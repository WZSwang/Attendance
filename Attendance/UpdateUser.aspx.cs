using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BLL;
using Entity;

namespace Attendance
{
    public partial class UpdateUser : System.Web.UI.Page
    {
        UserManagement um = new UserManagement();
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void BtnSubmit_Click(object sender, EventArgs e)
        {
            UserInfo us = Session["User"] as UserInfo;
            us.Cellphone = TxtPhone.Text;
            us.Password = TxtPass.Text;
            um.EditUser(us);
            lblTips.Visible = true;
        }
    }
}