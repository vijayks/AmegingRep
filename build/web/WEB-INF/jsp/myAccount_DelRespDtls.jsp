<%-- 
    Document   : myAccount_DelRespDtls
    Created on : Mar 15, 2013, 11:21:41 AM
    Author     : Karteek
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page  import="com.buysell.util.URlUtil"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<link href="css/New/SpryAccordion.css" rel="stylesheet" type="text/css">
<script src="js/New/SpryAccordion.js" type="text/javascript"></script>
<script type="text/javascript" src="css/accordion/script2.js"></script>
<style type="text/css">
    .vrfdDrsc{width:auto; height:auto; float:left;font-family:Arial, Helvetica, sans-serif; font-size:11px;color:#046DBE;font-weight:bold;}
</style>
<c:if test="${delResps != null}">
    <div class="manage_response_part_right" style="margin-top:15px;margin-left:10px; ">
        <div class="manage_response_right_txt_heading">
            <h1 style="font-size: 20px">Deleted Response</h1>
            <p style="margin-top:30px;">Total Deleted Response - ${fn:length(delResps)}<br/>
            </p>
        </div>
        <table width="692" border="0" cellspacing="0" cellpadding="0" style="float:left; margin-top:25px; padding-bottom:20px;">
            <tr>
                <td><table width="692" border="0" cellspacing="0" cellpadding="0" style="float:left; background-color:#ddeeff;">
                        <tr>
                            <td align="center" valign="middle" width="43" class="manage_response_right_tab_txt1">Sl No. </td>
                            <td align="center" valign="middle" width="219" class="manage_response_right_tab_txt1">Name</td>
                            <td align="center" valign="middle" width="129" class="manage_response_right_tab_txt1">Mobile</td>
                            <td align="center" valign="middle" width="84" class="manage_response_right_tab_txt1">Date</td>
                            <td align="center" valign="middle" width="88" class="manage_response_right_tab_txt1">Type</td>
                            <td align="center" valign="middle" width="128" class="manage_response_right_tab_txt1">Options</td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    <c:if test="${fn:length(delResps) == 0}"><center><br/><span style="font-size:14px;color:red;width:720px;">No Data Found Under Requested Criteria.</span></center></c:if>
                        <c:if test="${fn:length(delResps) > 0}">
                            <c:set var="sno" value="1"/>
                            <c:forEach items="${delResps}" var="delResps" >
                            <div id="accordion3"  style="position:relative;">
                                <dl class="accordion3" id="slider${sno}">
                                    <dt><span>
                                            <table width="692" border="0" cellspacing="0" cellpadding="0" style="float:left; ">
                                                <tr>
                                                    <td align="center" valign="middle" width="43" class="manage_response_right_tab_txt2">${sno} </td>
                                                    <c:set var="name" scope="request">${delResps.userName}</c:set>  
                                                    <% 
                                                                String name = (String) request.getAttribute("name");
                                                                int len=name.length(); 
                                                                if(len>=4 && name.substring(len-4,len).equalsIgnoreCase("null"))
                                                                {
                                                                    name= name.replace((name.substring(len-4,len)),"");   
                                                                }
                                                    %>
                                                    <td align="center" valign="middle" width="219" class="manage_response_right_tab_txt2"><c:out value="<%= name %>"/></td>
                                                    <td align="center" valign="middle" width="129" class="manage_response_right_tab_txt2"><c:out value="${delResps.contact}"/></td>
                                                    <td align="center" valign="middle" width="84" class="manage_response_right_tab_txt2"><c:out value="${delResps.responseDate}"/></td>
                                                    <td align="center" valign="middle" width="88" class="manage_response_right_tab_txt2"><c:if test="${delResps.responseType=='AD'}">Auto </c:if> <c:if test="${delResps.responseType=='VRFD'}"> Verified</c:if></td>
                                                    <td align="center" valign="middle" width="127" class="manage_response_right_tab_txt2" style="border-right:1px solid #cccccc;"><a style="cursor: pointer" title="View Response">Details </a><a href="resp_dtl.do?respId=<c:out value='${delResps.respId}'/>"></a></td>
                                                </tr>
                                            </table>
                                        </span></dt>
                                    <dd>
                                        <div class="manage_response_right_detals_txt">
                                            <p><b><c:out value="<%= name %>"/></b><br />
                                                <c:out value="${delResps.email}"/><br />
                                                <b><c:out value="${delResps.contact}"/></b>
                                            </p>
                                            <span style="width:150px">Auto Response<br />
                                                On: <c:out value="${delResps.responseDate}"/></span>
                                                <c:if test="${delResps.responseType=='AD'}">
                                                    <c:set var="urlAdId" scope="request">${delResps.relatedId}</c:set>
                                                    <c:set var="urlCatId" scope="request">${delResps.adCatId}</c:set>
                                                    <c:set var="urlAdTitle" scope="request">${delResps.adTitle}</c:set>
                                                    <% String url = (String) request.getAttribute("urlAdTitle");
                                                        String uAdId = (String) request.getAttribute("urlAdId");
                                                        String uCatId = (String) request.getAttribute("urlCatId");
                                                        if (url != null) {
                                                            url = URlUtil.getUrlString(url, uAdId, uCatId);
                                                        } else {
                                                            url = ".htm";
                                                        }
                                                        url = url.replaceAll("\\<?", "");
                                                        url = url.replaceAll("'", "");
                                                                url = url.replaceAll("\\\\", "");
                                                                String urlfull = "bs/" + url;%>
                                                <div class="manage_response_right_requirment_txt">
                                                    AD Title -  <a class="link" style="font-size:11px;color:#046DBE"  href="<%=urlfull%>" title="${delResps.adTitle}" target="blank"><strong>${delResps.adTitle}</strong></a>
                                                </div>
                                            </c:if>
                                            <c:if test="${delResps.responseType=='VRFD'}">
                                                <c:set var="urlAdId" scope="request">${delResps.relatedId}</c:set>
                                                <c:set var="urlCatId" scope="request">${delResps.adCatId}</c:set>
                                                <c:set var="urlAdTitle" scope="request">${delResps.adTitle}</c:set>
                                                    <div class="manage_response_right_requirment_txt">
                                                        <div style="float: left">Description  - &nbsp;</div>  <div class="vrfdDrsc"><strong>${delResps.adTitle}</strong></div>
                                                </div>
                                            </c:if>
                                        </div>
                                    </dd>
                                </dl>
                            </div>
                            <script type="text/javascript">
                                var slider${sno}=new accordion.slider("slider${sno}");
                                (slider${sno}).init("slider${sno}",-1,"open");
                            </script>
                            <c:set var="sno" value="${sno+1}"/>
                        </c:forEach>
                    </c:if>
                </td>
            </tr>
            <tr><td><br/></td></tr>
        </table>
    </div>
</c:if><br/>