
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script language="javascript">
     function numbersOnly(e, decimal) {

        var key;
        var keychar;

        if (window.event) {
            key = window.event.keyCode;
        }
        else if (e) {
            key = e.which;
        }
        else {

            return true;
        }

        keychar = String.fromCharCode(key);

        if ((key==null) || (key==0) || (key==8) ||  (key==9) || (key==13) || (key==27) ) {

            return true;
        }
        else if ((("0123456789").indexOf(keychar) > -1)) {

            return true;
        }
        else if (decimal && (keychar == ".")) {

            return true;
        }
        else

        return false;
}

function inputlimiter(e,allow) {

var AllowableCharacters = '';
AllowableCharacters=' ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';
var k;

k=document.all?parseInt(e.keyCode): parseInt(e.which);

if (k!=13 && k!=8 && k!=0){

if ((e.ctrlKey==false) && (e.altKey==false)) {

return (AllowableCharacters.indexOf(String.fromCharCode(k))!=-1);

} else {

return true;

}

} else {

return true;

}

}

</script>
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
                    Model
                </td>

                <td>
                    <input type="text" name="model" style="width:250px" value="<%= ab.getModel()%>">
                </td>
            </tr>

            <tr>
                <td>
                    Registration NO
                </td>

                <td>
                    <input type="text" name="regNo" style="width:250px" value="<%= ab.getRegNo()%>">
                </td>
            </tr>

            <tr>
                <td>
                    Colour
                </td>

                <td>
                    <input type="text" name="color" style="width:250px" value="<%= ab.getColor()%>" onkeypress="return inputlimiter(event,'color')">
                </td>
            </tr>

            <tr>
                <td>
                    Ownership
                </td>

                <td>
                    <select size="1" name="ownership">
                        <option selected><%= ab.getOwnership()%></option>
                        <option value="First">First</option>
                        <option value="second">Second</option>
                        <option value="Third">Third</option>
                        <option value="Fourth">Fourth</option>
                        <option value="Above four">Above four</option>
                    </select>
                </td>
            </tr>

            <tr>
                <td>
                    Insurance
                </td>

                <td>
                    <select size="1" name="insurance">
                        <option selected><%= ab.getInsurance()%></option>
                        <option value="No Insurance">No Insurance</option>
                        <option value="Comprehensive">Comprehensive</option>
                        <option value="Third Party">Third Party</option>
                    </select>
                </td>
            </tr>

            <tr>
                <td>
                    Kilometers Run
                </td>

                <td>
                    <input type="text" name="kmRun" style="width:250px" value="<%= ab.getKmRun()%>" onKeyPress="return numbersOnly(event, false)">
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
                        <select size="1" name="condition"  onChange="yODis(ad.condition.value);">
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
                        Model
                    </td>

                    <td>
                        <input type="text" style="width:250px" name="model">
                    </td>
                </tr>

                <tr>
                    <td>
                        Registration NO
                    </td>

                    <td>
                        <input type="text" style="width:250px" name="regNo">
                    </td>
                </tr>

                <tr>
                    <td>
                        Colour
                    </td>

                    <td>
                        <input type="text" style="width:250px" name="color" onkeypress="return inputlimiter(event,'color')">
                    </td>
                </tr>

                <tr>
                    <td>
                        Ownership
                    </td>

                    <td>
                        <select size="1" name="ownership">
                            <option value="" selected>Select</option>
                            <option value="First">First</option>
                            <option value="second">Second</option>
                            <option value="Third">Third</option>
                            <option value="Fourth">Fourth</option>
                            <option value="Above four">Above four</option>
                        </select>
                    </td>
                </tr>

                <tr>
                    <td>
                        Insurance
                    </td>

                    <td>
                        <select size="1" name="insurance">
                            <option value="" selected>Select</option>
                            <option value="No Insurance">No Insurance</option>
                            <option value="Comprehensive">Comprehensive</option>
                            <option value="Third Party">Third Party</option>
                        </select>
                    </td>
                </tr>

                <tr>
                    <td>
                        Kilometers Run
                    </td>
                    <td>
                        <input type="text" style="width:250px" name="kmRun" onKeyPress="return numbersOnly(event, false)">
                    </td>
                </tr>
            </table>
        </div>
        <div class="line" >

        </div>
    </logic:notPresent>
</logic:notPresent>
