<%--
    Document   : loginbody
    Created on : Mar 13, 2009, 8:07:31 PM
    Author     : Karteek
--%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script>
    function isEmptys()
    {
        var check=true
        oFormObject = document.loginform;
        var pw = oFormObject.pwd.value;
        var lnm = oFormObject.loginName.value;
        if( (pw.length == 0 || pw=='Password') && (lnm.length == 0 || lnm=='Login Email'))
        {
            alert("Please enter Login Name and Password!");
            check=false;
        }
        else if( pw.length == 0 || pw=='Password' )
        {   alert("Please enter Password!");
            check=false;
        }
        else if( lnm.length == 0 || lnm=='Login Email')
        {
            alert("Please enter Login Name");
            check=false;
        }
        else if(check != false){

            oFormObject.submit();
        }
        return check;
    }
</script>
<script>
    function clearLogindata()
    {     /* txtEmail
          pass1
          ln msgfpldiv
          by*/
    <%-- document.getElementById("txtEmail").value="";--%>
            document.getElementById("pass1").value="Password";
    <%-- document.getElementById("ln").value="";--%>
            document.getElementById("mn").value="Mobile No.";
            document.getElementById("msgfpldiv").innerHTML=" ";
        }
        function disl()
        {
            document.getElementById("loginBodydiv").style.display="block";
            document.getElementById("forpDiv").style.display="none";
            clearLogindata();
        }
        function disf()
        {
            document.getElementById("loginBodydiv").style.display="none" ;
            document.getElementById("forpDiv").style.display="block" ;
            clearLogindata();
        }
</script>
<!-- login box div start here -->
<c:if test="${logout != null}"><br/><span style="color:#046dbe;margin-left:230px;font-size:20px"> <c:out value="${logout}" /></span></c:if>
<div class="login_inner_mt_cont" style="margin:25px 0 25px 0;">
    <!-- Start Register  -->
    <div class="login_page_1_bg">
        <div class="login_inner_cont_01">
            <div class="login_small_logo"></div>
            <div class="new_to_ameging"> New to Ameging ?</div>
            <div class="join_txt">
                *  Join the largest growing community of Ameging.<br />
                *  Ameging is your one-stop destination to meet millions.<br />
                *  Post your Ad & Boost your business opportunities.<br />
                *  Explore your world of opportunities.</div>
            <div class="register_now_button"><a title="Register" href="register.do"></a></div>
        </div>
    </div>
    <!-- End Register  -->
    <!-- Start login and reset password--->
    <div class="login_page_2_bg">
        <div></div>
        <div class="login_inner_cont_02">
            <!-- login-->
            <div style="float:left;" id="loginBodydiv">
                <form name="loginform" method="post" action="validate.do" >
                    <div class="login_small_logo_2"></div>
                    <input type="hidden" name="from" value="normalLogin" />
                    <div class="sign_txt">Sign in</div>
                    <div>
                        <c:if test='${lname == null}'>
                            <input type="text" name="loginName" id="txtEmail" class="login_email_box" border="0" value="Login Email" onblur="if(this.value == '') this.value = 'Login Email'" onfocus="if(this.value == 'Login Email') this.value = ''" />
                        </c:if>
                        <c:if test='${lname != null}'>
                            <input type="text" name="loginName" id="txtEmail" class="login_email_box" border="0" value="${lname}"/>
                        </c:if>
                    </div>
                    <div> <input type="text" name="pwd"  maxlength="50" id="pass1" class="login_email_box" border="0" value="Password" onblur="if(this.value == '') {this.type='text';this.value = 'Password'}" onfocus="this.type='password';if(this.value == 'Password') this.value = ''"   /> </div>
                    <div class="forgot_password"><a href="#" onclick="disf();event.returnValue=false;return false;">Forgot Password</a></div>
                    <div style="width:260px;float:left;text-align:center;height:12px">
                        <% if(request.getAttribute("res") != null) {  %>
                        <div class="fv12bc" style="margin-top:2px;">
                            <span id="loginE" style="color:red"> Invalid UserId or password </span>
                        </div><% } %></div>
                    <div class="sign_in_button" ><a onclick="return isEmptys()"></a></div>
                </form>
            </div>
            <!-- forgot password  starts-->
            <div id="forpDiv" style="display:none;">
                <form  method="post" action="#" >
                    <div class="login_small_logo_3" ></div>
                    <div class="sign_txt">Forgot Your Password :</div>
                    <div> <input type="text" name="loginName"  maxlength="50" id="ln" class="login_email_box" border="0" value="Login Email" onblur="if(this.value == '') this.value = 'Login Email'" onfocus="if(this.value == 'Login Email') this.value = ''" /> </div>
                    <div> <input type="text" name="mn"  maxlength="50" class="login_email_box" id="mn" border="0" value="Mobile No." onblur="if(this.value == '') this.value = 'Mobile No.'" onfocus="if(this.value == 'Mobile No.') this.value = ''" /> </div>
                    <div style="width:260px;float:left;text-align:center;margin-top:5px;height:12px;">
                        <div id="fpldiv" style="display:none;"> <span id="imgfpldiv" style="margin:10px 0 0 50px"> Loading... </span>
                            <span class="fv12bc" id="msgfpldiv" style="width:260px;float:left;text-align:center;margin-top:5px"></span>
                        </div></div>
                    <div class="log_in_button" style="margin-top:23px;"><a href="#" onclick="disl();event.returnValue=false;return false;"></a></div>
                    <div class="register1_now_button" style="margin:25px 30px 0 0;"><a onclick="ForgetPassword(document.getElementById('ln').value+'&mobile='+document.getElementById('mn').value,'fpldiv');event.returnValue=false;return false;"></a></div>
                </form>
            </div>
            <!-- forgot password ends -->
        </div>
        <!-- End login and reset password--->
    </div>
</div>
