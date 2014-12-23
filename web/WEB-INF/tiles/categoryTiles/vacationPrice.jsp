<script language="javascript">
    function numbersonly(e, decimal) {

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



</script>


<%@page language="java" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%@page  import="com.buysell.beans.AdsBean" %>
<logic:present name="editAdForUpdateBean" >

    <% AdsBean ab = (AdsBean) request.getAttribute("editAdForUpdateBean");%>

    <div style="clear:both;" class="tilepad"  >

        <table id="price1" style="display:none" class="verdana_form_postAd" >
            <tr>
                <td width="100%">&nbsp;</td>
            </tr>
            <tr style="width:400px;">
                <td >
                    Price per Night
                </td>
                <td  style="width:300px;"><input style="width:90px;" maxlength="10" type="text" id="min" name="min" value="<%= ab.getMin()%>" onKeyPress="return numbersonly(event, false)" />(Min) - <input style="width:90px;" maxlength="10" type="text" id="max" name="max" value="<%= ab.getMax()%>" onKeyPress="return numbersonly(event, false)" /><span id="max1">(Max)</span></td>
            </tr>
            <tr>
                <td width="100%">&nbsp;</td>
            </tr>
        </table>
    </div>
</logic:present>

<logic:notPresent name="editAdForUpdateBean" >
    <div style="clear:both;"  class="tilepad"  >
        <table id="price1" class="verdana_form_postAd" >
            <tr>
                <td width="100%">&nbsp;</td>
            </tr>
            <tr style="width:400px;">
                <td >
                    Price per Night
                </td>
                <td  style="width:300px;">Min <input style="width:90px;" maxlength="10"  type="text" id="min" name="min" onKeyPress="return numbersonly(event, false)" /> - Max <input style="width:90px;" maxlength="10" type="text" id="max" name="max" onKeyPress="return numbersonly(event, false) " /><span id="max1"></span></td>
            </tr>
            <tr>
                <td width="100%">&nbsp;</td>
            </tr>
        </table>
    </div>


</logic:notPresent>
