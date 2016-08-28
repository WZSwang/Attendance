<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Attendance.Login" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>主页</title>
    <link href="Styles/Login.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="Scripts/jquery-1.4.1.js"></script>
    <script type="text/javascript">
        var flag = true;
        var pas = true;
        function nul(who) {
            if (flag) {
                who.value = '';
                flag = false;
            }
        }
        function nulls(who) {
            if (pas) {
                who.type = 'password';
                who.value = '';
                pas = false;
            }
        }

        function over(theover) {
            theover.style.opacity = "0.7";
        }

        function out(theout) {
            theout.style.opacity = "1";
        }

        function fover(theover) {
            theover.style.backgroundColor = "#336699";
        }

        function fout(theout) {
            theout.style.backgroundColor = "black";
        }

        function mover(theover) {
            theover.style.opacity = "0.8";
        }

        function mout(theout) {
            theout.style.opacity = "0.5";
        }

        $(document).ready(function () {
            $("#loginin").mousedown(function () {
                //点击ID为"button_login"的按钮后触发函数;
                $.ajax({
                    url: 'HttpHandler/LoginDataHandler.ashx',
                    data: 'txtName=' + $("#txtName").val() + "&txtPwd=" + $("#txtPwd").val(),
                    type: 'post',
                    error: function () {
                        $("#Tips").css("display", "block");
                    },
                    success: function (msg) {
                        if (msg == "Admin") {
                            location.href = "Admin/DateSetting.aspx";//location.href实现客户端页面的跳转  
                        } else if (msg == "Manage") {
                            location.href = "Index.aspx";
                        } else if (msg == "People") {
                            location.href = "Index.aspx";
                        } else if (msg == "false") {
                            $("#Tips").css("display", "block");
                        } else
                            alert("Running Error!");
                    }
                });
            });
        });

        $(function () {

            //按登录链接
            $("#loginclick").click(function () {
                $("#logc").fadeIn(300); //显示透明层
                $(".loginc").fadeIn(300); //显示登录div
            });

            //按透明层的事件
            $("#logc").click(function () {
                $("#logc").fadeOut(500); //隐藏透明层
                $(".loginc").fadeOut(500); //隐藏登录层
            });

            //鼠标以上按钮透明度变化
            $(".btn").mouseover(function () {
                this.style.opacity = "0.7";
            })
            $(".btn").mouseout(function () {
                this.style.opacity = "1";
            })

            //文本框点击透明度变化
            $(".txt").click(function () {
                this.value = "";
                this.style.opacity = "1";
            })
            $("#aboutus").click(function () {
                $(".enterplorer-banner").fadeIn(1000);
                $("#divdown").css("top", "50%");
                $("#aboutc").fadeIn(200);
                $("#xhx").slideUp(200);
                $("#divdown").addClass("moveup");
                $("#divdown").removeClass("movedown");
            })
            $("#aboutc").click(function () {
                $(".enterplorer-banner").fadeOut(1000);
                $("#divdown").css("top", "90%");
                $("#aboutc").fadeOut(200);
                $("#xhx").slideDown(200);
                $("#divdown").addClass("movedown");
                $("#divdown").removeClass("moveup");
            })

        });
    </script>
</head>
<body>
    <div class="enterplorer-banner">
        <ul class="bg-bubbles">
            <li></li>
            <li></li>
            <li></li>
            <li></li>
            <li></li>
            <li></li>
            <li></li>
            <li></li>
            <li></li>
            <li></li>
        </ul>
    </div>
    <!--上部div-->
    <div id="divup">
        <div id="TobPic">
            <div id="TobFont1">厚溥公司</div>
            <div id="TobFont2">管理人力  编排假日  统计考勤</div>
            <div id="TobFont3">默认用户名和密码为公司编号,建议初次登录后修改安全性更高的密码。</div>
            <input type="button" value="Login" id="loginclick" onmouseover="mover(this)" onmouseout="mout(this)" />
        </div>
    </div>
    <span style="position: absolute; right: 50px; bottom: 20px; font-family: 微软雅黑; font-size: 15px; color: White;">©2016 厚浦 N1612班</span>

    <!--白色下部div层-->
    <div id="divdown">
        <div id="xhx"><a href="#" class="links" id="aboutus" style="color: #fff;">> 关 于 我 们 <</a></div>

        <table style="width: 100%; height: 100%; background-color: transparent; padding-top: 20px; font-family: 微软雅黑; font-size: 18px; color: White;">
            <tr style="text-align: center; height: 50%">
                <td>
                    <img alt="" src="Images/renshi.png" class="imgt" style="width: 400px; height: 200px; background-color: red; border: 0px;" onmouseover="this.style.zoom=1.8" onmouseout="this.style.zoom=1" /></td>
                <td>
                    <img alt="" src="Images/qingjia.png" class="imgt" style="width: 400px; height: 200px; background-color: Blue; border: 0px;" onmouseover="this.style.zoom=1.8" onmouseout="this.style.zoom=1" /></td>
                <td>
                    <img alt="" src="Images/baobiao.png" class="imgt" style="width: 400px; height: 200px; background-color: Green; border: 0px;" onmouseover="this.style.zoom=1.8" onmouseout="this.style.zoom=1" /></td>
            </tr>
            <tr style="text-align: center;">
                <td>
                    <table class="tbldown" width="100%">
                        <tr>
                            <td>重大事件提醒</td>
                        </tr>
                        <tr>
                            <td>公司内部实时交流</td>
                        </tr>
                    </table>
                </td>
                <td>
                    <table class="tbldown" width="100%">
                        <tr>
                            <td>公司数据一目了然</td>
                        </tr>
                        <tr>
                            <td>发现更有潜力的发展方向</td>
                        </tr>
                    </table>
                </td>
                <td>
                    <table class="tbldown" width="100%">
                        <tr>
                            <td>管理公司内部员工资料</td>
                        </tr>
                        <tr>
                            <td>设置/更改公司人事信息</td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>

    </div>

    <!--透明背景层-->
    <div class="outc" id="logc" style="z-index: 10;"></div>
    <div class="outc" id="aboutc" style="z-index: 5;"></div>


    <!--登录div-->
    <div class="loginc">
        <form id="form" runat="server">
            <div id="logtitle">Login</div>
            <div style="padding-top: 20px; width: 100%;">
                <img src="Images/HI1.png" id="touxiang" alt=" " />
                <input runat="server" type="text" class="txt" value="请输入账号" id="txtName" onmousedown="nul(this)" />
                <input type="text" class="txt" value="请输入密码" id="txtPwd" onmousedown="nulls(this)" />
                <div style="text-align: center; height: 200px; width: 100%;">
                    <input type="button" class="btn" id="loginin" value="登录" />
                    <p id="Tips">*用户名或密码错误，请核对后再试！</p>
                </div>
            </div>
        </form>
    </div>


</body>
</html>
