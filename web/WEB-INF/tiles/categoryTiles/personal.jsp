        <%--
    Document   : personal
    Created on : Aug 19, 2009, 11:59:30 PM
    Author     : bbsadmin
--%>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@page  import="com.buysell.beans.AdsBean" %>

<style type="text/css">
    .blueHeader {
        background-color: #DDEEFF;
        border: 1px solid #9CCFEF;
        color: #05446B;
        float: left;
        font-size: 13px;
        height: 30px;
        margin: 2% 0;
        padding: 0 2%;
        width: 96%;
    }
</style>
<c:if test="${editAdForUpdateBean!=null}" >
    <% String type = (String) request.getAttribute("type");
            if (type.equalsIgnoreCase("e")) {%>
    <form name="ad" id="ad" action="upload_update_ad.do" method="post" enctype="multipart/form-data" onsubmit="return postAdForm(this)" >
        <% } else {%>
        <form name="ad" action="upload_renew_ad.do" method="post" enctype="multipart/form-data" onsubmit="return postAdForm(this)" >
            <% }%>
            <% AdsBean ab = (AdsBean) request.getAttribute("editAdForUpdateBean");%>
            <input type="hidden" name="adId" value="<%= ab.getAdId()%>" />
            <input type="hidden" name="catId" value="<%= ab.getCatId()%>" />
            <input type="hidden" name="status" value="<%= ab.getStatus()%>" />
            <input type="hidden" name="userId" value="<%= ab.getUserId()%>" />
            <div  id="general" class="tilepad">
                <div class="blueHeader">
                    <div style="float:left;padding-top:6px;">Personal Details</div><div id="generalMinMax" style="float:right;font-size:20px;cursor:pointer;" onclick="hideTables('general');">(&nbsp;&ndash;&nbsp;)</div>
                </div>
                <table class="verdana_form_postAd" align="left" cellspacing="10px" style="width:100%;table-layout:fixed">
                    <tr>
                        <td> Name </td>
                        <td><input type="text" name="fname" style="width:150px;height:18px" readonly value="${userBean.firstName}" />
                        </td>
                    </tr>
                    <tr><td style="padding-bottom:5px"></td></tr>
                    <tr>
                        <td>Mobile </td>
                        <td><input type="text" name="ph1" readonly style="width:100px;height:18px" value="${userBean.mobile}"/></td>
                    </tr>
                    <tr><td style="padding-bottom:5px"></td></tr>
                    <tr>
                        <td class="textRight">City&nbsp;<font color="#ff0000">*</font></td>
                        <td>
                            <select id="city" name="city" onchange="getLocalities(this)" style="width:120px">
                                <option value="" selected="true"  >Select City</option>
                                <c:if test="${cities  != null }">
                                    <c:forEach items="${cities}" var="city">
                                        <option value="<c:out value='${city.name}'/>"><c:out value="${city.name}"/></option>
                                    </c:forEach>
                                </c:if>
                            </select>
                        </td>
                        <td class="textRight">Locality&nbsp;<font color="#ff0000">*</font></td>
                        <td>
                            <select id="locality" name="locality" style="width:180px;" >
                                <option selected="true" value=""> Select Locality</option>
                                <c:if test="${locationClasses  != null }">
                                    <c:forEach items="${locationClasses}" var="location">
                                        <option value="<c:out value='${location.name}'/>"><c:out value="${location.name}"/></option>
                                    </c:forEach>
                                </c:if>
                            </select>
                        </td>
                    </tr>
                    <tr><td style="padding-bottom:5px"></td></tr>
                    <tr>
                        <td valign="top" class="textRight">Address </td>
                        <td><input type="text" name="address" style="width:400px;height:18px"  value="<%=ab.getAddress()%>" /></td>
                    </tr>
                    <tr><td style="padding-bottom:5px"></td></tr>
                    <tr>
                        <td> Email </td>
                        <td><input type="text" name="email" readonly style="width:250px;height:18px" value="<c:choose><c:when test="${fn:startsWith(userBean.userType,'DEALER')}">${userBean.emailId}</c:when><c:otherwise>${userBean.loginName}</c:otherwise></c:choose>"/></td>
                    </tr>
                    <tr><td style="padding-bottom:5px"></td></tr>
                </table>
                <script type="text/javascript">

                    <% if (ab.getCity() != null) {%>
                        document.getElementById('city').value='<%=ab.getCity()%>';
                    <% }%>

                    <% if (ab.getLocality() != null) {%>
                        document.getElementById('locality').value='<%= ab.getLocality()%>';
                    <% }%>

                </script>
            </c:if>
            <c:if test="${editAdForUpdateBean == null}" >
                <c:set var="reqURI">${fn:substring(reqURI,0,fn:length(reqURI))}</c:set>
                <c:if test="${reqURI == 'createAdMy.do'}" >
                    <form name="ad" id="ad" action="upload_postAd_submit_my.do" method="post" enctype="multipart/form-data" onsubmit="return postAdForm(this)">
                    </c:if>

                    <c:if test="${reqURI == 'createAd.do'}" >

                        <c:if test="${userBean != null}">
                            <form name="ad" id="ad" action="upload_postAd_submit.do" method="post" enctype="multipart/form-data" onsubmit="return postAdForm(this)">
                            </c:if>
                            <c:if test="${userBean == null}">
                                <form id="ad" name="ad" action="postRegister.do" method="post" enctype="multipart/form-data"  onsubmit="return postAdWithRegisterFormSubmit(this)">
                                    <input type="hidden" value="postAdRegistration" name="regFrom"/>
                                </c:if>

                            </c:if>
                            <div  id="general" class="tilepad">
                                <div class="blueHeader">
                                    <div style="float:left;padding-top:6px;">Personal Details</div><div id="generalMinMax" style="float:right;font-size:20px;cursor:pointer;" onclick="hideTables('general');">(&nbsp;&ndash;&nbsp;)</div>
                                </div>

                                <c:if test="${userBean != null}">
                                    <table class="verdana_form_postAd" align="left" cellspacing="10px" style="width:100%;table-layout:fixed">
                                        <tr>
                                            <td> Name </td>
                                            <td><input type="text" name="fname" style="width:150px;height:18px"   <c:if test="${userBean != null}" > readonly value="${userBean.firstName}" </c:if> />
                                            </td>
                                        </tr>
                                        <tr><td style="padding-bottom:5px"></td></tr>
                                        <tr>
                                            <td>Mobile </td>
                                            <td><input type="text" name="ph1"  style="width:100px;height:18px" <c:if test="${userBean != null}" > readonly value="${userBean.mobile}" </c:if> /></td>
                                        </tr>
                                        <tr><td style="padding-bottom:5px"></td></tr>
                                        <tr>
                                            <td class="textRight">City&nbsp;<font color="#ff0000" >*</font></td>
                                            <td>
                                                <select id="city" name="city" onchange="getLocalities(this)"  style="width:120px"z>
                                                    <option value="" selected="true" >Select City</option>
                                                    <c:if test="${cities  != null }">
                                                        <c:forEach items="${cities}" var="city">
                                                            <option value="<c:out value='${city.name}'/>"><c:out value="${city.name}"/></option>
                                                        </c:forEach>
                                                    </c:if>

                                                </select>
                                            </td>

                                            <td style="float:right;padding-top:5px;width:100px;">Locality&nbsp;<font color="#ff0000" >*</font></td>
                                            <td><select id="locality" name="locality"  style="width:180px;">
                                                    <option value="" selected="true"> Select Locality</option>
                                                    <c:if test="${locationClasses  != null }">
                                                        <c:forEach items="${locationClasses}" var="location">
                                                            <option value="<c:out value='${location.name}'/>"><c:out value="${location.name}"/></option>
                                                        </c:forEach>
                                                    </c:if>

                                                </select>
                                            </td>
                                        </tr>
                                        <tr><td style="padding-bottom:5px"></td></tr>
                                        <tr>
                                            <td valign="top" class="textRight">Address </td>
                                            <td><input type="text" name="address" style="width:400px;height:18px" value="<% if (request.getAttribute("addressId") != null) {%><%= (String) request.getAttribute("addressId")%><% }%>"/>
                                            </td>
                                        </tr>
                                        <tr><td style="padding-bottom:5px"></td></tr>
                                        <tr>
                                            <td> Email </td>
                                            <td><input type="text" name="email"  style="width:250px;height:18px" <c:if test="${userBean != null}" > readonly value="<c:choose><c:when test="${fn:startsWith(userBean.userType,'DEALER')}">${userBean.emailId}</c:when><c:otherwise>${userBean.loginName}</c:otherwise></c:choose>" </c:if> /></td>
                                        </tr>
                                        <tr><td style="padding-bottom:5px"></td></tr>
                                    </table>
                                </c:if>

                                <c:if test="${userBean == null}" >
                                    <table class="verdana_form_postAd" align="left" cellspacing="10px" style="width:100%;table-layout:fixed">
                                        <tr>
                                            <td> Name <span style="color:red">*</span> </td>
                                            <td style="width:100%"><input type="text" id="fname" name="fname" style="width:150px;height:18px" onkeypress="return inputLimiter(event,'NameCharacters')" />
                                            </td>
                                        </tr>
                                        <tr><td style="padding-bottom:5px"></td></tr>
                                        <tr>
                                            <td>Mobile <span style="color:red">*</span></td>
                                            <td><input type="text" id="ph1" name="ph1"  style="width:100px;height:18px" onKeyPress="return numbersonly(event, false)"/></td>
                                        </tr>
                                        <tr><td style="padding-bottom:5px"></td></tr>
                                        <tr>
                                            <td class="textRight">City <span style="color:red">*</span></td>
                                            <td style="width:100%">
                                                <select id="city" name="city" onchange="getLocalities(this)" style="width:120px;float:left">
                                                    <option value="" selected="true" >Select City</option>
                                                    <c:if test="${cities  != null }">
                                                        <c:forEach items="${cities}" var="city">
                                                            <option value="<c:out value='${city.name}'/>"><c:out value="${city.name}"/></option>
                                                        </c:forEach>
                                                    </c:if>

                                                </select>
                                                <span style="float:left;text-align:right;width:120px;padding-top:5px;">Locality <span style="color:red">*</span>&nbsp;</span>
                                                <select id="locality" name="locality" style="width:180px;float:left">
                                                    <option selected="true" value=""> Select Locality</option>
                                                    <c:if test="${locationClasses  != null }">
                                                        <c:forEach items="${locationClasses}" var="location">
                                                            <option value="<c:out value='${location.name}'/>"><c:out value="${location.name}"/></option>
                                                        </c:forEach>
                                                    </c:if>

                                                </select>
                                            </td>
                                        </tr>
                                        <tr><td style="padding-bottom:5px"></td></tr>
                                        <tr>
                                            <td valign="top" class="textRight">Address <span style="color:red">*</span> </td>
                                            <td><input type="text" id="address" name="address" style="width:400px;height:18px">
                                            </td>
                                        </tr>
                                        <tr><td style="padding-bottom:5px"></td></tr>
                                        <tr>
                                            <td> Email <span style="color:red">*</span> </td>
                                            <td><input type="text" id="email" name="email"  style="width:250px;height:18px"  onchange="isValidUserId('email');" />
                                                <%-- <span style="font-size:90%;">A valid email address. </span>--%>
                                                <div id="valid" style="display: none;color:green">
                                                    <b>This user Name Available</b>
                                                </div>
                                                <div id="notValid" style="display:none;color:red">
                                                    <b>User name already used</b>
                                                </div>

                                            </td>
                                        </tr>
                                    </table>
                                </c:if>

                            </c:if>

                            <script type="text/javascript">


                                <% if (request.getAttribute("cityId") != null) {%>
                                    document.getElementById('city').value='<%= (String) request.getAttribute("cityId")%>';
                                <% }%>

                                <% if (request.getAttribute("locality") != null) {%>
                                    document.getElementById('locality').value='<%= (String) request.getAttribute("locality")%>';
                                <% }%>

                            </script>

                        </div>
