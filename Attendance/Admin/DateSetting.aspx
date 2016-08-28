<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="DateSetting.aspx.cs" Inherits="Attendance.DateSetting" %>

<asp:Content ID="head" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="../Styles/MainBody.css" type="text/css" />
    <script src="../Scripts/jquery-1.4.1.js" type="text/javascript"></script>
    <style type="text/css">
        .gdvinfo {
            margin-top: 12px;
            border: 1px solid #34495E;
            font-family: 微软雅黑;
            Width: 100%;
            Font-Size: 12pt;
        }
    </style>
    <script type="text/javascript">
        function over(theover) {
            theover.style.opacity = "0.7";
        }
        function out(theout) {
            theout.style.opacity = "1";
        }
    </script>
</asp:Content>
<asp:Content ID="Main" ContentPlaceHolderID="ContentPlaceHolderMain" runat="server">
    <div class="MainBox">
        <table id="rightTable">
            <tr>
                <td >
                    <asp:DropDownList ID="DropDownListYear" runat="server">
                        <asp:ListItem>2013</asp:ListItem>
                        <asp:ListItem>2014</asp:ListItem>
                        <asp:ListItem>2015</asp:ListItem>
                        <asp:ListItem>2016</asp:ListItem>
                        <asp:ListItem>2017</asp:ListItem>
                        <asp:ListItem>2018</asp:ListItem>
                        <asp:ListItem>2019</asp:ListItem>
                    </asp:DropDownList>

                    <span >年</span>

                    <asp:DropDownList ID="DropDownListMonth" runat="server" >
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

                    <span>月</span>
                    <asp:Button ID="BtnShow" runat="server" Text="显示" class="Btn" onmouseover="over(this)" onmouseout="out(this)" OnClick="BtnShow_Click" />
                    <asp:Button ID="BtnSave" runat="server" Text="保存" class="Btn" onmouseover="over(this)" onmouseout="out(this)" OnClick="BtnSave_Click" />
                    <asp:Label ID="LabTip" runat="server" Text="保存成功！" Visible="false"></asp:Label>
                </td>
            </tr>
        </table>
        <asp:GridView ID="gdvinfo" CssClass="gdvinfo" runat="server" AutoGenerateColumns="False" AllowSorting="True"
            GridLines="None" OnPageIndexChanging="gdvinfo_PageIndexChanging" OnRowDataBound="gdvinfo_RowDataBound">
            <EmptyDataTemplate>
                <div style="text-align: center">请选择日期并点击显示按钮</div>
            </EmptyDataTemplate>
            <Columns>
                <asp:BoundField DataField="Date" HeaderText="日期" DataFormatString="{0:yyyy-MM-dd}" />
                <asp:BoundField HeaderText="星期" DataField="Week" />
                <asp:TemplateField HeaderText="状态">
                    <ItemTemplate>
                        <asp:DropDownList ID="DropDownListState" runat="server">
                            <asp:ListItem Value="0">默认</asp:ListItem>
                            <asp:ListItem Value="1" style=" color:red">上班</asp:ListItem>
                            <asp:ListItem Value="2" style=" color:green">休假</asp:ListItem>
                        </asp:DropDownList>
                    </ItemTemplate>
                    <ControlStyle BorderStyle="None" Height="30px" Width="50px" CssClass="ImageButonEdit" />
                </asp:TemplateField>
            </Columns>
            <HeaderStyle BackColor="#34495E" BorderColor="Black" BorderStyle="None" Font-Size="15pt"
                ForeColor="White" Height="40px" />
            <RowStyle BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="0px"
                ForeColor="Black" HorizontalAlign="Center" VerticalAlign="Middle" />
        </asp:GridView>
    </div>
</asp:Content>
<asp:Content ID="Hide" ContentPlaceHolderID="ContentPlaceHolderHide" runat="server">





    <script type="text/javascript">
        var s = "<%=Page.IsPostBack %>";
        //只在加载时 设置当前时间
        if (s == "False") {

            var date = new Date();
            for (var i = 0; i < document.getElementById("<%=DropDownListYear.ClientID %>").options.length; i++) {
            if (document.getElementById("<%=DropDownListYear.ClientID %>").options[i].text == date.getFullYear())
                document.getElementById("<%=DropDownListYear.ClientID %>").options[i].selected = true;
        }

        for (var i = 0; i < document.getElementById("<%=DropDownListMonth.ClientID %>").options.length; i++) {
               if (document.getElementById("<%=DropDownListMonth.ClientID %>").options[i].text == (date.getMonth() + 1))
                    document.getElementById("<%=DropDownListMonth.ClientID %>").options[i].selected = true;
        }

    }
    </script>
</asp:Content>
