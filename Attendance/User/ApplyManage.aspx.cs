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

namespace Attendance.User
{
    public partial class ApplyManage : System.Web.UI.Page
    {
        DeparmentManagement pm = new DeparmentManagement();
        HolidayManagement hm = new HolidayManagement();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ViewState["PageCount"] = (Math.Ceiling(hm.SearchApprove("", "", "", "", 999, 1).Rows.Count / 10.0)).ToString();
                ViewState["CurrentPage"] = "1";

                Bind();
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

        protected void btnin_Click(object sender, EventArgs e)
        {
            UserInfo use = new UserInfo();
            use.UserID = tnid.Text;
            use.UserName = tnname.Text;
            use.UserType = Convert.ToByte(drpdename.SelectedValue);
            byte DeptID;
            if (byte.TryParse(drponame.SelectedValue, out DeptID))
                use.DeptID = DeptID;
            else
                use.DeptID = null;
            use.Cellphone = txttel0.Text;
            //um.AddPeople(use);
            Response.Redirect("PeopleManage.aspx");
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string dept = "";
            foreach (CheckBox c in PanelCheckList.Controls)
            {
                if (c.Checked == true)
                    dept += "'" + c.Text.Substring(13) + "',";
            }
            if (dept != "")
                dept = dept.Remove(dept.Count() - 1);
            else
                dept = "";
            ViewState["CurrentPage"] = "1";
            //ViewState["PageCount"] = (Math.Ceiling(um.SearchPeopleCount(TxtSearchID.Text, TxtSearchName.Text, dept) / 10.0)).ToString();
            Bind();
        }

        protected void btnedit_Click(object sender, EventArgs e)
        {
            //bool f = true;
            UserInfo us = new UserInfo();
            us.UserID = editId.Value;
            us.UserName = txtname.Text;
            us.UserType = Convert.ToByte(drpdenameedit.SelectedValue);
            byte DeptID;
            if (byte.TryParse(drponameedit.SelectedValue, out DeptID))
                us.DeptID = DeptID;
            else
                us.DeptID = null;
            us.Cellphone = txttel.Text;
            //um.EditPeople(us);
            Bind();

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


        private void Bind()
        {
            // 获取GridView排序数据列及排序方向
            string sortExpression = this.gdvinfo.Attributes["SortExpression"];
            string sortDirection = this.gdvinfo.Attributes["SortDirection"];
            DataTable dtBind = new DataTable();

            string dept = "";
            foreach (CheckBox c in PanelCheckList.Controls)
            {
                if (c.Checked == true)
                    dept += "'" + c.Text.Substring(13) + "',";
            }
            if (dept != "")
                dept = dept.Remove(dept.Count() - 1);
            else
                dept = "";

            int pageindex = Convert.ToInt32(ViewState["CurrentPage"]);

            // 调用业务数据获取方法
            dtBind = hm.SearchApprove("", "", "", "", 999, 1);

            // 根据GridView排序数据列及排序方向设置显示的默认数据视图
            if ((!string.IsNullOrEmpty(sortExpression)) && (!string.IsNullOrEmpty(sortDirection)))
            {
                dtBind.DefaultView.Sort = string.Format("{0} {1}", sortExpression, sortDirection);
            }


            // GridView绑定并显示数据
            //  if(dtBind.Rows.Count>0)
            this.gdvinfo.DataSource = dtBind;
            this.gdvinfo.DataBind();
            gdvinfo.BottomPagerRow.Visible = true;
            SetPager();
        }

        protected void CheckBoxHead_CheckedChanged(object sender, EventArgs e)
        {
            //遍历所有的checkbox
            foreach (GridViewRow row in gdvinfo.Rows)
            {
                CheckBox cb = (CheckBox)row.FindControl("CheckBoxList");
                if ((sender as CheckBox).Checked)
                    cb.Checked = true;
                else
                    cb.Checked = false;
            }
        }

        protected void btndelete_Click(object sender, EventArgs e)
        {
            //遍历所有的checkbox
            foreach (GridViewRow row in gdvinfo.Rows)
            {
                CheckBox cb = (CheckBox)row.FindControl("CheckBoxList");
                if (cb.Checked)
                {
                    Label lb = (Label)row.FindControl("LabelID");
                    //um.DelPeople(lb.Text);
                }
            }
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
            return UserManagement.UserIDPadding(str) ? "true" : "false";
        }

        [WebMethod]
        public static string UserInfos(string str)
        {
            return UserManagement.UserInfos(str);
        }

        #endregion
    }
}