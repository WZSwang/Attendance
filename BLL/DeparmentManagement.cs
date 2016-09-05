using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Entity;
using DAL;
using System.Data;

namespace BLL
{
    public class DeparmentManagement
    {
        DepartmentServices Peopleserve = new DepartmentServices();
        
        public DataTable GetAllDepart()
        {
            return Peopleserve.GetAllDepart();
        }
        public DataTable SearchManage(string name, string manage,int  PageSize, int  pageindex=0)
        {
            return Peopleserve.SearchManage( name, manage, PageSize, pageindex);
        }

        public void AddDepart(Department dp)
        {
            Peopleserve.AddDepart(dp);
        }
        public void EditDepart(Department dp,string OldName)
        {
            Peopleserve.EditDepart(dp, OldName);
        }
        public void DelteDepart(string OldName)
        {
            Peopleserve.DelteDepart( OldName);
        }
        public bool DepartIsNull(string id)
        {
            return Peopleserve.DepartIsNull(id);
        }




        public static bool DepartPadding(string id)
        {
            return DepartmentServices.DepartPadding(id);
        }

        public static string DepartInfos(string id)
        {
            return DepartmentServices.DepartInfos(id);
        }
    }
}
