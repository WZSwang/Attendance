<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="PeropleManage.aspx.cs" Inherits="Attendance.PeropleManage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="../Styles/MainBody.css" type="text/css" />
    <link rel="stylesheet" href="../Styles/PeropleManage.css" type="text/css" />
    <script src="../Scripts/jquery-1.4.1.js" type="text/javascript"></script>
    <script type="text/javascript">

        $(document).ready(function () {
            $(".gdvinfo>tbody>tr>td:gt(0):has(:checked)").parent().find("td").addClass("selected");
            $(".gdvinfo>tbody>tr:gt(0)").click(function () {
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
        })


        $(function () {
            $(".ImageButonEdit").click(function () {
                //display
                $("#<%=diveditout.ClientID %>").fadeIn(500);
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
                    if (document.getElementById("<%=drponameedit.ClientID %>").options[i].text == obj.children[4].innerText)
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
                    document.getElementById("<%=lblbrith0.ClientID %>").innerText = "请输入用户类型";
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
                $("#<%=diveditout.ClientID %>").fadeOut(500);
            });
            $(".TipClose").click(function () {
                $("#addoutc").fadeOut(500);
                $("#divaddout").fadeOut(500);
                $("#<%=diveditout.ClientID %>").fadeOut(500);
                $("#editoutc").fadeOut(500);
            });
            $("#btndelete").click(function () {
                $("#exitout").fadeIn(500);
                $("#addoutc").fadeIn(500);
            });
            $("#noexit").click(function () {
                $("#exitout").fadeOut(500);
                $("#addoutc").fadeOut(500);
            });



        });
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

    </script>


    <style type="text/css">
        td.selected {
            background-color: #FEF2E8;
        }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderMain" runat="server">
    <div class="MainBox">
        <table id="rightTable">
            <tr>
                <td class=" searchUI">
                    <p class="searchLab">用户ID：</p>
                    <asp:TextBox ID="TxtSearchID" runat="server" CssClass="searchText"></asp:TextBox>
                    <p class="searchLab">用户名：</p>
                    <asp:TextBox ID="TxtSearchName" runat="server" CssClass="searchText"></asp:TextBox>
                    <p class="searchLab">部门：</p>
                    <asp:Panel ID="PanelCheckList" runat="server" Width="50%" Style="float: left;" Wrap="False"></asp:Panel>
                </td>
                <td>
                    <asp:Button ID="btnSearch" runat="server" Text="搜索" CssClass="searchBtn"
                        OnClick="btnSearch_Click" onmouseover="over(this)" onmouseout="out(this)" />
                </td>
            </tr>
            <tr>
                <td style="text-align: left;">
                    <input id="btnadd" type="button" value="添加" class="Btn" onmouseover="over(this)" onmouseout="out(this)" />
                    <input id="btndelete" type="button" value="删除" class="Btn" onmouseover="over(this)" onmouseout="out(this)" />
                </td>
            </tr>
        </table>
        <asp:GridView ID="gdvinfo" CssClass="gdvinfo" runat="server" AutoGenerateColumns="False" PageSize="10" AllowSorting="True"
            AllowPaging="True" OnRowDataBound="gdvinfo_RowDataBound" GridLines="None" OnSorting="gdvinfo_Sorting"
            OnPageIndexChanging="gdvinfo_PageIndexChanging">
            <EmptyDataTemplate>
                <div style="text-align: center">没有查询到数据，请检查查询条件是否正确</div>
            </EmptyDataTemplate>
            <Columns>
                <asp:TemplateField HeaderText="序号" InsertVisible="False">
                    <ItemStyle HorizontalAlign="Center" />
                    <HeaderStyle HorizontalAlign="Center" />
                    <ItemTemplate>
                        <asp:Label ID="Label2" runat="server" Text='<%# this.gdvinfo.PageIndex * this.gdvinfo.PageSize + this.gdvinfo.Rows.Count + 1%>' />
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="TemplateField" FooterText="qq">
                    <HeaderTemplate>
                        <asp:CheckBox ID="CheckBoxHead" runat="server" OnCheckedChanged="CheckBoxHead_CheckedChanged" AutoPostBack="True" />
                    </HeaderTemplate>
                    <ItemTemplate>
                        <asp:CheckBox ID="CheckBoxList" runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="UserId" HeaderText="用户ID" SortExpression="UserId" />
                <asp:BoundField DataField="UserName" HeaderText="用户姓名" SortExpression="UserName" />
                <asp:BoundField DataField="DeptName" HeaderText="所属部门 " SortExpression="DeptName" />
                <asp:TemplateField HeaderText="" ShowHeader="False">
                    <ItemTemplate>
                        <asp:ImageButton ID="ImageButonEdit" class="ImageButonEdit" runat="server" CausesValidation="false"
                            CommandName="update" ImageUrl="~/Images/edit.png" Text="编辑" OnClientClick=" return false;" />
                    </ItemTemplate>
                    <ControlStyle BorderStyle="None" Height="30px" Width="50px" CssClass="ImageButonEdit" />
                </asp:TemplateField>
            </Columns>
            <HeaderStyle BackColor="#34495E" BorderColor="Black" BorderStyle="None" Font-Size="15pt"
                ForeColor="White" Height="40px" />
            <PagerSettings Mode="NumericFirstLast" />
            <RowStyle BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="0px"
                ForeColor="Black" HorizontalAlign="Center" VerticalAlign="Middle" />

            <%--(3) 首页、上一页、下一页、尾页--%>
            <%-- http://liyuehui5205.blog.163.com/blog/static/6603115120075141364264/--%>
            <PagerTemplate>
                <asp:LinkButton ID="btnFirst" runat="server" CommandArgument="First" CommandName="Page" Text="首页" Enabled="<%# this.gdvinfo.PageIndex > 0 %>" />
                <asp:LinkButton ID="btnPrev" runat="server" CommandArgument="Prev" CommandName="Page" Text="上一页" Enabled="<%# this.gdvinfo.PageIndex > 0 %>" />
                <asp:LinkButton ID="btnNext" runat="server" CommandArgument="Next" CommandName="Page" Text="下一页" Enabled="<%# this.gdvinfo.PageIndex < this.gdvinfo.PageCount - 1 %>" />
                <asp:LinkButton ID="btnLast" runat="server" CommandArgument="Last" CommandName="Page" Text="末页" Enabled="<%# this.gdvinfo.PageIndex < this.gdvinfo.PageCount - 1 %>" />
                <asp:Label ID="Label7" runat="server" Text='<%# String.Format("{0}/{1}", this.gdvinfo.PageIndex + 1, this.gdvinfo.PageCount) %>'></asp:Label>
                <asp:TextBox ID="tbxPage" runat="server" Width="30px" Text="<%# gdvinfo.PageIndex +1%>"></asp:TextBox>
                <asp:LinkButton ID="btnGoto" runat="server" CommandName="Page" Text="Go" />
                <asp:RegularExpressionValidator ID="revPage" runat="server" ControlToValidate="tbxPage" ValidationExpression="\d+" SetFocusOnError="True" Display="Dynamic"></asp:RegularExpressionValidator>
                <asp:RangeValidator ID="rvlPage" runat="server" ControlToValidate="tbxPage" ErrorMessage="请输入正确的页数！"
                    Type="Integer" MinimumValue="1" MaximumValue="<%# this.gdvinfo.PageCount %>"
                    SetFocusOnError="True" Display="Dynamic"></asp:RangeValidator>
            </PagerTemplate>
        </asp:GridView>
    </div>

</asp:Content>

<asp:Content ID="Hide" ContentPlaceHolderID="ContentPlaceHolderHide" runat="server">
    <div id="divaddout" class="TipBox">
        <div class="TipTitle" runat="server">
            <+>添加用户
        <div class="TipClose">×</div>
        </div>
        <div class="TipMain" runat="server">
            <table id="tableadd" class="TipTable" runat="server">

                <tbody>

                    <tr>
                        <td class="TipLab">
                            <asp:Label ID="lnid" runat="server" Text="<span style='color: red; '>*</span>用户ID："></asp:Label>
                        </td>
                        <td class="TipTextBox">
                            <asp:TextBox ID="tnid" runat="server" class="TipText"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="TipLab">
                            <asp:Label ID="lnname" runat="server" Text="<span style='color: red; '>*</span>用户姓名："></asp:Label>
                        </td>
                        <td class="TipTextBox">
                            <asp:TextBox ID="tnname" runat="server" class="TipText"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="TipLab">
                            <asp:Label ID="lnpname" runat="server" Text="<span style='color: red; '>*</span>用户类型："></asp:Label>
                        </td>
                        <td class="TipTextBox">
                            <asp:DropDownList ID="drpdename" runat="server" Width="207px" Font-Names="微软雅黑"
                                Font-Size="15pt">
                                <asp:ListItem Value="-1">--请选择--</asp:ListItem>
                                <asp:ListItem Value="0">员工</asp:ListItem>
                                <asp:ListItem Value="1">主管</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td class="TipLab">
                            <asp:Label ID="lnDept" runat="server" Text="所属部门："></asp:Label>
                        </td>
                        <td class="TipTextBox">
                            <asp:DropDownList ID="drponame" runat="server" Width="207px" Font-Names="微软雅黑"
                                Font-Size="15pt">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td class="TipLab">
                            <asp:Label ID="LnPhone" runat="server" Text="手机："></asp:Label>
                        </td>
                        <td class="TipTextBox">
                            <asp:TextBox ID="txttel0" runat="server" class="TipText"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" style="text-align: center;">
                            <asp:Button ID="btnin" runat="server" Text="添加" OnClick="btnin_Click" CssClass="addBtn"
                                onmouseover="over(this)" onmouseout="out(this)" />
                            <asp:Label ID="lblbrith0" runat="server" Text="" Style="display: none"></asp:Label>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
    <div id="diveditout" class="TipBox" runat="server">
        <div class="TipTitle" runat="server">
            <+>修改信息
        <div class="TipClose">×</div>
        </div>
        <div class="TipMain" runat="server">
            <table class="TipTable" runat="server">
                <tr>
                    <td class="TipLab">
                        <asp:Label ID="Label1" runat="server" Text="<span style='color: red; '>*</span>用户ID："></asp:Label>
                    </td>
                    <td class="TipTextBox">
                        <asp:TextBox ID="txtId" runat="server" ReadOnly="True" class="TipText"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="TipLab">
                        <asp:Label ID="Label3" runat="server" Text="<span style='color: red; '>*</span>用户姓名："></asp:Label>
                    </td>
                    <td class="TipTextBox">
                        <asp:TextBox ID="txtname" runat="server" class="TipText"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="TipLab">
                        <asp:Label ID="Label4" runat="server" Text="<span style='color: red; '>*</span>用户类型："></asp:Label>
                    </td>
                    <td class="TipTextBox">
                        <asp:DropDownList ID="drpdenameedit" runat="server" Width="207px" Font-Names="微软雅黑"
                            Font-Size="15pt">
                            <asp:ListItem Value="0">员工</asp:ListItem>
                            <asp:ListItem Value="1">主管</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td class="TipLab">
                        <asp:Label ID="Label5" runat="server" Text="所属部门："></asp:Label>
                    </td>
                    <td class="TipTextBox">
                        <asp:DropDownList ID="drponameedit" runat="server" Width="207px" Font-Names="微软雅黑"
                            Font-Size="15pt">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td class="TipLab">
                        <asp:Label ID="Label6" runat="server" Text="手机："></asp:Label>
                    </td>
                    <td class="TipTextBox">
                        <asp:TextBox ID="txttel" runat="server" class="TipText"></asp:TextBox>
                    </td>
                </tr>

                <tr>
                    <td colspan="2" style="text-align: center;">
                        <asp:Button ID="btnedit" runat="server" Text="确认修改" CssClass="addBtn" OnClick="btnedit_Click"
                            onmouseover="over(this)" onmouseout="out(this)" />
                        <asp:Label ID="lblbrith" runat="server" Text="" Style="display: none"></asp:Label>
                    </td>
                </tr>
            </table>
        </div>
    </div>

    <div id="exitout" class="MessageBox">
        <div class="MessageTitle">&lt;!&gt;注意</div>
        <table style="width: 100%; height: 155px; text-align: center; font-family: 微软雅黑; font-size: 20px; color: Black;">
            <tr>
                <td colspan="2">确定要删除勾选的用户吗？</td>
            </tr>
            <tr>
                <td>
                    <asp:Button ID="yesexit" runat="server" Text="删除" class="MessageBtn" onmouseover="over(this)" onmouseout="out(this)" OnClick="btndelete_Click" />
                </td>
                <td>
                    <input id="noexit" type="button" class="MessageBtn" onmouseover="over(this)" onmouseout="out(this)" value="取消" /></td>
            </tr>
        </table>
    </div>

    <div id="addoutc" class="out"></div>
    <div id="editoutc" class="out"></div>

    <%--(1) 当前页--%>
    <asp:Label ID="LabelCurrentPage" runat="server" Text="<%# ((GridView)Container.NamingContainer).PageIndex + 1 %>"></asp:Label>
    <%--(2) 总页数--%>
    <asp:Label ID="LabelPageCount" runat="server" Text="<%# ((GridView)Container.NamingContainer).PageCount %>"></asp:Label>
    <asp:HiddenField runat="server" ID="editId" Value="" />
    <asp:HiddenField ID="pagechange" runat="server" />
</asp:Content>
