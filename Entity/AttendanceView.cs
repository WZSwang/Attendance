using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Entity
{
    public class AttendanceView
    {
        public DateTime Date { get; set; }
        public DateTime First { get; set; }
        public DateTime Last { get; set; }
        public string Status { get; set; }

    }
}
