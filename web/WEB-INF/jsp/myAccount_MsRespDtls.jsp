<%--
    Document   : myAccount_MsRespDtls
    Created on : Oct 13, 2012, 5:42:21 PM
    Author     : KarteeK
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page  import="com.buysell.util.URlUtil"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<style type="text/css">
    .bcgrdblue {
        background: none repeat scroll 0 0 #4D9EDF;
        color: #ffffff;
        font-size: 12px;
        font-weight: bold;
        height: 36px;
        padding-left:15px;
    }
    .txt {
        font-size: 11px;
    }
    greyfill {
        background: none repeat scroll 0 0 #F2F2F2;
    }
    .border {
        border: 1px solid #3399CC;
    }
</style><br/>
<c:if test="${resps != null}">
    <div style="color:#D55D0C;font-size:14px;float:left;padding-left:20px;">

         <b>  Contact Details Viewed&nbsp; : &nbsp;<%--${fn:length(resps)}--%></b><br/><br/>
    </div>
    <div style="color:#D55D0C;font-size:14px;float:right;padding-right:20px;">
        <b> Total Responses&nbsp; : &nbsp;${totalMicrositeCount} </b>  <br/><br/>
    </div>
     <div style="clear:both"></div>
    <div style="width:745px">
        <table  width="100%" cellspacing="1" cellpadding="0" border="1">
            <tr>
               <%-- <td align="left"  class="bcgrdblue"><input type="checkbox" value="1" name="allcheck"></td>--%>
                <td align="left" class="bcgrdblue"><b>S.no</b></td>
                <td align="left" class="bcgrdblue" ><b>Name &amp; Contact Details</b></td>
                <td align="left" class="bcgrdblue" ><b>City</b><br></td>
                <td align="left"  class="bcgrdblue" ><b>Date</b><br></td>
                <td align="center" class="bcgrdblue" ><b>AD Tittle</b></td>
                <%--<td align="left"  class="bcgrdblue"><b>User More ADS</b></td>--%>
                        </tr>
          <%--    <c:set var="sno" value="1"/>
            <c:forEach items="${resps}" var="resp" >
                            <tr>
                    <td align="center"  class="txt"><input type="checkbox" value="1" name="allcheck"></td>
                    <td align="center" class="txt">${sno}</td>
                    <td align="left" class="txt" style="padding-left: 15px;"><b><br/><c:out value="${resp.userName}"/><br><c:out value="${resp.contact}"/><br><c:out value="${resp.email}"/></b><br/><br/></td>
                    <td align="center" class="txt"><c:out value="${resp.city}"/></td>
                    <td align="center"  class="txt"><c:out value="${resp.responseDate}"/></td>

                    <c:if test="${resp.responseType=='AD'}">
                    <c:set var="urlAdId" scope="request">${resp.relatedId}</c:set>
                    <c:set var="urlCatId" scope="request">${resp.adCatId}</c:set>
                    <c:set var="urlAdTitle" scope="request">${resp.adTitle}</c:set>
                     <% String url=(String)request.getAttribute("urlAdTitle");
                        String uAdId=(String)request.getAttribute("urlAdId");
                        String uCatId=(String)request.getAttribute("urlCatId");
                        if(url!=null)
                        url=URlUtil.getUrlString(url,uAdId,uCatId);
                        else
                            url=".htm";
                        url=url.replaceAll("\\<?","");
                        url=url.replaceAll("'","");
                        url=url.replaceAll("\\\\","");
                            String urlfull="bs/"+url;%>

                    <td align="center" class="txt">
                        <a class="link" style="font-size:11px;color:#046DBE"  href="<%=urlfull%>" title="${resp.adTitle}" target="blank">
                                ${resp.adTitle}
                            </a>
                    </td>
                    </c:if>
                    <td align="center"  class="txt"><c:out value="${resp.relatedId}"/></td>
                </tr>
                <c:set var="sno" value="${sno+1}"/>
            </c:forEach>--%>
        </table>
   </div><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
    </c:if>