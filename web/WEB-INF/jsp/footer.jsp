<%--
    Document   : footer
    Created on : Mar 1, 2009, 1:03:38 PM
    Author     : praveen.ch
--%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import="com.buysell.util.BuySellProperties" %>
<% String localUrlPath = "/";
            if (BuySellProperties.getProperty("localurl") != null && BuySellProperties.getProperty("localurl").trim().length() > 0) {
                localUrlPath = BuySellProperties.getProperty("localurl");
            }
%>
<!--scial media part Start here-->
<div  class="socialmedia">
    <div class="f_img"><a href="https://www.facebook.com/BBuysell" title="Facebook" target="_blank" rel="nofollow"></a>
        <div class="t_img"><a href="http://twitter.com/bharatbuysell" title="Twitter" target="_blank" rel="nofollow"></a>
            <div class="g_img"><a href="http://plus.google.com/113845296006571668118/posts" title="Google" target="_blank" rel="nofollow"></a>
                <div class="feedback"><a href="<%=localUrlPath%>/contactUs.do" title="Feedback" target="_blank" rel="nofollow"></a></div>
            </div>
        </div>
    </div>
</div>
<div class="clear1"></div>
<!--scial media part End here-->

<!---------------------------------------------footer_city_part start here------------------------------------------------>
<c:if test="${reqURI=='tile1.do'}">
    <div class="footer_city_part">
        <div class="footer_city_part_wrapper">
            <div class="featured">related search<br/></div>
            <div>
                <div class="footer_city_left_cont" style="margin:0 0 0 16px;">
                    <c:if test='${cities!= null}'>
                        <c:set var="k" value="0" />
                        <c:forEach items="${cities}" var="popcities" >
                            <c:set var="k"  value="${k + 1}" />
                            <div class="footer_city_left_txt">
                                <ul>
                                    <li> <a href="<%=localUrlPath%>/ccs-${popcities.name}" title="${popcities.name} classifieds ">${popcities.name} </a></li>
                                </ul>
                            </div> <c:if test='${k%6 == 0}'></div>
                        <div></c:if></c:forEach></c:if></div>
                    </div>
                </div>
            </div>
</c:if>
<!----------------------------------------------------footer_city_part end here----------------------------------------------->

<!--------------------------------------------------footer part start here-------------------------------------------------------->
<div class="footer_part">
    <div class="footer_part_wrapper">
        <div class="footer_mt_cont">
            <div class="copy_left_txt">
                <p> Copyright ©   <strong><a title="Home" <c:if test="${sessionScope.button == 'home'}" >class="selected"</c:if> id="home" href="<c:if test="${city=='All India'}"><%=localUrlPath%></c:if><c:if test="${city!='All India'}"><%=localUrlPath%>/ccs-${city}</c:if>" > Ameging </a></strong> All rights reserved </p>
            </div>
            <div style="width:300px;float:left;margin-left:60px;">
                <a href="https://s3.amazonaws.com/com.alexa.toolbar/atbp/ed72Ro/download/index.htm"><img src="http://www.alexa.com/tbplatform/images/promotebuttons/lightBlue/TB-banner3-2.jpg" alt="Get our toolbar!" ></a>
            </div>
            <div class="footer_menu">
                <ul>
                    <li><a title="Terms of Service &amp; Use" href="javascript:return false;" onclick="termsAndConditions('<%=localUrlPath%>/tc.do','Terms and Conditions');event.returnValue=false;return false;">Terms of Service & Use</a></li>
                    <li> | </li>
                    <li><a title="Privacy Statement" href="javascript:return false;" onclick="termsAndConditions('<%=localUrlPath%>/ps.do','Privacy Statement');event.returnValue=false;return false;" >Privacy</a></li>
                    <li> | </li>
                    <li><a title="Business Links" href="<%=localUrlPath%>/getLinks.do" >Business Links</a></li>
                </ul>
            </div>
        </div>
    </div>
</div>
<!---------------------------------------------footer part end here-------------------------------------------------------->
<c:if test="${reqURI=='clf.do' || reqURI=='displayClfAds.do' || reqURI=='basicSearch.do'|| reqURI=='sRefine.do'}">

    <script type="text/javascript">
        function showHelp(tm) {
            setTimeout(function(){if(!$('#contactFormFrame').contents().find('#autoShowHelp').is(':checked') && $('div#contactable').attr('showOrHide')=='false'){$('div#contactable').click();}}, tm);
        }
        showHelp(1000);
    </script>
</c:if>
