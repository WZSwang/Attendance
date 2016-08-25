using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Entity;

namespace DAL
{
    public class UserServices
    {
        public bool Login(ref UserInfo us)
        {
            string sql = "select * from UserInfo where UserID='" + us.UserID + "' and Password='" + us.Password + "'";
            if (DBhelper.Select(sql).Rows.Count == 0)
                return false;
            else
                us.UserType = Convert.ToByte( DBhelper.Select(sql).Rows[0]["UserType"]);
                us.UserName = DBhelper.Select(sql).Rows[0]["UserName"].ToString();
            return true;
        }


        //public void InsertPost(List<UserAttrepoter> list)
        //{
        //    db.UserAttrepoter.InsertAllOnSubmit(list);
        //    db.SubmitChanges();
        //}

        //public void ChangeSetting(AttendanceEntity.Setting set)
        //{
        //    var qe = (from s in db.Setting where s.SUserId == set.SUserId select s).First();
        //    qe.ColorToday = set.ColorToday;
        //    qe.ColorSeted = set.ColorSeted;
        //    qe.HolidaySeted = set.HolidaySeted;
        //    qe.NoneSeted = set.NoneSeted;
        //    db.SubmitChanges();
        //  }

    }
}
