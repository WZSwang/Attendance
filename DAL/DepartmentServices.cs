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
            if (id == "" && name == "" && dept == "' '")
                return this.GetAllPeople();
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
        public void AddDepart(Department dp)
        {
            string sql =string.Format("insert into Department values ('{0}','{1}','{2}')", dp.DeptName,dp.ManagerID,dp.DeptInfo);
            DBhelper.Change(sql);
        }

        public void EditDepart(Department dp,string OldName)
        {
            string sql = string.Format("update Department set DeptName='{0}',ManagerID='{1}',DeptInfo='{2}'   where DeptName='{3}'",
                dp.DeptName, dp.ManagerID, dp.DeptInfo, OldName);
            DBhelper.Change(sql);
        }
        public void DelteDepart(string OldName)
        {
            string sql = string.Format("delete from Department where DeptName='{0}'",
                 OldName);
            DBhelper.Change(sql);
        }
        public  bool DepartIsNull(string id)
        {
            string sql = "select Count(*) from UserInfo where DeptID=(select DeptID from Department where DeptName='" + id.Trim() + "')";
            DataTable dt = DBhelper.Select(sql);
            return dt.Rows[0][0].ToString()=="0";
        }



        public static bool DepartPadding(string id)
        {
            string sql = "select * from Department  where DeptName='" + id + "'";
            DataTable dt = DBhelper.Select(sql);
            return dt.Rows.Count > 0;
        }
        public static string DepartInfos(string id)
        {
            string sql = "select * from Department  where DeptName='" + id + "'";
            DataTable dt = DBhelper.Select(sql);
            string Info = dt.Rows[0]["DeptInfo"].ToString();
            return Info;
        }

    }
}




