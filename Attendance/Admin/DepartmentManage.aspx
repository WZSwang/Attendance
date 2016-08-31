<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="DepartmentManage.aspx.cs" Inherits="Attendance.Admin.DepartmentManage" %>

<asp:Content ID="head" ContentPlaceHolderID="head" runat="server">
    <title>Attendance - Depart</title>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#<%=btnin.ClientID %>").click(function () {
                var NUM = document.getElementById("<% =tnid.ClientID%>").value;
                if (NUM == "") {
                    document.getElementById("<%=lblbrith0.ClientID %>").style.display = "block";
                    document.getElementById("<%=lblbrith0.ClientID %>").innerText = "请输入部门名称";
                    return false;
                }

                $.ajax({
                    type: "Post",
                    url: "DepartmentManage.aspx/GetStr",
                    async: false,
                    //方法传参的写法一定要对，str为形参的名字,str2为第二个形参的名字   
                    data: "{'str':'" + NUM + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) {
                        //返回的数据用data.d获取内容   
                        if (data.d == "true") {
                            document.getElementById("<%=lblbrith0.ClientID %>").style.display = "block";
                            document.getElementById("<%=lblbrith0.ClientID %>").innerText = "已经存在的部门名称,请更换";
                        }
                        else
                            document.getElementById("<%=lblbrith0.ClientID %>").innerText = " ";
                    },
                    error: function (err) {
                        alert(err);
                    }
                });

                if (document.getElementById("<%=lblbrith0.ClientID %>").innerText == "已经存在的部门名称,请更换")
                    return false;
                //禁用按钮的提交   
                return true;
            });

            $(".ImageButonEdit").click(function () {
                //display
                $("#<%=diveditout.ClientID %>").fadeIn(500);
                $("#editoutc").fadeIn(500);

                //getelement
                var obj = event.srcElement;
                while (obj.tagName != "TR") {
                    obj = obj.parentElement;
                }
                var depart = obj.children[1].innerText;
                document.getElementById("<%=DepartName.ClientID%>").value = obj.children[1].innerText.trim();
                document.getElementById("<%=txtId.ClientID%>").value = obj.children[1].innerText.trim();

                document.getElementById("<%=drpdenameedit.ClientID %>").options[0].selected = true;
                for (var i = 0; i < document.getElementById("<%=drpdenameedit.ClientID %>").options.length; i++) {
                    if (document.getElementById("<%=drpdenameedit.ClientID %>").options[i].text == obj.children[2].innerText.trim())
                        document.getElementById("<%=drpdenameedit.ClientID %>").options[i].selected = true;
                }
                $.ajax({
                    type: "Post",
                    url: "DepartmentManage.aspx/DepartInfos",
                    async: false,
                    data: "{'str':'" + depart + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) {
                        //返回的数据用data.d获取内容   
                        document.getElementById("<%=TxtEditInfo.ClientID %>").value = data.d;
                    },
                    error: function (err) {
                        alert(err);
                    }
                });
                document.getElementById("<%=lblbrith.ClientID %>").style.display = "none";
                return true;
            });

            $("#<%=btnedit.ClientID %>").click(function () {
                var NUM = document.getElementById("<% =txtId.ClientID%>").value;

                if (NUM == "") {
                    document.getElementById("<%=lblbrith.ClientID %>").style.display = "block";
                    document.getElementById("<%=lblbrith.ClientID %>").innerText = "请输入部门名称";
                    return false;
                }
                if (NUM == document.getElementById("<%=DepartName.ClientID%>").value)
                    return true;

                $.ajax({
                    type: "Post",
                    url: "DepartmentManage.aspx/GetStr",
                    async: false,
                    //方法传参的写法一定要对，str为形参的名字,str2为第二个形参的名字   
                    data: "{'str':'" + NUM + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) {
                        //返回的数据用data.d获取内容   
                        if (data.d == "true") {
                            document.getElementById("<%=lblbrith.ClientID %>").style.display = "block";
                            document.getElementById("<%=lblbrith.ClientID %>").innerText = "已经存在的部门名称,请更换";
                        }
                        else
                            document.getElementById("<%=lblbrith.ClientID %>").innerText = " ";
                    },
                    error: function (err) {
                        alert(err);
                    }
                });

                if (document.getElementById("<%=lblbrith.ClientID %>").innerText == "已经存在的部门名称,请更换")
                    return false;

                //禁用按钮的提交   
                return true;
            });

            $("#btnadd").click(function () {
                $("#addoutc").fadeIn(500);
                $("#divaddout").fadeIn(500);
            });
            $(".ImageButonDelete").click(function () {
                var obj = event.srcElement;
                while (obj.tagName != "TR") {
                    obj = obj.parentElement;
                }
                document.getElementById("<%=DepartName.ClientID%>").value = obj.children[1].innerText;
                $("#exitout").fadeIn(500);
                $("#addoutc").fadeIn(500);
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


<asp:Content ID="main" ContentPlaceHolderID="ContentPlaceHolderMain" runat="server">
    <div class="templatemo-content-widget white-bg">
        <h2 class="text-uppercase">搜索 / 添加</h2>
        <div class="panel-body">
            <div class="templatemo-flex-row flex-content-row">
                <div class="col-1">
                    <div id="timeline_div" class="templatemo-chart"></div>
                    <div class="col-lg-1 col-md-12  form-group">
                    </div>
                    <div class="col-lg-4 col-md-3 form-group">
                        <asp:TextBox ID="TxtSearchID" runat="server" CssClass="form-control" placeholder="请输入部门名称" Style="float: left"></asp:TextBox>
                    </div>
                    <div class="col-lg-4 col-md-3 form-group">
                        <asp:DropDownList ID="drpManage" runat="server" CssClass="form-control" Style="float: left"></asp:DropDownList>
                    </div>
                    <div class="col-lg-3 col-md-12  form-group">
                        <asp:Button ID="btnSearch" runat="server" Text="搜索" CssClass="templatemo-blue-button"
                            OnClick="btnSearch_Click" />
                    </div>
                </div>

            </div>
            <input id="btnadd" type="button" value='添加新部门' class="templatemo-blue-button" />
        </div>
    </div>

    <div class="templatemo-content-widget no-padding">
        <div class="panel panel-default table-responsive">
            <asp:GridView ID="gdvinfo" CssClass="table table-striped table-bordered templatemo-user-table gdvinfo" runat="server"
                AutoGenerateColumns="False" OnRowDataBound="gdvinfo_RowDataBound" AllowPaging="True" Style="text-align: center" OnPageIndexChanging="gdvinfo_PageIndexChanging">
                <EmptyDataTemplate>
                    <div style="text-align: center">没有查询到数据，请检查查询条件是否正确</div>
                </EmptyDataTemplate>
                <Columns>
                    <asp:TemplateField HeaderText='<div style="width:100%;text-align :center">序号</div>' InsertVisible="False">
                        <ItemStyle HorizontalAlign="Center" />
                        <HeaderStyle HorizontalAlign="Center" />
                        <ItemTemplate>
                            <asp:Label ID="LabelNum" runat="server" Text='<%# this.gdvinfo.PageIndex * this.gdvinfo.PageSize + this.gdvinfo.Rows.Count + 1%>' />
                        </ItemTemplate>
                        <HeaderStyle CssClass="white-text templatemo-sort-by" ForeColor="White" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText='<div style="width:100%;text-align :center">部门名称</div>'>
                        <ItemTemplate>
                            <asp:Label ID="LabelDeptName" runat="server" Text='<%# Bind("DeptName") %>'></asp:Label>
                        </ItemTemplate>
                        <HeaderStyle CssClass="white-text templatemo-sort-by" ForeColor="White" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText='<div style="width:100%;text-align :center">主管</div>'>
                        <ItemTemplate>
                            <asp:Label ID="LabelName" runat="server" Text='<%# Bind("UserName") %>'></asp:Label>
                        </ItemTemplate>
                        <HeaderStyle CssClass="white-text templatemo-sort-by" ForeColor="White" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="" ShowHeader="False">
                        <ItemTemplate>
                            <asp:Button ID="ImageButonEdit" runat="server" Text="修改" CssClass="templatemo-edit-btn ImageButonEdit" OnClientClick=" return false;" />
                            <asp:Button ID="ImageButonDelete" runat="server" Text="删除" CssClass="templatemo-edit-btn ImageButonDelete" OnClientClick=" return false;" Visible="false" />
                        </ItemTemplate>
                        <ControlStyle BorderStyle="None" Height="30px" Width="50px" />
                    </asp:TemplateField>
                </Columns>
                <HeaderStyle BackColor="#39ADB4" VerticalAlign="Middle" />
                <PagerSettings Mode="NumericFirstLast" />

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
    </div>

</asp:Content>
<asp:Content ID="Hide" ContentPlaceHolderID="ContentPlaceHolderHide" runat="server">
    <div id="divaddout" class="panel panel-default margin-10 TipBox" style="display: none">
        <div class="panel-heading" runat="server">
            <h2 class="text-uppercase">添加新部门</h2>
        </div>
        <div class="panel-body" runat="server">
            <div class="row form-group">
                <div class="col-lg-12 col-md-6 form-group">
                    <label for="inputFirstName"><span style='color: red;'>*</span>部门名称：</label>
                    <asp:TextBox ID="tnid" runat="server" class="form-control"></asp:TextBox>
                </div>
                <div class="col-lg-12 col-md-6 form-group">
                    <label for="inputLastName">主管：</label>
                    <asp:DropDownList ID="drpdename" runat="server" class="form-control">
                    </asp:DropDownList>
                </div>
            </div>
            <div class="row form-group">
                <div class="col-lg-12 col-md-10 form-group">
                    <label for="inputFirstName">部门说明：</label>
                    <asp:TextBox ID="TxtInfo" runat="server" class="form-control" Rows="3"></asp:TextBox>
                </div>
            </div>
            <div class="row form-group" style="text-align: center;">
                <div class="col-lg-12 col-md-12 form-group">
                    <asp:Label ID="lblbrith0" runat="server" Text="" Style="display: none; color: #d7425c"></asp:Label>
                </div>
            </div>
            <div class="form-group text-right">
                <asp:Button ID="btnin" runat="server" Text="添加新部门" OnClick="btnin_Click" CssClass="templatemo-blue-button" />
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
                <div class="col-lg-12 col-md-6 form-group">
                    <label for="inputFirstName"><span style='color: red;'>*</span>部门名称：</label>
                    <asp:TextBox ID="txtId" runat="server" class="form-control"></asp:TextBox>
                </div>
                <div class="col-lg-12 col-md-6 form-group">
                    <label for="inputLastName">主管：</label>
                    <asp:DropDownList ID="drpdenameedit" runat="server" class="form-control">
                    </asp:DropDownList>
                </div>
            </div>
            <div class="row form-group">
                <div class="col-lg-12 col-md-10 form-group">
                    <label for="inputFirstName">部门说明：</label>
                    <asp:TextBox ID="TxtEditInfo" runat="server" class="form-control" Rows="3"></asp:TextBox>
                </div>
            </div>
            <div class="row form-group" style="text-align: center;">
                <div class="col-lg-12 col-md-12 form-group">
                    <asp:Label ID="lblbrith" runat="server" Text="" Style="display: none; color: #d7425c"></asp:Label>
                </div>
            </div>
            <div class="form-group text-right">
                <asp:Button ID="btnedit" runat="server" Text="确认修改" CssClass="templatemo-blue-button" OnClick="btnedit_Click" />
                <button class="templatemo-white-button" type="reset" onclick="TipClose()">取消</button>
            </div>
        </div>
    </div>

    <div id="addoutc" class="out"></div>
    <div id="editoutc" class="out"></div>

    <div id="exitout" class="templatemo-content-widget pink-bg MessageBox" style="display: none">
        <i class="fa fa-times" onclick="TipClose()"></i>
        <h2 class="text-uppercase margin-bottom-10">&lt;!&gt;注意</h2>
        <p class="margin-bottom-0">此操作无法撤销,确定要删除选择的部门吗？ </p>
        <div class=" text-right" style="margin-top: 40px;">
            <div class="col-lg-12 col-md-12 form-group">
                <asp:Button ID="yesexit" runat="server" Text="删除" class="templatemo-white-button" Style="border: 0px; color: #D7425C" OnClick="btndelete_Click" />
            </div>
        </div>
    </div>

    <asp:HiddenField ID="DepartName" runat="server" />
    <asp:Label ID="LabelCurrentPage" runat="server" Text="<%# ((GridView)Container.NamingContainer).PageIndex + 1 %>"></asp:Label>
    <asp:Label ID="LabelPageCount" runat="server" Text="<%# ((GridView)Container.NamingContainer).PageCount %>"></asp:Label>
    <asp:HiddenField ID="pagechange" runat="server" />
</asp:Content>
