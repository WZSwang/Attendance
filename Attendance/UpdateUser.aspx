<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="UpdateUser.aspx.cs" Inherits="Attendance.UpdateUser" %>

<asp:Content ID="ContentHead" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="ContentMain" ContentPlaceHolderID="ContentPlaceHolderMain" runat="server">


    <div class="templatemo-flex-row flex-content-row">
        <div class="templatemo-content-widget white-bg col-2">
            <i class="fa fa-times"></i>
            <div class="square"></div>
            <h2 class="templatemo-inline-block">公司公告板</h2>
            <hr>
            <p>亲爱的员工：</p>
            <p>感谢大家一年来对公司的辛勤付出，圣诞临近，元旦近在咫尺，让我们暂时抛开工作的烦劳,相聚温暖的大家庭，与大家欢聚一堂。</p>
            <p>听一下，午夜的夜空里渐渐传来了圣诞老人驾着鹿车而来的清脆铃声，白色的圣诞节——属于我们童话般的节日如愿而至！平安夜，别静静的呆在家里发霉了，出来和我们一道狂欢吧……</p>
            <p>出发时间：2020-12-25 中午1：30    返回时间：2020-12-26午餐后</p>
        </div>
        <div class="templatemo-content-widget white-bg col-1 text-center">
            <i class="fa fa-times"></i>
            <h2 class="text-uppercase"><%= (Session["User"] as Entity.UserInfo).UserName %></h2>
            <h3 class="text-uppercase margin-bottom-10">个人头像</h3>
            <img src="images/person.jpg" width="180" height="180" alt="Bicycle" class="img-circle img-thumbnail">
        </div>
        <div class="templatemo-content-widget white-bg col-1">
            <i class="fa fa-times"></i>
            <h2 class="text-uppercase">打卡统计</h2>
            <h3 class="text-uppercase">正常/未打卡/迟到</h3>
            <hr>
            <div class="progress">
                <div class="progress-bar progress-bar-info" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 60%;"></div>
            </div>
            <div class="progress">
                <div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 50%;"></div>
            </div>
            <div class="progress">
                <div class="progress-bar progress-bar-warning" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 60%;"></div>
            </div>
        </div>
    </div>
    <div class="templatemo-flex-row flex-content-row">
        <div class="col-1">
            <div class="templatemo-content-widget orange-bg">
                <i class="fa fa-times"></i>
                <div class="media">
                    <div class="media-left">
                        <a href="#">
                            <img class="media-object img-circle" src="images/sunset.jpg" alt="Sunset">
                        </a>
                    </div>
                    <div class="media-body">
                        <h2 class="media-heading text-uppercase">重要提醒</h2>
                        <p>本公司决定2020年3月3日17点于第一会议室召开讨论关于公司未来发展规划的相关事宜的会议。</p>
                    </div>
                </div>
            </div>
            <div class="templatemo-content-widget white-bg">
                <i class="fa fa-times"></i>
                <div class="media">
                    <div class="media-left">
                        <a href="#">
                            <img class="media-object img-circle" src="images/sunset.jpg" alt="Sunset">
                        </a>
                    </div>
                    <div class="media-body">
                        <h2 class="media-heading text-uppercase">通知</h2>
                        <p>新员工XX加入，欢迎将成为我们公司的一员,祝在公司有一个美好的未来!</p>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-1">
            <div class="panel panel-default templatemo-content-widget white-bg no-padding templatemo-overflow-hidden">
                <i class="fa fa-times"></i>
                <div class="panel-heading templatemo-position-relative">
                    <h2 class="text-uppercase">修改信息</h2>
                </div>
                <div class="table-responsive">

                    <table class="table table-striped table-bordered">

                        <tr>

                            <td>新密码：</td>
                            <td>
                                <asp:TextBox ID="TxtPass" class="form-control pass" runat="server" onblur="ValueIsNull(this)"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td>确认密码：</td>
                            <td>
                                <asp:TextBox ID="TxtRePass" class="form-control repass" runat="server" onblur="ValueIsTrue(this)"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td>手机：</td>
                            <td>
                                <asp:TextBox ID="TxtPhone" class="form-control cellphone" runat="server" onblur="ValueIsNull(this)"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td colspan="2" class="text-right ">
                                <asp:Label ID="lblTips" runat="server" Text="修改成功！" Visible="false" ForeColor="#39ADB4" Style="text-align: center"></asp:Label>
                                <%-- <asp:Button ID="BtnClear" runat="server" Text="初始化" class="templatemo-white-button" />--%>
                                <asp:Button ID="BtnSubmit" runat="server" Text="确定" CssClass="templatemo-blue-button" OnClick="BtnSubmit_Click" />

                            </td>
                        </tr>

                    </table>
                </div>
            </div>
        </div>
    </div>
    <!-- Second row ends -->
</asp:Content>


<asp:Content ID="script" ContentPlaceHolderID="Script" runat="server">
    <script type="text/javascript">
        function ValueIsNull(obj) {
            $(obj).parent().removeClass("has-error");
            if (obj.value == "") {
                $(obj).parent().addClass("has-error");
                return false;
            }
            else {
                $(obj).parent().addClass("has-success");
                return true;
            }
        }
        function ValueIsTrue(obj) {
            $(obj).parent().removeClass("has-error");
            if (obj.value != $(".pass").val()) {
                $(obj).parent().addClass("has-error");
                return false;
            }
            else {
                $(obj).parent().addClass("has-success");
                return true;
            }
        }
        $("#<%=BtnSubmit.ClientID %>").click(function () {
            if (ValueIsNull($(".pass")[0]) & ValueIsTrue($(".repass")[0]) & ValueIsNull($(".cellphone")[0])) {
                return true;
            }
            return false;
        });
    </script>
</asp:Content>
