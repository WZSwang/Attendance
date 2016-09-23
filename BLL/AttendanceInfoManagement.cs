using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using DAL;
using System.Data;
using Entity;

namespace BLL
{
    public class AttendanceInfoManagement
    {
        AttendanceInfoServices attendan = new AttendanceInfoServices();

        public List<AttendanceView> GetAttendanceInfo(int year, int month, string id)
        {
            return attendan.GetAttendanceInfo(year, month, id);
        }


        public List<AttendanceView> GetAttendanceView(int year, int month, string id)
        {
            return attendan.GetAttendanceView(year, month, id);
        }

    }
}
