<%@ taglib prefix="C" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page pageEncoding="UTF-8" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3c.org/TR/1999/REC-html401-19991224/loose.dtd">
<HTML>
<HEAD>
    <TITLE>简单小论坛--帖子列表</TITLE>
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
<DIV>
    <!--      导航        -->
    <br/>
    <DIV>
        &gt;&gt;<B><a href="index">论坛首页</a></B>&gt;&gt;
        <B><a href="list?boardId=${sessionScope.boardId}&currentPage=1">${sessionScope.boardName}</a></B>
    </DIV>
    <br/>
    <!--      新帖        -->
    <DIV>
        <A href="post?boardId=${sessionScope.boardId}"><IMG src="../../image/post.gif" name="td_post" border="0"
                                                            id="td_post"></A>
    </DIV>
    <!--         翻 页         -->
    <DIV>
        <a href="list?boardId=${sessionScope.boardId}&currentPage=${FirstPage}">首页</a>
        <a href="list?boardId=${sessionScope.boardId}&currentPage=${PrePage}">上一页</a>|
        <a href="list?boardId=${sessionScope.boardId}&currentPage=${NextPage}">下一页</a>
        <a href="list?boardId=${sessionScope.boardId}&currentPage=${LastPage}">末页</a>
    </DIV>

    <DIV class="t">
        <TABLE cellSpacing="0" cellPadding="0" width="100%">
            <TR>
                <TH class="h" style="WIDTH: 100%" colSpan="4"><SPAN>&nbsp;</SPAN></TH>
            </TR>
            <!--       表 头           -->
            <TR class="tr2">
                <TD>&nbsp;</TD>
                <TD style="WIDTH: 80%" align="center">文章</TD>
                <TD style="WIDTH: 10%" align="center">作者</TD>
                <TD style="WIDTH: 10%" align="center">回复</TD>
            </TR>
            <!--         主 题 列 表        -->
            <C:forEach items="${topicList}" var="topicInfo" varStatus="s">
                <TR class="tr3">
                    <TD><IMG src="../../image/topic.gif" border=0></TD>
                    <TD style="FONT-SIZE: 15px">
                        <A href="detail?topicId=${topicInfo.topicId}&currentPage=1">${topicInfo.title}
                        </A>
                    </TD>
                    <C:set var="name1" value="uName${s.index}"></C:set>
                    <C:set var="name2" value="count${s.index}"></C:set>
                    <TD align="center">${requestScope[name1]}
                    </TD>
                    <TD align="center">${requestScope[name2]}</TD>
                </TR>
            </C:forEach>
        </TABLE>
    </DIV>
    <!--            翻 页          -->
    <DIV>
        <a href="list?boardId=${sessionScope.boardId}&currentPage=${FirstPage}">首页</a>
        <a href="list?boardId=${sessionScope.boardId}&currentPage=${PrePage}">上一页</a>|
        <a href="list?boardId=${sessionScope.boardId}&currentPage=${NextPage}">下一页</a>
        <a href="list?boardId=${sessionScope.boardId}&currentPage=${LastPage}">末页</a>
    </DIV>
</DIV>
<!--             声 明          -->
<BR/>
<CENTER class="gray">2007 Beijing Aptech Beida Jade Bird
    Information Technology Co.,Ltd 版权所有
</CENTER>

</BODY>
</HTML>
