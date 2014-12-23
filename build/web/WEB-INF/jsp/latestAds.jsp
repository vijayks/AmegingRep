<%@page contentType="text/html" pageEncoding="UTF-8"%><%@page  import="com.buysell.beans.AdsResultsBean " %><%@page  import="java.io.OutputStream " %><%@page  import="java.io.FileInputStream " %><%@page import="com.buysell.beans.UserBean" %><%@page import="com.buysell.util.URlUtil" %><%@page  import="com.buysell.util.CategoryUtil " %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %><%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %><%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %><%@taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn"%><%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page  import="java.util.List " %> <%@page  import="java.util.Iterator " %>
<script type="text/javascript" src="js/latestJs.js"></script>
<% UserBean ub = (UserBean) request.getSession().getAttribute("userBean");%>
<script type="text/javascript" language="javascript">
    var R=0;
    var S=0;
    var qcheck=true;
    function sendReq()
    {
        oFormObject = document.forms[1];
        oFormObject.submit();
    }

    function openAlertWindow(url){
        window.open(url,"SaveAlert",'width=400,height=200,resizable=no,menubar=no,status=no,location=no,toolbar=no,scrollbars=no,screenX=500,screenY=400');
    }

    function adsPerPage(itemId)
    {
        var dropdownIndex = document.getElementById(itemId).selectedIndex;
        var dropdownValue = document.getElementById(itemId)[dropdownIndex].value;
        document.location.href=dropdownValue;
    }

    /* this function used for quick registration validation */
    function validateqr(lid,name,city,ph,code,divID)
    {
        var chk=true;
        var result=checkMobileNum(ph,divID);
        if(result == true)
        {
            document.getElementById("table"+divID).style.display="none";
            document.getElementById("img"+divID).style.display="inline";
            var res=quickRegAjax(lid,name,city,ph,code,divID);
            if(res == true)
                chk=true;
            else
                chk=false;
        }else
        {
            document.getElementById("conf"+divID).innerHTML="";
            document.getElementById("conf"+divID).innerHTML="Invalid Data";
            document.getElementById("table"+divID).style.display="inline";
            document.getElementById("img"+divID).style.display="none";
            chk=false;
        }
        return chk;
    }

    function sortBy(itemId)
    {
        var dropdownIndex = document.getElementById(itemId).selectedIndex;
        var dropdownValue = document.getElementById(itemId)[dropdownIndex].value;
        document.location.href=dropdownValue;
    }
</script>
<c:if test='${userBean != null}' >
    <script type="text/javascript">
        R=1; <c:if test="${userBean.evStatus == 'V' }" > EV=1; </c:if>
    </script>
</c:if>
<c:if test='${saveThisSearch != null}' >
    <script type="text/javascript"> S=1; </script>
</c:if>
<script  type="text/javascript">
    var smsWL =new Array();
    var emailWL=new Array();
    var saveWL=new Array();
    var saveAL=new Array();
    var smsAL=new Array();
    var emailAL=new Array();
    // var eu=new Array();
    var nu=new Array();
    var fp=new Array();
    var count=0;
    function closeAllOtherDivs(itemId)
    {
        closeAllOtherDivsNoParam();
        // to erase prev o/p
        document.getElementById("msg"+itemId+"wl").innerHTML="";
        document.getElementById("msg"+itemId+"al").innerHTML="";
    }

    function closeAllOtherDivsNoParam()
    {
        for(var i=0;i<saveWL.length;i++)
        {
            toggle_close_it(saveWL[i]) ;
            toggle_close_it(saveAL[i]) ;
            toggle_close_it(smsWL[i]) ;
            toggle_close_it(smsAL[i]) ;
            toggle_close_it(emailWL[i]) ;
            toggle_close_it(emailAL[i]) ;
            toggle_close_it(nu[i]) ;
            toggle_close_it(fp[i]) ;
        }
        if(S==1)
        {
            toggle_close_it("alertal") ;
            toggle_close_it("alertwl") ;
            toggle_close_it("searchal") ;
            toggle_close_it("searchwl") ;
        }
    }

    function closeSearchAlert() {
        toggle_close_it("alertal") ;
        toggle_close_it("alertwl") ;
        toggle_close_it("searchal") ;
        toggle_close_it("searchwl") ;
    }

    function displayALForm(itemId)
    {
        toggle_open_it(itemId+"al");
        toggle_open_it('form'+itemId+"al");//make inline which was individually make none
        // document.getElementById(itemId+"al").focus();
    }

    function displayWLForm(itemId)
    {
        toggle_open_it(itemId+"wl");
        toggle_open_it('form'+itemId+"wl");//make inline which was individually make none
        //  document.getElementById(itemId+"wl").focus();
    }

    function showingLoading(itemId)
    {
        document.getElementById("msg"+itemId).innerHTML="";// erase prev o/p
        toggle_close_it("form"+itemId);//make none to show process
        toggle_open_it("load"+itemId); // display loading img
    }

    function toggle_search_it(itemId)
    {
        document.getElementById('qrSaveSearch').style.display = 'none';
        document.getElementById('fpss').style.display = 'none';
        closeSearchAlert();
        if(R == 0)
        {
            displayWLForm(itemId);
        }
        else
        {
            displayALForm(itemId);
        }
    }

    function toggle_alert_it(itemId)
    {
        document.getElementById('qrSaveAlert').style.display = 'none';
        document.getElementById('fpsa').style.display = 'none';
        closeSearchAlert();
        if(R == 0)
        {
            displayWLForm(itemId);
        }
        else
        {
            displayALForm(itemId);
        }
    }

    function toggle_save_it(itemId)
    {
        //if ((document.getElementById(itemId).style.display == 'none'))
        closeAllOtherDivs(itemId);
        if(R == 0)
        {
            displayWLForm(itemId);
        }
        else
        {
            displayALForm(itemId);
        }
    }

    function toggle_sms_it(itemId){
        closeAllOtherDivs(itemId);
        if(R == 0)
        {
            displayWLForm(itemId);
        }
        else
        {
            displayALForm(itemId);
        }
        return false;
    }

    function toggle_email_it(itemId){

        closeAllOtherDivs(itemId);
        if(R == 0)
        {
            displayWLForm(itemId);
        }
        else
        {
            displayALForm(itemId);
        }
        return false;
    }

    /*This function used for qucickregistration div display*/
    function toggle_qr(itemId,purpose,mb,adt)
    {
        closeAllOtherDivsNoParam();
        toggle_open_it(itemId);

        var element1 = document.createElement("input");
        //Assign different attributes to the element.
        element1.setAttribute("id",itemId+purpose);
        element1.setAttribute("type", "hidden");
        element1.setAttribute("value", purpose);
        element1.setAttribute("name", itemId+'purpose');
        var foo = document.getElementById("form"+itemId);
        foo.appendChild(element1);

        var element2 = document.createElement("input");
        element2.setAttribute("type","hidden");
        element2.setAttribute("name","advtMobile");
        element2.setAttribute("value",mb);
        element2.setAttribute("type","hidden");
        var foo1=document.getElementById("form"+itemId);
        foo1.appendChild(element2);

        var element3 = document.createElement("input");
        element3.setAttribute("type","hidden");
        element3.setAttribute("name","adTitle");
        element3.setAttribute("value",adt);
        element3.setAttribute("type","hidden");
        var foo2=document.getElementById("form"+itemId);
        foo2.appendChild(element3);
        return false;
    }

    function toggle_fp(itemId)
    {
        closeAllOtherDivsNoParam();
        toggle_open_it(itemId);
        return false;
    }

    function toggle_close_it(itemId)
    {
        document.getElementById(itemId).style.display='none';
        return false;
    }

    function toggle_open_it(itemId)
    {
        document.getElementById(itemId).style.display='inline';
        return false;
    }

    var count=0;
    function changeVrificationCodeQr(imgId)
    {
        count++;
        document.getElementById(imgId).src='rig?1='+count;
    }

    function validateQuickRegFormLA(qrform)
    {
        var firstName=qrform.firstName.value;
        var city=qrform.city.value;
        var mobile=qrform.mobile.value;
        var iagree=qrform.iagree.checked;
        var chk=false;

        var mobileRegex= /^([987]{1})([0123456789]{1})([0-9]{8})$/;

        if(firstName =="")
        {
            alert("Enter your name");
            chk=false;

        }else if(city == "")
        {
            alert("Please select city");
            chk=false;
        }
        else if(mobile == "") {
            alert('You must enter your phone number.');
            chk=false;
        }
        else if(!mobile.match(mobileRegex)) {
            alert('You have entered an invalid phone number.');
            chk=false;
        }else if(!iagree)
        {
            alert("please accept the terms and conditions ");
            chk=false;
        }else
        {
            chk=true;
        }

        return chk;
    }

</script>
<!-- latest ad display starts here -->
<logic:present name="latestAdResultsBean" property="results"><bean:size id="size" name="latestAdResultsBean" property="results"/>
    <logic:equal name="size" value="0">
        <% String reqURI = "tile1.do";
            if (request.getAttribute("reqURI") != null) {
                reqURI = (String) request.getAttribute("reqURI");
            }
            if (!reqURI.equalsIgnoreCase("tile1.do") && !reqURI.equalsIgnoreCase("clf.do")) {%>
        <div id="sortBar" class="latest_ads_in_Car_cont_txt" style="">
            <div class="" style="padding-left:15px;" ><% if (request.getAttribute("title") != null) {%> <%= request.getAttribute("title")%> <% } else {%> Requested Ads List <% }%></div>
        </div>   <% }%>
    </logic:equal>
    <jsp:include page='/WEB-INF/jsp/saveSearch.jsp'/>
    <style type="text/css">
        <!--
        .boxBorder4
        {
            height:90px;
            -moz-border-radius:0 0 5px 5px;
            -webkit-border-radius: 10px;
        }
        -->
        .ad:hover{
            background:#FFFFCC;
        }
        <%--.ast3:hover{
            background:#D8E4C0;
        }--%>

        .ast2:hover,.ast3:hover{
            background:#FFF5CC;
        }
        .ast0:hover,.ast1:hover{
            background:whitesmoke;
        }
        <%-- .ast3{
             background-color:#D8E4F0;
         }--%>
        .ast2,.ast3{
            background-color:#EBF3FF;
        }
        .ast0,.ast1{
            background:white;
        }
    </style>
    <logic:equal name="size" value="0">
        <div class="" style="text-align:center;color:#EA052B;padding-top:20px;padding-bottom:90px;">No ads found under requested criteria.</div>
        <%--<div style="width:740px;height:10px;"></div>--%>
    </logic:equal>
    <logic:greaterThan name="size" value="0">
        <c:set var="i" value="0" /> <!-- this value  used for commercial ads count -->
        <logic:iterate id="result"  name="latestAdResultsBean" property="results">
            <script type="text/javascript">
                smsWL[count]="sms"+<bean:write name="result" property="adId" />+"wl";
                smsAL[count]="sms"+<bean:write name="result" property="adId" />+"al";
                saveWL[count]="save"+<bean:write name="result" property="adId" />+"wl";
                saveAL[count]="save"+<bean:write name="result" property="adId" />+"al";
                emailWL[count]="email"+<bean:write name="result" property="adId" />+"wl";
                emailAL[count]="email"+<bean:write name="result" property="adId" />+"al";
                //eu[count]="eu"+;
                nu[count]="nu"+<bean:write name="result" property="adId" />;
                //  sent[count]="sent"+;
                fp[count]="fp"+<bean:write name="result" property="adId" />;
                count++;
            </script>
            <% boolean recentAds = false;
            String rqurl = null;
            if (request.getAttribute("reqURI") != null) {
                rqurl = (String) request.getAttribute("reqURI");
            }%>
            <%--<div class="ad ast${result.sponsType}" style="">--%>
            <%--
                                <script text="text/javascript">
                                   alert( '${result.sponsType}' );
                                    </script>
            --%>


            <%--<div >--%>
            <c:set var="adDesc" value="${result.title}" scope="request"/>
            <c:set var="urlAdId" scope="request"><bean:write name="result" property="adId"  /></c:set>
            <c:set var="urlCatId" scope="request"><bean:write name="result" property="catId"  /></c:set>
            <% String url = "";
    String uAdId = "";
    String uCatId = "";
    url = (String) request.getAttribute("adDesc");
    uAdId = (String) request.getAttribute("urlAdId");
    uCatId = (String) request.getAttribute("urlCatId");
    if (url != null) {
        url = URlUtil.getUrlString(url, uAdId, uCatId);
    } else {
        url = ".htm";
    }
    url = url.replaceAll("\\<?", "");
    url = url.replaceAll("'", "");
    url = url.replaceAll(";", "");
    url = url.replaceAll("\\\\", "");
    String urlfull = url;
            %>
            <%
    if (rqurl != null && rqurl.equalsIgnoreCase("recentAds.do")) {
        url = "bs/" + url;
        recentAds = true;
    } else {
        urlfull = "bs/" + url;
        url = "bs/" + url + "#moredetail";
    }%>
            <c:set var="citySubCat"><bean:write name="result" property="city"/><bean:write name="result" property="parentCatName" filter="false"  /></c:set>
            <c:set var="catId"><bean:write name="result" property="catId" filter="false"  /></c:set>
            <%
    CategoryUtil cu = new CategoryUtil();
    String subCatId = (String) pageContext.getAttribute("catId");
    int sub = Integer.parseInt(subCatId);
    int subCategoryId = cu.getRootCatId(sub);
    List clfCategoryIds = cu.getClfCatIdsWithSubCatId(sub);
    if (clfCategoryIds != null && clfCategoryIds.size() > 0) {
                for (Iterator itr1 = clfCategoryIds.iterator(); itr1.hasNext();) {
                    Integer clfId = (Integer) itr1.next();
             }
            }
            %>


            <div class="ikon_2006_left_bg_cont ast${result.sponsType}">
                <div class="ikon_2006_left_mt_cont">
                    <div class="ikon_2006_left_img">
                        <div class="car_fistpage_right_img_4">
                            <c:set var="adimg"><bean:write name="result"  property="image1" /></c:set>
                            <c:if test='${adimg != "" && adimg != "null" }'><a class="link" style="font-size:11px;color:#046DBE"  href="<%=urlfull%>" title="${result.title}"><img src="resourceGetter?imf=<bean:write name="result"  property="image1" />" width="127px" height="103px" style="border:none" alt="${result.title}" /></a></c:if>
                            <c:if test='${adimg == "" || adimg == "null"}'><a class="link" style="font-size:11px;color:#046DBE"  href="<%=urlfull%>" title="${result.title}"><img src="bbsimages/No_Image.png" width="127px" height="103px" style="border:none" alt="" /></a></c:if>
                        </div>
                    </div>
                    <div class="car_fistpage_more_details"> <li> <a href="<%=urlfull%>" title="${result.title}">More Details...</a></li></div></div>
                <div class="ikon_2006_left_txt_cont">
                    <strong style="color:#046dbe;">
                        <a class="link" style="font-size:11px;color:#046DBE"  href="<%=urlfull%>" title="${result.title}">
                            <c:if test="${fn:length(result.title) <= 50 }"><h2 style="margin:0px;font-size:11px;"><c:out value="${result.title}" />&nbsp;<a href="<c:out value="${fn:toLowerCase(fn:replace(fn:replace(citySubCat,' ','-'),'/','-'))}" escapeXml="false"/>-sc<%= subCategoryId%>.in" title="${result.parentCatName} in ${result.city}" style="font-size:11px;color:#046DBE">(<bean:write name="result" property="parentCatName" filter="false"  />)</a></h2></c:if>
                            <c:if test="${fn:length(result.title) > 50 }"><c:out value="${fn:substring(result.title,0,45)}"  />&nbsp;(<bean:write name="result" property="parentCatName" filter="false"  />)</c:if>
                        </a>
                    </strong>
                    <p style="margin-top:5px;height:72px;">
                        <c:if test="${fn:length(result.description) <= 300 }" ><c:out value="${result.description}" /></c:if>
                        <c:if test="${fn:length(result.description) > 300 }" ><c:out value="${fn:substring(result.description,0,300)}" />&nbsp;&nbsp;<a href="<%=urlfull%>" title="Details of ${result.title}"><span style="color:#046dbe">More...</span></a></c:if>
                    </p>
                    <p style="margin-top:5px;"> <bean:write name="result" property="locality" /> - <a <c:if test="${city != result.city}">href="ccs-${result.city}" title="${result.city} Free Classifieds"</c:if>><bean:write name="result" property="city"/></a>
                        <span style="float:right; margin:0 10px 0 0;">Posted By <strong style="color:#046dbe;"> <bean:write name="result" property="firstName" /> </strong>
                            <c:if test="${result.sponsType <= 1}">on <strong style="color:#046dbe;"><bean:write name="result" property="postedDate"/>  </strong></c:if></span>
                    </p>
                </div>
                <div class="ikon_2006_110">
                    <c:set var="adLogo"><bean:write name="result"  property="dlrLogo" /></c:set>
                    <c:if test='${adLogo != "" && adLogo != "null" && adLogo != null}'>
                        <div class="dealer_img"><a href="allAds-${result.userId}/${result.dlrName}.html" target="_blank"> <img src="resourceGetter?imf=<bean:write name="result"  property="dlrLogo" />" width="95px" height="60px" ></a> </div>
                    </c:if>
                    <c:if test='${adLogo == "" || adLogo == "null" || adLogo == null}'>
                        <div class="individual_img"><div class="individual_posting_txt">Individual <br /> Posting</div></div>
                            </c:if>


                    <div class="individual_rs_80">
                        <logic:equal name="result" property="adType" value="wanted"><c:if test="${result.max != 0}"><span class="fv11b" >Rs.</span><fmt:formatNumber type="currency"  value="${result.min}" pattern="#,##,###.00" />&nbsp;to&nbsp;<fmt:formatNumber type="currency"  value="${result.max}" pattern="#,##,###.00" /></c:if></logic:equal>
                        <logic:equal name="result" property="adType" value="offered">
                            <logic:notEqual name="result" property="cfp" value="on"><c:if test="${result.price != 0}"><span class="fv11b" >Rs.</span><fmt:formatNumber type="currency"  value="${result.price}" pattern="#,##,###.00" />&nbsp;(<logic:equal name="result" property="neg" value="yes">Neg</logic:equal><logic:equal name="result" property="neg" value="no">Not-Neg</logic:equal>)</c:if><c:if test='${result.rentMonth != 0}'><span class="fv11b">Rs.</span><fmt:formatNumber type="currency"  value="${result.rentMonth}" pattern="#,##,###.00" />(<c:if test="${result.neg == 'yes' }">Neg</c:if><c:if test="${result.neg == 'no'}">Not-Neg</c:if>)</c:if></logic:notEqual>
                            <logic:equal name="result" property="cfp" value="on"><span class="fv11bc" style="padding-right:2px">Contact for Price</span></logic:equal>
                        </logic:equal>
                    </div>
                </div>
            </div>

            <%--  <div style="float:left;width:145px;height:95px;padding-top:12px;border:1px solid #9ccfef;" align="center" >
                  <c:set var="adimg"><bean:write name="result"  property="image1" /></c:set>
                  <c:if test='${adimg != "" && adimg != "null" }'><a class="link" style="font-size:11px;color:#046DBE"  href="<%=urlfull%>" title="${result.title}"><img src="resourceGetter?imf=<bean:write name="result"  property="image1" />" width="135px" height="85px" style="border:none" alt="${result.title}" /></a></c:if>
                <c:if test='${adimg == "" || adimg == "null"}'><a class="link" style="font-size:11px;color:#046DBE"  href="<%=urlfull%>" title="${result.title}"><img src="bbsimages/noimage.png" width="135px" height="85px" style="border:none" alt="" /></a></c:if>
              </div>
            --%>
            <%--  <c:set var="citySubCat"><bean:write name="result" property="city"/><bean:write name="result" property="parentCatName" filter="false"  /></c:set>
              <c:set var="catId"><bean:write name="result" property="catId" filter="false"  /></c:set>
              <%
      CategoryUtil cu = new CategoryUtil();
      String subCatId = (String) pageContext.getAttribute("catId");
      int sub = Integer.parseInt(subCatId);
      int subCategoryId = cu.getRootCatId(sub);
              %>--%>
            <%--<div style="float:left;height:115px;width:460px;overflow:hidden;margin-left:10px">--%>
            <%--<div class="fv12bc" style="text-align:left;float:left;padding-left:3px;width:440px;padding-top:5px;overflow:hidden">
                <a class="link" style="font-size:11px;color:#046DBE"  href="<%=urlfull%>" title="${result.title}">
                    <c:if test="${fn:length(result.title) <= 50 }"><h2 style="margin:0px;font-size:11px;"><c:out value="${result.title}" />&nbsp;<a href="<c:out value="${fn:toLowerCase(fn:replace(fn:replace(citySubCat,' ','-'),'/','-'))}" escapeXml="false"/>-sc<%= subCategoryId%>.in" title="${result.parentCatName} in ${result.city}" style="font-size:11px;color:#046DBE">(<bean:write name="result" property="parentCatName" filter="false"  />)</a></h2></c:if>
                    <c:if test="${fn:length(result.title) > 50 }"><c:out value="${fn:substring(result.title,0,45)}"  />&nbsp;(<bean:write name="result" property="parentCatName" filter="false"  />)</c:if>
                </a>
            </div>--%>
            <%--  <div class="fv11" style="height:65px;width:464px;padding-right:3px;float:left;text-align:left;padding-left:3px;padding-top:6px;overflow:hidden">
                  <c:if test="${fn:length(result.description) <= 350 }" ><c:out value="${result.description}" /></c:if>
                  <c:if test="${fn:length(result.description) > 350 }" ><c:out value="${fn:substring(result.description,0,350)}" />&nbsp;&nbsp;<a href="<%=urlfull%>" title="Details of ${result.title}"><span style="color:#046dbe">More...</span></a></c:if>
              </div>
            --%>                        <%--<div class="fv11" style="padding-left:3px;float:left;width:190px;text-align:left;padding-bottom:5px">
                                        <bean:write name="result" property="locality" /> - <a <c:if test="${city != result.city}">href="ccs-${result.city}" title="${result.city} Free Classifieds"</c:if>><bean:write name="result" property="city"/></a>
                                    </div>
            --%>                        <%--<div class="fv11" style="float:left;width:245px;text-align:right;padding-bottom:5px">Posted By
                                        <span class="fv11bc"  ><bean:write name="result" property="firstName" /> </span>
                                        on <span class="fv11bc" style="padding-right:2px">
                                        <bean:write name="result" property="postedDate"/> </span>
                                    </div>--%>
            <%-- </div>--%>
            <%--
                                     <div class="fv11"  style="float:left;width:105px;height:105px;" align="right">
                                     <c:set var="adLogo"><bean:write name="result"  property="dlrLogo" /></c:set>
                                     <c:if test='${adLogo != "" && adLogo != "null" && adLogo != null}'><a href="dealersAllAds.do?Uid=<bean:write name="result"  property="userId" />" target="_blank"> <img src="resourceGetter?imf=<bean:write name="result"  property="dlrLogo" />" width="95px" height="60px" style="padding-left:12px;padding-top:10.5px;padding-bottom:15.5px;border:none"  ></a></c:if>
                                     <c:if test='${adLogo == "" || adLogo == "null" || adLogo == null}'><img src="bbsimages/individualposting.png"  width="95px" height="60px" style="padding-left:12px;padding-top:1.5px;padding-bottom:25.5px" alt="Self"/></c:if>
                                     <logic:equal name="result" property="adType" value="wanted"><c:if test="${result.max != 0}"><span class="fv11b" >Rs.</span><fmt:formatNumber type="currency"  value="${result.min}" pattern="#,##,###.00" /> to <fmt:formatNumber type="currency"  value="${result.max}" pattern="#,##,###.00" /></c:if></logic:equal>
                                     <logic:equal name="result" property="adType" value="offered">
                                         <logic:notEqual name="result" property="cfp" value="on"><c:if test="${result.price != 0}"><span class="fv11b" >Rs.</span><fmt:formatNumber type="currency"  value="${result.price}" pattern="#,##,###.00" />(<logic:equal name="result" property="neg" value="yes">Neg</logic:equal><logic:equal name="result" property="neg" value="no">Not-Neg</logic:equal>)</c:if><c:if test='${result.rentMonth != 0}'><span class="fv11b">Rs.</span><fmt:formatNumber type="currency"  value="${result.rentMonth}" pattern="#,##,###.00" />(<c:if test="${result.neg == 'yes' }">Neg</c:if><c:if test="${result.neg == 'no'}">Not-Neg</c:if>)</c:if></logic:notEqual>
                                         <logic:equal name="result" property="cfp" value="on"><span class="fv11bc" style="padding-right:2px">Contact for Price</span></logic:equal>
                                     </logic:equal>
                                 </div>
            --%>
            <%--</div></div></div></div></div></div></div></div></div>--%>
            <%--<div class="smsdiv" style=""><!-- Sms Div -->--%>
            <%--  <table  class="fv11" style="color:#FFFFFF;">
                  <tr>
                      <td style="width:400px;text-align:left;font-weight:normal" >
                          <div class="fv11b" style="float:left;text-align:right;width:85px;padding-right:2px;padding-top:5px"><b>
                                  <a class="link" style="font-size:11px;color:#222222"  href="<%=urlfull%>" title="${result.title}">More Details...</a>
                              </b></div>
                      </td>
                    <td style="width:25px;"><img src="bbsimages/twitter.gif" class="latestAdSms mail" alt="" height="18px" width="20px"/></td>
                    <td style="width:75px;"><a href="http://twitter.com/home?status=${result.title} http://bit.ly/ahZuff" style="color:#FFFFFF;" title="Tweet this Ad" target="_blank"> Tweet this Ad</a></td>
                    <td style="width:25px;"><img src="bbsimages/blank.gif" class="latestAdSms mail" alt=""/></td>
                    <td style="width:100px;"><a href="javascript:return false" style="color:teal;" onclick="toggle_email_it('email<bean:write name="result" property="adId" />');event.returnValue=false;return false;" title="Email to Friend"> Send To Friend</a></td>
                    <td style="width:25px;"><img src="bbsimages/blank.gif" class="latestAdSms sms" alt=""/></td>
                    <td style="width:100px;"><a href="javascript:return false;" style="color:teal;" onclick="toggle_sms_it('sms<bean:write name='result' property='adId' />');event.returnValue=false;return false;" title="Contact Advertiser">SMS Advertiser</a></td>
                    <td style="width:25px;"><img src="bbsimages/blank.gif" class="latestAdSms save" alt=""/></td>
                    <td style="width:50px;"> <a href='javascript:return false' style="color:teal;" onclick="toggle_save_it('save<bean:write name="result" property="adId" />');event.returnValue=false;return false;" title="Save Ad">Save Ad</a></td>
                </tr>
            </table>--%>
            <%--</div>--%>
            <%--</div>--%>
            <%--<div style="clear:both">--%>
            <%--</div>--%>
            <%--    <!-- ********************************************************************************************************** -->
                <!--   SAVE AD BLOCK STARTS   -->
                <!-- ********************************************************************************************************** -->
            --%>
            <!-- this works when user not logged in -->
            <%--<div class="boxBorder4" id="save<bean:write name='result' property="adId" />wl" style="width:700px;float:left;display:none">--%>
            <%--<div class="header" style="width:737px" >
                <div style="float:left;width:60%;text-align:left;"><span style="font-family:Arial;font-size:10px;font-weight:bold;padding-left:3px">To save this Ad</span>
                    <span style="font-family:Arial;font-size:10px;">&nbsp;(Please Login)</span>
                </div>
                <div style="float:left;width:35%;text-align:right;font-size:9px;font-family:Arial;"><a href="javascript:return false;" onclick="toggle_qr('nu<bean:write name="result" property="adId" />','save');event.returnValue=false;return false;" title="Register">Register</a>&nbsp;|&nbsp;
                    <a href="javascript:return false;" onclick="toggle_fp('fp<bean:write name="result" property="adId" />');event.returnValue=false;return false;" title="Forgot Password">Forgot Password</a></div>
                <div style="float:left;width:5%;text-align:right;">
                    <input type="image" src="images/close.png" onclick="toggle_close_it('save<bean:write name="result" property="adId" />wl')"/>
                </div>
            </div>
            <div id="formsave<bean:write name='result' property="adId" />wl" style="font-family:Arial;font-size:9px;padding: 1px auto;">
                <br/>
                <table style="margin:0 auto;">
                    <tr>
                        <td  width="12%" style="text-align:center"> User Id</td>
                        <td> <input id="lsave<bean:write name='result' property="adId" />wl" name="loginName" style="height:12px;font-size:9px;" type="text" size="35" /></td>
                        <td width="15%" style="text-align:center">Password</td>
                        <td><input id="psave<bean:write name='result' property="adId" />wl" name="pwd" style="height:12px;font-size:9px;" type="password" size="35" /></td>
                        <td width="15%" style="text-align:right"><input type="image"  src="bbsimages/buttons/SaveAd.png" onmouseover="this.src='bbsimages/buttons/SaveAd_MouseOver.png'" onmouseout="this.src='bbsimages/buttons/SaveAd.png'" onclick="SaveAdWL('save<bean:write name='result' property="adId" />wl',<bean:write name='result' property="adId" />)" /></td>
                    </tr>
                </table>
            </div>
                        <div id="loadsave<bean:write name='result' property="adId" />wl" style="width:auto;padding:2px 0 2px 350px;display:none"> <img src="images/loading.gif"  style="width:32px;height:32px" alt="loading"/><br/></div>
            <span style="padding:0 0 0 150px" class="fv12bc" id="msgsave<bean:write name='result' property="adId" />wl"> </span>

                <div style="width:737px;height:10px;float:left"></div>--%>
            <%--</div>--%>

            <!-- this works when user already logged in -->
            <%--<div class="boxBorder4" id="save<bean:write name='result' property="adId" />al" style="width:700px;height:60px;padding:2px 0 10px 0;float:left;display:none">--%>
            <%--<div class="header" style="background-color:#CCC;width:737px" >
                <div style="float:left;width:60%;text-align:left;">
                    <span style="font-family:Arial;font-size:10px;font-weight:bold;padding-left:3px"> To Save the Ad</span>
                </div>
                <div style="float:left;width:35%;"></div>
                <div style="float:left;width:5%;text-align:right">
                    <input type="image" src="images/close.png" onclick="toggle_close_it('save<bean:write name='result' property="adId" />al')"/>
                </div>
            </div>
            <div id="formsave<bean:write name='result' property="adId" />al" style="font-family:Arial;font-size:9px;padding: 1px auto;">
                <br />
                <table style="margin:0 auto;">
                    <tr>
                        <td class="fv12bc"> This ad will be saved in "myAccount" by saving here
                            <input type="image"  src="bbsimages/buttons/SaveAd.png" onmouseover="this.src='bbsimages/buttons/SaveAd_MouseOver.png'" onmouseout="this.src='bbsimages/buttons/SaveAd.png'" onclick="SaveAdAL('save<bean:write name="result" property="adId" />al','adId=<bean:write name="result" property="adId" />')" />
                        </td>
                    </tr>
                </table>
            </div>
            <div id="loadsave<bean:write name='result' property="adId" />al" style="width:auto;padding:2px 0 2px 350px;display:none"> <img src="images/loading.gif"  style="height:32px;width:32px;" alt="loading"/><br/></div>
            <span style="padding:0 0 0 150px" class="fv12bc" id="msgsave<bean:write name='result' property="adId" />al"> </span>--%>
            <%--</div>--%>
            <!-- ********************************************************************************************************** -->
            <!--   SAVE AD BLOCK END   -->
            <!-- ********************************************************************************************************** -->

            <!-- ********************************************************************************************************** -->
            <!-- this div for quick registration -->
            <!-- ********************************************************************************************************** -->

            <c:if test="${userBean == null}">

                <%--<div class="boxBorder4" id="nu<bean:write name="result" property="adId" />" style="width:700px;height:109px;float:left;display:none">--%>
                <%--<div class="header" style="background-color:#CCC;width:737px" >
                    <div style="float:left;width:60%;text-align:left;">
                        <span style="font-family:Arial;font-size:10px;font-weight:bold;padding-left:3px">To Register</span>
                        <span style="font-family:Arial;font-size:10px;">&nbsp;(Please Enter the information)</span>
                    </div>
                    <div style="float:left;width:35%;text-align:right;font-size:9px;font-family:Arial;"><a href="javascript:return false;" onclick="toggle_qr('nu<bean:write name="result" property="adId" />','smsadvt','<bean:write name='result' property="mobile" />','<bean:write name="result" property="title" />');event.returnValue=false;return false;" title="Register">Register</a>&nbsp;|&nbsp;
                        <a href="javascript:return false;" onclick="toggle_fp('fp<bean:write name="result" property="adId" />');event.returnValue=false;return false;" title="Forgot Password">Forgot Password</a></div>
                    <div style="float:left;width:5%;text-align:right;">
                        <input type="image" src="images/close.png" onclick="toggle_close_it('nu<bean:write name="result" property="adId" />');" />
                    </div>
                </div>
                <br />
                <form name="qrform" id="formnu<bean:write name='result' property='adId' />" method="get" action="quickReg.do" onsubmit="return validateQuickRegFormLA(this)">
                    <input type="hidden" name="adId" value="nu<bean:write name='result' property='adId' />" />
                    <table id="tablenu<bean:write name='result' property='adId' />" border="0" style="font-size:9px;margin:0 auto;margin-top:10px;_margin-top:-14px;" >
                        <tr>
                            <td width="">
                                User Id
                            </td>
                            <td>
                                <input style="height:12px;font-size:9px;width:120px" type="text" name="userName"
                                       id="l<bean:write name="result" property="adId" />" onchange="checkUsName('l<bean:write name="result" property="adId" />','nu<bean:write name="result" property="adId" />')" />
                            </td>
                            <td width="">
                                Your Name
                            </td>
                            <td width="">
                                <input style="height:12px;font-size:9px;width:120px"  type="text" name="firstName" id="n<bean:write name="result" property="adId" />" />
                            </td>
                            <td style="width:30px" align="right">
                                City
                            </td>
                            <td>
                                <select size="1"  id="ct<bean:write name="result" property="adId" />" style="font-size:9px;width:122px;_width:125px;" name="city" >
                                    <option value="" selected="selected" >select city</option>
                                    <c:if test="${cities  != null }">
                                        <c:forEach items="${cities}" var="con"><option value="<c:out value='${con.name}'/>"<c:if test='${city != null && city == con.name}' >selected='true'</c:if> ><c:out value="${con.name}"/></option></c:forEach>
                                    </c:if>
                                </select>
                            </td>
                            <td align="right">
                                Phone No
                            </td>
                            <td>
                                <input style="height:12px;font-size:9px;width:120px" type="text" name="mobile" id="ph<bean:write name='result' property='adId' />" />
                            </td>
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                            <td  style="width:130px;" align="center" valign="middle">
                                <img alt="" id="verIdnu<bean:write name="result" property="adId" />" src="rig" style="height:21px;width:100px"/>&nbsp;
                                <a class="link11" href="javascript:return false;" onclick="changeVrificationCodeQr('verIdnu<bean:write name="result" property="adId" />');event.returnValue=false;return false;" title="change Captcha"><img border="0" alt="verificationCode" src="bbsimages/referesh_button.jpg" style="height:24px;width:24px;"/></a>
                            </td>
                            <td>
                                Enter&nbsp;Code
                            </td>
                            <td>
                                <input id="vrCode<bean:write name="result" property="adId" />" type="text" name="regCode" style="width:120px;font-size:9px;" onblur="qrCheckRegCode('vrCode<bean:write name="result" property="adId" />','nu<bean:write name="result" property="adId" />')" />
                            </td>
                            <td align="right">
                                <input type="checkbox" name="iagree" /></td>
                            <td><a href="javascript:return false;" onclick="termsAndConditions('tc.do');event.returnValue=false;return false;" style="color:#046DBE" title="Terms and Conditions">I agree Terms &amp; Conditions.</a></td>
                            <td></td>
                            <td width="">
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input type="image" id="butdnu<bean:write name="result" property="adId" />"  src="bbsimages/buttons/RegisterSDis.png" disabled="disabled" />
                                <input type="image"  src="bbsimages/buttons/RegisterS.png" disabled="disabled" onmouseover="this.src='bbsimages/buttons/RegisterS_MouseOver.png'" onmouseout="this.src='bbsimages/buttons/RegisterS.png'"
                                       id="butnu<bean:write name="result" property="adId" />" style="display:none"      />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">&nbsp</td>
                            <td colspan="4" align="center"><span id="codeTestNonu<bean:write name="result" property="adId" />" name="codeTestNo" style="color:red;font-size:10px;display:none" >Verfication doesn't matched</span></td>
                            <td colspan="2">&nbsp</td>
                        </tr>
                    </table>
                    <div class="fv12bc" style="text-align:center" id="msgnu<bean:write name="result" property="adId" />"></div>
                    <div class="fv11b" style="text-align:center;" id="confnu<bean:write name='result' property='adId' />" ></div>
                    <div id="imgnu<bean:write name="result" property="adId" />" style="display:none;text-align:center">Loading...</div>
                </form>--%>
                <%--</div>--%>
            </c:if>

            <c:if test="${userBean != null}">
                <%--<div class="boxBorder4" id="nu<bean:write name="result" property="adId" />" style="width:700px;float:left;display:none"></div>--%>
            </c:if>

            <!-- ********************************************************************************************************** -->
            <!-- this div for quick registration end -->
            <!-- ********************************************************************************************************** -->

            <!-- ********************************************************************************************************** -->
            <!-- this div for forget password -->
            <!-- ********************************************************************************************************** -->

            <c:if test="${userBean == null }" >
                <%--<div class="boxBorder4" id="fp<bean:write name="result" property="adId" />" style="width:700px;float:left;display:none">--%>
                <%--<div class="header" style="background-color:#CCC;width:737px" >
                    <div style="float:left;width:60%;text-align:left;">
                        <span style="font-family:Arial;font-size:10px;font-weight:bold;padding-left:3px">To Reset Your Password</span>
                        <span style="font-family:Arial;font-size:10px;">&nbsp;(Please Enter the information)</span>
                    </div>
                    <div style="float:left;width:35%;text-align:right;font-size:9px;font-family:Arial;"><a href="javascript:return false;" onclick="toggle_qr('nu<bean:write name="result" property="adId" />','smsadvt','<bean:write name='result' property="mobile" />','<bean:write name="result" property="title" />');event.returnValue=false;return false;" title="Register">Register</a>&nbsp;|&nbsp;
                        <a href="javascript:return false;" onclick="toggle_fp('fp<bean:write name="result" property="adId" />');event.returnValue=false;return false;" title="Forgot Password">Forgot Password</a></div>
                    <div style="float:left;width:5%;text-align:right;">
                        <input type="image" src="images/close.png" onclick="toggle_close_it('fp<bean:write name="result" property="adId" />')"/>
                    </div>
                </div>

                    <div id="fpfp<bean:write name="result" property="adId" />" style="font-family:Arial;font-size:9px;margin:0 auto;">
                        <br/><br/><br/>
                        <table style="margin:0 auto;_margin-top:-12px;">
                            <tr><td>Enter Email Id</td><td>&nbsp;</td>
                                <td><input id="emfp<bean:write name="result" property="adId" />" style="height:12px;font-size:9px;width:150px" type="text" /></td>
                                <td>&nbsp;&nbsp;</td><td>Enter Mobile Number</td><td>&nbsp;</td>
                                <td><input id="yfp<bean:write name="result" property="adId" />" style="height:12px;font-size:9px;width:150px" type="text" /></td>
                                <td><span style="padding-left:20px">
                                        <input type="image"  src="bbsimages/buttons/ResetPasswordS.png" onmouseover="this.src='bbsimages/buttons/ResetPasswordS_MouseOver.png'" onmouseout="this.src='bbsimages/buttons/ResetPasswordS.png'"
                                               onclick="sendPassword('fp<bean:write name="result" property="adId" />');event.returnValue=false;return false;"/>
                                    </span></td></tr></table>
                    </div>
                    <div id="imgfp<bean:write name='result' property="adId" />" style="width:auto;padding:2px 0 2px 350px;display:none"> Loading... </div>
                    <span style="padding:0 0 0 150px" class="fv12bc" id="msgfp<bean:write name="result" property="adId" />">
                    </span>
                    <div style="width:737px;height:5px;float:left"></div>--%>
                <%--</div>--%>
            </c:if>
            <c:if test="${userBean != null }" >
                <%--<div class="boxBorder4" id="fp<bean:write name='result' property='adId' />" style="width:700px;float:left;display:none">--%>
                <%--</div>--%>
            </c:if>
            <!-- ********************************************************************************************************** -->
            <!--End  div for forget password -->
            <!-- ********************************************************************************************************** -->

            <!-- #############################################################################################################
                                                     DIV FOR SMS TO ADVERTISER STARTS
                 #############################################################################################################-->

            <%--<div id="sms<bean:write name="result" property="adId" />wl" class="boxBorder4" style="width:700px;float:left;display:none">--%>
            <%--<div class="header" style="background-color:#CCC;width:737px" >
                <div style="float:left;width:60%;text-align:left;">
                    <span style="font-family:Arial;font-size:10px;font-weight:bold;padding-left:3px">Sms To Advertiser</span>
                    <span style="font-family:Arial;font-size:10px;">&nbsp;(Please Enter the information)</span>
                </div>
                <div style="float:left;width:35%;text-align:right;font-size:9px;font-family:Arial;"><a href="javascript:return false;" onclick="toggle_qr('nu<bean:write name="result" property="adId" />','smsadvt','<bean:write name='result' property="mobile" />','<bean:write name="result" property="title" />');event.returnValue=false;return false;" title="Register">Register</a>&nbsp;|&nbsp;
                    <a href="javascript:return false;" onclick="toggle_fp('fp<bean:write name="result" property="adId" />');event.returnValue=false;return false;" title="Forgot Password">Forgot Password</a></div>
                <div style="float:left;width:5%;text-align:right">
                    <input type="image" src="images/close.png" onclick="toggle_close_it('sms<bean:write name="result" property="adId" />wl')"/>
                </div>
            </div>
            <br/>

                <div id="formsms<bean:write name='result' property="adId" />wl" style="font-family:Arial;font-size:9px;padding:1px auto">

                    <table style="margin: 10px auto;_margin-top: -10px;">
                        <tr><td> <input type="hidden" id="msms<bean:write name='result' property="adId" />wl" value="<bean:write name='result' property="mobile" />" />
                        <input type="hidden" id="adtsms<bean:write name='result' property="adId" />wl" value="<bean:write name='result' property="title" />" /></td>
                        <td  width="12%" style="text-align:left">User Id</td>
                        <td ><input style="height:12px;font-size:9px;" id="lsms<bean:write name='result' property="adId" />wl" type="text" size="35"  /></td>

                        <td  width="12%" style="text-align:left">Password</td>
                        <td><input style="height:12px;font-size:9px;" id="psms<bean:write name='result' property="adId" />wl" type="password" size="35"   /></td>
                        </tr>
                        <tr>
                            <td>Message</td>
                            <td colspan="3"><input style="height:12px;font-size:9px;width:405px;_width:415px" type="text" readonly="readonly" value="Hi, I am insterested in your ad, please contact me, I need more information about your Ad." /></td>
                            <td> <input type="image" src="bbsimages/buttons/SendSMS.png" onmouseover="this.src='bbsimages/buttons/SendSMS_MouseOver.png'" onmouseout="this.src='bbsimages/buttons/SendSMS.png'" onclick="smsAdvertiserWL('sms<bean:write name='result' property="adId" />wl','<bean:write name='result' property="adId" />')" /></td>
                        </tr>
                    </table>
                </div>
                <div id="loadsms<bean:write name='result' property="adId" />wl" style="width:auto;padding:2px 0 2px 350px;display:none"> <img src="images/loading.gif" style="height:32px;width:32px;" alt="loading"/><br/></div>
                <span style="padding:0 0 0 150px" class="fv12bc" id="msgsms<bean:write name='result' property="adId" />wl"> </span>--%>
            <%--</div>--%>
            <%--<div id="sms<bean:write name='result' property='adId' />al" class="boxBorder4" style="width:700px;height:60px;float:left;display:none;padding:2px 0 10px 0">--%>
            <%--<div class="header" style="background-color:#CCC;width:737px" >
                <div style="float:left;width:60%;text-align:left;">
                    <span style="font-family:Arial;font-size:10px;font-weight:bold;padding-left:3px">Sms To Advertiser</span>

                    </div>
                    <div style="float:left;width:35%;text-align:right;font-size:9px;font-family:Arial;">
                    </div>
                    <div style="float:left;width:5%;text-align:right">
                        <input type="image" src="images/close.png" onclick="toggle_close_it('sms<bean:write name="result" property="adId" />al')"/>
                    </div>
                </div>

                <div id="formsms<bean:write name='result' property="adId" />al" style="font-family:Arial;font-size:9px;padding: 1px auto;">
                    <br /><input type="hidden" id="msms<bean:write name='result' property="adId" />al" value="<bean:write name='result' property="mobile" />" />
                    <input type="hidden" id="adtsms<bean:write name='result' property="adId" />al" value="<bean:write name='result' property="title" />" />
                    <table style="margin:0 auto;">
                        <tr>
                            <td>  <input type="text" size="92" style="height:12px;font-size:9px;" readonly="readonly" value="Hi, I am insterested in your ad, please contact me, I need more information about your Ad."/></td>
                            <td><input type="image" src="bbsimages/buttons/SendSMS.png" onmouseover="this.src='bbsimages/buttons/SendSMS_MouseOver.png'" onmouseout="this.src='bbsimages/buttons/SendSMS.png'" onclick="smsAdvertiserAL('sms<bean:write name='result' property="adId" />al','<bean:write name='result' property="adId" />')" /></td>

                        </tr>
                    </table>
                </div>

                <div id="loadsms<bean:write name='result' property="adId" />al" style="width:auto;padding:2px 0 2px 350px;display:none"> <img src="images/loading.gif" style="height:32px;width:32px;" alt="loading"/><br/></div>

                <span  style="padding:0 0 0 150px;" class="fv12bc" id="msgsms<bean:write name='result' property="adId" />al"> </span>--%>



            <%--</div>--%>

            <!-- #############################################################################################################
                                         DIV FOR SMS TO ADVERTISER ENDS
     #############################################################################################################-->



            <!-- #############################################################################################################
                                                     DIV FOR E-MAIL TO FRIEND  STARTS
                 #############################################################################################################-->

            <!-- email to  friend for without login  users -->

            <%--<div class="boxBorder4" id="email<bean:write name='result' property='adId' />wl"  style="width:700px;float:left;display:none;">--%>

            <%--<div class="header" style="background-color:#ffcc33;width:737px;" >
                <div style="float:left;width:60%;text-align:left;"><span style="font-family:Arial;font-size:10px;font-weight:bold;padding-left:3px">To Email this Ad to Friend</span>

                        <span style="font-family:Arial;font-size:10px;">&nbsp;(Please Enter the information)</span>
                    </div>
                    <div style="float:left;width:35%;text-align:right;font-size:9px;font-family:Arial;"><a href="javascript:return false;" onclick="toggle_qr('nu<bean:write name="result" property="adId" />','emailFriend');event.returnValue=false;return false; " title="Register">Register</a>&nbsp;|&nbsp;
                        <a href="javascript:return false;" onclick="toggle_fp('fp<bean:write name="result" property="adId" />');event.returnValue=false;return false;"title="Forgot Password">Forgot Password</a></div>

                    <div style="float:left;width:5%;text-align:right">
                        <input type="image" src="images/close.png" onclick="toggle_close_it('email<bean:write name="result" property="adId" />wl')"/>
                    </div>
                </div>
                <br />--%>
            <%--<div id="formemail<bean:write name='result' property="adId" />wl" style="font-family:Arial;font-size:9px;padding:1px auto">
                <table style="margin: 10px auto;_margin-top: -10px;">

                        <tr>
                            <td  width="12%" style="text-align:left">Friend's Name </td>
                            <td><input style="height:12px;font-size:9px;" id="fnemail<bean:write name='result' property="adId" />wl" type="text" size="35"   /> </td>
                            <td width="6%" > &nbsp;</td>
                            <td  width="12%" style="text-align:left">Friend's Email </td>
                            <td><input style="height:12px;font-size:9px;" id="feemail<bean:write name='result' property="adId" />wl" type="text" size="35"   /> </td>
                            <td> &nbsp;</td>
                        </tr>

                        <tr>
                            <td  width="12%" style="text-align:left">User Id</td>
                            <td><input style="height:12px;font-size:9px;" id="lemail<bean:write name='result' property="adId" />wl" type="text" size="35"  /></td>
                            <td width="6%" > &nbsp;</td>
                            <td  width="12%" style="text-align:left">Password</td>
                            <td><input style="height:12px;font-size:9px;_width:160px;" id="pemail<bean:write name='result' property="adId" />wl" type="password" size="35"   /></td>
                            <td  width="15%" style="text-align:right"><input type="image" src="bbsimages/buttons/SendEmail.png" onmouseover="this.src='bbsimages/buttons/SendEmail_MouseOver.png'" onmouseout="this.src='bbsimages/buttons/SendEmail.png'"  onclick="sendToFriendWL('email<bean:write name='result' property="adId" />wl','<bean:write name='result' property="adId" />','<bean:write name='result' property="title" />','<bean:write name='result' property="catId" />')" /></td>
                        </tr>
                    </table>
                </div>--%>

            <%-- <div id="loademail<bean:write name='result' property="adId" />wl" style="width:auto;padding:2px 0 2px 350px;display:none"> <img src="images/loading.gif" style="height:32px;width:32px;" alt="loading"/><br/></div>

                <span style="padding:0 0 0 150px" class="fv12bc" id="msgemail<bean:write name='result' property="adId" />wl"> </span>
            --%>
            <%--</div>--%>

            <!-- email to  friend for logged in users  -->

            <%--<div id="email<bean:write name="result" property="adId" />al" class="boxBorder4" style="width:700px;height:60px;float:left;display:none;padding:2px 0 10px 0;">--%>

            <%--<div class="header" style="background-color:#ffcc33;width:737px" >
                <div style="float:left;width:60%;text-align:left;">
                    <span style="font-family:Arial;font-size:10px;font-weight:bold;padding-left:3px">To Email this Ad to Friend</span> <span style="font-family:Arial;font-size:10px;">&nbsp;(Please Enter the information)</span>
                </div>
                <div style="float:left;width:35%;">
                </div>
                <div style="float:left;width:5%;text-align:right">
                    <input type="image" src="images/close.png" onclick="toggle_close_it('email<bean:write name="result" property="adId" />al')"/>
                </div>
            </div>
            <br />--%>
            <%--<div id="formemail<bean:write name='result' property="adId" />al" style="font-family:Arial;font-size:9px;padding: 1px auto;">

                    <table style="margin:0 auto;font-size:9px; margin-top:00px;">
                        <tr>
                            <td  width="12%" style="text-align:left">Friend's Name </td>
                            <td><input style="height:12px;font-size:9px;" id="fnemail<bean:write name='result' property="adId" />al" type="text" size="35" name="friendName"  /> </td>
                            <td width="6%" > &nbsp;</td>
                            <td  width="12%" style="text-align:left">Friend's Email </td>
                            <td><input style="height:12px;font-size:9px;" id="feemail<bean:write name='result' property="adId" />al" type="text" size="35" name="friendEmail" /> </td>
                            <td  width="15%" style="text-align:right"><input type="image" src="bbsimages/buttons/SendEmail.png" onmouseover="this.src='bbsimages/buttons/SendEmail_MouseOver.png'" onmouseout="this.src='bbsimages/buttons/SendEmail.png'" onclick="sendToFriendAL('email<bean:write name='result' property="adId" />al','<bean:write name='result' property="adId" />','<bean:write name='result' property="title" />','<bean:write name='result' property="catId" />')" /></td>
                        </tr>
                    </table>
                </div>--%>
            <%--<div id="loademail<bean:write name='result' property="adId" />al" style="width:auto;padding:2px 0 2px 350px;display:none"> <img src="images/loading.gif" style="height:32px;width:32px;" alt="loading"/><br/></div>
<span  style="padding:0 0 0 150px;" class="fv12bc" id="msgemail<bean:write name='result' property="adId" />al"> </span>--%>
            <%--</div>--%>

            <!-- #############################################################################################################
                                         DIV FOR E-MAIL TO FRIEND  ENDS
     #############################################################################################################-->
            <!-- latestads part end here -->
            <!-- this part used to display commercial ads after every 5 ads -->


            <!--    This part used to display DS-MAX Mid Ads in Bangalore City and in Residential prop for Sale Category STARTS HERE   -->

            <c:set var="city"><%= (String) request.getSession().getAttribute("city")%></c:set>
            <c:if test='${subCatId == 373 && city== "Bangalore" }' >
                <c:set var="i"  value="${i + 1}" />
                <c:if test='${size > 5 && size <=10}' >
                    <c:if test='${i ==5}' ><div style="border-bottom:1px dashed #CCCCCC"><a href="http://bharatbuysell.com/dd-37/DS-MAX-PROPERTIES-PVT-LTD.html" target="blank"><center><img src="bbsimages/New/Mid_Banner.gif" style="height:70px;width:600px;margin-top:15px;margin-bottom:10px" alt=""/></center></a></div><c:set var="i" value="${i}" /></c:if>
                            </c:if>
                            <c:if test='${size > 10 && size <=15}' >
                                <c:if test='${i == 10}' ><div style="border-bottom:1px dashed #CCCCCC"><a href="http://bharatbuysell.com/dd-37/DS-MAX-PROPERTIES-PVT-LTD.html" target="blank"><center><img src="bbsimages/New/Mid_Banner.gif" style="height:70px;width:600px;margin-top:15px;margin-bottom:10px" alt=""/></center></a></div><c:set var="i" value="${i}" /></c:if>
                            </c:if>
                            <c:if test='${size > 15 && size <=20}' >
                                <c:if test='${i == 10}' ><div style="border-bottom:1px dashed #CCCCCC"><a href="http://bharatbuysell.com/dd-37/DS-MAX-PROPERTIES-PVT-LTD.html" target="blank"><center><img src="bbsimages/New/Mid_Banner.gif" style="height:70px;width:600px;margin-top:15px;margin-bottom:10px" alt=""/></center></a></div><c:set var="i" value="${i}" /></c:if>
                            </c:if>
                            <c:if test='${size > 20 && size <=30}' >
                                <c:if test='${i == 10||i==20}' ><div style="border-bottom:1px dashed #CCCCCC"><a href="http://bharatbuysell.com/dd-37/DS-MAX-PROPERTIES-PVT-LTD.html" target="blank"><center><img src="bbsimages/New/Mid_Banner.gif" style="height:70px;width:600px;margin-top:15px;margin-bottom:10px" alt=""/></center></a></div><c:set var="i" value="${i}" /></c:if>
                            </c:if>
                        </c:if>

            <c:if test='${clfId == 413 && city == "Bangalore" }' >
                <c:set var="i"  value="${i + 1}" />
                <c:if test='${size > 10 && size <=15}' >
                    <c:if test='${i ==10}' ><div style="border-bottom:1px dashed #CCCCCC"><a href="http://bharatbuysell.com/dd-37/DS-MAX-PROPERTIES-PVT-LTD.html" target="blank"><center><img src="bbsimages/New/Mid_Banner.gif" style="height:70px;width:600px;margin-top:15px;margin-bottom:10px" alt=""/></center></a></div><c:set var="i" value="${i}" /></c:if>
                            </c:if>   
                            <c:if test='${size > 15 && size <=25}' >
                                <c:if test='${i ==15}' ><div style="border-bottom:1px dashed #CCCCCC"><a href="http://bharatbuysell.com/dd-37/DS-MAX-PROPERTIES-PVT-LTD.html" target="blank"><center><img src="bbsimages/New/Mid_Banner.gif" style="height:70px;width:600px;margin-top:15px;margin-bottom:10px" alt=""/></center></a></div><c:set var="i" value="${i}" /></c:if>
                            </c:if>   
                            <c:if test='${size > 25 && size <=35}' >
                                <c:if test='${i ==15|| i==25}' ><div style="border-bottom:1px dashed #CCCCCC"><a href="http://bharatbuysell.com/dd-37/DS-MAX-PROPERTIES-PVT-LTD.html" target="blank"><center><img src="bbsimages/New/Mid_Banner.gif" style="height:70px;width:600px;margin-top:15px;margin-bottom:10px" alt=""/></center></a></div><c:set var="i" value="${i}" /></c:if>
                            </c:if>   
                        </c:if>

            <!--  This part used to display DS-MAX Mid Ads in Bangalore City and in Residential prop for Sale Category Ends HERE    -->

            <div style="clear:both">
            </div>
        </logic:iterate>
    </logic:greaterThan>
</logic:present><br/>