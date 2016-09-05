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
        public DataTable GetAllDepart()
        {
            DataTable dt = new DataTable();
            dt = DBhelper.Select("select *,(select UserName from UserInfo where UserID=ManagerID) as UserName from Department");
            return dt;
        }
        public DataTable SearchManage(string name, string manage,int PageSize, int pageindex)
        {
            DataTable dt = new DataTable();
            string sql = "select  ROW_NUMBER() over (order by Department.DeptID) RowNumb,DeptName,ManagerID, UserName from Department left join UserInfo on Department.ManagerID=UserInfo.UserID where  DeptName like '%" + name + "%' ";
            if (manage != "")
                sql += "and UserName like  '%" + manage + "%'";

                int StarNum = (pageindex - 1) * PageSize + 1;
            int EndNum = PageSize * pageindex;

            string sqlComb = "select * from (" + sql + ") A where RowNumb between " + StarNum + " and " + EndNum;
            if (pageindex != 0)
                dt = DBhelper.Select(sqlComb);
            else
                dt = DBhelper.Select(sql);
            return dt;
        }
        public void AddDepart(Department dp)
        {
            string sql = string.Format("insert into Department values ('{0}','{1}','{2}')", dp.DeptName, dp.ManagerID, dp.DeptInfo);
            DBhelper.Change(sql);
        }

        public void EditDepart(Department dp, string OldName)
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
        public bool DepartIsNull(string id)
        {
            string sql = "select Count(*) from UserInfo where DeptID=(select DeptID from Department where DeptName='" + id.Trim() + "')";
            DataTable dt = DBhelper.Select(sql);
            return dt.Rows[0][0].ToString() == "0";
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




