using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Entity;
using System.Data;

namespace DAL
{
    public class HolidayServices
    {

        public List<ApproveJoinUserInfo> SearchApproveByUser(string User, string title, string start, string end, string Status, int pagesize, int pageIndex, string sortExpression, string sortDirection)
        {
            string sql = "select ROW_NUMBER() over (order by Approve.ApproveID) RowNumb,*,statusname= case Status when '1' then '归档' else '待审核' end  from Approve left join UserInfo on UserInfo.UserID=Approve.ApplyUser where ApplyUser='" + User + "' and Title like '%" + title + "%'";
            if (start != "")
                sql += " and ApplyDate >= '" + start + "'";
            if (end != "")
                sql += " and ApplyDate <= '" + end + "' ";
            if (Status != "")
                sql += " and Status = '" + Status + "'";

            int StarNum = (pageIndex - 1) * pagesize + 1;
            int EndNum = pagesize * pageIndex;
            string sqlComb = "select * from (" + sql + ") A where RowNumb between " + StarNum + " and " + EndNum + " order by " + sortExpression + " " + sortDirection; ;
            DataTable dt = DBhelper.Select(sqlComb);
            return ConvertHelper.convertToList<ApproveJoinUserInfo>(dt).ToList();
        }
        public int SearchApproveCount(string title, string start, string end, string Status)
        {
            string sql = "select ROW_NUMBER() over (order by Approve.ApproveID) RowNumb,*,statusname= case Status when '1' then '归档' else '待审核' end  from Approve left join UserInfo on UserInfo.UserID=Approve.ApplyUser where Title like '%" + title + "%'";
            if (start != "")
                sql += " and ApplyDate >= '" + start + "'";
            if (end != "")
                sql += " and ApplyDate <= '" + end + "' ";
            if (Status != "")
                sql += " and Status = '" + Status + "'";
            DataTable dt = DBhelper.Select(sql);
            return dt.Rows.Count;
        }
        public int SearchApproveCountByUser(string User, string title, string start, string end, string Status)
        {
            string sql = "select ROW_NUMBER() over (order by Approve.ApproveID) RowNumb,*,statusname= case Status when '1' then '归档' else '待审核' end  from Approve left join UserInfo on UserInfo.UserID=Approve.ApplyUser where ApplyUser='" + User + "' and Title like '%" + title + "%'";
            if (start != "")
                sql += " and ApplyDate >= '" + start + "'";
            if (end != "")
                sql += " and ApplyDate <= '" + end + "' ";
            if (Status != "")
                sql += " and Status = '" + Status + "'";
            DataTable dt = DBhelper.Select(sql);
            return dt.Rows.Count;
        }
        public void AddApprove(Approve ap)
        {
            string sql = string.Format("insert into Approve values ((select userid from UserInfo where UserName='{0}'),'{1}','{2}','{3}','{4}',(select ManagerID from Department  where DeptID= (select DeptID from UserInfo where UserName='{0}')),getdate(),null,'0',null,null)"
                , ap.ApplyUser, ap.Title, ap.BeginDate, ap.EndDate, ap.Reason);

            DBhelper.Change(sql);
        }
        public void EditApprove(Approve ap)
        {
            string sql = string.Format(" update Approve set Title='{0}',BeginDate='{1}',EndDate='{2}',Reason='{3}' where ApproveID='{4}'"
                , ap.Title, ap.BeginDate, ap.EndDate, ap.Reason, ap.ApproveID);
            DBhelper.Change(sql);
        }
        public void DeleteApprove(string id)
        {
            string sql = " delete from Approve where ApproveID='" + id + "'";
            DBhelper.Change(sql);
        }
        public static string GetRes(string date)
        {
            string sql = "select Reason from Approve  where ApproveID = '" + date + "'";
            return DBhelper.Select(sql).Rows[0][0].ToString();
        }
        public static string DateIsFull(string star, string end, string id,string appid)
        {
            string sql = string.Format("select * from Approve  where ApplyUser  = '{0}' and(BeginDate between '{1}' and '{2}' or EndDate between '{1}' and '{2}')",
                id,star, end);
            if (appid != "")
                sql += " and ApproveID!='"+ appid + "'";
            return DBhelper.Select(sql).Rows.Count > 0 ? "true" : "false";
        }

    }
}
