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
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
        <meta name="google-site-verification" content="otOLqBKAgj_fgOlHw-rn8uqTr2q5IzwwTZi4KaNZoDE" />
        <title> Bharatbuysell.com | Search and Post Free Classified Ads in India</title>
        <%!String getCityBasedDescription(String city, String description){

        Object[] obj ={city};
        String des = MessageFormat.format(description,obj);
        return des;
    }%>
        <%String finalId = request.getParameter("subCatId");
            if (finalId == null) {
                finalId = request.getParameter("clfId");
            }
            String ctgId = finalId;

            CategoryUtil cu = new CategoryUtil();
            Category catg = new Category();
            String siti2 = (String) request.getSession().getAttribute("city");

            if (ctgId != null && ctgId.trim().length() > 0 && !(ctgId.equals("0")) && siti2 != null) {
                catg = cu.getCategoryByID((Integer.parseInt(ctgId)));
                String desc = (String) catg.getDescription();
                String ttl2 = null;
                String dscpr2 = null;
                StringTokenizer st22 = new StringTokenizer(desc, "^^^");
                if (st22.countTokens() >= 2) {
                    ttl2 = st22.nextToken();
                    dscpr2 = st22.nextToken();
                }
        %>
            <title><%=getCityBasedDescription(siti2,ttl2)%>-<%=siti2%></title>
        <meta name="description" content="<%=getCityBasedDescription(siti2,dscpr2)%>-<%=siti2%>" />
        <meta name="keywords" content="<% if(catg!=null) { List tgs = (List)(catg.getTags());if (tgs != null && tgs.size() > 0) {
              for (Iterator itert1 = tgs.iterator(); itert1.hasNext();) {%><%=getCityBasedDescription(siti2,(String)itert1.next())%>,<%}} else {%>Free Classifieds, free classified websites, free india classifieds, indian classifieds, free classifieds india, free indian classified, free classifieds in india, free indian classifieds, free india classified sites, free india classified ads, free classifieds personals, free indian classified ad posting, post free ads india, india classified ads, auto classified ads, classified advertisements, classic car classifieds, buy and sell, buysell, free india classified, online car classifieds, pre owned cars, commercial property for rent, commercial properties for sale, residential property for sale, property for sale, Used bikes, residential property for rent, electronic items, used laptops india, furniture sale, interior designers, livingroom furniture, modular kitchen, furniture in bangalore, used refrigerators, packers and movers, home appliances for sale, electric home appliances, home appliances, electronic appliances, second hand car, second hand bike.<%}}%>" /><%}else{%>

        <title> Bharatbuysell Free classifieds | Classified ads India-<%=siti2%>.</title>

        <meta name="description" content=" Bharatbuysell Online classifieds offers free online classifieds in all major cities in India. Browsing, reading or posting classified ads is free.This is the most innovative and comprehensive classified website for Indian community around the world.The listing covers ads for ALL India, try it now-<%=siti2%>."/>

        <meta name="keywords" content=" free india classified, classifieds, free classifieds, Bharatbuysell India, online classifieds, buy sell classifieds India, classified ads, India ."/><%}%>
        <style type="text/css">
            <!--
            .top_bg
            {
                background:url(bbsimages/top_bg.png) no-repeat;
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
        <link rel="shortcut Icon" href="bbsimages/favicon.ico" />
        <meta name="verify-v1" content="PwZKjgUkv/eSDfv+Uy0B+3cq/8kRGNuDOWAJpSWyHSw=" />
    </head>
    <body>
        <!-- this for button bar highlignted -->
        <c:set var="act"><tiles:getAsString name="button" ignore="true" /></c:set>
        <c:set var="button" value="${act}" scope="session" />
        <div id="wrapper" style="float:left;" >                                                                <!-- Main wrapper start -->
            <div id="masterheader">  <!-- master header div  start -->
                <tiles:insert attribute="header" />
            </div>  <!-- master header div  end -->
                            <tiles:insert attribute="searchBar" />
                       <div style="*height:30px; *background:white; *width:1000px; *margin-left:auto; *margin-right:auto"></div>
            <div id="body_container2" style="clear:both;">
                <div id="body_container1" ><c:if test="${userBean!=null}">
                        <c:if test="${fn:startsWith(userBean.userType,'DEALER-PLAT') == true}">
                           <%-- <span style="float:right;padding-right:40px;padding-top:15px"><a href="http://${userBean.website}.bharatbuysell.com/" target="_blank"><b style="color:#4d9edf">${userBean.website}.bharatbuysell.com</b></a></span>--%>
                        </c:if></c:if>
                        <div style="float:left;width:25%;*width:22%">
                        <tiles:insert attribute="menu"/>
                    </div>
                    <div id="mastermainbody" style="float:left;width:75%">                                                              <!-- Master main body div start -->
                        <div id="masterrightbodybg">

                            <tiles:insert attribute="recentSearches" />

                            <tiles:insert attribute="body" />
                        </div>
                    </div>                                                              <!-- Master main body div end -->
                </div>
            </div>
            <div id="masterfooter">                                                                <!-- Footer div start -->
                <tiles:insert attribute="footer" />
            </div>                                                               <!-- Footer div end -->
        </div>              <!-- Main wrapper end -->
        <script type="text/javascript">
            <%--  document.writeln(" Time to load Header ::"+(-headerStart+headerEnd)/1000+" Seconds");
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
            document.writeln(" Time to load Footer ::"+(-footerStart+footerEnd)/1000+" Seconds");--%>
                document.writeln("<br />");
                var d2=new Date();
                var last=d2.getTime();
                // document.writeln(" <center style='fontSize:10px'> Time taken to complete page load ::<b>"+(last-first)/1000+"</b> Seconds</center>");
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
