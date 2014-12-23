<%--
Document   : header
Created on : Mar 1, 2009, 1:03:05 PM
Author     : praveen.ch
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
<%@page  import="com.buysell.util.Category " %>
<%@page  import="com.buysell.util.CategoryUtil " %>
<%@page import="com.buysell.util.City" %>
<%@page import="com.buysell.util.BuySellProperties" %>
<%@page import="com.buysell.util.BannerUtil" %>
<% String localUrlPath = "/";
if (BuySellProperties.getProperty("localurl") != null && BuySellProperties.getProperty("localurl").trim().length() > 0) {
                localUrlPath = BuySellProperties.getProperty("localurl");
            }
%>
<link href="<%=localUrlPath%>/css/New/bharth.css" type="text/css" rel="stylesheet" />
<c:if test="${subCatId == '0' }">
    <script type="text/javascript" language="javascript">
        var globalCok=1;
    </script>
</c:if>
<script type="text/javascript">
    function selectCity(itemID)
    {
        var dropdownIndex = document.getElementById(itemID).selectedIndex;
        var dropdownValue = document.getElementById(itemID)[dropdownIndex].value;
    <%--document.location.href=dropdownValue;--%>
            changeHrefForm(dropdownValue);
        }

        function changeHrefForm(refValue) {
            var ccform=document.getElementById("changeHrefFormForm");
            if(refValue.indexOf('?')>0) {
                var formaction = refValue.substring(0, refValue.indexOf('?'));
                var formpms = refValue.substring(refValue.indexOf('?')+1, refValue.length);
                ccform.setAttribute("action", formaction);
                var nopms=formpms.split('=').length-1;
                var pms=formpms.split('&');
                for(var i=0;i<nopms;i++) {
                    var pm1=pms[i].substring(0,pms[i].indexOf('='));
                    var pm2=pms[i].substring(pms[i].indexOf('=')+1, pms[i].length);
                    var inpm=document.createElement("input");
                    inpm.setAttribute("name", pm1);
                    inpm.setAttribute("value", pm2);
                    inpm.setAttribute("type", "hidden");
                    ccform.appendChild(inpm);
                }
                ccform.submit();
            }
        }
        var FeedBack='yes';
        function searchSubmit() {
            document.basicSearch.submit();
            return true;
        }
</script>
<script type="text/javascript">
    var currentSysMS=<%=System.currentTimeMillis()%>;
</script>
<%
            String sessionCity = (String) request.getSession().getAttribute("city");
            if (sessionCity == null) {
                Cookie[] cookies = request.getCookies();
                if(cookies!=null) {
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
            if (request.getSession().getAttribute("surl") != null && request.getSession().getAttribute("surl").toString().trim().length()>0) {
                lastUrl = (String) request.getSession().getAttribute("surl");
            }
%>
<c:set var="cc"><%= (String) request.getSession().getAttribute("city")%></c:set>
<% String rId = request.getParameter("rId");
            if (rId != null && rId.length() > 10) {
                request.getSession().setAttribute("rId", rId);
            }
%>
<!--[if IE 8]>
<link href="<%=localUrlPath%>/css/ie8.css" rel="stylesheet" type="text/css" />
<![endif]-->
<!--[if IE 7]>
<link href="<%=localUrlPath%>/css/ie7.css" rel="stylesheet" type="text/css" />
<![endif]-->
<!--[if IE 6]>
<link href="<%=localUrlPath%>/css/ie6.css" rel="stylesheet" type="text/css" />
<![endif]-->
<!--menus scripts start-->
<script type="text/javascript" src="<%=localUrlPath%>/js/alljs.js"></script>
<script type="text/javascript" src="<%=localUrlPath%>/js/tooltip.js"></script>
<script type="text/javascript" src="<%=localUrlPath%>/js/allAjax.js" ></script>
<!--menus scripts end-->


<!--menus scripts start-->
<link href="<%=localUrlPath%>/css/New/ddmenu/ddmenu.css" rel="stylesheet" type="text/css" />
<script src="<%=localUrlPath%>/css/New/ddmenu/ddmenu.js" type="text/javascript"></script>
<!--menus scripts end-->
<link rel="stylesheet" type="text/css" href="<%=localUrlPath%>/css/New/dd.css" />
<script type="text/javascript" src="<%=localUrlPath%>/js/jquery-1.8.2.min.js"></script>
<script type="text/javascript" src="<%=localUrlPath%>/js/jquery-ui-1.8.24.custom.min.js"></script>
<link href="<%=localUrlPath%>/css/jquery-ui-1.8.24.custom.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="<%=localUrlPath%>/js/New/jquery.dd.js"></script>
<script type="text/javascript">
    $(function() {
        var offset = $("#sidebar").offset();
        var topPadding = 15;
        $(window).scroll(function() {
            if (offset && $(window).scrollTop() > offset.top) {
                $("#sidebar").stop().animate({
                    marginTop: $(window).scrollTop() - offset.top + topPadding
                });
            } else {
                $("#sidebar").stop().animate({
                    marginTop: 0
                });
            };
        });
    });
</script>
<script type="text/javascript">
    var currentSysMS=<%=System.currentTimeMillis()%>;
</script>
<!--advance search-->
<script type="text/javascript" src="<%=localUrlPath%>/css/accordion/script2_as.js"></script>
<link rel="stylesheet" href="<%=localUrlPath%>/css/accordion/style.css" type="text/css" />
<!--advance search-->

<!--right sidebar-->
<script type="text/javascript" src="<%=localUrlPath%>/js/New/jquery.validate.pack.js"></script>
<script type="text/javascript" src="<%=localUrlPath%>/js/New/jquery.contactable.js"></script>
<link rel="stylesheet" href="<%=localUrlPath%>/css/New/contactable.css" type="text/css" />
<script>
    $(function(){
        $('#contact').contactable({
            subject: 'A Feeback Message'
        });
    });
</script>
<script type="text/javascript">
    $(document).ready(function() {

        try {
            oHandler = $("#topcitylist1").msDropDown({mainCSS:'dd2'}).data("dd");
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
<!--/right sidebar-->
<form method="post" id="changeHrefFormForm" name="changeHrefFormForm"></form>
<!-----------------------------------------------top menu part start here------------------------------------------------>
<div class="menu_part">
    <div class="menu_wrapper" style="z-index:1000;">
        <div class="menu_cont" >
            <div class="main_header">
                <div class="menu_box1">
                    <div class="header1">
                        <div class="header1_text">
                            <c:set var="cityName"><c:choose><c:when test="${city == 'All India'}">India</c:when><c:otherwise>${city}</c:otherwise></c:choose></c:set>
                            <%
                            String sci=request.getParameter("subCatId");
                            CategoryUtil cu = new CategoryUtil();
                            String clfId = request.getParameter("clfId");
                            %>
                            <c:if test="${reqURI=='tile1.do'}"><h1>Free ${cityName} Classifieds </h1></c:if>
                            <c:if test="${reqURI=='clf.do'}"><h1> <%=cu.getCategoryNameWithId(Integer.parseInt(sci))%> - ${cityName} </h1></c:if>
                            <c:if test="${reqURI=='displayClfAds.do'}"><h1> <%=cu.getCategoryNameWithId(Integer.parseInt(clfId))%> - <%=cu.getCategoryNameWithId(Integer.parseInt(sci))%> - ${cityName} </h1></c:if>
                        </div>

                    </div>
                </div>
                <%--For Cart Hurt
                <div style="float:left;background-color:white;width:250px;height:40px;margin:2px 0 2px 10px;"><blink><div style="font-family:Verdana;font-size:14px;font-weight:bold;color:#FF7600;padding:10px 0 10px 30px;">30 Carts Left</div></blink></div>
                For Cart Hurt--%>
                <div class="menu_box">
                    <div class="home"><div class="home_img"></div>
                        <a title="Home" <c:if test="${sessionScope.button == 'home'}" >class="selected"</c:if> href="<c:if test="${city=='All India'}"><%=localUrlPath%></c:if><c:if test="${city!='All India'}"><%=localUrlPath%>/ccs-${city}</c:if>" >Home</a> </div>
                    <div class="my_bbs"><div class="my_bbs_img"></div>
                        <logic:present name="userBean"><a title="My Account" id="myAccount" <c:if test="${sessionScope.button == 'myAccount'}" >class="selected"</c:if> href="<%=localUrlPath%>/my_ads_details.do">My BBS</a></logic:present>
                        <logic:notPresent name="userBean"><a title="My Account" id="myAccount" href="<%=localUrlPath%>/myAccountNL.do">My BBS</a></logic:notPresent></div>
                    <div class="community"><div class="community_img"></div>
                        <a title="Post Ad" id="postAd" <c:if test="${sessionScope.button == 'postAd'}" >class="selected"</c:if> href="<%=localUrlPath%>/postAd.do">Post Ad</a> </div>
                    <div class="help"><div class="help_img"></div>
                        <a title="Help" href="<%=localUrlPath%>/help.do " target="_blank">FAQ'S</a></div>
                    <div class="register"><div class="register_img"></div>
                        <a title="Register" id="register" <c:if test="${sessionScope.button == 'register'}" >class="selected"</c:if> href="<%=localUrlPath%>/register.do">Register</a></div>
                    <div class="signin"><div class="signin_img"></div>
                        <logic:notPresent name="userBean">
                            <a title="Sign in" id="login" <c:if test="${sessionScope.button == 'login'}" >class="selected"</c:if> href="<%=localUrlPath%>/myAccountNL.do" ><span id="dr" >Login</span></a>
                        </logic:notPresent>
                        <logic:present name="userBean">
                            <a title="Sign out" id="login" href="<%=localUrlPath%>/logout.do" onclick="document.getElementById('dr').innerHTML='Login'" >Logout</a>
                        </logic:present>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-------------------------------------------top menu part end here------------------------------------------->

<!--slide bar start here-->
<div id="contactForm">
    <iframe id="contactFormFrame" src="<%=localUrlPath%>/leadForm.do" width="494px" height="537px" allowtransparency="yes" scrolling="no" frameborder="0"></iframe>
</div>
<div id="contact"><a href="#"></a></div>
<!--slide bar start here-->

<!------------------------------------------ Header Part For Remaining Pages Start Here ------------------------------------------------->

<c:if test="${reqURI!='tile1.do'}">
    <div class="body_part">
        <div class="body_part_wrapper">
            <div class="body_main_cont">
                <c:if test="${reqURI=='moreDetailsEmail.do'}">
                    <c:set var="adCatId" value="${moreDetails.catId}"/>
                    <%
                      int cid = Integer.parseInt(pageContext.getAttribute("adCatId").toString());
                      int pcid = cu.getRootCatId(cid);
                    %>
                    <c:set var="scnm"><%=cu.getCategoryNameWithId(pcid)%></c:set>
                    <c:set var="clfnm"><%=cu.getCategoryNameWithId(cid)%></c:set>
                    <center><div style=" color: #BFBFBF;font: 1.1em/1 arial,helvetica,sans-serif;font-size:12px;  overflow: hidden;width: 960px;margin-top: 5px;">
                            <div style="display: inline-block"><h1>${moreDetails.title} </h1></div> <div style="display: inline-block"> - ${clfnm} - ${scnm} - ${moreDetails.city}</div>
                        </div></center>                                   
                    </c:if>
                    <c:if test="${reqURI=='basicSearch.do'|| reqURI=='sRefine.do'}">
                        <c:if test="${keyword==' '&& subCatId==0}"><center><div style=" color: #BFBFBF;font: 1.1em/1 arial,helvetica,sans-serif;font-size:12px;  overflow: hidden;width: 960px;margin-top: 5px;"> <h1>Search ${city}</h1></div></center> </c:if>
                    <c:if test="${keyword==' '&& subCatId >0}"><center><div style=" color: #BFBFBF;font: 1.1em/1 arial,helvetica,sans-serif;font-size:12px;  overflow: hidden;width: 960px;margin-top: 5px;"> <h1><%=cu.getCategoryNameWithId(Integer.parseInt(sci))%> - ${city}</h1></div></center></c:if>
                    <c:if test="${keyword!=' '&& subCatId ==0}"><center><div style=" color: #BFBFBF;font: 1.1em/1 arial,helvetica,sans-serif;font-size:12px;  overflow: hidden;width: 960px;margin-top: 5px;"> <h1>${keyword} - ${city}</h1> </div></center> </c:if>
                    <c:if test="${keyword!=' '&& subCatId >0}"> <center><div style=" color: #BFBFBF;font: 1.1em/1 arial,helvetica,sans-serif;font-size:12px;  overflow: hidden;width: 960px;margin-top: 5px;"> <h1>${keyword} - <%=cu.getCategoryNameWithId(Integer.parseInt(sci))%> -  ${city}</h1> </div></center> </c:if>
                </c:if>

                <div class="car_fistpage_main_inner_cont">
                    <div class="car_fistpage_main_left_mt_cont_225">
                        <a title="Home" <c:if test="${sessionScope.button == 'home'}" >class="selected"</c:if> href="<c:if test="${city=='All India'}"><%=localUrlPath%></c:if><c:if test="${city!='All India'}"><%=localUrlPath%>/ccs-${city}</c:if>" ><div class="car_fistpage_logo"></div></a>
                        <div class="car_fistpage_flage_cont">
                            <a href="javascript:changeHrefForm('<%=localUrlPath%>/?city=All India')"> <div class="car_fistpage_flag_img"></div></a>
                            <div class="car_fistpage_all_india_input">
                                <select  class="" style="width:114px;" name="citySelect" id="topcitylist1" onchange="javascript:selectCity('topcitylist1')" >
                                    <% if(lastUrl.startsWith("catCityChange")) { lastUrl=lastUrl.replace("catCityChange/", ""); %>
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
                                    <% } else if(request.getSession().getAttribute("surl")!=null&&(request.getSession().getAttribute("surl").equals("/")||request.getSession().getAttribute("surl").equals("/tile1.do"))) {%>
                                    <option value="<%=localUrlPath%>/?city=All India" > All India</option>
                                    <c:if test="${cities!=null }" >
                                        <c:forEach items="${cities}" var="city"><option value='ccs-${city.name}?=' <c:if test='${city.name==cc}'>SELECTED</c:if>><c:out value='${city.name}' /></option></c:forEach>
                                    </c:if>
                                    <% } else {%>
                                    <option value="ccs?url=<%=request.getSession().getAttribute("surl")%>&amp;city=All India<%= qryString%>" > All India</option>
                                    <c:if test="${cities!=null }" >
                                        <c:forEach items="${cities}" var="city"><option value='ccs?url=<%=request.getSession().getAttribute("surl")%>&amp;city=${city.name}<%= qryString%>' <c:if test='${city.name==cc}'>SELECTED</c:if>><c:out value='${city.name}' /></option></c:forEach>
                                    </c:if>
                                    <% } %>
                                </select>
                            </div></div>
                    </div>
                    <div class="car_fistpage_main_right_mt_cont_707">
                        <div class="car_fistpage_main_right_mt_cont_707_inner">
                            <%
                             String subCt=(String)request.getAttribute("subCatId");
                             int scid=0;
                             if(subCt==null||subCt.trim().length()==0) {
                                 subCt=request.getParameter("subCatId");
                                 if(subCt==null||subCt.trim().length()==0) {
                                    subCt=request.getParameter("catId");
                                 }
                             }
                             if(subCt!=null&&subCt.trim().length()>0) {
                                 try{scid=Integer.parseInt(subCt);}catch(Exception e){}
                             }
                             if(scid>0) {
                                BannerUtil bu = new BannerUtil();
                                ArrayList bl=bu.getBanners(scid,(String)request.getSession().getAttribute("city"),1);
                                pageContext.setAttribute("bannerList",bl);
                            %>
                            <script type="text/javascript">
                                document.getElementById("contactFormFrame").setAttribute("src", "<%=localUrlPath%>/leadForm.do?scId=<%=scid%>");
                            </script>
                            <%
                            }
                            %>

                            <c:choose>
                                <c:when test="${bannerList!=null&& fn:length(bannerList)>0}">
                                    <c:forEach items="${bannerList}" var="ad">
                                        <div class="car_fistpage_right_img_1">
                                            <a title="${ad.scrTitle}"  class="link" href="<c:choose>
                                                   <c:when test="${ad.dealerId>0}"><%=localUrlPath%>/dd-${ad.dealerId}/${ad.dlrName}.html</c:when>
                                                   <c:when test="${ad.url!=null&&fn:length(ad.url)>0}">http://${ad.url}</c:when>
                                                   <c:otherwise>#</c:otherwise></c:choose>" target="_blank">
                                                <img src="<%=localUrlPath%>/resourceGetter?imf=${ad.img1}" style="height:100px;width:289px"  border="0" alt="${ad.scrTitle}"/></a>
                                        </div></c:forEach></c:when>
                                <c:otherwise><img src="<%=localUrlPath%>/bbsimages/banner123.gif" style="width:100%;height:100px;padding-top:3px;" alt="Sample Head"/></c:otherwise></c:choose>
                            </div>
                        </div>
                        <div class="car_fistpage_main_right_mt_cont_707_inner">
                            <div class="car_fistpage_search_full_bg_img">
                                <form id="basicSearch" name="basicSearch" method="post" action="basicSearch.do">
                                    <a href="javascript:void(0);" onclick="return searchSubmit();"><div class="search_txt_inner_page"></div></a>
                                    <div class="car_fistpage_search_box">
                                        <form id="basicSearch" name="basicSearch" method="post" action="basicSearch.do">
                                            <div class="searh_part_white_space">
                                                <div class="search_box_innerpage">
                                                <% String keyword = (String) request.getAttribute("keyword");%>
                                                <input name="keyword" type="text" class="search_box_input_innerpage" onfocus="if(this.value == 'What you are looking...? ') this.value = ''" onblur="if(this.value == '') this.value = 'What you are looking...? '" <%if (keyword != null && keyword.trim().length()>0) {%> value="<%= keyword %>"<% } else {%> value="What you are looking...? " <% }%> />
                                            </div>
                                            <div class="catery_input_innerpage">
                                                <select  name="subCatId" id="subCatId" style="width:200px;"> <option  selected value="0"  > Select Category </option>
                                                    <c:if test="${categoryList != null}" >
                                                        <c:forEach items="${categoryList}" var="category"><c:if test="${category.parent == 0}"><optgroup style="font-weight:bold;font-style:normal;color:#1ea1b9; background-color:#FFFFFF;padding-left:10px" label="${category.name}"><c:if test="${category.subCategories != null}"><c:forEach items="${category.subCategories}" var ="cat"><option style="padding-left:10px;color:black;" value="${cat.id}" ><c:out value="${cat.name}" escapeXml="false"/></option></c:forEach></c:if></optgroup></c:if></c:forEach>
                                                    </c:if>
                                                </select>
                                            </div>
                                            <div class="offered_input_innerpage">
                                                <select id="adType" name="adType" style="width:115px;"> <option value="offered">Offered</option><option value="wanted">Wanted</option>  </select>
                                                <input type="hidden" name="start" value="0"/> <input type="hidden" name="range" value="20"/> <input type="hidden" name="byO" value="1"/>  <input type="hidden" name="m" value="<c:out value="${m}" />"/>
                                            </div>
                                        </div>
                                        <div id="bSearchBtn" class="blue_arrow_innerpage"><a href="javascript:void(0);" onclick="return searchSubmit();"></a></div>
                                    </form>
                                    <c:if test="${reqURI!='moreDetailsEmail.do'}">
                                        <% if(scid>0) { %>
                                        <jsp:include page="/WEB-INF/jsp/advancedSearch.jsp"/>
                                        <% }    %>
                                    </c:if>
                                    <!--advance search start-->
                                </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- this is used to display the left menu as per prev menu-->
    <c:if test="${cityObj != null && cityObj.name != 'All India'}" > </c:if>
    <c:if test="${subCatId != null && subCatId != '0' }"> </c:if>
</div>
<script type="text/javascript">
    function setInWdths() {
        var rt=document.getElementById("rfnTbls");
        var rtt = rt.getElementsByTagName("table");
        for(var i=0;i<(rtt.length-1);i++) {
            var rttin = rtt[i].getElementsByTagName("input");
            for(var j=0;j<rttin.length;j++) {
                rttin[j].style.width="100px";
            }
        }
    }
    setInWdths();
    function setDropDownValue(selId, vl) {
        $("#"+selId+" option").filter(function() {
            return $(this).val() == vl;
        }).attr('selected', true);
    }
    /*if(document.location.href.indexOf("/bs/")>-1||document.location.href.indexOf("latestAds.do")>-1) {
        document.getElementById("RefineSearch").style.display="none";
    } else {
        document.getElementById("bSearchGo").style.display="none";
        document.basicSearch.setAttribute("action","sRefine.do");
    }*/
    <% if(request.getAttribute("subCatId") != null) { %>
        setDropDownValue('subCatId','<%=request.getAttribute("subCatId")%>');
    <% } else if(request.getParameter("subCatId")!=null) { %>
        setDropDownValue('subCatId','<%=request.getParameter("subCatId")%>');
    <%} if(request.getAttribute("adType") != null) { %>
        setDropDownValue('adType','<%=request.getAttribute("adType")%>');
    <% } %>
        if(document.getElementById('subCatId').value>0) {
    <%--document.getElementById('subCatId').disabled = true;--%>
        }
</script>
<script type="text/javascript">
    var slider2=new accordion_as.slider("slider2");
    slider2.init("slider2",-1,"open");
    <c:if test="${reqURI=='sRefine.do'}">
        slider2.pro(document.getElementById("slider2").getElementsByTagName('dt')[0]);
    </c:if>
</script>
</c:if>
<!------------------------------------------ Header Part For Remaining Pages End Here ------------------------------------------------->