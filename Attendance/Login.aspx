﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Attendance.Login" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Attendance - Login</title>
    <link href="css/Login.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="Scripts/jquery-1.4.1.js"></script>
    <link href="css/templatemo-style.css" rel="stylesheet">
    <link href="css/font-awesome.min.css" rel="stylesheet">
    <link href="css/bootstrap.min.css" rel="stylesheet">
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
    <span style="position: absolute; right: 50px; bottom: 20px; font-family: 微软雅黑; font-size: 15px; color: White;">©2016 厚浦 N1612 WeCiao</span>

    <!--白色下部div层-->
    <div id="divdown">
        <div id="xhx"><a href="#" class="links" id="aboutus" style="color: #fff;">> 关 于 我 们 <</a></div>

        <table style="width: 100%; height: 100%; background-color: transparent; margin-top: 20px; font-family: 微软雅黑; font-size: 18px; color: White;">
            <tr style="text-align: center; height: 50%">
                <td>
                    <img alt="" src="Images/Work.png" class="imgt" style="width: 300px; height: 215px; background-color: red; border: 0px;" onmouseover="this.style.zoom=1.2" onmouseout="this.style.zoom=1" />

                </td>
                <td>
                    <img alt="" src="Images/WorkInfo.png" class="imgt" style="width: 300px; height: 215px;  background-color: Blue; border: 0px;" onmouseover="this.style.zoom=1.2" onmouseout="this.style.zoom=1" />

                </td>
                <td>
                    <img alt="" src="Images/WorkRight.png" class="imgt" style="width: 300px; height: 215px;  background-color: Green; border: 0px;" onmouseover="this.style.zoom=1.2" onmouseout="this.style.zoom=1" />


                </td>
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
        <div class="templatemo-content-widget templatemo-login-widget white-bg">
            <header class="text-center">
                <div class="square"></div>
                <h1>Welcome</h1>
            </header>
            <form action="index.html" class="templatemo-login-form" runat="server">
                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon"><i class="fa fa-user fa-fw"></i></div>
                        <input type="text" id="txtName" class="form-control" placeholder="员工ID">
                    </div>
                </div>
                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon"><i class="fa fa-key fa-fw"></i></div>
                        <input type="password" id="txtPwd" class="form-control" placeholder="******">
                    </div>
                </div>
                <div class="form-group">
                    <div class="checkbox squaredTwo" style="text-align: center">
                        <p id="Tips">*用户名或密码错误，请核对后再试！</p>
                    </div>
                </div>
                <div class="form-group">
                    <input type="button" class="templatemo-blue-button width-100" id="loginin" value="登录" />
                </div>
            </form>
        </div>
        <div class="templatemo-content-widget templatemo-login-widget templatemo-register-widget white-bg">
            <p>还没有账号和密码? <strong><a href="#" class="blue-text">快去找老板!</a></strong></p>
        </div>
    </div>
</body>
</html>

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
                        location.href = "Manage/AttendanceManage.aspx";
                    } else if (msg == "People") {
                        location.href = "User/CheckAttendance.aspx";
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
        $(".enterplorer-banner").fadeIn(1000);
        $("#aboutus").click(function () {
            $("#divdown").css("top", "50%");
            $("#aboutc").fadeIn(200);
            $("#xhx").slideUp(200);
            $("#divdown").addClass("moveup");
            $("#divdown").removeClass("movedown");
        })
        $("#aboutc").click(function () {
            $("#divdown").css("top", "90%");
            $("#aboutc").fadeOut(200);
            $("#xhx").slideDown(200);
            $("#divdown").addClass("movedown");
            $("#divdown").removeClass("moveup");
        })

    });
</script>
