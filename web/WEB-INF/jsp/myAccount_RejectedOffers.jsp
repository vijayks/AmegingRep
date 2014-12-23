<%-- 
    Document   : myAccount_rejectedAds
    Created on : Dec 22, 2009, 4:33:24 PM
    Author     : bbsadmin
--%>
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
    <logic:present name="requestedOffersList" property="results">
    <bean:size id="size" name="requestedOffersList" property="results"/>

    <logic:equal name="size" value="0">
        <div class="fv11b" style="width:740px;height:15px;text-align:center;color:#EA052B;">No Offers found under requested criteria.</div>
    </logic:equal>


       
        <c:if test="${requestedOffersList.results!=null}">
        <c:forEach items="${requestedOffersList.results}" var="ol">

            <div class="adet"><div class="adb"><div class="adl"><div class="adr"><div class="adbl"><div class="adbr"><div class="adtl"><div class="adtr">
                                            <div  style="height:95px;" >

                                                <div class="rb" style="float:left;width:85px;height:85px;padding-top:10px" align="center" >
                                                    <a title="Offer Image" class="imglink" style=""   >
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
                                                        <a title="${ol.scrTitle}" class="link" style="font-size:11px;color:#046DBE"  href="spOffer.do?sId='${ol.sid}'">
                                                            ${ol.scrTitle}
                                                    </a>
                                                    </div>

                                                    <div class="fv11b" style="float:left;text-align:right;width:100px;padding-right:2px;padding-top:5px"><b>
                                                            <a title="More Details" class="link" style="font-size:11px;color:#222222"  href="spOffer.do?sId='${ol.sid}'">More Details...</a>
                                                    </b></div>

                                                    <div class="fv11" style="height:55px;width:525px;float:left;text-align:left;padding-left:3px;padding-top:6px;padding-right:2px;">
                                                        <c:if test="${fn:length(ol.desc) <= 350 }" >
                                                            <c:out value="${ol.desc}" />
                                                        </c:if>
                                                        <c:if test="${fn:length(ol.desc) > 350 }" >
                                                            <c:out value="${fn:substring(ol.desc,0,350)}" />&nbsp;&nbsp;<a title="More Details" href="spOffer.do?sId='${ol.sid}'" ><span style="color:#046dbe">More...</span></a>
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
                                                        <a title="Modify & Repost" href="editOffer.do?sid=${ol.sid}&from=cejr">Modify & Repost</a>
                                                    </div>
                                                </div>

                                            <!-- main div ends --></div>
            </div></div></div></div></div></div></div></div>
            <div style="width:710px;background-color:#4D9EDF;height:18px;"><!-- Blue bar Div --></div>
            <div style="width:720px;height:5px;"></div>

        </c:forEach>
        </c:if>

    </logic:present>
</div>