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

    <option value="<%= ab.getType() %>" selected><%= ab.getType() %></option>
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
    Pet Name
</td>
<td>
    <input type="text" name="name" value="<%= ab.getName() %>" />

</td>
</tr>

<tr>
<td>
Lost Date
</td>
<td>
    <input type="text" name="brand" value="<%= ab.getBrand()%>" >

</td>
</tr>

<tr>
<td>
Identifications
</td>
<td>
    <input type="text" name="note" value="<%= ab.getNote()%>" >

</td>
</tr>
<tr>
                <td>
                    Address
                </td>


                <td>
                    <textarea name="prefLocation"><%=ab.getPrefLocation()%></textarea>

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

    <option value="">Select Type</option>
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
Pet Name
</td>
<td>
    <input type="text" name="name"  />

</td>
</tr>

<tr>
<td>
Lost Date
</td>
<td>
    <input type="text" name="brand" value="" >

</td>
</tr>

<tr>
<td>
Identifications
</td>
<td>
    <input type="text" name="note" value="" >

</td>
</tr>
<tr>
                <td>
                    Address
                </td>
                <td>
                    <textarea name="prefLocation"></textarea>

                </td>
            </tr>

</table>

</div>
<div class="line" >

</div>
</c:if>