<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page  import="com.buysell.beans.UserBean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<script type="text/javascript" src="js/ui.core.js"></script>
<script type="text/javascript" src="js/ui.accordion.js"></script>
<style type="text/css">
    <!--
    #linkDiv {
        float:left;
        padding-left:10px;
        width:180px;
        height:25px;
        text-align:left;
    }
    #smsPopupDiv {
        position:fixed;
        background-color:#ffffff;
        width:650px;
        height:500px;
        z-index: 99999;
        border:4px solid #aaaaaa;
    }
    .menu_div_myaccount
    {
        height:22px;
        float:left;
        width:100%;
        padding-left:30px;
    }
    -->
</style>
<script>
    function SendMvCodeMy(itemId)
    {
        var mobnum=document.getElementById(itemId).value.toString();
        document.getElementById("loadingBar").style.display ='inline';
        getMVC(mobnum);
        // document.getElementById("smsPopupDiv2").style.display = 'inline';
    }
    function verifyMVC(itemId)
    {
        var uec=document.getElementById(itemId).value.toString();
        if(uec.length!=4) {
            alert("Please enter 4-digit Mobile code")
        }
        else {
            document.getElementById("loadingBar").style.display ='inline';
            verMVC(uec);
        }
    }
    function checkMC(check) {
        var mc=check.UEMVC.value;
        var chk=false;
        if(mc.length!=4) {
            alert("Please enter 4-digit Mobile code");
            chk=false;
        }
        else {
            return true;
        }
        return chk;
    }
    function sendEvCodeMy()
    {
        document.getElementById("loadingBar").style.display ='inline';
        getEVC();
    }
</script>
<div id="masterleftbodybg">       <!-- left body background start and end -->
    <div id="mastercontentbody">      <!-- Master content body div start   -->
        <div id="" style="margin-left:13px;">       <!-- Left menu div start  -->
            <br/>
            <div style="padding-bottom: 20px">
                <c:if test="${userBean != null}" >
                    <c:choose>
                        <c:when test="${fn:startsWith(userBean.userType,'DEALER') != true}">
                            <div class="manage_response_part_left" style="padding-bottom:15px;margin-bottom: 10px;">
                                <div class="manage_response_myaccount_txt">
                                    <p>My Account</p>
                                    <ul>
                                        <li style="background-image:url(bbsimages/New/manage_visit_icon.jpg);">
                                            <font style="float: left;font-size: 10px;padding-left: 25px;" >Last visited<br /><c:out value="${userBean.lastVisited}" /></font></li>
                                        <li style="background-image:url(bbsimages/New/manage_edit_icon.jpg);"> <a  title="Edit My Profile" href="myAccount_EditMyProfile.do">Edit My Profile</a></li>
                                        <li style="background-image:url(bbsimages/New/manage_password_icon.jpg);"> <a title="Change Password"  href="myAccount_ChangePassword.do">Change Password</a></li>
                                        <li style="background-image:url(bbsimages/New/manage_post_icon.jpg);"> <a title="Post Ads" href="postAdMy.do">Post Ads</a></li>
                                        <li style="background-image:url(bbsimages/New/manage_save_icon.jpg);"> <a title="My saved ads" href="my_saved_ads.do?start=0&range=20&byO=1">My Saved Ads</a></li>
                                        <li style="background-image:url(bbsimages/New/manage_search_icon.jpg);"> <a title="My Saved Searches" href="mySavedSearches.do">My Saved Searches</a></li>
                                        <li style="background-image:url(bbsimages/New/manage_alert_icon.jpg);"> <a title="My Saved Alerts" href="mySavedAlerts.do">My Saved Alerts</a></li>
                                        <li style="background-image:url(bbsimages/New/my_add_invitefriend_icon.png);"> <a title="Invite Friends" href="inviteFriends.do">Invite Friends</a></li>
                                    </ul>
                                </div>
                                <div style="clear:both"></div>
                                <div class="manage_response_myaccount_txt"style="padding-bottom:20px;">
                                    <p>My Ads</p>
                                    <ul>
                                        <li style="background-image:url(bbsimages/New/my_add_active_icon.jpg);"> <a title="Active Ads" href="specificAdsAction.do?status=1">Active</a></li>
                                        <li style="background-image:url(bbsimages/New/my_add_hold_icon.jpg);"> <a  title="On Hold Ads" href="specificAdsAction.do?status=2">On Hold</a></li>
                                        <li style="background-image:url(bbsimages/New/my_add_expired_icon.jpg);"> <a title="Expired Ads" href="specificAdsAction.do?status=4">Expired</a></li>
                                        <li style="background-image:url(bbsimages/New/my_add_renew_icon.jpg);"> <a title="Renew or Edit Ads" href="edit_or_renew_ads.do?start=0&range=20&byO=1">Renew / Edit</a></li>
                                        <li style="background-image:url(bbsimages/New/my_add_close_icon.jpg);"> <a title="Delete Ads" href="delete_ads.do?start=0&range=20&byO=1">Delete</a></li>
                                        <li style="background-image:url(bbsimages/New/my_add_reject_icon.gif);"> <a  title="Rejected Ads" class="" href="rejectedAds.do">Rejected</a></li>
                                    </ul>
                                </div>
                                <c:choose>
                                    <c:when test="${fn:startsWith(userBean.mvStatus,'V') != true && fn:startsWith(userBean.evStatus,'V') != true }" >
                                        <div id="mvcmsg" ><div id="menuend1" align="center"><img src="bbsimages/menu_close_1.jpg" border="0" height="10" /></div>
                                            <span style="color:#000000;font-size:12px;font-weight:bold;margin-left:5px;">
                                                <center> Email & Mobile Verification Incomplete </span><br /><br />
                                            <form action="mobileVerification.do" method="post" name="check" onsubmit="return checkMC(this);">
                                                <span style="font-size:12px;font-weight:bold;color:#000000;">
                                                    Mobile Code <input type="text" maxlength="4" size="4" id="UEMVC" name="UEMVC"/> &nbsp;<input type="submit" value="Go" style="font-size:8px" <%--onclick="verifyMVC('UEMVC')"--%> />
                                                </span>
                                            </form><br />
                                            <input type="hidden" id="mbnu" name="mbnu" value="<c:out value='${userBean.mobile}' />" />
                                            <a title="Resend Mobile Code" onclick="SendMvCodeMy('mbnu')" style="color:#000000;font-size:10px;cursor: pointer">
                                                Resend mobile code </a> <span style="font-size:12px;font-weight:bold;color:#000000;cursor: pointer">/</span>
                                            <a title="Resend Email Code"   onclick="sendEvCodeMy()" style="color:#000000;font-size:10px;cursor: pointer">
                                                Resend email code </a>
                                            </span><br />
                                            <span style="color:#179AC6;font-weight:normal" id="smsconifrm"> </span><br />
                                            </center>
                                        </div>
                                    </c:when>
                                    <c:when test="${fn:startsWith(userBean.mvStatus,'V') != true}" >
                                        <div id="mvcmsg" >
                                            <div id="menuend1" align="center"><img src="bbsimages/menu_close_1.jpg" border="0" height="10" /></div>
                                            <span style="color:#000000;font-size:12px;font-weight:bold;margin-left:5px;">
                                                <center> Mobile Verification Incomplete </span><br /><br />
                                            <span style="font-size:12px;font-weight:bold;">
                                                Mobile Code <input type="text" maxlength="4" size="4" id="UEMVC" name="UEMVC"/> &nbsp;<input type="button" value="Go" style="font-size:8px" onclick="verifyMVC('UEMVC')" />
                                            </span><br /><br />
                                            <input type="hidden" id="mbnu" name="mbnu" value="<c:out value='${userBean.mobile}' />" />
                                            <a href="#" onclick="SendMvCodeMy('mbnu')" style="color:#000000;font-size:10px;cursor: pointer">
                                                Resend mobile code </a> </span><br />
                                            <span style="color:#179AC6;font-weight:normal" id="smsconifrm"> </span><br />
                                            </center>
                                        </div>
                                    </c:when>
                                    <c:when test="${fn:startsWith(userBean.evStatus,'V') != true}" >
                                        <div id="mvcmsg" >
                                            <div id="menuend1" align="center"><img src="bbsimages/menu_close_1.jpg" border="0" height="10" /></div>
                                            <span style="color:#000000;font-size:12px;font-weight:bold;margin-left:5px;">
                                                <center> Email Verification Incomplete </span><br /><br />
                                            <a title="Resend Email Code" onclick="sendEvCodeMy()" style="color:#000000;font-size:10px;cursor: pointer">
                                                Resend Email code </a> </span><br />
                                            </center>
                                        </div>
                                    </c:when>
                                </c:choose>
                                <span id="loadingBar" style="display:none"> <img src="bbsimages/loading_bar.gif" /></span>
                                <center> <span style="font-size:12px;color:#179AC6" id="smsconifrm2"> </span><span style="color:#ff0000;font-size:12px;font-weight:normal;"><c:if test="${mcError != null}">Mobile verification code error</c:if></span></center>
                                <%--<div id="menuend2" align="center"><img src="bbsimages/menu_close_1.jpg" border="0" height="10" /></div>--%>
                            </div>
                            </c:when>
                          
                        <%--for dealer login--%>
                        
                       <c:when test="${fn:startsWith(userBean.userType,'DEALER') == true}">
                            <%-- <%! String dMC =(String) request.getSession().getAttribute("dealerMenuClass");%>--%>
                            <input type="hidden" id="ac" value="${dealerMenuClass}"/>
                            <div class="manage_response_part_left" style="padding-bottom:15px;margin-bottom: 10px;">
                                <div class="manage_response_myaccount_txt">
                                    <p>My Account</p>
                                    <ul>
                                        <li style="background-image:url(bbsimages/New/manage_visit_icon.jpg);">
                                            <font style="float: left;font-size: 10px;padding-left: 25px;" >Last visited<br /><c:out value="${userBean.lastVisited}" /></font></li>
                                        <li style="background-image:url(bbsimages/New/manage_account_icon.jpg);"> <a title="Account Details" href="myAcDet.do">Account Details</a></li>
                                        <li style="background-image:url(bbsimages/New/manage_edit_icon.jpg);"> <a  title="Edit My Profile" href="myAccount_EditMyProfile.do">Edit My Profile</a></li>
                                        <li style="background-image:url(bbsimages/New/manage_password_icon.jpg);"> <a title="Change Password"  href="myAccount_ChangePassword.do">Change Password</a></li>
                                        <li style="background-image:url(bbsimages/New/manage_post_icon.jpg);"> <a title="Post Ads" href="postAdMy.do">Post Ads</a></li>
                                        <li style="background-image:url(bbsimages/New/manage_save_icon.jpg);"> <a title="My saved ads" href="my_saved_ads.do?start=0&range=20&byO=1">My Saved Ads</a></li>
                                        <li style="background-image:url(bbsimages/New/manage_search_icon.jpg);"> <a title="My Saved Searches" href="mySavedSearches.do">My Saved Searches</a></li>
                                        <li style="background-image:url(bbsimages/New/manage_alert_icon.jpg);"> <a title="My Saved Alerts" href="mySavedAlerts.do">My Saved Alerts</a></li>
                                        <li style="background-image:url(bbsimages/New/my_add_invitefriend_icon.png);"> <a title="Invite Friends" href="inviteFriends.do">Invite Friends</a></li>
                                    </ul>
                                </div>
                                <div style="clear:both"></div>
                                <div class="manage_response_myaccount_txt">
                                    <p>My Ads</p>
                                    <ul>
                                        <li style="background-image:url(bbsimages/New/my_add_active_icon.jpg);"> <a title="Active Ads" href="specificAdsAction.do?status=1">Active</a></li>
                                        <li style="background-image:url(bbsimages/New/my_add_hold_icon.jpg);"> <a  title="On Hold Ads" href="specificAdsAction.do?status=2">On Hold</a></li>
                                        <li style="background-image:url(bbsimages/New/my_add_expired_icon.jpg);"> <a title="Expired Ads" href="specificAdsAction.do?status=4">Expired</a></li>
                                        <li style="background-image:url(bbsimages/New/my_add_renew_icon.jpg);"> <a title="Renew or Edit Ads" href="edit_or_renew_ads.do?start=0&range=20&byO=1">Renew / Edit</a></li>
                                        <li style="background-image:url(bbsimages/New/my_add_close_icon.jpg);"> <a title="Delete Ads" href="delete_ads.do?start=0&range=20&byO=1">Delete</a></li>
                                        <li style="background-image:url(bbsimages/New/my_add_reject_icon.gif);"> <a  title="Rejected Ads" href="rejectedAds.do">Rejected</a></li>
                                    </ul>
                                </div>
                                <div style="clear:both"></div>
                                <div class="manage_response_myaccount_txt" >
                                    <p>Manage Response</p>
                                    <ul>
                                        <li style="background-image:url(bbsimages/New/my_add_cart_icon.gif);"> <a title="View Responses" href="resp_dtl.do" >View Responses</a></li>
                                     <li style="background-image:url(bbsimages/New/delete_icon.gif);"> <a title="Deleted Responses" href="delRespDtl.do" >Deleted Responses</a></li>
                                   
                                    </ul>
                                </div>
                                </div>
                        </c:when>
                    </c:choose>
                </c:if>
                <%--<a href="microsite_respDtls.do?dmc=.four" id="mh" class="four"><div id="menuheader"  style="padding-top:5px;"><span class="verdana_menu_head">Microsite Responces</span></div></a>--%>
            </div> 
            <script type="text/javascript">
                CallCurveCorners("menuBox",5,5);
            </script>
        </div>
    </div><!-- Left menu div End  --->
</div>