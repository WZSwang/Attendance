<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="PeropleManage.aspx.cs" Inherits="Attendance.PeropleManage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="Styles/MainBody.css" type="text/css" />
    <link rel="stylesheet" href="Styles/PeropleManage.css" type="text/css" />
    <script src="../Scripts/jquery-1.4.1.js" type="text/javascript"></script>
    <script type="text/javascript">
        function EditInfo(obj) {
            document.getElementById("<%=diveditout.ClientID %>").style.display = "block";
            document.getElementById("editoutc").style.display = "block";
            var obj = event.srcElement;
            while (obj.tagName != "TR") {
                obj = obj.parentElement;
            } var str = obj.children[0].innerText;

          <%--  
            var e = e || window.event;
            var target = e.target || e.srcElement;
            alert(document.getElementById("<%=gdvinfo.ClientID %>").rows(target.parentNode.parentNode.rowIndex).cells(0).innerText + "");--%>
            document.getElementById("<%=editId.ClientID%>").value = obj.children[2].innerText;
            document.getElementById("<%=txtId.ClientID %>").value = obj.children[2].innerText;
            document.getElementById("<%=txtname.ClientID %>").value = obj.children[3].innerText;

            for (var i = 0; i < document.getElementById("<%=drpdenameedit.ClientID %>").options.length; i++)
                if (document.getElementById("<%=drpdenameedit.ClientID %>").options[i].text == obj.children[9].innerText) {
                    document.getElementById("<%=drpdenameedit.ClientID %>").options[i].selected = true;
                    changdrpdenameedit(document.getElementById("<%=drpdenameedit.ClientID %>").options[i].value);
                }
            for (var i = 0; i < document.getElementById("<%=drponameedit.ClientID %>").options.length; i++) {
                if (document.getElementById("<%=drponameedit.ClientID %>").options[i].text == obj.children[7].innerText)
                    document.getElementById("<%=drponameedit.ClientID %>").options[i].selected = true;
            }
        }
        function editoutc() {
            document.getElementById("<%=diveditout.ClientID %>").style.display = "none";
            document.getElementById("editoutc").style.display = "none";
        }



    </script>
    <script type="text/javascript">
        $(function () {
            $(".ImageButonEdit").click(function () {
                document.getElementById("<%=diveditout.ClientID %>").style.display = "block";
                document.getElementById("editoutc").style.display = "block";
                var obj = event.srcElement;
                while (obj.tagName != "TR") {
                    obj = obj.parentElement;
                } 
                var userid = obj.children[2].innerText;
                document.getElementById("<%=editId.ClientID%>").value = obj.children[2].innerText;
                document.getElementById("<%=txtId.ClientID %>").value = obj.children[2].innerText;
                document.getElementById("<%=txtname.ClientID %>").value = obj.children[3].innerText;
                for (var i = 0; i < document.getElementById("<%=drponameedit.ClientID %>").options.length; i++) {
                    if (document.getElementById("<%=drponameedit.ClientID %>").options[i].text == obj.children[4].innerText)
                        document.getElementById("<%=drponameedit.ClientID %>").options[i].selected = true;
                }
                $.ajax({
                    type: "Post",
                    url: "PeropleManage.aspx/UserInfos",
                    async: false,
                    //方法传参的写法一定要对，str为形参的名字,str2为第二个形参的名字   
                    data: "{'str':'" + userid + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) {
                        //返回的数据用data.d获取内容   
                        var ss = (data.d).split(",");
                                document.getElementById("<%=drpdenameedit.ClientID %>").options[0].selected = true;
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

<%--                

                  $.ajax({
                      type: "Post",
                      url: "PeropleManage.aspx/GetStr",
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
                });--%>

                //禁用按钮的提交   
                return true;
            });
        });



        //var http_request = false;
        //function send_request(method, url, content, responseType, callback)//定义发送请求的函数
        //{
        //    http_request = false;
        //    if (window.XMLHttpRequest) {
        //        http_request = new XMLHttpRequest();
        //        if (http_request.overrideMimeType) {
        //            http_request.overrideMimeType("text/xml");
        //        }
        //    }
        //    else {
        //        try {
        //            http_request = new ActiveXObject("Msxml2.XMLHTTP");
        //        }
        //        catch (e) {
        //            try {
        //                http_request = new ActiveXObject("Microsoft.XMLHTTP");
        //            }
        //            catch (e)
        //            { }
        //        }
        //    }
        //    if (!http_request) {
        //        window.alert("创建XMLHttpRequest对象失败");
        //        return false;
        //    }
        //    if (responseType.toLowerCase() == "text") {
        //        http_request.onreadystatechange = callback;
        //    }
        //    else {

        //        window.alert("ERR");
        //        return false;
        //    }
        //    if (method.toLowerCase() == "get") {
        //        http_request.open(method, url, true);
        //    }
        //    else if (method.toLowerCase() == "post") {
        //        http_request.open(method, url, true);
        //        http_request.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
        //    }
        //    else {
        //        window.alert("Err");
        //        return false;
        //    }
        //    http_request.send(content);
        //}

        <%--        function changdrpdename(va)//当学院下拉列表发生改变时触发的脚本事件
        {
            if (va != '0') {
                var speciality = document.getElementById("<%=drpdename.ClientID%>");
                speciality.disabled = false;
                document.getElementById("<%=comb1.ClientID%>").value = va;
                var url = "../HttpHandler/GetDropDownList.ashx?id=" + va;
                send_request("GET", url, null, "text", populateClass3);
            }
        }
        function populateClass3()//Ajax执行成功的回调函数
        {
            var f = document.getElementById("<%=drponame.ClientID%>");
            if (http_request.readyState == 4) {
                if (http_request.status == 200) {
                    var list = http_request.responseText;
                    var classList = list.split("|");
                    f.options.length = 0;
                    for (var i = 0; i < classList.length; i++)
                        //将取得的结果添加到下级的列表框中
                    {
                        var tmp = classList[i].split(",");
                        f.add(new Option(tmp[1], tmp[0]));
                    }
                    document.getElementById("<%=comb3.ClientID%>").value = classList[0].split(",")[0];
                }
                else {
                    alert("您所请求的页面有异常。");
                }
            }
        }--%>


<%--
        function changdrpdenameedit(va)//当学院下拉列表发生改变时触发的脚本事件
        {
            if (va != '0') {
                var speciality = document.getElementById("<%=drpdenameedit.ClientID%>");
                speciality.disabled = false;
                document.getElementById("<%=comb2.ClientID%>").value = va;
                var url = "../HttpHandler/GetDropDownList.ashx?id=" + va;
                send_request("GET", url, null, "text", populateClass4);
            }
        }
        function populateClass4()//Ajax执行成功的回调函数
        {
            var f = document.getElementById("<%=drponameedit.ClientID%>");
            if (http_request.readyState == 4) {
                if (http_request.status == 200) {
                    var list = http_request.responseText;
                    var classList = list.split("|");
                    f.options.length = 0;
                    for (var i = 0; i < classList.length; i++)
                        //将取得的结果添加到下级的列表框中
                    {
                        var tmp = classList[i].split(",");
                        f.add(new Option(tmp[1], tmp[0]));
                    }
                    document.getElementById("<%=comb4.ClientID%>").value = classList[0].split(",")[0];
                }
                else {
                    alert("您所请求的页面有异常。");
                }
            }
        }--%>
        function changcom2(va) {
            document.getElementById("<%=comb3.ClientID%>").value = va;
        }

        function changcom4(va) {
            document.getElementById("<%=comb4.ClientID%>").value = va;
        }


        $(function () {
            $(".addBtn").click(function () {
                var NUM = document.getElementById("<% =tnid.ClientID%>").value;

                if (NUM == "") {
                    document.getElementById("<%=lblbrith0.ClientID %>").style.display = "block";
                    document.getElementById("<%=lblbrith0.ClientID %>").innerText = "请输入员工ID";
                    return false;
                }

                $.ajax({
                    type: "Post",
                    url: "PeropleManage.aspx/GetStr",
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
        });


        $(function () {
            $("#btnadd").click(function () {
                $("#addoutc").fadeIn(500);
                $("#divaddout").fadeIn(500);
            });
            $("#addoutc").click(function () {
                $("#addoutc").fadeOut(500);
                $("#divaddout").fadeOut(500);
            });
            $(".TipClose").click(function () {
                $("#addoutc").fadeOut(500);
                $("#divaddout").fadeOut(500);
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
        <asp:GridView ID="gdvinfo" CssClass="gdvinfo" runat="server" AutoGenerateColumns="False" OnRowUpdating="gdvinfo_RowUpdating" PageSize="10" AllowSorting="True"
            AllowPaging="True" OnRowDeleting="gdvinfo_RowDeleting" OnRowDataBound="gdvinfo_RowDataBound" GridLines="None" OnSorting="gdvinfo_Sorting"
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
                        <asp:CheckBox ID="CheckBox1" runat="server" />
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
            <RowStyle BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="0px"
                ForeColor="Black" HorizontalAlign="Center" VerticalAlign="Middle" />
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
            </table>
        </div>
    </div>
    <div id="diveditout" class="TipBox" runat="server">
        <div class="TipTitle" runat="server">
            <+>修改信息
        <div class="TipClose">×</div>
        </div>
        <div id="Div2" class="outinput" style="padding-left: 50px; padding-right: 50px; padding-top: 30px;"
            runat="server">
            <table style="font-family: 微软雅黑; font-size: 20px; z-index: 7;">
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
                            <asp:ListItem Value="-1">--请选择--</asp:ListItem>
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
                        <asp:Button ID="btnedit" runat="server" Text="确认修改" Style="height: 40px; margin-top: 30px;"
                            BackColor="#34495E" OnClientClick="if(IsBrithtime()&&IsWorktime()&&Isnum()) return true;else return false;"
                            OnClick="btnedit_Click" BorderStyle="none" Font-Names="微软雅黑" Font-Size="25px"
                            ForeColor="White" Width="290px" BorderColor="Black" BorderWidth="0px" Height="40px"
                            onmouseover="over(this)" onmouseout="out(this)" />
                        <asp:Label ID="lblbrith" runat="server" Text="" Style="display: none"></asp:Label>
                    </td>
                </tr>
            </table>
        </div>
    </div>
    <div id="addoutc" style="background-color: Black; opacity: 0.5; position: fixed; width: 100%; height: 100%; top: 0px; left: 0px; z-index: 5; display: none;">
    </div>
    <div id="editoutc" onclick="editoutc()" style="background-color: Black; opacity: 0.5; position: fixed; width: 100%; height: 100%; top: 0px; left: 0px; z-index: 5; display: none;">
    </div>
    <asp:HiddenField runat="server" ID="editId" Value="" />
    <asp:HiddenField runat="server" ID="comb1" Value="" />
    <asp:HiddenField runat="server" ID="comb2" Value="" />
    <asp:HiddenField runat="server" ID="comb3" Value="" />
    <asp:HiddenField runat="server" ID="comb4" Value="" />
    <asp:HiddenField ID="pagechange" runat="server" />
</asp:Content>
