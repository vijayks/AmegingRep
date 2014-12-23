<%--
    Document   : myAccount_ChangeMobile
    Created on : Jul 9, 2011, 11:55:40 AM
    Author     : bbsadmin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<script type="text/javascript">

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

function mobChange(){
    var mobile = document.getElementById("mobile").value;
    var mobileRegex= /^([987]{1})([0123456789]{1})([0-9]{8})$/;

    if(mobile == ""){
        inlineMsg('mobile',"Enter Your New Mobile Number");
        return false;
    }else if(!mobile.match(mobileRegex)) {
        inlineMsg('mobile',"You have entered an invalid phone number.");
        return false;
    }
    mobAjax(0);
}

function verificationCode(){
    var code = document.getElementById("verCode").value;
    if(code == ""){
        inlineMsg('vConfirm',"Enter your verification code.");
        return false;
    }
    verCode();
}

function resendCode(){
    mobAjax(1);
}
</script>

<div style="height:5px;"> </div>

<div style="color:#FF9600;"><div style="padding-top:15px">Change My Mobile Number</div></div>

<div id="chgMob" style="width:600px;padding-top:30px;clear:both;display:block">

    <table id="chang" class="verdana_form" >
        <tr>
            <td><b>Old Mobile No : </b></td>
            <td><input type="text" maxlength="10" readonly name="mobile" style="height:18px" value="${userBean.mobile}"></td>
        </tr>
        <tr>
            <td style="padding-top:10px"><b>New Mobile No : </b></td>
            <td style="padding-top:10px"><input type="text" id="mobile" style="height:18px" name="mobil" maxlength="10" onKeyPress="return numbersonly(event, false)" ></td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td><span style="font-size:90%;">Please Dont add any prefix like 0 (or) +91 </span></td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td style="padding-top:20px"><input type="image" src="bbsimages/buttons/Update.png" onmouseover="this.src='bbsimages/buttons/Update_MouseOver.png';" onmouseout="this.src='bbsimages/buttons/Update.png';" onclick="return mobChange(this);"></td>
            <td id="lding" style="padding-top:25px;float:left;display:none"><img src="images/loading.gif" style="height:20px" alt="wait"></td>
        </tr>
    </table>

</div>

        <div id="sentMobT" style="width:600px;padding:20px 0 0 120px;display:none">
            <span style="color:green;font-size:small">Verification code is sent to your new mobile number. Please verify it.</span>
            <div style="padding-top:10px" class="verdana_form">
                <b>Enter verification code : </b><input type="text" id="verCode" name="vcode" style="width:130px"> <input type="submit" id="vConfirm" value="Confirm" onclick="return verificationCode(this);">
            </div>
            <div style="padding:10px 0 0 45px"><input type="submit" value="Resend Mobile Code" onclick="resendCode(this);"> <a title="Cancel" href="myAccount_EditMyProfile.do"><input type="submit" value="Cancel"></a></div>
        </div>

        <div id="sentMobF" style="padding:20px 0 0 120px;display:none;color:red;font-size:small">Sending verification code to new mobile number failed. Please try again.</div>

        <%--<div id="resendT" style="padding:20px 0 0 220px;display:none;color:green;font-size:small">Resend mobile code is successfull.</div>

        <div id="resendF" style="padding:20px 0 0 220px;display:none;color:red;font-size:small">Resend mobile code is failure.</div>

        <div id="verifF" style="padding:20px 0 0 220px;display:none;color:red;font-size:small">Verification code is wrong.</div>

        <div id="verifT" style="padding:20px 0 0 220px;display:none;color:green;font-size:small">Verification code is success.</div>

        <div id="verifE" style="padding:20px 0 0 220px;display:none;color:red;font-size:small">Error is occurred.</div>--%>

       <div id="mobChangeT" style="padding:20px 0 0 220px;color:green;font-size:small"></div>

       <div id="mobChangeF" style="padding:20px 0 0 220px;color:red;font-size:small"></div>
