<%--
    Document   : wsContactUs
    Created on : Mar 24, 2010, 12:06:04 PM
    Author     : madhuri
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@page import="com.buysell.webshop.actionclasses.WebsiteAction" %>
<%@page import="com.buysell.beans.DealerMoreInfo" %>
<link rel="StyleSheet" href="css/stylesheet.css" type="text/css">
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<style>
    #fieldHead
    {
        font-size:13px;
        font-weight:bold;
    }


</style>
<% String du = (String) request.getSession().getAttribute("dw");
    if(du!=null) {
        DealerMoreInfo dm = (DealerMoreInfo) WebsiteAction.hmp.get(du);
        if(dm!=null){
            request.setAttribute("dealerWebsite",dm);
            %>
<div style="width:100%;margin:20px">
    <div style="float:left;width:300px;height:auto">
        <span style="color:#6699cc;font-size:12px"><b>Business Details</b></span>
        <span style="font-size:10px">${dealerWebsite.businessDetails}</span>
    </div><br/><br/>
    <div style="width:300px">
        <span style="color:#6699cc;font-size:12px"><b>Address</b></span>
        <div style="font-size:10px;">${dealerWebsite.address}</div>

    </div>
    <div style="width:300px;height:auto;margin-top:18px">
        <span style="color:#6699cc;font-size:12px"><b>Email</b></span>
        <span style="font-size:10px">${dealerWebsite.emailId}</span>
    </div>
    <div style="width:300px;height:auto;margin-top:18px">
        <span style="color:#6699cc;font-size:12px"><b>Website</b></span>
        <span style="font-size:10px">${dealerWebsite.webUrl}</span>
    </div>
    <div style="float:left;width:860px;margin:25px 0 20px 0">
        <div style="height:300px;width:520px;">
            <span id="fieldHead" style="color:#6699cc"><b>Map</b></span><br/>
            <c:if test="${dealerWebsite.googleMap==null || dealerWebsite.googleMap==''}"><div style="padding:90px 70px;">No map found.</div></c:if>
            <c:if test="${dealerWebsite.googleMap!=null && dealerWebsite.googleMap!=''}">
                <c:if test="${fn:startsWith(dealerWebsite.googleMap,'http://maps.google') == true}" >
                    <iframe width="520px" height="300px" frameborder="0" scrolling="no" marginheight="0" style="float:right" marginwidth="0" src="${dealerWebsite.googleMap}"></iframe><br />
                </c:if>
                <c:if test="${fn:startsWith(dealerWebsite.googleMap,'http://maps.google') != true}" >
                    <div style="padding:90px 70px;">No map found.</div>
                </c:if>
            </c:if>
        </div>
    </div>
</div>
            <%}else {%>
            Please access from the Home Page
            <%}}%>