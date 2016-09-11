<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="ApplyManage.aspx.cs" Inherits="Attendance.User.ApplyManage" %>

<asp:Content ID="Head" ContentPlaceHolderID="head" runat="server">
    <script src="../Scripts/My97DatePicker/WdatePicker.js"></script>
    <title>Attendance - People</title>
    <script src="../Scripts/artDialog/artDialog.js?skin=default"></script>
    <script src="../Scripts/artDialog/plugins/iframeTools.js"></script>
    <script type="text/javascript">
        function ShowOBj(obj)
        {
            art.dialog({
                content: document.getElementById("divaddout")
            });

        }
    </script>
    <style type="text/css">
        td.selected {
            background-color: #FEF2E8;
        }
    </style>
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
                            <asp:Label ID="LabelBeginDate" runat="server" Text='<%# Bind("BeginDate") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText='<div style="width:100%;text-align :center">结束时间<span class="caret"></span></div>' SortExpression="EndDate">
                        <ItemTemplate>
                            <asp:Label ID="LabelEndDate" runat="server" Text='<%# Bind("EndDate") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText='<div style="width:100%;text-align :center">申请时间<span class="caret"></span></div>' SortExpression="ApplyDate">
                        <ItemTemplate>
                            <asp:Label ID="LabelApplyDate" runat="server" Text='<%# Bind("ApplyDate") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="statusname" HeaderText="请假单状态" />
                    <asp:TemplateField HeaderText="" ShowHeader="False">
                        <ItemTemplate>
                            <asp:LinkButton ID="lbtnView" runat="server" Visible="false" CssClass="InfoView">查看</asp:LinkButton>
                            <asp:Button ID="ImageButonEdit" runat="server" Text="修改" Visible="false" CssClass="templatemo-edit-btn ImageButonEdit" BackColo="white" OnClientClick=" return false;  "  />
                            <asp:Button ID="ImageButonDelete" runat="server" Text="删除" Visible="false" CssClass="templatemo-edit-btn ImageButonDelete" OnClientClick=" return false;" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <HeaderStyle BackColor="#39ADB4" CssClass="white-text templatemo-sort-by" ForeColor="White" />
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
    <div id="divaddout" class="panel panel-default margin-10" style="display: none">
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
                <label class="control-label" for="inputFirstName"><span style='color: red;'>*</span>起始时间：</label>
                <asp:TextBox ID="txtApplyStart" runat="server" class="form-control" onclick="WdatePicker()" onblur=' ValueIsNull(this);'></asp:TextBox>
            </div>
            <div class="col-lg-6 col-md-10 form-group">
                <label class="control-label" for="inputFirstName"><span style='color: red;'>*</span>结束时间：</label>
                <asp:TextBox ID="txtApplyEnd" runat="server" class="form-control" onclick="WdatePicker()" onblur=' ValueIsNull(this);'></asp:TextBox>
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
                <asp:TextBox ID="txtEditTitle" runat="server" class="form-control"></asp:TextBox>
            </div>
            <div class="col-lg-6 col-md-10 form-group">
                <label for="inputFirstName"><span style='color: red;'>*</span>起始时间：</label>
                <asp:TextBox ID="txtEditStart" runat="server" class="form-control" onclick="WdatePicker()"></asp:TextBox>
            </div>
            <div class="col-lg-6 col-md-10 form-group">
                <label for="inputFirstName"><span style='color: red;'>*</span>结束时间：</label>
                <asp:TextBox ID="txtEidtEnd" runat="server" class="form-control" onclick="WdatePicker()"></asp:TextBox>
            </div>

            <div class="col-lg-12 col-md-10 form-group">
                <label for="inputFirstName"><span style='color: red;'>*</span>请假原因：</label>
                <asp:TextBox ID="txtEditRes" runat="server" class="form-control" Rows="3" TextMode="MultiLine"></asp:TextBox>
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
</asp:Content>

<asp:Content ID="script" ContentPlaceHolderID="Script" runat="server">
    <script type="text/javascript">
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
                document.getElementById("<%=txtId.ClientID %>").innerText = userid;
                document.getElementById("<%=editId.ClientID %>").value = userid;
                document.getElementById("<%=txtEditTitle.ClientID %>").value = obj.children[2].innerText;
                document.getElementById("<%=txtEditStart.ClientID %>").value = obj.children[3].innerText;
                document.getElementById("<%=txtEidtEnd.ClientID %>").value = obj.children[4].innerText;
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
                document.getElementById("<%=lblbrith.ClientID %>").style.display = "none";
                return true;
            });

            $("#<%=btnin.ClientID %>").click(function () {
                var txtApplyTitle = document.getElementById("<%=txtApplyTitle.ClientID%>").value;
                if (txtApplyTitle == "") {
                    document.getElementById("<%=lblbrith0.ClientID %>").style.display = "block";
                    document.getElementById("<%=lblbrith0.ClientID %>").innerText = "请输入员工ID";
                    return false;
                }
                var txtApplyRes = document.getElementById("<%=txtApplyRes.ClientID%>").value;
                if (txtApplyRes == "") {
                    document.getElementById("<%=lblbrith0.ClientID %>").style.display = "block";
                    document.getElementById("<%=lblbrith0.ClientID %>").innerText = "请输入员工2ID";
                    return false;
                }
                var star = document.getElementById("<%=txtApplyStart.ClientID%>").value;
                var end = document.getElementById("<%=txtApplyEnd.ClientID%>").value;
                var id = document.getElementById("<%=editId.ClientID%>").value;

                $.ajax({
                    type: "Post",
                    url: "ApplyManage.aspx/DateIsFull",
                    async: false,
                    //方法传参的写法一定要对，str为形参的名字,str2为第二个形参的名字   
                    data: "{'star':'" + star + "','end':'" + end + "','id':'" + id + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) {
                        //返回的数据用data.d获取内容   
                        if (data.d == "true") {
                            document.getElementById("<%=lblbrith0.ClientID %>").style.display = "block";
                            document.getElementById("<%=lblbrith0.ClientID %>").innerText = "已经存在的sjID,请更换";
                        }
                        else
                            document.getElementById("<%=lblbrith0.ClientID %>").innerText = "";
                    },
                    error: function (err) {
                        alert(err);
                    }
                });

                if (document.getElementById("<%=lblbrith0.ClientID %>").innerText == "已经存在的sjID,请更换")
                    return false;

                //禁用按钮的提交   
                return true;
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
                document.getElementById("<%=editId.ClientID%>").value = obj.children[0].innerText;
                $("#exitout").fadeIn(500);
                $("#addoutc").fadeIn(500);
            });

            $("#<%=btnedit.ClientID %>").click(function () {
                var txtApplyTitle = document.getElementById("<%=txtEditTitle.ClientID%>").value;
                if (txtApplyTitle == "") {
                    document.getElementById("<%=lblbrith.ClientID %>").style.display = "block";
                    document.getElementById("<%=lblbrith.ClientID %>").innerText = "请输入员工ID";
                    return false;
                }
                var txtApplyRes = document.getElementById("<%=txtEditRes.ClientID%>").value;
                if (txtApplyRes == "") {
                    document.getElementById("<%=lblbrith.ClientID %>").style.display = "block";
                    document.getElementById("<%=lblbrith.ClientID %>").innerText = "请输入员工2ID";
                    return false;
                }
                var star = document.getElementById("<%=txtEditStart.ClientID%>").value;
                var end = document.getElementById("<%=txtEidtEnd.ClientID%>").value;
                var id = document.getElementById("<%=editId.ClientID%>").value;

                $.ajax({
                    type: "Post",
                    url: "ApplyManage.aspx/DateIsFull",
                    async: false,
                    //方法传参的写法一定要对，str为形参的名字,str2为第二个形参的名字   
                    data: "{'star':'" + star + "','end':'" + end + "','id':'" + id + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) {
                        //返回的数据用data.d获取内容   
                        if (data.d == "true") {
                            document.getElementById("<%=lblbrith.ClientID %>").style.display = "block";
                            document.getElementById("<%=lblbrith.ClientID %>").innerText = "已经存在的sjID,请更换";
                        }
                        else
                            document.getElementById("<%=lblbrith.ClientID %>").innerText = "";
                    },
                    error: function (err) {
                        alert(err);
                    }
                });

                if (document.getElementById("<%=lblbrith.ClientID %>").innerText == "已经存在的sjID,请更换")
                    return false;

                //禁用按钮的提交   
                return true;
                //禁用按钮的提交   
                return true;
            });

            //$("#btnadd").click(function () {
            //    $("#addoutc").fadeIn(500);
            //    $("#divaddout").fadeIn(500);
            //});
            $("#addoutc").click(function () {
                $(".divView").fadeOut(500);
                $("#addoutc").fadeOut(500);
                $("#exitout").fadeOut(500);
                $("#divaddout").fadeOut(500);
                $(".diveditout").fadeOut(500);
            });
            $("#btndelete").click(function () {
                $("#exitout").fadeIn(500);
                $("#addoutc").fadeIn(500);
            });

        });
        function TipClose() {
            $(".divView").fadeOut(500);
            $("#addoutc").fadeOut(500);
            $("#divaddout").fadeOut(500);
            $(".diveditout").fadeOut(500);
            $(".MessageBox").fadeOut(500);
        }

        function ValueIsNull(obj) {
            $(obj).parent().removeClass("has-error");
            if (obj.value == "")
                $(obj).parent().addClass("has-error");
            else
                $(obj).parent().addClass("has-success");
        }

        function ValueIsDate(obj) {
            $(obj).parent().removeClass("has-error");
            var sDate = obj.value.replace(/(^\s+|\s+$)/g, '');//去两边空格; 
            if (sDate == '') {
                $(obj).parent().addClass("has-error");
                return;
            }
            //如果格式满足YYYY-(/)MM-(/)DD或YYYY-(/)M-(/)DD或YYYY-(/)M-(/)D或YYYY-(/)MM-(/)D就替换为'' 
            //数据库中，合法日期可以是:YYYY-MM/DD(2003-3/21),数据库会自动转换为YYYY-MM-DD格式 
            var s = sDate.replace(/^(\d{1,4})(-|\/)(\d{1,2})\2(\d{1,2})$/, '');
            if (s == '') {//说明格式满足YYYY-MM-DD或YYYY-M-DD或YYYY-M-D或YYYY-MM-D 
                var t = new Date(sDate.replace(/\-/g, '/'));
                var ar = sDate.split(/[-/:]/);
                if (ar[0] != t.getFullYear() || ar[1] != t.getMonth() + 1 || ar[2] != t.getDate()) {//alert('错误的日期格式！格式为：YYYY-MM-DD或YYYY/MM/DD。注意闰年。');
                    $(obj).parent().addClass("has-error");
                    return;
                }
            } else {//alert('错误的日期格式！格式为：YYYY-MM-DD或YYYY/MM/DD。注意闰年。'); 
                $(obj).parent().addClass("has-error");
                return;
            }
            $(obj).parent().addClass("has-success");
        }


        function DateIsFull(obj) {
            $(obj).parent().removeClass("has-error");
            if (obj.value == "")
                $(obj).parent().addClass("has-error");
            else
                $(obj).parent().addClass("has-success");
        }

    </script>
</asp:Content>
