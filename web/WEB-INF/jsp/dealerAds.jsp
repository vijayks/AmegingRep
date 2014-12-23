<%--
    Document   : dealerAds
    Created on : Jan 9, 2010, 8:06:26 PM
    Author     : bbsadmin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn"%>
<link href="<c:url value='/css/New/bharth.css'/>" type="text/css" rel="stylesheet" />
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<c:choose>
    <c:when test="${ab !=null && fn:length(ab) > 0}">
        <%--<c:if test="${ab!=null}">--%>
        <c:set var="i" value="0" /> <!-- this value  used forcommercial ads count -->
        <c:forEach items="${ab}" var="ab">
            <script language="javascript">
                smsWL[count]="sms"+${ab.adId}+"wl";
                smsAL[count]="sms"+${ab.adId}+"al";
                saveWL[count]="save"+${ab.adId}+"wl";
                saveAL[count]="save"+${ab.adId}+"al";
                emailWL[count]="email"+${ab.adId}+"wl";
                emailAL[count]="email"+${ab.adId}+"al";
                //eu[count]="eu"+;
                nu[count]="nu"+${ab.adId};
                //  sent[count]="sent"+;
                fp[count]="fp"+${ab.adId};
                count++;
                
                var R=0;
                var S=0;
                <c:if test='${userBean != null}' > R=1;
                    <c:if test="${userBean.evStatus == 'V' }" >  EV=1;
                    </c:if>
                </c:if>
            </script>
            <div style="width:740px;">
                <div  style="height:110px;" >
                    <div class="my_account_ad_bg_cont" style="width:725px;background:white;" onmouseover="this.style.background='whitesmoke';" onmouseout="this.style.background='white';">       
                        <div class="my_account_ad_cont">
                            <div class="my_account_ad_bg">
                                <div class="my_account_ad_img">
                                    <a title="Dealer Logo" class="imglink" style=""   >
                                        <c:if test='${ab.image1 != "" && ab.image1 != "null" }'> <img alt="dealer logo" src="<c:url value='/resourceGetter?imf=${ab.image1}'/>" property="image1"  width="75px" height="75px" style="border:none"  >  </c:if>
                                        <c:if test='${ab.image1 == "" || ab.image1 == "null"}'> <img src="<c:url value='/bbsimages/No_Image.png'/>" width="75px" height="75px" style="border:none"  > </c:if>
                                    </a>
                                </div>
                            </div>
                            <div  class="my_account_ad_more_details" style="padding-left: 10px;"><li><a title="More Details" class="link" href="<c:url value='/bs/moreDetails.do?adId=${ab.adId}&catId=${ab.catId}#moredetail'/>" onclick="return hs.htmlExpand(this, { objectType: 'ajax'} )">More Details...</a></li></div>
                        </div>
                        <div class="my_account_ad_left_txt_cont" style="width:520px; ">
                            <strong style="color:#046dbe;">
                                <a title="${ab.title} " class="link" style="font-size:11px;color:#046DBE"  href="<c:url value='/bs/moreDetails.do?adId=${ab.adId}&catId=${ab.catId}#moredetail'/>" onclick="return hs.htmlExpand(this, { objectType: 'ajax'} )">
                                    <c:if test="${fn:length(ab.title) <= 50 }"> <c:out value="${ab.title}" />&nbsp;(${ab.parentCatName}) </c:if>
                                    <c:if test="${fn:length(ab.title) > 50 }"> <c:out value="${fn:substring(ab.title,0,45)}"  />&nbsp;(${ab.parentCatName}) </c:if>
                                </a>
                            </strong> <br />
                            <p style="margin-top:2px;">       
                                <c:if test="${fn:length(ab.description) <= 270 }" > <c:out value="${ab.description}" /> </c:if>
                                <c:if test="${fn:length(ab.description) > 270 }" > <c:out value="${fn:substring(ab.description,0,270)}" />&nbsp;&nbsp;<a title="More Details" href="<c:url value='/bs/moreDetails.do?adId=${ab.adId}&catId=${ab.catId}#moredetail'/>" onclick="return hs.htmlExpand(this, { objectType: 'ajax'} )" ><span style="color:#046dbe">More...</span></a> </c:if>
                            </p>
                            <p style="margin-top:9px;padding-left:10px;"> <span style="float:right; margin:0 10px 0 0;">Posted by <strong style="color:#046dbe;">${domainNM}</strong> on <strong style="color:#046dbe;">${ab.postedDate}</strong></span> </p>
                        </div>
                        <div class="my_account_ad_status"style="margin-right:15px;margin-top:15px;  "> <img src="<c:url value='/resourceGetter?imf=${dAdBean.logo}'/>" alt=""  width="95px" height="60px" style="" /> </div>
                    </div>
                </div>
            </div>
            <%--</div>--%>
            <div style="clear:left"></div>
            <div id="smsdiv" style="width:730px;background-color:#4D9EDF;height:20px;"><!-- Sms Div -->
                <table align="left" class="fv11" style="color:#FFFFFF;">
                    <tr style="vertical-align:top">
                        <td style="width:400px;font-weight:normal;" >  ${ab.locality} - ${ab.city}</td>
                        <td style="width:25px;"><img src="<c:url value='/bbsimages/blank.gif'/>" class="latestAdSms mail" style="vertical-align:top" alt=""/></td>
                        <td style="width:100px;"><a title="Send details to friend" href="javascript:return false" style="color:#FFFFFF;" onclick="toggle_email_it('email${ab.adId}');event.returnValue=false;return false;"> Send To Friend</a></td>
                        <td style="width:25px;"><img src="<c:url value='/bbsimages/blank.gif'/>" class="latestAdSms sms" alt=""/></td>
                        <td style="width:100px;"><a title="Send SMS to the Ad Advertiser" href="javascript:return false;" style="color:#FFFFFF;" onclick="toggle_sms_it('sms${ab.adId}');event.returnValue=false;return false;">SMS Advertiser</a></td>
                        <td style="width:25px;"><img src="<c:url value='/bbsimages/blank.gif'/>" class="latestAdSms save" alt=""/></td>
                        <td style="width:50px;"> <a title="Save Ad to your Account" href='javascript:return false' style="color:#FFFFFF;" onclick="toggle_save_it('save${ab.adId}');event.returnValue=false;return false;">Save Ad</a></td>
                    </tr>
                </table>
            </div>
            <div style="clear:both;height:5px"> </div>

            <%--    <!-- ********************************************************************************************************** -->
                        <!--   SAVE AD BLOCK STARTS   -->
                        <!-- ********************************************************************************************************** -->
            --%>
            <!-- this works when user not logged in -->
            <div class="boxBorder4" id="save${ab.adId}wl" style="width:725px;float:left;display:none">
                <div id="header" style="width:725px" >
                    <div style="float:left;width:60%;text-align:left;"><span style="font-family:Arial;font-size:10px;font-weight:bold;padding-left:3px">To save this Ad</span>
                        <span style="font-family:Arial;font-size:10px;">&nbsp;(Please Login)</span>
                    </div>
                    <div style="float:left;width:35%;text-align:right;font-size:9px;font-family:Arial;"><a title="Click to Register" href="javascript:return false;" onclick="toggle_qr('nu${ab.adId}','save');event.returnValue=false;return false;">Register</a>&nbsp;|&nbsp;
                        <a title="Click to get your Password" href="javascript:return false;" onclick="toggle_fp('fp${ab.adId}');event.returnValue=false;return false;">Forgot Password</a></div>
                    <div style="float:left;width:5%;text-align:right">
                        <input type="image" src="<c:url value='/images/close.png'/>" onclick="toggle_close_it('save${ab.adId}wl')" style="padding-right: 5px;"/>
                    </div>
                </div>
                <div id="formsave${ab.adId}wl" style="font-family:Arial;font-size:9px;padding: 1px auto;"> <br>
                    <table style="margin:0 auto;">
                        <tr>
                            <td  width="12%" style="text-align:center"> User Id</td>
                            <td> <input id="lsave${ab.adId}wl" name="loginName" style="height:12px;font-size:9px;" type="text" size="35" /></td>
                            <td width="15%" style="text-align:center">Password</td>
                            <td><input id="psave${ab.adId}wl" name="pwd" style="height:12px;font-size:9px;" type="password" size="35" /></td>
                            <td width="15%" style="text-align:right"><input type="image"  src="<c:url value='/bbsimages/buttons/SaveAd.png'/>" onmouseover="this.src='bbsimages/buttons/SaveAd_MouseOver.png'" onmouseout="this.src='bbsimages/buttons/SaveAd.png'" onclick="SaveAdWL('save${ab.adId}wl',${ab.adId})" /></td>
                        </tr>
                    </table>
                </div>
                <div id="loadsave${ab.adId}wl" style="width:auto;padding:2px 0 2px 350px;display:none"> <img src="<c:url value='/images/loading.gif'/>"  style="width:32px;height:32px"/><br></div>
                <span style="padding:0 0 0 150px" class="fv12bc" id="msgsave${ab.adId}wl"> </span>
                <div style="width:737px;height:10px;float:left"></div>
            </div>
            <!-- this works when user already logged in -->
            <div class="boxBorder4" id="save${ab.adId}al" style="width:725px;height:60px;padding:2px 0 10px 0;float:left;display:none">
                <div id="header" style="background-color:#CCC;width:725px" >
                    <div style="float:left;width:60%;text-align:left;"> <span style="font-family:Arial;font-size:10px;font-weight:bold;padding-left:3px"> To Save the Ad</span> </div>
                    <div style="float:left;width:35%;"></div>
                    <div style="float:left;width:5%;text-align:right"> <input type="image" src="<c:url value='/images/close.png'/>" onclick="toggle_close_it('save${ab.adId}al')" style="padding-right: 5px;"/> </div>
                </div>
                <div id="formsave${ab.adId}al" style="font-family:Arial;font-size:9px;padding: 1px auto;"> <br />
                    <table style="margin:0 auto;">
                        <tr>
                            <td class="fv12bc"> This ad will be saved in "MYBBS" by saving here <input type="image"  src="<c:url value='/bbsimages/buttons/SaveAd.png'/>" onmouseover="this.src='<c:url value='/bbsimages/buttons/SaveAd_MouseOver.png'/>'" onmouseout="this.src='<c:url value='bbsimages/buttons/SaveAd.png'/>'" onclick="SaveAdAL('save${ab.adId}al','adId=${ab.adId}')" /> </td>
                        </tr>
                    </table>
                </div>
                <div id="loadsave${ab.adId}al" style="width:auto;padding:2px 0 2px 350px;display:none"> <img src="<c:url value='/images/loading.gif'/>"  style="height:32px;width:32px;"/><br></div>
                <span style="padding:0 0 0 150px" class="fv12bc" id="msgsave${ab.adId}al"> </span>
            </div>
            <%--   <!-- ********************************************************************************************************** -->
               <!--   SAVE AD BLOCK END   -->
               <!-- ********************************************************************************************************** -->

            <!-- ********************************************************************************************************** -->
            <!-- this div for quick registration -->
            <!-- ********************************************************************************************************** -->
            --%>
            <c:if test="${userBean == null}">
                <div class="boxBorder4" id="nu${ab.adId}" style="width:725px;height:109px;float:left;display:none">
                    <div id="header" style="background-color:#CCC;width:725px" >
                        <div style="float:left;width:60%;text-align:left;">
                            <span style="font-family:Arial;font-size:10px;font-weight:bold;padding-left:3px">To Register</span>
                            <span style="font-family:Arial;font-size:10px;">&nbsp;(Please Enter the information)</span>
                        </div>
                        <div style="float:left;width:35%;text-align:right;font-size:9px;font-family:Arial;"><a title="Click to Register" href="javascript:return false;" onclick="toggle_qr('nu${ab.adId}','smsadvt','${ab.adId}','${ab.adId}');event.returnValue=false;return false;">Register</a>&nbsp;|&nbsp;
                            <a title="Click to get your Password" href="javascript:return false;" onclick="toggle_fp('fp${ab.adId}');event.returnValue=false;return false;">Forgot Password</a></div>
                        <div style="float:left;width:5%;text-align:right;"> <input type="image" src="<c:url value='/images/close.png'/>" onclick="toggle_close_it('nu${ab.adId}');" style="padding-right: 5px;" />  </div>
                    </div> <br/>
                    <form name="qrform" id="formnu${ab.adId}" method="get" action="quickReg.do" onsubmit="return validateQuickRegFormLA(this)">
                        <input type="hidden" name="adId" value="nu${ab.adId}" />
                        <table id="tablenu${ab.adId}" border="0" style="font-size:9px;margin:0 auto;margin-top:10px;_margin-top:-14px;" >
                            <tr>
                                <td width=""> User Id </td>
                                <td><input style="height:12px;font-size:9px;width:120px" type="text" name="userName" id="l${ab.adId}" onchange="checkUsName('l${ab.adId}','nu${ab.adId}')" /> </td>
                                <td width=""> Your Name </td>
                                <td width=""> <input style="height:12px;font-size:9px;width:120px"  type="text" name="firstName" id="n${ab.adId}" /> </td>
                                <td style="width:30px" align="right"> City </td>
                                <td> <select size="1"  id="ct${ab.adId}" style="font-size:9px;width:122px;_width:125px;" name="city" >
                                        <option value="" selected="true" >select city</option>
                                        <c:if test="${cities  != null }">
                                            <c:forEach items="${cities}" var="con"><option value="<c:out value='${con.name}'/>"<c:if test='${city != null && city == con.name}' >selected='true'</c:if> ><c:out value="${con.name}"/></option></c:forEach>
                                        </c:if>
                                    </select>
                                </td>
                                <td align="right"> Phone No </td>
                                <td> <input style="height:12px;font-size:9px;width:120px" type="text" name="mobile" id="ph${ab.adId}" /> </td>
                            </tr>
                            <tr>
                                <td>&nbsp;</td>
                                <td  style="width:130px;" align="center" valign="middle">  <img alt="" id="verIdnu${ab.adId}" src="rig" style="height:21px;width:100px"/>&nbsp;
                                    <a title="Click to Change Verification code" class="link11" href="javascript:return false;" onclick="changeVrificationCodeQr('verIdnu${ab.adId}');event.returnValue=false;return false;"><img border="0" alt="verificationCode" src="<c:url value='/bbsimages/referesh_button.jpg'/>" style="height:24px;width:24px;"/></a>
                                </td>
                                <td> Enter&nbsp;Code </td>
                                <td> <input id="vrCode${ab.adId}" type="text" name="regCode" style="width:120px;font-size:9px;" onblur="qrCheckRegCode('vrCode${ab.adId}','nu${ab.adId}')"> </td>
                                <td align="right"> <input type="checkbox" name="iagree" ></td>
                                <td><a title="View terms and conditions" href="javascript:return false;" onclick="termsAndConditions('tc.do');event.returnValue=false;return false;" style="color:#046DBE">I agree Terms &amp; Conditions.</a></td>
                                <td></td>
                                <td width="">
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input type="image" id="butdnu${ab.adId}"  src="<c:url value='/bbsimages/buttons/RegisterSDis.png'/>" disabled />
                                    <input type="image"  src="<c:url value='/bbsimages/buttons/RegisterS.png'/>'" disabled onmouseover="this.src='<c:url value='/bbsimages/buttons/RegisterS_MouseOver.png'/>'" onmouseout="this.src='<c:url value='/bbsimages/buttons/RegisterS.png'/>'" id="butnu${ab.adId}" style="display:none" />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">&nbsp</td>
                                <td colspan="4" align="center"><span id="codeTestNonu${ab.adId}" name="codeTestNo" style="color:red;font-size:10px;display:none" >Verification doesn't matched</span></td>
                                <td colspan="2">&nbsp</td>
                            </tr>
                        </table>
                        <div class="fv12bc" style="text-align:center" id="msgnu${ab.adId}"></div>
                        <div class="fv11b" style="text-align:center;" id="confnu${ab.adId}" ></div>
                        <div id="imgnu${ab.adId}" style="display:none;text-align:center">Loading...</div>
                    </form>
                </div>
            </c:if>
            <c:if test="${userBean != null}"> <div class="boxBorder4" id="nu${ab.adId}" style="width:725px;float:left;display:none"></div> </c:if>
            <%--
                        <!-- ********************************************************************************************************** -->
                        <!-- this div for quick registration end -->
                        <!-- ********************************************************************************************************** -->

            <!-- ********************************************************************************************************** -->
            <!-- this div for forget password -->
            <!-- ********************************************************************************************************** -->--%>

            <c:if test="${userBean == null }" >
                <div class="boxBorder4" id="fp${ab.adId}" style="width:725px;float:left;display:none">
                    <div id="header" style="background-color:#CCC;width:725px" >
                        <div style="float:left;width:60%;text-align:left;">
                            <span style="font-family:Arial;font-size:10px;font-weight:bold;padding-left:3px">To Reset Your Password</span>
                            <span style="font-family:Arial;font-size:10px;">&nbsp;(Please Enter the information)</span>
                        </div>
                        <div style="float:left;width:35%;text-align:right;font-size:9px;font-family:Arial;"><a title="Click to Register" href="javascript:return false;" onclick="toggle_qr('nu${ab.adId}','smsadvt','${ab.adId}','${ab.adId}');event.returnValue=false;return false;">Register</a>&nbsp;|&nbsp;
                            <a title="Click to get your Password" href="javascript:return false;" onclick="toggle_fp('fp${ab.adId}');event.returnValue=false;return false;">Forgot Password</a></div>
                        <div style="float:left;width:5%;text-align:right;"> <input type="image" src="<c:url value='/images/close.png'/>" onclick="toggle_close_it('fp${ab.adId}')" style="padding-right: 5px;"/> </div>
                    </div>
                    <div id="fpfp${ab.adId}" style="font-family:Arial;font-size:9px;margin:0 auto;"> <br><br/><br>
                        <table style="margin:0 auto;_margin-top:-12px;">
                            <tr><td>Enter Email Id</td><td>&nbsp;</td>
                                <td><input id="emfp${ab.adId}" style="height:12px;font-size:9px;width:150px" type="text" /></td>
                                <td>&nbsp;&nbsp;</td><td>Enter Mobile Number</td><td>&nbsp;</td>
                                <td><input id="yfp${ab.adId}" style="height:12px;font-size:9px;width:150px" type="text" /></td>
                                <td><span style="padding-left:20px">
                                        <input type="image"  src="<c:url value='/bbsimages/buttons/ResetPasswordS.png'/>" onmouseover="this.src='<c:url value='/bbsimages/buttons/ResetPasswordS_MouseOver.png'/>'" onmouseout="this.src='<c:url value='/bbsimages/buttons/ResetPasswordS.png'/>'" onclick="sendPassword('fp${ab.adId}');event.returnValue=false;return false;"/>
                                    </span></td></tr></table>
                    </div>
                    <div id="imgfp${ab.adId}" style="width:auto;padding:2px 0 2px 350px;display:none"> Loading... </div>
                    <span style="padding:0 0 0 150px" class="fv12bc" id="msgfp${ab.adId}">  </span>
                    <div style="width:737px;height:5px;float:left"></div>
                </div>
            </c:if>
            <c:if test="${userBean != null }" > <div class="boxBorder4" id="fp${ab.adId}" style="width:725px;float:left;display:none"> </div>  </c:if>
            <%-- <!-- ********************************************************************************************************** -->
             <!--End  div for forget password -->
             <!-- ********************************************************************************************************** -->

            <!-- #############################################################################################################
                                                     DIV FOR SMS TO ADVERTISER STARTS
                 #############################################################################################################-->--%>

            <div id="sms${ab.adId}wl" class="boxBorder4" style="width:725px;float:left;display:none">
                <div id="header" style="background-color:#CCC;width:725px" >
                    <div style="float:left;width:60%;text-align:left;">
                        <span style="font-family:Arial;font-size:10px;font-weight:bold;padding-left:3px">Sms To Advertiser</span>
                        <span style="font-family:Arial;font-size:10px;">&nbsp;(Please Enter the information)</span>
                    </div>
                    <div style="float:left;width:35%;text-align:right;font-size:9px;font-family:Arial;"><a title="Click to Register" href="javascript:return false;" onclick="toggle_qr('nu${ab.adId}','smsadvt','${ab.adId}','${ab.adId}');event.returnValue=false;return false;">Register</a>&nbsp;|&nbsp;
                        <a title="Click to get your Password" href="javascript:return false;" onclick="toggle_fp('fp${ab.adId}');event.returnValue=false;return false;">Forgot Password</a></div>
                    <div style="float:left;width:5%;text-align:right"> <input type="image" src="<c:url value='/images/close.png'/>" onclick="toggle_close_it('sms${ab.adId}wl')" style="padding-right: 5px;"/> </div>
                </div>   <br>

                <div id="formsms${ab.adId}wl" style="font-family:Arial;font-size:9px;padding:1px auto">
                    <table style="margin: 10px auto;_margin-top: -10px;">
                        <tr> <input type="hidden" id="msms${ab.adId}wl" value="${ab.adId}" /> <%-- mobile--%>
                        <input type="hidden" id="adtsms${ab.adId}wl" value="${ab.title}" />
                        <td  width="12%" style="text-align:left">User Id</td>
                        <td ><input style="height:12px;font-size:9px;" id="lsms${ab.adId}wl" type="text" size="35"  /></td>
                        <td  width="12%" style="text-align:left">Password</td>
                        <td><input style="height:12px;font-size:9px;" id="psms${ab.adId}wl" type="password" size="35"   /></td>
                        </tr>
                        <t>
                            <td>Message</td>
                            <td colspan="3"><input style="height:12px;font-size:9px;width:405px;_width:415px" type="text" readonly value="Hi, I am insterested in your ad, please contact me, I need more information about your Ad." /></td>
                            <td> <input type="image" src="<c:url value='/bbsimages/buttons/SendSMS.png'/>" onmouseover="this.src='<c:url value='/bbsimages/buttons/SendSMS_MouseOver.png'/>'" onmouseout="this.src='<c:url value='/bbsimages/buttons/SendSMS.png'/>'" onclick="smsAdvertiserWL('sms${ab.adId}wl','${ab.adId}')" /></td>
                            </tr>
                    </table>
                </div>
                <div id="loadsms${ab.adId}wl" style="width:auto;padding:2px 0 2px 350px;display:none"> <img src="<c:url value='/images/loading.gif'/>" style="height:32px;width:32px;" /><br></div>
                <span style="padding:0 0 0 150px" class="fv12bc" id="msgsms${ab.adId}wl"> </span>
            </div>
            <div id="sms${ab.adId}al" class="boxBorder4" style="width:725px;height:60px;float:left;display:none;padding:2px 0 10px 0">
                <div id="header" style="background-color:#CCC;width:725px" >
                    <div style="float:left;width:60%;text-align:left;"> <span style="font-family:Arial;font-size:10px;font-weight:bold;padding-left:3px">Sms To Advertiser</span> </div>
                    <div style="float:left;width:35%;text-align:right;font-size:9px;font-family:Arial;"> </div>
                    <div style="float:left;width:5%;text-align:right"> <input type="image" src="<c:url value='/images/close.png'/>" onclick="toggle_close_it('sms${ab.adId}al')" style="padding-right: 5px;"/> </div>
                </div>
                <div id="formsms${ab.adId}al" style="font-family:Arial;font-size:9px;padding: 1px auto;"> 
                    <br /><input type="hidden" id="msms${ab.adId}al" value="${ab.mobile}" />         <%--mobile--%>
                    <input type="hidden" id="adtsms${ab.adId}al" value="${ab.title}" />
                    <table style="margin:0 auto;">
                        <tr>
                            <td><input type="text" size="92" style="height:12px;font-size:9px;" readonly value="Hi, I am insterested in your ad, please contact me, I need more information about your Ad."/></td>
                            <td><input type="image" src="<c:url value='/bbsimages/buttons/SendSMS.png'/>" onmouseover="this.src='<c:url value='/bbsimages/buttons/SendSMS_MouseOver.png'/>'" onmouseout="this.src='<c:url value='/bbsimages/buttons/SendSMS.png'/>'" onclick="smsAdvertiserAL('sms${ab.adId}al','${ab.adId}')" /></td>
                        </tr>
                    </table>
                </div>
                <div id="loadsms${ab.adId}al" style="width:auto;padding:2px 0 2px 350px;display:none"> <img src="<c:url value='/images/loading.gif'/>" alt="loading" style="height:32px;width:32px;"/><br></div>
                <span  style="padding:0 0 0 150px;" class="fv12bc" id="msgsms${ab.adId}al"> </span>
            </div>

            <%--         <!-- #############################################################################################################
                                                  DIV FOR SMS TO ADVERTISER ENDS
              #############################################################################################################-->

            <!-- #############################################################################################################
                                                     DIV FOR E-MAIL TO FRIEND  STARTS
                 #############################################################################################################-->

            <!-- email to  friend for without login  users -->
            --%>
            <div class="boxBorder4" id="email${ab.adId}wl"  style="width:725px;float:left;display:none;">
                <div id="header" style="background-color:#ffcc33;width:725px;" >
                    <div style="float:left;width:60%;text-align:left;"><span style="font-family:Arial;font-size:10px;font-weight:bold;padding-left:3px">To Email this Ad to Friend</span>
                        <span style="font-family:Arial;font-size:10px;">&nbsp;(Please Enter the information)</span>
                    </div>
                    <div style="float:left;width:35%;text-align:right;font-size:9px;font-family:Arial;"><a title="Click to Register" href="javascript:return false;" onclick="toggle_qr('nu${ab.adId}','emailFriend');event.returnValue=false;return false; ">Register</a>&nbsp;|&nbsp;
                        <a title="Click to get ypur Password" href="javascript:return false;" onclick="toggle_fp('fp${ab.adId}');event.returnValue=false;return false;">Forgot Password</a></div>
                    <div style="float:left;width:5%;text-align:right"> <input type="image" src="<c:url value='/images/close.png'/>" onclick="toggle_close_it('email${ab.adId}wl')" style="padding-right: 5px;"/>  </div>
                </div>    <br />
                <div id="formemail${ab.adId}wl" style="font-family:Arial;font-size:9px;padding:1px auto">
                    <table style="margin: 10px auto;_margin-top: -10px;">
                        <tr>
                            <td  width="12%" style="text-align:left">Friend's Name </td>
                            <td><input style="height:12px;font-size:9px;" id="fnemail${ab.adId}wl" type="text" size="35"   /> </td>
                            <td width="6%" > &nbsp;</td>
                            <td  width="12%" style="text-align:left">Friend's Email </td>
                            <td><input style="height:12px;font-size:9px;" id="feemail${ab.adId}wl" type="text" size="35"   /> </td>
                            <td> &nbsp;</td>
                        </tr>
                        <tr>
                            <td  width="12%" style="text-align:left">User Id</td>
                            <td><input style="height:12px;font-size:9px;" id="lemail${ab.adId}wl" type="text" size="35"  /></td>
                            <td width="6%" > &nbsp;</td>
                            <td  width="12%" style="text-align:left">Password</td>
                            <td><input style="height:12px;font-size:9px;_width:160px;" id="pemail${ab.adId}wl" type="password" size="35"   /></td>
                            <td  width="15%" style="text-align:right"><input type="image" src="<c:url value='/bbsimages/buttons/SendEmail.png'/>" onmouseover="this.src='<c:url value='/bbsimages/buttons/SendEmail_MouseOver.png'/>'" onmouseout="this.src='<c:url value='/bbsimages/buttons/SendEmail.png'/>'"  onclick="sendToFriendWL('email${ab.adId}wl','${ab.adId}','${ab.title}','${ab.catId}')" /></td>
                        </tr>
                    </table>
                </div>
                <div id="loademail${ab.adId}wl" style="width:auto;padding:2px 0 2px 350px;display:none"> <img src="<c:url value='/images/loading.gif'/>" style="height:32px;width:32px;" /><br></div>
                <span style="padding:0 0 0 150px" class="fv12bc" id="msgemail${ab.adId}wl"> </span>
            </div>

            <!-- email to  friend for logged in users  -->

            <div id="email${ab.adId}al" class="boxBorder4" style="width:725px;height:60px;float:left;display:none;padding:2px 0 10px 0;">
                <div id="header" style="background-color:#ffcc33;width:725px" >
                    <div style="float:left;width:60%;text-align:left;">
                        <span style="font-family:Arial;font-size:10px;font-weight:bold;padding-left:3px">To Email this Ad to Friend</span> <span style="font-family:Arial;font-size:10px;">&nbsp;(Please Enter the information)</span>
                    </div>
                    <div style="float:left;width:35%;"> </div>
                    <div style="float:left;width:5%;text-align:right">
                        <input type="image" src="<c:url value='/images/close.png'/>" onclick="toggle_close_it('email${ab.adId}al')" style="padding-right: 5px;"/>
                    </div>
                </div> <br />
                <div id="formemail${ab.adId}al" style="font-family:Arial;font-size:9px;padding: 1px auto;">
                    <table style="margin:0 auto;font-size:9px; margin-top:00px;">
                        <tr>
                            <td  width="12%" style="text-align:left">Friend's Name </td>
                            <td><input style="height:12px;font-size:9px;" id="fnemail${ab.adId}al" type="text" size="35" name="friendName"  /> </td>
                            <td width="6%" > &nbsp;</td>
                            <td  width="12%" style="text-align:left">Friend's Email </td>
                            <td><input style="height:12px;font-size:9px;" id="feemail${ab.adId}al" type="text" size="35" name="friendEmail" /> </td>
                            <td  width="15%" style="text-align:right"><input type="image" src="<c:url value='/bbsimages/buttons/SendEmail.png'/>" onmouseover="this.src='<c:url value='/bbsimages/buttons/SendEmail_MouseOver.png'/>'" onmouseout="this.src='<c:url value='/bbsimages/buttons/SendEmail.png'/>'" onclick="sendToFriendAL('email${ab.adId}al','${ab.adId}','${ab.title}','${ab.catId}')" /></td>
                        </tr>
                    </table>
                </div>
                <div id="loademail${ab.adId}al" style="width:auto;padding:2px 0 2px 350px;display:none"> <img src="<c:url value='/images/loading.gif'/>" style="height:32px;width:32px;" /><br></div>
                <span  style="padding:0 0 0 150px;" class="fv12bc" id="msgemail${ab.adId}al"> </span></div>
                <%--
            <!-- #############################################################################################################
                                         DIV FOR E-MAIL TO FRIEND  ENDS
     #############################################################################################################-->--%>
            <!-- latestads part end here -->
            <div style="height:10px;width:100%;"></div>
            <!-- this part used to display commercial ads after every 5 ads -->
            <c:set var="i"  value="${i + 1}" />
            <c:if test='${i == 5}' >
                <%--<div><img src="bbsimages/home_img.gif" style="height:65px;width:740px"/></div><br />--%>
                <c:set var="i" value="0" />
            </c:if>
            <div style="clear:both"> </div>
            <div  id="dr" style="display:none"></div>
            <div id="myAccount" style="display:none"></div>
            <div id="login" style="display:none"></div>
            <div id="guest" style="display:none"></div>
            <div id="guest1" style="display:none"></div>
        </c:forEach>
    </c:when>
    <c:otherwise>
        <div class="fv11b" style="text-align:center;color:#EA052B;font-size:14px"> No Ads found for this Dealer !</div>
    </c:otherwise>
</c:choose>