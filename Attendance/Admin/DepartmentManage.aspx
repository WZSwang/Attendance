<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="DepartmentManage.aspx.cs" Inherits="Attendance.Admin.DepartmentManage" %>

<asp:Content ID="head" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="../Styles/MainBody.css" type="text/css" />
    <link rel="stylesheet" href="../Styles/Department.css" type="text/css" />
</asp:Content>
<asp:Content ID="main" ContentPlaceHolderID="ContentPlaceHolderMain" runat="server">
    <div class="MainBox">
        <table id="rightTable">
            <tr class="searchUI">
                <td >
                    
                    <p class="searchLab">部门名称：</p>
                    <asp:TextBox ID="TxtSearchID" runat="server" CssClass="searchText"></asp:TextBox>
                    <p class="searchLab">主管：</p>
                    <asp:DropDownList ID="drpManage" runat="server" CssClass="searchText"></asp:DropDownList>
                    <asp:Button ID="btnSearch" runat="server" Text="搜索" CssClass="searchBtn"
                        OnClick="btnSearch_Click" onmouseover="over(this)" onmouseout="out(this)" />
                </td>

            </tr>
        </table>
        <asp:GridView ID="gdvinfo" CssClass="gdvinfo" runat="server" AutoGenerateColumns="False"
            GridLines="None">
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
                <asp:BoundField DataField="DeptName" HeaderText="部门名称" />
                <asp:BoundField DataField="UserName" HeaderText="主管" />
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
            <RowStyle BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="0px"
                ForeColor="Black" HorizontalAlign="Center" VerticalAlign="Middle" />

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
    <asp:Label ID="LabelCurrentPage" runat="server" Text="<%# ((GridView)Container.NamingContainer).PageIndex + 1 %>"></asp:Label>
    <asp:Label ID="LabelPageCount" runat="server" Text="<%# ((GridView)Container.NamingContainer).PageCount %>"></asp:Label>

</asp:Content>
