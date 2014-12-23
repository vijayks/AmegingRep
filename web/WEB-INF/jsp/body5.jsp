<%--
    Document   : body
    Created on : Mar 1, 2009, 1:03:49 PM
    Author     : bbsadmin
--%>


<%@page   contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://jakarta.apache.org/struts/tags-bean"  prefix="bean" %>
<%@taglib uri="http://jakarta.apache.org/struts/tags-html"  prefix="html" %>
<%@taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%@ taglib uri="http://struts.apache.org/tags-tiles" prefix="tiles" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@page import="com.buysell.beans.UserBean" %>
<%@page import="java.util.ArrayList" %>
<%@page import="java.util.List" %>
<%@page import="java.util.Iterator" %>
<%@page import="java.io.File" %>
<%@page import="com.buysell.util.CityUtil" %>
<%@page import="com.buysell.util.City" %>
<%@page import="com.buysell.util.BuySellProperties" %>
<%@page import="com.buysell.util.BannerUtil" %>
<%@page import="com.buysell.util.URlUtil" %>

<% String localUrlPath = "/";
    if (BuySellProperties.getProperty("localurl") != null && BuySellProperties.getProperty("localurl").trim().length() > 0) {
        localUrlPath = BuySellProperties.getProperty("localurl");
    }
%>

<script type="text/javascript">
    var currentSysMS=<%=System.currentTimeMillis()%>;
</script>
<%
    String sessionCity = (String) request.getSession().getAttribute("city");
    if (sessionCity == null) {
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (int i = 0; i < cookies.length; i++) {
                if (cookies[i].getName().equals("presentCity")) {
                    request.getSession().setAttribute("city", cookies[i].getValue());
                }
            }
        }
    }
    String qryString = "";
    if (request.getAttribute("queryString") != null) {
        qryString = (String) request.getAttribute("queryString");
    }

    String lastUrl = "/tile1.do";
    if (request.getSession().getAttribute("surl") != null && request.getSession().getAttribute("surl").toString().trim().length() > 0) {
        lastUrl = (String) request.getSession().getAttribute("surl");
    }
%>
<c:set var="cc"><%= (String) request.getSession().getAttribute("city")%></c:set>
<% String rId = request.getParameter("rId");
    if (rId != null && rId.length() > 10) {
        request.getSession().setAttribute("rId", rId);
    }
%>

<script type="text/JavaScript">

    function hideBanner() {
        document.getElementById("banner").style.display = 'none';
    }
    function displayBanner() {
        document.getElementById("banner").style.display = 'inline';
    }
</script>
<script type="text/javascript">
    $(document).ready(function() {

        try {
            oHandler = $("#topcitylist").msDropDown({mainCSS:'dd2'}).data("dd");
            //alert($.msDropDown.version);
            //$.msDropDown.create("body select");
            $("#ver").html($.msDropDown.version);
        } catch(e) {
            alert("Error: "+e.message);
        }
    })

</script>
<script type="text/javascript">
    $(document).ready(function() {

        try {
            oHandler = $("#subCatId").msDropDown({mainCSS:'dd3'}).data("dd");
            //alert($.msDropDown.version);
            //$.msDropDown.create("body select");
            $("#ver").html($.msDropDown.version);
        } catch(e) {
            alert("Error: "+e.message);
        }
    })

</script>
<script type="text/javascript">
    $(document).ready(function() {

        try {
            oHandler = $("#adType").msDropDown({mainCSS:'dd4'}).data("dd");
            //alert($.msDropDown.version);
            //$.msDropDown.create("body select");
            $("#ver").html($.msDropDown.version);
        } catch(e) {
            alert("Error: "+e.message);
        }
    })

</script>
<script type="text/javascript">
    $(document).ready(function() {

        try {
            oHandler = $("#websites5").msDropDown({mainCSS:'dd2'}).data("dd");
            //alert($.msDropDown.version);
            //$.msDropDown.create("body select");
            $("#ver").html($.msDropDown.version);
        } catch(e) {
            alert("Error: "+e.message);
        }
    })

</script>
<script type="text/javascript">
    $(document).ready(function() {

        try {
            oHandler = $("#websites6").msDropDown({mainCSS:'dd2'}).data("dd");
            //alert($.msDropDown.version);
            //$.msDropDown.create("body select");
            $("#ver").html($.msDropDown.version);
        } catch(e) {
            alert("Error: "+e.message);
        }
    })

</script>
<div id="bharth">
    <div class="body_part">
        <div class="body_part_wrapper">
            <div class="body_main_cont">
                <div class="body_top_menu_cont">
                    <%--    <div class="top_menu">
                            <ul>
                                <li><a href="http://blog.bharatbuysell.com/">Blog </a></li>
                                <li> | </li>
                                <li><a href="http://blog.bharatbuysell.com/category/news/">News </a></li>
                                <li> | </li>
                                <li><a href="http://blog.bharatbuysell.com/category/technology/">Technology </a></li>
                                <li> | </li>
                                <li><a href="http://blog.bharatbuysell.com/category/movies/">Movies</a></li>
                                <li> | </li>
                                <li><a href="http://blog.bharatbuysell.com/category/sports/">Sports </a></li>
                                <li> | </li>
                                <li><a href="http://blog.bharatbuysell.com/category/food/">Food </a></li>
                            </ul>
                        </div> --%>
                    <div class="body_top_left_menu_cont">
                        <a href="javascript:changeHrefForm('<%=localUrlPath%>/?city=All India')">  <div class="india_flag_img"></div></a>
                          <div class="all_india_input">
                            <select  class="" style="width:114px;" name="citySelect" id="topcitylist" onchange="javascript:selectCity('topcitylist')" >
                                <% if (lastUrl.startsWith("catCityChange")) {
                                        lastUrl = lastUrl.replace("catCityChange/", "");%>
                                <c:set var="catcityUrl"><%= lastUrl%></c:set>
                                <c:if test="${cc!='All India'}">
                                    <c:set var="smallcc" value="${fn:toLowerCase(cc)}-" />
                                    <c:set var="catcityUrl">
                                        ${fn:replace(catcityUrl,smallcc,"")}
                                    </c:set>
                                </c:if>
                                <option value="${catcityUrl}?city=All India" selected="selected"> All India</option>
                                <c:if test="${cities!=null }" >
                                    <c:forEach items="${cities}" var="city"><option value='${fn:toLowerCase(city.name)}-${catcityUrl}?city=${city.name}' <c:if test='${city.name==cc}'>SELECTED</c:if>><c:out value='${city.name}' /></option></c:forEach>
                                </c:if>
                                <% } else if (request.getSession().getAttribute("surl") != null && (request.getSession().getAttribute("surl").equals("/") || request.getSession().getAttribute("surl").equals("/tile1.do"))) {%>
                                <option value="<%=localUrlPath%>/?city=All India" > All India</option>
                                <c:if test="${cities!=null }" >
                                    <c:forEach items="${cities}" var="city"><option value='ccs-${city.name}?=' <c:if test='${city.name==cc}'>SELECTED</c:if>><c:out value='${city.name}' /></option></c:forEach>
                                </c:if>
                                <% } else {%>
                                <option value="ccs?url=<%=request.getSession().getAttribute("surl")%>&amp;city=All India<%= qryString%>" > All India</option>
                                <c:if test="${cities!=null }" >
                                    <c:forEach items="${cities}" var="city"><option value='ccs?url=<%=request.getSession().getAttribute("surl")%>&amp;city=${city.name}<%= qryString%>' <c:if test='${city.name==cc}'>SELECTED</c:if>><c:out value='${city.name}' /></option></c:forEach>
                                </c:if>
                                <% }%>
                            </select>
                            <form method="post" id="changeHrefFormForm" name="changeHrefFormForm"></form>
                        </div>
                    </div>
                </div>
                <div class="body_top_right_menu_cont">
                    <div class="post_a_free_ad_button"><a href="postAd.do"></a></div>
                </div>

                     
                    <%--LOGO IMAGE--%>
              <%--  <div class="logo_cont">  <a title="Home" <c:if test="${sessionScope.button == 'home'}" >class="selected"</c:if> href="<c:if test="${city=='All India'}"><%=localUrlPath%></c:if><c:if test="${city!='All India'}"><%=localUrlPath%>/ccs-${city}</c:if>" >
                </a> </div> --%>
                <%--LOGO IMAGE--%>
                 <div class="logo"></div>
                <%--Basic Search--%>
                <div class="body_inner_mt_cont_1">
                    <div class="search_full_bg_img">
                        <form id="basicSearch" name="basicSearch" method="post" action="basicSearch.do">
                            <div class="search_txt"><a href="javascript:void(0);" onclick="return searchSubmit();"></a></div>
                            <div class="search_box">
                                <% String keyword = (String) request.getAttribute("keyword");
                                    if (keyword != null) {%>
                                <input type="text" style="border:none" class="search_box_input"  value="<%= keyword%>"  name="keyword"  onfocus="if(this.value=='Keyword') this.value='';" onblur="if(this.value=='') this.value='Keyword';"  />
                                <% } else {%>
                                <input type="text" style="border:none" class="search_box_input"  name="keyword"  value="What you are looking...? "  onfocus="if(this.value=='What you are looking...? ') this.value='';" onblur="if(this.value=='') this.value='What you are looking...? ';" />
                                <% }%>
                            </div>
                            <div class="catery_input">
                                <select  name="subCatId" id="subCatId" style="width:200px;"> <option value="0" selected="selected" > Select Category </option>
                                    <c:if test="${categoryList != null}" >
                                        <c:forEach items="${categoryList}" var="category">
                                            <c:if test="${category.parent == 0}">
                                                <optgroup style="font-weight:bold; color: #1ea1b9; background-color:#FFFFFF;" label="${category.name}">
                                                    <c:if test="${category.subCategories != null}"><c:forEach items="${category.subCategories}" var ="cat">
                                                            <option style="color:black;padding-left:10px;" value="${cat.id}" ><c:out value="${cat.name}" escapeXml="false"/></option>
                                                        </c:forEach>
                                                    </c:if>
                                                </optgroup>
                                            </c:if>
                                        </c:forEach>
                                    </c:if>
                                </select>
                            </div>
                            <div class="offered_input">
                                <select id="adType" name="adType" style="width:115px;"> <option value="offered">Offered</option><option value="wanted">Wanted</option>  </select>
                                <input type="hidden" name="start" value="0"/> <input type="hidden" name="range" value="20"/> <input type="hidden" name="byO" value="1"/>  <input type="hidden" name="m" value="<c:out value="${m}" />"/>
                            </div>
                            <div class="blue_arrow"><a href="javascript:void(0);" onclick="return searchSubmit();"></a></div>
                        </form>
                    </div>
                </div>
                <%--Basic Search--%>

                <%--Display Category--%>
                <div>
                    <div class="main_menu_cont">
                        <nav id="ddmenu">
                            <c:if test='${categoryList != null}'>
                                <c:set var="i" value="0" />
                                <ul>
                                    <c:forEach items="${categoryList}" var="category"  varStatus="loop">
                                        <c:if test='${category.parent == 0}' > <c:set var="i"  value="${i + 1}" />
                                            <c:if test="${i<9}" > <li onmouseover="hideBanner()" onmouseout="displayBanner()"> <span style="text-transform:uppercase"><c:out value="${category.name}" escapeXml="false" /></span> </c:if>
                                            <c:if test="${i==9}" > <li onmouseover="hideBanner()" onmouseout="displayBanner()">OTHER CLASSIFIEDS</c:if>
                                                <c:if test="${category.subCategories != null}"> <c:set var="j" value="0" /> <c:if test="${i<=9}" > <div <c:if test="${i>5}">class="dropToLeft"</c:if>> </c:if>
                                                        <c:if test="${i>=9 && i%3==0}" > <div class="column" <c:if test="${i>9}" >style="width:160px;border-left:dotted 1px #CCCCCC;margin-left:5px;"</c:if>></c:if> <c:if test="${i>=9}"><b><c:out value="${category.name}" escapeXml="false"/></b></c:if><c:forEach items="${category.subCategories}" var ="cat"  varStatus="loop1" >
                                                                <c:if test="${i<9 && j%6==0}" > <div class="column"  <c:if test="${j/6>0}" >style="width:160px;border-left:dotted 1px #CCCCCC;margin-left:10px;"</c:if>></c:if> <a title="<c:out value="${fn:trim(cat.name)}" escapeXml="false" /> in <c:choose><c:when test="${city == 'All India'}">India</c:when><c:otherwise>${city}</c:otherwise></c:choose>" class="link11"  href="<c:if test="${city!=null && city!='All India'}">${fn:toLowerCase(city)}-</c:if>${fn:toLowerCase(fn:replace(fn:replace(fn:trim(cat.name),'/','-'),' ','-'))}-sc${cat.id}.in"><c:out value="${cat.name}" escapeXml="false"/></a>
                                                                    <c:choose><c:when test="${i<9 && j%6==5}" ></div></c:when> <c:when test="${i<9 && loop1.last}" > </div> </c:when> </c:choose> <c:set var="j" value="${j + 1}" /> </c:forEach>
                                                        <c:if test="${i>=9 && i%3==2}" > </div> </c:if> <c:if test="${i<9}" >
                                                        <div class="column" style="width:200px;text-align:center;">
                                                            <c:if test="${i==1}" > <img src="bbsimages/New/car.png" style="width:192px; height:108px;" /> </c:if>
                                                            <c:if test="${i==2}" > <img src="bbsimages/New/realsetate_img.png" style="width:192px; height:108px;" /> </c:if>
                                                            <c:if test="${i==3}" > <img src="bbsimages/New/furiture.png" style="width:192px; height:108px;" /> </c:if>
                                                            <c:if test="${i==4}" > <img src="bbsimages/New/pets_img.png" style="width:192px; height:108px;" /> </c:if>
                                                            <c:if test="${i==5}" > <img src="bbsimages/New/home_appliances.jpg" style="width:192px; height:108px;" /> </c:if>
                                                            <c:if test="${i==6}" > <img src="bbsimages/New/jobs_img.png" style="width:192px; height:108px;" /> </c:if>
                                                            <c:if test="${i==7}" > <img src="bbsimages/New/services_img.png" style="width:192px; height:108px;" /> </c:if>
                                                            <c:if test="${i==8}" > <img src="bbsimages/New/electricals_img.png" style="width:192px; height:108px;" /> </c:if>
                                                        </div>
                                                    </c:if> <c:if test="${i<9 || loop.last}" > </div> </c:if> </c:if>  <c:if test="${i<9 || loop.last}" > </li> </c:if> </c:if> </c:forEach> </ul> </c:if>
                                        </nav>
                                    </div>
                    <%--Display Category--%>

                    <%--Home Banner--%>
                    <div style="height:150px;width:978px">
                        <div id="banner"> 
                            <center>
                                <c:if test="${city=='Bangalore'}"> <embed width="960" height="150" style="margin-top:10px;z-index:1" src="bbsimages/New/DS_MAX_banner.swf"> </c:if>
                                <c:if test="${city!='Bangalore' && city!=''}" > <a href="<%=localUrlPath%>/postAd.do"><img src="bbsimages/New/Banner2.png" style="width:98%; height:150px;margin-top:10px" /></a> </c:if>
                            </center>
                        </div>
                    </div>
                    <%--Home Banner--%>
                    <%
                        String subCt = (String) request.getAttribute("subCatId");
                        int scid = 0;
                        if (subCt != null && subCt.trim().length() > 0) {
                            try {
                                scid = Integer.parseInt(subCt);
                            } catch (Exception e) {
                            }
                        }
                        BannerUtil bu = new BannerUtil();
                        ArrayList bl = bu.getBanners(scid, (String) request.getSession().getAttribute("city"), 1);
                        if (bl.size() == 0) {
                            bl = bu.getBanners(scid, "All India", 1);
                        }
                        ArrayList bl2 = bu.getBanners(scid, (String) request.getSession().getAttribute("city"), 2);
                        if (bl2.size() == 0) {
                            bl2 = bu.getBanners(scid, "All India", 2);
                        }
                        pageContext.setAttribute("bannerList", bl);
                        pageContext.setAttribute("bannerList2", bl2);

                    %>

                    <%--  Premium Banner(Top Banner) Starts --%>

                    <div class="featured_cont_txt">premium</div>

                    <div class="img_cont_prm">
                        <%--<marquee  onmouseover="this.setAttribute('scrollamount', 0, 0);" onmouseout="this.setAttribute('scrollamount', 3, 0);" scrollamount=""  direction="right" border="0" cellspacing="0" cellpadding="0" style="width:920px;height:90px">--%>
                        <table width="0" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td>
                                    <c:if test="${bannerList!=null&& fn:length(bannerList)>0}">
                                        <c:forEach items="${bannerList}" var="ad">
                                            <div class="img_bg_1" style="margin:0 10px 0 0;">
                                                <div class="img_1">
                                                    <a title="${ad.scrTitle}"  class="link" href="<c:choose>
                                                           <c:when test="${ad.dealerId>0}"><%=localUrlPath%>/dd-${ad.dealerId}/${ad.dlrName}.html</c:when>
                                                           <c:when test="${ad.url!=null&&fn:length(ad.url)>0}">http://${ad.url}</c:when>
                                                           <c:otherwise>#</c:otherwise></c:choose>" target="_blank">
                                                        <img src="resourceGetter?imf=${ad.img1}" style="height:79px;width:207px"  border="0" alt="${ad.scrTitle}"/>
                                                    </a>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </c:if>

                                </td>
                            </tr>
                        </table>
                        <%-- </marquee>--%>
                    </div>
                    <%--  Premium Banner(Top Banner) Stop --%>

                    <%--  Featured Banner(Side Banner) Strats --%>
                    <div class="premium_main_cont">
                        <c:if test="${bannerList2!=null&& fn:length(bannerList2)>0}">
                            <div class="premium_cont_txt">featured</div>
                            <div class="img_cont">
                                <marquee behavior="alternate" onmouseover="this.stop();" onmouseout="this.start();" scrollamount="3"  direction="right" border="0" cellspacing="0" cellpadding="0" style="height: 90px;" >
                                    <table width="0" border="0" cellspacing="0" cellpadding="0" >
                                        <tr>
                                            <td>
                                                <c:forEach items="${bannerList2}" var="ad">
                                                    <div class="img_bg_1">
                                                        <div class="img_1">
                                                            <a title="${ad.scrTitle}" class="link" target="_blank" href="<c:choose><c:when test="${ad.dealerId>0}"><%=localUrlPath%>/dd-${ad.dealerId}/${ad.dlrName}.html</c:when><c:when test="${ad.url!=null&&fn:length(ad.url)>0}">http://${ad.url}</c:when><c:otherwise>#</c:otherwise></c:choose>" >
                                                                <img src="resourceGetter?imf=${ad.img1}"  alt="${ad.scrTitle}" border="0" style="height:79px;width:207px"/>
                                                            </a>
                                                        </div>
                                                    </div>
                                                </c:forEach>
                                                <style type="text/css">
                                                    .img_cont table {
                                                        width:${(fn:length(bannerList2))*230}px;
                                                    }
                                                </style>
                                            </td>
                                        </tr>
                                    </table>
                                </marquee>
                            </div>
                            <div class="img_cont">
                                <marquee behavior="alternate" scrollamount="3" onmouseover="this.stop();" onmouseout="this.start();"  direction="left" border="0" cellspacing="0" cellpadding="0" style="width:920px;height:90px">
                                    <table width="0" border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                            <td>
                                                <c:forEach items="${bannerList2}" var="ad">
                                                    <div class="img_bg_1">
                                                        <div class="img_1">
                                                            <a title="${ad.scrTitle}" class="link" target="_blank" href="<c:choose><c:when test="${ad.dealerId>0}"><%=localUrlPath%>/dd-${ad.dealerId}/${ad.dlrName}.html</c:when><c:when test="${ad.url!=null&&fn:length(ad.url)>0}">http://${ad.url}</c:when><c:otherwise>#</c:otherwise></c:choose>" >
                                                                <img src="resourceGetter?imf=${ad.img1}"  alt="${ad.scrTitle}" border="0" style="height:79px;width:207px"/>
                                                            </a>
                                                        </div>
                                                    </div>
                                                </c:forEach>
                                            </td>
                                        </tr>
                                    </table>
                                </marquee>
                            </div>
                        </c:if>
                    </div>
                    <%--  Featured Banner(Side Banner) Stop --%>
                </div>
            </div>
        </div>
    </div>
</div>
<!-------------------------------------body_part_right_part end here------------------------------------------->

