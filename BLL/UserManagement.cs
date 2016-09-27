using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Entity;
using DAL;
using System.Data;

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
        public void EditUser(UserInfo us)
        {
            Userserve.EditUser(us);
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
        public DataTable SearchPeople(string id, string name, string dept, int pagesize, int pageIndex)
        {
            return Userserve.SearchPeople(id, name, dept, pagesize, pageIndex);
        }
        public int SearchPeopleCount(string id = "", string name = "", string dept = "")
        {
            return Userserve.SearchPeopleCount(id, name, dept);
        }
        public DataTable SearchPeopleInManage(string manage, int pagesize, int pageIndex)
        {
            return Userserve.SearchPeopleInManage(manage, pagesize, pageIndex);
        }
        public void UpdateAttanceInfo(List<AttendanceInfo> list)
        {
            Userserve.UpdateAttanceInfo(list);
        }
    }
}
