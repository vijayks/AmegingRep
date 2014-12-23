<%-- 
    Document   : pets-ac
    Created on : Oct 26, 2009, 6:03:24 PM
    Author     : bbsadmin
--%>


<%@page language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:if test="${editAdForUpdateBean != null}" >
     <% AdsBean ab = (AdsBean) request.getAttribute("editAdForUpdateBean");%>
<%@page  import="com.buysell.beans.AdsBean" %>


<div class="tilepad" align="left">
<table   class="verdana_form_postAd" align="left">
<tr>
<td>
Pet Type
</td>
<td>
<select size="1" name="type">

    <option value="<%= ab.getType() %>"selected><%= ab.getType() %></option>
    <option value="Cat">Cat</option>
    <option value="Dog">Dog</option>
    <option value="Horse">Horse</option>
    <option value="Bird">Bird</option>
    <option value="Reptile">Reptile</option>
    <option value="Fish">Fish</option>
    <option value="Rabbit">Rabbit</option>
    <option value="Other Animal">Other Animal</option>
    </select>
</td>
</tr>

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
Make
</td>
<td>
    <input type="text" name="brand" value="<%= ab.getBrand()%>" >

</td>
</tr>

<tr>
<td>
Model
</td>
<td>
    <input type="text" name="model" value="<%= ab.getModel()%>" >

</td>
</tr>
<tr>
                <td>
                    Condition
                </td>

                <td>
                    <select size="1" name="condition" onChange="yODis(ad.condition.value);">
                        <option value="<%= ab.getCondition()%>"selected><%= ab.getCondition()%></option>
                        <option value="New">New</option>
                        <option value="Used">Used</option>

                    </select>
                </td>
            </tr>

<tr>
<td>
Years Old
</td>
<td>
    <select size="1" name="yearsOld" id="yearsOld">
    <option value="<%= ab.getYearsOld() %>" selected><%= ab.getYearsOld() %></option>
    <option value="&lt;1 Year"><1 Year</option>
    <option value="1 - 2 Years">1 - 2 years</option>
    <option value="2 - 3 Years">2 - 3 Years</option>
    <option value="3 - 4 Years">3 - 4 Years</option>
    <option value="4 - 5 Years">4 - 5 Years</option>
    <option value="&gt;5 Years ">>5 Years</option>
    </select>
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
Pet Type
</td>

<td>
<select size="1" name="type">

    <option selected value="">Select</option>
    <option value="Cat">Cat</option>
    <option value="Dog">Dog</option>
    <option value="Horse">Horse</option>
    <option value="Bird">Bird</option>
    <option value="Reptile">Reptile</option>
    <option value="Fish">Fish</option>
    <option value="Rabbit">Rabbit</option>
    <option value="Other Animal">Other Animal</option>
    </select>
</td>
</tr>
<tr>
<td>
Name
</td>
<td>
    <input type="text" name="name"  />

</td>
</tr>

<tr>
<td>
Make
</td>
<td>
    <input type="text" name="brand"  >

</td>
</tr>

<tr>
<td>
Model
</td>
<td>
    <input type="text" name="model"  >

</td>
</tr>
<tr>
                <td>
                    Condition
                </td>

                <td>
                    <select size="1" name="condition" onChange="yODis(ad.condition.value);">
                        <option value="">Select Condition</option>
                        <option value="New">New</option>
                        <option value="Used">Used</option>

                    </select>
                </td>
            </tr>

<tr>
<td>
Years Old
</td>
<td>
    <select size="1" name="yearsOld" id="yearsOld">
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



</table>

</div>
<div class="line" >

</div>
</c:if>