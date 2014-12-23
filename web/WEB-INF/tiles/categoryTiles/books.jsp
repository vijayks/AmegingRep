<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%--<bean:message property="bobby.somu"/>--%>
<link href="images/lytebox/fbox.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="css/stylesheet.css" />
<script type="text/javascript" src="images/lytebox/fbox_conf.js"></script>
<script type="text/javascript" src="images/lytebox/fbox_engine.js"></script>
<script type="text/javascript" src="images/lytebox/fbox_engine-min.js"></script>
<script type="text/javascript" language="javascript" src="js/ajaxSaveSearch.js"></script>



<c:if test="${editAdForUpdateBean!=null }" >
    <%@page  import="com.buysell.beans.AdsBean" %>

    <% AdsBean ab = (AdsBean) request.getAttribute("editAdForUpdateBean");%>
    <div id="general" class="tilepad">

        <table id="ptab" class="verdana_form_postAd" align="left">
            <tr>
                <td >
                    Condition
                </td
                <td>
                    <select size="1" name="condition" onChange="yODis(ad.condition.value);">
                        <option selected><%= ab.getCondition()%></option>
                        <option value="New">New</option>
                        <option value="Used">Used</option>

                    </select>
                </td>
            </tr>
            <tr>
                <td >
                    Years Old
                </td>
                <td>
                    <select size="1" name="yearsOld" id="yearsOld">
                        <option selected><%= ab.getYearsOld()%></option>
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
                <td>
                    Title
                </td>
                <td>
                    <input type="text" style="width:250px" name="name" value="<%= ab.getName()%>">

                </td>
            </tr>

            <tr>
                <td>
                    Author
                </td>
                <td>
                    <input type="text" style="width:250px" name="author" value="<%= ab.getAuthor() %>" >

                </td>
            </tr>
            <tr>
                <td>
                    Language
                </td>
                <td>
                    <input type="text" style="width:250px" name="language" value="<%= ab.getLanguage() %>" >

                </td>
            </tr>
            <tr>
                <td>
                    Publication
                </td>
                <td>
                    <input type="text" style="width:250px" name="publication" value="<%= ab.getPublication()%>" >

                </td>
            </tr>

        </table>

        <div class="line" >

        </div>
    </div>

</c:if>


<logic:notPresent name="editAdForUpdateBean" >
    <logic:notPresent name="tileName" >
        <div class="tilepad">
            <table  class="verdana_form_postAd" align="left">
                 <tr>
                <td >
                    Condition
                </td
                <td>
                    <select size="1" name="condition" onChange="yODis(ad.condition.value);">
                        <option selected value="">Select</option>
                        <option value="New">New</option>
                        <option value="Used">Used</option>

                    </select>
                </td>
            </tr>
            <tr>
                <td >
                    Years Old
                </td>
                <td>
                    <select size="1" name="yearsOld" id="yearsOld">
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
                <td>
                    Title
                </td>
                <td>
                    <input type="text" style="width:250px" name="name">

                </td>
            </tr>

            <tr>
                <td>
                    Author
                </td>
                <td>
                    <input type="text" style="width:250px" name="author">

                </td>
            </tr>
            <tr>
                <td>
                    Language
                </td>
                <td>
                    <input type="text" style="width:250px" name="language">

                </td>
            </tr>
            <tr>
                <td>
                    Publication
                </td>
                <td>
                    <input type="text" style="width:250px" name="publication">

                </td>
            </tr>
            </table>
            <div class="line" >

            </div>
        </div>
    </logic:notPresent>
</logic:notPresent>