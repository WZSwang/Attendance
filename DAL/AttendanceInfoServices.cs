using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Entity;
using System.Data;

namespace DAL
{
    public class AttendanceInfoServices
    {
        public enum status
        {
            正常 = 1,
            未打卡 = 2,//当天只有一次打卡记录
            请假 = 3,//当天包含于审批同意的请假申请时间范围内
            休假 = 4,//当天为默认休假日（周末）或指定休假日（见考勤设置）
            缺勤 = 5,//当天没有打卡记录
            迟到 = 6,//第一次打卡时间晚于上班时间，且当天打卡两次
            早退 = 7,//最后一次打卡时间早于下班时间，且当天打卡两次
            迟到且早退 = 8,//：当天打卡两次，且第一次打卡时间晚于上班时间，最后一次打卡时间早于下班时间
        }
        public List<AttendanceView> GetAttendanceInfo(int year, int month, string id)
        {
            string sql;
            DataTable dt = new DataTable();
            Dictionary<DateTime, int> asetDic = new Dictionary<DateTime, int>();

            //休息日
            sql = " select *  from AttendanceSetting where YEAR(Date) =" + year + " and MONTH(Date)  =" + month;
            dt = DBhelper.Select(sql);
            foreach (DataRow dr in dt.Rows)
            {
                DateTime now = Convert.ToDateTime(dr["Date"]);
                int statu = Convert.ToInt32(dr["Status"]);
                asetDic[now] = statu;
            }

            //晴假日  01 10
            sql = "select* from Approve where ApplyUser = '" + id + "' and YEAR(BeginDate) = " + year + " and MONTH(BeginDate) = " + month + " and Result=1";
            dt = DBhelper.Select(sql);
            foreach (DataRow dr in dt.Rows)
            {
                DateTime star = Convert.ToDateTime(dr["BeginDate"]);
                DateTime end = Convert.ToDateTime(dr["EndDate"]);

                if (star.Hour == 8)
                    asetDic[Convert.ToDateTime(star.ToShortDateString())] = 3;
                else
                    asetDic[Convert.ToDateTime(star.ToShortDateString())] = 301;
                for (star = star.AddDays(1); star < end; star = star.AddDays(1))
                {
                    asetDic[Convert.ToDateTime(star.ToShortDateString())] = 3;
                    asetDic[Convert.ToDateTime(star.ToShortDateString())] = 3;
                }
                if (end.Hour == 17)
                    if (star.AddDays(-1).ToShortDateString() == end.ToShortDateString())
                        asetDic[Convert.ToDateTime(end.ToShortDateString())] = 301;
                    else
                        asetDic[Convert.ToDateTime(end.ToShortDateString())] = 3;
                else
                    asetDic[Convert.ToDateTime(end.ToShortDateString())] = 310;
            }

            //打卡记录
            sql = "select MIN(FaceTime) Frist,Max(FaceTime) Last,COUNT(FaceTime) Count,convert(varchar(10),FaceTime,111) Date  from AttendanceInfo where UserID = '" + id + "' and YEAR(FaceTime) = " + year + " and MONTH(FaceTime) = " + month + " group by UserID, convert(varchar(10), FaceTime, 111)";
            dt = DBhelper.Select(sql);
            var q = from a in dt.AsEnumerable() select a;

            List<AttendanceView> list = new List<AttendanceView>();
            for (int i = 1; i <= DateTime.DaysInMonth(year, month); i++)
            {
                AttendanceView view = new AttendanceView();
                view.Status = "正常";
                view.Date = Convert.ToDateTime(year + "-" + month + "-" + i);
                var qur = (from a in q where a.Field<string>("Date") == view.Date.ToString("yyyy/MM/dd") select a).FirstOrDefault();
                var k = from a in q where a.Field<string>("Date") == view.Date.ToString("yyyy/MM/dd") select a;
                var f = view.Date.ToString("yyyy/MM/dd");
                if (qur != null)
                {
                    view.First = qur.Field<DateTime>("Frist");
                    view.Last = qur.Field<DateTime>("Last");
                    if (qur.Field<int>("Count") == 1)
                    {
                        view.Status = "未打卡";
                        list.Add(view);
                        continue;
                    }
                    else
                    {

                        if (asetDic.ContainsKey(view.Date))
                        {
                            int st = asetDic[view.Date];

                            if (st == 3)
                                view.Status = "请假";
                            //301 310
                            else if (st == 301)
                            {
                                if (view.Last.Hour <= 15 && view.Last.Minute <= 50)
                                    view.Status = "早退 请假";
                                else
                                    view.Status = "正常 请假";
                            }
                            else if (st == 310)
                            {
                                if (view.First.Hour >= 8 && view.First.Minute > 30)
                                    view.Status = "请假 迟到";
                                else
                                    view.Status = "请假 正常";
                            }
                        }
                    }

                    if (view.First.Hour >= 8 && view.First.Minute > 30 && view.Last.Hour <= 15 && view.Last.Minute <= 50)
                        view.Status = "迟到且早退";
                    else if (view.First.Hour >= 8 && view.First.Minute > 30)
                        view.Status = "迟到";
                    else if (view.Last.Hour <= 15 && view.Last.Minute <= 50)
                        view.Status = "早退";
                }
                else
                    if (asetDic.ContainsKey(view.Date) && asetDic[view.Date] == 4)
                    view.Status = "休假";
                else if (asetDic.ContainsKey(view.Date) && asetDic[view.Date] == 0 && (view.Date.DayOfWeek == DayOfWeek.Saturday || view.Date.DayOfWeek == DayOfWeek.Sunday))
                    view.Status = "休假";
                else if (view.Date.DayOfWeek == DayOfWeek.Saturday || view.Date.DayOfWeek == DayOfWeek.Sunday)
                    view.Status = "休假";
                else
                    view.Status = "缺勤";
                list.Add(view);
            }


            return list;
        }


    }
}
