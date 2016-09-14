using BLL;
using Entity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Attendance.Manage
{
    public partial class ApplyHolidy : System.Web.UI.Page
    {
        HolidayManagement hm = new HolidayManagement();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                UserInfo us = Session["user"] as UserInfo;
                ViewState["sortExpression"] = "ApproveID";
                ViewState["sortDirection"] = "ASC";
                ControlTemplate.SetPager(hm.SearchApproveCountByManage(us.DeptID.ToString()), gdvinfo.PageSize);
                Bind(sender, e);
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            UserInfo us = Session["user"] as UserInfo;
            ControlTemplate.SetPager(hm.SearchApproveCountByManage(us.DeptID.ToString(), txtsearchUser.Text,txtSearchTitle.Text, txtSearchStar.Text, txtSearchEnd.Text, rblStatus.SelectedValue), gdvinfo.PageSize);
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
        public void Bind(object sender, EventArgs e)
        {
            UserInfo us = Session["user"] as UserInfo;
            string sortExpression = ViewState["sortExpression"].ToString();
            string sortDirection = ViewState["sortDirection"].ToString();
            List<ApproveJoinUserInfo> dtBind = hm.SearchApproveByManage(us.DeptID.ToString(), txtsearchUser.Text, txtSearchTitle.Text, txtSearchStar.Text, txtSearchEnd.Text, rblStatus.SelectedValue, ControlTemplate.pageSize, ControlTemplate.pageIndex, sortExpression, sortDirection);
            // GridView绑定并显示数据
            this.gdvinfo.DataSource = dtBind;
            this.gdvinfo.DataBind();
        }



        protected void btnedit_Click(object sender, EventArgs e)
        {
            UserInfo us = Session["user"] as UserInfo;
            hm.AppleApprove(us.UserID, ddlRes.SelectedValue, TxtText.Text, AppID.Value);
            Bind( sender,  e);
        }




        #region AJAX静态方法

        [WebMethod]
        public static string GetRes(string str)
        {
            return HolidayManagement.GetRes(str);
        }

        [WebMethod]
        public static string GetApply(string str)
        {
            return HolidayManagement.GetApply(str);
        }

        #endregion
    }

}