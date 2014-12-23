<%--
    Document   : wsRMenu
    Created on : Feb 25, 2010, 10:43:37 AM
    Author     : bbsadmin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="com.buysell.webshop.actionclasses.WebsiteAction" %>
<%@page import="com.buysell.beans.DealerMoreInfo" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<style>
    #sidebar2 img{
        width:98%;
        height:120px;
        margin-top:10px;
    }
</style>
<div id="sidebar2">
    <% String du = (String) request.getSession().getAttribute("dw");
       if(du!=null) {
        DealerMoreInfo dm = (DealerMoreInfo) WebsiteAction.hmp.get(du);
        if(dm!=null){
            request.setAttribute("dealerWebsite",dm);
    %>
    <c:set var="i" value="1"/>
    <c:forEach items="${dealerWebsite.websiteImages}" var="iL">
      <c:if test="${iL!=null}"><img src="resourceGetter?imd=${dealerWebsite.path}${iL}" alt="Ad ${i} Image" border="0" height="160px" width="160px"/></c:if><c:set var="i" value="${i+1}"/>
    </c:forEach>
    <%}else {%>
    Please access from the Home Page
    <%}}%>

</div>