<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="ApplyManage.aspx.cs" Inherits="Attendance.User.ApplyManage" %>

<%@ Register Src="~/UserControl/ControlTemplate.ascx" TagPrefix="uc1" TagName="ControlTemplate" %>


<asp:Content ID="Head" ContentPlaceHolderID="head" runat="server">
    <script src="../Scripts/My97DatePicker/WdatePicker.js"></script>
    <title>Attendance - Holiday</title>
</asp:Content>

<asp:Content ID="Main" ContentPlaceHolderID="ContentPlaceHolderMain" runat="server">
    <div class="templatemo-content-widget white-bg">
        <h2 class="text-uppercase">请假 / 查看</h2>
        <div class="panel-body">
            <div class="templatemo-flex-row flex-content-row">
                <div class="col-1">
                    <div id="timeline_div" class="templatemo-chart"></div>
                    <div class="row form-group">
                        <div class="col-lg-2 col-md-2 form-group">
                            <asp:TextBox ID="txtSearchTitle" runat="server" CssClass="form-control margin-bottom-5" placeholder="标题" Style="float: left"></asp:TextBox>
                        </div>
                        <div class="col-lg-2 col-md-2 form-group">
                            <asp:TextBox ID="txtSearchStar" runat="server" CssClass="form-control margin-bottom-5" placeholder="申请起始时间" Style="float: left" onclick="WdatePicker()"></asp:TextBox>

                        </div>
                        <div class="col-lg-2 col-md-2 form-group">
                            <asp:TextBox ID="txtSearchEnd" runat="server" CssClass="form-control" placeholder="申请结束时间" Style="float: left" onclick="WdatePicker()"></asp:TextBox>
                        </div>
                        <div class="col-lg-4 col-md-4 form-group" style="padding-top: 8px;">
                            <p style="float: left">请假单状态：</p>
                            <asp:RadioButtonList ID="rblStatus" runat="server" RepeatDirection="Horizontal">
                                <asp:ListItem Value="0"><span></span>待审批</asp:ListItem>
                                <asp:ListItem Value="1"><span></span>归档</asp:ListItem>
                                <asp:ListItem Value="" Selected="True"><span></span>全部</asp:ListItem>
                            </asp:RadioButtonList>
                        </div>
                        <div class="col-lg-2 col-md-12  form-group">
                            <asp:Button ID="btnSearch" runat="server" Text="查询" CssClass="templatemo-blue-button"
                                OnClick="btnSearch_Click" />
                        </div>
                    </div>
                </div>
            </div>
            <input id="btnadd" type="button" value="请假" class="templatemo-blue-button" onclick="ShowOBj(this)" />
        </div>
    </div>

    <div class="tem0platemo-content-widget no-padding">
        <div class="panel panel-default table-responsive">
            <asp:GridView ID="gdvinfo" CssClass="table table-striped table-bordered templatemo-user-table gdvinfo" runat="server" AutoGenerateColumns="False" AllowSorting="True"
                AllowPaging="True" OnSorting="gdvinfo_Sorting" Style="text-align: center" AllowCustomPaging="True" OnRowDataBound="gdvinfo_RowDataBound">
                <EmptyDataTemplate>
                    <div style="text-align: center">没有查询到数据，请检查查询条件是否正确</div>
                </EmptyDataTemplate>
                <Columns>
                    <asp:TemplateField HeaderText='请假单ID' InsertVisible="False">
                        <ItemStyle />
                        <ItemTemplate>
                            <asp:Label ID="LabelID" runat="server" Text='<%# Bind("ApproveID") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText='<div style="width:100%;text-align :center">申请人<span class="caret"></span></div>' SortExpression="UserName">
                        <ItemTemplate>
                            <asp:Label ID="LabelName" runat="server" Text='<%# Bind("UserName") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText='标题'>
                        <ItemTemplate>
                            <asp:Label ID="LabelTitle" runat="server" Text='<%# Bind("Title") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText='<div style="width:100%;text-align :center">起始时间<span class="caret"></span></div>' SortExpression="BeginDate">
                        <ItemTemplate>
                            <asp:Label ID="LabelBeginDate" runat="server" Text='<%# Convert.ToDateTime( Eval("BeginDate")).ToString("yyyy-MM-dd HH:mm")%>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText='<div style="width:100%;text-align :center">结束时间<span class="caret"></span></div>' SortExpression="EndDate">
                        <ItemTemplate>
                            <asp:Label ID="LabelEndDate" runat="server" Text='<%# Convert.ToDateTime( Eval("EndDate")).ToString("yyyy-MM-dd HH:mm") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText='<div style="width:100%;text-align :center">申请时间<span class="caret"></span></div>' SortExpression="ApplyDate">
                        <ItemTemplate>
                            <asp:Label ID="LabelApplyDate" runat="server" Text='<%# Convert.ToDateTime( Eval("ApplyDate")).ToString("yyyy-MM-dd HH:mm") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="statusname" HeaderText="请假单状态" />
                    <asp:TemplateField HeaderText="" ShowHeader="False">
                        <ItemTemplate>
                            <asp:LinkButton ID="lbtnView" runat="server"  CssClass="InfoView">查看</asp:LinkButton>
                            <asp:Button ID="ImageButonEdit" runat="server" Text="修改" Visible="false" CssClass="templatemo-edit-btn ImageButonEdit" BackColo="white" OnClientClick=" return false;  " />
                            <asp:Button ID="ImageButonDelete" runat="server" Text="删除" Visible="false" CssClass="templatemo-edit-btn ImageButonDelete" OnClientClick=" return false;" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <HeaderStyle BackColor="#39ADB4" CssClass="white-text templatemo-sort-by" ForeColor="White" />
                <PagerSettings Mode="Numeric" />
            </asp:GridView>
            <uc1:ControlTemplate runat="server" ID="ControlTemplate" OnDateBind="Bind" />
        </div>
    </div>
</asp:Content>

<asp:Content ID="Hide" ContentPlaceHolderID="ContentPlaceHolderHide" runat="server">
    <div id="divaddout" class="panel panel-default margin-10 TipBoxMax divaddout" style="display: none">
        <div class="panel-heading" runat="server">
            <h2 class="text-uppercase"><+>请假信息</h2>
        </div>
        <div class="panel-body" runat="server">
            <div class="col-lg-6 col-md-6 form-group">
                <label for="inputFirstName">请假单号： New</label>
                <asp:Label ID="labApplyID" runat="server" Text=""></asp:Label>
            </div>
            <div class="col-lg-6 col-md-6 form-group">
                <label for="inputLastName">申请人：</label>
                <asp:Label ID="txtApplyName" runat="server" Text=""></asp:Label>
            </div>
            <div id="AddTitle" class="col-lg-12 col-md-12 form-group">
                <label class="control-label" for="inputFirstName"><span style='color: red;'>*</span>标题：</label>
                <asp:TextBox ID="txtApplyTitle" runat="server" class="form-control" onblur="ValueIsNull(this);"></asp:TextBox>
            </div>
            <div class="col-lg-6 col-md-10 form-group">
                <label class="control-label" for="inputFirstName"><span style='color: red;'>*</span>起始时间：</label><br />
                <asp:TextBox ID="txtApplyStart" runat="server" class="form-control " Style="width: 60%; float: left" onclick="WdatePicker(); " onchange=" ValueIsNull(this);"></asp:TextBox>
                <asp:DropDownList ID="drpApplyStart" runat="server" CssClass="form-control" Style="width: 40%; float: left">
                    <asp:ListItem Selected="True" Value="08:30:00">8:30</asp:ListItem>
                    <asp:ListItem Value="11:50:00">11:50</asp:ListItem>
                </asp:DropDownList>
            </div>
            <div class="col-lg-6 col-md-10 form-group">
                <label class="control-label" for="inputFirstName"><span style='color: red;'>*</span>结束时间：</label><br />
                <asp:TextBox ID="txtApplyEnd" runat="server" class="form-control" Style="width: 60%; float: left" onclick="WdatePicker()" onchange=' ValueIsNull(this);'></asp:TextBox>
                <asp:DropDownList ID="drpApplyEnd" runat="server" CssClass="form-control" Style="width: 40%; float: left">
                    <asp:ListItem Value="11:50:00">11:50</asp:ListItem>
                    <asp:ListItem Selected="True" Value="17:00:00">17:00</asp:ListItem>
                </asp:DropDownList>
            </div>

            <div class="col-lg-12 col-md-10 form-group">
                <label class="control-label" for="inputFirstName"><span style='color: red;'>*</span>请假原因：</label>
                <asp:TextBox ID="txtApplyRes" runat="server" class="form-control" Rows="3" TextMode="MultiLine" onblur="ValueIsNull(this);"></asp:TextBox>
            </div>
            <div class="row form-group" style="text-align: center;">
                <div class="col-lg-12 col-md-12 form-group">
                    <asp:Label ID="lblbrith0" runat="server" Text="" Style="display: none; color: #d7425c"></asp:Label>
                </div>
            </div>
            <div class="form-group text-right">
                <asp:Button ID="btnin" runat="server" Text="申请新假期" OnClick="btnin_Click" CssClass="templatemo-blue-button" />
                <button class="templatemo-white-button" type="reset" onclick="TipClose()">取消</button>
            </div>
        </div>
    </div>
    <div id="diveditout" class="panel panel-default margin-10 TipBoxMax diveditout" runat="server" style="display: none">
        <div class="panel-heading" runat="server">
            <h2 class="text-uppercase"><+>修改信息</h2>
        </div>
        <div class="panel-body" runat="server">
            <div class="col-lg-6 col-md-6 form-group">
                <label for="inputFirstName">请假单号：</label>
                <asp:Label ID="txtId" runat="server" Text=""></asp:Label>
            </div>
            <div class="col-lg-6 col-md-6 form-group">
                <label for="inputLastName">申请人：</label>
                <asp:Label ID="LabEditName" runat="server" Text=""></asp:Label>
            </div>
            <div class="col-lg-12 col-md-12 form-group">
                <label for="inputFirstName"><span style='color: red;'>*</span>标题：</label>
                <asp:TextBox ID="txtEditTitle" runat="server" class="form-control" onblur="ValueIsNull(this);"></asp:TextBox>
            </div>
            <div class="col-lg-6 col-md-10 form-group">
                <label for="inputFirstName"><span style='color: red;'>*</span>起始时间：</label><br />
                <asp:TextBox ID="txtEditStart" runat="server" class="form-control" Style="width: 60%; float: left" onclick="WdatePicker()" onblur="ValueIsNull(this);"></asp:TextBox>
                <asp:DropDownList ID="drpEditStart" runat="server" CssClass="form-control" Style="width: 40%; float: left">
                    <asp:ListItem Selected="True" Value="08:30:00">8:30</asp:ListItem>
                    <asp:ListItem Value="11:50:00">11:50</asp:ListItem>
                </asp:DropDownList>
            </div>
            <div class="col-lg-6 col-md-10 form-group">
                <label for="inputFirstName"><span style='color: red;'>*</span>结束时间：</label><br />
                <asp:TextBox ID="txtEidtEnd" runat="server" class="form-control" Style="width: 60%; float: left" onclick="WdatePicker()" onblur="ValueIsNull(this);"></asp:TextBox>
                <asp:DropDownList ID="drpEidtEnd" runat="server" CssClass="form-control" Style="width: 40%; float: left">
                    <asp:ListItem Value="11:50:00">11:50</asp:ListItem>
                    <asp:ListItem Selected="True" Value="17:00:00">17:00</asp:ListItem>
                </asp:DropDownList>
            </div>

            <div class="col-lg-12 col-md-10 form-group">
                <label for="inputFirstName"><span style='color: red;'>*</span>请假原因：</label>
                <asp:TextBox ID="txtEditRes" runat="server" class="form-control" Rows="3" TextMode="MultiLine" onblur="ValueIsNull(this);"></asp:TextBox>
            </div>

            <div class="row form-group" style="text-align: center;">
                <div class="col-lg-12 col-md-12 form-group">
                    <asp:Label ID="lblbrith" runat="server" Text="" Style="display: none; color: #d7425c"></asp:Label>
                </div>
            </div>
            <div class="form-group text-right">
                <asp:Button ID="btnedit" runat="server" Text="确认修改" OnClick="btnedit_Click" CssClass="templatemo-blue-button" />
                <button class="templatemo-white-button" type="reset" onclick="TipClose()">取消</button>
            </div>
        </div>
    </div>


    <div id="divView" class="panel panel-default margin-10 TipBoxMax divView" runat="server" style="display: none">
        <div class="panel-heading" runat="server">
            <h2 class="text-uppercase"><+>查看信息</h2>
        </div>
        <div class="panel-body" runat="server">
            <div class="col-lg-6 col-md-6 form-group">
                <label for="inputFirstName">请假单号：</label>
                <asp:Label ID="LabViewID" runat="server" Text=""></asp:Label>
            </div>
            <div class="col-lg-6 col-md-6 form-group">
                <label for="inputLastName">申请人：</label>
                <asp:Label ID="LabViewName" runat="server" Text=""></asp:Label>
            </div>
            <div class="col-lg-12 col-md-12 form-group">
                <label for="inputFirstName"><span style='color: red;'>*</span>标题：</label>
                <asp:TextBox ID="txtViewTitle" runat="server" class="form-control" ReadOnly="true"></asp:TextBox>
            </div>
            <div class="col-lg-6 col-md-10 form-group">
                <label for="inputFirstName"><span style='color: red;'>*</span>起始时间：</label>
                <asp:TextBox ID="txtViewStar" runat="server" class="form-control" ReadOnly="true"></asp:TextBox>
            </div>
            <div class="col-lg-6 col-md-10 form-group">
                <label for="inputFirstName"><span style='color: red;'>*</span>结束时间：</label>
                <asp:TextBox ID="txtViewEnd" runat="server" class="form-control" ReadOnly="true"></asp:TextBox>
            </div>

            <div class="col-lg-12 col-md-10 form-group">
                <label for="inputFirstName"><span style='color: red;'>*</span>请假原因：</label>
                <asp:TextBox ID="txtViewRes" runat="server" class="form-control" Rows="3" TextMode="MultiLine" ReadOnly="true"></asp:TextBox>
            </div>
            <div class="form-group text-right">
                <button class="templatemo-white-button" type="reset" onclick="TipClose()">关闭</button>
            </div>
        </div>
    </div>

    <div id="exitout" class="templatemo-content-widget pink-bg MessageBox" style="display: none">
        <i class="fa fa-times" onclick="TipClose()"></i>
        <h2 class="text-uppercase margin-bottom-10">&lt;!&gt;注意</h2>
        <p class="margin-bottom-0">此操作无法撤销,确定要删除勾选的申请吗？ </p>
        <div class=" text-right" style="margin-top: 40px;">
            <div class="col-lg-12 col-md-12 form-group">
                <asp:Button ID="yesexit" runat="server" Text="删除" class="templatemo-white-button" Style="border: 0px; color: #D7425C" OnClick="btndelete_Click" />
            </div>
        </div>
    </div>
    <div id="addoutc" class="out"></div>

    <asp:HiddenField runat="server" ID="editId" Value="" />
    <asp:HiddenField runat="server" ID="AppID" Value="" />
</asp:Content>

<asp:Content ID="script" ContentPlaceHolderID="Script" runat="server">
    <script type="text/javascript">

        function ValueIsNull(obj) {
            $(obj).parent().removeClass("has-error");
            if (obj.value == "") {
                $(obj).parent().addClass("has-error");
                return false;
            }
            else {
                $(obj).parent().addClass("has-success");
                return true;
            }
        }

        function DateIsFull(txtstar, txtend, drpstar, drpend) {
            if (ValueIsNull(txtstar) & ValueIsNull(txtend)) {
                var id = $("#<%=editId.ClientID %>").val();
                var appid = $("#<%=AppID.ClientID %>").val();
                var startime = txtstar.value + " " + drpstar.value;
                var endtime = txtend.value + " " + drpend.value;
                $.ajax({
                    type: "Post",
                    url: "ApplyManage.aspx/DateIsFull",
                    async: false,
                    data: "{'star':'" + startime + "','end':'" + endtime + "','id':'" + id + "','appid':'" + appid + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) {
                        if (data.d == "true") {
                            $("#<%=lblbrith.ClientID %>").text("erro");
                            $(txtstar).parent().addClass("has-warning");
                            $(txtend).parent().addClass("has-warning");
                        }
                        else
                            $("#<%=lblbrith.ClientID %>").text("");
                    },
                    error: function (err) {
                        alert(err);
                    }
                });
                if ($("#<%=lblbrith.ClientID %>").text() == "erro")
                    return false;
                return true;
            } else
                return false;
        }
        $(function () {

            $(".ImageButonEdit").click(function () {
                //display
                $(".diveditout").fadeIn(500);
                $("#addoutc").fadeIn(500);

                //getelement
                var obj = event.srcElement;
                while (obj.tagName != "TR") {
                    obj = obj.parentElement;
                }
                var userid = obj.children[0].innerText;

                $.ajax({
                    type: "Post",
                    url: "ApplyManage.aspx/GetRes",
                    async: false,
                    data: "{'str':'" + userid + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) {
                        document.getElementById("<%=txtEditRes.ClientID %>").value = data.d;
                    },
                    error: function (err) {
                        alert(err);
                    }
                });

                $("#<%=txtId.ClientID %>").text(userid);
                $("#<%=AppID.ClientID %>").val(userid);
                $("#<%=txtEditTitle.ClientID %>").val(obj.children[2].innerText);

                var startime = obj.children[3].innerText;
                $("#<%=txtEditStart.ClientID %>").val(startime.substr(0, 10));
                for (var i = 0; i < document.getElementById("<%=drpEditStart.ClientID %>").options.length; i++) {
                    if (document.getElementById("<%=drpEditStart.ClientID %>").options[i].text == startime.substr(11, 5).trim())
                        document.getElementById("<%=drpEditStart.ClientID %>").options[i].selected = true;
                }

                var endtime = obj.children[4].innerText;
                $("#<%=txtEidtEnd.ClientID %>").val(endtime.substr(0, 10));
                for (var i = 0; i < document.getElementById("<%=drpEidtEnd.ClientID %>").options.length; i++) {
                    if (document.getElementById("<%=drpEidtEnd.ClientID %>").options[i].text == endtime.substr(11, 5).trim())
                        document.getElementById("<%=drpEidtEnd.ClientID %>").options[i].selected = true;
                }
                $("#<%=lblbrith.ClientID %>").hide();

                return true;
            });

            $("#<%=btnin.ClientID %>").click(function () {
                $("#<%=AppID.ClientID %>").val("");
                if (ValueIsNull($("#<%=txtApplyTitle.ClientID %>")[0]) & ValueIsNull($("#<%=txtApplyRes.ClientID %>")[0]) & DateIsFull($("#<%=txtApplyStart.ClientID %>")[0], $("#<%=txtApplyEnd.ClientID %>")[0], $("#<%=drpApplyStart.ClientID %>")[0], $("#<%=drpApplyEnd.ClientID %>")[0])) {
                    return true;
                }
                return false;
            });


            $("#<%=btnedit.ClientID %>").click(function () {
                if (ValueIsNull($("#<%=txtEditTitle.ClientID %>")[0]) & ValueIsNull($("#<%=txtEditRes.ClientID %>")[0]) & DateIsFull($("#<%=txtEditStart.ClientID %>")[0], $("#<%=txtEidtEnd.ClientID %>")[0], $("#<%=drpEditStart.ClientID %>")[0], $("#<%=drpEidtEnd.ClientID %>")[0])) {
                    return true;
                }
                return false;
            });

            $(".InfoView").click(function () {
                $(".divView").fadeIn(500);
                $("#addoutc").fadeIn(500);

                //getelement
                var obj = event.srcElement;
                while (obj.tagName != "TR") {
                    obj = obj.parentElement;
                }
                var userid = obj.children[0].innerText;
                document.getElementById("<%=LabViewID.ClientID %>").innerText = userid;
                document.getElementById("<%=txtViewTitle.ClientID %>").value = obj.children[2].innerText;
                document.getElementById("<%=txtViewStar.ClientID %>").value = obj.children[3].innerText;
                document.getElementById("<%=txtViewEnd.ClientID %>").value = obj.children[4].innerText;
                $.ajax({
                    type: "Post",
                    url: "ApplyManage.aspx/GetRes",
                    async: false,
                    data: "{'str':'" + userid + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) {
                        document.getElementById("<%=txtViewRes.ClientID %>").value = data.d;
                    },
                    error: function (err) {
                        alert(err);
                    }
                });
                document.getElementById("<%=lblbrith.ClientID %>").style.display = "none";
                return false;
            });

            $(".ImageButonDelete").click(function () {
                var obj = event.srcElement;
                while (obj.tagName != "TR") {
                    obj = obj.parentElement;
                }
                document.getElementById("<%=AppID.ClientID%>").value = obj.children[0].innerText;
                $("#exitout").fadeIn(500);
                $("#addoutc").fadeIn(500);
            });


            $("#btnadd").click(function () {
                $("#addoutc").fadeIn(500);
                $("#divaddout").fadeIn(500);
            });
            $("#addoutc").click(function () {
                $(".divView").fadeOut(500);
                $("#addoutc").fadeOut(500);
                $("#exitout").fadeOut(500);
                $("#divaddout").fadeOut(500);
                $(".diveditout").fadeOut(500);
            });
        });
        function TipClose() {
            $(".divView").fadeOut(500);
            $("#addoutc").fadeOut(500);
            $("#divaddout").fadeOut(500);
            $(".diveditout").fadeOut(500);
            $(".MessageBox").fadeOut(500);
        }


    </script>
</asp:Content>
