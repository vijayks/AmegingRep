<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>

<logic:present name="mySavedAlerts" >
    <bean:size id="size" name="mySavedAlerts" />
    <div style="clear:both;">
        <div style="width:710px;height:5px;"></div>

        <div   style="width:715px;" >
            <div style="padding-bottom:10px;" width="100%" valign="top" class="verdana_form_mainhead"><b>My Saved Alerts</b></div>
            <table width="690" align="center"  border="1" cellpadding="1" cellspacing="1"  >
                <tr class="fv12bw"  >
                    <th width="37" bgcolor="#4D9EDF" height="35" style="text-align:center">Sl No</th>
                    <th width="65" bgcolor="#4D9EDF" height="35" style="text-align:center">Saved On</th>
                    <th width="390" bgcolor="#4D9EDF" height="35" style="text-align:center">Alert Details</th>
                    <th width="65" bgcolor="#4D9EDF" height="35" style="text-align:center">From</th>
                    <th width="65" bgcolor="#4D9EDF" height="35" style="text-align:center">To</th>
                    <th width="70" bgcolor="#4D9EDF" height="35" style="text-align:center">Action</th>
                    <!--<th>SearchUrl</th>-->
                </tr>
        <logic:equal name="size" value="0">

                </table>
                <table width="690" align="center"  height="35" border="1" cellpadding="0" cellspacing="0"  >
                    <tr><td class="fv12bc" align="center"> No alerts are saved </td></tr>
                </table>
            </div>
        </logic:equal>
        <logic:greaterThan name="size" value="0">
            <% int c=1; %>
            <c:forEach items="${mySavedAlerts}" var="myAlerts">

                <tr >
                    <td class="fv11" width="25" height="30"  align="center"><%= c %></td>
                    <td class="fv11" width="60" height="30" align="center" ><c:out value="${myAlerts.alertOn}" /></td>
                    <td  width="390" class="fv11" align="left" height="30" style="padding-left:5px;padding-right:5px;" >

                        <c:if test="${myAlerts.refinePattern != null }" >
                            <c:out value="${myAlerts.refinePattern}" />
                        </c:if>
                    </td >
                    <td class="fv11" width="65" height="30" align="center"><c:out value="${myAlerts.alertFrom}" /></td>
                    <td class="fv11" width="65" height="30" align="center"><c:out value="${myAlerts.alertTo}" /></td>


                    <td width="65" height="30" align="center" class="fv11"> <a title="Delete" href="deleteSavedAlert.do?alertId=<c:out value="${myAlerts.alertId}" />" >Delete</a></td>
                    <%--<td><c:out value="${mySearches.searchUrl}" /></td>--%>
                </tr>
                <% c++; %>

            </c:forEach>
        </logic:greaterThan>
            </table>
        </div>
        <div style="width:710px;height:10px;"></div>
    </div>

</logic:present>