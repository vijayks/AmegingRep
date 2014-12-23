<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>

<logic:present name="editAdForUpdateBean" >
 <%@page  import="com.buysell.beans.AdsBean" %>
    <% AdsBean ab=(AdsBean)request.getAttribute("editAdForUpdateBean"); %>
<div class="tilepad" align="left">
<table  class="verdana_form_postAd" align="left">

<tr>
    <td>Name</td>
    <td><input type="text" name="name" value="<%= ab.getName()%>"></td>
</tr>
<tr>
    <td>Address</td>
    <td><textarea name="prefLocation"><%= ab.getPrefLocation() %></textarea></td>
</tr>
</table>

</div>
<div class="line" >

</div>
</logic:present>


<logic:notPresent name="editAdForUpdateBean" >
<div class="tilepad" align="left">
<table  class="verdana_form_postAd" align="left">
<tr>
    <td>Name</td>
    <td><input type="text" name="name"></td>
</tr>
<tr>
    <td>Address</td>
    <td><textarea name="prefLocation"></textarea>
       </td>
</tr>
</table>

</div>
<div class="line" >

</div>
</logic:notPresent>