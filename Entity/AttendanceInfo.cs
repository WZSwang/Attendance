using System;
using System.Collections.Generic;
using System.Text;

namespace Entity
{
	public class AttendanceInfo
	{
		/// <summary>
		/// �޲ι��췽��
		/// </summary>
		public AttendanceInfo(){ }
	
		/// <summary>
		/// ���ݿ�ǿ��ֶεĹ��췽��
		/// </summary>
		public AttendanceInfo(int attendanceID,string userID)
		{
			this.attendanceID = attendanceID;
			this.userID = userID;
		}
	
		/// <summary>
		/// ָ���ֶεĹ��췽��
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