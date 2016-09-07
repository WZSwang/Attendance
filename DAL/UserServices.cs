using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Entity;
using System.Data;

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
        public void AddPeople(UserInfo us)
        {
            string sql;
            if (us.DeptID != null)
                sql = string.Format(
                   "insert into  UserInfo values ('{0}','{1}','{2}',null,'{3}','{4}')"
                   , us.UserID, us.UserName, us.DeptID, us.Cellphone, us.UserType);
            else
                sql = string.Format(
                   "insert into  UserInfo values ('{0}','{1}',null,null,'{2}','{3}')"
                   , us.UserID, us.UserName, us.Cellphone, us.UserType);

            DBhelper.Change(sql);
        }

        public IList<UserInfo> SearchManage()
        {
            IList<UserInfo> usersJionLog = new List<UserInfo>();
            DataTable dt = DBhelper.Select("select * from  UserInfo  where UserType ='1'");
            return usersJionLog = ConvertHelper.convertToList<UserInfo>(dt);
        }
        public void EditPeople(UserInfo us)
        {
            string sql;
            if (us.DeptID != null)
                sql = string.Format(
                   "update UserInfo set UserName='{1}',DeptID='{2}',Cellphone='{3}',UserType='{4}'   where UserID='{0}'"
                   , us.UserID, us.UserName, us.DeptID, us.Cellphone, us.UserType);
            else
                sql = string.Format(
                   "update UserInfo set UserName='{1}',DeptID=null,Cellphone='{2}',UserType='{3}'   where UserID='{0}'"
                   , us.UserID, us.UserName, us.Cellphone, us.UserType);
            DBhelper.Change(sql);
        }
        public void DelPeople(string us)
        {
            string sql = "delete from userInfo where UserID='" + us + "'";
            DBhelper.Change(sql);
        }






        public static bool UserIDPadding(string id)
        {
            string sql = "select * from UserInfo  where UserID='" + id + "'";
            DataTable dt = DBhelper.Select(sql);
            return dt.Rows.Count > 0;
        }
        public static string UserInfos(string id)
        {
            string sql = "select * from UserInfo  where UserID='" + id + "'";
            DataTable dt = DBhelper.Select(sql);
            string user = dt.Rows[0]["UserType"].ToString() + "," + dt.Rows[0]["Cellphone"].ToString();
            return user;
        }


        public DataTable SearchPeople(string id, string name, string dept, int pagesize, int pageIndex)
        {
            string sql = string.Format("select ROW_NUMBER() over (order by Department.DeptID) RowNumb,Department.*,UserID,UserName from Department right join UserInfo on UserInfo.DeptID=Department.DeptID  where UserID !='admin' and UserID like '%{0}%' and UserName like '%{1}%' "
                , id, name);
            if (dept != "")
                sql += "and DeptName in (" + dept + ")";

            int StarNum = (pageIndex - 1) * pagesize + 1;
            int EndNum = pagesize * pageIndex;
            string sqlComb = "select * from (" + sql + ") A where RowNumb between " + StarNum + " and " + EndNum;
            DataTable dt = DBhelper.Select(sqlComb);
            return dt;
        }
        public int SearchPeopleCount(string id, string name, string dept)
        {
            string sql = string.Format("select * from Department right join UserInfo on UserInfo.DeptID=Department.DeptID  where UserID !='admin' and UserID like '%{0}%' and UserName like '%{1}%' "
                , id, name);
            if (dept != "")
                sql += "and DeptName in (" + dept + ")";
            DataTable dt = DBhelper.Select(sql);
            return dt.Rows.Count;
        }
        
        public DataTable SearchPeopleInManage(string manage, int pagesize, int pageIndex)
        {
            string sql = "select ROW_NUMBER() over (order by UserInfo.UserID) RowNumb,Department.*,UserID,UserName from Department right join UserInfo on UserInfo.DeptID = Department.DeptID where ManagerID = '"+ manage + "'";
            int StarNum = (pageIndex - 1) * pagesize + 1;
            int EndNum = pagesize * pageIndex;
            string sqlComb = "select * from (" + sql + ") A where RowNumb between " + StarNum + " and " + EndNum;
            DataTable dt = DBhelper.Select(sqlComb);
            return dt;
        }

    }
}
