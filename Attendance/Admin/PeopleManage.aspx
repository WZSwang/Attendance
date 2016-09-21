<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="PeopleManage.aspx.cs" Inherits="Attendance.PeropleManage" %>

<%@ Register Src="~/UserControl/ControlTemplate.ascx" TagPrefix="uc1" TagName="ControlTemplate" %>


<asp:Content ID="Head" ContentPlaceHolderID="head" runat="server">
    <title>Attendance - People</title>

    <style type="text/css">
        td.selected {
            background-color: #FEF2E8;
        }
    </style>
</asp:Content>

<asp:Content ID="Main" ContentPlaceHolderID="ContentPlaceHolderMain" runat="server">
    <div class="templatemo-content-widget white-bg">
        <h2 class="text-uppercase">搜索 / 添加 / 删除</h2>
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
            <input id="btndelete" type="button" value="删除" class="templatemo-blue-button" />
        </div>
    </div>

    <div class="templatemo-content-widget no-padding">
        <div class="panel panel-default table-responsive">
            <asp:GridView ID="gdvinfo" CssClass="table table-striped table-bordered templatemo-user-table gdvinfo" runat="server" AutoGenerateColumns="False" AllowSorting="True"
                AllowPaging="True" OnRowDataBound="gdvinfo_RowDataBound" OnSorting="gdvinfo_Sorting" Style="text-align: center" AllowCustomPaging="True">
                <EmptyDataTemplate>
                    <div style="text-align: center">没有查询到数据，请检查查询条件是否正确</div>
                </EmptyDataTemplate>
                <Columns>
                    <asp:TemplateField HeaderText='<div style="width:100%;text-align :center">序号</div>' InsertVisible="False">
                        <ItemStyle />
                        <ItemTemplate>
                            <asp:Label ID="Label2" runat="server" Text='<%# this.gdvinfo.PageIndex * this.gdvinfo.PageSize + this.gdvinfo.Rows.Count + 1%>' />
                        </ItemTemplate>
                        <HeaderStyle CssClass="white-text templatemo-sort-by" ForeColor="White"></HeaderStyle>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="TemplateField" FooterText="qq">
                        <HeaderTemplate>
                            <div style="width: 100%; text-align: center">
                                <asp:CheckBox ID="CheckBoxHead" runat="server" OnCheckedChanged="CheckBoxHead_CheckedChanged" AutoPostBack="True" Text="<span></span>" />
                            </div>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:CheckBox ID="CheckBoxList" runat="server" Text="<span></span>" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText='<div style="width:100%;text-align :center">用户ID<span class="caret"></span></div>' SortExpression="UserId">
                        <ItemTemplate>
                            <asp:Label ID="LabelID" runat="server" Text='<%# Bind("UserId") %>'></asp:Label>
                        </ItemTemplate>
                        <HeaderStyle CssClass="white-text templatemo-sort-by" ForeColor="White" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText='<div style="width:100%;text-align :center">用户姓名<span class="caret"></span></div>' SortExpression="UserName">
                        <ItemTemplate>
                            <asp:Label ID="LabelName" runat="server" Text='<%# Bind("UserName") %>'></asp:Label>
                        </ItemTemplate>
                        <HeaderStyle CssClass="white-text templatemo-sort-by" ForeColor="White" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText='<div style="width:100%;text-align :center">所属部门<span class="caret"></span></div>' SortExpression="DeptName">
                        <ItemTemplate>
                            <asp:Label ID="LabelDepart" runat="server" Text='<%# Bind("DeptName") %>'></asp:Label>
                        </ItemTemplate>
                        <HeaderStyle CssClass="white-text templatemo-sort-by" ForeColor="White" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="" ShowHeader="False">
                        <ItemTemplate>
                            <asp:Button ID="ImageButonEdit" runat="server" Text="修改" CssClass="templatemo-edit-btn ImageButonEdit" BackColo="white" OnClientClick=" return false;" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <HeaderStyle BackColor="#39ADB4" />
                <PagerSettings Mode="Numeric" />

            </asp:GridView>
            <uc1:ControlTemplate runat="server" ID="ControlTemplate" OnDateBind="Bind"  />

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

<asp:Content ID="script" ContentPlaceHolderID="Script" runat="server">
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
            $(".gdvinfo>tbody>tr>td:gt(0):has(:checked)").parent().find("td").addClass("selected");
            $(".gdvinfo>tbody>tr:gt(0):lt(10)").click(function () {
                if ($(this).find(":checkbox").attr("checked")) {
                    $(this).find("td").removeClass("selected")
                     .end().find(":checkbox").attr("checked", false);
                } else {
                    $(this).find("td").addClass("selected")
                   .end().find(":checkbox").attr("checked", true);
                }
            });
            $(":checkbox").click(function () {
                $("")
                $(this).parents("tr").trigger("click");
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
</asp:Content>
