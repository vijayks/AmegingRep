<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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

        try {
            oHandler = $("#qselection").msDropDown({mainCSS:'dd10'}).data("dd");
            //alert($.msDropDown.version);
            //$.msDropDown.create("body select");
            $("#ver").html($.msDropDown.version);
        } catch(e) {
            alert("Error: "+e.message);
        }
    })

</script>

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
    // form validation function //
    function validatet(form) {
        var form = document.form;
        var name = form.name.value;
        var regCode=form.regCode.value;
        var email = form.email.value;
        var qselection=form.qselection.value;
        var mobilef=form.mobilef.value;
        var limitedtextarea=form.limitedtextarea.value;
        var nameRegex = /^[a-zA-Z]+(([\'\,\.\- ][a-zA-Z ])?[a-zA-Z]*)*$/;
        var emailRegex = /^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$/;
        var mobileRegex= /^([98]{1})([0-9]{9})$/;
        if(qselection == "") {
            alert('Select Question/Comment.');
            return false;
        }
        else if(name == "") {
            alert('You must enter your name.');
            return false;
        }
        else if(!name.match(nameRegex)) {
            alert('You have entered an invalid name.');
            return false;
        }
        else if(email == "") {
            alert('You must enter your email.');
            return false;
        }
        else if(!email.match(emailRegex)) {
            alert('You have entered an invalid email.');
            return false;
        }
        else if(mobilef == "") {
            alert('You must enter your phone number.');
            return false;
        }
        else if(!mobilef.match(mobileRegex)) {
            alert('You have entered an invalid phone number.');
            return false;
        }
        else if(limitedtextarea == "") {
            alert('You must enter a message.');
            return false;
        }
        else if(regCode == "") {
            alert('You must enter a Verfy Code.');
            return false;
        }
        else
        {
            document.form.submit();
            chk=true;
        }
        return true;
    }
    // START OF MESSAGE SCRIPT //
    var MSGTIMER = 20;
    var MSGSPEED = 5;
    var MSGOFFSET = 3;
    var MSGHIDE = 3;
    // build out the divs, set attributes and call the fade function //
    function inlineMsg(target,string,autohide) {
        var msg;
        var msgcontent;
        if(!document.getElementById('msg')) {
            msg = document.createElement('div');
            msg.id = 'msg';
            msgcontent = document.createElement('div');
            msgcontent.id = 'msgcontent';
            document.body.appendChild(msg);
            msg.appendChild(msgcontent);
            msg.style.filter = 'alpha(opacity=0)';
            msg.style.opacity = 0;
            msg.alpha = 0;
        } else {
            msg = document.getElementById('msg');
            msgcontent = document.getElementById('msgcontent');
        }
        msgcontent.innerHTML = string;
        msg.style.display = 'block';
        var msgheight = msg.offsetHeight;
        var targetdiv = document.getElementById(target);
        targetdiv.focus();
        var targetheight = targetdiv.offsetHeight;
        var targetwidth = targetdiv.offsetWidth;
        var topposition = topPosition(targetdiv) - ((msgheight - targetheight) / 2);
        var leftposition = leftPosition(targetdiv) + targetwidth + MSGOFFSET;
        msg.style.top = topposition + 'px';
        msg.style.left = leftposition + 'px';
        clearInterval(msg.timer);
        msg.timer = setInterval("fadeMsg(1)", MSGTIMER);
        if(!autohide) {
            autohide = MSGHIDE;
        }
        // window.setTimeout("hideMsg()", (autohide * 1000));
    }
    // hide the form alert //
    function hideMsg(msg) {
        var msg = document.getElementById('msg');
        if(!msg.timer) {
            msg.timer = setInterval("fadeMsg(0)", MSGTIMER);
        }
    }
    // face the message box //
    function fadeMsg(flag) {
        if(flag == null) {
            flag = 1;
        }
        var msg = document.getElementById('msg');
        var value;
        if(flag == 1) {
            value = msg.alpha + MSGSPEED;
        } else {
            value = msg.alpha - MSGSPEED;
        }
        msg.alpha = value;
        msg.style.opacity = (value / 100);
        msg.style.filter = 'alpha(opacity=' + value + ')';
        if(value >= 99) {
            clearInterval(msg.timer);
            msg.timer = null;
        } else if(value <= 1) {
            msg.style.display = "none";
            clearInterval(msg.timer);
        }
    }
    // calculate the position of the element in relation to the left of the browser //
    function leftPosition(target) {
        var left = 0;
        if(target.offsetParent) {
            while(1) {
                left += target.offsetLeft;
                if(!target.offsetParent) {
                    break;
                }
                target = target.offsetParent;
            }
        } else if(target.x) {
            left += target.x;
        }
        return left;
    }
    // calculate the position of the element in relation to the top of the browser window //
    function topPosition(target) {
        var top = 0;
        if(target.offsetParent) {
            while(1) {
                top += target.offsetTop;
                if(!target.offsetParent) {
                    break;
                }
                target = target.offsetParent;
            }
        } else if(target.y) {
            top += target.y;
        }
        return top;
    }
    FeedBack='no';
</script>
<style>
    #msg {display:none; position:absolute; z-index:200; background:url(images/msg_arrow.gif) left center no-repeat; padding-left:7px}
    #msgcontent {display:block;color:#f00;font-size:12px;padding:5px; min-width:150px; max-width:250px}
</style>

<div class="car_main_cont" >
    <form method="post" name="form" id="form" action="feedBack.do" onsubmit="return validatet(this)" >
        <div class="customer_support_part">
            <div  class="customer_support_heading">Bharat Buysell Customer Support & Feedback Form
                <p>If you have any questions or comments about Bharatbuysell.com, Please check <a title="Click here to clear your queries" href="help.do" style="color:#046dbe;font-weight:bold;text-decoration:none;" onmouseout="style.color='#046dbe'" onmouseover="style.color='#FF7600'">Help</a> to view our
                    FAQ's. If you are unable to locate an answer for your question.</p>
                <p style="margin-top:5px;">please complete the following form and click "Submit". Our team will get back to you soon.</p>
            </div>
            <div class="customer_support_form_bg">
                <table width="482" border="0" cellspacing="0" cellpadding="0" style="float:left; margin-left:96px; margin-top:25px;">
                    <tr>
                        <td align="left" valign="top" class="customer_support_form_txt" >Subject <font color="#FF0000">*</font> </td>
                        <td align="left" valign="top"><select name="qselection" id="qselection" style="width:342px;" tabindex="1">
                                <option value="">Select the type of question / comment</option>
                                <option value="1">I have a question regarding Special Ad posting</option>
                                <option value="2">I would like more information on business advertising</option>
                                <option value="3">I have a question regarding My account</option>
                                <option value="4">I want more information on Dealer Registration Process</option>
                                <option value="5">I have a Technical question</option>
                                <option value="6">I have a General question</option>
                                <option value="7">I have a comment / suggestion</option>
                                <option value="8">I would like to report a possible bug</option>
                                <option value="9"> Other ...</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td align="left" valign="top" class="customer_support_form_txt">Name <font color="#FF0000">*</font> </td>
                        <td align="left" valign="top"> <input id="name" type="text" name="name"  class="customer_support_input_txt" onkeypress="hideMsg(1)" /></td>
                    </tr>
                    <tr>
                        <td align="left" valign="top" class="customer_support_form_txt">Email <font color="#FF0000">*</font> </td>
                        <td align="left" valign="top"> <input id="email" name="email" type="text"  class="customer_support_input_txt"/></td>
                    </tr>
                    <tr>
                        <td align="left" valign="top" class="customer_support_form_txt">Moblie <font color="#FF0000">*</font> </td>
                        <td align="left" valign="top"> <input id="mobilef" name="mobilef" type="text" class="customer_support_input_txt" onKeyPress="return numbersonly(event, false)" /> </td>
                    </tr>
                    <tr>
                        <td align="left" valign="top" class="customer_support_form_txt" style="height:10px;">Question / Comment</td>
                        <td align="left" valign="top"> <textarea name="limitedtextarea" id="limitedtextarea" class="customer_support_input_txt1"onKeyDown="limitText(this.form.limitedtextarea,this.form.countdown,1000);" onKeyUp="limitText(this.form.limitedtextarea,this.form.countdown,1000);"></textarea>
                            <table width="331" border="0" cellspacing="0" cellpadding="0" style="float:left; padding-bottom:12px;">
                                <tr>
                                    <td align="left" valign="top" class="customer_support_small_txt">(Maximum characters 1000) &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;You have </td>
                                    <td align="left" valign="top"> <input readonly type="text" name="countdown" size="3" value="1000" style="width:53px; height:17px; float:left; border:1px solid #666666; font-family:Arial, Helvetica, sans-serif; font-size:11px;" /></td>
                                    <td align="left" valign="top"  class="customer_support_small_txt">characters left </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td align="left" valign="top" class="customer_support_form_txt">Verification Code</td>
                        <td align="left" valign="top"> <div id="firstCode" style="display:inline"><img alt="" id="verId1" src="rig" style="height:40px;width:200px"/></div>
                            <div id="firstLink" style="display:inline">
                                <a title="Change Verification Code" class="link11"  href="javascript:return false;" onclick="changeVrificationCode1();event.returnValue=false;return false;" > <img src="bbsimages/referesh_button.jpg" border="0"  style="height:40px;" /></a>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td align="left" valign="top" class="customer_support_form_txt">Enter Code</td>
                        <td align="left" valign="top"> <input id="regCode" name="regCode" type="text" class="customer_support_input_txt2" onblur="CheckRegCode(this)" /></td>
                    </tr>
                    <tr>
                        <td></td>
                        <td> <span id="codeTestNo" style="color:red;display:none;font-size:12px" >&nbsp;&nbsp;&nbsp;Verification doesn't matched</span>
                            <span id="codeTestYes" style="color:red;display:none;font-size:12px" >Code Matched</span>
                        </td>
                    </tr>
                    <tr>
                        <td align="left" valign="top">&nbsp;</td>
                        <td align="left" valign="top" class="customer_support_submit"><a onclick="return validatet(this)"></a></td>
                    </tr>
                    <tr>
                        <td align="left" valign="top">&nbsp;</td>
                        <td align="left" valign="top" class="customer_support_thanks_txt">** Thanks for your interest in BharatBuySell **</td>
                    </tr>
                </table>
              <%--  For Cart Hunt
                <c:if test="${userBean!=null}">
                <div align="right" style="padding-top:470px;"> <img src="bbsimages/New/cart3.png" width="50" height="50"/></div>
                </c:if>
                For Cart Hunt--%>
            </div>
        </div>
    </form>
</div>
