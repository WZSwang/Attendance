<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="AttendanceManage.aspx.cs" Inherits="Attendance.Manage.AttendanceManage" %>

<asp:Content ID="Head" ContentPlaceHolderID="head" runat="server">
    <title>Attendance - Check</title>
    <script type="text/javascript">
        $(function () {
            $(".ImageButonEdit").click(function () {
                //display
                $(".TipBox").fadeIn(500);
                $("#addoutc").fadeIn(500);

                //getelement
                var obj = event.srcElement;
                while (obj.tagName != "TR") {
                    obj = obj.parentElement;
                }
                var depart = obj.children[1].innerText;
                document.getElementById("<%=hidUser.ClientID%>").value = obj.children[1].innerText.trim();
                return false;
             });
            $("#addoutc").click(function () {
                $("#addoutc").fadeOut(500);
                $("#exitout").fadeOut(500);
                $("#divaddout").fadeOut(500);
            });
            $(".TipClose").click(function () {
                $("#addoutc").fadeOut(500);
                $("#divaddout").fadeOut(500);
                $(".diveditout").fadeOut(500);
                $("#editoutc").fadeOut(500);
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
                    <div id="timeline_div" class="templatemo-chart"></div>
                    <div class="col-lg-1 col-md-12  form-group">
                    </div>
                    <div class="col-lg-8">
                        <!-- <input type="file" name="fileToUpload" id="fileToUpload" class="margin-bottom-10"> -->
                        <input type="file" name="fileToUpload" id="fileToUpload" class="filestyle" data-buttonname="btn-primary" data-buttonbefore="true" data-icon="false">
                        <p>支持的最大文件大小为 5 MB.</p>
                    </div>
                    <div class="col-lg-3 col-md-12  form-group">
                        <asp:Button ID="btnAdd" runat="server" Text="导入" CssClass="templatemo-blue-button" />
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

                <PagerTemplate>
                    <div class="row form-group">
                        <div class="col-lg-3 col-md-1 form-group">
                        </div>
                        <div class="col-lg-1 col-md-1 form-group" style="padding-top: 10px">
                            <asp:LinkButton ID="btnFirst" runat="server" Text="首页" OnClick="btnFirst_Click" />
                        </div>
                        <div class="col-lg-1 col-md-1 form-group" style="padding-top: 10px">
                            <asp:LinkButton ID="btnPrev" runat="server" Text="上一页" OnClick="btnPrev_Click" />
                        </div>
                        <div class="col-lg-2 col-md-2 form-group" style="padding-top: 3px">
                            <asp:DropDownList ID="ddlIndex" runat="server" OnSelectedIndexChanged="ddlIndex_SelectedIndexChanged" AutoPostBack="True" CssClass="form-control" Width="130px"></asp:DropDownList>
                        </div>
                        <div class="col-lg-1 col-md-1 form-group" style="padding-top: 10px">
                            <asp:LinkButton ID="btnNext" runat="server" Text="下一页" OnClick="btnNext_Click" />
                        </div>
                        <div class="col-lg-1 col-md-1 form-group" style="padding-top: 10px">
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
            <h2 class="text-uppercase">查看考勤</h2>
        </div>
        <div class="panel-body" runat="server">
            <div class="templatemo-flex-row flex-content-row">
                <div class="col-1">
                    <div class="col-lg-1 col-md-12  form-group">
                    </div>
                    <div id="timeline_div" class="templatemo-chart"></div>
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
                    <div class="col-lg-1 col-md-12  form-group">
                       
                    </div>
                    <div class="col-lg-2 col-md-12  form-group text-right" style="padding-top: 10px;">
                        <asp:Label ID="LabTip" runat="server" Text='<i class="fa fa-check "></i>保存成功！' Visible="false"></asp:Label>
                    </div>
                </div>

            </div>
        </div>
    </div>

    <asp:HiddenField ID="hidUser" runat="server" />
    <div id="addoutc" class="out"></div>
</asp:Content>
