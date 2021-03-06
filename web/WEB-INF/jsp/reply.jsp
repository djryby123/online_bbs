<%@ taglib prefix="C" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":"
            + request.getServerPort() + path + "/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3c.org/TR/1999/REC-html401-19991224/loose.dtd">
<HTML>
<HEAD>
    <TITLE>简单小论坛--回复帖子</TITLE>
    <META http-equiv=Content-Type content="text/html; charset=gbk">
    <Link rel="stylesheet" type="text/css" href="../../style/style.css"/>
</HEAD>

<BODY>
<DIV>
    <IMG src="../../image/logo.gif">
</DIV>
<!--      用户信息、登录、注册        -->

<DIV class="h">
    <C:choose>
        <C:when test="${userinfo != null}">
            欢迎您，会员 ${userinfo.uName}&nbsp;| &nbsp; <A href="reg">新用户注册</A>&nbsp;| &nbsp;
            <A href="exit?url=index">退出登录</A>
        </C:when>
        <C:otherwise>
            您尚未 <a href="login">登录</a>
            &nbsp;| &nbsp; <A href="reg">新用户注册</A> |
        </C:otherwise>
    </C:choose>
</DIV>


<!--      主体        -->
<DIV><BR/>
    <!--      导航        -->
    <DIV>
        &gt;&gt;<B><a href="index.jsp">论坛首页</a></B>&gt;&gt;
        <B><a href="list?boardId=${sessionScope.boardId}&currentPage=1">${sessionScope.boardName}</a></B>
    </DIV>
    <BR/>
    <DIV>
        <FORM name="postForm">
            <DIV class="t">
                <TABLE cellSpacing="0" cellPadding="0" align="center">
                    <TR>
                        <TD class="h" colSpan="3"><B>回复帖子</B></TD>
                    </TR>

                    <TR class="tr3">
                        <TH width="20%"><B>标题</B></TH>
                        <TH><INPUT id="edit1" class="input" style="PADDING-LEFT: 2px; FONT: 14px Tahoma" tabIndex="1"
                                   size="60" name="title"></TH>
                    </TR>

                    <TR class="tr3">
                        <TH vAlign=top>
                            <DIV><B>内容</B></DIV>
                        </TH>
                        <TH colSpan=2>
                            <DIV>
                                <span><textarea id="edit2" style="WIDTH: 500px;" name="content" rows="20" cols="90"
                                                tabIndex="2"></textarea></span>
                            </DIV>
                            (不能大于:<FONT color="blue">1000</FONT>字)
                        </TH>
                    </TR>
                </TABLE>
            </DIV>

            <DIV style="MARGIN: 15px 0px; TEXT-ALIGN: center">
                <INPUT class="btn" id="btn1" tabIndex="3" type="button" value="提 交">
                <INPUT class="btn" tabIndex="4" type="reset" value="重 置">
            </DIV>
            <input type="hidden" id="tId" value="${sessionScope.topicId}"/>
            <C:choose>
                <C:when test="${userinfo != null}">
                    <input type="hidden" id="uId" value="${userinfo.uId}"/>
                </C:when>
                <C:otherwise>
                    <input type="hidden" id="uId" value="-1"/>
                </C:otherwise>
            </C:choose>
        </FORM>
    </DIV>
</DIV>
<!--      声明        -->
<BR/>
<CENTER class="gray">2007 Beijing Aptech Beida Jade Bird
    Information Technology Co.,Ltd 版权所有
</CENTER>

</BODY>
</HTML>
<script type="text/javascript" src="../../plugins/jquery-1.7.2.js"></script>
<script type="text/javascript">
    var f1 = function check() {
        if ($("#uId").val() == "-1") {
            alert("请先登录");
            return false;
        }
        if (document.postForm.title.value == "") {
            alert("标题不能为空");
            return false;
        }
        if (document.postForm.content.value == "") {
            alert("内容不能为空");
            return false;
        }
        if (document.postForm.content.value.length > 1000) {
            alert("长度不能大于1000");
            return false;
        }
    }
    $("#btn1").click(function () {
        $.ajax({
            type: "post",
            url: "/bbs/doReply",
            data: {
                title: $("#edit1").val(),
                content: $("#edit2").val(),
                tId: $("#tId").val(),
                uId: $("#uId").val()
            },
            beforeSend: f1,
            success: function (data) {
                if("true" == data){
                    window.location.href = "<%=basePath %>bbs/detail?topicId=${sessionScope.topicId}&currentPage=1";
                }
            }
        });
    });
</script>
