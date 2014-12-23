
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>

<logic:present name="mySavedSearches" >
    <bean:size id="size" name="mySavedSearches" />
    <div style="clear:both;">
        <div style="width:715px;height:5px;"></div>

        <div   style="width:715px;" >
            <div style="padding-bottom:10px;" width="100%" valign="top" class="verdana_form_mainhead"><b>My Saved Searches</b></div>
            <table width="700" align="center"  border="1" cellpadding="1" cellspacing="1"  >
                <tr class="fv12bw">
                    <th width="35" bgcolor="#4D9EDF" height="35" style="text-align:center">Sl No</th>
                    <th width="65" bgcolor="#4D9EDF" height="35" style="text-align:center">Saved On</th>
                    <th width="465" bgcolor="#4D9EDF" height="35" style="text-align:center">Search Details</th>
                    <th width="135" bgcolor="#4D9EDF" height="35" style="text-align:center">Action</th>
                    <!--<th>SearchUrl</th>-->
                </tr>
        <logic:equal name="size" value="0">
                </table>
                <table width="680" align="center"   border="1" cellpadding="0" cellspacing="0"  >
                    <tr><td class="fv12bc" align="center"> No searches are saved </td></tr>
                </table>
            </div>
        </logic:equal>
        <logic:greaterThan name="size" value="0">
            <% int c = 1;%>
            <c:forEach items="${mySavedSearches}" var="mySearches">
                <tr >
                    <td class="fv11" width="35" height="30"  align="center"><%= c%></td>
                    <td class="fv11" width="60" height="30" align="center" ><c:out value="${mySearches.searchOn}" /></td>
                    <td  width="460" class="fv11" align="left" height="30" style="padding-left:5px;padding-right:5px;" >
                        <c:if test="${mySearches.refinePattern != null }" >
                            <c:out value="${mySearches.refinePattern}" escapeXml="false" />
                        </c:if>
                    </td >
                    <td width="130" height="30" align="center" class="fv11">  <a title="Search Again" href="<c:out value="${mySearches.searchUrl }" /><c:out value="${mySearches.qryString}" />&m=ma" >Search again&nbsp;&nbsp;&nbsp;&nbsp;</a> <a title="Delete" href="deleteSavedSearch.do?searchId=<c:out value="${mySearches.searchId}" />" >Delete</a></td>
                    <%--<td><c:out value="${mySearches.searchUrl}" /></td>--%>
                </tr>
                <% c++;%>
            </c:forEach>
        </logic:greaterThan>
            </table>
        </div>
        <div style="width:710px;height:10px;"></div>
    </div>


</logic:present>