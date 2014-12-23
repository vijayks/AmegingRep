<%-- 
    Document   : tile5
    Created on : Apr 9, 2011, 4:56:08 PM
    Author     : bbsadmin
--%>
<%@ taglib uri="http://struts.apache.org/tags-tiles" prefix="tiles" %><%@page contentType="text/html" pageEncoding="UTF-8"%><%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %><%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %><%@page  import="com.buysell.util.Category " %><%@page  import="com.buysell.util.CategoryUtil " %><%@page  import="java.util.List " %><%@page  import="java.util.Iterator " %><%@ page import="java.util.StringTokenizer" %><%@page import="java.text.MessageFormat" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html>
    <head>
        <meta name="verify-v1" content="PwZKjgUkv/eSDfv+Uy0B+3cq/8kRGNuDOWAJpSWyHSw=" />
        <meta name="google-site-verification" content="otOLqBKAgj_fgOlHw-rn8uqTr2q5IzwwTZi4KaNZoDE" />
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
        <c:if test="${sessionScope.button == 'auctions'}" ><title> Bharatbuysell.com | Auctions - Free Bidding - Unlimited Bids for Free - No Registration fee </title></c:if>
        <%!String getCityBasedDescription(String city, String description){
        //example : In database we need to store description as " this category in {0} is very usefull"

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
        <meta name="keywords" content="<% if (catg != null) {
                    List tgs = (List) (catg.getTags());
                    if (tgs != null && tgs.size() > 0) {
                        for (Iterator itert1 = tgs.iterator(); itert1.hasNext();) {%><%=getCityBasedDescription(siti2,(String)itert1.next())%>,<%} } else {%>Free Classifieds, buy and sell, buysell, free india classified, online car classifieds, pre owned cars, commercial property for rent, commercial properties for sale, residential property for sale, property for sale, Used bikes, residential property for rent, electronic items, used laptops india, furniture sale, interior designers, livingroom furniture, modular kitchen, furniture in bangalore, used refrigerators, packers and movers, home appliances for sale, electric home appliances, home appliances, electronic appliances, second hand car, second hand bike.<%}
                }%>" /><%} else {%>
        <c:set var="cityName"><c:choose><c:when test="${city == 'All India'}">India</c:when><c:otherwise>${city}</c:otherwise></c:choose></c:set>
        <title> Free ${cityName} Classifieds - Bharat Buy Sell</title>

        <meta name="description" content=" Bharat Buy Sell Classifieds Post Free Classifieds Ads in ${cityName}. Free Classifieds for Buying & Selling Online. Search Online Free Classified Ads for Used Mobiles, Cars, Jobs, Bikes, Computer, Laptops, Pets, Flats, Apartments, PG, Furniture, Tuitions, and Home Appliances. Find Local Listings for IT jobs, BPO jobs, Coaching Centre, Travel Services, Property Dealers Also Avail Latest Offers and Deals in your City."/>

        <meta name="keywords" content=" ${cityName} Classifieds, Free ${cityName} Classifieds, ${cityName} Classified Ads, Free Classifieds, Free Ads, Free Online ${cityName} Classifieds, Ads in ${cityName}, Buy Sell Free Classifieds, For rent in ${cityName}, For sale in ${cityName}, Classified Ads in ${cityName}, Jobs Classifieds, Jobs in ${cityName}, B2B Classifieds, Real Estate Ads ${cityName} , Property in ${cityName} , Travel Deals, Best Dealers in ${cityName}, Discount Coupons ${cityName}, Used Products, Secondhand, Re sale, Domestic help Services ${cityName}"/><%}%>
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
        <link rel="stylesheet" type="text/css" href="/highslide/highslide.css" />
        <script type="text/javascript" src="js/jquery.js"></script>
    </head>
    <body>
        <!-- this for button bar highlignted -->
        <c:set var="act"><tiles:getAsString name="button" ignore="true" /></c:set>
        <c:set var="button" value="${act}" scope="session" />
        <div id="wrapper" style="float:left;" >                                                                <!-- Main wrapper start -->
            <div id="masterheader">  <!-- master header div  start -->
                <tiles:insert attribute="header" />
            </div>  <!-- master header div  end -->
            <div id="body_container2" style="clear:both;*padding-top:58px;">
                <div id="body_container1" >
                    <div id="mastermainbody" style="float:left;width:100%">                                                              <!-- Master main body div start -->
                        <div id="masterrightbodybg" style="width:100%">
                            <tiles:insert attribute="body" />
                        </div>
                    </div>                                                              <!-- Master main body div end -->
                </div>
            </div>
            <div id="masterfooter">                                                                <!-- Footer div start -->
                <tiles:insert attribute="footer" />
            </div>                                                               <!-- Footer div end -->
            <%--<c:if test='${categoryList != null}' >
                                           <marquee style="background:white;width:100%;" onmouseover="this.setAttribute('scrollamount', 0, 0);" onmouseout="this.setAttribute('scrollamount', 6, 0);">
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

        </div>              <!-- Main wrapper end -->
        <%--<script type="text/javascript">
                document.writeln("<br />");
                var d2=new Date();
                var last=d2.getTime();
                // document.writeln(" <center style='fontSize:10px'> Time taken to complete page load ::<b>"+(last-first)/1000+"</b> Seconds</center>");
        </script>--%>
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
