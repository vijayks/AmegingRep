<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%@page import="com.buysell.beans.UserBean" %>
<% UserBean ub = (UserBean) request.getSession().getAttribute("userBean");%>

<script>


    function changePasswordValidation(cpd)
    {

        var chk;
        var oldPWD=cpd.oldPWD.value;
        var newPWD=cpd.newPWD.value;
        var newPWD1=cpd.newPWD1.value;


        if(oldPWD == "")
        {
            inlineMsg('oldPWD','Please enter old password');
            chk=false;
        }
        else if(oldPWD != '<%= ub.getPwd()%>')
        {
            inlineMsg('oldPWD',' Entered old password wrong');
            chk=false;
        }else if(newPWD == "")
        {
            inlineMsg('newPWD',' Please enter new password');
            chk=false;
        }else if(newPWD.length < 6)
        {
            inlineMsg('newPWD',' Password length should be minimum 6 characters');
            chk=false;
        }else if(newPWD1 != newPWD)
        {
            inlineMsg('newPWD1',' Retype password not matched.');
            chk=false;
        }else
        {
            chk=true;
        }
        return chk;
    }

    <%--
        function isOldPwdRight()
        {

        oFormObject = document.forms[1];

        if(oFormObject.elements["oldPWD"].value.length > 0 && oFormObject.elements["oldPWD"].value != '<%= ub.getPwd()%>' )
        {
            document.getElementById('pwdWrong').style.display='inline';
            document.getElementById('pwdRight').style.display='none';

        }
        else if(oFormObject.elements["oldPWD"].value.length > 0 && oFormObject.elements["oldPWD"].value == '<%= ub.getPwd()%>')
        {
            document.getElementById('pwdWrong').style.display='none';
            document.getElementById('pwdRight').style.display='inline';
            isEligibleToSubmit();
        }

    }

    function isNewDiffFromOld()
    {

        oFormObject = document.forms[1];

        if(oFormObject.elements["newPWD"].value.length > 0 && oFormObject.elements["newPWD"].value  ==  '<%= ub.getPwd()%>' )
        {
            document.getElementById('newWrong').style.display='inline';

        }
        else if(oFormObject.elements["newPWD"].value.length > 0 && oFormObject.elements["newPWD"].value  !=  '<%= ub.getPwd()%>' )
        {
            document.getElementById('newWrong').style.display='none';
            isEligibleToSubmit();
        }




    }

    function isRetypeRight()
    {

        oFormObject = document.forms[1];

        if( oFormObject.elements["newPWD"].value.length > 0 &&  oFormObject.elements["newPWD1"].value.length > 0 && oFormObject.elements["newPWD1"].value != oFormObject.elements["newPWD"].value )
        {
            document.getElementById('rtWrong').style.display='inline';
            document.getElementById('rtRight').style.display='none';

        }
        else if( oFormObject.elements["newPWD"].value.length > 0 &&  oFormObject.elements["newPWD1"].value.length > 0 && oFormObject.elements["newPWD1"].value == oFormObject.elements["newPWD"].value)
        {
            document.getElementById('rtWrong').style.display='none';
            document.getElementById('rtRight').style.display='inline';
            isEligibleToSubmit();
        }

    }

    function isEligibleToSubmit()
    {

        oFormObject = document.forms[1];


        if(oFormObject.elements["oldPWD"].value.length > 0 && oFormObject.elements["oldPWD"].value == '<%= ub.getPwd()%>' && oFormObject.elements["newPWD"].value.length > 0 && oFormObject.elements["newPWD"].value  !=  '<%= ub.getPwd()%>' &&  oFormObject.elements["newPWD1"].value.length > 0 && oFormObject.elements["newPWD1"].value == oFormObject.elements["newPWD"].value )
        {
            toggle_enable('changePwdButtonDis','changePwdButton');

        }
    }--%>
</script>

<div id="masterrightbodybg"  >
    <div class="verdana_form_mainhead"><div style="padding-top:6px">Change My Password</div></div>

    <form name="cpd" action="changepwd.do" method="POST" onsubmit="return changePasswordValidation(this)" style="padding-left:140px;padding-top:30px">
        <input type="hidden" value="3pwd" name="pwdfrom">
        <table style="">
            <tr class="verdana_form">
                <td ><b>Enter Old Password </b><span style="color:red" > * </span></td>
                <td><input type="password" id="oldPWD" name="oldPWD" style="width:150px;height:18px" <%--onblur="isOldPwdRight()"--%> ><div id="pwdRight" style="display:none">&nbsp;&nbsp;<img src="bbsimages/pwdRight.bmp">Correct Password </div><div id="pwdWrong" style="display:none">&nbsp;&nbsp;<img src="bbsimages/pwdWrong.bmp"><span style="color:red" >&nbsp;&nbsp; Old Password is wrong </span> </div></td>
            </tr>
            <tr><td style="padding-bottom:5px"></td></tr>
            <tr class="verdana_form">
                <td><b>Enter New Password </b><span style="color:red" > * </span> </td>
                <td><input type="password" id="newPWD" name="newPWD" size="20" style="width:150px;height:18px" <%--onblur="isNewDiffFromOld()"--%> > <div id="newWrong" style="display:none">&nbsp;&nbsp;<img src="bbsimages/pwdWrong.bmp"><span style="color:red" >&nbsp;&nbsp;Old & New Passwords are same, Pls change  </span> </div> </td>
            </tr>
            <tr><td style="padding-bottom:5px"></td></tr>
            <tr class="verdana_form">
                <td><b> Retype New Password</b><span style="color:red" > * </span> </td>
                <td><input type="password" id="newPWD1" name="newPWD1" size="20" style="width:150px;height:18px" <%--onblur="isRetypeRight()"--%>> <div id="rtRight" style="display:none">&nbsp;&nbsp;<img src="bbsimages/pwdRight.bmp"> Retype is identical </div><div id="rtWrong" style="display:none">&nbsp;&nbsp;<img src="bbsimages/pwdWrong.bmp"><span style="color:red" >&nbsp;&nbsp;Retype is wrong</span> </div></td>
            </tr>
<tr><td style="padding-bottom:10px"></td></tr>
        </table>
        <div style="width:80%;border:8px solid #ffffff">

        </div>
        <table>
            <tr>
                <td width="50%" align="center">
                    <a title="Cancel" href="my_ads_details.do"><input  type="image" src="bbsimages/buttons/Cancel.png" onmouseover="this.src='bbsimages/buttons/Cancel_MouseOver.png';" onmouseout="this.src='bbsimages/buttons/Cancel.png';" /></a>
                </td >
                <td align="center">
                    <%--<input id="changePwdButtonDis" disabled type="image" src="bbsimages/buttons/ChangePasswordDis.png"/>--%>
                    <input title="Change Password" id="changePwdButton" type="image" <%--style="display:none"--%>  src="bbsimages/buttons/ChangePassword.png" onmouseover="this.src='bbsimages/buttons/ChangePassword_MouseOver.png';" onmouseout="this.src='bbsimages/buttons/ChangePassword.png';"  />
                </td>
            </tr>

        </table>

    </form>
</div>