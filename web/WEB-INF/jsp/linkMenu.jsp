<%--
    Document   : linkMenu
    Created on : Feb 15, 2010, 1:08:53 PM
    Author     : Madhuri
--%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<style>
    <!--
    .li12
    {
        font-family:Arial;
        font-size:12px;
        list-style:none;
    }
    .li11
    {
        font-family:Arial;
        font-size:11px;
        font-weight:normal;
        list-style:inside;
        list-style-type:square;
        color:#ffffff;
        margin-left:50px;
        line-height:20px
    }
    -->
</style>
<!-- left body background start and end -->
<!-- Master main body div start -->
<div id="masterleftbodybg">       <!-- left body background start and end -->
    <div id="mastercontentbody">      <!-- Master content body div start   -->
        <div id="leftcategorymenu">       <!-- Left menu div start  -->

            <%--<div class="t"><div class="b"><div class="l"><div class="r"><div class="bl"><div class="br"><div class="tl">
                                        <div class="tr">
                                            <div id="menuheader"  style="padding-top:2px;padding-bottom:5px;">&nbsp;
                                                <span class="verdana_menu_head" > Categories </span>
                                            </div>
                                            <div style="clear:both"></div>
                                            <c:if test="${categoryList != null}" >
                                                <c:forEach items="${categoryList}" var="category" varStatus="loop">
                                                        <c:if test="${category.parent == 0}">
                                                            <div class="menu_div" style="">
                                                                <li class="li12" style="">
                                                                    <img src="bbsimages/arrow.jpg"  style="width:30px;height:12px;"/>
                                                                    <a href="#" style="color:#ffffff" >
                                                                        <c:out value="${category.name}" escapeXml="false"/>
                                                                    </a>
                                                                </li>
                                                            </div>
                                                        </c:if>
                                                </c:forEach>
                                            </c:if>
                                   </div>
                                    </div></div></div></div></div></div></div>--%>
        </div>
    </div><!-- Left menu div End -->
</div>

