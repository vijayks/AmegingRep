<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page  import="com.buysell.beans.AdsResultsBean" %>
<%@page  import="java.io.OutputStream " %>
<%@page  import="java.io.FileInputStream " %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn"%>

<link href="images/lytebox/fbox.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="images/lytebox/fbox_conf.js"></script>
<script type="text/javascript" src="images/lytebox/fbox_engine-min.js"></script>
<script type="text/javascript" language="javascript" src="js/inlineRequestResolveAjax.js"></script>
<script type="text/javascript" src="highslide/highslide-with-html.js"></script>
<link rel="stylesheet" type="text/css" href="highslide/highslide.css" />
<script type="text/javascript">
    hs.graphicsDir = 'highslide/graphics/';
    hs.outlineType = 'rounded-white';
    hs.wrapperClassName = 'draggable-header';
</script>
<script type="text/javascript">

    var emailAL=new Array();
    var smsAL=new Array();
    var count=0;

    function chkAll()
    {
        active =document.getElementsByName("box");
        commons(active,"checked");
        return false;
    }

    function unchkAll(){

        active =document.getElementsByName("box");
        commons(active,"");
        return false;
    }

    function commons(item,checked){

        for (i = 0; i < item.length; i++)
        {
            item[i].checked =checked;
        }
        return false;
    }

    function toggle_sms_it_SA(itemId){
        document.getElementById("msg"+itemId+"al").innerHTML="";

        for(var i=0;i<smsAL.length;i++)
        {

            toggle_close_it_SA(smsAL[i]) ;
            toggle_close_it_SA(emailAL[i]) ;
        }

        toggle_open_it_SA(itemId+"al");
        toggle_open_it_SA('form'+itemId+"al");//make inline which was individually make none
        return false;

    }

    function toggle_email_it_SA(itemId){

        document.getElementById("msg"+itemId+"al").innerHTML="";
        for(var i=0;i<smsAL.length;i++)
        {

            toggle_close_it_SA(smsAL[i]) ;
            toggle_close_it_SA(emailAL[i]) ;
        }

        toggle_open_it_SA(itemId+"al");
        toggle_open_it_SA('form'+itemId+"al");//make inline which was individually make none
        return false;
    }

    function smsAdvertiserAL_SA(itemId,qrystr)
    {
        showingLoading(itemId);
        var qrystr="adId="+itemId+"&mobile="+document.getElementById("m"+itemId).value+"&adTitle="+document.getElementById("adt"+itemId).value;

        smsAdvertiserAjaxFun(itemId,qrystr);
        return false;
    }

    function sendToFriendAL_SA(itemId,adId)
    {

        showingLoading(itemId);
        var qrystr="adId="+adId+"&fName="+document.getElementById("fn"+itemId).value+"&fEmail="+document.getElementById("fe"+itemId).value;

        sendToFriendAjaxFun(itemId,qrystr);
        return false;
    }

    function toggle_close_it_SA(itemId)
    {

        document.getElementById(itemId).style.display='none';
        return false;

    }

    function toggle_open_it_SA(itemId)
    {

        document.getElementById(itemId).style.display='inline';
        return false;

    }

    function showingLoading(itemId)
    {
        document.getElementById("msg"+itemId).innerHTML="";// erase prev o/p
        toggle_close_it_SA("form"+itemId);//make none to show process
        toggle_open_it_SA("load"+itemId); // display loading img
        return false;
    }
</script>

<div id="sortBar" style="text-align:left;color:#ffffff;width:730px;float:left;height:28px;padding-top:9px;margin-top:10px; background:url(bbsimages/sortBy.jpg) no-repeat;">
    <span class="verdana_menu_head" style="padding-left:15px;" >My Saved Ads</span>
</div>
<logic:present name="mySavedAdsResultsBean" property="results">
    <bean:size id="size" name="mySavedAdsResultsBean" property="results"/>
    <c:if test="${saveAdResult != null}">
        <div class="fv11b" style="float:left;width:720px;height:15px;text-align:center;color:#008800;"><c:out value="${saveAdResult}" /></div>
    </c:if>
    <logic:equal name="size" value="0">
        <div class="fv11b" style="float:left;width:720px;height:15px;text-align:center;color:#EA052B;">No ads found under requested criteria.</div>
    </logic:equal>
    <logic:greaterThan name="size" value="0">
        <form action="delete_my_saved_ads.do">
            <div  style="width:720px;float:left;height:20px;">
                <div  class="fv12" style="width:5%;float:left;height:16px;padding-top:4px;padding-left:5px;">  Select </div>
                <div class="fv12bc" style="width:5%;float:left;height:16px;padding-top:4px;" align="right"> <a title="All" class="fv12bc" href="javascript:return false;" onClick="chkAll()">All</a> </div>
                <div class="fv12bc" style="width:12%;float:left;height:16px;padding-top:4px;" align="center"> <a title="None" class="fv12bc" href="javascript:return false;" onClick="unchkAll()">None</a></div>
                <div  style="width:75%;float:left;height:20px;" align="right"><input type="image" src="bbsimages/buttons/Delete.png" onmouseover="this.src='bbsimages/buttons/Delete_MouseOver.png';" onmouseout="this.src='bbsimages/buttons/Delete.png';" /> </div>
            </div>
            <div style="clear:both;width:720px;height:15px;"></div>
            <logic:iterate id="result"  name="mySavedAdsResultsBean" property="results">
                <script  type="text/javascript" language="javascript">
                    smsAL[count]="sms"+<bean:write name="result" property="adId" />+"al";
                    emailAL[count]="email"+<bean:write name="result" property="adId" />+"al";
                    count++;
                </script>

                <% String name = "status";%>
                <logic:equal name="result" property="status" value="1">
                    <% name = "Active";%>
                </logic:equal>

                <logic:equal  name="result" property="status" value="2">
                    <% name = "On Hold";%>
                </logic:equal>

                <logic:equal name="result" property="status" value="4">
                    <% name = "Expired";%>
                </logic:equal>

                <logic:equal name="result" property="status" value="5">
                    <% name = "Deleted";%>
                </logic:equal>

                <logic:equal name="result" property="status" value="6">
                    <% name = "Incomplete";%>
                </logic:equal>

                <div class="" style="width:720px;">
                    <div  style="height:110px;" >
                        <div class="my_account_ad_bg_cont" style="background:white" onmouseover="this.style.background='whitesmoke';" onmouseout="this.style.background='white';">
                            <input type="checkbox" style="margin:1px;float:left " name="box" value="<bean:write name="result" property="savedId" />" />
                            <div class="my_account_ad_cont">
                                <div class="my_account_ad_bg">
                                    <div class="my_account_ad_img"> <a title="Ad Image" class="imglink"  > <c:set var="adimg"><bean:write name="result"  property="image1" /></c:set>
                                            <c:if test='${adimg != "" && adimg != "null" }'> <img src="resourceGetter?imf=<bean:write name="result"  property="image1" />" width="75px" height="75px" style="border:none"  > </c:if>
                                            <c:if test='${adimg == "" || adimg == "null"}'> <img src="bbsimages/No_Image.png" width="75px" height="75px" style="border:none"  > </c:if>
                                        </a>
                                    </div>
                                </div>
                                <div class="my_account_ad_more_details"><li><a title="More Details" href="moreDetails.do?adId=<bean:write name="result" property="adId"  />&catId=<bean:write name="result" property="catId"  />"#moredetail" onclick="return hs.htmlExpand(this, { objectType: 'ajax'} )">More Details...</a></li></div>
                            </div>
                            <div class="my_account_ad_left_txt_cont"><strong style="color:#046dbe;">
                                    <a title="<bean:write name="result" property="title" />" class="link" style="font-size:11px;color:#046DBE"  href="moreDetails.do?adId=<bean:write name="result" property="adId"  />&catId=<bean:write name="result" property="catId"  />"#moredetail" onclick="return hs.htmlExpand(this, { objectType: 'ajax'} )">
                                        <bean:write name="result" property="title" />
                                        <c:set var="ku" > <bean:write name="result" property="catId" /></c:set>
                                        <c:if test="${categoryList != null}" >
                                            <c:forEach items="${categoryList}" var="cat">
                                                <c:if test="${cat.id == ku}" >
                                                    <c:set var="par">${cat.parent} </c:set> </c:if>
                                            </c:forEach>
                                        </c:if>
                                        <!-- this block to get parent category id name -->

                                        <c:if test="${categoryList != null}" >
                                            <c:forEach items="${categoryList}" var="cat">
                                                <c:if test="${cat.id == par}" >
                                                    (<c:out value="${cat.name}" escapeXml="false"/>)
                                                </c:if>
                                            </c:forEach>
                                        </c:if>
                                    </a>
                                </strong><br />
                                <p style="margin-top:2px;">
                                    <c:if test="${fn:length(result.description) <= 265 }" >
                                        <c:out value="${result.description}" />
                                    </c:if>
                                    <c:if test="${fn:length(result.description) > 265 }" >
                                        <c:out value="${fn:substring(result.description,0,265)}" />&nbsp;&nbsp;<a title="More Details" href="moreDetails.do?adId=<bean:write name="result" property="adId"  />&catId=<bean:write name="result" property="catId"  />#moredetail" onclick="return hs.htmlExpand(this, { objectType: 'ajax'} )" ><span style="color:#046dbe">More...</span></a>
                                    </c:if>
                                </p>
                                <p style="margin-top:5px;">
                                    <logic:equal name="result" property="adType" value="wanted">

                                        <span class="fv11b" >Rs.</span><bean:write name="result" property="min" />0 to <bean:write name="result" property="max" />0
                                    </logic:equal>

                                    <logic:equal name="result" property="adType" value="offered">
                                        <logic:notEqual name="result" property="cfp" value="on">
                                            <span class="fv11b" >Rs.</span><bean:write name="result" property="price" />0&nbsp;&nbsp;(<logic:equal name="result" property="neg" value="yes">Neg</logic:equal><logic:equal name="result" property="neg" value="no">Not-Neg</logic:equal>)
                                        </logic:notEqual>
                                        <logic:equal name="result" property="cfp" value="on">
                                            <span class="fv11bc" style="padding-right:2px">Contact for Price</span>
                                        </logic:equal>
                                    </logic:equal>
                                    <span style="float:right; margin:0 10px 0 0;">Posted By <strong style="color:#046dbe;"> <bean:write name="result" property="firstName" /></strong> on <strong style="color:#046dbe;"><bean:write name="result" property="postedDate"/> </strong></span>
                                </p>
                            </div>
                            <div class="my_account_ad_status"><div class="my_account_ad_status_txt"> <%= name%></div> </div>
                        </div>
                    </div>

                    <!-- main div ends here -->
                    <!--    <div style="float:left;width:85px;" align="center"> <img alt="" src="resourceGetter?imf=blankimage.png"  width="80px" height="65px" align="center" style="padding-top:5px;padding-bottom:5px" />                                           </div>-->
                </div>
                 <div style="width:720px;height:18px;padding-top:5px; border-bottom: 1px dashed #CCCCCC; ">

                    <table  class="fv11b" style="color:#333333;">
                        <tr>
                            <td style="width:400px;text-align:left">Location - <bean:write name="result" property="city"/></td>
                            <td style="width:25px;"><img src="bbsimages/mail.gif" style="height:13px;" /></td>
                            <td style="width:100px;"><a title="Send to Friend"href="javascript:return false" style="color:#333333;text-decoration: none" onmouseout="style.color= '#333333'"  onmouseover="style.color= '#FF6600'" onclick="return toggle_email_it_SA('email<bean:write name="result" property="adId" />');event.returnValue=false;return false;"> Send To Friend</a></td>
                            <td style="width:25px;"><img src="bbsimages/sms.gif" style="height:13px;" /></td>
                            <td style="width:100px;"><a title="SMS Advertiser" href="javascript:return false;" style="color:#333333;text-decoration: none" onmouseout="style.color= '#333333'" onmouseover="style.color= '#FF6600'"  onclick="return toggle_sms_it_SA('sms<bean:write name='result' property='adId' />');event.returnValue=false;return false;">SMS Advertiser</a></td>
                        </tr>
                    </table>
                </div>

                <!-- #############################################################################################################
                                 DIV FOR SMS TO ADVERTISER STARTS
#############################################################################################################-->


                <div id="sms<bean:write name='result' property='adId' />al" class="" style="width:718px;float:left;display:none;padding:2px 0 10px 0;margin-left:5px; border-bottom: 1px dashed #CCCCCC; ">
                    <div id="header" style="background-color:#CCC;width:735px" >
                        <div style="float:left;width:60%;text-align:left;padding-left:10px;margin-top: 5px;">
                            <span style="font-family:Arial;font-size:10px;font-weight:bold;">Sms To Advertiser</span>
                        </div>
                        <div style="float:left;width:33%;text-align:right;font-size:9px;font-family:Arial;">
                        </div>
                        <div style="float:left;">
                            <input type="image" src="bbsimages/c1.png" title="Close" onclick="return toggle_close_it_SA('sms<bean:write name="result" property="adId" />al')"/>
                        </div>
                    </div>
                    <div id="formsms<bean:write name='result' property="adId" />al" style="font-family:Arial;font-size:9px;padding-left:20px;float:left">
                        <br /><input type="hidden" id="msms<bean:write name='result' property="adId" />al" value="<bean:write name='result' property="mobile" />" />
                        <input type="hidden" id="adtsms<bean:write name='result' property="adId" />al" value="<bean:write name='result' property="title" />" />
                        <table style="margin:0 auto;">
                            <tr>
                                <td>  <input type="text" size="92" style="height:12px;font-size:9px;" readonly value="Hi, I am insterested in your ad, please contact me, I need more information about your Ad."/></td>
                                <td> &nbsp; &nbsp; &nbsp;</td>
                                <td><input type="image" src="bbsimages/buttons/SendSMS.png" onmouseover="this.src='bbsimages/buttons/SendSMS_MouseOver.png'" onmouseout="this.src='bbsimages/buttons/SendSMS.png'" onclick="return smsAdvertiserAL_SA('sms<bean:write name='result' property="adId" />al','<bean:write name='result' property="adId" />')" /></td>

                            </tr>
                        </table>
                    </div>
                    <div id="loadsms<bean:write name='result' property="adId" />al" style="width:auto;padding:2px 0 2px 350px;display:none"> <img alt="" src="images/loading.gif" /><br></div>
                    <span  style="padding:0 0 0 150px;" class="fv12bc" id="msgsms<bean:write name='result' property="adId" />al"> </span>
                </div>
                <div style="clear:both"></div>
                <!-- #############################################################################################################
                                             DIV FOR SMS TO ADVERTISER ENDS
         #############################################################################################################-->


                <!-- #############################################################################################################
                                                         DIV FOR E-MAIL TO FRIEND  STARTS
                     #############################################################################################################-->


                <!-- email to  friend for logged in users  -->

                <div id="email<bean:write name="result" property="adId" />al" class="" style="width:718px;float:left;display:none;padding:2px 0 10px 0;margin-left:5px; border-bottom: 1px dashed #CCCCCC;">
                    <div id="header" style="background-color:#ffcc33;width:735px" >
                        <div style="float:left;width:60%;text-align:left;padding-left:10px;">
                            <span style="font-family:Arial;font-size:10px;font-weight:bold;padding-left:3px">To Email this Ad to Friend</span> <span style="font-family:Arial;font-size:10px;">&nbsp;(Please Enter the information)</span>
                        </div>
                        <div style="float:left;width:33%;">
                        </div>
                        <div style="float:left;">
                            <input type="image" src="bbsimages/c1.png" onclick="return toggle_close_it_SA('email<bean:write name="result" property="adId" />al')"/>
                        </div>
                    </div>
                    <br />
                    <div id="formemail<bean:write name='result' property="adId" />al" style="font-family:Arial;font-size:9px;padding-top:1px;float:left;width:650px;padding-left: 20px; ">
                        <br />
                        <table style="margin:0 auto;font-size:9px">
                            <tr>
                                <td  width="30%" style="text-align:left">Friend's Name </td>
                                <td><input style="height:12px;font-size:9px;" id="fnemail<bean:write name='result' property="adId" />al" type="text" size="35" name="friendName"  /> </td>
                                <td width="15%" > &nbsp;</td>
                                <td  width="30%" style="text-align:left">Friend's Email </td>
                                <td><input style="height:12px;font-size:9px;" id="feemail<bean:write name='result' property="adId" />al" type="text" size="35" name="friendEmail" /> </td>
                                <td  width="25%" style="text-align:right"><input type="image" src="bbsimages/buttons/SendEmail.png" onmouseover="this.src='bbsimages/buttons/SendEmail_MouseOver.png'" onmouseout="this.src='bbsimages/buttons/SendEmail.png'" onclick="return sendToFriendAL_SA('email<bean:write name='result' property="adId" />al','<bean:write name='result' property="adId" />')" /></td>
                            </tr>
                        </table>
                    </div>
                    <div id="loademail<bean:write name='result' property="adId" />al" style="width:auto;padding:2px 0 2px 350px;display:none"> <img alt="" src="images/loading.gif" /><br></div>
                    <span  style="padding:0 0 0 150px;" class="fv12bc" id="msgemail<bean:write name='result' property="adId" />al"> </span>
                </div>
                <div style="clear:both;height:8px;"></div>


                <!-- #############################################################################################################
                                             DIV FOR E-MAIL TO FRIEND  ENDS
         #############################################################################################################-->


            </logic:iterate>
            <div  style="width:720px;float:left;height:20px;padding-bottom:6px;">
                <div  class="fv12" style="width:5%;float:left;height:16px;padding-top:4px;padding-left:5px;">  Select </div>
                <div class="fv12bc" style="width:5%;float:left;height:16px;padding-top:4px;" align="right"> <a title="All" class="fv12bc" href="javascript:return false;" onClick="chkAll()">All</a> </div>
                <div class="fv12bc" style="width:12%;float:left;height:16px;padding-top:4px;" align="center"> <a title="None" class="fv12bc" href="javascript:return false;" onClick="unchkAll()">None</a></div>
                <div  style="width:75%;float:left;height:20px;" align="right"><input type="image" src="bbsimages/buttons/Delete.png" onmouseover="this.src='bbsimages/buttons/Delete_MouseOver.png';" onmouseout="this.src='bbsimages/buttons/Delete.png';" /> </div>
            </div>

            <div style="clear:both;width:720px;height:10px;"></div>
        </form>

    </logic:greaterThan>
</logic:present>

