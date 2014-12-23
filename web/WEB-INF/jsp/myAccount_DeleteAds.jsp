<%--
    Document   : latestAds
    Created on : Mar 4, 2009, 8:18:33 PM
    Author     : bbsadmin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page  import="com.buysell.beans.AdsResultsBean " %>
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
<script type="text/javascript" src="highslide/highslide-with-html.js"></script>
<link rel="stylesheet" type="text/css" href="highslide/highslide.css" />
<script type="text/javascript">
    hs.graphicsDir = 'highslide/graphics/';
    hs.outlineType = 'rounded-white';
    hs.wrapperClassName = 'draggable-header';
</script>

<script type="text/javascript">

    function sortBy(itemID)
    {
        var dropdownIndex = document.getElementById(itemID).selectedIndex;
        var dropdownValue = document.getElementById(itemID)[dropdownIndex].value;
        //alert(dropdownValue);

        document.location.href=dropdownValue;

    }
    function adsPerPage(itemID)
    {
        var dropdownIndex = document.getElementById(itemID).selectedIndex;
        var dropdownValue = document.getElementById(itemID)[dropdownIndex].value;
        //alert(dropdownValue);

        document.location.href=dropdownValue;

    }

    function check(checkAllState, cbGroup)
    {//alert("cbGroup.length="+cbGroup.length);
        for (i = 0; i < cbGroup.length; i++)
        {
            //alert("cbGroup[i]="+cbGroup[i]);
            cbGroup[i].checked = checkAllState.checked;
        }
    }
    function chkAll()
    {   active =document.getElementsByName("active");
        hold =document.getElementsByName("hold");
        reposted =document.getElementsByName("reposted");
        expired =document.getElementsByName("expired");
        incomplete=document.getElementsByName("incomplete");

        commons(active,"checked");
        commons(hold,"checked");
        commons(reposted,"checked");
        commons(expired,"checked");

        commons(incomplete,"checked");
    }
    function unchkAll(){
        active =document.getElementsByName("active");
        hold =document.getElementsByName("hold");
        reposted =document.getElementsByName("reposted");
        expired =document.getElementsByName("expired");

        incomplete=document.getElementsByName("incomplete");


        commons(active,"");
        commons(hold,"");
        commons(reposted,"");
        commons(expired,"");

        commons(incomplete,"");
    }

    function commons(item,checked){
        for (i = 0; i < item.length; i++)
        {
            item[i].checked =checked;
        }
    }


</script>


<div>
    <jsp:include page='/WEB-INF/jsp/pagination.jsp'/>
</div>
<div>
    <jsp:include page='/WEB-INF/jsp/paginationNums.jsp'/>
</div>

<logic:present name="deleteAdsResultsBean" property="results">

    <bean:size id="size" name="deleteAdsResultsBean" property="results"/>

    <logic:equal name="size" value="0">
        <div id="sortBar" style="text-align:left;color:#ffffff;width:720px;float:left;height:30px;padding-top:8px;_padding-top:7px;background:url(bbsimages/sortBy.jpg) no-repeat;">
            <span class="verdana_menu_head" style="padding-left:15px;" >Delete Ad</span>
        </div>

        <div class="fv11b" style="width:720px;height:15px;text-align:center;color:#EA052B;">No ads found under requested criteria.</div>
    </logic:equal>

    <logic:greaterThan name="size" value="0">
        <form action="delete_specific_ads.do">
            <div  style="width:720px;float:left;height:20px;">
                <div  class="fv12" style="width:5%;float:left;height:16px;padding-top:4px;padding-left:5px;">  Select </div>
                <div style="width:5%;float:left;height:16px;padding-top:4px;" align="right"> <a title="All" class="fv12bc" href="javascript:return false" onClick="chkAll()">All</a>  </div>
                <div style="width:12%;float:left;height:16px;padding-top:4px;" align="center"><a title="None" class="fv12bc" href="javascript:return false" onClick="unchkAll()">None</a> </div>
                <div class="fv12bc" style="width:12%;float:left;height:20px;">  <input title="Active" type="checkbox" name="active" onClick="check(this,active)"> &nbsp; Active </div>
                <div class="fv12bc" style="width:12%;float:left;height:20px;">  <input title="OnHold" type="checkbox" name="hold" onClick="check(this,hold)"> &nbsp; OnHold </div>
                <div class="fv12bc" style="width:12%;float:left;height:20px;">  <input title="Expired" type="checkbox" name="expired" onClick="check(this,expired)"> &nbsp; Expired </div>
                <div  class="fv12bc" style="width:15%;float:left;height:20px;">  <input title="Incomplete" type="checkbox" name="incomplete" onClick="check(this,incomplete)"> &nbsp; Incomplete </div>
                <div  style="width:24%;float:left;height:20px;" align="right">
                    <input title="Delete" type="image" src="bbsimages/buttons/Delete.png" onmouseover="this.src='bbsimages/buttons/Delete_MouseOver.png';" onmouseout="this.src='bbsimages/buttons/Delete.png';" /> </div>
            </div>

            <div style="clear:both;width:720px;height:12px;"></div>


            <logic:iterate id="result"  name="deleteAdsResultsBean" property="results">


                <% String name="status";%>
                <logic:equal name="result" property="status" value="1">
                    <% name="active"; %>
                </logic:equal>

                <logic:equal  name="result" property="status" value="2">
                    <% name="hold"; %>
                </logic:equal>
                <logic:equal name="result" property="status" value="3">
                    <% name="reposted"; %>
                </logic:equal>
                <logic:equal name="result" property="status" value="4">
                    <% name="expired"; %>
                </logic:equal>

                <logic:equal name="result" property="status" value="6">
                    <% name="incomplete"; %>
                </logic:equal>

                <div class="" style="width:720px;">
                    <div  style="height:110px;" >
                        <div class="my_account_ad_bg_cont" style="background:white;border-bottom:1px dashed #CCCCCC;padding-bottom:5px;  " onmouseover="this.style.background='whitesmoke';" onmouseout="this.style.background='white';">
                            <input type="checkbox" style="margin:1px;float:left "  name='<%= name%>' value="<bean:write name="result" property="adId" /><c:if test='${result.status==1||result.status==2}'>|<bean:write name="result" property="sponsType" /></c:if>" />
                            <div class="my_account_ad_cont">
                                <div class="my_account_ad_bg">
                                    <div class="my_account_ad_img">
                                        <a class="imglink" style=""   >
                                            <c:set var="adimg"><bean:write name="result"  property="image1" /></c:set>

                                            <c:if test='${adimg != "" && adimg != "null" }'>

                                                <img src="resourceGetter?imf=<bean:write name="result"  property="image1" />"
                                                     width="75px" height="75px" style="border:none"  >

                                            </c:if>
                                            <c:if test='${adimg == "" || adimg == "null"}'>
                                                <img src="bbsimages/No_Image.png"
                                                     width="75px" height="75px" style="border:none"  >

                                            </c:if>

                                        </a>
                                    </div>
                                </div>
                                <div class="my_account_ad_more_details"> <li><a title="More Details"  href="bs/moreDetails.do?adId=<bean:write name="result" property="adId"  />&catId=<bean:write name="result" property="catId"  />#moredetail" onclick="return hs.htmlExpand(this, { objectType: 'ajax'} )">More Details...</a></li></div>
                            </div>
                            <div class="my_account_ad_left_txt_cont"><strong style="color:#046dbe;">
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
                                    <c:if test="${fn:length(result.description) <= 265 }" >
                                        <c:out value="${result.description}" />
                                    </c:if>
                                    <c:if test="${fn:length(result.description) > 265 }" >
                                        <c:out value="${fn:substring(result.description,0,265)}" />&nbsp;&nbsp;<a href="bs/moreDetails.do?adId=<bean:write name="result" property="adId"  />&catId=<bean:write name="result" property="catId"  />#moredetail" onclick="return hs.htmlExpand(this, { objectType: 'ajax'} )" ><span style="color:#046dbe">More...</span></a>
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
                                    <span style="float:right; margin:0 10px 0 0;">Posted On :<strong style="color:#046dbe;"><bean:write name="result" property="postedDate"/> </strong></span>
                                </p>
                            </div>
                            <div class="my_account_ad_status"><div class="my_account_ad_status_txt">  <%= name %></div> </div>
                        </div>
                    </div>
</div>
                    <!-- main div ends -->

                    <div style="width:740px;height:10px;"> </div>
                </logic:iterate>
                <div  style="width:740px;float:left;height:40px;">
                    <div  class="fv12" style="width:5%;float:left;height:36px;padding-top:4px;padding-left:5px;">  Select </div>
                    <div style="width:5%;float:left;height:36px;padding-top:4px;" align="right"> <a class="fv12bc" href="javascript:return false" onClick="chkAll()">All</a>  </div>
                    <div style="width:12%;float:left;height:36px;padding-top:4px;" align="center">  <a class="fv12bc" href="javascript:return false" onClick="unchkAll()">None</a> </div>
                    <div class="fv12bc" style="width:12%;float:left;height:40px;">  <input type="checkbox" name="active" onClick="check(this,active)"> &nbsp; Active </div>
                    <div class="fv12bc" style="width:12%;float:left;height:40px;">  <input type="checkbox" name="hold" onClick="check(this,hold)"> &nbsp; OnHold </div>
                    <div class="fv12bc" style="width:12%;float:left;height:40px;">  <input type="checkbox" name="expired" onClick="check(this,expired)"> &nbsp; Expired </div>
                    <div  class="fv12bc" style="width:15%;float:left;height:40px;">  <input type="checkbox" name="incomplete" onClick="check(this,incomplete)"> &nbsp; Incomplete </div>
                    <div  style="width:24%;float:left;height:40px;" align="right">
                        <input type="image" src="bbsimages/buttons/Delete.png" onmouseover="this.src='bbsimages/buttons/Delete_MouseOver.png';" onmouseout="this.src='bbsimages/buttons/Delete.png';" /> </div>
                </div>
     </form>
    </logic:greaterThan>
</logic:present>
<div>
    <jsp:include page='/WEB-INF/jsp/paginationNums.jsp'/>
</div>

<%-- this block of code for light box
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
</span>--%>
<!-- Light box code ended -->

