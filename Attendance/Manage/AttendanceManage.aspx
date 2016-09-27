<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="AttendanceManage.aspx.cs" Inherits="Attendance.Manage.AttendanceManage" %>

<%@ Register Src="~/UserControl/ControlTemplate.ascx" TagPrefix="uc1" TagName="ControlTemplate" %>


<asp:Content ID="Head" ContentPlaceHolderID="head" runat="server">
    <title>Attendance - Check</title>
    <script type="text/javascript">
        $(function () {
            $(".ImageButonEdit").click(function () {
                //display
                $(".TipBoxComantion").fadeIn(500);
                $(".out").fadeIn(500);

                //getelement
                var obj = event.srcElement;
                while (obj.tagName != "TR") {
                    obj = obj.parentElement;
                }
                var depart = obj.children[1].innerText;
                document.getElementById("<%=hidUser.ClientID%>").value = obj.children[1].innerText.trim();
                return false;
            });
            $(".out,#<%= BtnClose.ClientID%>").click(function () {
                $(".out").fadeOut(500);
                $(".TipBoxComantion").fadeOut(500);
            });
        });
    </script>

</asp:Content>
<asp:Content ID="Main" ContentPlaceHolderID="ContentPlaceHolderMain" runat="server">
    <div class="templatemo-content-widget white-bg">
        <h2 class="text-uppercase">导入考勤数据</h2>
        <div class="panel-body">
            <div class="templatemo-flex-row flex-content-row">
                <div class="col-1">
                    <div class="col-lg-1 col-md-12  form-group">
                    </div>
                    <div class="col-lg-7">
                        <!-- <input type="file" name="fileToUpload" id="fileToUpload" class="margin-bottom-10"> -->
                        <%--<input type="file" name="fileToUpload" id="FileUploadExcel" runat="server" class="filestyle" data-buttonname="btn-primary" data-buttonbefore="true" data-icon="false" />--%>
                        <asp:FileUpload ID="FileUploadExcel" runat="server" class="filestyle" data-buttonname="btn-primary" data-buttonbefore="true" data-icon="false" />
                        <p>支持的最大文件大小为 5 MB.</p>
                    </div>
                    <div class="col-lg-2 col-md-12  form-group">
                        <asp:Button ID="btnAdd" runat="server" Text="导入" CssClass="templatemo-blue-button" OnClick="btnAdd_Click" />
                    </div>
                    <div class="col-lg-2 col-md-12  form-group">
                        <asp:Label ID="LabTips" runat="server"></asp:Label>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="templatemo-content-widget no-padding">
        <div class="panel panel-default table-responsive">
            <asp:GridView ID="gdvinfo" CssClass="table table-striped table-bordered templatemo-user-table gdvinfo" runat="server" AutoGenerateColumns="False" AllowSorting="True"
                AllowPaging="True" PageSize="10" OnSorting="gdvinfo_Sorting" Style="text-align: center" AllowCustomPaging="True">
                <EmptyDataTemplate>
                    <div style="text-align: center">没有查询到数据，请检查是否任职部门。</div>
                </EmptyDataTemplate>
                <Columns>
                    <asp:TemplateField HeaderText='<div style="width:100%;text-align :center">序号</div>' InsertVisible="False">
                        <ItemStyle />
                        <ItemTemplate>
                            <asp:Label ID="Label2" runat="server" Text='<%# this.gdvinfo.PageIndex * this.gdvinfo.PageSize + this.gdvinfo.Rows.Count + 1%>' />
                        </ItemTemplate>
                        <HeaderStyle CssClass="white-text templatemo-sort-by" ForeColor="White"></HeaderStyle>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText='<div style="width:100%;text-align :center">用户ID<span class="caret"></span></div>' SortExpression="UserId">
                        <ItemTemplate>
                            <asp:Label ID="LabelID" runat="server" Text='<%# Bind("UserId") %>'></asp:Label>
                        </ItemTemplate>
                        <HeaderStyle CssClass="white-text templatemo-sort-by" ForeColor="White" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText='<div style="width:100%;text-align :center">用户名<span class="caret"></span></div>' SortExpression="UserName">
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
                    <asp:TemplateField HeaderText='<div style="width:100%;text-align :center">考勤信息</div>' ShowHeader="False">
                        <ItemTemplate>
                            <asp:Button ID="ImageButonEdit" runat="server" Text="查看" CssClass="templatemo-edit-btn ImageButonEdit" BackColo="white" OnClientClick=" return false;" />
                        </ItemTemplate>
                        <HeaderStyle CssClass="white-text templatemo-sort-by" ForeColor="White" />
                    </asp:TemplateField>
                </Columns>
                <HeaderStyle BackColor="#39ADB4" />
                <PagerSettings Mode="Numeric" />
            </asp:GridView>
            <uc1:ControlTemplate runat="server" ID="ControlTemplate" OnDateBind="Bind" />
        </div>
    </div>

</asp:Content>
<asp:Content ID="Hide" ContentPlaceHolderID="ContentPlaceHolderHide" runat="server">
    <div id="divaddout" class="panel panel-default margin-10 TipBoxComantion" style="display: none" runat="server">
        <div class="panel-heading" runat="server">
            <h2 class="text-uppercase">查看考勤</h2>
        </div>
        <div class="panel-body" runat="server">
            <div class="templatemo-flex-row flex-content-row">
                <div class="col-1">
                    <div class="col-lg-1 col-md-12  form-group">
                    </div>
                    <div class="col-lg-2 col-md-3 form-group">
                        <asp:DropDownList ID="DropDownListYear" runat="server" CssClass="form-control">
                        </asp:DropDownList>
                    </div>
                    <div class="col-lg-1 col-md-1  form-group" style="padding-top: 10px;">
                        年
                    </div>
                    <div class="col-lg-2 col-md-3 form-group">
                        <asp:DropDownList ID="DropDownListMonth" runat="server" CssClass="form-control">
                            <asp:ListItem>1</asp:ListItem>
                            <asp:ListItem>2</asp:ListItem>
                            <asp:ListItem>3</asp:ListItem>
                            <asp:ListItem>4</asp:ListItem>
                            <asp:ListItem>5</asp:ListItem>
                            <asp:ListItem>6</asp:ListItem>
                            <asp:ListItem>7</asp:ListItem>
                            <asp:ListItem>8</asp:ListItem>
                            <asp:ListItem>9</asp:ListItem>
                            <asp:ListItem>10</asp:ListItem>
                            <asp:ListItem>11</asp:ListItem>
                            <asp:ListItem>12</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="col-lg-1 col-md-1  form-group" style="padding-top: 10px;">
                        月
                    </div>
                    <div class="col-lg-2 col-md-12  form-group">
                        <asp:Button ID="BtnShow" runat="server" Text="显示" class="templatemo-blue-button" OnClick="BtnShow_Click" />
                    </div>
                    <div class="col-lg-2 col-md-12  form-group">
                        <asp:Button ID="BtnClose" runat="server" Text="关闭" class="templatemo-blue-button" OnClientClick="return false;" />
                    </div>


                    <div class="col-lg-12 col-md-12  form-group">
                        <div class="templatemo-content-widget no-padding">
                            <div class="panel panel-default table-responsive" style="height: 400px; overflow-y: scroll;">
                                <asp:GridView ID="gdvView" CssClass="table table-striped table-bordered templatemo-user-table gdvinfo" runat="server" AutoGenerateColumns="False" AllowSorting="True"
                                    GridLines="None" OnRowDataBound="gdvView_RowDataBound">
                                    <EmptyDataTemplate>
                                        <div style="text-align: center">请选择日期并点击显示按钮</div>
                                    </EmptyDataTemplate>
                                    <Columns>
                                        <asp:BoundField DataField="Date" HeaderText="日期" DataFormatString="{0:yyyy-MM-dd}" />
                                        <asp:BoundField HeaderText="星期" />
                                        <asp:BoundField DataField="First" HeaderText="首次打卡时间" />
                                        <asp:BoundField DataField="Last" HeaderText="最后打卡时间" />
                                        <asp:TemplateField HeaderText="考勤状态">
                                            <ItemTemplate>
                                                <%# Eval("Status") %>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                    <HeaderStyle CssClass="white-text templatemo-sort-by" ForeColor="White"></HeaderStyle>
                                    <HeaderStyle BackColor="#39ADB4" VerticalAlign="Middle" />
                                    <PagerSettings Mode="NumericFirstLast" />
                                </asp:GridView>
                            </div>
                        </div>
                    </div>

                </div>

            </div>
        </div>
    </div>

    <asp:HiddenField ID="hidUser" runat="server" />
    <div id="addoutc" class="out" runat="server"></div>
</asp:Content>
