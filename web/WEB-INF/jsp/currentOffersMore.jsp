<%--
    Document   : currentOffersDiv
    Created on : Sep 14, 2009, 7:55:38 PM
    Author     : bbsadmin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn"%>

<div>

    <c:set var="sc" > <%=request.getAttribute("currentCatId")%></c:set>
   <c:if test="${categoryList != null}" >
        <c:forEach items="${categoryList}" var="cat">
            <c:if test="${cat.id == sc}" >
                <div id="sortBar" style="text-align:left;color:#ffffff;width:730px;float:left;height:30px;padding-top:10px;font-size:12px;background:url(bbsimages/sortBy.jpg) no-repeat;">&nbsp;&nbsp;Current Offers in - <c:out value="${cat.name}" escapeXml="false" /></div>
            </c:if>
        </c:forEach>

    </c:if>
    <br/><br/>

    <c:if test="${offers != null}" >
        <c:forEach items="${offers}" var="offers">

            <div class="adt"><div class="adb"><div class="adl"><div class="adr"><div class="adbl"><div class="adbr"><div class="adtl"><div class="adtr">
                                            <div  style="height:95px;width:740px" >
                                                <div class="rb" style="float:left;width:85px;height:85px;padding-top:12px" align="center" >
                                                    <a title="Ad Image" class="imglink" style=""   >
                                                        <img src="resourceGetter?imf=<c:out value='${offers.img1}' />" style="width:75px;height:75px;margin:3px;border:none" />


                                                    </a>
                                                </div>
                                                <div class="rb" style="float:left;height:95px;width:530px;overflow:hidden">
                                                    <div class="fv12bc" style="text-align:left;float:left;padding-left:3px;width:377px;padding-top:5px">
                                                        <a title="<c:out value="${offers.scrTitle}" />" class="link" style="font-size:11px;color:#046DBE"  href="spoffer.do?sid=${offers.sid}"  >
                                                            <c:out value="${offers.scrTitle}" />
                                                        </a>
                                                    </div>
                                                    <div class="fv11b" style="float:left;text-align:right;width:148px;padding-right:2px;padding-top:5px"><b>
                                                            <a title="More Details" class="link" style="font-size:11px;color:#222222" href="spoffer.do?sid=${offers.sid}">More Details...
                                                            </a>
                                                        </b>
                                                    </div>
                                                    <div class="fv11" style="height:55px;width:524px;padding-right:3px;float:left;text-align:left;padding-left:3px;padding-top:6px;overflow:hidden">

                                                        <c:if test="${fn:length(offers.desc) <= 200 }" >
                                                            <c:out value="${offers.desc}" />
                                                        </c:if>
                                                        <c:if test="${fn:length(offers.desc) > 200 }" >
                                                            <c:out value="${fn:substring(offers.desc,0,200)}" />&nbsp;&nbsp;<a title="More Details" href="spoffer.do?sid=${offers.sid}" ><span style="color:#046dbe">More...</span></a>
                                                        </c:if>

                                                    </div>
                                                    <div class="fv11" style="padding-left:3px;float:left;width:177px;text-align:left;padding-bottom:5px">
                                                    </div>
                                                    <div class="fv11" style="float:left;width:350px;text-align:right;padding-bottom:5px">

                                                    </div>
                                                </div>
                                                <div  style="float:left;width:105px;height:95px;" align="right">
                                                    <img src="resourceGetter?imf=<c:out value='${offers.logo}' />"  width="95px" height="60px" style="padding-left:12px;padding-top:19.5px;padding-bottom:15.5px" />
                                                </div>
                                            </div></div></div></div></div></div></div></div></div>

            <div id="smsdiv" style="width:740px;background-color:#4D9EDF;height:18px;float:left;margin-top:-2px;">&nbsp; </div>


            <br> <div style="height:8px;_margin-top:-12px;"></div>
        </c:forEach>
    </c:if>
</div>