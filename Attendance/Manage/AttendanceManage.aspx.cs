using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BLL;
using Entity;
using System.Data.OleDb;

namespace Attendance.Manage
{
    public partial class AttendanceManage : System.Web.UI.Page
    {
        UserManagement UserMa = new UserManagement();
        AttendanceInfoManagement attenden = new AttendanceInfoManagement();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ViewState["CurrentPage"] = "1";
                Bind();

                for (int i = DateTime.Now.Year - 3; i <= DateTime.Now.Year + 3; i++)
                    DropDownListYear.Items.Add(i.ToString());
                DropDownListYear.SelectedValue = DateTime.Now.Year.ToString();
                DropDownListMonth.SelectedValue = DateTime.Now.Month.ToString();
                gdvView.DataBind();
            }
        }


        protected void gdvinfo_Sorting(object sender, GridViewSortEventArgs e)
        {
            string sortExpression = e.SortExpression.ToString();

            // 假定为排序方向为“顺序”
            string sortDirection = "ASC";

            // “ASC”与事件参数获取到的排序方向进行比较，进行GridView排序方向参数的修改
            if (sortExpression == this.gdvinfo.Attributes["SortExpression"])
            {
                //获得下一次的排序状态
                sortDirection = (this.gdvinfo.Attributes["SortDirection"].ToString() == sortDirection ? "DESC" : "ASC");
            }

            // 重新设定GridView排序数据列及排序方向
            this.gdvinfo.Attributes["SortExpression"] = sortExpression;
            this.gdvinfo.Attributes["SortDirection"] = sortDirection;
            this.Bind();
        }


        public void SetPager()
        {
            GridViewRow pagerRow = gdvinfo.BottomPagerRow;
            LinkButton btnPrev = (LinkButton)pagerRow.Cells[0].FindControl("btnPrev");
            btnPrev.Enabled = ViewState["CurrentPage"].ToString() != "1";
            LinkButton btnNext = (LinkButton)pagerRow.Cells[0].FindControl("btnNext");
            btnNext.Enabled = ViewState["CurrentPage"].ToString() != ViewState["PageCount"].ToString();


            //绑定数据到下拉表
            DropDownList ddl = pagerRow.FindControl("ddlIndex") as DropDownList;
            for (int i = 1; i <= Convert.ToInt32(ViewState["PageCount"]); i++)
            {
                ListItem li = new ListItem("第" + i + "页", i.ToString());
                ddl.Items.Add(li);
            }
            ddl.SelectedValue = ViewState["CurrentPage"].ToString();

        }
        private void Bind()
        {
            // 获取GridView排序数据列及排序方向
            string sortExpression = this.gdvinfo.Attributes["SortExpression"];
            string sortDirection = this.gdvinfo.Attributes["SortDirection"];
            DataTable dtBind = new DataTable();

            UserInfo User = Session["User"] as UserInfo;
            //// 调用业务数据获取方法
            dtBind = UserMa.SearchPeopleInManage(User.UserID.ToString(), gdvinfo.PageSize, Convert.ToInt32(ViewState["CurrentPage"]));
            ViewState["PageCount"] = (Math.Ceiling(dtBind.Rows.Count / 10.0)).ToString();

            // 根据GridView排序数据列及排序方向设置显示的默认数据视图
            if ((!string.IsNullOrEmpty(sortExpression)) && (!string.IsNullOrEmpty(sortDirection)))
            {
                dtBind.DefaultView.Sort = string.Format("{0} {1}", sortExpression, sortDirection);
            }


            // GridView绑定并显示数据
            //  if(dtBind.Rows.Count>0)
            this.gdvinfo.DataSource = dtBind;
            this.gdvinfo.DataBind();
            if (gdvinfo.BottomPagerRow != null)
                gdvinfo.BottomPagerRow.Visible = true;
            SetPager();
        }


        protected void btnFirst_Click(object sender, EventArgs e)
        {
            ViewState["CurrentPage"] = "1";
            Bind();
        }

        protected void btnPrev_Click(object sender, EventArgs e)
        {
            ViewState["CurrentPage"] = Convert.ToInt32(ViewState["CurrentPage"]) - 1;
            Bind();
        }

        protected void btnNext_Click(object sender, EventArgs e)
        {
            ViewState["CurrentPage"] = Convert.ToInt32(ViewState["CurrentPage"]) + 1;
            Bind();
        }

        protected void btnLast_Click(object sender, EventArgs e)
        {
            ViewState["CurrentPage"] = ViewState["PageCount"];
            Bind();
        }

        protected void ddlIndex_SelectedIndexChanged(object sender, EventArgs e)
        {
            DropDownList ddls = sender as DropDownList;
            ViewState["CurrentPage"] = int.Parse(ddls.SelectedValue);
            Bind();

        }

        protected void BtnShow_Click(object sender, EventArgs e)
        {

            int year = int.Parse(DropDownListYear.SelectedValue);
            int month = int.Parse(DropDownListMonth.SelectedValue);
            gdvView.DataSource = attenden.GetAttendanceInfo(year, month, hidUser.Value);
            gdvView.DataBind();
            divaddout.Style.Add("display", "block");
            addoutc.Style.Add("display", "block");
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            if (FileUploadExcel.HasFile)//判断FileUploadExcel是否为空
            {
                LabTips.Text = "";
                string serverRoot = System.Web.HttpContext.Current.Request.PhysicalApplicationPath;
                string strPath = serverRoot + "Update\\" + DateTime.Now.ToString("yyyyMMddhhmmss") + ".xls";
                FileUploadExcel.PostedFile.SaveAs(strPath);
                string url = strPath;
                //取得全部的上传文件路径
                try
                {
                    DataTable dataset = CreateDataSource(url);
                    if (dataset.Rows.Count > 2)
                    {
                        List<AttendanceInfo> list = new List<AttendanceInfo>();
                        foreach (DataRow dr in dataset.Rows)
                        {
                            AttendanceInfo ai = new AttendanceInfo();
                            ai.UserID = dr[0].ToString();
                            ai.FaceTime = Convert.ToDateTime(dr[2]);
                            list.Add(ai);
                        }
                        UserMa.UpdateAttanceInfo(list);
                        LabTips.Text = "文件保存成功！";
                    }
                    else
                    {

                        LabTips.Text = "此文件为空！";
                    }
                }
                catch
                {
                    LabTips.Text = "不支持此文件！";
                }
            }
            else
            {
                LabTips.Text = "请选择文件！";
            }
        }

        private DataTable CreateDataSource(string path)
        {
            string strConn, tableName = null;
            using (OleDbConnection conner = new OleDbConnection("Provider=Microsoft.ACE." +
"OLEDB.12.0;Extended Properties=\"Excel 8.0\";Data Source=" + path))
            {
                conner.Open();
                DataTable dt = conner.GetOleDbSchemaTable(OleDbSchemaGuid.Tables, null);
                tableName = dt.Rows[0][2].ToString().Trim();
            }
            strConn = "Provider=Microsoft.ACE.Oledb.12.0;Data Source=" + path + ";Extended Properties=\"Excel 8.0;HDR=Yes;IMEX=1;\"";
            DataSet myDataSet = new DataSet();
            OleDbConnection conn = new OleDbConnection(strConn);
            OleDbDataAdapter myCommand = new OleDbDataAdapter("SELECT * FROM   [" + tableName + "]  ", strConn);
            myCommand.Fill(myDataSet);
            return myDataSet.Tables[0];
        }

        protected void gdvView_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                DateTime time = Convert.ToDateTime(e.Row.Cells[0].Text);
                e.Row.Cells[1].Text = time.ToString("dddd", new System.Globalization.CultureInfo("zh-cn"));
                if (e.Row.Cells[2].Text == "0001/1/1 0:00:00")
                    e.Row.Cells[2].Text = "";
                if (e.Row.Cells[3].Text == "0001/1/1 0:00:00")
                    e.Row.Cells[3].Text = "";
            }
        }
    }
}