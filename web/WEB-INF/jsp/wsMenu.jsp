<%--
    Document   : wsMenu
    Created on : Feb 4, 2010, 1:29:48 PM
    Author     : bbsadmin
--%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<script type="text/javascript" src="js/curvycorners.js"></script>

<style>
#wsmenu div {
    float:left;padding:0 10px;line-height:25px;
}
#wsmenu div:hover {
    background-color:#858585;
}
#wsmenu a
{
    font-family:arial;font-size:12px;
    display:block;text-align:left;color:#FFFFFF;text-decoration:none;
    padding-top:5px;
}
<%--#wsmenu .selected
{
    color:#FFCC33;
}--%>
<%--#wsmenu a:hover{color:#000000}--%>
</style>
    <div style="float:left;width:1%;height:100%;padding-top:1px" align="right"><img src="bbsimages/nav_left.gif" height="100%" /></div>
<div id="wsmenu" style="width:98%;height:100%;float:left;background:transparent url(bbsimages/nav_bg.gif) repeat-x scroll 0 0;">
        <div ><a id="home" <c:if test="${sessionScope.button == 'wsHome'}" >class="selected"</c:if> href="ws.do" >Home</a></div>
        <img src="bbsimages/nav_sep.gif" height="100%" width="2px" style="float:left">
        <div >
            <a id="postAd"  <c:if test="${sessionScope.button == 'wsProducts'}" >class="selected"</c:if> href="wsPl.do">Products</a>
        </div>
        <img src="bbsimages/nav_sep.gif" height="100%" width="2px" style="float:left">
        <div>
            <a id="register" <c:if test="${sessionScope.button == 'wsAds'}" >class="selected"</c:if> href="http://bharatbuysell.com/dealersAllAds.do?Did=${dealerWebsite.dId}" target="_blank">Ads in Bharatbuysell</a>
        </div>
        <img src="bbsimages/nav_sep.gif" height="100%" width="2px" style="float:left">
        <div>
            <a id="myAccount" <c:if test="${sessionScope.button == 'wsAboutUs'}" >class="selected"</c:if> href="">About Us</a></div>
        <img src="bbsimages/nav_sep.gif" height="100%" width="2px" style="float:left">
        <div>
            <a id="currentOffers" <c:if test="${sessionScope.button == 'wsCurrentOffers'}" >class="selected"</c:if> href="wsContact.do">Contact Us</a></div>
        <img src="bbsimages/nav_sep.gif" height="100%" width="2px" style="float:left">
            <%--<div style="margin-left:430px"><a id="login" href="#" >My Basket</a></div>--%>
    </div>
<div style="float:left;width:1%;height:100%;padding-top:1px;"><img src="bbsimages/nav_right.gif" height="100%" /></div>
