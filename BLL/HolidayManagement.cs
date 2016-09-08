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

        public DataTable SearchApprove(string title, string start, string end, string Status, int pagesize, int pageIndex)
        {
            return holiSer.SearchApprove(title, start, end, Status, pagesize, pageIndex);
        }
    }
}
