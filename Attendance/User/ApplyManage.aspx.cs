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
        DeparmentManagement pm = new DeparmentManagement();
        HolidayManagement hm = new HolidayManagement();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                UserInfo us = Session["user"] as UserInfo;
                ViewState["PageCount"] = (Math.Ceiling(hm.SearchApproveCountByUser(us.UserID) / 10.0)).ToString();
                ViewState["CurrentPage"] = "1";
                ViewState["sortExpression"] = "ApproveID";
                ViewState["sortDirection"] = "ASC";
                txtApplyName.Text = us.UserName;
                LabEditName.Text = us.UserName;
                editId.Value = us.UserID;
                Bind();
            }
        }

        public void SetPager()
        {
            GridViewRow pagerRow = gdvinfo.BottomPagerRow;
            LinkButton btnPrev = (LinkButton)pagerRow.Cells[0].FindControl("btnPrev");
            btnPrev.Enabled = ViewState["CurrentPage"].ToString() != "1";
            LinkButton btnNext = (LinkButton)pagerRow.Cells[0].FindControl("btnNext");
            btnNext.Enabled = ViewState["CurrentPage"].ToString() != ViewState["PageCount"].ToString();


            //绑定数据到下拉表
            DropDownList ddl = pagerRow.FindControl("ddlIndex") as DropDownList;
            for (int i = 1; i <= Convert.ToInt32(ViewState["PageCount"]); i++)
            {
                ListItem li = new ListItem("第" + i + "页", i.ToString());
                ddl.Items.Add(li);
            }
            ddl.SelectedValue = ViewState["CurrentPage"].ToString();
        }

        protected void btnin_Click(object sender, EventArgs e)
        {
            Approve ap = new Approve();
            ap.ApplyUser = txtApplyName.Text;
            ap.Title = txtApplyTitle.Text;
            ap.BeginDate = Convert.ToDateTime(txtApplyStart.Text);
            ap.EndDate = Convert.ToDateTime(txtApplyEnd.Text);
            ap.Reason = txtApplyRes.Text;
            hm.AddApprove(ap);
            Response.Redirect("ApplyManage.aspx");
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            UserInfo us = Session["user"] as UserInfo;
            ViewState["CurrentPage"] = "1";
            ViewState["PageCount"] = (Math.Ceiling(hm.SearchApproveCountByUser(us.UserID,txtSearchTitle.Text, txtSearchStar.Text, txtSearchEnd.Text, rblStatus.SelectedValue) / 10.0)).ToString();
            Bind();
        }

        protected void btnedit_Click(object sender, EventArgs e)
        {
            Approve ap = new Approve();
            ap.ApproveID = Convert.ToInt32(editId.Value);
            ap.Title = txtEditTitle.Text;
            ap.BeginDate = Convert.ToDateTime(txtEditStart.Text);
            ap.EndDate = Convert.ToDateTime(txtEidtEnd.Text);
            ap.Reason = txtEditRes.Text;
            hm.EditApprove(ap);
            Bind();
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

            this.Bind();
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


        private void Bind()
        {
            // 获取GridView排序数据列及排序方向
            string sortExpression = ViewState["sortExpression"].ToString();
            string sortDirection = ViewState["sortDirection"].ToString();

            int pageindex = Convert.ToInt32(ViewState["CurrentPage"]);

            UserInfo us = Session["user"] as UserInfo;

            // 调用业务数据获取方法
            List<ApproveJoinUserInfo> dtBind = hm.SearchApproveByUser(us.UserID,txtSearchTitle.Text, txtSearchStar.Text, txtSearchEnd.Text, rblStatus.SelectedValue, gdvinfo.PageSize, pageindex, sortExpression, sortDirection);

            // GridView绑定并显示数据
            //  if(dtBind.Rows.Count>0)
            this.gdvinfo.DataSource = dtBind;
            this.gdvinfo.DataBind();
            try
            {
                gdvinfo.BottomPagerRow.Visible = true;
                SetPager();
            }
            catch { }

        }


        protected void btndelete_Click(object sender, EventArgs e)
        {
            hm.DeleteApprove(editId.Value);
            Response.Redirect("ApplyManage.aspx");
        }

        protected void btnFirst_Click(object sender, EventArgs e)
        {
            ViewState["CurrentPage"] = "1";
            Bind();
        }

        protected void btnPrev_Click(object sender, EventArgs e)
        {
            ViewState["CurrentPage"] = Convert.ToInt32(ViewState["CurrentPage"]) - 1;
            Bind();
        }

        protected void btnNext_Click(object sender, EventArgs e)
        {
            ViewState["CurrentPage"] = Convert.ToInt32(ViewState["CurrentPage"]) + 1;
            Bind();
        }

        protected void btnLast_Click(object sender, EventArgs e)
        {
            ViewState["CurrentPage"] = ViewState["PageCount"];
            Bind();
        }

        protected void ddlIndex_SelectedIndexChanged(object sender, EventArgs e)
        {
            DropDownList ddls = sender as DropDownList;
            ViewState["CurrentPage"] = int.Parse(ddls.SelectedValue);
            Bind();

        }



        #region AJAX静态方法

        [WebMethod]
        public static string GetRes(string str)
        {
            return HolidayManagement.GetRes(str);
        }

        [WebMethod]
        public static string DateIsFull(string star,string end,string  id)
        {
            return HolidayManagement.DateIsFull(star,end, id);
        }

        #endregion

    }

}