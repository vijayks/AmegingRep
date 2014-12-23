<%--
    Document   : tile
    Created on : May 10, 2009, 6:58:42 PM
    Author     : praveen.ch
    This tile.jsp is used for to insert the tile in proper order. For this i use layout.css

--%>
<%@ taglib uri="http://struts.apache.org/tags-tiles" prefix="tiles" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@page  import="com.buysell.util.Category " %>
<%@page  import="com.buysell.util.CategoryUtil " %>
<%@page  import="java.util.List " %>
<%@page  import="java.util.Iterator " %>
<%@ page import="java.util.StringTokenizer" %>
<%@page import="java.text.MessageFormat" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html>
    <head>
        <meta name="verify-v1" content="PwZKjgUkv/eSDfv+Uy0B+3cq/8kRGNuDOWAJpSWyHSw=" />
        <meta name="google-site-verification" content="otOLqBKAgj_fgOlHw-rn8uqTr2q5IzwwTZi4KaNZoDE" />
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />

        <c:if test="${reqURI!='basicSearch.do'&& reqURI!='sRefine.do'}">

            <%!String getCityBasedDescription(String city, String description){

            Object[] obj ={city};
            String des = MessageFormat.format(description,obj);
            return des;
        }%>
            <% String adTitle=null;
             String finalId = request.getParameter("subCatId");
             if(finalId==null) finalId=request.getParameter("clfId");
             String ctgId = finalId;

             CategoryUtil cu = new CategoryUtil();
             Category catg = new Category();
             String siti1=(String)request.getSession().getAttribute("city");
                if(ctgId!=null&&ctgId.trim().length()>0&&!(ctgId.equals("0"))&&siti1!=null){
                catg = cu.getCategoryByID((Integer.parseInt(ctgId)));

                String desc=(String)catg.getDescription();
                String ttl1=null;
                String dscpr1=null;
                StringTokenizer st11=new StringTokenizer(desc,"^^^");
    if(st11.countTokens()>=2)
    {
    ttl1=st11.nextToken();
    dscpr1=st11.nextToken();
    }
            %>
            <title><%=getCityBasedDescription(siti1,ttl1)%>-<%=siti1%></title>
            <meta name="description" content="<%=getCityBasedDescription(siti1,dscpr1)%>-<%=siti1%>" />
            <meta name="keywords" content="<% if(catg!=null) { List tgs = (List)(catg.getTags());if (tgs != null && tgs.size() > 0) {
              for (Iterator itert1 = tgs.iterator(); itert1.hasNext();) {%><%=getCityBasedDescription(siti1,(String)itert1.next())%>,<%}} else {%>Free Classifieds ,free classified websites, free india classifieds, indian classifieds, free classifieds india, free indian classified, free classifieds in india, free indian classifieds, free india classified sites, free india classified ads, free classifieds personals, free indian classified ad posting, post free ads india, india classified ads, auto classified ads, classified advertisements, classic car classifieds, buy and sell, buysell, free india classified, online car classifieds, pre owned cars, commercial property for rent, commercial properties for sale, residential property for sale, property for sale, Used bikes, residential property for rent, electronic items, used laptops india, furniture sale, interior designers, livingroom furniture, modular kitchen, furniture in bangalore, used refrigerators, packers and movers, home appliances for sale, electric home appliances, home appliances, electronic appliances, second hand car, second hand bike.<%}}%>" /><%}else{%>

            <title> Bharatbuysell Free classifieds | Classified ads India-<%=siti1%>.</title>
            <meta name="description" content=" Bharatbuysell indian classifieds offers free india classifieds in all major cities in india.This is the most innovative free classified websites providing Free classifieds india for indian community around the world."/>
            <meta name="keywords" content=" free classified websites,free india classifieds,indian classifieds,free classifieds india,free indian classified,free classifieds in india,free indian classifieds,free india classified sites"/><%}%>
        </c:if>
        <c:if test="${reqURI=='basicSearch.do'}">
            <% String sci=request.getParameter("subCatId");
               CategoryUtil cu = new CategoryUtil(); %>
            <c:if test="${keyword==' '&& subCatId==0}">
                <title>Search ${city}</title>
                <meta name="description" content="Search ${city} "/>
                <meta name="keywords" content="Search ${city} "/> 
            </c:if>
            <c:if test="${keyword==' '&& subCatId >0}">
                <title><%=cu.getCategoryNameWithId(Integer.parseInt(sci))%> - ${city}</title>
                <meta name="description" content=" <%=cu.getCategoryNameWithId(Integer.parseInt(sci))%> - ${city}"/>
                <meta name="keywords" content=" <%=cu.getCategoryNameWithId(Integer.parseInt(sci))%> - ${city}"/> 
            </c:if>
            <c:if test="${keyword!=' '&& subCatId ==0}">
                <title>${keyword} - ${city}</title> 
                <meta name="description" content="${keyword} - ${city}"/> 
                <meta name="keywords" content="${keyword} - ${city}"/>  
            </c:if>
            <c:if test="${keyword!=' '&& subCatId >0}">
                <title>${keyword} - <%=cu.getCategoryNameWithId(Integer.parseInt(sci))%> -  ${city}</title>
                <meta name="description" content="${keyword} - <%=cu.getCategoryNameWithId(Integer.parseInt(sci))%> - ${city}"/> 
                <meta name="keywords" content="${keyword} - <%=cu.getCategoryNameWithId(Integer.parseInt(sci))%> - ${city}"/> 
            </c:if>
        </c:if>
        <c:if test="${reqURI=='sRefine.do'}">
            <% String sci=request.getParameter("subCatId");
               CategoryUtil cu = new CategoryUtil(); %>
            <c:if test="${keyword==''&& subCatId >0}">
                <title><%=cu.getCategoryNameWithId(Integer.parseInt(sci))%> -  ${city}</title>
                <meta name="description" content="<%=cu.getCategoryNameWithId(Integer.parseInt(sci))%> - ${city}"/> 
                <meta name="keywords" content="<%=cu.getCategoryNameWithId(Integer.parseInt(sci))%> - ${city}"/> 
            </c:if>
            <c:if test="${keyword!=''&& subCatId >0}">
                <title>${keyword} - <%=cu.getCategoryNameWithId(Integer.parseInt(sci))%> -  ${city}</title>
                <meta name="description" content="${keyword} - <%=cu.getCategoryNameWithId(Integer.parseInt(sci))%> - ${city}"/> 
                <meta name="keywords" content="${keyword} - <%=cu.getCategoryNameWithId(Integer.parseInt(sci))%> - ${city}"/> 
            </c:if>
        </c:if>

        <style type="text/css">
            <!--
            .top_bg
            {   background:url(bbsimages/top_bg.png) no-repeat;
                height:10px;
                margin-top:0px;
            }
            .bottom_bg
            {
                clear:both;
                background:url(bbsimages/bottom_bg.png) 0 100% no-repeat;
                height:10px;
                margin-bottom:0px;
            }
            -->
        </style>
        <link href="css/stylesheet.css" rel="stylesheet" type="text/css" />
        <link rel="shortcut Icon" href="bbsimages/favicon.ico"  />
        <%--  <script type="text/javascript" src="js/jquery.js"></script>--%>
        <%--<script type="text/javascript" src="js/thickbox.js"></script>--%>
        <%--<link rel="stylesheet" href="css/thickbox.css" type="text/css" media="screen" />--%>
        <script type="text/javascript">

            function showSelectCity(){
                var ct3=readCookie('si');
                if(ct3==null){
                    if ( typeof imgLoader === 'undefined')
                    {
                        imgLoader = new Image();// preload image
                        imgLoader.src = tb_pathToImage;//Animated loader gif image.
                    }
                    tb_show('Select your preferred City','city.do?placeValuesBeforeTB_=savedValues&TB_iframe=true&height=380&width=750&modal=true',null);}
            }



            function readCookie(name) {

                var nameEQ = name + "=";
                var ca = document.cookie.split(';');
                for(var i=0;i < ca.length;i++) {
                    var c = ca[i];
                    while (c.charAt(0)==' ') c = c.substring(1,c.length);
                    if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length,c.length);
                }
                return null;
            }

            function eraseCookie(name) {
                createCookie(name,"",-1);
            }

        </script>
    </head>
    <body>
        <%--<script type="text/javascript">
            showSelectCity();
        </script>--%>
        <%--<script type="text/javascript">
            var t=new Date();
            var first=t.getTime();
        </script>--%>
        <!-- this for button bar highlignted -->
        <c:set var="act"><tiles:getAsString name="button" ignore="true" /></c:set>
        <c:set var="button" value="${act}" scope="session" />
        <div id="wrapper" style="float:left;" >                                                                  <!-- Main wrapper start -->
            <div id="masterheader">
                <!-- master header div  start -->
                <tiles:insert attribute="header" />
            </div>   <!-- master header div  end -->
            <div id="" style=";" >
                <tiles:insert attribute="searchBar" />
            </div>
            <div style="*height:30px; *background:white; *width:1000px; *margin-left:auto; *margin-right:auto"></div>

            <div id="body_container2" style="clear:both;">
                <div id="body_container1" >
                    <div style="float:left;width:25%;">
                        <tiles:insert attribute="menu"/>
                    </div>

                    <div id="masterrightbodybg" style="float:left;width:74%;position:relative" >
                        <div>
                            <tiles:insert attribute="recentSearches" />
                        </div>
                        <c:set var="clock"> <tiles:getAsString name="clock"/></c:set>

                        <%--
                                                <c:if test="${clock != null}">
                                                    <div >

                                    <tiles:insert attribute="clock" />

                                </div>
                            </c:if>--%>
                        <div>
                            <tiles:insert attribute="body" />
                        </div>
                    </div>
                </div>
            </div>
            <!-- Master main body div end -->
            <div id="masterfooter"><!-- Footer div start -->
                <tiles:insert attribute="footer" />
            </div>
            <!-- Footer div end -->
            <%-- <c:if test='${categoryList != null}' >
                                   <marquee style="background:white;" onmouseover="this.setAttribute('scrollamount', 0, 0);" onmouseout="this.setAttribute('scrollamount', 6, 0);">
        <c:forEach items="${categoryList}" var="category" >
            <c:if test='${category.parent == 0}' >
                <c:if test="${category.subCategories != null}">
                    <c:forEach items="${category.subCategories}" var ="cat">
                        <c:if test="${cat.subCategories != null}">
                            <c:forEach items="${cat.subCategories}" var ="clfction">
                                <a href="<c:if test="${city!=null && city!='All India'}">${fn:toLowerCase(city)}-</c:if>${fn:toLowerCase(fn:replace(fn:replace(fn:trim(cat.name),"/","-")," ","-"))}-${fn:toLowerCase(fn:replace(fn:replace(fn:trim(clfction.name),"/","")," ","-"))}-cl${clfction.id}cs${cat.id}.in" style="font-size:10px;color:black">${clfction.name},</a>
                            </c:forEach >
                        </c:if>
                    </c:forEach >
                </c:if>
            </c:if>
        </c:forEach >
    </marquee>
    </c:if>--%>
        </div>
        <!-- Main wrapper end -->
        <script>

            <%-- document.writeln(" Time to load Header ::"+(-headerStart+headerEnd)/1000+" Seconds");
             document.writeln("<br />");
             document.writeln(" Time to load Menu ::"+(-menuStart+menuEnd)/1000+" Seconds");
             document.writeln("<br />");
             document.writeln("<br />");
             document.writeln("Categories loading time ::"+(catEnd-catStart)/1000+" Seconds.");
             document.writeln("<br />");
             document.writeln("LatestAds loading time ::"+(laEnd-laStart)/1000+" Seconds.");
             document.writeln("<br />");
             document.writeln("Curvy Corners loading time ::"+(ccEnd-ccStart)/1000+" Seconds");
             document.writeln("<br />");

            document.writeln(" Time to load body  ::"+(-bodyStart+bodyEnd)/1000+" Seconds");
            document.writeln("<br />");
            document.writeln("<br />");
            document.writeln(" Time to load Footer ::"+(-footerStart+footerEnd)/1000+" Seconds");
            document.writeln("<br />");--%>
                var d2=new Date();
                var last=d2.getTime();
                //document.writeln(" <center style='fontSize:10px'> Time taken to complete page load ::<b>"+(last-first)/1000+"</b> Seconds</center>");
        </script>
        <script type="text/javascript">
            var gaJsHost = (("https:" == document.location.protocol) ? "https://ssl." : "http://www.");
            document.write(unescape("%3Cscript src='" + gaJsHost + "google-analytics.com/ga.js' type='text/javascript'%3E%3C/script%3E"));
        </script>
        <script type="text/javascript">
            try {
                var pageTracker = _gat._getTracker("UA-12685965-1");
                pageTracker._trackPageview();
            } catch(err) {}</script>
    </body>
</html>
