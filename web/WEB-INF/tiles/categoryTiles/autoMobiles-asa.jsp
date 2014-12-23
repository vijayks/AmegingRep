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
                    Condition
                </td>

                <td>
                    <select size="1" name="condition">
                        <option selected value="<%= ab.getCondition()%>"><%= ab.getCondition()%></option>
                        <option value="New">New</option>
                        <option value="Used">Used</option>

                    </select>
                </td>
            </tr>

            <tr>
                <td>
                    Mfg. Year
                </td>

                <td>
                    <input type="text" name="yearsOld" id="yearsOld" style="width:250px;" value="<%= ab.getYearsOld()%>">
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
                    Model
                </td>

                <td>
                    <input type="text" name="model" style="width:250px" value="<%= ab.getModel()%>">
                </td>
            </tr>
            <tr>
                <td>
                    Colour
                </td>

                <td>
                    <input type="text" name="color" style="width:250px" value="<%= ab.getColor()%>">
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
                        Condition
                    </td>

                    <td>
                        <select size="1" name="condition">
                            <option value="" selected>Select</option>
                            <option value="New">New</option>
                            <option value="Used">Used</option>

                        </select>
                    </td>
                </tr>

                <tr>
                    <td>
                        Mfg. Year
                    </td>

                    <td>
                        <input type="text" name="yearsOld" id="yearsOld" style="width:250px;">
                    </td>
                </tr>


                <tr>
                    <td>
                        Make
                    </td>

                    <td>
                        <input type="text" style="width:250px" name="brand">
                    </td>
                </tr>
                <tr>
                    <td>
                        Model
                    </td>

                    <td>
                        <input type="text" style="width:250px" name="model">
                    </td>
                </tr>



                <tr>
                    <td>
                        Colour
                    </td>

                    <td>
                        <input type="text" style="width:250px" name="color">
                    </td>
                </tr>


            </table>
        </div>
        <div class="line" >

        </div>
    </logic:notPresent>
</logic:notPresent>

