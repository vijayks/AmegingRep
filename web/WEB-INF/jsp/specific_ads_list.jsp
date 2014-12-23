

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.buysell.beans.UserBean" %>
<%@page import="com.buysell.beans.MyAdDetailsBean" %>
<%@page  import="com.buysell.beans.AdsResultsBean " %>
<%@page  import="java.io.OutputStream " %>
<%@page  import="java.io.FileInputStream " %>

<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<link href="images/lytebox/fbox.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="highslide/highslide-with-html.js"></script>
<link rel="stylesheet" type="text/css" href="highslide/highslide.css" />
<script type="text/javascript">
    hs.graphicsDir = 'highslide/graphics/';
    hs.outlineType = 'rounded-white';
    hs.wrapperClassName = 'draggable-header';
</script>

<script type="text/javascript" src="images/lytebox/fbox_conf.js"></script>
<script type="text/javascript" src="images/lytebox/fbox_engine-min.js"></script>


<%
MyAdDetailsBean madb = (MyAdDetailsBean) request.getSession().getAttribute("myAdDetailsBean");
 UserBean ub = (UserBean) request.getSession().getAttribute("userBean");
%>
<div style="clear:both;"></div>


<div style="padding-top:10px; padding-bottom:15px;" width="100%" valign="top" class="verdana_form_mainhead"><b>My Ad Details</b></div>
<div class="fv12" id="bv_Table1" style="width:710px;height:150px;z-index:4;" >
    <table width="100%"  border="1" cellpadding="1" cellspacing="1" id="Table1">
        <tr>
            <td class="fv12b" align="center" valign="middle" bgcolor="#DDEEFF" width="150" height="48">Type Of Ad</td>
            <td class="fv12b" align="center" valign="middle" bgcolor="#DDEEFF" width="84" height="48">Active</td>
            <td class="fv12b" align="center" valign="middle" bgcolor="#DDEEFF" width="84" height="48">On Hold</td>
            <td class="fv12b" align="center" valign="middle" bgcolor="#DDEEFF" width="84" height="48">Expired</td>
            <td class="fv12b" align="center" valign="middle" bgcolor="#DDEEFF" width="84" height="48">Incomplete</td>
            <td class="fv12b" align="center" valign="middle" bgcolor="#DDEEFF" width="84" height="48">Deleted</td>
            <td class="fv12b" align="center" valign="middle" bgcolor="#DDEEFF" width="99" height="48">Balance</td>
        </tr>
        <tr>
            <td  class="fv12b" align="center" valign="middle" bgcolor="#DDEEFF" width="150" height="48">Basic Ads</td>
            <td align="center" valign="middle" width="84" height="48"><a title="View Active Ads" href="specificAdsAction.do?status=1"><%= madb.getActive()%></a></td>
            <td align="center" valign="middle" width="84" height="48"><a title="View OnHold Ads"href="specificAdsAction.do?status=2"><%= madb.getOnHold()%></a></td>
            <td align="center" valign="middle" width="84" height="48"><a title="View Expired Ads"href="specificAdsAction.do?status=4"><%= madb.getExpired()%></a></td>
            <td align="center" valign="middle" width="84" height="48"><a title="View Incomplete Ads" href="#">0</a></td>
            <td align="center" valign="middle" width="84" height="48"><a title="View Deleted Ads" href="specificAdsAction.do?status=5"><%= madb.getDeleted()%></a></td>
            <td align="center" valign="middle" width="99" height="48"><%= madb.getBalanceAds()%></td>
        </tr>
        <c:if test="${userBean != null}">
            <c:set var="dt"><%=((UserBean) request.getSession().getAttribute("userBean")).getUserType().startsWith("D") ? "D" : "N"%>
            </c:set>
            <c:if test='${dt=="D"}'>
                <tr>
                    <td  class="fv12b" align="center" valign="middle" bgcolor="#DDEEFF" width="150" height="48">Special Ads</td>
                    <td align="center" valign="middle" width="84" height="48" ><a title="View Active Ads" href="specificPreffAdsAction.do?status=1"><%= madb.getPreffActive()%></a></td>
                    <td align="center" valign="middle" width="84" height="48"><a title="View Active Ads" href="specificPreffAdsAction.do?status=2"><%= madb.getPreffOnHold()%></a></td>
                    <td align="center" valign="middle" width="84" height="48"><a title="View Active Ads" href="specificPreffAdsAction.do?status=4"><%= madb.getPreffExpired()%></a></td>
                    <td align="center" valign="middle" width="84" height="48"><a title="View Incomplete Ads" href="#">0</a></td>
                    <td align="center" valign="middle" width="84" height="48"><a title="View Active Ads" href="specificPreffAdsAction.do?status=5"><%= madb.getPreffDeleted()%></a></td>
                    <td align="center" valign="middle" width="99" height="48"><%= madb.getPreffBal()%></td>
                </tr>
            </c:if>
            <c:if test='${dt=="N"}'>
                <tr>
                    <td  class="fv12b" align="center" valign="middle" bgcolor="#DDEEFF" width="150" height="48">Special Ads</td>
                    <td align="center" valign="middle" width="84" height="48">0</td>
                    <td align="center" valign="middle" width="84" height="48">0</td>
                    <td align="center" valign="middle" width="84" height="48">0</td>
                    <td align="center" valign="middle" width="84" height="48">0</td>
                    <td align="center" valign="middle" width="84" height="48">0</td>
                    <td align="center" valign="middle" width="99" height="48">0</td>
                </tr>
            </c:if>
        </c:if>
    </table>
</div>
<div style="clear:both;"></div>
<div style="width:710px;height:15px;"></div>
<div style="color:#FF9600;font-size:14px;font-weight:bold;padding-bottom:10px;padding-left:5px;" >
    <div style="padding-top:6px;" ><%= request.getAttribute("title") %></div>
</div>
<div style="clear:both;">
    <div style="width:710px;height:1px;"></div>
    <logic:present name="specificAdsList" property="results">
        <bean:size id="size" name="specificAdsList" property="results"/>

        <logic:equal name="size" value="0">
            <div class="fv11b" style="width:740px;height:15px;text-align:center;color:#EA052B;">No ads found under requested criteria.</div>
        </logic:equal>

        <logic:greaterThan name="size" value="0">
            <logic:iterate id="result"  name="specificAdsList" property="results">

                <% String name = "status";%>
                <logic:equal name="result" property="status" value="1">
                    <% name = "Active";%>
                </logic:equal>

                <logic:equal  name="result" property="status" value="2">
                    <% name = "On Hold";%>
                </logic:equal>
                <logic:equal name="result" property="status" value="3">
                    <% name = "Reposted";%>
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
                        <div class="my_account_ad_bg_cont" style="background:white; border-bottom: 1px dashed #CCCCCC;padding-bottom: 5px;" onmouseover="this.style.background='whitesmoke';" onmouseout="this.style.background='white';">       
                            <div class="my_account_ad_cont">
                                <div class="my_account_ad_bg">
                                    <div class="my_account_ad_img">
                                        <a title="Ad Image" class="imglink" style=""   >
                                            <c:set var="adimg"><bean:write name="result"  property="image1" /></c:set>
                                            <c:if test='${adimg != "" && adimg != "null" }'> <img src="resourceGetter?imf=<bean:write name="result"  property="image1" />"  width="75px" height="75px" style="border:none"  > </c:if>
                                            <c:if test='${adimg == "" || adimg == "null"}'> <img src="bbsimages/No_Image.png" width="75px" height="75px" style="border:none"  > </c:if>
                                        </a>
                                    </div>
                                </div>
                                <div  class="my_account_ad_more_details" style="padding-left: 10px;"><li><a title="More Details"   href="bs/moreDetails.do?adId=<bean:write name="result" property="adId"  />&catId=<bean:write name="result" property="catId"  />#moredetail" onclick="return hs.htmlExpand(this, { objectType: 'ajax'} )">More Details...</a> </li> </div>
                            </div>
                            <div class="my_account_ad_left_txt_cont" style="width:520px; ">
                                <strong style="color:#046dbe;">
                                    <a  title="<bean:write name="result" property="title" />" class="link" style="font-size:11px;color:#046DBE"  href="bs/moreDetails.do?adId=<bean:write name="result" property="adId"  />&catId=<bean:write name="result" property="catId"  />#moredetail" onclick="return hs.htmlExpand(this, { objectType: 'ajax'} )">
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
                                    <c:if test="${fn:length(result.description) <= 270 }" >
                                        <c:out value="${result.description}" />
                                    </c:if>
                                    <c:if test="${fn:length(result.description) > 270 }" >
                                        <c:out value="${fn:substring(result.description,0,270)}" />&nbsp;&nbsp;<a title="More Details" href="bs/moreDetails.do?adId=<bean:write name="result" property="adId"  />&catId=<bean:write name="result" property="catId"  />#moredetail" onclick="return hs.htmlExpand(this, { objectType: 'ajax'} )" ><span style="color:#046dbe">More...</span></a>
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
                                    <span style="float:right; margin:0 10px 0 0;">Posted On  <strong style="color:#046dbe;">  <bean:write name="result" property="postedDate"/> </strong></span>
                                </p>
                            </div>
                            <div class="my_account_ad_status"> <div class="my_account_ad_status_txt"> <%= name%></div> </div>
                    </div>
                </div>
                </div> <!-- main div ends -->
                <div style="width:720px;height:10px;"></div>

            </logic:iterate>
        </logic:greaterThan>
    </logic:present>
</div>
<%--

<!-- this block of code for light box -->
<span>
<div style="display:none; width:500px;height:400px;" id="<bean:write name="result" property="adId" />"  >

<div style="width:490px;height:20px;">

</div>


<div style="float:left;padding-left:10px;" class="fv12b" >


</div>

<div style="width:490px;height:20px;">

</div>


<div style="float:left;width:480px;height:2px;background-color:#dddddd;padding-left:10px;padding-right:10px;"></div>
<span style="float:left;padding-left:10px;"  ><img src="images/basket.png" style="height:30px;width:40px"/></span>

<div style="float:left;padding-top:6px;" class="fv14b">
<bean:write name="result" property="title" />
</div>


<div style="float:left;width:480px;height:2px;background-color:#222222;padding-left:10px;padding-right:10px;"></div>

<div style="float:left;width:420px;text-align:justify;padding-left:20px;" class="fv10" >
<p>&nbsp;<bean:write name="result" property="description" /></p>
<p>&nbsp;<bean:write name="result" property="addtionalContent"/></p>
</div>

<div style="width:490px;height:20px;">

</div>


<div style="float:right;width:460px;padding-right:30px;padding-bottom:10px;" class="fv10" align="right">

Price: <b><bean:write name="result" property="price" /></b>
</div>



<div style="float:left;padding-left:20px;width:300px;height:150px;" align="left" class="fv12b" >
Details:
<br />
Ad Type :<bean:write name="result" property="adType" /><br />
Contact For Price :<bean:write name="result" property="cfp" /><br />

</div>

<div style="float:right;width:140px;padding-right:20px;height:160px"  >
<img style="width:120px;height:120px;" class="" src="resourceGetter?imf=<bean:write name="result" property="image1" />">


</div>




<div style="float:left;padding-left:20px;width:480px;" align="left" class="fv11b" >
Contact:&nbsp;<bean:write name="result" property="firstName"/>


</div>


<div style="float:left;padding-left:20px;width:480px;" align="left" class="fv11" >
Location:&nbsp;<bean:write name="result" property="city"/>
</div>

<div style="float:left;padding-left:20px;width:480px;" align="left" class="fv11" >
Mobile:&nbsp;<bean:write name="result" property="ph1"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;LandLine:&nbsp;<bean:write name="result" property="ph2"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Email:&nbsp;<bean:write name="result" property="email"/>
</div>


</div>
</span>
<!-- Light box code ended -->

--%>
