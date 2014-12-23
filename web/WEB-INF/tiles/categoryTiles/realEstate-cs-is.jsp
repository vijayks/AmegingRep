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
                    <td><textarea name="prefLocation" onKeyDown="addLimit(this,250);" onKeyUp="addLimit(this,250);"><%= ab.getPrefLocation()%></textarea>
                    </td>
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
                    <td>Facing</td>
                    <td><input type="text" name="facing" value="<%= ab.getFacing()%>"></td>
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
                    <td>Facing</td>
                    <td><input type="text" name="facing"></td>
                </tr>
              </table>
        </div>
    </logic:notPresent>
</logic:notPresent>