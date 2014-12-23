<%--
    Document   : relatedClfAds
    Created on : Jun 30, 2011, 5:13:14 PM
    Author     : bbsadmin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="com.buysell.util.URlUtil" %>

<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>

<%@taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

  <link href="css/New/bharth.css" type="text/css" rel="stylesheet" />

      <c:set var="reqAdId"><%= request.getParameter("adId")%></c:set>
        <logic:present name="latestAdResultsBean" property="results">
            <c:if test="${fn:length(latestAdResultsBean.results)>0}">
                <c:set var="emptyads" value="true"/>
                <div class="car_border_rel_1" id="relatedClfAds" >
                    <div class="car_top_border"></div>
                    <div class="car_middel_border">
                        <logic:iterate id="result"  name="latestAdResultsBean" property="results">
                            <c:set var="adDesc" value="${result.title}" scope="request"/>
                            <c:set var="urlAdId" scope="request"><bean:write name="result" property="adId"  /></c:set>
                            <c:set var="urlCatId" scope="request"><bean:write name="result" property="catId"  /></c:set>
                            <c:if test="${reqAdId != urlAdId}">
                                <c:set var="emptyads" value="false"/>
                                <div class="car_img_border">
                                    <div class="car_img_bg">
                                        <div class="car_img_1">
                                            <a>
                                                <c:set var="adimg"><bean:write name="result"  property="image1" /></c:set>
                                                <c:if test='${adimg != "" && adimg != "null" }'>
                                                    <img src="resourceGetter?imf=<bean:write name="result"  property="image1" />" width="150px" height="95px" border="0" alt="${result.title}" />
                                                </c:if>
                                                <c:if test='${adimg == "" || adimg == "null"}'>
                                                    <img src="bbsimages/No_Image.png" width="150px" height="95px" border="0" alt="No Image" />
                                                </c:if>
                                            </a>

                                            <% String url="";
                                                String uAdId="";
                                                String uCatId="";
                                                url=(String)request.getAttribute("adDesc");
                                                uAdId=(String)request.getAttribute("urlAdId");
                                                uCatId=(String)request.getAttribute("urlCatId");
                                                if(url!=null)
                                                url=URlUtil.getUrlString(url,uAdId,uCatId);
                                                else
                                                    url=".htm";
                                                url=url.replaceAll("\\<?","");
                                                url=url.replaceAll("'","");
                                                    String urlfull=url;
                                            %>
                                        </div>
                                    </div>
                                    <div class="rel_txt">
                                        <a class="rel_txt" href="bs/<%=urlfull%>" title="${result.title}" target="_top" style="text-decoration:none">
                                            <c:if test="${fn:length(result.title) <= 45 }">
                                                <c:out value="${result.title}" />
                                            </c:if>
                                            <c:if test="${fn:length(result.title) > 45 }">
                                                <c:out value="${fn:substring(result.title,0,40)}"  />
                                            </c:if>
                                        </a> <br />
                                        <c:if test="${result.min !='0.0' && result.max !='0.0'}">
                                            <strong style="color:#ff8028;"> RS. ${result.min} - ${result.max} </strong> ONLY
                                        </c:if>
                                        <c:if test="${result.rentMonth !='0'}">
                                            <strong style="color:#ff8028;"> RS. ${result.rentMonth}</strong> ONLY
                                        </c:if>
                                        <c:if test="${result.price !='0.0'}">
                                            <strong style="color:#ff8028;"> RS.${result.price} </strong> ONLY
                                        </c:if>
                                        <c:if test="${result.price =='0.0'&& result.min =='0.0'&& result.max =='0.0'&& result.rentMonth =='0'}">
                                            <strong style="color:#ff8028;">Contact For Price</strong>
                                        </c:if>
                                    </div>

                                </div>
                            </c:if>
                        </logic:iterate>
                        <div style="clear:both"></div>
                    </div>
                    <div class="car_bottom_border" style="margin:0 0 20px 0;"></div>
                </div>
                <c:if test="${emptyads}"><script type="text/javascript">document.getElementById("relatedClfAds").style.display='none';</script></c:if>
            </c:if>
        </logic:present>
 