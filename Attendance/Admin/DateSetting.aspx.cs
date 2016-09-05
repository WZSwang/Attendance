using BLL;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Entity;

namespace Attendance
{
    public partial class DateSetting : System.Web.UI.Page
    {
        AttendanceManagement Atten = new AttendanceManagement();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                gdvinfo.DataBind();
            }
        }

        protected void gdvinfo_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gdvinfo.PageIndex = e.NewPageIndex;
            // Bind();
        }

        protected void BtnShow_Click(object sender, EventArgs e)
        {
            int year = int.Parse(DropDownListYear.SelectedValue);
            int month = int.Parse(DropDownListMonth.SelectedValue);

            DataTable dt = new DataTable();
            //添加 时间、星期列
            dt.Columns.Add("Date", Type.GetType("System.DateTime"));
            dt.Columns.Add("Week", Type.GetType("System.String"));

            //计算年月有多少天,添加到dt中
            for (int i = 0; i < DateTime.DaysInMonth(year, month); i++)
            {
                DateTime time = Convert.ToDateTime(year + "-" + month + "-" + (i + 1).ToString());
                //添加新数据
                DataRow newRow = dt.NewRow();
                newRow["Date"] = time.ToString();
                //英文的星期
                //newRow["Week"] = time.DayOfWeek;
                newRow["Week"] = time.ToString("dddd", new System.Globalization.CultureInfo("zh-cn"));
                dt.Rows.InsertAt(newRow, i);
            }
            gdvinfo.DataSource = dt;
            gdvinfo.DataBind();
        }

        protected void gdvinfo_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            // like 2014-02
            string YearMonth = DropDownListYear.SelectedValue + "-" +
                (int.Parse(DropDownListMonth.SelectedValue) < 10 ? "0" + DropDownListMonth.SelectedValue : DropDownListMonth.SelectedValue);
            //数据库中数据
            IList<AttendanceSetting> list = Atten.GetDateStatus(YearMonth);
            if (list != null)
                if (e.Row.RowType == DataControlRowType.DataRow)
                {
                    string dates = (e.Row.Cells[0].Text).Substring(8);
                    int date = int.Parse(dates);
                    foreach (AttendanceSetting set in list)
                    {
                        int setdate = int.Parse(set.Date.Day.ToString());
                        if (setdate > date)
                            break;
                        if (setdate == date)
                            (e.Row.Cells[2].FindControl("DropDownListState") as DropDownList).SelectedIndex = set.Status;
                    }
                }
        }

        protected void BtnSave_Click(object sender, EventArgs e)
        {
            foreach (GridViewRow dr in gdvinfo.Rows)
            {
                string date = gdvinfo.Rows[dr.RowIndex].Cells[0].Text;
                string status = (gdvinfo.Rows[dr.RowIndex].Cells[2].FindControl("DropDownListState") as DropDownList).SelectedValue;
                Atten.ChangeDateStatus(date, status);
            }
            LabTip.Visible = true;
        }
    }
}