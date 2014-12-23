<%--
    Document   : wsHeader
    Created on : Feb 4, 2010, 12:28:12 PM
    Author     : bbsadmin
--%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<script type="text/javascript" src="highslide/highslide-with-gallery.js"></script>
<link rel="stylesheet" type="text/css" href="highslide/highslide.css" />
<%@page import="com.buysell.webshop.actionclasses.WebsiteAction" %>
<%@page import="com.buysell.beans.DealerMoreInfo" %>
<script type="text/javascript">
    hs.graphicsDir = 'highslide/graphics/';
    hs.outlineType = 'rounded-white';
    hs.wrapperClassName = 'draggable-header';
</script>
<% String du = (String) request.getSession().getAttribute("dw");
    if(du!=null) {
        DealerMoreInfo dm = (DealerMoreInfo) WebsiteAction.hmp.get(du);
        if(dm!=null){
            request.setAttribute("dealerWebsite",dm);
            %>
<div id="submainheader" style="width:1000px;">      <!-- Submain  headerdiv  start -->
    <div style="width:850px;float:left;height:80%">
         <div style="float:left;width:20%;padding:15px 10px">
            <img src="resourceGetter?imf=${dealerWebsite.logo}" width="120px" height="60px" style="border:none" alt="${dealerWebsite.compName}">
        </div>
        <div style="text-align:left;overflow:hidden;float:left;width:70%;padding:20px 10px 0 0;font-size:12px">
            <c:if test="${dealerWebsite.businessDetails!=null}">
                ${fn:substringBefore(dealerWebsite.businessDetails,'|')}<br/>${fn:substringAfter(dealerWebsite.businessDetails,'|')}
            </c:if>
        </div>
    </div>
    <div style="float:left;" align="right">
        <a href="http://bharatbuysell.com/tile1.do?city=All India" target="_blank"><img alt="bharatbuysellLogo" src="bbsimages/cityPageLogo.gif" border="0" style="height:60px;width:140px;padding:5px 0;" /></a>
    </div>
    <div style="clear:both"></div>
    <div style="width:1000px;height:20%" align="right"><a href="http://bharatbuysell.com/tile1.do?city=All India" target="_blank" style="font-size:12px;color:gray;font-weight:bold;text-decoration:none;padding-right:10px;">Check Bharatbuysell.com</a></div>
</div>

            <%}else {%>
            Please access from the Home Page
            <%}}%>