<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
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
                    Company Name
                </td>
                <td>
                    <input type="text" name="name" value="<%= ab.getName()%>">
                </td>

            </tr>

            <tr>
                <td>
                    Product Name
                </td>
                <td>
                    <input type="text" name="brand" value="<%= ab.getBrand()%>" >

                </td>
            </tr>
            <tr>
                <td>
                    License Period
                </td>
                <td>
                    <input type="text" name="yearsOld" value="<%= ab.getYearsOld()%>">
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
                    Company Name
                </td>
                <td>
                    <input type="text" name="name">
                </td>

            </tr>

            <tr>
                <td>
                    Product Name
                </td>
                <td>
                    <input type="text" name="brand" >

                </td>
            </tr>
            <tr>
                <td>
                    License Period
                </td>
                <td>
                    <input type="text" name="yearsOld">
                </td>
            </tr>
            </table>

        </div>
        <div class="line" >

        </div>
    </logic:notPresent>
</logic:notPresent>

