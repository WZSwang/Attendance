using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using Entity;

namespace DAL
{
    public class AttendanceServices
    {
        public String GetDateStatus(string date)
        {
            string sql = "select * from AttendanceSetting where date = '" + date + "'";
            DataTable dt = DBhelper.Select(sql);
            return dt.Rows.Count > 0 ? dt.Rows[0][2].ToString() : "0";
        }
        public void DeleteDate(string date)
        {
            DateTime time = Convert.ToDateTime(date);
            string sql = "delete from AttendanceSetting where year(Date)=" + time.Year + " and MONTH(Date)=" + time.Month;
            DBhelper.Change(sql);
        }

        public void ChangeDateStatus(List<string> date)
        {
            DBhelper.TransactioChange(date);
        }


        public Dictionary<DateTime, int> DateInfo(int year, int month)
        {
            Dictionary<DateTime, int> dic = new Dictionary<DateTime, int>();
            string sql = "select * from AttendanceSetting where year(Date)=" + year + " and MONTH(Date)=" + month;
            DataTable dt = DBhelper.Select(sql);
            foreach (DataRow dr in dt.Rows)
            {
                dic.Add(Convert.ToDateTime(dr["Date"]), Convert.ToInt32(dr["Status"]));
            }
            return dic;
        }
        


    }
}
