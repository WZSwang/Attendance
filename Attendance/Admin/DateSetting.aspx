<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="DateSetting.aspx.cs" Inherits="Attendance.DateSetting" %>

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
                        <asp:Button ID="BtnSave" runat="server" Text="保存" class="templatemo-blue-button" OnClick="BtnSave_Click" />
                    </div>
                    <div class="col-lg-2 col-md-12  form-group text-right" style="padding-top: 10px;">
                        <asp:Label ID="LabTip" runat="server" Text='<i class="fa fa-check "></i>保存成功！' Visible="false"></asp:Label>
                    </div>
                </div>

            </div>
        </div>
    </div>

    <div class="templatemo-content-widget no-padding">
        <div class="panel panel-default table-responsive">
            <asp:GridView ID="gdvinfo" CssClass="table table-striped table-bordered templatemo-user-table gdvinfo" runat="server" AutoGenerateColumns="False" AllowSorting="True"
                GridLines="None" OnPageIndexChanging="gdvinfo_PageIndexChanging" OnRowDataBound="gdvinfo_RowDataBound">
                <EmptyDataTemplate>
                    <div style="text-align: center">请选择日期并点击显示按钮</div>
                </EmptyDataTemplate>
                <Columns>
                    <asp:BoundField DataField="Date" HeaderText="日期" DataFormatString="{0:yyyy-MM-dd}" />
                    <asp:BoundField HeaderText="星期" DataField="Week" />
                    <asp:TemplateField HeaderText="状态">
                        <ItemTemplate>
                            <asp:DropDownList ID="DropDownListState" runat="server" CssClass="form-control" Style="width: 80%">
                                <asp:ListItem Value="0">默认</asp:ListItem>
                                <asp:ListItem Value="1" style="color: red">上班</asp:ListItem>
                                <asp:ListItem Value="2" style="color: green">休假</asp:ListItem>
                            </asp:DropDownList>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <HeaderStyle BackColor="#39ADB4" VerticalAlign="Middle" />
                <PagerSettings Mode="NumericFirstLast" />
            </asp:GridView>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Hide" ContentPlaceHolderID="ContentPlaceHolderHide" runat="server">

</asp:Content>
