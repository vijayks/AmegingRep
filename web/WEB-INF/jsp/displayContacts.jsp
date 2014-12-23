<%--
    Document   : displayContacts
    Created on : Aug 23, 2009, 5:04:04 PM
    Author     : bbsadmin
--%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib  uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<script>
    function chkAllContacts()
    {
        sendMail =document.getElementsByName("sendMail");
        commons(sendMail,"checked");
    }
    function unChkAllContacts()
    {
        sendMail =document.getElementsByName("sendMail");
        commons(sendMail,"");
    }
    function commons(item,checked){
        for (i = 0; i < item.length; i++)
        {
            item[i].checked =checked;
        }
    }

</script>
<div style="margin:5px 0 0 0;clear:both;width:738px">
    <div class="pt"><div class="pb"><div class="pl"><div class="pr"><div class="pbl"><div class="pbr"><div class="ptl">
                                <div class="ptr">

                                    <br />
                                    <b class="fv14bc" style="font-size:16px;padding:0px 0 0 20px;" >Invite Friends</b>
                                    <hr size="1" color="#ffcc33" style="width:730px"  />
                                     <form action="inviteFriends2.do" method="post">
                                    <table width="600px" align="center">
                                        <tr><td align="left" width="80px;">
                                                <a title="Click to select all friends" href="javascript:return false;" class="fv14bc" onClick="chkAllContacts();event.returnValue=false;return false;">Select All</a>
                                            </td>
                                            <td align="left">
                                                <a title="Click to De-select all friends" href="javascript:return false;" class="fv14bc" style="padding-left:30px" onClick="unChkAllContacts();event.returnValue=false;return false;">None</a></td>
                                            <td align="right">
                                                <input type="submit" value="Invite" />
                                            </td>
                                        </tr>
                                    </table>

                                    <input type="hidden" name="actfrom" value="sendMessage" />
                                     <input type="hidden" name="name" value="<c:out value='${userBean.firstName}' />"  />

                                    <table class="fv11" width="600px" align="center">
                                        <tr bgcolor="#dddddd" style="height:25px">
                                            <th>Select</th><th>Name</th><th>Email</th>
                                        </tr>
                                        <c:forEach items="${mailList}"  var="cont">
                                            <c:if test="${cont != null}">
                                                <tr><td bgcolor="#dddddd" align="center">
                                                     <input type="checkbox" name="sendMail"  value="<c:out value='${cont.name}'/>$^$<c:out value='${cont.emailAddress}'/>"/></td>
                                                    <td style="padding-left:5px;"><c:out value="${cont.name}"/></td>
                                                    <td  style="padding-left:5px;"><c:out value="${cont.emailAddress}"/></td>
                                                </tr>
                                            </c:if>
                                        </c:forEach>
                                            <c:if test="${errorInFetch != null}" >
                                                <tr align="center">
                                                    <td></td>
                                                    <td> <span style="color:red">We are enable to fetch records</span></td>
                                                    <td></td>
                                                </tr>
                                                </c:if>
                                    </table>



                                    <table width="600px" align="center">
                                        <tr><td align="left" width="80px;">
                                                <a title="Click to select all friends" href="javascript:return false;" class="fv14bc" onClick="chkAllContacts()">Select All</a>
                                            </td>
                                            <td align="left">
                                                <a title="Click to De-select all friends" href="javascript:return false;" class="fv14bc" style="padding-left:30px" onClick="unChkAllContacts()">None</a></td>
                                            <td align="right">
                                                <input type="submit" value="Invite"  />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td></td>
                                            <td style="text-align:center" class="fv12bc">Total number of Contacts fetched :: <c:out value="${fn:length(mailList)}" /></td>
                                            <td></td>
                                        </tr>
                                    </table>
                                     </form>

                                </div>
                            </div></div>
                    </div></div>
            </div></div>
    </div></div>

