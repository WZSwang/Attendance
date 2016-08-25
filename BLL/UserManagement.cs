using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Entity;
using DAL;

namespace BLL
{
   public   class UserManagement
    {
        UserServices Userserve = new UserServices();
        public bool Login(ref UserInfo us)
        {
            return Userserve.Login(ref us); ;
        }
    }
}
