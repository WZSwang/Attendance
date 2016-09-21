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

        protected void Calinfo_DayRender(object sender, DayRenderEventArgs e)
        {
            if (e.Day.IsOtherMonth)
                e.Cell.Controls.Clear();
            else
            {
                UserInfo us = Session["user"] as UserInfo;
                int year = int.Parse(DropDownListYear.SelectedValue);
                int month = int.Parse(DropDownListMonth.SelectedValue);
                List<AttendanceView> list = attenden.GetAttendanceInfo(year, month, us.UserID);

                var q = from day in list where day.Date == e.Day.Date select day;



                //e.Cell.Attributes.Add("date", e.Day.Date.ToString("yyyy-MM-dd"));
                //e.Cell.Attributes.Add("id", "td" + e.Day.Date.ToString("MMdd"));
                //e.Cell.Attributes.Add("scheduleId", "NO");

                e.Cell.Text = "<table style='width:100%;height:100%' ><tr><td style='width:20%'>" + e.Day.Date.Day + "</td><td>" + q.First().Status + "</td></tr> </table>";


                ////打卡人数
                //foreach (DateTime AssignTime in SetH.getAssignInfo())
                //{
                //    if (e.Day.Date.ToString("yyyy-MM-dd").Equals(AssignTime.ToString("yyyy-MM-dd")))
                //    {

                //        e.Cell.ForeColor = System.Drawing.Color.FromName(userset.ColorSeted);
                //        e.Cell.Text = e.Day.Date.Day + "</br>" + SetH.getAllAssignByDate(e.Day.Date) + "人打卡";

                //    }
                //}

                ////休息
                //if (e.Day.IsWeekend)
                //{
                //    e.Cell.ForeColor = System.Drawing.Color.FromName(userset.HolidaySeted);
                //    e.Cell.Text = e.Day.Date.Day + "</br>休息日";
                //}
            }
        }
    }

}