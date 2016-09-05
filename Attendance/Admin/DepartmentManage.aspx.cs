using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BLL;
using Entity;
using System.Data;
using System.Web.Services;

namespace Attendance.Admin
{
    public partial class DepartmentManage : System.Web.UI.Page
    {
        UserManagement um = new UserManagement();
        DeparmentManagement dm = new DeparmentManagement();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ViewState["PageCount"] = (Math.Ceiling(dm.GetAllDepart().Rows.Count / 10.0)).ToString();
                ViewState["CurrentPage"] = "1";
                Bind();
                drpManage.DataSource = um.SearchManage();
                drpManage.DataValueField = "UserName";
                drpManage.DataTextField = "UserName";
                drpManage.DataBind();
                drpManage.Items.Insert(0, new ListItem("请选择主管名称", ""));

                drpdename.DataSource = um.SearchManage();
                drpdename.DataValueField = "UserId";
                drpdename.DataTextField = "UserName";
                drpdename.DataBind();
                drpdename.Items.Insert(0, new ListItem("--空--", ""));

                drpdenameedit.DataSource = um.SearchManage();
                drpdenameedit.DataValueField = "UserId";
                drpdenameedit.DataTextField = "UserName";
                drpdenameedit.DataBind();
                drpdenameedit.Items.Insert(0, new ListItem("--空--", ""));

            }
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
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            ViewState["CurrentPage"] = "1";
            ViewState["PageCount"] = (Math.Ceiling(dm.SearchManage(TxtSearchID.Text, drpManage.SelectedValue, gdvinfo.PageSize).Rows.Count / 10.0)).ToString();
            Bind();
        }

        public void Bind()
        {
            DataTable dtBind = new DataTable();

            int pageindex = Convert.ToInt32(ViewState["CurrentPage"]);

            // 调用业务数据获取方法
            dtBind = dm.SearchManage(TxtSearchID.Text, drpManage.SelectedValue, gdvinfo.PageSize, pageindex);

            gdvinfo.DataSource = dtBind;
            gdvinfo.DataBind();
            gdvinfo.BottomPagerRow.Visible = true;
            SetPager();
        }

        protected void gdvinfo_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gdvinfo.PageIndex = e.NewPageIndex;
            Bind();
        }

        //在Row绑定时触发
        protected void gdvinfo_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.Cells.Count== 1)
                return;
            //删除按钮 默认隐藏
            Button txt = (Button)e.Row.Cells[3].FindControl("ImageButonDelete");
            Label lb = (Label)e.Row.Cells[1].FindControl("LabelDeptName");
            //找得到删除按钮 部门中没有员工
            if (txt != null && dm. DepartIsNull(lb.Text))
                txt.Visible = true;

        }


        protected void btnin_Click(object sender, EventArgs e)
        {
            Department dp = new Department();
            dp.DeptName = tnid.Text;
            dp.ManagerID = drpdename.SelectedValue.Trim();
            dp.DeptInfo = TxtInfo.Text;
            dm.AddDepart(dp);
            Response.Redirect("DepartmentManage.aspx");

        }
        protected void btnedit_Click(object sender, EventArgs e)
        {
            Department dp = new Department();
            dp.DeptName = txtId.Text;
            dp.ManagerID = drpdenameedit.SelectedValue.Trim();
            dp.DeptInfo = TxtEditInfo.Text;
            dm.EditDepart(dp, DepartName.Value);
            Bind();
        }
        protected void btndelete_Click(object sender, EventArgs e)
        {
            string name = DepartName.Value;
            dm.DelteDepart(name);
            ViewState["CurrentPage"] = "1";
            Bind();
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



        #region AJAX静态方法

        [WebMethod]
        public static string GetStr(string str)
        {
            return DeparmentManagement.DepartPadding(str) ? "true" : "false";
        }

        [WebMethod]
        public static string DepartInfos(string str)
        {
            return DeparmentManagement.DepartInfos(str);
        }

        #endregion

    }
}