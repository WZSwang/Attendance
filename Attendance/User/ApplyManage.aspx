<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="ApplyManage.aspx.cs" Inherits="Attendance.User.ApplyManage" %>

<asp:Content ID="Head" ContentPlaceHolderID="head" runat="server">
    <title>Attendance - People</title>
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
                            <asp:TextBox ID="txtSearchStar" runat="server" CssClass="form-control margin-bottom-5" placeholder="申请起始时间" Style="float: left" onclick="HS_setDate(this)"></asp:TextBox>

                        </div>
                        <div class="col-lg-2 col-md-2 form-group">
                            <asp:TextBox ID="txtSearchEnd" runat="server" CssClass="form-control" placeholder="申请结束时间" Style="float: left" onclick="HS_setDate(this)"></asp:TextBox>
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
            <input id="btnadd" type="button" value="请假" class="templatemo-blue-button" />
        </div>
    </div>

    <div class="templatemo-content-widget no-padding">
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
                            <asp:Button ID="ImageButonEdit" runat="server" Text="修改" Visible="false" CssClass="templatemo-edit-btn ImageButonEdit" BackColo="white" OnClientClick=" return false;" />
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
    <div id="divaddout" class="panel panel-default margin-10 TipBoxMax" style="display: none">
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
                <asp:TextBox ID="txtApplyStart" runat="server" class="form-control" onfocus="HS_setDate(this)" onblur='$(".calender").fadeOut(500); ValueIsDate(this);'></asp:TextBox>
            </div>
            <div class="col-lg-6 col-md-10 form-group">
                <label class="control-label" for="inputFirstName"><span style='color: red;'>*</span>结束时间：</label>
                <asp:TextBox ID="txtApplyEnd" runat="server" class="form-control" onfocus="HS_setDate(this)" onblur='$(".calender").fadeOut(500); ValueIsDate(this);'></asp:TextBox>
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
                <asp:TextBox ID="txtEditStart" runat="server" class="form-control" onfocus="HS_setDate(this)"></asp:TextBox>
            </div>
            <div class="col-lg-6 col-md-10 form-group">
                <label for="inputFirstName"><span style='color: red;'>*</span>结束时间：</label>
                <asp:TextBox ID="txtEidtEnd" runat="server" class="form-control" onfocus="HS_setDate(this)"></asp:TextBox>
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
        function HS_DateAdd(interval, number, date) {
            number = parseInt(number);
            if (typeof (date) == "string") { var date = new Date(date.split("-")[0], date.split("-")[1], date.split("-")[2]) }
            if (typeof (date) == "object") { var date = date }
            switch (interval) {
                case "y": return new Date(date.getFullYear() + number, date.getMonth(), date.getDate()); break;
                case "m": return new Date(date.getFullYear(), date.getMonth() + number, checkDate(date.getFullYear(), date.getMonth() + number, date.getDate())); break;
                case "d": return new Date(date.getFullYear(), date.getMonth(), date.getDate() + number); break;
                case "w": return new Date(date.getFullYear(), date.getMonth(), 7 * number + date.getDate()); break;
            }
        }
        function checkDate(year, month, date) {
            var enddate = ["31", "28", "31", "30", "31", "30", "31", "31", "30", "31", "30", "31"];
            var returnDate = "";
            if (year % 4 == 0) { enddate[1] = "29" }
            if (date > enddate[month]) { returnDate = enddate[month] } else { returnDate = date }
            return returnDate;
        }
        function WeekDay(date) {
            var theDate;
            if (typeof (date) == "string") { theDate = new Date(date.split("-")[0], date.split("-")[1], date.split("-")[2]); }
            if (typeof (date) == "object") { theDate = date }
            return theDate.getDay();
        }
        function HS_calender() {
            var lis = "";
            var style = "";
            style += "<style type='text/css'>";
            style += ".calender { width:250px; height:auto; font-size:12px; margin-right:14px; background:url(calenderbg.gif) no-repeat right center #fff; border:1px solid #397EAE; padding:1px;}";
            style += ".calender ul {list-style-type:none; margin:0; padding:0;}";
            style += ".calender .day { background-color:#EDF5FF; height:20px;}";
            style += ".calender .day li,.calender .date li{ float:left; width:14%; height:20px; line-height:20px; text-align:center}";
            style += ".calender li a { text-decoration:none; font-family:Tahoma; font-size:11px; color:#333}";
            style += ".calender li a:hover { color:#f30; text-decoration:underline}";
            style += ".calender li a.hasArticle {font-weight:bold; color:#f60 !important}";
            style += ".lastMonthDate, .nextMonthDate {color:#bbb;font-size:11px}";
            style += ".selectThisYear a, .selectThisMonth a{text-decoration:none; margin:0 2px; color:#000; font-weight:bold}";
            style += ".calender .LastMonth, .calender .NextMonth{ text-decoration:none; color:#000; font-size:18px; font-weight:bold; line-height:16px;}";
            style += ".calender .LastMonth { float:left;}";
            style += ".calender .NextMonth { float:right;}";
            style += ".calenderBody {clear:both}";
            style += ".calenderTitle {text-align:center;height:20px; line-height:20px; clear:both}";
            style += ".today { background-color:#ffffaa;border:1px solid #f60; padding:2px}";
            style += ".today a { color:#f30; }";
            style += ".calenderBottom {clear:both; border-top:1px solid #ddd; padding: 3px 0; text-align:left}";
            style += ".calenderBottom a {text-decoration:none; margin:2px !important; font-weight:bold; color:#000}";
            style += ".calenderBottom a.closeCalender{float:right}";
            style += ".closeCalenderBox {float:right; border:1px solid #000; background:#fff; font-size:9px; width:11px; height:11px; line-height:11px; text-align:center;overflow:hidden; font-weight:normal !important}";
            style += "</style>";
            var now;
            if (typeof (arguments[0]) == "string") {
                selectDate = arguments[0].split("-");
                var year = selectDate[0];
                var month = parseInt(selectDate[1]) - 1 + "";
                var date = selectDate[2];
                now = new Date(year, month, date);
            } else if (typeof (arguments[0]) == "object") {
                now = arguments[0];
            }
            var lastMonthEndDate = HS_DateAdd("d", "-1", now.getFullYear() + "-" + now.getMonth() + "-01").getDate();
            var lastMonthDate = WeekDay(now.getFullYear() + "-" + now.getMonth() + "-01");
            var thisMonthLastDate = HS_DateAdd("d", "-1", now.getFullYear() + "-" + (parseInt(now.getMonth()) + 1).toString() + "-01");
            var thisMonthEndDate = thisMonthLastDate.getDate();
            var thisMonthEndDay = thisMonthLastDate.getDay();
            var todayObj = new Date();
            today = todayObj.getFullYear() + "-" + todayObj.getMonth() + "-" + todayObj.getDate();
            for (i = 0; i < lastMonthDate; i++) {  // Last Month's Date
                lis = "<li class='lastMonthDate'>" + lastMonthEndDate + "</li>" + lis;
                lastMonthEndDate--;
            }
            for (i = 1; i <= thisMonthEndDate; i++) { // Current Month's Date
                if (today == now.getFullYear() + "-" + now.getMonth() + "-" + i) {
                    var todayString = now.getFullYear() + "-" + (parseInt(now.getMonth()) + 1).toString() + "-" + i;
                    lis += "<li><a href=javascript:void(0) class='today' onclick='_selectThisDay(this)' title='" + now.getFullYear() + "-" + (parseInt(now.getMonth()) + 1) + "-" + i + "'>" + i + "</a></li>";
                } else {
                    lis += "<li><a href=javascript:void(0) onclick='_selectThisDay(this)' title='" + now.getFullYear() + "-" + (parseInt(now.getMonth()) + 1) + "-" + i + "'>" + i + "</a></li>";
                }
            }
            var j = 1;
            for (i = thisMonthEndDay; i < 6; i++) {  // Next Month's Date
                lis += "<li class='nextMonthDate'>" + j + "</li>";
                j++;
            }
            lis += style;
            var CalenderTitle = "<a href='javascript:void(0)' class='NextMonth' onclick=HS_calender(HS_DateAdd('m',1,'" + now.getFullYear() + "-" + now.getMonth() + "-" + now.getDate() + "'),this) title='Next Month'>&raquo;</a>";
            CalenderTitle += "<a href='javascript:void(0)' class='LastMonth' onclick=HS_calender(HS_DateAdd('m',-1,'" + now.getFullYear() + "-" + now.getMonth() + "-" + now.getDate() + "'),this) title='Previous Month'>&laquo;</a>";
            CalenderTitle += "<span class='selectThisYear'><a href='javascript:void(0)' onclick='CalenderselectYear(this)' title='Click here to select other year' >" + now.getFullYear() + "</a></span>年<span class='selectThisMonth'><a href='javascript:void(0)' onclick='CalenderselectMonth(this)' title='Click here to select other month'>" + (parseInt(now.getMonth()) + 1).toString() + "</a></span>月";
            if (arguments.length > 1) {
                arguments[1].parentNode.parentNode.getElementsByTagName("ul")[1].innerHTML = lis;
                arguments[1].parentNode.innerHTML = CalenderTitle;
            } else {
                var CalenderBox = style + "<div class='calender'><div class='calenderTitle'>" + CalenderTitle + "</div><div class='calenderBody'><ul class='day'><li>日</li><li>一</li><li>二</li><li>三</li><li>四</li><li>五</li><li>六</li></ul><ul class='date' id='thisMonthDate'>" + lis + "</ul></div><div class='calenderBottom'><a href='javascript:void(0)' class='closeCalender' onclick='closeCalender(this)'>×</a><span><span><a href=javascript:void(0) onclick='_selectThisDay(this)' title='" + todayString + "'>Today</a></span></span></div></div>";
                return CalenderBox;
            }
        }
        function _selectThisDay(d) {
            var boxObj = d.parentNode.parentNode.parentNode.parentNode.parentNode;
            boxObj.targetObj.value = d.title;
            ValueIsDate(boxObj.targetObj);
            boxObj.parentNode.removeChild(boxObj);
        }
        function closeCalender(d) {
            var boxObj = d.parentNode.parentNode.parentNode;
            boxObj.parentNode.removeChild(boxObj);
        }
        function CalenderselectYear(obj) {
            var opt = "";
            var thisYear = obj.innerHTML;
            for (i = 1970; i <= 2020; i++) {
                if (i == thisYear) {
                    opt += "<option value=" + i + " selected>" + i + "</option>";
                } else {
                    opt += "<option value=" + i + ">" + i + "</option>";
                }
            }
            opt = "<select onblur='selectThisYear(this)' onchange='selectThisYear(this)' style='font-size:11px'>" + opt + "</select>";
            obj.parentNode.innerHTML = opt;
        }
        function selectThisYear(obj) {
            HS_calender(obj.value + "-" + obj.parentNode.parentNode.getElementsByTagName("span")[1].getElementsByTagName("a")[0].innerHTML + "-1", obj.parentNode);
        }
        function CalenderselectMonth(obj) {
            var opt = "";
            var thisMonth = obj.innerHTML;
            for (i = 1; i <= 12; i++) {
                if (i == thisMonth) {
                    opt += "<option value=" + i + " selected>" + i + "</option>";
                } else {
                    opt += "<option value=" + i + ">" + i + "</option>";
                }
            }
            opt = "<select onblur='selectThisMonth(this)' onchange='selectThisMonth(this)' style='font-size:11px'>" + opt + "</select>";
            obj.parentNode.innerHTML = opt;
        }
        function selectThisMonth(obj) {
            HS_calender(obj.parentNode.parentNode.getElementsByTagName("span")[0].getElementsByTagName("a")[0].innerHTML + "-" + obj.value + "-1", obj.parentNode);
        }
        function HS_setDate(inputObj) {
            var calenderObj = document.createElement("span");
            calenderObj.innerHTML = HS_calender(new Date());
            calenderObj.style.position = "absolute";
            calenderObj.style.zIndex = "999";
            calenderObj.targetObj = inputObj;
            inputObj.parentNode.insertBefore(calenderObj, inputObj.nextSibling);
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
