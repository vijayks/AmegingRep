<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script type="text/javascript" language="javascript" >
    function addLimit(ad, limitNum) {
         if (ad.value.length > limitNum) {
            ad.value = ad.value.substring(0, limitNum);
        }
    }
</script>

<logic:present name="editAdForUpdateBean" >
    <%@page  import="com.buysell.beans.AdsBean" %>
    <% AdsBean ab = (AdsBean) request.getAttribute("editAdForUpdateBean");%>

    <div class="tilepad" align="left">
            <table class="verdana_form_postAd" align="left">
                <tr>
                    <td>Property Address</td>
                    <td><textarea name="prefLocation" onKeyDown="addLimit(this,250);" onKeyUp="addLimit(this,250);"><%= ab.getPrefLocation()%></textarea></td>
                </tr>
                <tr>
                    <td>Area</td>
                    <td><input type="text" name="area" value="<%= ab.getArea()%>"></td>
                </tr>
                <tr>
                    <td>No. of Bedrooms</td>
                    <td><input type="text" name="noBedRooms" value="<%= ab.getNoBedRooms()%>"></td>
                </tr>
                <tr>
                    <td>No. of Bathrooms</td>
                    <td><input type="text" name="kmRun" value="<%= ab.getKmRun()%>"></td>
                </tr>
                <tr>
                    <td>Facing</td>
                    <td><input type="text" name="facing" value="<%= ab.getFacing()%>"></td>
                </tr>
                <tr>
                    <td>Furnished</td>
                    <td><input type="text" name="furnished" value="<%= ab.getFurnished()%>"></td>
                </tr>

                <tr>
                <%
            String facList = ab.getFacilities();
                %>
                <td>Facilities</td>
                <td>
                    <input type="hidden" value="" id="facilities" name="facilities">
                    <input type="checkbox" name="fac" value="Gym" <%if (facList != null && facList.contains("Gym")) {%>checked=true<%}%>>Gym<br>
                    <input type="checkbox" name="fac" value="Club" <%if (facList != null && facList.contains("Club")) {%>checked=true<%}%>>Club<br>
                    <input type="checkbox" name="fac" value="Park" <%if (facList != null && facList.contains("Park")) {%>checked=true<%}%>>Park<br>
                    <input type="checkbox" name="fac" value="Swimming Pool" <%if (facList != null && facList.contains("Swimming Pool")) {%>checked=true<%}%>>SwimmingPool<br>
                    <input type="checkbox" name="fac" value="Security" <%if (facList != null && facList.contains("Security")) {%>checked=true<%}%>>Security<br>
                    <input type="checkbox" name="fac" value="Power Backup" <%if (facList != null && facList.contains("Power Backup")) {%>checked=true<%}%>>Power Backup<br>
                    <input type="checkbox" name="fac" value="Vaastu Compliant" <%if (facList != null && facList.contains("Vaastu Compliant")) {%>checked=true<%}%>>Vaastu Compliant<br>
                    <input type="checkbox" name="fac" value="Reserved Parking" <%if (facList != null && facList.contains("Reserved Parking")) {%>checked=true<%}%>>Reserved Parking<br>
                    <input type="checkbox" name="fac" value="Rain Water Harvesting" <%if (facList != null && facList.contains("Rain Water Harvesting")) {%>checked=true<%}%>>Rain Water Harvesting<br>
                </td>
            </tr>
            </table>
        </div>

<div class="line" >

</div>
</logic:present>

<logic:notPresent name="editAdForUpdateBean" >
    <logic:notPresent name="tileName" >
        <div class="tilepad" align="left">
            <table class="verdana_form_postAd" align="left">
                <tr>
                    <td>Property Address</td>
                    <td><textarea name="prefLocation" onKeyDown="addLimit(this,250);" onKeyUp="addLimit(this,250);"></textarea></td>
                </tr>
                <tr>
                    <td>Area</td>
                    <td><input type="text" name="area"></td>
                </tr>
                <tr>
                    <td>No. of Bedrooms</td>
                    <td><input type="text" name="noBedRooms"></td>
                </tr>
                <tr>
                    <td>No. of Bathrooms</td>
                    <td><input type="text" name="kmRun"></td>
                </tr>
                <tr>
                    <td>Facing</td>
                    <td><input type="text" name="facing"></td>
                </tr>
                <tr>
                    <td>Furnished</td>
                    <td><input type="text" name="furnished"></td>
                </tr>
                <tr>
                    <td>Facilities</td>
                    <td>
                    <input type="hidden" value="" id="facilities" name="facilities">
                    <input type="checkbox" name="fac" value="Gym">Gym<br>
                    <input type="checkbox" name="fac" value="Club">Club<br>
                    <input type="checkbox" name="fac" value="Park">Park<br>
                    <input type="checkbox" name="fac" value="Swimming Pool">SwimmingPool<br>
                    <input type="checkbox" name="fac" value="Security">Secuirity<br>
                    <input type="checkbox" name="fac" value="Power Backup">Power Backup<br>
                    <input type="checkbox" name="fac" value="Vaastu Compliant">Vaastu Compliant<br>
                    <input type="checkbox" name="fac" value="Reserved Parking">Reserved Parking<br>
                    <input type="checkbox" name="fac" value="Rain Water Harvesting">Rain Water Harvesting<br>
                </td>
                </tr>
            </table>
        </div>
    </logic:notPresent>
</logic:notPresent>