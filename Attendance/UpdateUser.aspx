<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="UpdateUser.aspx.cs" Inherits="Attendance.UpdateUser" %>
<asp:Content ID="ContentHead" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="ContentMain" ContentPlaceHolderID="ContentPlaceHolderMain" runat="server">

    <table>

        <tr>
            <td>新密码：</td>
            <td>
                <asp:TextBox ID="TxtPass" runat="server"></asp:TextBox></td>
        </tr>
        <tr>
            <td>确认密码：</td>
            <td><asp:TextBox ID="TxtRePass" runat="server"></asp:TextBox></td>
        </tr>
        <tr>
            <td>手机：</td>
            <td><asp:TextBox ID="TxtPhone" runat="server"></asp:TextBox></td>
        </tr>
        <tr>
            <td class="2">
                <asp:Button ID="BtnSubmit" runat="server" Text="Button" /><asp:Button ID="BtnClear" runat="server" Text="Button" /></td>
        </tr>

    </table>



</asp:Content>
