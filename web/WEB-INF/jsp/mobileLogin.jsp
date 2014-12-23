<%@page import="com.buysell.beans.UserBean" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<script type="">
    function toggle_openDiv(itemId)
    {
        if(document.getElementById(itemId).style.display == 'none')
        {
            document.getElementById(itemId).style.display = 'inline';
            document.getElementById("details").style.display = "none";
        }
        else
        {
            document.getElementById(itemId).style.display = 'none';
            document.getElementById("details").style.display = "inline";
        }
    }
    function passwordEqualorNot(chpwd)
    {
        var chk;
        var newPWD=chpwd.newPWD.value;
        var newPWD1=chpwd.newPWD1.value;

        if(newPWD == "")
        {
            inlineMsg('newPWD', "Please Enter New password");
            chk=false;
        }
        else if(newPWD.length < 6)
        {
            inlineMsg('newPWD', "Password length should be minimum 6 characters ");
            chk=false;
        }
        else if(newPWD != newPWD1)
        {

            inlineMsg('newPWD1', "Two passwords not equal ");
            chk=false;
        }else
        {
            chk=true;
        }

        return chk;
    }
</script>
<% UserBean ub = (UserBean) request.getSession().getAttribute("userBean");%>

<%--<div style="font-size:12px;color:#046dbe;margin:0 auto">
    <c:if test="${quickRegSave != null}" >
        your registration completed and ad saved successfully
        <%
            request.getSession().removeAttribute("quickRegSave");
        %>
    </c:if>
    <c:if test="${quickRegSaveSearch != null}" >
        your registration completed and ur search saved successfully.
        <%
            request.getSession().removeAttribute("quickRegSaveSearch");
        %>
    </c:if>
    <c:if test="${quickRegSendSms != null}">
        your registration completed  successfully. <br />
        To send sms to advertiser you need to verify your mobile or Email.
        <%
            request.getSession().removeAttribute("quickRegSendSms");
        %>
    </c:if>
    <c:if test="${quickRegSaveAlert != null}" >
        your registration completed  successfully. <br /> saved alert work incomplete
        <%
            request.getSession().removeAttribute("quickRegSaveAlert");
        %>
    </c:if>
    <c:if test="${quickRegEmail != null}">
        your registration completed  successfully. <br /> send sms to friend work incomplete.
        <%
            request.getSession().removeAttribute("quickRegEmail");
        %>
    </c:if>
</div>--%>

<div style="font-size:12px;margin:0 0 0 50px">
   
    <span style="color:#4d9edf;font-weight:600;font-size:13px;">Welcome to Bharatbuysell!</span>
    <br />
    <h3>Enjoy all the benefits of Bharatbuysell by verifying your Mobile or Email.</h3>


    <table width="600px"  height="112" id="details" style="background: #FFFFFF url(bbsimages/total.png) no-repeat;">
        <tr>
            <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
            <td>
                <table>
                    <tr><td><span style="color:#4d9edf;font-weight:600;">Login Name</span></td><td><span style="color:#4d9edf;font-weight:600;">:</span></td><td>${userBean.loginName}</td></tr>
                    <tr><td><span style="color:#4d9edf;font-weight:600;">Password</span></td><td><span style="color:#4d9edf;font-weight:600;">:</span></td><td>${userBean.pwd}</td></tr>
                </table>
            </td>
            <td align="right" style="padding-right:20px;"><a title="Change Password" href="#" style="color:#fff"onclick="toggle_openDiv('changePasswordDiv')" ><img src="bbsimages/password.png"></a></span></td>
        </tr>
    </table>
    <div id="changePasswordDiv" style="display:none;">
        <form action="changepwd.do" method="POST" name="chpwd" onsubmit="return passwordEqualorNot(this) ">
            <input type="hidden" value="2pwd" name="pwdfrom">
            <table width="600px" height="122" style="background: #FFFFFF url(bbsimages/total1.png) no-repeat;" >
                <tr><td>&nbsp;</td></tr>
                <tr>
                    <td align="right"><span style="color:#4d9edf;font-weight:600;">UserId:</span></td>
                    <td>&nbsp;</td>
                    <td>${userBean.loginName}</td>
                </tr>
                <tr>
                    <td align="right"><span style="color:#4d9edf;font-weight:600;">New Password:</span></td>
                     <td>&nbsp;</td>
                    <td><input type="password" name="newPWD" id="newPWD" ></td>
                </tr>
                <tr>
                    <td align="right"><span style="color:#4d9edf;font-weight:600;">Confirm Password:</span></td>
                     <td>&nbsp;</td>
                    <td><input type="password" name="newPWD1" id="newPWD1"></td>
                </tr>
                <tr>
                    <td></td>
                     <td>&nbsp;</td>
                    <td><input type="reset"  value="Clear"/>&nbsp;<input type="submit"  value="Change Password" onclick="passwordEqualorNot(this);"/></td>
                </tr>
                <tr><td>&nbsp;</td></tr>
            </table>
        </form>
    </div>



    <table width="600px;">
        <tr>
            <td><img src="bbsimages/Left_2.gif"></td>
            <td width=""><h4>Mobile Verification</h4>
                A verification code is sent to your mobile number ${userBean.pwd}, please enter the same in box appearing in the left menu.</td>
        </tr>
        <tr><td>&nbsp;</td><td>&nbsp;</td></tr>
        <tr>
            <td><img src="bbsimages/Mail.jpg"></td>
            <td><h4>Email Verification</h4>
                An email is sent to "${userBean.loginName}" with a verification link. Please click the link to verify the email ID.</td>
        </tr>
    </table>
        <br>  <br>
    <p style="width:600px;">
        <span style="color:#4d9edf;font-weight:600">Note:</span>Only the verified information will be shown to the other users on website. With out verification of provided data the information shall not be shown. Contact admin@bharatbuysell.com for any queries.</p>
    <br>  <br>
    <p style="width:610px;">Your Bharatbuysell ID gives you access to powerful classifieds portal where you can post an Ad, Search required products, Send information to friends, Contact advertiser via SMS, Save your favorite Ad's, Save searches, Set an alert, Refer a friend, Post articles, Earn BBS Points, Redeem for free gifts and many more...&nbsp;&nbsp;<span style="color:#000000;font-weight:600">--all for Free</span></p>

</div>
<div id="mobileVerificationDiv" style="display:none">
</div>
<div id="resendEmailVerificationDiv" style="display:none">
</div>


