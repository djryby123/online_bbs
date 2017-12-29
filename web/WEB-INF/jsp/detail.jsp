<%@ taglib prefix="C" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page pageEncoding="UTF-8" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3c.org/TR/1999/REC-html401-19991224/loose.dtd">
<HTML>
<HEAD>
    <TITLE>简单小论坛--看贴</TITLE>
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

<!-- 主体 -->
<DIV><br/>
    <!--      导航        -->
    <DIV>
        &gt;&gt;<B><a href="index">论坛首页</a></B>&gt;&gt;
        <B><a href="list?boardId=${sessionScope.boardId}&currentPage=1">${sessionScope.boardName}</a></B>
    </DIV>
    <br/>
    <!--      回复、新帖        -->
    <DIV>
        <A href="reply?topicId=${sessionScope.topicId}"><IMG src="../../image/reply.gif" border="0" id="td_post1"></A>
        <A href="post?boardId=${sessionScope.boardId}"><IMG src="../../image/post.gif" border="0" id="td_post2"></A>
    </DIV>
    <!--         翻 页         -->
    <DIV>
        <a href="detail?topicId=${sessionScope.topicId}&currentPage=${FirstPage}">首页</a>
        <a href="detail?topicId=${sessionScope.topicId}&currentPage=${PrePage}">上一页</a>|
        <a href="detail?topicId=${sessionScope.topicId}&currentPage=${NextPage}">下一页</a>
        <a href="detail?topicId=${sessionScope.topicId}&currentPage=${LastPage}">末页</a>
    </DIV>
    <!--      本页主题的标题        -->
    <DIV>
        <TABLE cellSpacing="0" cellPadding="0" width="100%">
            <TR>
                <TH class="h">本页主题: ${topicInfo.title}
                </TH>
            </TR>
            <TR class="tr2">
                <TD>&nbsp;</TD>
            </TR>
        </TABLE>
    </DIV>

    <!--      主题        -->

    <DIV class="t">
        <TABLE style="BORDER-TOP-WIDTH: 0px; TABLE-LAYOUT: fixed" cellSpacing="0" cellPadding="0" width="100%">
            <TR class="tr1">
                <TH style="WIDTH: 20%">
                    <B>${userInfo.uName}
                    </B>&nbsp;&nbsp;&nbsp;<span class="red">[ 楼主 ]</span><BR/>
                    <img src="../../image/head/${userInfo.head}"/><BR/>
                    注册:${time}<BR/>
                </TH>
                <TH>
                    <H4>${topicInfo.title}
                    </H4>
                    <DIV>${topicInfo.content}
                    </DIV>
                    <DIV class="tipad gray">
                        发表：[ ${time1} ]
                    </DIV>
                </TH>
            </TR>
        </TABLE>
    </DIV>

    <!--      回复        -->
    <C:choose>
        <C:when test="${replyList != null}">
            <C:forEach items="${replyList}" var="replyInfo" varStatus="s">
                <C:set var="name1" value="uInfo${s.index}"></C:set>
                <DIV class="t">
                    <TABLE style="BORDER-TOP-WIDTH: 0px; TABLE-LAYOUT: fixed" cellSpacing="0" cellPadding="0"
                           width="100%">
                        <TR class="tr1">
                            <TH style="WIDTH: 20%">
                                <B>${requestScope[name1].uName}
                                </B><BR/>
                                <img src="../../image/head/${requestScope[name1].head}"/><BR/>
                                <C:set var="name2" value="time3${s.index}"></C:set>
                                注册:${requestScope[name2]}<BR/>
                            </TH>
                            <TH>
                                <H4>${replyInfo.title}
                                </H4>
                                <DIV>${replyInfo.content}
                                </DIV>
                                <DIV class="tipad gray">
                                    发表：[ ${time2} ]
                                </DIV>
                            </TH>
                        </TR>
                    </TABLE>
                </DIV>
            </C:forEach>
        </C:when>
        <C:otherwise>
            <DIV class="t">
                <TABLE style="BORDER-TOP-WIDTH: 0px; TABLE-LAYOUT: fixed" cellSpacing="0" cellPadding="0" width="100%">
                    <TR class="tr1">
                        <TH style="WIDTH: 100%">
                            <SPAN class="red">[暂无人回帖]</SPAN>
                        </TH>
                    </TR>
                </TABLE>
            </DIV>
        </C:otherwise>
    </C:choose>

</DIV>

<!-- 声明 -->
<BR>
<CENTER class="gray">2007 Beijing Aptech Beida Jade Bird
    Information Technology Co.,Ltd 版权所有
</CENTER>
</BODY>
</HTML>