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
                        Course Name
                    </td>
                    <td>
                        <input type="text" name="name" value="<%= ab.getName()%>">
                    </td>
                </tr>
               <tr>
                    <td>
                        Qualification
                    </td>

                    <td>
                        <input type="text" style="width:250px" name="qualification" value="<%= ab.getQualification()%>">
                    </td>
                </tr>
                <tr>
                    <td>
                        Address
                    </td>

                    <td>
                         <textarea name="prefLocation"><%= ab.getPrefLocation()%></textarea>
                    </td>
                </tr>
                <tr>
                    <td>
                        Fee
                    </td>

                    <td>
                        <input type="text" style="width:250px;" name="kmRun" value="<%= ab.getKmRun()%>">
                    </td>
                </tr>


            </table>
        </div>

<div class="line" >

</div>
    </logic:present>

<logic:notPresent name="editAdForUpdateBean" >
 <div class="tilepad" align="left">
            <table class="verdana_form_postAd" align="left">
               <tr>
                    <td>
                        Course Name
                    </td>
                    <td>
                        <input type="text" name="name">
                    </td>
                </tr>
               <tr>
                    <td>
                        Qualification
                    </td>

                    <td>
                        <input type="text" style="width:250px" name="qualification">
                    </td>
                </tr>
                <tr>
                    <td>
                        Address
                    </td>

                    <td>
                          <textarea name="prefLocation"></textarea>
                    </td>
                </tr>
                <tr>
                    <td>
                        Fee
                    </td>

                    <td>
                        <input type="text" style="width:250px;" name="kmRun">
                    </td>
                </tr>
            </table>
        </div>

<div class="line" >

</div>
</logic:notPresent>
