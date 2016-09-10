using System;
using System.Collections.Generic;
using System.Text;

namespace Entity
{
	public class Approve
	{
		/// <summary>
		/// 无参构造方法
		/// </summary>
		public Approve(){ }
	
		/// <summary>
		/// 数据库非空字段的构造方法
		/// </summary>
		public Approve(int approveID)
		{
			this.approveID = approveID;
		}
	
		/// <summary>
		/// 指定字段的构造方法
		/// </summary>
		public Approve(int approveID,string applyUser,string title,DateTime beginDate,DateTime endDate,string reason,string approveUser,DateTime applyDate,DateTime approveDate,byte status,byte result,string remark)
		{
			this.approveID = approveID;
			this.applyUser = applyUser;
			this.title = title;
			this.beginDate = beginDate;
			this.endDate = endDate;
			this.reason = reason;
			this.approveUser = approveUser;
			this.applyDate = applyDate;
			this.approveDate = approveDate;
			this.status = status;
			this.result = result;
			this.remark = remark;
		}
	
		private int approveID;
		public int ApproveID
		{
			get { return approveID; }
			set { approveID = value; }
		}
	
		private string applyUser;
		public string ApplyUser
		{
			get { return applyUser; }
			set { applyUser = value; }
		}
	
		private string title;
		public string Title
		{
			get { return title; }
			set { title = value; }
		}
	
		private DateTime beginDate;
		public DateTime BeginDate
		{
			get { return beginDate; }
			set { beginDate = value; }
		}
	
		private DateTime endDate;
		public DateTime EndDate
		{
			get { return endDate; }
			set { endDate = value; }
		}
	
		private string reason;
		public string Reason
		{
			get { return reason; }
			set { reason = value; }
		}
	
		private string approveUser;
		public string ApproveUser
		{
			get { return approveUser; }
			set { approveUser = value; }
		}
	
		private DateTime applyDate;
		public DateTime ApplyDate
		{
			get { return applyDate; }
			set { applyDate = value; }
		}
	
		private DateTime approveDate;
		public DateTime ApproveDate
		{
			get { return approveDate; }
			set { approveDate = value; }
		}
	
		private byte status;
		public byte Status
		{
			get { return status; }
			set { status = value; }
		}
	
		private byte result;
		public byte Result
		{
			get { return result; }
			set { result = value; }
		}
	
		private string remark;
		public string Remark
		{
			get { return remark; }
			set { remark = value; }
		}
	}
}