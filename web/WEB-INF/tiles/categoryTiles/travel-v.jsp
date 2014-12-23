
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
                    Accommodation Type
                </td>

                <td>
                    <input type="text" name="type" style="width:250px" value="<%= ab.getType()%>">
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
                    Accommodation Type
                </td>

                <td>
                    <input type="text" name="type" style="width:250px">
                </td>
            </tr>
            </table>
        </div>
        <div class="line" >

        </div>
    </logic:notPresent>
</logic:notPresent>
