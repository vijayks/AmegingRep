<%--
    Document   : myOffersDetails
    Created on : Dec 22, 2009, 4:44:14 PM
    Author     : bbsadmin--%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@page import="com.buysell.beans.UserBean" %>
<%@page import="com.buysell.beans.MyAdDetailsBean" %>
<link href="images/lytebox/fbox.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="images/lytebox/fbox_conf.js"></script>
<script type="text/javascript" src="images/lytebox/fbox_engine.js"></script>
<script type="text/javascript" src="images/lytebox/fbox_engine-min.js"></script>



<%
MyAdDetailsBean madb = (MyAdDetailsBean) request.getSession().getAttribute("myOfferDetailsBean");
%>
<div style="clear:both;"></div>



<div style="width:730px;">
    <div style="padding-top:15px; padding-bottom:10px;padding-left:10px"  class="verdana_form_mainhead"><b>My Offer Details</b></div>
    <div class="fv12" id="bv_Table1" style="width:710px;height:150px;z-index:4;" >
        <table width="100%"  border="1" cellpadding="1" cellspacing="1" id="Table1">
            <tr>
                <td class="fv12bw" align="center" valign="middle" bgcolor="#4D9EDF" width="150" height="48">Type Of Offer</td>
                <td class="fv12bw" align="center" valign="middle" bgcolor="#4D9EDF" width="84" height="48">Active</td>
                <td class="fv12bw" align="center" valign="middle" bgcolor="#4D9EDF" width="84" height="48">On Hold</td>
                <td class="fv12bw" align="center" valign="middle" bgcolor="#4D9EDF" width="84" height="48">Expired</td>
                <td class="fv12bw" align="center" valign="middle" bgcolor="#4D9EDF" width="84" height="48">Incomplete</td>
                <td class="fv12bw" align="center" valign="middle" bgcolor="#4D9EDF" width="84" height="48">Deleted</td>
                <td class="fv12bw" align="center" valign="middle" bgcolor="#4D9EDF" width="99" height="48">Balance</td>
            </tr>
            <tr>
                <td  class="fv12bw" align="center" valign="middle" bgcolor="#4D9EDF" width="150" height="48">Normal Offers</td>

                <td align="center" valign="middle" width="84" height="48"><a title="View Active Offers" href="requestOffers.do?st=1"><%= madb.getActive()%></a></td>
                <td align="center" valign="middle" width="84" height="48"><a title="View OnHold Offers" href="requestOffers.do?st=2"><%= madb.getOnHold()%></a></td>
                <td align="center" valign="middle" width="84" height="48"><a title="View Expired Offers" href="requestOffers.do?st=4"><%= madb.getExpired()%></a></td>
                <td align="center" valign="middle" width="84" height="48"><a title="View Incomplete Offers" href="#">0</a></td>
                <td align="center" valign="middle" width="84" height="48"><a title="View Deleted Offers" href="requestOffers.do?st=5"><%= madb.getDeleted()%></a></td>
                <td align="center" valign="middle" width="99" height="48"><%= madb.getBalanceAds()%></td>

            </tr>
            <tr>
                <td  class="fv12bw" align="center" valign="middle" bgcolor="#4D9EDF" width="150" height="48">Special Offers</td>
                <td align="center" valign="middle" width="84" height="48">0</td>
                <td align="center" valign="middle" width="84" height="48">0</td>
                <td align="center" valign="middle" width="84" height="48">0</td>
                <td align="center" valign="middle" width="84" height="48">0</td>
                <td align="center" valign="middle" width="84" height="48">0</td>
                <td align="center" valign="middle" width="99" height="48">0</td>
            </tr>
        </table>
    </div>
    <br /><br><br><br>
</div>


  