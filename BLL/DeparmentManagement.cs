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

        public DataTable  GetAllPeople()
        {
            return Peopleserve.GetAllPeople();
        }

        public DataTable GetAllDepart()
        {
            return Peopleserve.GetAllDepart();
        }
        public DataTable SearchPeople(string id, string name, string dept)
        {
            return Peopleserve.SearchPeople(id, name, dept);
        }
        public DataTable SearchManage(string name, string manage)
        {
            return Peopleserve.SearchManage( name, manage);
        }

        public void AddDepart(Department dp)
        {
            Peopleserve.AddDepart(dp);
        }
    }
}
