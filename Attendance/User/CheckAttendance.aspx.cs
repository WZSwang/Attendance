using BLL;
using Entity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Attendance.User
{
    public partial class CheckAttendance : System.Web.UI.Page
    {
        AttendanceInfoManagement attenden = new AttendanceInfoManagement();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                for (int i = DateTime.Now.Year - 3; i <= DateTime.Now.Year + 3; i++)
                    DropDownListYear.Items.Add(i.ToString());
                DropDownListYear.SelectedValue = DateTime.Now.Year.ToString();
                DropDownListMonth.SelectedValue = DateTime.Now.Month.ToString();
                gdvinfo.DataBind();
            }
        }

        protected void BtnShow_Click(object sender, EventArgs e)
        {
            UserInfo us = Session["user"] as UserInfo;
            int year = int.Parse(DropDownListYear.SelectedValue);
            int month = int.Parse(DropDownListMonth.SelectedValue);
            gdvinfo.DataSource = attenden.GetAttendanceInfo(year, month, us.UserID);
            gdvinfo.DataBind();
        }

        protected void gdvinfo_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                DateTime time = Convert.ToDateTime(e.Row.Cells[0].Text);
                e.Row.Cells[1].Text = time.ToString("dddd", new System.Globalization.CultureInfo("zh-cn"));
                if (e.Row.Cells[2].Text == "0001/1/1 0:00:00")
                    e.Row.Cells[2].Text = "";
                if (e.Row.Cells[3].Text == "0001/1/1 0:00:00")
                    e.Row.Cells[3].Text = "";
            }
        }
        
    }
    
}