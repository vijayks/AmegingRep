<%--
    Document   : myAccount_EditRenewOffers
    Created on : Dec 22, 2009, 4:06:24 PM
    Author     : bbsadmin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.buysell.beans.UserBean" %>
<%@page import="com.buysell.beans.MyAdDetailsBean" %>
<%@page  import="com.buysell.beans.AdsResultsBean " %>
<%@page  import="java.io.OutputStream " %>
<%@page  import="java.io.FileInputStream " %>

<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>

<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn"%>


<div style="width:710px;height:15px;"></div>
<div id="sortBar" style="text-align:left;color:#ffffff;width:710px;float:left;height:30px;padding-top:9px;background:url(bbsimages/sortBy710.jpg) no-repeat;">
    <span class="verdana_menu_head" style="padding-left:15px;" ><%= request.getAttribute("title") %></span>
</div>
<div style="clear:both;"></div>
     <div style="width:710px;height:1px;"></div>
    <logic:present name="editRenewOffersList" property="results">
    <bean:size id="size" name="editRenewOffersList" property="results"/>

    <logic:equal name="size" value="0">
        <div class="fv11b" style="width:740px;height:15px;text-align:center;color:#EA052B;">No Offers found under requested criteria.</div>
    </logic:equal>


        <% String name = "status";%>
        <c:if test="${editRenewOffersList.results!=null}">
        <c:forEach items="${editRenewOffersList.results}" var="ol">
            <c:if test="${ol.status==1}">
                <% name = "Active";%>
            </c:if>
            <c:if test="${ol.status==2}">
                <% name = "On Hold";%>
            </c:if>
            <c:if test="${ol.status==3}">
                <% name = "Reposted";%>
            </c:if>
            <c:if test="${ol.status==4}">
                <% name = "Expired";%>
            </c:if>
            <c:if test="${ol.status==5}">
                <% name = "Deleted";%>
            </c:if>
            <c:if test="${ol.status==6}">
                <% name = "Incomplete";%>
            </c:if>

            <div class="adet"><div class="adb"><div class="adl"><div class="adr"><div class="adbl"><div class="adbr"><div class="adtl"><div class="adtr">
                                            <div  style="height:95px;" >

                                                <div class="rb" style="float:left;width:85px;height:85px;padding-top:10px" align="center" >
                                                 <a class="imglink" style=""   >
                                                     <c:set var="offerImg" value="${ol.img1}"/>

                                                        <c:if test='${offerImg != "" && offerImg != "null" }'>
                                                            <img src="resourceGetter?imf=${ol.img1}" width="75px" height="75px" style="border:none"  >
                                                        </c:if>
                                                        <c:if test='${offerImg == "" || offerImg == "null"}'>
                                                            <img src="bbsimages/noimage.png" width="75px" height="75px" style="border:none"  >
                                                        </c:if>
                                                    </a>
                                                </div>

                                                <div class="rb" style="float:left;height:95px;width:530px;overflow:hidden;">
                                                    <div class="fv12bc" style="text-align:left;float:left;padding-top:5px;padding-left:3px;width:425px;">
                                                        <a class="link" style="font-size:11px;color:#046DBE" target="_blank"  href="spoffer.do?sid=${ol.sid}">
                                                            ${ol.scrTitle}
                                                    </a>
                                                    </div>

                                                    <div class="fv11b" style="float:left;text-align:right;width:100px;padding-right:2px;padding-top:5px"><b>
                                                             <a class="link" style="font-size:11px;color:#222222" target="_blank"  href="spoffer.do?sid=${ol.sid}">More Details...</a>
                                                    </b></div>

                                                    <div class="fv11" style="height:55px;width:525px;float:left;text-align:left;padding-left:3px;padding-top:6px;padding-right:2px;">
                                                        <c:if test="${fn:length(ol.desc) <= 350 }" >
                                                            <c:out value="${ol.desc}" />
                                                        </c:if>
                                                        <c:if test="${fn:length(ol.desc) > 350 }" >
                                                            <c:out value="${fn:substring(ol.desc,0,350)}" />&nbsp;&nbsp;<a href="spoffer.do?sid=${ol.sid}" target="_blank" ><span style="color:#046dbe">More...</span></a>
                                                        </c:if>
                                                    </div>

                                                    <div class="fv11" style="padding-left:3px;float:left;width:188px;text-align:left;padding-bottom:5px">
                                                        ${ol.oprice}
                                                    </div>

                                                    <div class="fv11" style="float:left;width:330px;text-align:right;padding-bottom:5px">
                                                        Started from : <span class="fv11bc" style="padding-right:2px">
                                                        ${ol.sDate} </span>
                                                    </div>

                                                </div>



                                                <div style="float:left;width:90px;height:95px;" align="center">
                                                    <div style="float:left;width:90px;height:45px;padding-top:40px;" align="center">
                                                        <%= name%>
                                                    </div>
                                                </div>

                                            <!-- main div ends --></div>
            </div></div></div></div></div></div></div></div>
           <div style="width:710px;background-color:#4D9EDF;height:18px;"><!-- Blue bar Div -->
                <div style="width:55%;float:left;">&nbsp;</div>
                <div style="width:3%;float:left;text-align:left;">
                    <img src="bbsimages/Renew-Edit-Ad.gif" style="height:15px;padding-top:1px" />
                </div>
                <div  style="width:30%;float:left;padding-top:3px;">
                    <c:if test="${ol.status==1}">
                        <div class="fv11b" style="float:left;width:40%;text-align:left;padding-top:1px">
                            <a style="color:#FFFFFF;" href="editOffer.do?sid=${ol.sid}&from=newre&dmc=.four">Renew</a>
                        </div>

                        <div style="width:10%;float:left">
                            <img src="bbsimages/Post_Ad.gif" style="height:15px;" />
                        </div>

                        <div class="fv11b" style="float:left;text-align:left;padding-top:1px">
                            <a style="color:#FFFFFF;" href="editOffer.do?sid=${ol.sid}&from=tide">Edit</a>
                        </div>
                   </c:if>

                    <c:if test="${ol.status==4}">
                        <div class="fv11b" style="float:left;width:40%;text-align:left;padding-top:1px">
                            <a style="color:#FFFFFF;" href="editOffer.do?sid=${ol.sid}&from=newre">Renew</a>
                        </div>
                    </c:if>

                    <c:if test="${ol.status==5}">
                        <div class="fv11b" style="float:left;width:40%;text-align:left;padding-top:1px">
                            <a style="color:#FFFFFF;" href="editOffer.do?sid=${ol.sid}&from=newre">Renew</a>
                        </div>
                    </c:if>
                </div>
            </div>
            <div style="width:725px;height:5px;"></div>


        </c:forEach>
        </c:if>

    </logic:present>