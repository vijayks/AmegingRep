<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>

<logic:present name="editAdForUpdateBean" >
 <%@page  import="com.buysell.beans.AdsBean" %>
    <% AdsBean ab=(AdsBean)request.getAttribute("editAdForUpdateBean"); %>
<div class="tilepad" align="left">
<table class="verdana_form_postAd" align="left">

<tr>
    <td>
      Hospital Name
     </td>
      <td>
         <input type="text" name="name" value="<%= ab.getName()%>">
      </td>
</tr>
<tr>
 <td>
     Address
 </td>
 <td>
     <textarea name="prefLocation" value=""><%= ab.getPrefLocation()%></textarea>
 </td>
  </tr>
  <tr>
    <td>
        Specialist
    </td>
    <td>
        <input type="text" name="model" value="<%=ab.getModel()%>">
    </td>
</tr>
<tr>
<td>
Timings
</td>
<td>
<input type="text" name="note" value="<%= ab.getNote() %>">
</td>
</tr>
<tr>
    <td>
        Consultation Fee
    </td>
    <td>
        <input type="text" name="kmRun" value="<%=ab.getKmRun()%>">
    </td>
</tr>
</table>
</div>
<div class="line" >
</div>
</logic:present>


<logic:notPresent name="editAdForUpdateBean" >
<div class="tilepad" align="left">
<table class="verdana_form_postAd" align="left">

<tr>
  <td>
    Hospital Name
  </td>
  <td>
    <input type="text" name="name">
  </td>
</tr>
<tr>
 <td>
   Address
 </td>
 <td>
    <textarea name="prefLocation" value=""></textarea>
</td>
</tr>
<tr>
    <td>
        Specialist
    </td>
    <td>
        <input type="text" name="model">
    </td>
</tr>
<tr>
<td>
Timings
</td>
<td>
<input type="text" name="note">
</td>
</tr>
<tr>
    <td>
        Consultation Fee
    </td>
    <td>
        <input type="text" name="kmRun">
    </td>
</tr>
</table>
</div>
<div class="line" >
</div>
</logic:notPresent>