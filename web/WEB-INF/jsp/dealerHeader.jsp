<%--
    Document   : dealerHeader
    Created on : Jan 9, 2010, 8:01:40 PM
    Author     : bbsadmin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<style>
    h1, h2, h3, h4, h5, h6 { font-size: 100%; font-weight: normal; }
</style>
<c:if test="${dAdBean!=null}">
    <c:set var="db" value="${dAdBean}"/>
    <center><div style="color: #BFBFBF;font: 1.1em/1 arial,helvetica,sans-serif;font-size:12px;overflow: hidden;height:15px;margin-top:3px;margin-bottom:2px;background:url('<c:url value='/bbsimages/New/body_bg.jpg'/>')"><h1>${db.compName} Ads - ${db.city} Ads</h1></div></center>
    <div class="headerLogo" style="overflow:hidden;">
        <div style="float:left;width:12%;padding:5px 30px"><img src="<c:url value='/resourceGetter?imf=${db.logo}'/>" width="120px" height="60px" style="border:none" alt="${domainNM}"> </div>
        <div style="text-align:left;overflow:hidden;float:left;width:42%;padding:10px 30px 10px 0;font:2em bold;color:#FFCC33">${domainNM}</div>
        <div class="boxBorder5" style="float:left;overflow:hidden;width:35%;font:11px normal;">
            <table style="color:#ffffff;font-family:arial;margin:0px ">
                <tr valign="top"> <td>Address</td> <td>:</td> <td><div style="overflow:hidden">${db.address} </div><span style="float:left;">${db.locality}&nbsp;,&nbsp;${db.city}</span></td> </tr>
                <tr><td>Mobile</td><td>:</td><td>${db.mobile}</td></tr>
                <tr><td>Landline</td> <td>:</td> <td>${db.phone}</td> </tr>
            </table>
        </div>
    </div>
</c:if>