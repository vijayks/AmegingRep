
<%@taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%@page   contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.buysell.beans.UserBean" %>
<%@page import="com.buysell.util.URlUtil" %>
<%@page import="java.util.*" %>
<%@page import="com.buysell.beans.RecentSearch" %>


<html>
    <head>
        <link href="/css/stylesheet.css" rel="stylesheet" type="text/css" />
        <link rel="shortcut Icon" href="/bbsimages/favicon.ico"  />
        <script type="text/javascript" src="/js/jquery.js"></script>

    </head>
    <body>

     <div id="wrapper" style="float:left;padding:5px;" >
           <div id="masterheader">
                    <script type="text/javascript" src="/js/alljs.js"></script>
                    <script type="text/javascript" src="/js/tooltip.js"></script>
                    <script type="text/javascript" src="/js/allAjax.js" ></script>
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
                                for (int i = 0; i < cookies.length; i++) {
                                    if (cookies[i].getName().equals("presentCity")) {
                                        request.getSession().setAttribute("city", cookies[i].getValue());
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
                        <script type="text/javascript" src="/highslide/highslide-with-html.js"></script>
                        <link rel="stylesheet" type="text/css" href="/highslide/highslide.css" />
                        <script type="text/javascript">
                            hs.graphicsDir = 'highslide/graphics/';
                            hs.outlineType = 'rounded-white';
                            hs.wrapperClassName = 'draggable-header';
                        </script>
                        <div id="headerlogo"><a title="Logo" href="http://bharatbuysell.com"> <img alt="bharatbuysellLogo" src="/bbsimages/logo.gif"  style="height:85px;width:173px;border:none" /></a></div>
                        <div id="submainheader">      <!-- Submain  headerdiv  start -->
                            <div id="subheadertop">
                                <table cellspacing="0" cellpadding="0" border="0" align="right" style="margin-right:10px">
                                                        <tr>
                                                        <td align="right" valign="top">
                                                            <img src="/bbsimages/left-login.gif" style="border:none;" alt="\_" height="19" width="19"/></td>
                                                        <td class="login-bar" align="right" valign="top" style="padding-top:2px;">
                                                            You are in</td>
                                                        <td class="login-bar" style="padding-left: 5px; padding-right: 1px; padding-top: 1px;" valign="top">
                                                            <img alt="India" title="www.bharatbuysell.com" src="/bbsimages/india.gif" style="vertical-align:middle;height:15px;width:20px" /></td>
                                                        <td class="login-bar" style="padding:0px 5px;" valign="top">
                                <select  class="verdana_textfeelds" style="width:auto;" name="citySelect" id="topcitylist" onchange="javascript:selectCity('topcitylist')" >
                                    <option value="ccs?url=<%=request.getSession().getAttribute("surl")%>&amp;city=All India<%= qryString%>" > All India</option>
                                    <c:if test="${cities!=null }" >
                                        <c:forEach items="${cities}" var="city"><option value='ccs?url=<%=request.getSession().getAttribute("surl")%>&amp;city=${city.name}<%= qryString%>' <c:if test='${city.name==cc}'>SELECTED</c:if>><c:out value='${city.name}' /></option></c:forEach>
                                    </c:if>
                                </select> &nbsp; &nbsp;
                                                        </td>
                                                        <td class="login-bar">
                                                        <logic:notPresent name="userBean">
                                                            <a title="Login" id="login" <c:if test="${sessionScope.button == 'login'}" >class="selected"</c:if> href="/myAccountNL.do"><span id="dr" style="height:19px;display:block;text-decoration:underline;cursor:hand">Login</span></a>
                                                        </logic:notPresent>

                                                        <logic:present name="userBean">
                                                            <a title="Logout" id="login" href="/logout.do" onclick="document.getElementById('dr').innerHTML='Login'">Logout</a>
                                                        </logic:present>
                                                        </td>
                                                        <td class="login-bar">
                                                            <a title="Register" href="/register.do"><span style="margin-left:20px;height:19px;display:block;text-decoration:underline;cursor:hand">Register</span></a>
                                                        </td>
                                                        <td align="right" valign="top">
                                                            <img src="/bbsimages/right-login.gif" style="border:none" alt="_/" height="19" width="19"/></td>
                                                    </tr>
                                                </table>
                            </div>
                            <div id="subheaderdown">
                                <div ><a title="Home" <c:if test="${sessionScope.button == 'home'}" >class="selected"</c:if> id="home" href="/tile1.do?start=0&amp;range=10&amp;byO=1" >Home</a></div>
                                <div >
                                    <a title="Post Ad" id="postAd"  <c:if test="${sessionScope.button == 'postAd'}" >class="selected"</c:if> href="/postAd.do">Post Ad</a>
                                </div>
                                <div>
                                    <a title="Register" id="register" <c:if test="${sessionScope.button == 'register'}" >class="selected"</c:if> href="/register.do">Register</a>
                                </div>
                                <logic:present name="userBean">
                                    <div>
                                        <a title="My Account" id="myAccount" <c:if test="${sessionScope.button == 'myAccount'}" >class="selected"</c:if> href="/my_ads_details.do">My Account</a></div>
                                    </logic:present>
                                    <logic:notPresent name="userBean">
                                        <div><a title="My Account" id="myAccount" href="/myAccountNL.do">My Account</a></div>
                                </logic:notPresent>
                                <div>
                                    <a title="Best Dealers" id="bestDealers" <c:if test="${sessionScope.button == 'bestDealers'}" >class="selected"</c:if> href="/bestDealers.do" onmouseover="Tip('Its shows the best delears available in the city', PADDING, 9, BGCOLOR, '#a4d7ff', BORDERCOLOR, '#0d61a4', CLICKCLOSE, true, WIDTH, -1, TITLE, 'This feature will come soon', TITLEBGCOLOR, '#0d61a4', FADEIN, 500, FADEOUT, 500, OPACITY, 90)" onmouseout="UnTip()">Best Dealers</a></div>
                                <div>
                                    <a title="Latest Ads" id="latestAds" <c:if test="${sessionScope.button == 'latestAds'}" >class="selected"</c:if> href="/latestAds.do?start=0&amp;range=20&amp;byO=1">Latest Ads</a></div>
                                <div>
                                    <a title="Current Offers" id="currentOffers" <c:if test="${sessionScope.button == 'currentOffers'}" >class="selected"</c:if> href="/currentOffers.do">Current Offers</a></div>
                                <div>
                                    <a title="Auctions" id="auctions" <c:if test="${sessionScope.button == 'auctions'}" >class="selected"</c:if> href="/auctions.do">Auctions</a></div>
                            </div>
                        </div>
                </div>
           <div id="welcomebody" style="clear:left;height:30px" >
                    <script type="text/javascript">
                        function searchSubmit()
                        {
                          document.basicSearch.submit();
                          return true;
                        }
                    </script>
                    <div style="width:275px;height:25px;float:left;padding:2px 0 2px 0;background-color:#ffffff">
                        <span class="verdana_welcome">&nbsp;&nbsp; Welcome,</span>&nbsp;<span class="verdana_welcome_1">
                            <logic:present name="userBean">
                                <% UserBean ub = (UserBean) request.getSession().getAttribute("userBean");
                                if (ub.getFirstName() != null && ub.getLastName() != null && !ub.getLastName().equalsIgnoreCase("null")  && !ub.getFirstName().equalsIgnoreCase("null")) {
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
                        </span>
                    </div>
                    <c:if test="${sessionScope.button != 'auctions'}" >
                    <div style="width:725px;float:left;padding:5px 0 2px 0;height:22px;background-color:#ffffff" >
                        <form id="basicSearch" name="basicSearch" method="post" action="basicSearch.do">
                            <div style="width:225px;float:left">
                                <% String keyword = (String) request.getAttribute("keyword");
                                if (keyword != null) {%>
                                <input type="text" class="" style="width:200px;vertical-align:bottom" value="<%= keyword %>"  name="keyword"  onfocus="if(this.value=='Keyword') this.value='';" onblur="if(this.value=='') this.value='Keyword';"  />
                                <% } else {%>
                                <input type="text" class=""  name="keyword" style="width:200px;vertical-align:bottom" value="Keyword"  onfocus="if(this.value=='Keyword') this.value='';" onblur="if(this.value=='') this.value='Keyword';" />
                                <% }%>
                            </div>
                            <div style="width:225px;float:left;">
                                <select  name="subCatId" id="subCatId" style="width:200px;vertical-align:bottom">
                                    <option value="0"  selected="selected"> Select Category </option>
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
                            <div style="width:275px;float:left;">
                                <select id="adType" name="adType" style="width:150px;vertical-align:bottom">
                                    <option value="offered">Offered</option><option value="wanted">Wanted</option>
                                </select>
                                <input type="hidden" name="start" value="0"/>
                                <input type="hidden" name="range" value="20"/>
                                <input type="hidden" name="byO" value="1"/>
                                <input type="hidden" name="m" value="<c:out value="${m}" />"/>
                                &nbsp;
                                <input  type="image" name="option" onclick="return searchSubmit();" src="/bbsimages/buttons/Search.png" onmouseover="this.src='/bbsimages/buttons/Search_MouseOver.png';" onmouseout="this.src='/bbsimages/buttons/Search.png';" style="height:18px;vertical-align:bottom"  />
                            </div>
                        </form>
                    </div>
                          <script type="text/javascript">
                        <% if(request.getAttribute("subCatId") != null) { %> document.getElementById('subCatId').value='<%=request.getAttribute("subCatId")%>';
                            <% } %>
                                 <% if(request.getAttribute("adType") != null) { %> document.getElementById('adType').value='<%= (String) request.getAttribute("adType")%>';
                            <% } %>
                    </script>
                  </c:if>
                </div>
           <div id="body_container2" style="clear:both;">
                <div id="body_container1" >
                    <div style="float:left;width:25%;">
                        <script type="text/javascript">
                        function toggle_s(itemID,img)
                        {
                            if((document.getElementById(itemID).style.display == 'none'))
                            {
                                document.getElementById(itemID).style.display = 'inline';
                                document.getElementById(img).src='/bbsimages/arrowd.jpg';
                            }
                            else
                            {
                                document.getElementById(itemID).style.display = 'none';
                                document.getElementById(img).src='/bbsimages/arrow.jpg';
                            }
                            return;
                        }
                        function sc(catid)
                        {
                            alert(catid);
                        }
                        function openCat(itemID)
                        {
                            document.getElementById(itemID).style.display = 'inline' ;
                            document.getElementById('more').style.display = 'none';
                            document.getElementById('hide').style.display = 'inline';
                        }
                        function hideCat(itemID)
                        {
                            document.getElementById(itemID).style.display = 'none' ;
                            document.getElementById('more').style.display = 'inline';
                            document.getElementById('hide').style.display = 'none';
                        }
                    </script>
                    <style type="text/css">
                        <!--
                        .li12
                        {
                            font-family:Arial;
                            font-size:12px;
                            list-style:none;
                        }
                        .li11
                        {
                            font-family:Arial;
                            font-size:11px;
                            font-weight:normal;
                            list-style:inside;
                            list-style-type:square;
                            color:#ffffff;
                            margin-left:50px;
                            line-height:20px
                        }
                        -->
                    </style>
                    <!-- left body background start and end -->
                    <!-- Master main body div start -->
                    <div id="masterleftbodybg">       <!-- left body background start and end -->
                        <div id="mastercontentbody">      <!-- Master content body div start   -->
                            <div id="leftcategorymenu">       <!-- Left menu div start  -->

                                <div class="t"><div class="b"><div class="l"><div class="r"><div class="bl"><div class="br"><div class="tl">
                                                            <div class="tr">
                                                                <div id="menuheader"  style="padding-top:2px;padding-bottom:5px;">&nbsp;
                                                                    <span class="verdana_menu_head" > Categories </span>
                                                                </div>
                                                                <div style="clear:both"></div>
                                                                <c:if test="${categoryList != null}" >
                                                                    <c:forEach items="${categoryList}" var="category" varStatus="loop">
                                                                        <c:if test="${loop.index < 10}">
                                                                            <c:if test="${category.parent == 0}">
                                                                                <div class="menu_div" style="">
                                                                                    <c:set var="s">sub<c:out value="${category.id}" /></c:set>
                                                                                    <c:set var="i">img<c:out value="${category.id}" /></c:set>
                                                                                    <ul style="list-style-type:none;margin:0;padding:0">
                                                                                    <li class="li12" style="">
                                                                                        <img id="${i}" src="/bbsimages/arrow.jpg" onclick="toggle_s('${s}','${i}')"  alt="L" style="width:30px;height:12px;"/>
                                                                                        <a title="${category.name}" href="#<c:if test="${category.name!=null}">&amp;category=${category.name}</c:if>" onclick="toggle_s('${s}','${i}');event.returnValue=false;return false;" style="color:#ffffff" >
                                                                                            <c:out value="${category.name}" escapeXml="false"/>
                                                                                        </a>
                                                                                    </li>
                                                                                    </ul>
                                                                                </div>
                                                                                <c:if test="${category.subCategories != null}">
                                                                                    <div id="${s}" style="display:none">
                                                                                        <ul style="list-style-type:none;margin:0;padding:0">
                                                                                        <c:forEach items="${category.subCategories}" var ="cat">
                                                                                            <c:set value="${cat.name}" var="caname" scope="request"/>
                                                                                            <c:set var="caid" scope="request">${cat.id}</c:set>
                                                                        <% String caturl="";
                                                                            String uCatId="";
                                                                            caturl=(String) request.getAttribute("caname");
                                                                            uCatId=(String)request.getAttribute("caid");
                                                                            if(caturl!=null)
                                                                                caturl=URlUtil.getUrlString(caturl,"",uCatId);
                                                                            else
                                                                                caturl=".htm";
                                                                            caturl=caturl.replaceAll("#", "");
                                                                             %>
                                                                                            <li class="li11"><a title="${cat.name}" href="/bc/<%=caturl%>" style="color:#ffffff"> <c:out value="${cat.name}" escapeXml="false" /></a></li>
                                                                                        </c:forEach>
                                                                                        </ul>
                                                                                    </div>
                                                                                </c:if>
                                                                            </c:if>
                                                                        </c:if>
                                                                    </c:forEach>
                                                                </c:if>
                                                                <div id="more" style="width:100%"><span class="verdana_menu"><a title="More Categories"  href="#" style="margin-left:140px" onclick="openCat('lmhide')">More >> </a></span>
                                                                </div>
                                                                <div id="lmhide" style="display:none">
                                                                    <c:if test="${categoryList != null}" >
                                                                        <c:forEach items="${categoryList}"  var="category" varStatus="loop2">
                                                                            <c:if test="${loop2.index >= 10}">
                                                                                <c:if test="${category.parent == 0}">
                                                                                    <div  class="menu_div" style="vertical-align:middle">
                                                                                        <c:set var="s">sub<c:out value="${category.id}" /></c:set>
                                                                                        <c:set var="i">img<c:out value="${category.id}" /></c:set>
                                                                                        <ul style="list-style-type:none;margin:0;padding:0">
                                                                                        <li class="li12" style="">
                                                                                            <img id="${i}" src="/bbsimages/arrow.jpg" alt="L" style="width:30px;height:12px;" onclick="toggle_s('${s}','${i}')"  />
                                                                                            <a title="${category.name}" href="javascript: return flase;<c:if test="${category.name!=null}">&amp;category=${category.name}</c:if>" onclick="toggle_s('${s}','${i}');event.returnValue=false;return false;" style="color:#ffffff" >
                                                                                                <c:out value="${category.name}" escapeXml="false"/>
                                                                                            </a>
                                                                                        </li>
                                                                                        </ul>
                                                                                    </div>
                                                                                    <c:if test="${category.subCategories != null}">
                                                                                        <div id="${s}" style="display:none">
                                                                                            <ul style="list-style-type:none;margin:0;padding:0">
                                                                                            <c:forEach items="${category.subCategories}" var ="cat">
                                                                                            <c:set value="${cat.name}" var="caname" scope="request"/>
                                                                                            <c:set var="caid" scope="request">${cat.id}</c:set>
                                                                        <% String caturl="";
                                                                            String uCatId="";
                                                                            caturl=(String) request.getAttribute("caname");
                                                                            uCatId=(String)request.getAttribute("caid");
                                                                            if(caturl!=null)
                                                                                caturl=URlUtil.getUrlString(caturl,"",uCatId);
                                                                            else
                                                                                caturl=".htm";
                                                                            caturl=caturl.replaceAll("#", "");
                                                                             %>

                                                                                                    <li class="li11">
                                                                                                            <a title="${cat.name}" href="/bc/<%=caturl%>" style="color:#ffffff"> <c:out value="${cat.name}" escapeXml="false" /></a>
                                                                                                    </li>
                                                                                            </c:forEach>
                                                                                            </ul>
                                                                                        </div>
                                                                                    </c:if>
                                                                                </c:if>
                                                                            </c:if>
                                                                        </c:forEach>
                                                                    </c:if>
                                                                    <br />
                                                                </div>
                                                                <div><span class="verdana_menu"> <a title="Hide" id="hide" href="#" style="margin-left:140px;display:none"  onclick="hideCat('lmhide')" > &lt;&lt; Hide </a></span>
                                                                </div>
                                                                <div id="menuend1" align="center" ><img src="/bbsimages/blank.gif" class="menuEnd" alt=""/></div>
                                                                <br />
                                                                <div id="menuheader" align="left" style="padding-top:2px;cursor:pointer" onclick="javascript:window.location.href='/auctions.do'">&nbsp;
                                                                    <span class="verdana_menu_head"  > &nbsp;Live Auctions </span>
                                                                </div> <br /><br />
                                                               <script type="text/javascript">
                                                                    //specify path to your external page:
                                                                    var iframesrc="bidScroll.do";
                                                                    //You may change most attributes of iframe tag below, such as width and height:
                                                                    document.write('<iframe style="background-color:#4D9EDF" id="datamain" src="'+iframesrc+'" width="220px" height="300px" marginwidth="0" marginheight="0" hspace="0" vspace="0" frameborder="0" scrolling="no"></iframe>')
                                                                </script>
                                                            </div>
                                                        </div></div></div></div></div></div></div>
                            </div>
                        </div><!-- Left menu div End -->
                    </div>

                    </div>

                    <div id="masterrightbodybg" style="float:left;width:74%;position:relative" >
                        <div>
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

                                        <a title="" class="link11" href="/<%= recentSearches.get(key)%>&city=<%=request.getSession().getAttribute("city")%>" ><span class="fv10c"><%= key%></span></a><span>,&nbsp;</span>
                                        <% }
                                    }%>
                                    </div>

                                    <div id="recent2" class="fv10c" style="float:right;width:50px;text-align:center;"> <a title="Clear" class="link11" href="javascript:return false;" onclick="RecentSearch();event.returnValue=false;return false;"><span class="fv10c">Clear</span></a> </div>
                                </div>
                            </c:if>
                        </div>
                            <div >
                                <div style="margin:5px 0 0 0;clear:both">
                                <div id="bodybanner">

                                    <object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=10,0,0,0" width="728" height="95" id="buysell1" align="middle">
                                        <param name="allowScriptAccess" value="sameDomain" />
                                        <param name="allowFullScreen" value="false" />
                                        <param name="movie" value="bbsimages/buysell1.swf" /><param name="quality" value="high" /><param name="bgcolor" value="#ffffff" />
                                        <embed src="/bbsimages/buysell1.swf" quality="high" bgcolor="#ffffff" width="728" height="95" name="buysell1" align="middle" allowScriptAccess="sameDomain" allowFullScreen="false" type="application/x-shockwave-flash" pluginspage="http://www.adobe.com/go/getflashplayer" />
                                   </object>
                                </div>
                                <!-- home banner   -->
                                <div id="afterbanner" style="margin:0 0 0 5px">             <!-- home navigation  start -->
                                  <div  style="text-align:center;float:right;width:500px">
                                        <span  id="clock" style=";width:150px;font-family:verdana;font-size:12px;color:#444444;font-weight:bold;margin:0 40px 0 0">
                                        <%= new java.text.SimpleDateFormat("MMM dd, yyyy").format(new java.util.Date()) %></span>
                                  </div>
                                </div>
                                </div>

                            </div>
                        <div>
                            <tiles:insert attribute="body" />
                        </div>
                    </div>
                </div>
            </div>
           <div id="masterfooter">
                    <br />
                        <div id="footerPage" style="text-align:right;">


                            <span class="verdana_footer" ><a title="About Us" href="/aboutUs.do">About Us</a></span>
                            <span class="verdana_footer_1"> | </span>


                            <span class="verdana_footer"> <a title="Contact us" href="/contactUs.do">Contact Us</a></span>
                            <span class="verdana_footer_1"> | </span>


                            <span class="verdana_footer"><a title="Feedback" href="/contactUs.do">Feedback</a></span>
                            <span class="verdana_footer_1"> | </span>

                            <span class="verdana_footer"><a title="Sitemap" href="/siteMap.do">Site Map</a></span>
                            <span class="verdana_footer_1"> | </span>

                            <span class="verdana_footer"><a title="Help" href="/help.do">Help</a></span>
                            <span class="verdana_footer_1"> | </span>

                            <%--<span class="verdana_footer"><a title="Terms of use"href="#">Terms of Use</a></span>
                            <span class="verdana_footer_1"> | </span>--%>

                            <span class="verdana_footer"><a title="Terms of Service & Use" href="javascript:return false;" onclick="termsAndConditions('tc.do','Terms & Condition');event.returnValue=false;return false;">Terms of Service &amp; Use</a></span>
                            <span class="verdana_footer_1"> | </span>

                            <span class="verdana_footer"><a title="Privacy Statement" href="javascript:return false;" onclick="termsAndConditions('ps.do','Privacy Statement');event.returnValue=false;return false;">Privacy statement</a></span>
                             <span class="verdana_footer_1"> | </span>
                            <span class="verdana_footer"><a title="Business Links" href="/getLinks.do">Business Links</a></span>

                            <span class="verdana_footer">&nbsp;&nbsp;</span>


                            <br />
                            <br />

                        </div>
                        <span class="verdana_footer_1">© 2009 Bharatbuysell.com</span>
                        <span class="verdana_footer_1" style="float:right;">Powered by <a href="http://focus9.in" style="text-decoration:none;font-size:12px;font-weight:bold;color:#FFF" target="_blank">Focus9.in</a></span>

                        <script type="text/javaScript">
                            function browserDetect()
                            {
                                var browserVer=navigator.appVersion;
                                var str=browserVer.indexOf("MSIE 6.0");

                                if (str > 0 )
                                {
                                    document.getElementById("floatFeed").style.display= 'none';
                                }
                                else
                                {
                                    document.getElementById("floatFeed").style.display= 'block';
                                }

                            }
                        </script>
                        <%--<div id="twit">
                        <a style="display:scroll;position:fixed;bottom:250px;left:10px;" href="http://twitter.com/bharatbuysell" target="_blank"><img style="width:45px;height:45px;border:0;" title="Follow us on twitter" src="/bbsimages/twittert.gif" alt="Follow us on Twitter"/></a>

                        </div>--%>

                        <div id="cntr1">
                            <a title="" style="display:scroll;position:fixed;bottom:100px;right:10px;z-index:3" href="http://singaporebuysell.com" target="_blank"><img style="width:35px;height:35px;border:0;" title="singaporebuysell.com" src="/bbsimages/flags_icons/singapore.png" alt="Singapore"/></a>

                        </div>
                        <div id="cntr3">
                            <a title="" style="display:scroll;position:fixed;bottom:10px;right:10px;z-index:3" href="http://aussiebuysell.com" target="_blank"><img style="width:35px;height:35px;border:0" title="aussiebuysell.com" src="/bbsimages/flags_icons/australia.png" alt="Australia"/></a>

                        </div>
                        <div id="cntr2">
                            <a title="" style="display:scroll;position:fixed;bottom:55px;right:10px;z-index:3" href="http://ukbuysell.com" target="_blank"><img style="width:35px;height:35px;border:0;" title="ukbuysell.com" src="/bbsimages/flags_icons/uk.png" alt="UK"/></a>
                        </div>

                        <%--<div><a title="" style="display:scroll;position:fixed;bottom:10px;right:10px;" href="http://europe-buysell.com" target="_blank"><img style="width:35px;height:35px;border:0;" title="europe-buysell.com" src="/bbsimages/flags_icons/europe.png" /></a>

                        </div>--%>
                        <%--<div>
                            <a title="" style="display:scroll;position:fixed;bottom:55px;right:10px;" href="http://us-buysell.com" target="_blank"><img style="width:35px;height:35px;border:0;" title="us-buysell.com" src="/bbsimages/flags_icons/us.png" /></a>
                        </div>

                            <div>
                                <a title="" style="display:scroll;position:fixed;bottom:10px;right:10px;" href="http://mychinabuysell.com" target="_blank"><img style="width:35px;height:35px;border:0;" title="mychinabuysell.com" src="/bbsimages/flags_icons/china.png" /></a></div>
                           </div>--%>
                        <%--<script type="text/javascript">

                            if(FeedBack == 'yes')
                            {
                                browserDetect();
                            }
                        </script>
                        --%>
                </div>

     </div>

  </body>
</html>