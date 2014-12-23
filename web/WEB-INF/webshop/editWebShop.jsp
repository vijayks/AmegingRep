<%--
    Document   : EditWebShop
    Created on : Mar 12, 2010, 7:34:56 PM
    Author     : bbsadmin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<div class="verdana_form_postAd" style="width:700px;margin-left:50px;margin-top:40px">
    <c:if test="${wsMsg!=null}">
        <center><span style="color:green">${wsMsg}</span></center>
    </c:if>
    <c:if test="${wsMsgF!=null}">
        <center><span style="color:red">${wsMsgF}</span></center>
    </c:if>
    <c:if test="${fn:length(webshopList)==0}">
        <center><span style="font-size:14px;color:red"><b> No webshop is created .</b></span></center>
    </c:if>

    <c:if test="${(webshopList!=null) && fn:length(webshopList)!=0}">
        <table style="width:100%"><span style="font-size:15px"><b>List of WebShops   </b></span><br/><br/>
            <c:set var="i" value='1'/>
            <c:forEach items="${webshopList}" var="wl">
                <tr><td>${i}</td>
                    <td style="width:250px">${wl.name}</td>
                    <td style="width:80px"><a title="Edit" href="edtWs.do?nm=${wl.name}&wsId=${wl.id}"><img src="bbsimages/buttons/EditWebshop.png" border="0" width="120px"/></a></td>
                    <td style="width:80px"><a title="Define" href="defineWebshop.do?wi=${wl.id}&wn=${wl.name}&ws=${wl.status}"><img src="bbsimages/buttons/DefineWebshop.png" border="0" width="120px"/></a></td>
                    <td style="width:180px"><a title="Delete" href="updateWS.do?del=del&wbId=${wl.id}"><img src="bbsimages/buttons/Delete.png" border="0" width="100px" height="27px"/></a></td></tr>
                            <c:set var="i" value="${i+1}"/>
                        </c:forEach>
                    </c:if>
    </table>
</div>
