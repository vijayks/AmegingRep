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

<div style="width:100%;float:left;height:auto;font-size:12px" >
    <div  style="margin:20px" >
        <c:if test="${prodList!=null}">
            <c:set var="tp" value="1"/>
            <c:forEach begin="1" end="3">
            <div style="border-bottom:1px dashed #4D9EDF;width:100%;margin-bottom:15px;color:black;padding-bottom:10px;">
                <c:if test="${tp==1}"><div style="width:150px;font-size:16px;padding-right:420px;float:left">What's New !</div><a href="getWCT.do?lT=new" style="color:#4D9EDF">More</a><br/></c:if>
                <c:if test="${tp==2}"><div style="width:150px;font-size:16px;padding-right:420px;float:left">Latest Offers</div><a href="getWCT.do?lT=spl" style="color:#4D9EDF">More</a><br/></c:if>
                <c:if test="${tp==3}"><div style="width:150px;font-size:16px;padding-right:420px;float:left">Top Sellers</div><a href="getWCT.do?lT=tnl" style="color:#4D9EDF">More</a><br/></c:if>
            </div>
            <c:set var="i" value="1"/>
            <c:forEach items="${prodList}" var="al">

               <c:if test="${al.type==tp&&i<=3&&al.status==1}">
                <div style="width:188px;float:left;height:300px;padding:0 5px 15px;background:transparent url(bbsimages/box_sep.gif) no-repeat scroll right top">
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
                </div><c:set var="i" value="${i+1}"/>
                </c:if>
            </c:forEach><div style="clear:both"></div><c:set var="tp" value="${tp+1}"/>
            </c:forEach>
        </c:if>
    </div>
</div>