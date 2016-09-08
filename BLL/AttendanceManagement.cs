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

        public String GetDateStatus(string date)
        {
            return Atten.GetDateStatus(date);
        }

        public void ChangeDateStatus(List<string> date)
        {
            Atten.ChangeDateStatus(date);
        }
        public void DeleteDate(string date)
        {
            Atten.DeleteDate(date);
        }
        public Dictionary<DateTime, int> DateInfo(int year, int month)
        {
            return Atten.DateInfo(year,month);
        }
    }
}
