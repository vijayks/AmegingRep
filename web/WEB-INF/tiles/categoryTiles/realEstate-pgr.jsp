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
                    <td>PG Address</td>
                    <td><textarea name="prefLocation" onKeyDown="addLimit(this,250);" onKeyUp="addLimit(this,250);"><%= ab.getPrefLocation()%></textarea></td>
                </tr>
                <tr>
                    <td>Gender</td>
                    <td><input type="text" name="brand" value="<%=ab.getBrand()%>"></td>
                </tr>
                <tr>
                    <td>Room Type(Give no. of Sharings)</td>
                    <td><input type="text" name="model" value="<%= ab.getModel()%>"></td>
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
                    <td>Floor No.</td>
                    <td><input type="text" name="floorNum" value="<%= ab.getFloorNum()%>"></td>
                </tr>
                <tr>
                    <td>Total No. of Floors</td>
                    <td><input type="text" name="totalFloors" value="<%= ab.getTotalFloors()%>"></td>
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
                    <input type="checkbox" name="fac" value="Food" <%if (facList != null && facList.contains("Food")) {%>checked=true<%}%>>Food<br>
                    <input type="checkbox" name="fac" value="Hot Water" <%if (facList != null && facList.contains("Hot Water")) {%>checked=true<%}%>>Hot Water<br>
                    <input type="checkbox" name="fac" value="Reserved Parking" <%if (facList != null && facList.contains("Reserved Parking")) {%>checked=true<%}%>>Reserved Parking<br>
                    <input type="checkbox" name="fac" value="TV" <%if (facList != null && facList.contains("TV")) {%>checked=true<%}%>>TV<br>
                    <input type="checkbox" name="fac" value="Security" <%if (facList != null && facList.contains("Security")) {%>checked=true<%}%>>Security<br>
                    <input type="checkbox" name="fac" value="Internet Facility" <%if (facList != null && facList.contains("Internet Facility")) {%>checked=true<%}%>>Internet Facility<br>
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
                    <td>PG Address</td>
                    <td><textarea name="prefLocation" onKeyDown="addLimit(this,250);" onKeyUp="addLimit(this,250);"></textarea></td>
                </tr>
                <tr>
                    <td>Gender</td>
                    <td><input type="text" name="condition"></td>
                </tr>
                <tr>
                    <td>Room Type(Give no. of Sharings)</td>
                    <td><input type="text" name="facing"></td>
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
                    <td>Floor No.</td>
                    <td><input type="text" name="floorNum"></td>
                </tr>
                <tr>
                    <td>Total No. of Floors</td>
                    <td><input type="text" name="totalFloors"></td>
                </tr>
                <tr>
                    <td>Furnished</td>
                    <td><input type="text" name="furnished"></td>
                </tr>

                <tr>
                <td>Facilities</td>
                <td>
                    <input type="hidden" value="" id="facilities" name="facilities">
                    <input type="checkbox" name="fac" value="Food">Food<br>
                    <input type="checkbox" name="fac" value="Hot Water">Hot Water<br>
                    <input type="checkbox" name="fac" value="Reserved Parking">Reserved Parking<br>
                    <input type="checkbox" name="fac" value="TV">TV<br>
                    <input type="checkbox" name="fac" value="Security">Security<br>
                    <input type="checkbox" name="fac" value="Internet Facility">Internet Facility<br>
                </td>
            </tr>
            </table>
        </div>
    </logic:notPresent>
</logic:notPresent>