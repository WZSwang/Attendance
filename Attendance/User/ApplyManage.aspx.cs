using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BLL;
using Entity;
using System.Data;
using System.Web.Services;

namespace Attendance.User
{
    public partial class ApplyManage : System.Web.UI.Page
    {
        HolidayManagement hm = new HolidayManagement();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                UserInfo us = Session["user"] as UserInfo;
                ViewState["sortExpression"] = "ApproveID";
                ViewState["sortDirection"] = "ASC";
                txtApplyName.Text = LabEditName.Text = LabViewName.Text = us.UserName;
                editId.Value = us.UserID;
                ControlTemplate.SetPager(hm.SearchApproveCountByUser(us.UserID), gdvinfo.PageSize);
                Bind(sender, e);
            }
        }



        protected void btnin_Click(object sender, EventArgs e)
        {
            Approve ap = new Approve();
            ap.ApplyUser = txtApplyName.Text;
            ap.Title = txtApplyTitle.Text;
            ap.BeginDate = Convert.ToDateTime(txtApplyStart.Text + " " + drpApplyStart.SelectedValue);
            ap.EndDate = Convert.ToDateTime(txtApplyEnd.Text + " " + drpApplyEnd.SelectedValue);
            ap.Reason = txtApplyRes.Text;
            hm.AddApprove(ap);
            Response.Redirect("ApplyManage.aspx");
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            UserInfo us = Session["user"] as UserInfo;
            ControlTemplate.SetPager(hm.SearchApproveCountByUser(us.UserID, txtSearchTitle.Text, txtSearchStar.Text, txtSearchEnd.Text, rblStatus.SelectedValue), gdvinfo.PageSize);
            Bind(sender, e);
        }

        protected void btnedit_Click(object sender, EventArgs e)
        {
            Approve ap = new Approve();
            ap.ApproveID = Convert.ToInt32(AppID.Value);
            ap.Title = txtEditTitle.Text;
            ap.BeginDate = Convert.ToDateTime(txtEditStart.Text + " " + drpEditStart.SelectedValue);
            ap.EndDate = Convert.ToDateTime(txtEidtEnd.Text + " " + drpEidtEnd.SelectedValue);
            ap.Reason = txtEditRes.Text;
            hm.EditApprove(ap);
            Bind(sender, e);
        }


        protected void gdvinfo_Sorting(object sender, GridViewSortEventArgs e)
        {
            string sortExpression = e.SortExpression.ToString();
            // “ASC”与事件参数获取到的排序方向进行比较，进行GridView排序方向参数的修改
            if (sortExpression == ViewState["sortExpression"].ToString())
                //获得下一次的排序状态
                ViewState["sortDirection"] = (ViewState["sortDirection"].ToString() == "ASC" ? "DESC" : "ASC");
            else
                // 重新设定GridView排序数据列及排序方向
                ViewState["sortExpression"] = sortExpression;

            Bind(sender, e);
        }
        protected void gdvinfo_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                if (e.Row.Cells[6].Text == "归档")
                {
                    LinkButton lb = e.Row.FindControl("lbtnView") as LinkButton;
                    lb.Visible = true;
                }
                else
                {
                    (e.Row.FindControl("ImageButonEdit") as Button).Visible = true;
                    (e.Row.FindControl("ImageButonDelete") as Button).Visible = true;
                }
            }
        }

        public void Bind(object sender, EventArgs e)
        {
            UserInfo us = Session["user"] as UserInfo;
            string sortExpression = ViewState["sortExpression"].ToString();
            string sortDirection = ViewState["sortDirection"].ToString();
            List<ApproveJoinUserInfo> dtBind = hm.SearchApproveByUser(us.UserID, txtSearchTitle.Text, txtSearchStar.Text, txtSearchEnd.Text, rblStatus.SelectedValue, ControlTemplate.pageSize, ControlTemplate.pageIndex, sortExpression, sortDirection);
            // GridView绑定并显示数据
            this.gdvinfo.DataSource = dtBind;
            this.gdvinfo.DataBind();
        }


        protected void btndelete_Click(object sender, EventArgs e)
        {
            hm.DeleteApprove(AppID.Value);
            Response.Redirect("ApplyManage.aspx");
        }




        #region AJAX静态方法

        [WebMethod]
        public static string GetRes(string str)
        {
            return HolidayManagement.GetRes(str);
        }

        [WebMethod]
        public static string DateIsFull(string star, string end, string id, string appid)
        {
            return HolidayManagement.DateIsFull(star, end, id, appid);
        }

        [WebMethod]
        public static string GetApply(string str)
        {
            return HolidayManagement.GetApply(str);
        }

        #endregion

    }

}