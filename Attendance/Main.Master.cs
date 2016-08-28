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
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["User"] != null)
                {
                    UserInfo userInfo = Session["User"] as UserInfo;
                    if (userInfo != null)
                    {
                        this.ltlOnlineUser.Text = userInfo.UserName + ",欢迎您";
                        if (userInfo.UserType == 2)
                            AdminList.Style.Add("display", "block");
                        else if (userInfo.UserType == 1)
                            MasterList.Style.Add("display", "block");
                        else if (userInfo.UserType == 0)
                            PersonList.Style.Add("display", "block");
                    }
                }
            }
        }

        protected void lnkSignOut_Click(object sender, EventArgs e)
        {
            FormsAuthentication.SignOut();
            Response.Redirect("../Login.aspx");
        }
    }
}