using System;
using System.Collections.Generic;
using System.Text;

namespace Entity
{
	public class AttendanceInfo
	{
		/// <summary>
		/// 无参构造方法
		/// </summary>
		public AttendanceInfo(){ }
	
		/// <summary>
		/// 数据库非空字段的构造方法
		/// </summary>
		public AttendanceInfo(int attendanceID,string userID)
		{
			this.attendanceID = attendanceID;
			this.userID = userID;
		}
	
		/// <summary>
		/// 指定字段的构造方法
		/// </summary>
		public AttendanceInfo(int attendanceID,string userID,DateTime faceTime)
		{
			this.attendanceID = attendanceID;
			this.userID = userID;
			this.faceTime = faceTime;
		}
	
		private int attendanceID;
		public int AttendanceID
		{
			get { return attendanceID; }
			set { attendanceID = value; }
		}
	
		private string userID;
		public string UserID
		{
			get { return userID; }
			set { userID = value; }
		}
	
		private DateTime faceTime;
		public DateTime FaceTime
		{
			get { return faceTime; }
			set { faceTime = value; }
		}
	}
}