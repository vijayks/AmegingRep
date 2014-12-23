<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<logic:present name="editAdForUpdateBean" >
    <%@page  import="com.buysell.beans.AdsBean" %>
    <% AdsBean ab = (AdsBean) request.getAttribute("editAdForUpdateBean");%>
    <div class="tilepad" align="left">
        <table class="verdana_form_postAd" align="left">

            <tr>
                <td>
                    Tyre Type
                </td>
                <td>
                    <input type="text" style="width:250px;" name="type" value="<%= ab.getType()%>">
                </td>
            </tr>
            <tr>
                <td>
                    Size
                </td>

                <td>
                    <input type="text" name="measurement" style="width:250px" value="<%= ab.getMeasurement()%>">
                </td>
            </tr>
            <tr>
                <td>
                   Vehicle Model
                </td>

                <td>
                    <input type="text" name="name" style="width:250px" value="<%= ab.getName()%>">
                </td>
            </tr>



            <tr>
                <td>
                    Make
                </td>

                <td>
                    <input type="text" name="brand" style="width:250px" value="<%= ab.getBrand()%>">
                </td>
            </tr>



            <tr>
                <td>
                   Tyre Model
                </td>

                <td>
                    <input type="text" name="model" style="width:250px" value="<%= ab.getModel()%>">
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
                <td>
                    Tyre Type
                </td>
                <td>
                    <input type="text" style="width:250px;" name="type">
                </td>
            </tr>
            <tr>
                <td>
                    Size
                </td>

                <td>
                    <input type="text" name="measurement" style="width:250px">
                </td>
            </tr>
            <tr>
                <td>
                   Vehicle Model
                </td>

                <td>
                    <input type="text" name="name" style="width:250px">
                </td>
            </tr>



            <tr>
                <td>
                    Make
                </td>

                <td>
                    <input type="text" name="brand" style="width:250px">
                </td>
            </tr>



            <tr>
                <td>
                   Tyre Model
                </td>

                <td>
                    <input type="text" name="model" style="width:250px">
                </td>
            </tr>
            </table>
        </div>
        <div class="line" >

        </div>
    </logic:notPresent>
</logic:notPresent>

