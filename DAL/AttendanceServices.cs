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
        public IList<AttendanceSetting> GetDateStatus(string date)
        {
            string sql = "select * from AttendanceSetting where convert(varchar(50),Date,120) like '" + date + "%'";
            DataTable dt = DBhelper.Select(sql);
            return ConvertHelper.convertToList<AttendanceSetting>(dt);
        }

        public void ChangeDateStatus(string date,string satus)
        {
            string sql = "delete from AttendanceSetting where Date='"+ date + "'  INSERT INTO AttendanceSetting VALUES ('"+ date + "', '"+ satus + "') ";
            DBhelper.Change(sql);
        }


    }
}
