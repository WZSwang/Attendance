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
        public DataTable SearchApprove(string title, string start, string end, string Status, int pagesize, int pageIndex)
        {
            string sql = "select ROW_NUMBER() over (order by Approve.ApproveID) RowNumb,*,statusname= case Status when '1' then '归档' else '未审核' end  from Approve left join UserInfo on UserInfo.UserID=Approve.ApproveUser where Title like '%" + title + "%'";
            if (start != "")
                sql += " and ApplyDate between '" + start + "' and '" + end + "'";
            if (Status != "")
                sql += " and Status = '"+ Status + "'";

            int StarNum = (pageIndex - 1) * pagesize + 1;
            int EndNum = pagesize * pageIndex;
            string sqlComb = "select * from (" + sql + ") A where RowNumb between " + StarNum + " and " + EndNum;
            DataTable dt = DBhelper.Select(sqlComb);
            return dt;
        }
    }
}
