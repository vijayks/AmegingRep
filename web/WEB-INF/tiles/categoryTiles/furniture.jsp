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
Condition
</td>

<td>
<select size="1" name="condition" onChange="yODis(ad.condition.value);">
<option selected><%= ab.getCondition() %></option>
    <option value="New">New</option>
    <option value="Used">Used</option>

    </select>
</td>
</tr>
<tr>
<td>
YearOld
</td>
<td>
    <select size="1" name="yearsold" id="yearsOld">
    <option selected><%= ab.getYearsOld() %></option>
    <option value="&lt;1 Year"><1 Year</option>
    <option value="1 - 2 Years">1 - 2 years</option>

    <option value="2 - 3 Years">2 - 3 Years</option>
    <option value="3 - 4 Years">3 - 4 Years</option>
    <option value="4 - 5 Years">4 - 5 Years</option>
    <option value="&gt;5 Years ">>5 Years</option>
    </select>
</td>
</tr>

<tr>
<td>
Material
</td>
<td>
<input type="text" name="material" value=<%= ab.getMaterial() %> >

</td>
</tr>

<tr>
<td>
Dimensions
</td>
<td>
    <input type="text" name="measurement" value="<%= ab.getMeasurement()%>">

</td>
</tr>

<tr>
<td>
Brand
</td>
<td>
<input type="text" name="brand" value=<%= ab.getBrand() %> >

</td>
</tr>
<tr>
<td>
Colour
</td>
<td>
<input type="text" name="color" value=<%= ab.getColor() %>>

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
Condition
</td>

<td>
<select size="1" name="condition" onChange="yODis(ad.condition.value);">
    <option selected value="">Select</option>
    <option value="New">New</option>
    <option value="Used">Used</option>

    </select>
</td>
</tr>
<tr>
<td>
YearOld
</td>
<td>
<select size="1" name="yearsold" id="yearsOld">
    <option selected value="">Select</option>
    <option value="&lt;1 Year"><1 Year</option>
    <option value="1 - 2 Years">1 - 2 years</option>

    <option value="2 - 3 Years">2 - 3 Years</option>
    <option value="3 - 4 Years">3 - 4 Years</option>
    <option value="4 - 5 Years">4 - 5 Years</option>
    <option value="&gt;5 Years ">>5 Years</option>
    </select>
</td>
</tr>

<tr>
<td>
Material
</td>
<td>
<input type="text" name="material">

</td>
</tr>

<tr>
<td>
Dimensions
</td>
<td>
<input type="text" name="measurement">

</td>
</tr>

<tr>
<td>
Brand
</td>
<td>
<input type="text" name="brand">

</td>
</tr>
<tr>
<td>
Colour
</td>
<td>
<input type="text" name="color">

</td>
</tr>


</table>

</div>

<div class="line" >

</div>
</logic:notPresent>