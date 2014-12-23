
<%@page  import="com.buysell.beans.PostAdFormBean" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>


<%--<script src="js/regCodeValidateAjax.js" type="text/javascript"></script>--%>

<script type="text/javascript" language="javascript">
    var count=0;
    function changeVrificationCode1()
    {
        document.getElementById("regCode").value="";

        document.getElementById("codeTestNo").style.display='none';
        document.getElementById("codeTestYes").style.display='none';

        toggle_disable('rButtonDis','rButton');
        count++;
        document.getElementById('verId1').src='rig?1='+count;
    }

</script>

<script type="text/javascript">
    $(document).ready(function() {
        locationDD();
    })
    function locationDD()
    {
        try {
            oHandler = $("#location").msDropDown({mainCSS:'dd12'}).data("dd");
            //alert($.msDropDown.version);
            //$.msDropDown.create("body select");
            $("#ver").html($.msDropDown.version);
        } catch(e) {
            alert("Error: karthik"+e.message);
        }
    }
</script>
<script language="javascript">

    //For Phone number Validation//
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

// form validation function //
function regFormValidationNew() {
    var regform = document.regform;
    var userName=regform.userName.value;
    var firstName=regform.firstName.value;
    //var gender=regform.gender.value;

    //var day=regform.date.value;
    //var month=regform.month.value;
    //var year=regform.year.value;

    var city=regform.city.value;;
    var location=regform.location.value;
    var address=regform.address.value;

    var mobile=regform.mobile.value;
    var regCode=regform.regCode.value;

    var chk=false;


    <%--CheckRegCodeNew();--%>
        //       var qselection=regFormValidation.qselection.value;
        var nameRegex = /^[a-zA-Z]+(([\'\,\.\- ][a-zA-Z ])?[a-zA-Z]*)*$/;
        var emailRegex = /^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$/;
        var mobileRegex= /^([987]{1})([0123456789]{1})([0-9]{8})$/;
        if(userName == "") {
            alert('You must enter your email');
            chk=false;
        }
        else if(!userName.match(emailRegex)) {
            alert('You have entered an invalid email.');
            chk=false;
        }
        else if(!(document.getElementById("notValid").style.display == 'none'))
        {
            alert("username already exists");
            chk=false;

        }
        else if(firstName == "") {

            alert('You must enter your name.');
            chk=false;
        }
        else if(!firstName.match(nameRegex)) {
            alert('You have entered an invalid name.');
            chk=false;
        }
        /*else if(gender == "")
    {
        inlineMsg('gender','Please select gender.');
        chk=false;

    }else if(day == 0 || month == 0 || year == 0 )
    {
        inlineMsg('year','Please select  Date of Birth.');
        chk=false;
    }
    else if(!dateOfBirthValidation(regform))
    {
        inlineMsg('year','Please select Correct Date of Birth.');
        chk=false;
    }*/
        else if(city == "")
        {
            alert('Please select City');
            chk=false;
        }
        else if(location == "")
        {
            alert('Please select Location');
            chk=false;
        } else if(address == "") {
            alert('You must enter your Address.');
            chk=false;
        }else if(regform.address.value.length > 100){
            alert("You can't enter more than 100 Chars.");
            chk=false;
        }
        else if(mobile == "") {
            alert('You must enter your phone number.');
            chk=false;
        }
        else if(!mobile.match(mobileRegex)) {
            alert('You have entered an invalid phone number.');
            chk=false;
        }else if(regCode == "")
        {
            alert('Please Enter the code appear in the picture');
            chk=false;
        }
    <%-- else if(!getVerifCodeFlag())
     {
         alert("Verification code is wrong");
         chk=false;
     }--%>
         else if(!document.regform.iagree.checked)
         {
             alert("Please accept the terms and conditions ");
             chk=false;
         }
         else
         {
             document.regform.submit();
             chk=true;
         }

         return chk;
     }

</script>

<%--<script type="text/javascript" language="javascript" src="js/ajx.js"></script>
<script type="text/javascript" language="javascript" src="js/userIdAvailablityCheck.js"></script>--%>
<div id="masterrightbodybg" >
    <form id="regform" name="regform" method="POST" action="register1.do" autocomplete="off" enctype="multipart/form-data" onsubmit="return regFormValidationNew(this);" >
        <% String rId = request.getParameter("rId");
if (rId != null && rId.length() > 10) {
request.getSession().setAttribute("rId", rId);
        %>
        <input type="hidden" name="rId" value="<%= rId%>">
        <% }%>

        <!-- this paramenter get from tile in oder to identify from which page the registration come -->
        <%
PostAdFormBean pfb = (PostAdFormBean) request.getAttribute("pfb");
session.setAttribute("pfb", pfb);
        %>
        <% if (pfb == null) {%>
        <input type="hidden" id="normalRegistration"  name="regFrom" value="normalRegistration" />
        <%} else {%>
        <input type="hidden" id="normalRegistration" name="regFrom" value="postAdRegistration" />
        <% }%>
        <input type="hidden" name="type" value="user" />
        <div class="car_main_cont" >
            <div class="registering_part">
                <div class="registering_heading">Register with BharthBuySell for free!</div>
                <div class="registering_body_part">
                    <div class="registering_body_left_part">
                        <table width="430" border="0" cellspacing="0" cellpadding="0">
                            <tr> <td align="left" valign="top"><img src="bbsimages/New/r_login_icon.jpg" width="156" height="32" border="0" /></td> </tr>
                            <tr>
                                <td align="left" valign="top">
                                    <table width="348" border="0" cellspacing="0" cellpadding="0" style="float:right;">
                                        <tr>
                                            <td align="right" valign="middle" class="registering_txt1"  style="padding-bottom:15px;">Login Name <font color="#FF0000">*</font> </td>
                                            <td align="left" valign="middle">
                                                <input type="text" class="registering_input_txt" name="userName" id="userName" size="20" maxlength="50" value="<c:if test="${registerFormBean.userName!=null}"><c:out value="${registerFormBean.userName}" /></c:if>" onchange="isValidUserId('userName')"  />
                                                    <span style="font-size:90%;float:right;padding-right:5px;">A valid email address. </span>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td></td>
                                                <td>
                                                    <div id="valid" style="display: none;color:green;padding-left:40px;"> <b>This user Name Available</b> </div>
                                                    <div id="notValid" style="display:none;color:red;padding-left:40px;"> <b>User name already used</b> </div>
                                                    <span id="txtHint" style="visibility:hidden;" ></span>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr> <td align="left" valign="top"><img src="bbsimages/New/contact_icon.jpg" width="179" height="32" border="0" /></td> </tr>
                                <tr>
                                    <td align="center" valign="top"><table width="348" border="0" cellspacing="0" cellpadding="0" style="float:right; margin-top:10px;">
                                            <tr>
                                                <td align="right" valign="top" class="registering_txt1" >Name <font color="#FF0000">*</font> </td>
                                                <td align="left" valign="top" >
                                                    <input type="text" name="firstName" class="registering_input_txt" size="45" id="firstName" value="<c:if test="${registerFormBean.firstName!=null}"><c:out value="${registerFormBean.firstName}" /></c:if><c:if test="${pfb != null}"><c:out value="${pfb.fname}" /></c:if>"/>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="right" valign="top" class="registering_txt1">City <font color="#FF0000">*</font></td>
                                                <td align="right" valign="middle">
                                                    <select size="1"  id="city1" name="city" style="width:242px;" onchange="getLocalitiesR(this)">
                                                        <option value="" selected="true" >Select City</option>
                                                    <c:if test="${cities  != null }"> <c:forEach items="${cities}" var="city">
                                                            <option value="<c:out value='${city.name}'/>" ><c:out value="${city.name}"/></option>
                                                        </c:forEach> </c:if>
                                                    </select>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="right" valign="top" class="registering_txt1">Locality <font color="#FF0000">*</font></td>
                                                <td align="right" valign="middle">
                                                    <select size="1" id="location" style="width:242px;" name="location">
                                                        <option value="" selected="true"> Select Locality</option>
                                                    <c:if test="${locationClasses  != null}"> <c:forEach items="${locationClasses}" var="location">
                                                            <option value="<c:out value='${location.name}'/>"><c:out value="${location.name}"/></option>
                                                        </c:forEach> </c:if>
                                                    </select>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="right" valign="top" class="registering_txt1" style="padding-top:17px;">Address <font color="#FF0000">*</font></td>
                                                <td align="left" valign="middle">
                                                    <textarea id="address" class="registering_input_txt1" name="address"  ><% if (request.getAttribute("addressId") != null) {%><%= (String) request.getAttribute("addressId")%><% }%></textarea>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right" valign="top" class="registering_txt1">Mobile <font color="#FF0000">*</font></td>
                                            <td align="right" valign="middle">
                                                <input type="text" id="mobile" class="registering_input_txt" name="mobile" maxlength="10"  value="<c:if test='${pfb != null}'><c:out value='${pfb.ph1}' /></c:if>" onKeyPress="return numbersonly(event, false)" /> <br />
                                                <div style="font-family:Arial, Helvetica, sans-serif; font-size:12px; color:#333333; width:236px; float:right; margin-top:5px;">Please Don't add any prefix like (0) or +91</div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right" valign="top" class="registering_txt1" style="padding-top:15px;">Verfication Code </td>
                                            <td align="right" valign="middle">
                                                <div id="firstCode" style="display:inline"> <img alt="" id="verId1" src="rig" width="190" height="40"/>  </div>
                                                <div id="firstLink" style="display:inline"> <a title="Change Verification Code" class="link11"  href="javascript:return false;" onclick="changeVrificationCode1();event.returnValue=false;return false;" >
                                                        <img src="bbsimages/New/referesh_button.jpg" width="45" height="45" /></a> </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right" valign="top" class="registering_txt1" style="padding-top:15px;">Enter Code <font color="#FF0000">*</font> </td>
                                            <td align="left" valign="middle">
                                                <input id="regCode" name="regCode" class="registering_input_txt" type="text" onblur="CheckRegCode(this)" />
                                            </td>
                                        </tr>
                                        <tr><td></td><td>
                                                <span id="codeTestNo" style="color:red;display:none;padding-left:35px" >&nbsp;&nbsp;&nbsp;Verfication doesn't matched</span>
                                                <span id="codeTestYes" style="color:red;display:none;padding-left:35px" >Code Matched</span>
                                        </tr>
                                        <tr>
                                            <td align="right" valign="middle" class="registering_txt1">&nbsp;</td>
                                            <td align="left" valign="top">
                                                <div style="font-family:Arial, Helvetica, sans-serif; font-size:11px; color:#666666; width:200px;padding-top:5px">
                                                    <input type="checkbox" id="iagree" name="iagree" style="vertical-align:middle" />&nbsp;<a style="color:#222222" href="javascript:return false;" title="View Terms and Conditions" onclick="termsAndConditions('tc.do');event.returnValue=false;return false;" >I agree Terms & Conditions.</a>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right" valign="middle" class="registering_txt1">&nbsp;</td>
                                            <td align="left" valign="top">

                                                <input id="rButtonDis" type="image" style="float:left; width:117px; height:40px;margin-left:40px;" disabled src="bbsimages/New/reg_dis.png" onclick="return regFormValidationNew(this)" />
                                                <div id="rButton" class="registering_now_button" style="display:none"><a onclick="return regFormValidationNew(this)"></a></div></td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table> <br/>
                    </div>
                    <div class="registering_body_right_part">  <div class="registering_right_heading">Registering allows you....</div>
                        <div class="registering_right_menu">
                            <ul> <li><img src="bbsimages/New/tick1.png" style="float: left" />&nbsp;&nbsp;Post Free Ads</li>
                                <li><img src="bbsimages/New/tick1.png" style="float: left" />&nbsp;&nbsp;Manage Your Ads</li>
                                <li><img src="bbsimages/New/tick1.png" style="float: left" />&nbsp;&nbsp;Set Your Own Ad Alerts</li>
                                <li><img src="bbsimages/New/tick1.png" style="float: left" />&nbsp;&nbsp;You Can View The Advertiser Details</li>
                                <li><img src="bbsimages/New/tick1.png" style="float: left" />&nbsp;&nbsp;Save The Favourite Search</li>
                            </ul>
                        </div>
                        <%-- For Cart Hunt
                         <c:if test="${userBean!=null}">
                             <div align="center" style="margin-top:400px;"> <img src="bbsimages/New/cart1.png" width="50" height="50"/></div>
                             </c:if>
                             For Cart Hunt--%>
                    </div>
                </div>
            </div>
        </div>
    </form>
</div>
<script type="text/javascript">
    <% if (request.getAttribute("cityId") != null) {%>
    document.getElementById('city').value='<%= (String) request.getAttribute("cityId")%>';
    <% }%>
    <% if (request.getAttribute("locality") != null) {%>
    document.getElementById('location').value='<%= (String) request.getAttribute("locality")%>';
    <% }%>
</script>
<script type="text/javascript">
$(document).ready(function() {
    cityDD();
})
function cityDD()
{
    try {
        oHandler = $("#city1").msDropDown({mainCSS:'dd11'});
        //alert($.msDropDown.version);
        //$.msDropDown.create("body select");
        $("#ver").html($.msDropDown.version);
    } catch(e) {
        alert("Error: kiran"+e.message);
    }
}

</script>