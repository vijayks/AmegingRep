<%--
    Document   : whatsNewOffer
    Created on : Mar 22, 2010, 11:53:31 AM
    Author     : madhuri
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<div style="width:100%;float:left;height:auto;min-height:810px;font-size:12px;" >
    <div style="margin:20px;">
          <%
          if(request.getParameter("lT").equals("new")){
          %>
          <div style="background:transparent url(bbsimages/whats_new.jpg) scroll 0 0 ;height:105px; width:574px;color:#FFFFFF;margin:0 auto"><span style="font-size:18px;margin:25px;">Whats New!!</span></div>
          <c:set var="tp" value="1"/>
          <%
          }
          if(request.getParameter("lT").equals("spl")){
          %>
           <div style="background:transparent url(bbsimages/latest_offers.jpg) scroll 0 0 ; width:574px;height:105px;color:#FFFFFF;margin:0 auto"><span style="margin:25px;font-size:18px">Special Offers</span></div>
          <c:set var="tp" value="2"/>
          <%
          }
           if(request.getParameter("lT").equals("tnl")){
          %>
           <div style="background:transparent url(bbsimages/best_sellers.jpg) scroll 0 0 ; width:574px;height:105px;color:#FFFFFF;margin:0 auto"><span style="margin:25px;font-size:18px">Top Sellers</span></div>
          <c:set var="tp" value="3"/>
          <%
          }%>
          <br/><br/>

        <c:if test="${prodList!=null}">
            <c:set var="i" value="1"/>
            <c:forEach items="${prodList}" var="al">

               <c:if test="${al.type==tp}">
                <div style="width:188px;float:left;height:300px;padding:0 5px 15px;">
                    <div align="center"><a href="newProdDet.do?prodId=${al.prodId}"><img src="resourceGetter?imd=${dealerWebsite.path}${fn:split(al.imageLocation,'|')[0]}" width="130px" height="130px"  border="0"></a></div>
                    <h2 style="margin:0 2px 6px 0"><a href="newProdDet.do?prodId=${al.prodId}" style="color:#4D9EDF;font-size:13px"><b> ${al.name}</b></a></h2>
                        <p style="font-size:10px;margin:7px 0 0;color:#000"> ${al.modelId}</p>
                        <a href="newProdDet.do?prodId=${al.prodId}" style="color:#4D9EDF;font-size:11px;margin-bottom:10px">More...</a>
                        <p style="margin-top:17px;font-weight:bold">
                            <span style="font-size:14px;color:#999999;">
                                <c:if test="${al.offerPrice!=0}">${al.currency} ${al.offerPrice} inc. VAT<br/></c:if>
                                <c:if test="${al.offerPrice==0 && al.discount!=0 && al.actualPrice!=0}">${al.currency} ${al.actualPrice-al.discount} inc. VAT<br/></c:if>
                            </span>
                            <c:if test="${al.actualPrice!=0}">
                                <span style="color:#FA6C30;font-size:12px;">
                                    <c:choose>
                                        <c:when test="${al.offerPrice!=0 || al.discount!=0}">
                                            <strike style="font-weight:normal">${al.currency} <span style="font-size:14px">${al.actualPrice}</span> inc. VAT</strike>
                                        </c:when>
                                        <c:otherwise>
                                            ${al.currency} ${al.actualPrice} inc. VAT
                                        </c:otherwise>
                                    </c:choose>
                                </span><br/>
                            </c:if>
                        </p>
                        <p style="margin-top:7px;font-size:10px;color:#000"> ${al.stockStatus}</p>
                </div><img style="float:left;margin:0px;" src="bbsimages/box_sep.gif" alt="nm"/><c:if test="${(i%3)==0}"><br/></c:if><c:set var="i" value="${i+1}"/>
                </c:if>
            </c:forEach>
        </c:if>
                </div>
</div>