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
<%@page import="com.buysell.util.BuySellProperties" %>

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
            String localUrlPath = "/";
    if (BuySellProperties.getProperty("localurl") != null && BuySellProperties.getProperty("localurl").trim().length() > 0) {
                localUrlPath = BuySellProperties.getProperty("localurl");
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
                <c:if test="${moreDetails!=null}">
                    <c:set var="adCatId" value="${moreDetails.catId}"/>
                    <%
                      CategoryUtil cu = new CategoryUtil();
                      int cid = Integer.parseInt(pageContext.getAttribute("adCatId").toString());
                      int pcid = cu.getRootCatId(cid);
                    %>
                    <c:set var="scnm"><%=cu.getCategoryNameWithId(pcid)%></c:set>
                    <c:set var="clfnm"><%=cu.getCategoryNameWithId(cid)%></c:set>
                    <title>${moreDetails.title} - ${clfnm} - ${scnm} - ${moreDetails.city}</title>
                    <meta name="description" content="${moreDetails.title} - ${clfnm} - ${scnm} - ${moreDetails.city}"/>
                    <meta name="keywords" content="${moreDetails.title} - ${clfnm} - ${scnm} - ${moreDetails.city}"/>
                </c:if>  </c:otherwise>
        </c:choose>
        <link href="<%=localUrlPath%>/css/stylesheet.css" rel="stylesheet" type="text/css" />
        <link rel="shortcut Icon" href="<%=localUrlPath%>/bbsimages/favicon.ico"  />
        <script type="text/javascript" src="<%=localUrlPath%>/js/curvycorners.js"></script>
    </head>
    <body>

        <div id="wrapper" style="float:left;" >
            <div id="masterheader">
                <jsp:include page="WEB-INF/jsp/header.jsp"/>
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
                                        <a title="" class="link11" href="<%=localUrlPath%>/<%= recentSearches.get(key)%>&city=<%=request.getSession().getAttribute("city")%>" ><span class="fv10c"><%= key%></span></a><span>,&nbsp;</span>
                                        <% } }%>
                                    </div>
                                    <div id="recent2" class="fv10c" style="float:right;width:50px;text-align:center;"> <a title="Clear" class="link11" href="javascript:return false;" onclick="RecentSearch();event.returnValue=false;return false;"><span class="fv10c">Clear</span></a> </div>
                                </div>
                            </c:if>
                        </div>
                        <div style="width:75%;float:right">
                            <div style="margin:5px 0 0 0;clear:both">
                            </div>
                        </div>
                        <div style="clear:both"></div>
                        <div>
                            <c:if test="${moreDetails!=null}">
                                <div class="body_part">
                                    <div class="body_part_wrapper">
                                        <div class="body_main_cont">
                                            <c:set var="adCatId" value="${moreDetails.catId}"/>
                                            <%
                                              CategoryUtil cu = new CategoryUtil();
                                              int cid = Integer.parseInt(pageContext.getAttribute("adCatId").toString());
                                              int pcid = cu.getRootCatId(cid);
                                            %>
                                            <c:set var="scnm"><%=cu.getCategoryNameWithId(pcid)%></c:set>
                                            <c:set var="clfnm"><%=cu.getCategoryNameWithId(cid)%></c:set>
                                                <div class="car_main_cont">
                                                    <div class="car_main_inner_cont">
                                                        <div class="car_mt_cont_920">
                                                            <div class="car_category">
                                                                <ul><li><b>Category :</b></li>
                                                                    <li><a href="<%=localUrlPath%>/">Home <img src="<%=localUrlPath%>/bbsimages/New/car_side_arrow.png" alt="" width="6" height="7" border="0" /></a></li>
                                                                <li><a href="<%=localUrlPath%>/<c:if test="${city!=null && city!='All India'}">${fn:toLowerCase(city)}-</c:if>${fn:toLowerCase(fn:replace(fn:replace(fn:trim(scnm),'/','-'),' ','-'))}-sc<%=pcid%>.in" class="car_category_Highlight">${scnm} <img src="<%=localUrlPath%>/bbsimages/New/car_side_arrow.png" alt="" width="6" height="7" border="0" /></a></li>
                                                                <li><a href="<%=localUrlPath%>/<c:if test="${city!=null && city!='All India'}">${fn:toLowerCase(city)}-</c:if>${fn:toLowerCase(fn:replace(fn:replace(fn:trim(scnm),"/","-")," ","-"))}-${fn:toLowerCase(fn:replace(fn:replace(fn:trim(clfnm),"/","")," ","-"))}-cl<%=cid%>cs<%=pcid%>.in" >${clfnm}</a></li>
                                                                </ul>
                                                            </div>
                                                        </div>
                                                    <jsp:include page="/WEB-INF/jsp/moreDetails.jsp" />
                                                    <br/>
                                                    <iframe src="<%=localUrlPath%>/relatedClfAds.do?clfId=${moreDetails.catId}&adId=${moreDetails.adId}&subCatId=<%=pcid%>&range=5&fromRelated=s" width="100%" height="300" style="border:none" frameborder="0"></iframe>
                                                </c:if>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div id="masterfooter">
                <jsp:include page="WEB-INF/jsp/footer.jsp"/>
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
