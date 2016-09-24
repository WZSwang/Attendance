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

        public Dictionary<DateTime, int> getDaySet(int year, int month)
        {
            Dictionary<DateTime, int> asetDic = new Dictionary<DateTime, int>();
            string sql = " select *  from AttendanceSetting where YEAR(Date) =" + year + " and MONTH(Date)  =" + month;
            DataTable dt = DBhelper.Select(sql);
            foreach (DataRow dr in dt.Rows)
            {
                DateTime now = Convert.ToDateTime(dr["Date"]);
                int statu = Convert.ToInt32(dr["Status"]);
                asetDic[now] = statu;
            }
            return asetDic;
        }

        public Dictionary<DateTime, int> getHoliday(int year, int month, string id)
        {
            Dictionary<DateTime, int> HoliDic = new Dictionary<DateTime, int>();
            string sql = "select* from Approve where ApplyUser = '" + id + "' and YEAR(BeginDate) = " + year + " and MONTH(BeginDate) = " + month + " and Result=1";
            DataTable dt = DBhelper.Select(sql);
            foreach (DataRow dr in dt.Rows)
            {
                DateTime star = Convert.ToDateTime(dr["BeginDate"]);
                DateTime end = Convert.ToDateTime(dr["EndDate"]);

                if (star.Hour == 8)
                    HoliDic[Convert.ToDateTime(star.ToShortDateString())] = 3;
                else
                    HoliDic[Convert.ToDateTime(star.ToShortDateString())] = 301;
                for (star = star.AddDays(1); star < end; star = star.AddDays(1))
                {
                    HoliDic[Convert.ToDateTime(star.ToShortDateString())] = 3;
                    HoliDic[Convert.ToDateTime(star.ToShortDateString())] = 3;
                }
                if (end.Hour == 17)
                    if (star.AddDays(-1).ToShortDateString() == end.ToShortDateString())
                        HoliDic[Convert.ToDateTime(end.ToShortDateString())] = 301;
                    else
                        HoliDic[Convert.ToDateTime(end.ToShortDateString())] = 3;
                else
                    HoliDic[Convert.ToDateTime(end.ToShortDateString())] = 310;
            }
            return HoliDic;
        }
        public DataTable getCardInfo(int year, int month, string id)
        {
            Dictionary<DateTime, int> HoliDic = new Dictionary<DateTime, int>();
            string sql = "select MIN(FaceTime) Frist,Max(FaceTime) Last,COUNT(FaceTime) Count,convert(varchar(10),FaceTime,111) Date  from AttendanceInfo where UserID = '" + id + "' and YEAR(FaceTime) = " + year + " and MONTH(FaceTime) = " + month + " group by UserID, convert(varchar(10), FaceTime, 111)";
            DataTable dt = DBhelper.Select(sql);
            return dt;
        }

        public List<AttendanceView> GetAttendanceInfo(int year, int month, string id)
        {
            Dictionary<DateTime, int> asetDic = getDaySet(year, month);
            Dictionary<DateTime, int> HoliDic = getHoliday(year, month, id);
            var card = from a in getCardInfo(year, month, id).AsEnumerable() select a;

            List<AttendanceView> list = new List<AttendanceView>();
            for (int i = 1; i <= DateTime.DaysInMonth(year, month); i++)
            {
                AttendanceView view = new AttendanceView();
                view.Date = Convert.ToDateTime(year + "-" + month + "-" + i);

                if ((asetDic.ContainsKey(view.Date) && (asetDic[view.Date] == 1 || (asetDic[view.Date] == 0 && view.Date.DayOfWeek != DayOfWeek.Saturday && view.Date.DayOfWeek != DayOfWeek.Sunday)))
                    || (!asetDic.ContainsKey(view.Date) && view.Date.DayOfWeek != DayOfWeek.Saturday && view.Date.DayOfWeek != DayOfWeek.Sunday))
                {
                    //工作日
                    var qur = (from a in card
                               where a.Field<string>("Date") == view.Date.ToString("yyyy/MM/dd")
                               select a).FirstOrDefault();
                    if (qur != null)
                    {
                        view.First = qur.Field<DateTime>("Frist");
                        view.Last = qur.Field<DateTime>("Last");
                        if (HoliDic.ContainsKey(view.Date))
                        {
                            int st = HoliDic[view.Date];

                            if (st == 3)
                                view.Status = "<font style='color:#1695A3;'>请假</font>";
                            //301 310
                            else if (st == 301)
                            {
                                if (view.First.Hour >= 8 && view.First.Minute > 30)
                                    view.Status = "<font style='color:#3498DB'>早退</font>  <font style='color:#1695A3'>请假</font>";
                                else
                                    view.Status = "<font style='color:#2980B9'>正常</font>  <font style='color:#1695A3'>请假</font>";
                            }
                            else if (st == 310)
                            {
                                if (view.Last.Hour <= 15 && view.Last.Minute <= 50)
                                    view.Status = "<font style='color:#1695A3'>请假</font>  <font style='color:#2C3E50'>迟到</font>";
                                else
                                    view.Status = "<font style='color:#1695A3'>请假</font>  <font style='color:#2980B9'>正常</font>";
                            }
                        }
                        else if (view.First == view.Last)
                            view.Status = "<font style='color:pink'>未打卡</font>";
                        else if (view.First.Hour >= 8 && view.First.Minute > 30 && view.Last.Hour <= 15 && view.Last.Minute <= 50)
                            view.Status = "<font style='color:yellow;'>迟到且早退</font>";
                        else if (view.First.Hour >= 8 && view.First.Minute > 30)
                            view.Status = "<font style='color:#2C3E50;'>迟到</font>";
                        else if (view.Last.Hour <= 15 && view.Last.Minute <= 50)
                            view.Status = "<font style='color:#3498DB;'>早退</font>";
                        else
                            view.Status = "<font style='color:#2980B9;'>正常</font>";
                    }
                    else if (HoliDic.ContainsKey(view.Date))
                    {
                        int st = HoliDic[view.Date];

                        if (st == 3)
                            view.Status = "<font style='color:#1695A3'>请假</font>";
                        //301 310
                        else if (st == 301)
                            view.Status = "<font style='color:#E74C3C'>缺勤</font>  <font style='color:#1695A3'>请假</font>";
                        else if (st == 310)
                            view.Status = "<font style='color:#1695A3'>请假</font>  <font style='color:#E74C3C'>缺勤</font>";
                    }
                    else
                        view.Status = "<font style='color:#E74C3C'>缺勤</font>";
                }
                else
                    view.Status = "<font style='color:#000;'>休假</font>";
                list.Add(view);
            }
            return list;
        }
        public List<AttendanceView> GetAttendanceView(int year, int month, string id)
        {
            List<AttendanceView> list = new List<AttendanceView>();
            Dictionary<DateTime, int> asetDic = getDaySet(year, month);
            Dictionary<DateTime, int> HoliDic = getHoliday(year, month, id);
            var card = from a in getCardInfo(year, month, id).AsEnumerable() select a;

            for (int i = 1; i <= DateTime.DaysInMonth(year, month); i++)
            {
                AttendanceView view = new AttendanceView();
                view.Date = Convert.ToDateTime(year + "-" + month + "-" + i);

                if ((asetDic.ContainsKey(view.Date) && (asetDic[view.Date] == 1 || (asetDic[view.Date] == 0 && view.Date.DayOfWeek != DayOfWeek.Saturday && view.Date.DayOfWeek != DayOfWeek.Sunday)))
                    || (!asetDic.ContainsKey(view.Date) && view.Date.DayOfWeek != DayOfWeek.Saturday && view.Date.DayOfWeek != DayOfWeek.Sunday))
                {
                    //工作日
                    var qur = (from a in card
                               where a.Field<string>("Date") == view.Date.ToString("yyyy/MM/dd")
                               select a).FirstOrDefault();
                    if (qur != null)
                    {
                        view.First = qur.Field<DateTime>("Frist");
                        view.Last = qur.Field<DateTime>("Last");
                        if (HoliDic.ContainsKey(view.Date))
                        {
                            int st = HoliDic[view.Date];

                            if (st == 3)
                                view.Status = "<td style='background:#1695A3;color:#fff'>请假</td>";
                            //301 310
                            else if (st == 301)
                            {
                                if (view.First.Hour >= 8 && view.First.Minute > 30)
                                    view.Status = "<td><table style='width:100%;height:100%;text-align:center;' ><tr><td style='background:#3498DB;color:#fff'>早退</td></tr> <tr><td style='background:#1695A3;color:#fff'>请假</td></tr> </table></td> ";
                                else
                                    view.Status = "<td><table style='width:100%;height:100%;text-align:center;' ><tr><td style='background:#2980B9;color:#fff'>正常</td></tr><tr><td style='background:#1695A3;color:#fff'>请假</td></tr> </table> </td>";
                            }
                            else if (st == 310)
                            {
                                if (view.Last.Hour <= 15 && view.Last.Minute <= 50)
                                    view.Status = "<td><table style='width:100%;height:100%;text-align:center;' ><tr><td style='background:#1695A3;color:#fff'>请假</td></tr><tr><td style='background:#2C3E50;color:#fff'>迟到</td></tr> </table> </td>";
                                else
                                    view.Status = "<td><table style='width:100%;height:100%;text-align:center;' ><tr><td style='background:#1695A3;color:#fff'>请假</td></tr> <tr><td style='background:#2980B9;color:#fff'>正常</td></tr> </table></td> ";
                            }
                        }
                        else if (view.First == view.Last)
                            view.Status = "<td style='background:pink'>未打卡</td>";
                        else if (view.First.Hour >= 8 && view.First.Minute > 30 && view.Last.Hour <= 15 && view.Last.Minute <= 50)
                            view.Status = "<td style='background:yellow;'>迟到且早退</td>";
                        else if (view.First.Hour >= 8 && view.First.Minute > 30)
                            view.Status = "<td style='background:#2C3E50;color:#fff'>迟到</td>";
                        else if (view.Last.Hour <= 15 && view.Last.Minute <= 50)
                            view.Status = "<td style='background:#3498DB;color:#fff'>早退</td>";
                        else
                            view.Status = "<td style='background:#2980B9;color:#fff'>正常</td>";
                    }
                    else if (HoliDic.ContainsKey(view.Date))
                    {
                        int st = HoliDic[view.Date];

                        if (st == 3)
                            view.Status = "<td style='background:#1695A3;color:#fff'>请假</td>";
                        //301 310
                        else if (st == 301)
                            view.Status = "<td><table style='width:100%;height:100%;text-align:center;' ><tr><td style='background:#E74C3C;color:#fff'>缺勤</td></tr><tr><td style='background:#1695A3;color:#fff'>请假</td></tr> </table> </td>";
                        else if (st == 310)
                            view.Status = "<td><table style='width:100%;height:100%;text-align:center;' ><tr><td style='background:#1695A3;color:#fff'>请假</td></tr><tr><td style='background:#E74C3C;color:#fff'>缺勤</td></tr> </table> </td>";
                    }
                    else
                        view.Status = "<td style='background:#E74C3C;color:#fff'>缺勤</td>";
                }
                else
                    view.Status = "<td style='background:#ECF0F1;'>休假</td>";

                list.Add(view);
            }


            return list;
        }


    }
}
