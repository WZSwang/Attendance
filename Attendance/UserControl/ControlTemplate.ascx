<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ControlTemplate.ascx.cs" Inherits="Attendance.UserControl.ControlTemplate" %>

<div id="btnsearch" class="row form-group" style="width: 100%; margin-top: 10px" runat="server">
    <div class="col-lg-3 col-md-3 col-sm-2 col-xs-2  form-group">
    </div>
    <div class="col-lg-1 col-md-1 col-sm-1 col-xs-1  form-group" style="padding-top: 10px">
        <asp:LinkButton ID="btnFirst" runat="server" Text="首页" OnClick="btnFirst_Click" />
    </div>
    <div class="col-lg-1 col-md-1 col-sm-1 col-xs-1  form-group" style="padding-top: 10px">
        <asp:LinkButton ID="btnPrev" runat="server" Text="上一页" OnClick="btnPrev_Click" />
    </div>
    <div class="col-lg-2 col-md-2 col-sm-3 col-xs-4 form-group " style="padding-top: 3px;">
        <asp:DropDownList ID="ddlIndex" runat="server" OnSelectedIndexChanged="ddlIndex_SelectedIndexChanged" AutoPostBack="True" CssClass="form-control" Width="130px"></asp:DropDownList>
    </div>
    <div class="col-lg-1 col-md-1 col-sm-1 col-xs-1 form-group" style="padding-top: 10px">
        <asp:LinkButton ID="btnNext" runat="server" Text="下一页" OnClick="btnNext_Click" />
    </div>
    <div class="col-lg-1 col-md-1 col-sm-1 col-xs-1 form-group" style="padding-top: 10px">
        <asp:LinkButton ID="btnLast" runat="server" Text="末页" OnClick="btnLast_Click" />
    </div>
</div>
