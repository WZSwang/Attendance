using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Entity
{

    public class AttendanceSetting
    {
        /// <summary>
        /// 无参构造方法
        /// </summary>
        public AttendanceSetting() { }

        /// <summary>
        /// 数据库非空字段的构造方法
        /// </summary>
        public AttendanceSetting(int settingID, DateTime date)
        {
            this.settingID = settingID;
            this.date = date;
        }

        /// <summary>
        /// 指定字段的构造方法
        /// </summary>
        public AttendanceSetting(int settingID, DateTime date, byte status)
        {
            this.settingID = settingID;
            this.date = date;
            this.status = status;
        }

        private int settingID;
        public int SettingID
        {
            get { return settingID; }
            set { settingID = value; }
        }

        private DateTime date;
        public DateTime Date
        {
            get { return date; }
            set { date = value; }
        }

        private int status;
        public int Status
        {
            get { return status; }
            set { status = value; }
        }
    }
}
