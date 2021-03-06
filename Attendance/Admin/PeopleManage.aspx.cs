﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BLL;
using Entity;
using System.Data;
using System.Web.Services;

namespace Attendance
{
    public partial class PeropleManage : System.Web.UI.Page
    {
        DeparmentManagement pm = new DeparmentManagement();
        UserManagement um = new UserManagement();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ControlTemplate.SetPager(Convert.ToInt32(Math.Ceiling(um.SearchPeopleCount() / 10.0)), gdvinfo.PageSize);
                Bind();
                //添加 职位 下拉框
                drponame.DataSource = pm.GetAllDepart();
                drponame.DataValueField = "DeptID";
                drponame.DataTextField = "DeptName";
                drponame.DataBind();
                drponame.Items.Insert(0, new ListItem("--请选择--", ""));
                //修改 职位 下拉框
                drponameedit.DataSource = pm.GetAllDepart();
                drponameedit.DataValueField = "DeptID";
                drponameedit.DataTextField = "DeptName";
                drponameedit.DataBind();
                drponameedit.Items.Insert(0, new ListItem("--请选择--", ""));
            }
            CheckBoxNew();
        }

        public void CheckBoxNew()
        {
            DataTable dtES = pm.GetAllDepart();
            CheckBox checkBox;
            for (int i = 0; i < dtES.Rows.Count; i++)
            {
                checkBox = new CheckBox();
                checkBox.Text = "<span></span>" + dtES.Rows[i]["DeptName"].ToString();
                checkBox.ID = dtES.Rows[i]["DeptID"].ToString();
                checkBox.Style.Add("margin-left", "3px");
                this.PanelCheckList.Controls.Add(checkBox);
            }
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
            um.AddPeople(use);
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

            ControlTemplate.SetPager(Convert.ToInt32(Math.Ceiling(um.SearchPeopleCount(TxtSearchID.Text, TxtSearchName.Text, dept) / 10.0)), gdvinfo.PageSize);
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
            um.EditPeople(us);
            Bind();

        }


        //加上光棒效果
        protected void gdvinfo_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Attributes.Add("onmouseover", "this.style.backgroundColor='#cccccc'");
                e.Row.Attributes.Add("onmouseout", "this.style.backgroundColor='#ffffff'");

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


        public void Bind(object sender = null, EventArgs e = null)
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

            // 调用业务数据获取方法
            dtBind = um.SearchPeople(TxtSearchID.Text, TxtSearchName.Text, dept, ControlTemplate.pageSize, ControlTemplate.pageIndex);

            // 根据GridView排序数据列及排序方向设置显示的默认数据视图
            if ((!string.IsNullOrEmpty(sortExpression)) && (!string.IsNullOrEmpty(sortDirection)))
            {
                dtBind.DefaultView.Sort = string.Format("{0} {1}", sortExpression, sortDirection);
            }


            // GridView绑定并显示数据
            //  if(dtBind.Rows.Count>0)
            this.gdvinfo.DataSource = dtBind;
            this.gdvinfo.DataBind();
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
                    um.DelPeople(lb.Text);
                }
            }
            Response.Redirect("PeopleManage.aspx");
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