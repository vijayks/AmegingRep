<%--
    Document   : inviteFriends
    Created on : Aug 22, 2009, 1:16:19 AM
    Author     : bbsadmin
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<%@page  import="com.buysell.beans.UserBean" %>
<script>
    function getContactValidation()
    {
        if(document.getElementById("pwd").value == null || document.getElementById("pwd").value == "" )
        {
            alert("Please enter password");
            return false;
        }
        else
        {
            submitPressed('inviteFriendsForm','getContacts');
        }
    }
    function submitFormWithEnter(myfield,e)
    {
        var keycode;
        if (window.event)
        {
            keycode = window.event.keyCode;
        }
        else if (e)
        {
            keycode = e.which;
        }
        else
        {
            return true;
        }

        if (keycode == 13)
        {
            getContactValidation();
        }
        else
        {
            return true;
        }
    }
</script>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%--<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>--%>
<div style="margin:20px 0 0 0;clear:both;width:720px">
    <div class="pt"><div class="pb"><div class="pl"><div class="pr"><div class="pbl"><div class="pbr"><div class="ptl">
                                <div class="ptr">
                                    <%
            UserBean ub = (UserBean) request.getSession().getAttribute("userBean");
            if (ub != null) {
                                    %> <br />
                                    <%-- <%
                 if (ub.getLoginName().contains("gmail.com") || ub.getLoginName().contains("yahoo")) {
                                     %>--%>
                                    <%--<b class="fv14bc" style="padding:0px 0 0 20px;" >Invite Friends</b>
                                    <hr size="1" color="#ffcc33" style="width:730px"  />
                                    <c:if test="${ok != null}" >
                                        <center><c:out value="${ok}" /> </center>
                                        <% request.getSession().removeAttribute("ok");%>
                                    </c:if>
                                    <table width="700px" >
                                        <tr>
                                            <td align="right"><img src="bbsimages/gmail.jpg" /></td>
                                            <td>&nbsp;&nbsp;&nbsp;</td>
                                            <td align="left"><img src="bbsimages/yahoo.jpg" /></td>
                                        </tr>
                                    </table>
                                    <br />
                                    <p align="center" class="fv14b">Get "Reward Points" on registration of your friend in Bharatbuysell.com with your invitation.</p>
                                    <p align="left" class="fv14b" style="padding-left:70px;">It is very simple and easy....</p>
                                    <center><form name="inviteFriendsForm" id="inviteFriendsForm" method="post" action="inviteFriends1.do">
                                            <c:if test="${userBean != null}" >
                                                <input type="hidden" name="name" value="<c:out value='${userBean.firstName}' />"  />
                                                <input type="hidden" name="actfrom" value="displayList" />
                                                <c:set var="lgn" >${userBean.loginName}</c:set>
                                                <c:set var="uname" value="${fn:split(lgn, '@')}"/>
                                                <c:set var="count" value="${0}"/>
                                                <table width="400px">
                                                    <tr>
                                                        <c:forEach var="num" items="${uname}" begin="0" >
                                                            <c:set var="count" value="${count+1}"/>

                                                            <c:if test="${count ==1}">
                                                                <td class="fv12bc">Email Id</td><td></td>
                                                                <td><input type="text" size="30" value="<c:out value="${num}" />" name="mailId" /></td>
                                                                </c:if>
                                                                <c:if test="${count ==2}">
                                                                <td>@</td>
                                                                <td><select name="dname" size="1" style="border:1px solid #4d9edf;height:21px;">
                                                                        <option value="gmail.com" >Select Domain</option>
                                                                        <option value="gmail.com" <c:if test='${num == "gmail.com"}'>selected</c:if>>gmail.com</option>
                                                                        <option value="yahoo.com" <c:if test='${num == "yahoo.com"}'>selected</c:if>>yahoo.com</option>
                                                                        <option value="yahoo.co.in" <c:if test='${num == "yahoo.co.in"}'>selected</c:if>>yahoo.co.in</option>
                                                                </select></td></c:if>

                                                        </c:forEach>
                                                    </tr><tr><td></td></tr>
                                                    <tr>
                                                        <td class="fv12bc">Password</td>
                                                        <td></td>
                                                        <td> <input type="password" value="" id="pwd" name="pwd" size="30" onKeyPress="return submitFormWithEnter(this,event)"
                                                                    onselect="return getContactValidation();"> </td></tr></table>
                                                <br /><input type="button"  id="getContacts"  name="getContacts" value="Get Contacts" onclick="return getContactValidation();" />
                                            </form>
                                            <br />
                                            <table width="400px"><tr><td align="left"  class="fv14b">Note: We will not store your Password.</td></tr></table>
                                        </center>
                                    </c:if><br /><br />--%>
                                    <%-- <% }%>--%>
                                    <h3 class="fv14bc" style="padding:0 0 0 20px;" >Invite Friends : Option 1</h3>
                                    <hr size="1" color="#ffcc33" style="width:700px;margin-top: 5px;"  />
                                    <div style="margin:0 10px 0 10px;width:700px">
                                        <%--<textarea readonly cols="600" rows="3" onfocus="this.select()">http://bharatbuysell.com/register.do?city=${city}&rId=${rid}</textarea>--%>
                                        <span class="fv12" style="float:left;margin-top: 10px;margin-bottom: 10px;">Copy & Paste the below content to your mail and send to all your friends.</span> <br/>
                                        <table width="695" bgcolor="#4d9edf" style="font-size:11px">
                                            <tr>
                                                <td><table width="698" bgcolor="#FFFFFF">
                                                        <tr>
                                                            <td> <table width="696" bgcolor="#4d9edf" style="color:#FFFFFF;">
                                                                    <tr>
                                                                        <td><table width="680" align="center"><tr>
                                                                                    <td width="530">Hello Friend,<br /><h3>I am inviting you to join Bharatbuysell.com</h3><p>It's really amazing!</p></td>
                                                                                    <td width="152" valign="top" style="padding-top:5px;"><img src="http://bharatbuysell.com/bbsimages/EmailLogo.gif" width="146" height="76" alt="Bharatbuysell" /></td></tr></table></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <table width="680" align="center">
                                                                                <tr><td>Please click the below link to <strong>Join  Bharatbuysell.com</strong>.<br />
                                                                                        <a title="Refer Friends" href="http://bharatbuysell.com/referFriendReg.do?city=${city}&rId=${rid}" style="color:#ffcc33; font-weight:600">"http://bharatbuysell.com/referFriendReg.do?city=${city}&rId=${rid}"</a>
                                                                                    </td></tr></table>
                                                                        </td>
                                                                    </tr>
                                                                    <tr><td><br/></td></tr>
                                                                    <tr>
                                                                        <td>
                                                                            <table align="center" width="680"><tr><td><b><u>Benefits of  Bharatbuysell.com:</u></b></td></tr></table>
                                                                        </td>
                                                                    </tr>
                                                                    <tr><td><br/></td></tr>
                                                                    <tr>
                                                                        <td>
                                                                            <table align="left" width="680"><tr><td>
                                                                                        <ul style="padding-left: 10px;"><li style="padding-bottom: 5px;"> On Bharatbuysell.com you can easily search or post ads, events, announcements  for anything.</li>
                                                                                            <li style="padding-bottom: 5px;"><b>User Friendly </b>- Bharatbuysell.com has been made keeping  the user in mind. The information is easily accessible through category  browsing, easy search &amp; latest ads so that you find the information much faster.</li>
                                                                                            <li style="padding-bottom: 5px;"><b>Visibility </b>- Bharatbuysell.com is a powerful platform for the  advertisers to showcase their offers &amp; receive quick response. The ads are  clearly visible throughout the website which gives maximum visibility to the  users.</li>
                                                                                            <li style="padding-bottom: 5px;">BBS Points are Bharatbuysell  points, which you can redeem for different items available and earn by</li>
                                                                                        </ul></td></tr></table>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <table align="right" width="610"><tr><td>
                                                                                        <img src="http://bharatbuysell.com/bbsimages/tick.gif">&nbsp;Making your friend  register by inviting <br />
                                                                                        <img src="http://bharatbuysell.com/bbsimages/tick.gif">&nbsp;Receiving sms/email  about special offers<br />
                                                                                        <img src="http://bharatbuysell.com/bbsimages/tick.gif">&nbsp;Posting special Ads<br />
                                                                                        <img src="http://bharatbuysell.com/bbsimages/tick.gif">&nbsp;Posting an unique article  about Bharatbuysell.<br />
                                                                                    </td></tr></table>
                                                                        </td>
                                                                    </tr>
                                                                    <tr><td><br/></td></tr>
                                                                    <tr>
                                                                        <td>
                                                                            <table align="center" width="680"><tr><td><ul><li>You will receive promotional offers, discounts and other advertisements strictly based on the preferences you opted for. However you are free to change  your preferences list in your Bharatbuysell account at any time.</li></ul></td></tr></table>
                                                                        </td>
                                                                    </tr>
                                                                    <tr><td><br/></td></tr>
                                                                </table></td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                        </table>
                                    </div><br /><br />
                                    <h3 class="fv14bc" style="padding:0 0 0 20px;" >Invite Friends : Option 2</h3>
                                    <hr size="1" color="#ffcc33" style="width:700px;margin-top: 5px;"  />
                                    <div style="margin:0 10px 0 5px;width:690px">
                                        <span class="fv12" style="float:left;margin-top: 10px;margin-bottom: 10px;">Copy the code appearing below and paste it to your website, blog or any webpage to invite friends join on www.bharatbuysell.com. </span><br/>
                                        <textarea readonly cols="67" rows="2" style="width:100%;font-size:14px;font-weight: bold " onfocus="this.select()"><a href="http://bharatbuysell.com/register.do?city=${city}&rId=${rid}"> <b style="color:#046dbe">Join Bharatbuysell.com</b></a></textarea>
                                    </div><br>
                                    <h3 class="fv14bc" style="padding:0 0 0 20px;" >Invite Friends : Option 3</h3>
                                    <hr size="1" color="#ffcc33" style="width:700px;margin-top: 5px"  />
                                    <div style="margin:0 0 0 5px;width:700px">
                                        <form action="inviteFriends2.do" method="post">
                                            <input type="hidden" name="actfrom" value="sendMessage" />
                                            <span class="fv12" style="float:left;margin-top: 10px;margin-bottom: 10px;">Please enter the email id of ur friends to invite them for joining in&nbsp; </span><span class="fv12" style="color:#046dbe;float:left;;margin-top: 10px;margin-bottom: 10px;"> Bharatbuysell.com!</span>
                                            <table class="fv11" style="margin:0 0 0 50px;clear:left">
                                                <tr>
                                                    <td style="width:75px">Email Id</td>
                                                    <td> <input type="text" name="sendMail" style="width:200px;margin-bottom:5px;height:18px;"></td>
                                                </tr>
                                                <tr>
                                                    <td>Email Id</td>
                                                    <td> <input type="text" name="sendMail" style="width:200px;margin-bottom:5px;height:18px;"></td>
                                                </tr>
                                                <tr>
                                                    <td>Email Id</td>
                                                    <td> <input type="text" name="sendMail" style="width:200px;margin-bottom:5px;height:18px;">
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>Email Id</td>
                                                    <td> <input type="text" name="sendMail" style="width:200px;margin-bottom:5px;height:18px;"></td>
                                                </tr>
                                                <tr>
                                                    <td>Email Id</td>
                                                    <td> <input type="text" name="sendMail" style="width:200px;margin-bottom:15px;height:18px;"></td>
                                                </tr>
                                                <tr>
                                                    <td></td>
                                                    <td></td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2" style="text-align:center"><input type="submit" value="Invite Friends"></td>
                                                </tr>
                                                <tr><td colspan="2" style="text-align:center"><span style="font-size:10px;padding-bottom:4px;color:#0F0;margin-bottom:5px;"><c:out value='${ok}' escapeXml="false" /><% request.getSession().removeAttribute("ok");%></span></td></tr>
                                          <tr>
                                                    <td><br/></td></tr>
                                            </table>
                                        </form>
                                    </div>
                                </div>
                            </div></div></div></div></div></div></div></div><br/>
                            <%} else {%>
<meta http-equiv="REFRESH" content="0; url=myAccountNL.do">
<%            }%>