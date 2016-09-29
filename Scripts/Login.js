
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