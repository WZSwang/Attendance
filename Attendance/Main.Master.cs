using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using Entity;

namespace Attendance
{
    public partial class Main : System.Web.UI.MasterPage
    {
        public byte? UserType;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["User"] != null)
            {
                UserInfo userInfo = Session["User"] as UserInfo;
                UserType = userInfo.UserType;
                this.ltlOnlineUser.Text = userInfo.UserName + ",欢迎您";
            }
            if (!IsPostBack)
            {
            }
        }

        protected void lnkSignOut_Click(object sender, EventArgs e)
        {
            FormsAuthentication.SignOut();
            Session.Clear();
            Response.Redirect("~/Login.aspx");
        }
    }
}