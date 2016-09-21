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
                ControlTemplate.SetPager(Convert.ToInt32((Math.Ceiling(dm.GetAllDepart().Rows.Count / 10.0))), gdvinfo.PageSize);

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
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            ControlTemplate.SetPager(Convert.ToInt32(Math.Ceiling(dm.SearchManage(TxtSearchID.Text, drpManage.SelectedValue, gdvinfo.PageSize).Rows.Count / 10.0)), gdvinfo.PageSize);
            Bind();
        }

        public void Bind(object sender = null, EventArgs e = null)
        {
            DataTable dtBind = new DataTable();
            // 调用业务数据获取方法
            dtBind = dm.SearchManage(TxtSearchID.Text, drpManage.SelectedValue, ControlTemplate.pageSize, ControlTemplate.pageIndex);
            gdvinfo.DataSource = dtBind;
            gdvinfo.DataBind();
        }


        //在Row绑定时触发
        protected void gdvinfo_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.Cells.Count == 1)
                return;
            //删除按钮 默认隐藏
            Button txt = (Button)e.Row.Cells[3].FindControl("ImageButonDelete");
            Label lb = (Label)e.Row.Cells[1].FindControl("LabelDeptName");
            //找得到删除按钮 部门中没有员工
            if (txt != null && dm.DepartIsNull(lb.Text))
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
            Response.Redirect("DepartmentManage.aspx");
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