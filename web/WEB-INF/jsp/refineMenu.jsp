<%--
    Document   : adTemplate
    Created on : Apr 1, 2009, 12:50:13 PM
    Author     : bbsadmin
--%>
<%@ taglib uri="http://struts.apache.org/tags-tiles" prefix="tiles" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn"%>
<%@page import="com.buysell.util.BannerUtil" %>
<%@page import="java.util.ArrayList" %>
<%@page import="com.buysell.util.BuySellProperties" %>
<% String localUrlPath = "/";
if (BuySellProperties.getProperty("localurl") != null && BuySellProperties.getProperty("localurl").trim().length() > 0) {
                localUrlPath = BuySellProperties.getProperty("localurl");
            }
%>
<div style="margin:0% 5%;">
     <div style="width:25%;">&nbsp;</div>

    <%-- <jsp:include page="/WEB-INF/jsp/delearSearch.jsp"/>--%>
    <%
        String subCt=(String)request.getAttribute("subCatId");
        int scid=0;
        if(subCt!=null&&subCt.trim().length()>0) {
            scid=Integer.parseInt(subCt);
        } else {
            String clf = (String)request.getAttribute("clfId");
            if(clf!=null&&clf.trim().length()>0) {
                scid=Integer.parseInt(clf);
        }
        }
        BannerUtil bu = new BannerUtil();
        ArrayList bl=bu.getBanners(scid,(String)request.getSession().getAttribute("city"),2);
        ArrayList vbl=bu.getVideoBanners(scid,(String)request.getSession().getAttribute("city"),2);
        pageContext.setAttribute("bannerList",bl);
        pageContext.setAttribute("videoBannerList",vbl);
    %>

    <c:if test="${videoBannerList!=null&& fn:length(videoBannerList)>0}">
        <c:forEach items="${videoBannerList}" var="vd">
            <c:if test="${vd.url!=null&&fn:length(vd.url)>0}">
                <div class="video"> <iframe width="225" height="150" src="${vd.url}" frameborder="0" allowfullscreen></iframe></div>
            </c:if>
        </c:forEach>
    </c:if>
    <c:if test="${bannerList!=null&& fn:length(bannerList)>0}">
            <div class="car_fistpage_top_border_2_txt">Featured Business</div>
            <c:forEach items="${bannerList}" var="ad">
            <div class="img_bg_1" style="margin:0 7px 0 0;height:100px">
                <div class="img_1">
                   <a title="${ad.scrTitle}" class="link" target="_blank" href="<c:choose><c:when test="${ad.dealerId>0}"><%=localUrlPath%>/dd-${ad.dealerId}/${ad.dlrName}.html</c:when><c:when test="${ad.url!=null&&fn:length(ad.url)>0}">http://${ad.url}</c:when><c:otherwise>#</c:otherwise></c:choose>">
                        <img src="resourceGetter?imf=${ad.img1}" width="207" height="79" alt="${ad.scrTitle}"/> </a>
                </div>
            </div>
       </c:forEach>
    </c:if>
</div>

<!--<script type="text/javascript">
    if(!(document.location.href.indexOf('postAd')>-1))
        document.getElementById("userLead").style.display="block";
</script>-->
<%--<script type="text/javascript" language="javascript">
    var globalCok=0;
    function isEligibleToRefine(lcsChieldName, clfsChieldName){
        var locationOk=0;
        var clfOk=globalCok;
        var chieldsList = document.getElementsByName(lcsChieldName);
        if(chieldsList != null && chieldsList.length>0){
            for(var i=0 ; i<chieldsList.length ;i++ )
            {
                if(chieldsList[i].checked ==true)
                {
                    locationOk=1;
                    break;
                }
            }
        }
        chieldsList = document.getElementsByName(clfsChieldName);
        if(chieldsList != null && chieldsList.length>0){
            for(var i=0 ; i<chieldsList.length ;i++ )
            {
                if(chieldsList[i].checked ==true)
                {
                    clfOk=1;
                    break;
                }
            }
        }
        if(locationOk == 0 || clfOk == 0){
            if(locationOk ==0 && clfOk ==0){
                alert("One location and one Classfication must");
            }else if(locationOk ==1 && clfOk ==0){
               alert("One Classfication must");
            }else if(locationOk ==0 && clfOk ==1){
    <c:if test="${cityObj.name != 'All India'}" >
                    alert("One location must") ;
                    return false;
    </c:if>
    <c:if test="${cityObj.name == 'All India'}" >
                    return true;
    </c:if>
                }
                return false;
            }
        }
        function checkAll(allIdStatus,chieldName)
        {
            var chieldsList = document.getElementsByName(chieldName);
            if(chieldsList != null && chieldsList.length>0){
                for(var i=0 ; i<chieldsList.length ;i++ )
                {
                    chieldsList[i].checked= allIdStatus.checked;
                }
            }
        }
        function reCheckTheAll(chieldIdStatus,allId,chieldName){
           if(chieldIdStatus.checked == false){
                document.getElementById(allId).checked=false;
            }else{
                var chieldsList = document.getElementsByName(chieldName);
                if(chieldsList != null && chieldsList.length>0){
                    var c=chieldsList.length ;
                    for(var i=0 ; i<chieldsList.length ;i++ )
                    {
                        if(chieldsList[i].checked== false)
                        {
                            break;
                        }
                    }
                    if(i==chieldsList.length){
                        document.getElementById(allId).checked=true;
                    }
                }
            }
       }
        function numbersonly(e, decimal) {
            var key;
            var keychar;
            if (window.event) {
                key = window.event.keyCode;
            }
            else if (e) { key = e.which; }
            else { return true; }
            keychar = String.fromCharCode(key);
            if ((key==null) || (key==0) || (key==8) ||  (key==9) || (key==13) || (key==27) ) {
                return true;
            }
            else if ((("0123456789").indexOf(keychar) > -1)) {
                return true;
            }
            else if (decimal && (keychar == ".")) {
                return true;
            }
            else
            return false;
    }
</script>--%>
<%--<c:if test="${subCatId == '0' }">
    <script type="text/javascript" language="javascript">
    var globalCok=1;
    </script>
</c:if>--%>
<c:set var="rqur">${fn:substring(reqURI,0,fn:length(reqURI))}</c:set>
<c:choose>
    <c:when test="${rqur=='createAd.do'}">
        <%-- <img src="bbsimages/postAd_menu.jpg" alt="post Ad"/>--%>
    </c:when>
    <c:otherwise>
        <%--<style type="text/css">
            #searchTls table{
                width:100%;
                background:#FFFFFF;
                font-size:12px;
                border-spacing:0px;
            }
            #searchTls table td{
                width:95%;
                height:20px;
                display:block;
                padding:3% 0% 0% 5%;
		float:left;
		*padding-left:0%;
            }
            #searchTls table td:first-child{
                background-color:#ddeeff;
                border-top:1px solid #aaaaaa;
                border-bottom:1px solid #aaaaaa;
            }
            #searchTls table td:last-child{
                text-align:center;
            }
	    .fv11 {
		padding-left:10px
	    }
        </style>
        <br/>
        <div style="width:90%;margin:0% 5%;*margin:0% 0.5%">
<c:if test="${false}">
    <div class="refineBox" style="background:#a3d3ef;border:1px solid silver;color:#222222;font-size:12px;width:99%;"><div style="padding:5px 10px;font-weight:bold;">Refine Search</div></div>
<div id="RefineSearch" style="float:left;background-color:#ddeeff;color:black;width:100%;">
    <form action="sRefine.do" method="post" >
        <% String keyword = (String) request.getAttribute("keyword");
            if (keyword == null) {
            keyword="";
         }%>
        <input type="hidden" name="keyword" value="<%= keyword%>" />
        <% String subCatId = (String) request.getAttribute("subCatId");
            if (subCatId != null) {%>
        <input type="hidden" name="subCatId" value="<%= subCatId%>" />
        <% }%>
       <input type="hidden" name="from" value="refine" />
        <c:if test="${tilesList!=null}">
        <input type="hidden" name="adType" value="<c:if test="${adType!='all'}" ><c:out value="${adType}" /></c:if>" >
	<div id="searchTls"  style="width:99%;float:left;" class="boxBorder2y">
            <span class="fv11"> Select one or more options to refine the search :</span><br />
            <c:forEach items="${tilesList}" var="tile">
                <tiles:insert name="${tile}"/>
            </c:forEach>
        </div>
        </c:if>
        <!-- If it is directly form Refine search -->
            <c:if test="${cityObj != null && cityObj.name != 'All India'}" >
                <div style="width:99%;float:left;padding:5px 0 2px 0px" class="boxBorder2y">
                    <span class="fv11">Select One or More Localities:</span> <br />
                    <div  style="height:auto;max-height:250px;overflow:auto;color:#222222;margin-top:4px;border:1px solid #fff;background-color:#FFFFFF;">
                        <c:if test="${cityObj != null }">
                            <c:if test="${cityObj.loc != null }">
                                <table border="0" cellpadding="0px" cellspacing="0px" style="padding-left:5%">
                                    <tr>
                                        <td>
                                            <input id="allLcs" type="checkbox"  value=""  onclick="checkAll(this,'lcs')" <c:if  test="${(localsSelected == null) || (localsSelected != null && (fn:length(localsSelected)) == (fn:length(cityObj.loc)))}" > checked </c:if> ></td>
                                        <td style="padding-left:4px;">All</td>
                                    </tr>
                                    <c:forEach items="${cityObj.loc}" var="local">
                                        <tr>
                                            <td>
                                                <input name="lcs" type="checkbox"  onclick="reCheckTheAll(this,'allLcs','lcs')" value="<c:out value="${local.name}"/>"
                                                       <c:choose>
                                                           <c:when test="${localsSelected != null }">
                                                           <c:forEach items="${localsSelected}" var="selectedLoc">
                                                               <c:if test="${local.name == selectedLoc }">
                                                                   checked="true"
                                                               </c:if>
                                                           </c:forEach>
                                                           </c:when>
                                                               <c:otherwise>
                                                                   checked="true"
                                                               </c:otherwise>
                                                       </c:choose> >
                                            </td>
                                            <td style="padding-left:4px;"><c:out value="${local.name}"/>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </table>
                            </c:if>
                        </c:if>
                    </div>
                </div>
            </c:if>
            <c:if test="${subCatId != null && subCatId != '0' }">
                <div style="width:99%;float:left;padding:5px 0 2px 0px" class="boxBorder2y">
                    <span class="fv11">Select One or More Classifications:</span><br />
                    <div  style="height:auto;max-height:250px;overflow:auto;color:#222222;margin-top:4px;border:1px solid #fff;background-color:#FFFFFF">
                        <c:if test="${clfIds != null }">
                           <c:if test="${categoryList != null}" >
                                <table border="0" cellpadding="0px" cellspacing="0px" style="padding-left:5%">
                                    <tr>
                                        <td>
                                            <input id="allClfs" type="checkbox"  value="" onclick="checkAll(this,'clfs')" <c:if  test="${(clfsSelected == null)||(clfsSelected != null && (fn:length(clfsSelected)) == (fn:length(clfIds))) }" > checked </c:if> ></td>
                                        <td style="padding-left:4px;">All</td>
                                    </tr>
                                    <c:forEach items="${clfIds}" var="clfId">
                                        <c:forEach items="${categoryList}" var="cat">
                                            <c:if test="${cat.id == clfId}" >
                                               <tr>
                                                    <td>
                                                        <input name="clfs" type="checkbox"  onclick="reCheckTheAll(this,'allClfs','clfs')" value="<c:out value="${clfId}"/>"
                                                               <c:choose>
                                                                   <c:when test="${clfsSelected != null }">
                                                                   <c:forEach items="${clfsSelected}" var="selectedClf">
                                                                       <c:if test="${clfId == selectedClf }">
                                                                         checked="true"
                                                                       </c:if>
                                                                   </c:forEach>
                                                                   </c:when>
                                                                       <c:otherwise>
                                                                           checked="true"
                                                                       </c:otherwise>
                                                               </c:choose> >
                                                    </td> <td style="padding-left:4px;"><c:out value="${cat.name}"  escapeXml="false"/>
                                                    </td>
                                                </tr>
                                            </c:if>
                                        </c:forEach>
                                    </c:forEach>
                                </table>
                            </c:if>
                        </c:if>

                    </div>
                </div>
            </c:if>
	<c:if test="${subCatId==null || subCatId==0}">
		<% String urlclfid=request.getParameter("clfId");
			String urlscid=request.getParameter("subCatId");
			if(urlscid == null || urlscid.trim().length()==0)
				urlscid = "0";
			if(urlclfid != null && urlclfid.trim().length()>0) {%>
				<div style="display:none">
					<input name="clfs" type="checkbox" value="<%=urlclfid%>" checked="true"/>
					<input name="subCatId" value="<%=urlscid%>" type="hidden" />
				</div>
		<%	}
		%>
	</c:if>
        <!-- this is used to display the left menu as per prev menu-->
        <input type="hidden" name="m" value="<c:out value="${m}" />">
	<c:if test="${tilesList==null}">
	<input type="hidden" name="adType" value="" >
        </c:if>
	<div style="clear:both"></div>
        <div class="boxBorder2y">
            <center><input type="image" onclick="return isEligibleToRefine('lcs','clfs')"  src="bbsimages/buttons/RefineSearch.png" style="margin:8px 0px;" /></center>
        </div>
            </form>
        </div>
        <div style="clear:both"></div>
        </c:if>
        </div>   <br/>
        <img src="bbsimages/rightAd.gif" width="223" height="439" alt="http://bharatbuysell.com" style="margin:0% 5%;" />
        //GoogleAds <br/>
            <script type="text/javascript">
                CallCurveCorners("refineBox",5,0);
            </script>--%>
    </c:otherwise>
</c:choose>
