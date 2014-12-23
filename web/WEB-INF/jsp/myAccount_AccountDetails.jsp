<%--
    Document   : myAccount_AccountDetails
    Created on : Dec 10, 2009, 5:05:24 PM
    Author     : bbsadmin
--%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<style type="text/css">
    <!--
    #linkDiv {
        float:left;
        padding-left:10px;
        width:180px;
        height:25px;
        text-align:left;
    }
    #MyAccount
    {
        margin:10px 0 10px 15px;
        font-weight:200;
    }
    #editMyProfilet input[type=text]
    {
        width:250px;

    }
    #editMyProfilet a
    {
        text-decoration:none;
        font-size:12px;
        color:#046dbe;

    }
    #editMyProfilet a:hover
    {
        text-decoration:underline;
        font-size:12px;
        color:#046dbe;

    }
    #editMyProfilet select
    {
        width:253px;

    }



    -->
</style>



<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<div style="width:730px;">
    <div style="padding-top:15px; padding-bottom:10px;padding-left:10px"  class="verdana_form_mainhead"><b>My Account Details</b></div>
    <div class="fv12" id="bv_Table1" style="width:710px;z-index:4;" >

            <table width="100%"  border="1" cellpadding="1" cellspacing="1" id="Table1">
                <tr>
                    <td class="fv12bw" align="center" valign="middle" bgcolor="#4D9EDF" width="150" height="48"></td>
                    <td class="fv12bw" align="center" valign="middle" bgcolor="#4D9EDF" width="84" height="48">SMS</td>
                    <td class="fv12bw" align="center" valign="middle" bgcolor="#4D9EDF" width="84" height="48">Normal Offers</td>
                    <td class="fv12bw" align="center" valign="middle" bgcolor="#4D9EDF" width="84" height="48">Special Offers</td>
                    <td class="fv12bw" align="center" valign="middle" bgcolor="#4D9EDF" width="84" height="48">Normal Ads</td>
                    <td class="fv12bw" align="center" valign="middle" bgcolor="#4D9EDF" width="84" height="48">Special Ads</td>
                </tr>
                <tr>
                    <td  class="fv12bw" align="center" valign="middle" bgcolor="#4D9EDF" width="150" height="48">Allocated</td>

                    <td align="center" valign="middle" width="84" height="48"><a href="specificAdsAction.do?status=1"><%=request.getAttribute("alSMS")%></a></td>
                    <td align="center" valign="middle" width="84" height="48"><a href="specificAdsAction.do?status=2"></a></td>
                    <td align="center" valign="middle" width="84" height="48"><a href="specificAdsAction.do?status=4"></a></td>
                    <td align="center" valign="middle" width="84" height="48"><a href="#"></a><%=request.getAttribute("alAds")%></td>
                    <td align="center" valign="middle" width="84" height="48"><a href="specificAdsAction.do?status=5"></a></td>

                </tr>
                <tr>
                    <td  class="fv12bw" align="center" valign="middle" bgcolor="#4D9EDF" width="150" height="48">Used</td>
                    <td align="center" valign="middle" width="84" height="48"></td>
                    <td align="center" valign="middle" width="84" height="48"></td>
                    <td align="center" valign="middle" width="84" height="48"></td>
                    <td align="center" valign="middle" width="84" height="48"><%=request.getAttribute("usedAds")%></td>
                    <td align="center" valign="middle" width="84" height="48"></td>
                </tr>
            </table>
    </div>
</div>
--%>

<%--String comp_name;
    String logoPath;
    String account_typ;
    String num_Ads;
    String num_Offers;
    String num_SMS;--%>

<div style="width:50%;height:15px;"> </div>
<div id="masterrightbodybg" style="width:720px">
    <div class="pt"><div class="pb"><div class="pl"><div class="pr"><div class="pbl"><div class="pbr"><div class="ptl">
                                <div class="ptr">
                                    <div class="verdana_form_mainhead" style="width:auto;padding:20px 0 0 15px">My Account Details</div>
                                    <%--<c:forEach items="dealBean" var="DB">--%>
                                    <c:if test="${dealBean!=null}">
                                        <table id="MyAccount" cellpadding="2px" class="verdana_form" style="width:650px;margin-left:80px" >
                                            <tr>
                                                <td style="width:20%">Company Name </td> <td>:&nbsp;&nbsp;${dealBean.comp_name}</td>
                                                <td></td>
                                            </tr>
                                            <tr>
                                                <td>Logo </td> <%--<td>${dealBean.logoPath}</td>--%> <td>:&nbsp;&nbsp;<img src="resourceGetter?imf=${dealBean.logoPath}" alt="company Logo"></td>
                                                <td></td>
                                            </tr>

                                            <tr>
                                                <td>Account Type</td> <td>:&nbsp;&nbsp;${dealBean.dlrType}</td>
                                                <td></td>
                                            </tr>
                                            <tr>
                                                <td>Number Of Ads</td> <td>:&nbsp;&nbsp;${dealBean.noAds}</td>
                                                <td></td>
                                            </tr>
                                            <tr>
                                                <td>Number of Offers</td> <td>:&nbsp;&nbsp;${dealBean.noOffers}</td>
                                                <td></td>
                                            </tr>
                                            <tr>
                                                <td>Number of SMS</td>  <td>:&nbsp;&nbsp;${dealBean.noSms}</td>
                                                <td></td>
                                            </tr>
                                            <tr>
                                                <td>First Name :</td>  <td>:&nbsp;&nbsp;${dealBean.firstName}</td>
                                                <td></td>
                                            </tr>
                                            <tr>
                                                <td>Last Name: </td> <td>:&nbsp;&nbsp;${dealBean.lastName}</td>
                                                <td></td>
                                            </tr>
                                            <%-- <tr>
                                                <td>Occupation :</td>
                                                <td>:&nbsp;&nbsp;${dealBean.OCCUPATION}</td>
                                                <td></td>
                                            </tr>
                                             <tr>
                                                <td>Gender</td>
                                                <td>:&nbsp;&nbsp;${dealBean.GENDER}</td>
                                                <td></td>
                                            </tr>--%>
                                            <tr>
                                                <td>Phone :</td>  <td>:&nbsp;&nbsp;${dealBean.mobile}</td>
                                                <td></td>
                                            </tr>
                                            <tr>
                                                <td>URL</td> <td>:&nbsp;&nbsp;${dealBean.wsUrl}</td>
                                                <td></td>
                                            </tr>
                                            <tr>
                                                <td>Locality :</td> <td>:&nbsp;&nbsp;${dealBean.locality}</td>
                                                <td></td>
                                            </tr>
                                            <tr>
                                                <td>Area :</td> <td>:&nbsp;&nbsp;${dealBean.address}</td>
                                                <td></td>
                                            </tr>
                                            <tr>
                                                <td>City :</td> <td>:&nbsp;&nbsp;${dealBean.city}</td>
                                                <td></td>
                                            </tr>
                                            <%--<tr>
                                                <td>State :</td>
                                                <td>:&nbsp;&nbsp;${dealBean.state}</td>
                                                <td></td>
                                            </tr>
                                            <tr>
                                                <td>Country :</td>
                                                <td>:&nbsp;&nbsp;${dealBean.country}</td>
                                                <td></td>
                                            </tr>--%>
                                        </table>
                                    </c:if>
                                    <br/>
                                    <%--</c:forEach>--%>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

</div>