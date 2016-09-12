using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Entity;
using DAL;
using System.Data;

namespace BLL
{
    public class HolidayManagement
    {
        HolidayServices holiSer = new HolidayServices();

        public List<ApproveJoinUserInfo> SearchApproveByUser(string User, string title, string start, string end, string Status, int pagesize, int pageIndex, string sortExpression, string sortDirection)
        {
            return holiSer.SearchApproveByUser(User, title, start, end, Status, pagesize, pageIndex, sortExpression, sortDirection);
        }
        public int SearchApproveCount(string title = "", string start = "", string end = "", string Status = "")
        {
            return holiSer.SearchApproveCount(title, start, end, Status);
        }
        public int SearchApproveCountByUser(string User, string title = "", string start = "", string end = "", string Status = "")
        {
            return holiSer.SearchApproveCountByUser(User, title, start, end, Status);
        }
        public void AddApprove(Approve ap)
        {
            holiSer.AddApprove(ap);
        }
        public void EditApprove(Approve ap)
        {
            holiSer.EditApprove(ap);
        }
        public void DeleteApprove(string id)
        {
            holiSer.DeleteApprove(id);
        }
        public static string GetRes(string date)
        {
            return HolidayServices.GetRes(date);
        }
        public static string DateIsFull(string star, string end, string id, string appid)
        {
            return HolidayServices.DateIsFull(star, end, id, appid);
        }
    }
}
