<%--
    Document   : myAccount_RespDtls
    Created on : Aug 25, 2012, 6:18:08 PM
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
<script type="text/javascript">
    function SrchBySelected(itemId)
    {
        var dropdownIndex = document.getElementById(itemId).selectedIndex;
        var dropdownValue = document.getElementById(itemId)[dropdownIndex].value;
        document.location.href=dropdownValue;
    }


    function SubmitMnthForm(srchMnth)
    {
        var srchMnth = document.srchMnth;
        var month = srchMnth.month.value;
        document.forms['srchMnth'].submit() ;
    }
    function SubmitSrchBy(SrchBy)
    {
        var SrchBy = document.SrchBy;
        var SrchBy = SrchBy.SrchBy.value;
        document.forms['SrchBy'].submit() ;
    }
    
</script>
<style type="text/css">
    .vrfdDrsc{width:auto; height:auto; float:left;font-family:Arial, Helvetica, sans-serif; font-size:11px;color:#046DBE;font-weight:bold;}
</style>
<c:if test="${resps != null}">
    <div class="manage_response_part_right" style="margin-top:15px;margin-left:10px; ">
        <div class="manage_response_right_txt_heading">
            <h1 style="font-size: 20px">Manage Response</h1>
<c:if test="${success != null}" >
    <br>
    <span class="fv10" style="color:red;"><c:out value="${success}" /></span>
    <br>
</c:if>
            <p style="margin-top:30px;">
                <c:if test="${fn:length(resps) >0}">Total Response - ${fn:length(resps)}<br/>
                    Auto Response - ${fn:length(resps)}
                </c:if>
            </p>
            <form action="resp_dtl.do" name="SrchBy" >
                <h2>Sort by &nbsp;&nbsp;&nbsp;
                    <select   style="width:127px;" name="SrchBy" id="SrchBy" onchange="return SubmitSrchBy(this)">
                        <option value="lst"  >Latest First</option> <option value="old" >Older First</option>
                    </select>
                </h2>
            </form>
            <p style="float:right "><c:if test="${totalResponses >= 10}">Total Ads Response - ${totalResponses}<br/></c:if>
                <c:if test="${totalMicrositeCount > 0}"> Total Microsite Response - ${totalMicrositeCount}<br/></c:if>
                </p>
            </div>
            <form action="resp_dtl.do" name="srchMnth" >
                <div class="manage_response_right_txt_please">
                    <p>Please View Your Response Statement of Account</p>
                    <h3>
                        <select name="month" id="month" style="width:127px;" tabindex="2">
                            <option selected="selected" value="" >Select Month</option>
                            <option value="01">January</option><option value="02">February</option><option value="03">March</option> <option value="04">April</option> <option value="05">May</option> <option value="06">June</option> <option value="07">July</option> <option value="08">August</option> <option value="09">September</option> <option value="10">October</option> <option value="11">November</option> <option value="12">December</option>
                        </select>
                    </h3>
                    <div class="manage_response_right_open"><a onclick="return SubmitMnthForm(this)"></a></div>
                </div>
            </form>
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
                    <c:if test="${fn:length(resps) == 0}"><center><br/><span style="font-size:14px;color:red;width:720px;">No Data Found Under Requested Criteria.</span></center></c:if>
                        <c:if test="${fn:length(resps) > 0}">
                            <c:set var="sno" value="1"/>
                            <c:forEach items="${resps}" var="resp" >
                            <div id="accordion3"  style="position:relative;">
                                <dl class="accordion3" id="slider${resp.respId}">
                                    <dt id="dtlBtn2"><span>
                                            <table width="692" border="0" cellspacing="0" cellpadding="0" style="float:left; ">
                                                <tr>
                                                    <td align="center" valign="middle" width="43" class="manage_response_right_tab_txt2">${sno} </td>
                                                    <c:set var="name" scope="request">${resp.userName}</c:set>   
                                                    <% 
                                                    String name = (String) request.getAttribute("name");
                                                    int len=name.length(); 
                                                    if(len>=4 && name.substring(len-4,len).equalsIgnoreCase("null"))
                                                    {
                                                       name= name.replace((name.substring(len-4,len)),"");   
                                                    }
                                                    %>
                                                    <td align="center" valign="middle" width="219" class="manage_response_right_tab_txt2" ><c:out value="<%= name %>"/></td>
                                                    <td align="center" valign="middle" width="129" class="manage_response_right_tab_txt2"><c:out value="${resp.contact}"/></td>
                                                    <td align="center" valign="middle" width="84" class="manage_response_right_tab_txt2"><c:out value="${resp.responseDate}"/></td>
                                                    <td align="center" valign="middle" width="88" class="manage_response_right_tab_txt2"><c:if test="${resp.responseType=='AD'}">Auto </c:if> <c:if test="${resp.responseType=='VRFD'}"> Verified</c:if> </td>
                                                    <td align="center" valign="middle" width="127" class="manage_response_right_tab_txt2" style="border-right:1px solid #cccccc;"><a id="${resp.respId}dtlBtn" style="cursor: pointer" title="View Response">Details </a><a href="resp_dtl.do?respId=<c:out value='${resp.respId}'/>"><img src="bbsimages/New/inner_delete_img.jpg" title="Delete Response" width="10" height="10" border="0" style="padding-left:12px;" /></a></td>
                                                </tr>
                                            </table>
                                        </span></dt>
                                    <dd>
                                        <div class="manage_response_right_detals_txt">
                                            <p><b><c:out value="<%= name %>"/></b><br />
                                                <c:out value="${resp.email}"/><br />
                                                <b><c:out value="${resp.contact}"/></b>
                                            </p>
                                            <span style="width:150px ">Auto Response<br /> On: <c:out value="${resp.responseDate}"/></span>
                                            <h1 style="width:150px"><a style="cursor: pointer;color:#FF9900" onclick="$('#${resp.respId}dtlBtn').click();" title="Close">Close</a><a href="resp_dtl.do?respId=<c:out value='${resp.respId}'/>" title="Delete">Delete</a></h1>
                                            <c:if test="${resp.responseType=='AD'}">
                                                <c:set var="urlAdId" scope="request">${resp.relatedId}</c:set>
                                                <c:set var="urlCatId" scope="request">${resp.adCatId}</c:set>
                                                <c:set var="urlAdTitle" scope="request">${resp.adTitle}</c:set>
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
                                                    AD Title -  <a class="link" style="font-size:11px;color:#046DBE"  href="<%=urlfull%>" title="${resp.adTitle}" target="blank"><strong>${resp.adTitle}</strong></a>
                                                </div>
                                            </c:if>
                                            <c:if test="${resp.responseType=='VRFD'}">
                                                <c:set var="urlAdId" scope="request">${resp.relatedId}</c:set>
                                                <c:set var="urlCatId" scope="request">${resp.adCatId}</c:set>
                                                <c:set var="urlAdTitle" scope="request">${resp.adTitle}</c:set>
                                                <div class="manage_response_right_requirment_txt">
                                                    <div style="float: left">Description  - &nbsp;</div>  <div class="vrfdDrsc"><strong>${resp.adTitle}</strong></div>
                                        </div>
                                            </c:if>
                                        </div>
                                    </dd>
                                </dl>
                            </div>
                            <script type="text/javascript">
                                var slider${resp.respId}=new accordion.slider("slider${resp.respId}");
                                (slider${resp.respId}).init("slider${resp.respId}",-1,"open");
                            </script>
                            <c:set var="sno" value="${sno+1}"/>
                        </c:forEach>
                    </c:if>
                </td>
            </tr>
            <tr><td><br/></td></tr>
        </table>
    </div>
    <script type="text/javascript">
        <% if (request.getAttribute("month") != null) {%>
                document.getElementById('month').value='<%= request.getAttribute("month")%>';
        <% }%>
        <% if (request.getAttribute("SrchBy") != null) {%>
            document.getElementById('SrchBy').value='<%= request.getAttribute("SrchBy")%>';
        <% }%>
    </script>
    <script type="text/javascript">
        var slider3=new accordion.slider("slider3");
        slider3.init("slider3",-1,"open");
        var slider4=new accordion.slider("slider4");
        slider4.init("slider4",-1,"open");
    </script>
</c:if><br/>
<%--  <c:if test="${fn:length(resps) != 0}">
     <div style="color:#D55D0C;font-size:14px;float:left;padding-left:20px;">
         <b>  Contact Details Viewed&nbsp; : &nbsp;${fn:length(resps)}</b><br/><br/>
     </div>
 </c:if>
 <c:if test="${totalResponses != 0}">
     <div style="color:#D55D0C;font-size:14px;float:right;padding-right:20px;">
         <b> Total Responses&nbsp; : &nbsp;${totalResponses} </b>  <br/><br/>
     </div>
 </c:if>--%>

