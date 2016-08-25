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

namespace Attendance
{
    public partial class PeropleManage : System.Web.UI.Page
    {
        PeopleManagement pm = new PeopleManagement();
        UsersJionDepart pen = new UsersJionDepart();

        protected void Page_Load(object sender, EventArgs e)
        {
            CheckBoxNew();
            if (!IsPostBack)
            {
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

                ////添加 部门 下拉框
                //drpdename.DataSource = pm.Depart();
                //drpdename.DataValueField = "Deptno";
                //drpdename.DataTextField = "DeptName";
                //drpdename.DataBind();
                //drpdename.SelectedIndex = 0;
                //comb1.Value = drpdename.SelectedValue;
                ////修改 部门 下拉框
                //drpdenameedit.DataSource = pm.Depart();
                //drpdenameedit.DataValueField = "Deptno";
                //drpdenameedit.DataTextField = "DeptName";
                //drpdenameedit.DataBind();
                //drpdenameedit.SelectedIndex = 0;
                //comb3.Value = drpdenameedit.SelectedValue;
                ////修改 职位 下拉框
                //drponameedit.DataSource = pm.Post(pen);
                //drponameedit.DataValueField = "Postno";
                //drponameedit.DataTextField = "PostName";
                //drponameedit.DataBind();
                //drponameedit.SelectedIndex = 0;
                //comb4.Value = drponameedit.SelectedValue;

            }


        }

        public void CheckBoxNew()
        {
            DataTable dtES = pm.GetAllDepart();
            CheckBox checkBox;
            for (int i = 0; i < dtES.Rows.Count; i++)
            {
                checkBox = new CheckBox();
                checkBox.Text = dtES.Rows[i]["DeptName"].ToString();
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
            pm.AddPeople(use);
            Response.Redirect("PeropleManage.aspx");
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            //点击搜索后将搜索标志设置为change
            pagechange.Value = "change";
            Bind();
        }

        protected void gdvinfo_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {

        }

        protected void gdvinfo_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            //UserInfo us = new UserInfo();
            //int index = e.RowIndex;
            //int ID = Convert.ToInt32(gdvinfo.Rows[index].Cells[0].Text);
            //us.UserId = ID;
            //if (pm.delete(us))
            //{
            //}
            //RefrhPage();

        }

        protected void btnedit_Click(object sender, EventArgs e)
        {
            //bool f = true;
            //UserInfo us = new UserInfo();
            //us.UserId = Convert.ToInt32(editId.Value);
            //us.UserName = txtname.Text;
            //us.UserPostno = int.Parse(comb4.Value);
            //us.UserDeptno = int.Parse(comb2.Value);
            ////判断输入的日期是否正确
            ////if (IsDate(txtbrith.Text) == true)
            ////{
            ////    
            ////    //f = true;
            ////}
            ////else
            ////{
            ////    //Response.Write("<script>alert('请输入正确的日期')</script>");
            ////    //lblbrith.Visible = true;
            ////    //regbrith.Visible = true;
            ////    f = false;
            ////}
            //us.UserBrith = Convert.ToDateTime(txtbrith.Text);
            //if (radnan.Checked)
            //{
            //    us.UserSex = true;
            //}
            //else
            //{
            //    us.UserSex = false;
            //}
            ////if (IsDate(txtwork.Text) == true)
            ////{
            ////    
            ////    //f = true;
            ////}
            ////else
            ////{
            ////    //Response.Write("<script>alert('请输入正确的日期')</script>");
            ////    lblWork.Visible = true;
            ////    f = false;
            ////}
            //us.UserWorkAge = Convert.ToDateTime(txtwork.Text);
            //us.UserTel = txttel.Text;
            //us.Usertype = txttype.Text;
            //if (f == true)
            //{
            //    pm.Edit(us);
            //}
            //RefrhPage();
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


        private void Bind()
        {
            // 获取GridView排序数据列及排序方向
            string sortExpression = this.gdvinfo.Attributes["SortExpression"];
            string sortDirection = this.gdvinfo.Attributes["SortDirection"];
            DataTable dtBind = new DataTable();

            //判断是不是点击了搜索按钮  
            if (pagechange.Value.ToString().Equals("change"))
            {
                string dept = "";
                foreach (CheckBox c in PanelCheckList.Controls)
                {
                    if (c.Checked == true)
                        dept += "'" + c.Text + "',";
                }
                if (dept != "")
                    dept = dept.Remove(dept.Count() - 1);
                else
                    dept = "' '";

                dtBind = pm.SearchPeople(TxtSearchID.Text, TxtSearchName.Text, dept);
            }
            else
                // 调用业务数据获取方法
                dtBind = pm.GetAllPeople();

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

        protected void gdvinfo_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gdvinfo.PageIndex = e.NewPageIndex;
            Bind();

        }

        protected void CheckBoxHead_CheckedChanged(object sender, EventArgs e)
        {
            //遍历所有的checkbox
            foreach (GridViewRow row in gdvinfo.Rows)
            {
                CheckBox cb = (CheckBox)row.FindControl("CheckBox1");
                if ((sender as CheckBox).Checked)
                    cb.Checked = true;
                else
                    cb.Checked = false;
            }
        }


        [WebMethod]
        public static string GetStr(string str)
        {
            return PeopleManagement.UserIDPadding(str)?"true":"false";
        }

        [WebMethod]
        public static string UserInfos(string str)
        {
            return PeopleManagement.UserInfos(str);
        }



    }
}