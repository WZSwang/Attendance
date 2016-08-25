using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Entity
{
    public class UserInfo
    {
        public string UserID { get; set; }
        public string UserName { get; set; }
        public int? DeptID { get; set; }
        public string Password { get; set; }
        public string Cellphone { get; set; }
        public byte? UserType { get; set; }
    }
}
