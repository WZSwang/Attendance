using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Entity;
using DAL;
using System.Data;

namespace BLL
{
    public class PeopleManagement
    {
        PeropleServices Peopleserve = new PeropleServices();

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

        public void AddPeople(UserInfo us)
        {
            Peopleserve.AddPeople(us);
        }
        public static bool UserIDPadding(string id)
        {
            return PeropleServices.UserIDPadding(id);
        }
        public static string UserInfos(string id)
        {
            return PeropleServices.UserInfos(id);
        }

    }
}
