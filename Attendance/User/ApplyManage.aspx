<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="ApplyManage.aspx.cs" Inherits="Attendance.User.ApplyManage" %>
<asp:Content ID="Head" ContentPlaceHolderID="head" runat="server">
    <title>Attendance - People</title>
    <script type="text/javascript">

        $(function () {
            $(".ImageButonEdit").click(function () {
                //display
                $(".diveditout").fadeIn(500);
                $("#editoutc").fadeIn(500);

                //getelement
                var obj = event.srcElement;
                while (obj.tagName != "TR") {
                    obj = obj.parentElement;
                }
                var userid = obj.children[2].innerText;
                document.getElementById("<%=editId.ClientID%>").value = obj.children[2].innerText;
                document.getElementById("<%=txtId.ClientID %>").value = obj.children[2].innerText;
                document.getElementById("<%=txtname.ClientID %>").value = obj.children[3].innerText;

                document.getElementById("<%=drponameedit.ClientID %>").options[0].selected = true;
                for (var i = 0; i < document.getElementById("<%=drponameedit.ClientID %>").options.length; i++) {
                    if (document.getElementById("<%=drponameedit.ClientID %>").options[i].text == obj.children[4].innerText.trim())
                        document.getElementById("<%=drponameedit.ClientID %>").options[i].selected = true;
                }
                $.ajax({
                    type: "Post",
                    url: "PeopleManage.aspx/UserInfos",
                    async: false,
                    data: "{'str':'" + userid + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) {
                        //返回的数据用data.d获取内容   
                        var ss = (data.d).split(",");
                        for (var i = 0; i < document.getElementById("<%=drpdenameedit.ClientID %>").options.length; i++)
                            if (document.getElementById("<%=drpdenameedit.ClientID %>").options[i].value == ss[0]) {
                                document.getElementById("<%=drpdenameedit.ClientID %>").options[i].selected = true;
                            }

                        document.getElementById("<%=txttel.ClientID %>").value = ss[1];
                    },
                    error: function (err) {
                        alert(err);
                    }
                });
                document.getElementById("<%=lblbrith.ClientID %>").style.display = "none";
                return true;
            });

            $("#<%=btnin.ClientID %>").click(function () {
                var NUM = document.getElementById("<% =tnid.ClientID%>").value;
                if (NUM == "") {
                    document.getElementById("<%=lblbrith0.ClientID %>").style.display = "block";
                    document.getElementById("<%=lblbrith0.ClientID %>").innerText = "请输入员工ID";
                    return false;
                }

                $.ajax({
                    type: "Post",
                    url: "PeopleManage.aspx/GetStr",
                    async: false,
                    //方法传参的写法一定要对，str为形参的名字,str2为第二个形参的名字   
                    data: "{'str':'" + NUM + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) {
                        //返回的数据用data.d获取内容   
                        if (data.d == "true") {
                            document.getElementById("<%=lblbrith0.ClientID %>").style.display = "block";
                            document.getElementById("<%=lblbrith0.ClientID %>").innerText = "已经存在的ID,请更换";
                        }
                        else
                            document.getElementById("<%=lblbrith0.ClientID %>").innerText = " ";
                    },
                    error: function (err) {
                        alert(err);
                    }
                });

                if (document.getElementById("<%=lblbrith0.ClientID %>").innerText == "已经存在的ID,请更换")
                    return false;

                var tnname = document.getElementById("<% =tnname.ClientID%>").value;
                if (tnname == "") {
                    document.getElementById("<%=lblbrith0.ClientID %>").style.display = "block";
                    document.getElementById("<%=lblbrith0.ClientID %>").innerText = "请输入员工姓名";
                    return false;
                }
                var drpdename = document.getElementById("<% =drpdename.ClientID%>").value;
                if (drpdename == -1) {
                    document.getElementById("<%=lblbrith0.ClientID %>").style.display = "block";
                    document.getElementById("<%=lblbrith0.ClientID %>").innerText = "请选择用户类型";
                    return false;
                }
                //禁用按钮的提交   
                return true;
            });

            $("#<%=btnedit.ClientID %>").click(function () {
                var tnname = document.getElementById("<% =txtname.ClientID%>").value;
                if (tnname == "") {
                    document.getElementById("<%=lblbrith.ClientID %>").style.display = "block";
                    document.getElementById("<%=lblbrith.ClientID %>").innerText = "请输入员工姓名";
                    return false;
                }
                //禁用按钮的提交   
                return true;
            });

            $("#btnadd").click(function () {
                $("#addoutc").fadeIn(500);
                $("#divaddout").fadeIn(500);
            });
            $("#addoutc").click(function () {
                $("#addoutc").fadeOut(500);
                $("#exitout").fadeOut(500);
                $("#divaddout").fadeOut(500);
            });
            $("#editoutc").click(function () {
                $("#editoutc").fadeOut(500);
                $(".diveditout").fadeOut(500);
            });
            $(".TipClose").click(function () {
                $("#addoutc").fadeOut(500);
                $("#divaddout").fadeOut(500);
                $(".diveditout").fadeOut(500);
                $("#editoutc").fadeOut(500);
            });
            $("#btndelete").click(function () {
                $("#exitout").fadeIn(500);
                $("#addoutc").fadeIn(500);
            });
        });
        function TipClose() {
            $("#addoutc").fadeOut(500);
            $("#divaddout").fadeOut(500);
            $(".diveditout").fadeOut(500);
            $("#editoutc").fadeOut(500);
            $(".MessageBox").fadeOut(500);
        }

    </script>

    <style type="text/css">
        td.selected {
            background-color: #FEF2E8;
        }
    </style>
</asp:Content>

<asp:Content ID="Main" ContentPlaceHolderID="ContentPlaceHolderMain" runat="server">
    <div class="templatemo-content-widget white-bg">
        <h2 class="text-uppercase">请假 / 查看</h2>
        <div class="panel-body">
            <div class="templatemo-flex-row flex-content-row">
                <div class="col-1">
                    <div id="timeline_div" class="templatemo-chart"></div>
                    <div class="row form-group">
                        <div class="col-lg-4 col-md-4 form-group">
                            <asp:TextBox ID="TxtSearchID" runat="server" CssClass="form-control margin-bottom-5" placeholder="请输入用户ID" Style="float: left"></asp:TextBox>
                            <asp:TextBox ID="TxtSearchName" runat="server" CssClass="form-control" placeholder="请输入用户名" Style="float: left"></asp:TextBox>
                        </div>
                        <div class="col-lg-6 col-md-6 form-group">
                            <p>部门：</p>
                            <asp:Panel ID="PanelCheckList" runat="server" Style="float: left;" Wrap="False" ScrollBars="Horizontal" Width="100%"></asp:Panel>
                        </div>
                        <div class="col-lg-2 col-md-12  form-group">
                            <p>&nbsp</p>
                            <asp:Button ID="btnSearch" runat="server" Text="搜索" CssClass="templatemo-blue-button"
                                OnClick="btnSearch_Click" />
                        </div>
                    </div>
                </div>
            </div>
            <input id="btnadd" type="button" value="添加" class="templatemo-blue-button" />
        </div>
    </div>

    <div class="templatemo-content-widget no-padding">
        <div class="panel panel-default table-responsive">
            <asp:GridView ID="gdvinfo" CssClass="table table-striped table-bordered templatemo-user-table gdvinfo" runat="server" AutoGenerateColumns="False" AllowSorting="True"
                AllowPaging="True" OnSorting="gdvinfo_Sorting" PageSize="10" Style="text-align: center" AllowCustomPaging="True">
                <EmptyDataTemplate>
                    <div style="text-align: center">没有查询到数据，请检查查询条件是否正确</div>
                </EmptyDataTemplate>
                <Columns>
                    <asp:TemplateField HeaderText='请假单ID' InsertVisible="False">
                        <ItemStyle />
                        <ItemTemplate>
                            <asp:Label ID="LabelID" runat="server" Text='<%# Bind("ApproveID") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText='<div style="width:100%;text-align :center">申请人<span class="caret"></span></div>' SortExpression="UserName">
                        <ItemTemplate>
                            <asp:Label ID="LabelName" runat="server" Text='<%# Bind("UserName") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText='标题' >
                        <ItemTemplate>
                            <asp:Label ID="LabelID" runat="server" Text='<%# Bind("Title") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText='<div style="width:100%;text-align :center">起始时间<span class="caret"></span></div>' SortExpression="BeginDate">
                        <ItemTemplate>
                            <asp:Label ID="LabelName" runat="server" Text='<%# Bind("BeginDate") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText='<div style="width:100%;text-align :center">结束时间<span class="caret"></span></div>' SortExpression="EndDate">
                        <ItemTemplate>
                            <asp:Label ID="LabelDepart" runat="server" Text='<%# Bind("EndDate") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText='<div style="width:100%;text-align :center">申请时间<span class="caret"></span></div>' SortExpression="ApplyDate">
                        <ItemTemplate>
                            <asp:Label ID="LabelDepart" runat="server" Text='<%# Bind("ApplyDate") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText='请假单状态' >
                        <ItemTemplate>
                            <asp:Label ID="LabelStatus" runat="server" Text='<%# Bind("statusname") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="" ShowHeader="False">
                        <ItemTemplate>
                            <asp:Button ID="ImageButonEdit" runat="server" Text="修改" CssClass="templatemo-edit-btn ImageButonEdit" BackColo="white" OnClientClick=" return false;" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <HeaderStyle BackColor="#39ADB4" CssClass="white-text templatemo-sort-by" ForeColor="White" />
                <PagerSettings Mode="Numeric" />

                <PagerTemplate>
                    <div class="row form-group" >
                        <div class="col-lg-3 col-md-1 form-group">
                        </div>
                        <div class="col-lg-1 col-md-1 form-group" style="padding-top:10px">
                            <asp:LinkButton ID="btnFirst" runat="server" Text="首页" OnClick="btnFirst_Click" />
                        </div>
                        <div class="col-lg-1 col-md-1 form-group" style="padding-top:10px">
                            <asp:LinkButton ID="btnPrev" runat="server" Text="上一页" OnClick="btnPrev_Click" />
                        </div>
                        <div class="col-lg-2 col-md-2 form-group" style="padding-top:3px">
                            <asp:DropDownList ID="ddlIndex" runat="server" OnSelectedIndexChanged="ddlIndex_SelectedIndexChanged" AutoPostBack="True" CssClass="form-control" Width="130px"></asp:DropDownList>
                        </div>
                        <div class="col-lg-1 col-md-1 form-group" style="padding-top:10px">
                            <asp:LinkButton ID="btnNext" runat="server" Text="下一页" OnClick="btnNext_Click" />
                        </div>
                        <div class="col-lg-1 col-md-1 form-group" style="padding-top:10px">
                            <asp:LinkButton ID="btnLast" runat="server" Text="末页" OnClick="btnLast_Click" />
                        </div>
                    </div>
                </PagerTemplate>
            </asp:GridView>


        </div>
    </div>
</asp:Content>

<asp:Content ID="Hide" ContentPlaceHolderID="ContentPlaceHolderHide" runat="server">
    <div id="divaddout" class="panel panel-default margin-10 TipBox" style="display: none">
        <div class="panel-heading" runat="server">
            <h2 class="text-uppercase"><+>添加用户</h2>
        </div>
        <div class="panel-body" runat="server">
            <div class="row form-group">
                <div class="col-lg-6 col-md-6 form-group">
                    <label for="inputFirstName"><span style='color: red;'>*</span>用户ID：</label>
                    <asp:TextBox ID="tnid" runat="server" class="form-control"></asp:TextBox>
                </div>
                <div class="col-lg-6 col-md-6 form-group">
                    <label for="inputLastName"><span style='color: red;'>*</span>用户姓名：</label>
                    <asp:TextBox ID="tnname" runat="server" class="form-control"></asp:TextBox>
                </div>
            </div>
            <div class="row form-group">
                <div class="col-lg-6 col-md-6 form-group">
                    <label for="inputFirstName"><span style='color: red;'>*</span>用户类型：</label>
                    <asp:DropDownList ID="drpdename" runat="server" class="form-control">
                        <asp:ListItem Value="-1">--请选择--</asp:ListItem>
                        <asp:ListItem Value="0">员工</asp:ListItem>
                        <asp:ListItem Value="1">主管</asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="col-lg-6 col-md-6 form-group">
                    <label for="inputLastName">所属部门：</label>
                    <asp:DropDownList ID="drponame" runat="server" class="form-control">
                    </asp:DropDownList>
                </div>
            </div>
            <div class="row form-group">
                <div class="col-lg-12 col-md-10 form-group">
                    <label for="inputFirstName">手机：</label>
                    <asp:TextBox ID="txttel0" runat="server" class="form-control"></asp:TextBox>
                </div>
            </div>
            <div class="row form-group" style="text-align: center;">
                <div class="col-lg-12 col-md-12 form-group">
                    <asp:Label ID="lblbrith0" runat="server" Text="" Style="display: none; color: #d7425c"></asp:Label>
                </div>
            </div>
            <div class="form-group text-right">
                <asp:Button ID="btnin" runat="server" Text="添加新用户" OnClick="btnin_Click" CssClass="templatemo-blue-button" />
                <button class="templatemo-white-button" type="reset" onclick="TipClose()">取消</button>
            </div>
        </div>
    </div>
    <div id="diveditout" class="panel panel-default margin-10 TipBox diveditout" runat="server" style="display: none">
        <div class="panel-heading" runat="server">
            <h2 class="text-uppercase"><+>修改信息</h2>
        </div>
        <div class="panel-body" runat="server">
            <div class="row form-group">
                <div class="col-lg-6 col-md-6 form-group">
                    <label for="inputFirstName"><span style='color: red;'>*</span>用户ID：</label>
                    <asp:TextBox ID="txtId" runat="server" ReadOnly="True" class="form-control"></asp:TextBox>
                </div>
                <div class="col-lg-6 col-md-6 form-group">
                    <label for="inputLastName"><span style='color: red;'>*</span>用户姓名：</label>
                    <asp:TextBox ID="txtname" runat="server" class="form-control"></asp:TextBox>
                </div>
            </div>
            <div class="row form-group">
                <div class="col-lg-6 col-md-6 form-group">
                    <label for="inputFirstName"><span style='color: red;'>*</span>用户类型：</label>
                    <asp:DropDownList ID="drpdenameedit" runat="server" class="form-control">
                        <asp:ListItem Value="0">员工</asp:ListItem>
                        <asp:ListItem Value="1">主管</asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="col-lg-6 col-md-6 form-group">
                    <label for="inputLastName">所属部门：</label>
                    <asp:DropDownList ID="drponameedit" runat="server" class="form-control">
                    </asp:DropDownList>
                </div>
            </div>
            <div class="row form-group">
                <div class="col-lg-12 col-md-10 form-group">
                    <label for="inputFirstName">手机：</label>
                    <asp:TextBox ID="txttel" runat="server" class="form-control"></asp:TextBox>
                </div>
            </div>
            <div class="row form-group" style="text-align: center;">
                <div class="col-lg-12 col-md-12 form-group">
                    <asp:Label ID="lblbrith" runat="server" Text="" Style="display: none; color: #d7425c"></asp:Label>
                </div>
            </div>
            <div class="form-group text-right">
                <asp:Button ID="btnedit" runat="server" Text="确认修改" OnClick="btnedit_Click" CssClass="templatemo-blue-button" />
                <button class="templatemo-white-button" type="reset" onclick="TipClose()">取消</button>
            </div>
        </div>
    </div>

    <div id="exitout" class="templatemo-content-widget pink-bg MessageBox" style="display: none">
        <i class="fa fa-times" onclick="TipClose()"></i>
        <h2 class="text-uppercase margin-bottom-10">&lt;!&gt;注意</h2>
        <p class="margin-bottom-0">此操作无法撤销,确定要删除勾选的用户吗？ </p>
        <div class=" text-right" style="margin-top: 40px;">
            <div class="col-lg-12 col-md-12 form-group">
                <asp:Button ID="yesexit" runat="server" Text="删除" class="templatemo-white-button" Style="border: 0px; color: #D7425C" OnClick="btndelete_Click" />
            </div>
        </div>
    </div>
    <div id="addoutc" class="out"></div>
    <div id="editoutc" class="out"></div>

    <asp:HiddenField runat="server" ID="editId" Value="" />
</asp:Content>
