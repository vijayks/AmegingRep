
<%@page language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:if test="${editAdForUpdateBean != null}" >
     <% AdsBean ab = (AdsBean) request.getAttribute("editAdForUpdateBean");%>
<%@page  import="com.buysell.beans.AdsBean" %>


<div class="tilepad" align="left">
<table   class="verdana_form_postAd" align="left">

<tr>
<td>
Name
</td>
<td>
    <input type="text" name="name" value="<%= ab.getName() %>" />

</td>
</tr>

<tr>
<td>
Address
</td>
<td>
    <textarea name="prefLocation"><%= ab.getPrefLocation()%></textarea>

</td>
</tr>

</table>

</div>
<div class="line" >

</div>




</c:if>


<c:if test="${editAdForUpdateBean == null}" >
<div class="tilepad" align="left">
<table   class="verdana_form_postAd" align="left">

<tr>
<td>
Name
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






</table>

</div>
<div class="line" >

</div>
</c:if>
