using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Entity;
using DAL;
using System.Data;

namespace BLL
{
    public class AttendanceManagement
    {
        AttendanceServices Atten = new AttendanceServices();

        public IList<AttendanceSetting> GetDateStatus(string date)
        {
            return Atten.GetDateStatus(date);
        }

        public void ChangeDateStatus(string date, string satus)
        {
            Atten.ChangeDateStatus(date, satus);
        }
    }
}
