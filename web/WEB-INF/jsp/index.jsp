<%@ taglib prefix="C" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page pageEncoding="utf-8" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3c.org/TR/1999/REC-html401-19991224/loose.dtd">
<HTML>
<HEAD>
    <TITLE>欢迎访问简单小论坛—杜君然</TITLE>
    <META http-equiv=Content-Type content="text/html; charset=utf-8">
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
<DIV class="t">
    <TABLE cellSpacing="0" cellPadding="0" width="100%">
        <TR class="tr2" align="center">
            <TD colSpan="2">论坛</TD>
            <TD style="WIDTH: 10%;">主题</TD>
            <TD style="WIDTH: 30%">最后发表</TD>
        </TR>
        <!--       主版块       -->

        <C:forEach items="${pList}" var="pBoardInfo" varStatus="s1">
            <TR class="tr3">
                <TD colspan="4">${pBoardInfo.boardName}
                </TD>
            </TR>

            <!-- 子版块 -->
            <C:set var="name1" value="cList${s1.index}"></C:set>
            <C:forEach items="${requestScope[name1]}" var="cBoardInfo" varStatus="s2">
                <TR class="tr3">
                    <TD width="5%">&nbsp;</TD>
                    <TH align="left">
                        <IMG src="../../image/board.gif">
                        <A href="list?boardId=${cBoardInfo.boardId}&currentPage=1">${cBoardInfo.boardName}
                        </A>
                    </TH>
                    <C:set var="name2" value="topicInfo${s1.index}${s2.index}"></C:set>
                    <C:set var="name3" value="countTopic${s1.index}${s2.index}"></C:set>
                    <C:set var="name4" value="topicId${s1.index}${s2.index}"></C:set>
                    <C:set var="name5" value="title${s1.index}${s2.index}"></C:set>
                    <C:set var="name6" value="uName${s1.index}${s2.index}"></C:set>
                    <C:set var="name7" value="time${s1.index}${s2.index}"></C:set>
                    <C:choose>
                        <C:when test="${requestScope[name2] != null}">
                            <TD align="center">${requestScope[name3]}
                            </TD>
                            <TH><SPAN>
                                <A href="detail?topicId=${requestScope[name4]}&currentPage=1">${requestScope[name5]} </A>
                                </SPAN><BR/>
                                <SPAN>${requestScope[name6]}</SPAN>
                                <SPAN class="gray">[ ${requestScope[name7]} ]</SPAN>
                            </TH>
                        </C:when>
                        <C:otherwise>
                            <TD align="center">0</TD>
                            <TH>
                                <SPAN class="red">[暂无人发帖]</SPAN>
                            </TH>
                        </C:otherwise>
                    </C:choose>
                </TR>

            </C:forEach>
        </C:forEach>
    </TABLE>
</DIV>

<BR/>
<CENTER class="gray">2007 Beijing Aptech Beida Jade Bird
    Information Technology Co.,Ltd 版权所有
</CENTER>
</BODY>
</HTML>