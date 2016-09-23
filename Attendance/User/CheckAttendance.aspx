<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="CheckAttendance.aspx.cs" Inherits="Attendance.User.CheckAttendance" %>

<asp:Content ID="Head" ContentPlaceHolderID="head" runat="server">
    <title>Attendance - DateSet</title>
</asp:Content>
<asp:Content ID="Main" ContentPlaceHolderID="ContentPlaceHolderMain" runat="server">
    <div class="templatemo-content-widget white-bg">
        <h2 class="text-uppercase">查看 / 设置</h2>
        <div class="panel-body">
            <div class="templatemo-flex-row flex-content-row">
                <div class="col-1">
                    <div class="col-lg-1 col-md-12  form-group">
                    </div>
                    <div id="timeline_div" class="templatemo-chart"></div>
                    <div class="col-lg-2 col-md-3 form-group">
                        <asp:DropDownList ID="DropDownListYear" runat="server" CssClass="form-control">
                        </asp:DropDownList>
                    </div>
                    <div class="col-lg-1 col-md-1  form-group" style=" padding-top: 10px;">
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
                    <div class="col-lg-2 col-md-3 form-group">
                        <asp:DropDownList ID="DropDownList1" runat="server" CssClass="form-control">
                            <asp:ListItem>列表展示</asp:ListItem>
                            <asp:ListItem>日历展示</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="col-lg-2 col-md-12  form-group">
                        <asp:Button ID="BtnShow" runat="server" Text="查看" class="templatemo-blue-button" OnClick="BtnShow_Click" />
                    </div>
                </div>

            </div>
        </div>
    </div>

    <div class="templatemo-content-widget no-padding">
        <div class="panel panel-default table-responsive">
            <asp:GridView ID="gdvinfo" CssClass="table table-striped table-bordered templatemo-user-table gdvinfo" runat="server" AutoGenerateColumns="False" AllowSorting="True"
                GridLines="None"  OnRowDataBound="gdvinfo_RowDataBound">
                <EmptyDataTemplate>
                    <div style="text-align: center">请选择日期并点击显示按钮</div>
                </EmptyDataTemplate>
                <Columns>
                    <asp:BoundField DataField="Date" HeaderText="日期" DataFormatString="{0:yyyy-MM-dd}" />
                    <asp:BoundField HeaderText="星期" />
                    <asp:BoundField DataField="First" HeaderText="首次打卡时间"  />
                    <asp:BoundField DataField="Last" HeaderText="最后打卡时间"   />
                    <asp:BoundField HeaderText="考勤状态" DataField="Status"/>
                </Columns>
                <HeaderStyle CssClass="white-text templatemo-sort-by" ForeColor="White"></HeaderStyle>
                <HeaderStyle BackColor="#39ADB4" VerticalAlign="Middle" />
                <PagerSettings Mode="NumericFirstLast" />
            </asp:GridView>
            <asp:Calendar ID="Calinfo" runat="server"  CssClass="table table-striped table-bordered templatemo-user-table" FirstDayOfWeek="Monday" SelectionMode="None" ShowNextPrevMonth="False" ShowTitle="False" Height="500px" OnDayRender="Calinfo_DayRender" BorderStyle="None">
                <DayHeaderStyle  CssClass="white-text templatemo-sort-by" ForeColor="White" BackColor="#39ADB4" Height="35px"/>
            </asp:Calendar>

        </div>
    </div>
</asp:Content>
<asp:Content ID="Hide" ContentPlaceHolderID="ContentPlaceHolderHide" runat="server">
</asp:Content>
