using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using Entity;

namespace DAL
{
    public class DepartmentServices
    {
        public DataTable GetAllPeople()
        {
            string sql = "select * from Department right join UserInfo on UserInfo.DeptID=Department.DeptID where UserID !='admin'";
            DataTable dt = DBhelper.Select(sql);
            return dt;
        }
        public DataTable GetAllDepart()
        {
            DataTable dt = new DataTable();
            dt = DBhelper.Select("select *,(select UserName from UserInfo where UserID=ManagerID) as UserName from Department");
            return dt;
        }
        public DataTable SearchPeople(string id, string name, string dept)
        {
            DataTable dt = DBhelper.Select(string.Format(
                "select * from Department right join UserInfo on UserInfo.DeptID=Department.DeptID  where UserID !='admin' and UserID like '%{0}%' and UserName like '%{1}%' and DeptName in ({2})"
                , id, name, dept));
            return dt;
        }
        public DataTable SearchManage(string name, string manage)
        {
            DataTable dt = new DataTable();
            if (manage == "")
            {
                dt = DBhelper.Select(string.Format(
            "select DeptName,ManagerID,(select UserName from UserInfo where UserID=ManagerID) as UserName from Department where  DeptName like '%{0}%'"
            , name));
                return dt;
            }
            else
            {
                dt = DBhelper.Select(string.Format(
            "select * from (select DeptName,ManagerID,(select UserName from UserInfo where UserID=ManagerID) as UserName from Department)  as a where  DeptName like '%{0}%' and  UserName = '{1}'"
            , name, manage));
                return dt;
            }
        }

    }
}




