using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Entity;
using DAL;

namespace BLL
{
   public   class UserManagement
    {
        UserServices Userserve = new UserServices();
        public bool Login(ref UserInfo us)
        {
            return Userserve.Login(ref us); ;
        }

        public IList<UserInfo> SearchManage()
        {
            return Userserve .SearchManage();
        }

        public void AddPeople(UserInfo us)
        {
            Userserve.AddPeople(us);
        }
        public void EditPeople(UserInfo us)
        {
            Userserve.EditPeople(us);
        }
        public void DelPeople(string us)
        {
            Userserve.DelPeople(us);
        }




        public static bool UserIDPadding(string id)
        {
            return UserServices.UserIDPadding(id);
        }
        public static string UserInfos(string id)
        {
            return UserServices.UserInfos(id);
        }
    }
}
