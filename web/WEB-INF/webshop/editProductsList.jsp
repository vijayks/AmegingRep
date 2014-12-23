<%--
    Document   : editProductsList
    Created on : Mar 15, 2010, 2:14:30 PM
    Author     : Madhuri
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<c:if test="${sucMsg!=null}">
    <center><span style="color:green;font-size:12px;padding-top:20px;"><b>${sucMsg}</b></span></center>
</c:if>
<c:if test="${failMsg!=null}">
    <center><span style="color:red;font-size:12px;padding-top:20px;"><b>${failMsg}</b></span></center>
</c:if>
<div class="verdana_form_postAd" style="width:700px;margin-left:50px;margin-top:40px">
   <c:if test="${fn:length(prodList)=='0'}">
       <center><span style="font-size:14px;color:red;"><b>No products created.</b></span></center>
   </c:if>

  <c:if test="${fn:length(prodList)!='0'}">
      <span style="font-size:15px"><b>List of Products</b></span><br/><br/>
    <table style="width:100%">
    <c:set var="i" value='1'/>
        <c:forEach items="${prodList}" var="pl">

    <tr><td>${i}</td>
        <td style="">${pl.name}</td>
        <td style="width:40px"><a title="Edit" href="edtProd.do?nm=${pl.name}&prodId=${pl.prodId}&et=et"><img src="bbsimages/buttons/edit.png" border="0" width="120px"/></a></td>
        <td style=""><a title="Edit" href="edtProd.do?nm=${pl.name}&prodId=${pl.prodId}&del=del"><img src="bbsimages/buttons/Delete.png" border="0" width="120px"/></a></td>
    </tr>
        <c:set var="i" value="${i+1}"/>
    </c:forEach>
</c:if>
</table>
</div>