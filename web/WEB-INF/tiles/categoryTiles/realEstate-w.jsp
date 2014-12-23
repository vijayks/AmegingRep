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
                    <td><textarea name="prefLocation" cols="" rows="" onKeyDown="addLimit(this,250);" onKeyUp="addLimit(this,250);"><%= ab.getPrefLocation()%></textarea></td>
                </tr>
                <tr>
                    <td>Age of Construction</td>
                    <td>
                        <select size="1" name="yearsOld">
                            <option selected value="<%= ab.getYearsOld()%>"><%= ab.getYearsOld()%></option>
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
                    <td>Area</td>
                    <td><input type="text" name="area" value="<%= ab.getArea()%>"></td>
                </tr>
                <tr>
                    <td>Floor No.</td>
                    <td><input type="text" name="floorNum" value="<%= ab.getFloorNum()%>"></td>
                </tr>
                <tr>
                    <td>Total No. of Floors</td>
                    <td><input type="text" name="totalFloors" value="<%= ab.getTotalFloors()%>"></td>
                </tr>
                <tr>
                    <td>Facing</td>
                    <td><input type="text" name="facing" value="<%= ab.getFacing()%>"></td>
                </tr>
                <tr>
                <%
            String facList = ab.getFacilities();
                %>
                <td>Facilities</td>
                <td>
                    <input type="hidden" value="" id="facilities" name="facilities">
                    <input type="checkbox" name="fac" value="Lift" <%if (facList != null && facList.contains("Lift")) {%>checked=true<%}%> >Lift<br>
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
                    <td><textarea name="prefLocation" cols="" rows=""                     <td><textarea name="prefLocation" cols="" rows="" ></textarea></td>
></textarea></td>
                </tr>
                <tr>
                    <td>Age of Construction</td>
                    <td>
                        <select size="1" name="yearsOld">
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
                    <td>Area</td>
                    <td><input type="text" name="area"></td>
                </tr>
                <tr>
                    <td>Floor No.</td>
                    <td><input type="text" name="floorNum"></td>
                </tr>
                <tr>
                    <td>Total No. of Floors</td>
                    <td><input type="text" name="totalFloors"></td>
                </tr>
                <tr>
                    <td>Facing</td>
                    <td><input type="text" name="facing"></td>
                </tr>
                <tr>
                    <td>Facilities</td>
                    <td>
                    <input type="hidden" value="" id="facilities" name="facilities">
                    <input type="checkbox" name="fac" value="Lift">Lift<br>
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