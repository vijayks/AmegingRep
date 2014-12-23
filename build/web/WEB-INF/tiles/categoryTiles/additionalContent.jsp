<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>

<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>

<div id="addCont" class="tilepad"  >
    <div class="blueHeader">
        <div style="float:left;padding-top:6px;">Additional Content</div><div id="addContMinMax" style="float:right;font-size:20px;cursor:pointer" onclick="hideTables('addCont');">(&nbsp;&ndash;&nbsp;)</div>
    </div>

    <logic:present name="editAdForUpdateBean" >
        <%@page  import="com.buysell.beans.AdsBean" %>
        <% AdsBean ab=(AdsBean)request.getAttribute("editAdForUpdateBean"); %>
        <table class="verdana_form_postAd" align="left" cellspacing="10px">
            <tr>
                <td valign="top"> Additional Content </td>
                <td>
                    <textarea rows="6" name="additionalContent" cols="28" ><%= ab.getAddtionalContent() %></textarea><br/><font color="#FF4545">Please don't give your email & mobile number here.</font>
                </td>
            </tr>
            <tr><td style="padding-bottom:5px"></td></tr>
        </table>
    </logic:present>
    <logic:notPresent name="editAdForUpdateBean" >


        <table class="verdana_form_postAd" align="left" cellspacing="10px">
            <tr> <td valign="top"> Additional Content</td>
                <td>
                    <textarea rows="6" name="additionalContent" cols="28" style="width:450px;"></textarea><br/><font color="#FF4545">Please don't give your email & mobile number here.</font>
                </td>
            </tr>
            <tr><td style="padding-bottom:5px"></td></tr>
        </table>
    </logic:notPresent>
</div>
<div class="line" ></div>