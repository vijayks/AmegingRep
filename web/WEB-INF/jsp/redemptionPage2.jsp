
<%@page import="com.buysell.util.BuySellProperties" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script type="text/javascript" language="javascript" src="js/alljs.js"></script>
<script type="text/javascript" language="javascript">
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

function validate(redem) {    
    var name=redem.name.value;
    var addr=redem.addr.value;
    var locality=redem.locality.value;
    var city=redem.city.value;
    var state=redem.state.value;
    var mobile=redem.mobile.value;

    var chk=false;

    var nameRegex = /^[a-zA-Z]+(([\'\,\.\- ][a-zA-Z ])?[a-zA-Z]*)*$/;
    var mobileRegex= /^([98]{1})([0123456789]{1})([0-9]{8})$/;

    if(name == "") {        
        inlineMsg('name','You must enter your name.');
        chk=false;
    }
    else if(!name.match(nameRegex)) {
        inlineMsg('name','You have entered an invalid name.');
        chk=false;
    }
    else if(addr == "") {
        inlineMsg('addr','You must enter delivery address.');
        chk=false;
    }
    else if(locality == "")
    {
        inlineMsg('locality','You must enter locality');
        chk=false;
    }
    else if(city == "")
    {
        inlineMsg('city','You must enter city');
        chk=false;
    }
    else if(state == "")
    {
        inlineMsg('state','Please select state');
        chk=false;
    }
    else if(mobile == "") {
        inlineMsg('mobile','You must enter your phone number.');
        chk=false;
    }
    else if(!mobile.match(mobileRegex)) {
        inlineMsg('mobile','You have entered an invalid phone number.');
        chk=false;
    }
    else {
        return true;
    }
    return chk;
}
</script>

<div id="masterrightbodybg" style="margin:5px 0 0 0;clear:both" >
    <div class="pt"><div class="pb"><div class="pl"><div class="pr"><div class="pbl"><div class="pbr"><div class="ptl"><div class="ptr">
                                    <table width="730"><td>

                                            <form action="redemption.do" id="redem" method="POST" name="redem" onsubmit="return validate(this);">

                                                <input  type="hidden" name="itemSelected" value="<c:if test='${itemSelected != null}'>${itemSelected}</c:if>" />
                                                <input  type="hidden" name="itemValue" value='<c:if test="${points != null}">${points}</c:if>' />


                                                <div style="padding-top:15px; padding-left:10px;" width="100%" valign="top" class="verdana_form_mainhead">Redemption Page</div>
                                                <div   style="width:730px;height:1px;background-color:#FFCC33;"></div>
                                                <div style="width:720px;height:15px;"></div>
                                                <div  class="verdana_form_head"  style="width:730px;height:20px;background-color:#E5E5E5;">&nbsp;Item Information</div>

                                                <div class="fv12bc" style="width:720px;float:left;padding-left:10px;padding-top:15px;">

                                                    <div style="width:180px;float:left;height:20px;">Item Selected</div><div style="width:20px;float:left;height:20px;">:</div><div  class="fv12b" style="color:#000000;width:520px;float:left;height:20px;"><c:if test="${itemSelected != null}">${itemSelected}</c:if></div>
                                                    <div style="width:180px;float:left;height:20px;">Required Points</div><div style="width:20px;float:left;height:20px;">:</div><div  class="fv12b" style="color:#000000;width:520px;float:left;height:20px;">
                                                    <c:if test="${points != null}">${points}</c:if></div>
                                                    <div style="width:180px;float:left;height:20px;">Current Balance</div><div style="width:20px;float:left;height:20px;">:</div><div   class="fv12b" style="color:#000000;width:520px;float:left;height:20px;"><c:if test="${current != null}">${current}</c:if></div>
                                                    <div style="width:180px;float:left;height:20px;">Quantity</div><div style="width:20px;float:left;height:20px;">:</div>
                                                    <div   class="fv12b" style="color:#000000;width:520px;float:left;height:20px;">
                                                        <select name="qty"  >
                                                            <option value="1">1</option>
                                                            <option value="2">2</option>
                                                            <option value="3">3</option>
                                                            <option value="4">4</option>
                                                            <option value="5">5</option>
                                                        </select>
                                                    </div>
                                                </div>
                                                <div style="clear:both;"></div>
                                                <table border="0" cellpadding="2" cellspacing="3" style="border-collapse: collapse" bordercolor="#111111" width="100%" >
                                                    <tr>
                                                        <td width="100%" valign="top">&nbsp;</td>
                                                    </tr>
                                                    <tr>
                                                        <td class="verdana_form_head" width="100%" valign="top" bgcolor="#E5E5E5"><b>&nbsp;Item Deliver Information</b></td>
                                                    </tr>
                                                    <tr>
                                                        <td width="100%" valign="top" >&nbsp;</td>
                                                    </tr>

                                                    <tr>
                                                        <td width="100%">
                                                            <table class="verdana_form" cellpadding="2" style=""  width="100%"  cellspacing="3" >

                                                                <tr>
                                                                    <td width="20%"></td>
                                                                    <td width="80%">( Please provide correct address details. Following details are used to deliver the item selected )</td>
                                                                </tr>


                                                                <tr >
                                                                    <td width="20%"  ><b>Deliver To</b><font color="red">*</font>(name)</td>
                                                                    <td  width="80%" ><input  style="width:250px"  size="20" maxlength="50"  type="text" id="name" name="name"></td>
                                                                </tr>

                                                                <tr >
                                                                    <td width="20%"><b>Address<font color="red">*</font></b></td>
                                                                    <td width="80%">
                                                                        <textarea type="text"  name="addr" id="addr" rows="5" cols="30" onKeyDown="limitText(this.form.addr,this.form.countdown,500);" onKeyUp="limitText(this.form.addr,this.form.countdown,500);"></textarea>
                                                                    </td>
                                                                </tr>

                                                                <tr >
                                                                    <td width="20%" ><b>Locality</b><font color="red">*</font></td>
                                                                    <td  width="80%" ><input  style="width:250px" name="locality" id="locality" size="20" maxlength="50"  type="text" ></td>
                                                                </tr>

                                                                <tr >
                                                                    <td width="20%" ><b>City</b><font color="red">*</font></td>
                                                                    <td  width="80%" ><input  style="width:250px" name="city" id="city" size="20" maxlength="50"  type="text" ></td>
                                                                </tr>

                                                                <tr >
                                                                    <td width="20%" ><b>State</b><font color="red">*</font></td>
                                                                    <td  width="80%" >
                                                                        <select name="state" id="state" style="width:253px" >
                                                                            <option value="">Select State</option>
                                                                            <option value="AndhraPradesh">Andhra Pradesh</option>
                                                                            <option value="Karataka">Karanataka</option>
                                                                        </select>
                                                                    </td>
                                                                </tr>
                                                                <tr >
                                                                    <td width="20%" ><b>Country</b><font color="red">*</font></td>
                                                                    <td  width="80%" ><input  style="width:250px" name="country" value="India" readonly size="20" maxlength="50"  type="text" name="name"></td>
                                                                </tr>



                                                                <tr >
                                                                    <td width="20%"  ><b>Mobile</b><font color="red">*</font></td>
                                                                    <td  width="80%" ><input  style="width:250px" name="mobile" id="mobile" size="20" maxlength="10"  type="text" onKeyPress="return numbersonly(event, false)" ></td>
                                                                </tr>




                                                                <!--  <tr>
                                                                      <td width="20%"  ><b>Deliver Date</b><font color="red">*</font></td>
                                                                      <td>

                                                                          <select name="day" id="day" style="width:80px" >
                                                                              <option selected="true" value="">day</option>

                                                                              <option value="1"> 1</option>
                                                                              <option value="2"> 2</option>
                                                                              <option value="3"> 3</option>
                                                                              <option value="4"> 4</option>
                                                                              <option value="5"> 5</option>
                                                                              <option value="6"> 6</option>
                                                                              <option value="7"> 7</option>
                                                                              <option value="8"> 8</option>
                                                                              <option value="9"> 9</option>
                                                                              <option value="10">10</option>
                                                                              <option value="11">11</option>
                                                                              <option value="12">12</option>
                                                                              <option value="13">13</option>
                                                                              <option value="14">14</option>
                                                                              <option value="15">15</option>
                                                                              <option value="16">16</option>
                                                                              <option value="17">17</option>
                                                                              <option value="18">18</option>
                                                                              <option value="19">19</option>
                                                                              <option value="20">20</option>
                                                                              <option value="21">21</option>
                                                                              <option value="22">22</option>
                                                                              <option value="23">23</option>
                                                                              <option value="24">24</option>
                                                                              <option value="25">25</option>
                                                                              <option value="26">26</option>
                                                                              <option value="27">26</option>
                                                                              <option value="28">28</option>
                                                                              <option value="29">29</option>
                                                                              <option value="30">30</option>
                                                                              <option value="30">31</option>

                                                                          </select>

                                                                          <select name="month" id="month" style="width:86px" >
                                                                              <option selected="true" value="">month</option>
                                                                              <option value="1">January</option>
                                                                              <option value="2">February</option>
                                                                              <option value="3">March</option>
                                                                              <option value="4">April</option>
                                                                              <option value="5">May</option>
                                                                              <option value="6">June</option>
                                                                              <option value="7">July</option>
                                                                              <option value="8">August</option>
                                                                              <option value="9">September</option>
                                                                              <option value="10">October</option>
                                                                              <option value="11">November</option>
                                                                              <option value="12">December</option>
                                                                          </select>

                                                                          <select name="year" id="year" style="width:80px" >
                                                                              <option selected value="">year</option>

                                                                              <option value="2009">2009</option>
                                                                              <option value="2010">2010</option>
                                                                              <option value="2011">2011</option>
                                                                              <option value="2012">2012</option>

                                                                          </select>
                                                                      </td>
                                                                  </tr>-->
                                                                <tr>
                                                                    <td width="20%"></td>
                                                                    <td width="80%"> Delivery of selected item will takes  10 - 15 days from ordered date.</td>
                                                                </tr>

                                                            </table>

                                                        </td>

                                                    </tr>

                                                    <tr>
                                                        <td width="100%">&nbsp;</td>
                                                    </tr>
                                                    <tr>
                                                        <td width="100%">
                                                            <table class="verdana_form" cellpadding="2" style=""  width="100%"  cellspacing="3" >
                                                                <tr>
                                                                    <td width="35%"></td>
                                                                    <td width="65%" align="left" >
                                                                        <input type="submit" value="Order Item">
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>

                                                    <tr>
                                                        <td width="100%">&nbsp;</td>
                                                    </tr>


                                                </table>
                                            </form>
                                        </td>
                                    </table>
                                </div></div></div></div></div></div></div></div>
</div>