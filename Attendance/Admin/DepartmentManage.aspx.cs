using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BLL;
using Entity;
using System.Data;

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
                drpManage.Items.Insert(0, new ListItem("--请选择--", ""));
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
            Bind( dm.SearchManage(TxtSearchID.Text, drpManage.SelectedValue));
    }


        public void Bind(DataTable dt)
        {
            gdvinfo.DataSource = dt;
            gdvinfo.DataBind();
        }
    }
}