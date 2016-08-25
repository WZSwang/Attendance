using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.SessionState;//使用session需要引用
using BLL;
using Entity;

namespace AttendanceSystem.HttpHandler
{                 
    /// <summary>
    /// LoginDataHandler 的摘要说明
    /// </summary>             
    public class LoginDataHandler : IHttpHandler, IRequiresSessionState     // 使用session需要实现IRequiresSessionState接口
    {

        UserManagement uman = new UserManagement();
        UserInfo us = new UserInfo();
        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            us.UserID = context.Request.Form["txtName"];
            us.Password = context.Request.Form["txtPwd"];
            if (uman.Login(ref us))
            {
                context.Response.Write("true");
                context.Session["User"] = us;
            }
            else 
                context.Response.Write("false");
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}