
<%@page language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:if test="${editAdForUpdateBean != null}" >
     <% AdsBean ab = (AdsBean) request.getAttribute("editAdForUpdateBean");%>
<%@page  import="com.buysell.beans.AdsBean" %>

 
<div class="tilepad" align="left">
<table   class="verdana_form_postAd" align="left">

<tr>
<td>
Breed
</td>
<td>
    <input type="text" name="breed" value="<%= ab.getBreed() %>" />

</td>
</tr>

<tr>
<td>
Age
</td>
<td>
    <input type="text" name="yearsOld" value="<%= ab.getYearsOld()%>" >

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
Breed
</td>
<td>
<input type="text" name="breed">

</td>
</tr>

<tr>
<td>
Age
</td>
<td>
<input type="text" name="yearsOld">

</td>
</tr>






</table>

</div>
<div class="line" >

</div>
</c:if>