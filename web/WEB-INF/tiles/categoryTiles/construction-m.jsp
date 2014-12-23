
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<logic:present name="editAdForUpdateBean" >
    <%@page  import="com.buysell.beans.AdsBean" %>
    <% AdsBean ab = (AdsBean) request.getAttribute("editAdForUpdateBean");%>
    <div class="tilepad" align="left">
        <table class="verdana_form_postAd" align="left">
            <tr>
                <td>Material Name</td>
                <td><input type="text" name="name" value="<%= ab.getName() %>"></td>
            </tr>
            <tr>
                <td>Make</td>
                <td><input type="text" name="brand" value="<%= ab.getBrand()%>"></td>
            </tr>
            <tr>
                <td>Dimensions</td>
                <td><input type="text" name="measurement" value="<%= ab.getMeasurement()%>"></td>
            </tr>
            <tr>
                <td>Weight</td>
                <td><input type="text" name="weight" value="<%= ab.getWeight() %>"></td>
            </tr>
        </table>
    </div>
    <div class="line" ></div>
</logic:present>

<logic:notPresent name="editAdForUpdateBean" >
    <logic:notPresent name="tileName" >
        <div class="tilepad" align="left">
            <table class="verdana_form_postAd" align="left">
            <tr>
                <td>Material Name</td>
                <td><input type="text" name="name"></td>
            </tr>
            <tr>
                <td>Make</td>
                <td><input type="text" name="brand"></td>
            </tr>
            <tr>
                <td>Dimensions</td>
                <td><input type="text" name="measurement"></td>
            </tr>
            <tr>
                <td>Weight</td>
                <td><input type="text" name="weight"></td>
            </tr>
            </table>
        </div>
        <div class="line" ></div>
    </logic:notPresent>
</logic:notPresent>