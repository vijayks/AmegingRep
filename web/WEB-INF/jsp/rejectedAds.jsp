<%--
    Document   : latestAds
    Created on : Mar 4, 2009, 8:18:33 PM
    Author     : bbsadmin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page  import="com.buysell.beans.AdsResultsBean" %>
<%@page  import="java.io.OutputStream " %>
<%@page  import="java.io.FileInputStream " %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<div id="sortBar" style="text-align:left;color:#ffffff;width:720px;float:left;height:30px;padding-top:9px;background:url(bbsimages/sortBy.jpg) no-repeat;">
    <span class="verdana_menu_head" style="padding-left:15px;" >Rejected Ads</span>
</div>
<logic:present name="RejectedAdsList" >
    <bean:size id="size" name="RejectedAdsList" />
    <logic:equal name="size" value="0">
        <div class="fv11b" style="width:740px;height:15px;text-align:center;color:#EA052B;float: left">No ads found under requested criteria.</div>
    </logic:equal>
    <logic:greaterThan name="size" value="0">
        <div style="clear:both;"></div>
        <div style="width:720px;height:10px;"> </div>
        <logic:iterate id="result"  name="RejectedAdsList" >
            <div class="" style="width:720px;">
                <div  style="height:110px;" >
                    <div class="my_account_ad_bg_cont" style="background:white; border-bottom: 1px dashed #CCCCCC;padding-bottom: 5px;" onmouseover="this.style.background='whitesmoke';" onmouseout="this.style.background='white';">       
                        <div class="my_account_ad_cont">
                            <div class="my_account_ad_bg">
                                <div class="my_account_ad_img">
                                    <a title="Ad Image" class="imglink" style=""   >
                                        <c:set var="adimg"><bean:write name="result"  property="image1" /></c:set>
                                        <c:if test='${adimg != "" && adimg != "null" }'> <img src="resourceGetter?imf=<bean:write name="result"  property="image1" />" width="75px" height="75px" style="border:none" > </c:if>
                                        <c:if test='${adimg == "" || adimg == "null"}'> <img src="bbsimages/No_Image.png"  width="75px" height="75px" style="border:none"  > </c:if>
                                    </a>
                                </div>
                            </div>
                            <div  class="my_account_ad_more_details" style="padding-left: 10px;"><li><a title="More Details"  href="bs/moreDetails.do?adId=<bean:write name="result" property="adId"  />&catId=<bean:write name="result" property="catId"  />#moredetail" onclick="return hs.htmlExpand(this, { objectType: 'ajax'} )">More Details...</a></li> </div>
                        </div>
                        <div class="my_account_ad_left_txt_cont" style="width:520px; ">
                            <strong style="color:#046dbe;">
                                <a title="<bean:write name="result" property="title" />" class="link" style="font-size:11px;color:#046DBE"  href="bs/moreDetails.do?adId=<bean:write name="result" property="adId"  />&catId=<bean:write name="result" property="catId"  />#moredetail" onclick="return hs.htmlExpand(this, { objectType: 'ajax'} )">
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
                                <c:if test="${fn:length(result.description) <= 350 }" >
                                    <c:out value="${result.description}" />
                                </c:if>
                                <c:if test="${fn:length(result.description) > 350 }" >
                                    <c:out value="${fn:substring(result.description,0,350)}" />&nbsp;&nbsp;<a title="More Details" href="bs/moreDetails.do?adId=<bean:write name="result" property="adId"  />&catId=<bean:write name="result" property="catId"  />#moredetail" onclick="return hs.htmlExpand(this, { objectType: 'ajax'} )" ><span style="color:#046dbe">More...</span></a>
                                </c:if>
                            </p>
                            <p style="margin-top:9px;padding-left:10px;">
                                <logic:equal name="result" property="adType" value="wanted">
                                    <span class="fv11b" >Rs.</span><fmt:formatNumber type="currency"  value="${result.min}" pattern="#,##,###.00" /> to <fmt:formatNumber type="currency"  value="${result.max}" pattern="#,##,###.00" />
                                </logic:equal>

                                <logic:equal name="result" property="adType" value="offered">
                                    <logic:notEqual name="result" property="cfp" value="on">
                                        <c:if test="${result.price != 0}">
                                            <span class="fv11b" >Rs.</span><fmt:formatNumber type="currency"  value="${result.price}" pattern="#,##,###.00" />
                                            &nbsp;&nbsp;(<logic:equal name="result" property="neg" value="yes">Neg</logic:equal><logic:equal name="result" property="neg" value="no">Not-Neg</logic:equal>)
                                        </c:if>
                                    </logic:notEqual>
                                    <logic:equal name="result" property="cfp" value="on">
                                        <span class="fv11bc" style="padding-right:2px">Contact for Price</span>
                                    </logic:equal>
                                </logic:equal>  
                                <span style="float:right; margin:0 10px 0 0;">Posted On <strong style="color:#046dbe;"> <bean:write name="result" property="postedDate"/> </strong></span>
                            </p>
                        </div>
                                <div class="my_account_ad_status" style="margin-top: 0px"> <div class="my_account_ad_status_txt"><a style="color:#333333;text-decoration: none;font-size: 13px;" onmouseout="style.color= '#333333'"  onmouseover="style.color= '#FF6600'" title="Modify & Repost" href="edit_ad_for_renew.do?adId=<bean:write name="result" property="adId" />&catId=<bean:write name="result" property="catId" />&type=e">Modify<br/> &<br/> Repost</a></div> </div>
                    </div>
                </div>
            </div><!-- main div ends -->
       
<div style="width:725px;height:5px;"></div>

</logic:iterate>

</logic:greaterThan>
</logic:present>

