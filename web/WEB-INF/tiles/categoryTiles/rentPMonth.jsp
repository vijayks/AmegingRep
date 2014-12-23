<script language="javascript">

    function disableTotalCost(itemId)
    {
        inlineMsg('cfp1',' ');
        document.ad.price.disabled=itemId.checked;
        document.ad.neg1.disabled=itemId.checked;
        document.ad.neg2.disabled=itemId.checked;

        if(itemId.checked)
        {
            document.getElementById('info11').style.display='inline'
        }else
        {
            document.getElementById('info11').style.display='none'
        }
    }


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
            <tr>
                <td>Rent per Month</td>
                <td><input type="text" style="width:100px;" id="price" maxlength="10" name="rentMonth" value="<%= ab.getRentMonth()%>" onKeyPress="return numbersonly(event, false)"  /></td>
                <td><input type="checkbox" id="cfp" name="cfp" <% if (ab.getCfp() != null) {%> checked <% }%> onclick="disableTotalCost(this)" /><span id="cfp1">Contact for price</span></td>
            </tr>
            <tr>
                <td >Negotiable</td>
                <td><input type="radio" id="neg1" name="neg" value="yes" checked   /> Yes &nbsp;&nbsp;<input type="radio" id="neg2"  name="neg" value="no" />No</td>
                <td style="width:250px;"><div id="info11" style="display:none;color:red;font-weight:normal;">&nbsp;&nbsp;Cost won't shown in Ad</div></td>
            </tr>
            <tr>
                <td width="100%">&nbsp;</td>
            </tr>
        </table>
        <table id="price2" style="display:none" class="verdana_form_postAd" >
            <tr>
                <td width="100%">&nbsp;</td>
            </tr>
            <tr style="width:400px;">
                <td>Rent per Month</td>
                <td style="width:300px;">Min <input style="width:100px;" maxlength="10"  type="text" id="min" name="min" value="<%= ab.getMin()%>" onKeyPress="return numbersonly(event, false)" /> - Max <input style="width:100px;" type="text" maxlength="10" id="max" name="max" value="<%= ab.getMax()%>" onKeyPress="return numbersonly(event, false)" /></td>
            </tr>
            <tr>
                <td width="100%">&nbsp;</td>
            </tr>
        </table>
        <script>
                <% if (ab.getAdType().equals("offered")) {%>
                document.getElementById('price1').style.display='inline'

                <% } else {%>
                document.getElementById('price2').style.display='inline'
                 <% }%>

               <% if (ab.getCfp() != null) {%>
               document.ad.price.disabled=true;
               document.ad.neg1.disabled=true
               document.ad.neg2.disabled=true;
               document.getElementById('info11').style.display='inline'
               <% }%>


               <% if (ab.getNeg() == null) {%>
               document.ad.neg1.checked=true;
                 <% } else if (ab.getNeg().equals("yes")) {%>
                 document.ad.neg1.checked=true;
                       <% } else {%>
                       document.ad.neg2.checked=true;
                        <% }%>
        </script>
    </div>
</logic:present>

<logic:notPresent name="editAdForUpdateBean" >
    <div style="clear:both;"  class="tilepad"  >
        <table id="price1" class="verdana_form_postAd" >
            <tr>
                <td width="100%">&nbsp;</td>
            </tr>
            <tr >
                <td>Rent per Month<font color="#FF0000">*</font></td>
                <td><input type="text" style="width:100px;" maxlength="10" id="price" name="rentMonth" onKeyPress="return numbersonly(event, false)" /></td>
                <td><input type="checkbox" id="cfp" name="cfp"  onclick="disableTotalCost(this)" /><span id="cfp1">Contact for price</span></td>
            </tr>
            <tr>
                <td>Negotiable</td>
                <td><input type="radio" id="neg1" name="neg" value="yes" checked   /> Yes &nbsp;&nbsp;<input type="radio" id="neg2"  name="neg" value="no" /> No</td>
                <td style="width:250px;"><div id="info11" style="display:none;color:red;font-weight:normal;">&nbsp;&nbsp;Cost won't shown in Ad</div></td>
            </tr>
            <tr>
                <td width="100%">&nbsp;</td>
            </tr>
        </table>
        <table id="price2" style="display:none" class="verdana_form_postAd" >
            <tr>
                <td width="100%">&nbsp;</td>
            </tr>
            <tr style="width:400px;">
                <td >Rent per Month</td>
                <td  style="width:300px;">Min <input style="width:100px;" maxlength="10" type="text" id="min" name="min" onKeyPress="return numbersonly(event, false)" /> - Max <input style="width:100px;" type="text" maxlength="10" id="max" name="max" onKeyPress="return numbersonly(event, false) " /></td>
            </tr>
            <tr>
                <td width="100%">&nbsp;</td>
            </tr>
        </table>
    </div>
</logic:notPresent>
