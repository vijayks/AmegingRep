
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<logic:present name="editAdForUpdateBean" >
    <%@page  import="com.buysell.beans.AdsBean" %>
    <% AdsBean ab = (AdsBean) request.getAttribute("editAdForUpdateBean");%>
    <div class="tilepad" align="left">
        <table class="verdana_form_postAd" align="left">
            <tr>
                <td>Name</td>
                <td><input type="text" name="name" value="<%= ab.getName() %>"></td>
            </tr>
            <tr>
                <td>Age</td>
                <td><input type="text" name="yearsOld" value="<%= ab.getYearsOld()%>"></td>
            </tr>
            <tr>
                <td>Religion</td>
                <td><input type="text" name="type" value="<%= ab.getType()%>"></td>
            </tr>
            <tr>
                <td>Father's Name</td>
                <td><input type="text" name="brand" value="<%= ab.getBrand()%>"></td>
            </tr>
            <tr>
                <td>Mother's Name</td>
                <td><input type="text" name="model" value="<%= ab.getModel()%>"></td>
            </tr>
            <tr>
                <td>No. of Sisters</td>
                <td><input type="text" name="height" value="<%= ab.getHeight() %>"></td>
            </tr>
            <tr>
                <td>No. of Brothers</td>
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
                <td>Name</td>
                <td><input type="text" name="name"></td>
            </tr>
            <tr>
                <td>Age</td>
                <td><input type="text" name="yearsOld"></td>
            </tr>
            <tr>
                <td>Religion</td>
                <td><input type="text" name="type"></td>
            </tr>
            <tr>
                <td>Father's Name</td>
                <td><input type="text" name="brand"></td>
            </tr>
            <tr>
                <td>Mother's Name</td>
                <td><input type="text" name="model"></td>
            </tr>
            <tr>
                <td>No. of Sisters</td>
                <td><input type="text" name="height"></td>
            </tr>
            <tr>
                <td>No. of Brothers</td>
                <td><input type="text" name="weight"></td>
            </tr>
            </table>
        </div>
        <div class="line" ></div>
    </logic:notPresent>
</logic:notPresent>