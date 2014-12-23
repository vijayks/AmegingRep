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