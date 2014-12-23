<%--
    Document   : fullLayout
    Created on : Jun 7, 2011, 12:52:28 PM
    Author     : bbsadmin
--%>

<%@taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.buysell.beans.UserBean" %>
<%@page import="com.buysell.util.URlUtil" %>
<%@page import="java.util.*" %>
<%@page import="java.util.regex.Matcher" %>
<%@page import="java.util.regex.Pattern" %>
<%@page import="com.buysell.beans.RecentSearch" %>
<%@page import="com.buysell.util.CategoryUtil" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<c:set var="mdAdTitle">${moreDetails.title}</c:set>
<% String mdAdTitle = (String) pageContext.getAttribute("mdAdTitle");
            String regex = "[^a-zA-z0-9 ,-]";
            Pattern p = Pattern.compile(regex);
            Matcher m = p.matcher(mdAdTitle);
            mdAdTitle = m.replaceAll("");
            String[] stopwords = {"a", "am", "an", "and", "are", "as", "at", "be", "by", "com", "de", "en", "for", "from", "how", "in", "is", "it", "la", "of", "on", "or", "that", "the", "this", "to", "was", "what", "when", "where", "who", "will", "with", "www", "we", "you", "your", "me", "mine", "my", "i"};
            for (int i = 0; i < stopwords.length; i++) {
                if (mdAdTitle.matches("(.*) (?i)(" + stopwords[i] + ") (.*)")) {
                    mdAdTitle = mdAdTitle.replaceAll("(.*) (?i)(" + stopwords[i] + ") (.*)", "$1 $3");
                }
            }
%>
<html>
    <head>
        <c:choose>
        <c:when test="${moreDetails.status != 1 && userBean.loginName !=moreDetails.email}">
        <title>Bharatbuysell - Free Classifieds India</title>
        <meta name="description" content="Bharatbuysell"/>
        <meta name="keywords" content="bharatbuysell.com, free india classified ads"/>
        </c:when>
        <c:otherwise>
        <title><c:if test="${moreDetails!=null}"><%=mdAdTitle%> | </c:if>Bharatbuysell</title>
        <meta name="description" content="<c:if test="${moreDetails!=null}">${fn:substring(moreDetails.description,0,150)} - ${moreDetails.city} - </c:if> Bharatbuysell"/>
        <meta name="keywords" content="bharatbuysell.com, free india classified ads <c:if test="${moreDetails!=null}">, ${moreDetails.title} - ${moreDetails.city}</c:if>"/>
        </c:otherwise>
        </c:choose>
        <link href="/Buysell/css/stylesheet.css" rel="stylesheet" type="text/css" />
        <link rel="shortcut Icon" href="/Buysell/bbsimages/favicon.ico"  />
        <script type="text/javascript" src="/Buysell/js/jquery.js"></script>
        <script type="text/javascript" src="/Buysell/js/curvycorners.js"></script>
    </head>
    <body>

        <div id="wrapper" style="float:left;" >
            <div id="masterheader">
                <script type="text/javascript" src="/Buysell/js/alljs.js"></script>
                <script type="text/javascript" src="/Buysell/js/tooltip.js"></script>
                <script type="text/javascript" src="/Buysell/js/allAjax.js" ></script>
                <script type="text/javascript">
                    function selectCity(itemID)
                    {
                        var dropdownIndex = document.getElementById(itemID).selectedIndex;
                        var dropdownValue = document.getElementById(itemID)[dropdownIndex].value;
                        document.location.href=dropdownValue;
                    }
                    var FeedBack='yes';
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
                %>
                <c:set var="cc"><%= (String) request.getSession().getAttribute("city")%></c:set>
                <% String rId = request.getParameter("rId");
    if (rId != null && rId.length() > 10) {
        request.getSession().setAttribute("rId", rId);
    }
                %>
                <style type="text/css">
                    <!--
                    /* This divs to display the error messages*/
                    #msg {display:none; position:absolute; z-index:200; background:url(images/msg_arrow.gif) left center no-repeat; padding-left:7px}
                    #msgcontent {display:block;color:#f00;font-size:12px;padding:5px; min-width:150px; max-width:250px}
                    -->
                </style>
                <script type="text/javascript" src="/Buysell/highslide/highslide-with-html.js"></script>
                <link rel="stylesheet" type="text/css" href="/Buysell/highslide/highslide.css" />
                <script type="text/javascript">
                    hs.graphicsDir = '/Buysell/highslide/graphics/';
                    hs.outlineType = 'rounded-white';
                    hs.wrapperClassName = 'draggable-header';
                </script>
                <script type="text/javascript">
                    var currentSysMS=<%=System.currentTimeMillis()%>;
                </script>
                <div id="headerlogo"><a title="Logo" href="http://bharatbuysell.com"> <img alt="bharatbuysellLogo" src="/Buysell/bbsimages/logo.png"  style="height:84px;width:226px;border:none" /></a></div>
                <div id="submainheader">      <!-- Submain  headerdiv  start -->
                    <div id="subheadertop">

                        <div style="width:50%;float:left;">
                            <img src="/Buysell/bbsimages/hdr_flash1.jpg" style="width:100%;height:97px;padding-top:5px" alt="Sample Head"/>
                        </div>
                        <div style="width:50%;float:left;">
                            <br/>
                            <span style="padding-right:2%"><a href="http://blog.bharatbuysell.com/" style="color:#D55D0C">Blog</a></span>
                            <span style="padding-right:2%"><a href="http://blog.bharatbuysell.com/category/news/" style="color:#D55D0C">News</a></span>
                            <span style="padding-right:2%"><a href="http://blog.bharatbuysell.com/category/technology/" style="color:#D55D0C">Technology</a></span>
                            <span style="padding-right:20%;*padding-right:5%"><a href="http://blog.bharatbuysell.com/category/food/" style="color:#D55D0C">Food</a></span>
                            <br/><br/>
                            <span style="padding-right:3%"><a href="http://blog.bharatbuysell.com/category/movies/" style="color:#D55D0C">Movies</a></span>
                            <span style="padding-right:25%;*padding-right:10%"><a href="http://blog.bharatbuysell.com/category/sports/" style="color:#D55D0C">Sports</a></span>
                        </div>
                    </div>
                </div><div style="clear:both"></div>
                <div id="subheaderdown" style="width:100%;background:url(/Buysell/bbsimages/hdr_m.gif);height:25px;display:block;color:white">
                    <div ><a title="Home" <c:if test="${sessionScope.button == 'home'}" >class="selected"</c:if> id="home" href="/Buysell/" >Home</a></div>
                    <span style="float:left">|</span>
                    <div >
                        <a title="Post Ad" id="postAd"  <c:if test="${sessionScope.button == 'postAd'}" >class="selected"</c:if> href="/Buysell/postAd.do">Post Ad</a>
                    </div>
                    <span style="float:left">|</span>
                    <div>
                        <a title="Register" id="register" <c:if test="${sessionScope.button == 'register'}" >class="selected"</c:if> href="/Buysell/register.do">Register</a>
                    </div>
                    <span style="float:left">|</span>
                    <logic:present name="userBean">
                        <div>
                            <a title="My Account" id="myAccount" <c:if test="${sessionScope.button == 'myAccount'}" >class="selected"</c:if> href="/Buysell/my_ads_details.do">My Account</a></div>
                        <span style="float:left">|</span>
                    </logic:present>
                    <logic:notPresent name="userBean">
                        <div><a title="My Account" id="myAccount" href="/Buysell/myAccountNL.do">My Account</a></div>
                        <span style="float:left">|</span>
                    </logic:notPresent>
                    <%--<div>
                        <a title="Best Dealers" id="bestDealers" <c:if test="${sessionScope.button == 'bestDealers'}" >class="selected"</c:if> href="#" onmouseover="Tip('Its shows the best delears available in the city', PADDING, 9, BGCOLOR, '#a4d7ff', BORDERCOLOR, '#0d61a4', CLICKCLOSE, true, WIDTH, -1, TITLE, 'This feature will come soon', TITLEBGCOLOR, '#0d61a4', FADEIN, 500, FADEOUT, 500, OPACITY, 90)" onmouseout="UnTip()">Best Dealers</a></div>--%>
                    <div>
                        <a title="Latest Ads" id="latestAds" <c:if test="${sessionScope.button == 'latestAds'}" >class="selected"</c:if> href="/Buysell/latestAds.do">Latest Ads</a></div>
                    <%--<span style="float:left">|</span>--%>
                    <%--<div>
                        <a title="Current Offers" id="currentOffers" <c:if test="${sessionScope.button == 'currentOffers'}" >class="selected"</c:if> href="/Buysell/currentOffers.do">Current Offers</a></div>--%>
                    <%--<div>
                        <a title="Auctions" id="auctions" <c:if test="${sessionScope.button == 'auctions'}" >class="selected"</c:if> href="/Buysell/auctions.do">Auctions</a></div>--%>
                </div>
                <div style="width:100%">
                    <div style="width:66.5%;height:26px;float:left;padding:5px 0% 2px 1%;background:url(/Buysell/bbsimages/hdr_o.gif);color:white;font-size:11px;font-weight:bold">
                        <span>
                            &nbsp;You are in&nbsp;<img alt="India" title="www.bharatbuysell.com" src="/Buysell/bbsimages/india.gif" style="vertical-align:middle;height:15px;width:20px;border:1px solid #FFFFFF" />
                        </span>
                        <span>
                            <select  class="verdana_textfeelds" style="width:auto;" name="citySelect" id="topcitylist" onchange="javascript:selectCity('topcitylist')" >
                                <option value="/Buysell/ccs?url=tile1.do&amp;city=All India" > All India</option>
                                <c:if test="${cities!=null }" >
                                    <c:forEach items="${cities}" var="city"><option value='/Buysell/ccs?url=tile1.do&amp;city=${city.name}' <c:if test='${city.name==cc}'>SELECTED</c:if>><c:out value='${city.name}' /></option></c:forEach>
                                </c:if>
                            </select>&nbsp; &nbsp;
                        </span>
                        <span id="servTime"></span>
                    </div>
                    <img src="/Buysell/bbsimages/hdr_os.gif" alt="os" style="float:left;width:2.5%;height:33px;"/>
                    <div style="width:29%;float:left;padding:2px 0% 5px 1%;height:26px;background:url(/Buysell/bbsimages/hdr_so.gif)" >
                        <div style="float:right;padding:5px 10px;width:10%;font-size:11px;">
                            <logic:notPresent name="userBean">
                                <a title="Login" id="login" <c:if test="${sessionScope.button == 'login'}" >class="selected"</c:if> href="/Buysell/myAccountNL.do"><span id="dr" style="height:19px;cursor:hand;color:#D55D0C;">Login</span></a>
                        </logic:notPresent>

                        <logic:present name="userBean">
                            <a title="Logout" id="login" href="/Buysell/logout.do" onclick="document.getElementById('dr').innerHTML='Login'" style="color:#D55D0C;">Logout</a>
                        </logic:present>
                    </div>
                    <div style="float:right">
                        <span style="font-size:11px;color:#D55D0C">&nbsp;&nbsp; Welcome,</span>&nbsp;<span class="verdana_welcome_1" style="color:#D55D0C">
                            <logic:present name="userBean">
                                <% UserBean ub = (UserBean) request.getSession().getAttribute("userBean");
                                if (ub.getFirstName() != null && ub.getLastName() != null && !ub.getLastName().equalsIgnoreCase("null") && !ub.getFirstName().equalsIgnoreCase("null")) {
                                %>
                                <%= ub.getFirstName()%>&nbsp;<%= ub.getLastName()%>
                                <%   } else if (ub.getFirstName() != null && !ub.getFirstName().equalsIgnoreCase("null")) {%>
                                <%= ub.getFirstName()%>
                                <%    } else if (ub.getLastName() != null && !ub.getLastName().equalsIgnoreCase("null")) {%>
                                <%= ub.getFirstName()%>
                                <%  } else {%> Guest  <% }%>
                            </logic:present>
                            <logic:notPresent name="userBean">
                                <span id="guest" style=""> Guest </span><span id="guest1" style=""></span>
                            </logic:notPresent>
                            <span>&nbsp;|&nbsp;</span>
                        </span>
                    </div>
                </div>
            </div>
            <script type="text/javascript">
                var ctDiff=0;
                function clockTick()
                {
                    var currentTime = new Date();
                    if(ctDiff==0) ctDiff=currentTime.getTime();
                    currentSysMS=currentSysMS+(currentTime.getTime()-ctDiff);
                    ctDiff=currentTime.getTime();
                    currentTime = new Date(currentSysMS);
                    currentTime.setTime(currentTime.getTime() +(currentTime.getTimezoneOffset()+330)*60*1000);
                    document.getElementById("servTime").innerHTML="";
                    document.getElementById("servTime").innerHTML=currentTime.toString().substr(4, 6)+","+currentTime.getFullYear()+' '+currentTime.toLocaleTimeString();
                    setTimeout("clockTick()", 1000);
                }
                clockTick();
            </script>
    </div>

    <div id="body_container2" style="clear:both;">
        <div style="*height:58px;clear:both"></div>
        <div id="body_container1" >

            <div id="masterrightbodybg" style="float:left;width:100%;" >
                <div style="width:75%;float:right">
                    <div style="margin:5px 0 0 0;clear:both"></div>

                    <c:if test="${recentSearches != null }" >
                        <div id="recentS"   style="width:100%;float:left;height:12px;padding:0 0 5px 5px;">
                            <div id="recent1" class="fv10c" style="width:688px;float:left;height:12px;overflow:hidden;">
                                Recent Searches :&nbsp;
                                <%
    LinkedHashMap<String, String> recentSearches = (LinkedHashMap<String, String>) request.getSession().getAttribute("recentSearches");
    if (recentSearches != null) {
        ArrayList<String> al = null;
        al = new ArrayList<String>();
        Set<String> set = recentSearches.keySet();
        for (String keyS : set) {
            al.add(0, keyS);
        }
        for (String key : al) {
                                %>

                                <a title="" class="link11" href="/Buysell/<%= recentSearches.get(key)%>&city=<%=request.getSession().getAttribute("city")%>" ><span class="fv10c"><%= key%></span></a><span>,&nbsp;</span>
                                <% }
            }%>
                            </div>

                            <div id="recent2" class="fv10c" style="float:right;width:50px;text-align:center;"> <a title="Clear" class="link11" href="javascript:return false;" onclick="RecentSearch();event.returnValue=false;return false;"><span class="fv10c">Clear</span></a> </div>
                        </div>
                    </c:if>
                </div>
                <div style="width:75%;float:right">
                    <div style="margin:5px 0 0 0;clear:both">

                    </div>
                    <jsp:include page="/WEB-INF/jsp/clock.jsp" />
                </div>
                <div style="clear:both"></div>
                <div style="margin:0% 4%;">
                    <c:if test="${moreDetails!=null}">
                        <div style="margin:2% 1%;font-size:12px;">
                            <c:set var="adCatId" value="${moreDetails.catId}"/>
                            <%
        CategoryUtil cu = new CategoryUtil();
        int cid = Integer.parseInt(pageContext.getAttribute("adCatId").toString());
        int pcid = cu.getRootCatId(cid);
                            %>
                            <c:set var="scnm"><%=cu.getCategoryNameWithId(pcid)%></c:set>
                            <c:set var="clfnm"><%=cu.getCategoryNameWithId(cid)%></c:set>
                                Category:
                                <a href="/Buysell/">Home</a> >
                                <a href="/Buysell/<c:if test="${city!=null && city!='All India'}">${fn:toLowerCase(city)}-</c:if>${fn:toLowerCase(fn:replace(fn:replace(fn:trim(scnm),'/','-'),' ','-'))}-sc<%=pcid%>.in">${scnm}</a> >
                        <a href="/Buysell/<c:if test="${city!=null && city!='All India'}">${fn:toLowerCase(city)}-</c:if>${fn:toLowerCase(fn:replace(fn:replace(fn:trim(scnm),"/","-")," ","-"))}-${fn:toLowerCase(fn:replace(fn:replace(fn:trim(clfnm),"/","")," ","-"))}-cl<%=cid%>cs<%=pcid%>.in">${clfnm}</a>
                        </div>
                    <jsp:include page="/WEB-INF/jsp/moreDetails.jsp" />
                    <br/>
                    <iframe src="/Buysell/relatedClfAds.do?clfId=${moreDetails.catId}&adId=${moreDetails.adId}&subCatId=<%=pcid%>&range=5" width="100%" height="300" style="border:none" frameborder="0"></iframe>
                    </c:if>
                    </div>
                    </div>
                    </div>
                    </div>
                    <div id="masterfooter">
                        <link href="/Buysell/css/cute_profiles32.css" type="text/css" rel="stylesheet">
                        <div style="width:100%">
                            <div id="footerPage">


                                <span class="verdana_footer" ><a title="About Us" href="/Buysell/aboutUs.do">About Us</a></span>
                                <span class="verdana_footer_1"> | </span>


                                <span class="verdana_footer"> <a title="Contact us" href="/Buysell/contactUs.do">Contact Us</a></span>
                                <span class="verdana_footer_1"> | </span>


                                <span class="verdana_footer"><a title="Feedback" href="/Buysell/contactUs.do">Feedback</a></span>
                                <span class="verdana_footer_1"> | </span>

                                <span class="verdana_footer"><a title="Sitemap" href="/Buysell/siteMap.do">Site Map</a></span>
                                <span class="verdana_footer_1"> | </span>

                                <span class="verdana_footer"><a title="Help" href="/Buysell/help.do">Help</a></span>
                                <span class="verdana_footer_1"> | </span>


                                <%----%>
                                <span class="verdana_footer">&nbsp;&nbsp;</span>


                            </div>
                            <img src="/Buysell/bbsimages/hdr_bs.gif" alt="os" style="float:left;width:5.5%;height:35px;"/>
                            <div style="width:38.5%;float:left;padding:9px 0% 0px 1%;height:26px;background:url(/Buysell/bbsimages/hdr_sb.gif)" >
                                <form id="basicSearchF" name="basicSearchF" method="post" action="/basicSearch.do">
                                    <div style="width:33%;float:left">
                                        <% String keyword = (String) request.getAttribute("keyword");
            if (keyword != null) {%>
                                        <input type="text" class="" style="width:80%;vertical-align:bottom" value="<%= keyword%>"  name="keyword"  onfocus="if(this.value=='Keyword') this.value='';" onblur="if(this.value=='') this.value='Keyword';"  />
                                        <% } else {%>
                                        <input type="text" class=""  name="keyword" style="width:80%;vertical-align:bottom" value="Keyword"  onfocus="if(this.value=='Keyword') this.value='';" onblur="if(this.value=='') this.value='Keyword';" />
                                        <% }%>
                                    </div>
                                    <div style="width:33%;float:left;">
                                        <select  name="subCatId" id="subCatIdF" style="width:80%;vertical-align:bottom">
                                            <option  selected value="0"  > Select Category </option>
                                            <c:if test="${categoryList != null}" >
                                                <c:forEach items="${categoryList}" var="category">
                                                    <c:if test="${category.parent == 0}"><optgroup style="background:#dddddd;font-style:normal;font-weight:normal" label="${category.name}">
                                                            <c:if test="${category.subCategories != null}">
                                                                <c:forEach items="${category.subCategories}" var ="cat"><option style="background:#ffffff" value="${cat.id}" ><c:out value="${cat.name}" escapeXml="false"/></option></c:forEach>
                                                            </c:if>
                                                        </optgroup>
                                                    </c:if>
                                                </c:forEach>
                                            </c:if>
                                        </select>
                                    </div>
                                    <div style="width:33%;float:left;">
                                        <select id="adTypeF" name="adType" style="width:60%;vertical-align:bottom;float:left">
                                            <option value="offered">Offered</option><option value="wanted">Wanted</option>
                                        </select>
                                        <input type="hidden" name="start" value="0"/>
                                        <input type="hidden" name="range" value="20"/>
                                        <input type="hidden" name="byO" value="1"/>
                                        <input type="hidden" name="m" value="<c:out value="${m}" />"/>
                                           <span style="float:left">&nbsp;
                                        <a href="javascript:void(0);" onclick="return searchSubmitF();" style="color:#D55D0C;text-decoration:underline" >Go!</a>
                                    </span>
                                </div>
                            </form>
                        </div>
                    </div>
                    <div style="clear:both"></div>
                    <div style="background:#FF6600;line-height:33px;padding-left:10px">
                        <div style="float:right">
                            <span class="verdana_footer_1"><a title="Terms of Service &amp; Use" href="javascript:return false;" onclick="termsAndConditions('/Buysell/tc.do','Terms and Conditions');event.returnValue=false;return false;" style="color:white">Terms of Service &amp; Use</a></span>
                            <span class="verdana_footer_1"> | </span>

                            <span class="verdana_footer_1"><a title="Privacy Statement" href="javascript:return false;" onclick="termsAndConditions('/Buysell/ps.do','Privacy Statement');event.returnValue=false;return false;" style="color:white">Privacy Statement</a></span>
                            <span class="verdana_footer_1"> | </span>

                            <span class="verdana_footer_1"><a title="Business Links" href="/Buysell/getLinks.do" style="color:white">Business Links</a></span>
                        </div>
                        <div>
                            <span class="verdana_footer_1">© 2009 Bharatbuysell.com</span>
                            <span class="verdana_footer_1" >Powered by <a href="http://focus9.in" style="text-decoration:none;font-size:12px;font-weight:bold;color:#FFF" target="_blank">Focus9.in</a></span>
                        </div>
                    </div>
                    <script type="text/javaScript">
                        <% if (request.getAttribute("subCatId") != null) {%> document.getElementById('subCatIdF').value='<%=request.getAttribute("subCatId")%>';
                        <% }%>
                        <% if (request.getAttribute("adType") != null) {%> document.getElementById('adTypeF').value='<%= (String) request.getAttribute("adType")%>';
                        <% }%>
                            function searchSubmitF()
                            {
                                document.basicSearchF.submit();
                                return true;
                            }
                    </script>

                    <div class="cute_profiles_sprite">
                        <a rel="nofollow" target="_blank" href="http://twitter.com/bharatbuysell" class="cute_profiles_twitter" title="Twitter"/>
                        <a rel="nofollow" target="_blank" href="http://www.facebook.com/pages/Bharatbuysell/207110219300418" class="cute_profiles_facebook" title="Facebook"/>
                        <%--	<a rel="nofollow" target="_blank" href="http://www.stumbleupon.com/stumbler/bharatbuysell/" class="cute_profiles_stumble" title="Stumbleupon"/>
	<a rel="nofollow" target="_blank" href="http://www.mixx.com/users/bharatbuysell" class="cute_profiles_mixx" title="Mixx"/>
	<a rel="nofollow" target="_blank" href="https://profiles.google.com/bharatbuysell.com/about" class="cute_profiles_google" title="Google"/>
	<a rel="nofollow" target="_blank" href="http://www.reddit.com/user/bharatbuysell" class="cute_profiles_reddit" title="Reddit"/>
	<a rel="nofollow" target="_blank" href="http://digg.com/bharatbuysell" class="cute_profiles_digg" title="Digg"/>
                        --%>	<a rel="nofollow" target="_blank" href="http://www.youtube.com/user/bharatbuysell" class="cute_profiles_youtube" title="Youtube"/>
                        <%--<a rel="nofollow" target="_blank" href="http://www.linkedin.com/in/bharatbuysell" class="cute_profiles_linkedin" title="Linkedin"/>
                        <a rel="nofollow" target="_blank" href="http://www.myspace.com/bharatbuysell" class="cute_profiles_myspace" title="Myspace"></a>
                        --%>
                    </div><div style="clear:both"></div>

                </div>

                </div>
                <script type="text/javascript">
                    var gaJsHost = (("https:" == document.location.protocol) ? "https://ssl." : "http://www.");
                    document.write(unescape("%3Cscript src='" + gaJsHost + "google-analytics.com/ga.js' type='text/javascript'%3E%3C/script%3E"));
                </script>
                <script type="text/javascript">
                    try {
                        var pageTracker = _gat._getTracker("UA-12685965-1");
                        pageTracker._trackPageview();
                    } catch(err) {}</script>
                <!-- Start of StatCounter Code -->
                <script type="text/javascript">
                    var sc_project=5729613;
                    var sc_invisible=1;
                    var sc_security="777e698d";
                </script>

                <script type="text/javascript"
                src="http://www.statcounter.com/counter/counter.js"></script><noscript><div
                        class="statcounter"><a title="web statistics"
                                           href="http://www.statcounter.com/" target="_blank"><img
                                class="statcounter"
                                src="http://c.statcounter.com/5729613/0/777e698d/1/"
                                alt="web statistics" /></a></div></noscript>

                </body>
                </html>
