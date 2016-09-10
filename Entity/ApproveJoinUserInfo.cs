using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Entity
{
    public class ApproveJoinUserInfo
    {
        public string UserID { get; set; }
        public string UserName { get; set; }
        public int? DeptID { get; set; }
        public string Password { get; set; }
        public string Cellphone { get; set; }
        public byte? UserType { get; set; }
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

        public string statusname { get; set; }


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
