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
                Bind(dm.GetAllDepart());
                drpManage.DataSource = um.SearchManage();
                drpManage.DataValueField = "UserName";
                drpManage.DataTextField = "UserName";
                drpManage.DataBind();
                drpManage.Items.Insert(0, new ListItem("--空--", ""));

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

            GridViewRow pagerRow = gdvinfo.BottomPagerRow;            // 获得 GridView 控件中的底部页导航行。
            if (pagerRow != null)
            {
                TextBox txt = (TextBox)pagerRow.Cells[0].FindControl("tbxPage");
                LinkButton link = (LinkButton)pagerRow.Cells[0].FindControl("btnGoto");
                link.CommandArgument = txt.Text.Trim();
            }
        }
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            Bind(dm.SearchManage(TxtSearchID.Text, drpManage.SelectedValue));
        }


        public void Bind(DataTable dt)
        {
            gdvinfo.DataSource = dt;
            gdvinfo.DataBind();
        }
        
        //在Row绑定时触发
        protected void gdvinfo_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            //删除按钮 默认隐藏
            ImageButton txt = (ImageButton)e.Row.Cells[3].FindControl("ImageButonDelete");

            //找得到删除按钮 部门中没有员工
            if (txt != null && dm. DepartIsNull(e.Row.Cells[1].Text))
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
            Bind(dm.GetAllDepart());
        }
        protected void btndelete_Click(object sender, EventArgs e)
        {
            string name = DepartName.Value;
            dm.DelteDepart(name);
            Bind(dm.GetAllDepart());
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