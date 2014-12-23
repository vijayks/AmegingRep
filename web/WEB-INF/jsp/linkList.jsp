<%--
    Document   : linkList
    Created on : Feb 15, 2010, 1:19:24 PM
    Author     : bbsadmin
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<% pageContext.setAttribute("newLineChar", "\n"); %>
<% pageContext.setAttribute("jstlbr", "<br>"); %>
<style>
    #listLink{
        FONT-SIZE: 12px;
        FONT-FAMILY: Verdana, Arial, Helvetica, sans-serif;
        COLOR:#222222;
    }
    #listLink a{
        color:#0066cc;
        FONT-SIZE: 13px;
    }
    #title_latest b{
        FONT-SIZE:24px;
    }
</style>
<%--<script>
function disp(){
    alert(document.getElementById("cId").value);}
</script>--%>
<div style="clear:both">&nbsp;</div>
<br/><br/>
<div style="padding-left:150px;">
    <div style="float:left;width:60%;font-size:71%;color:#0066cc;padding-left:40%">
        <form action="getLinks.do" method="post">
            <table style="width:100%;float:right">
                <tr><td width="40%">Refine By category</td>
                    <td><select name="catId" onchange="disp()" id="cId">
                            <% String val=request.getParameter("catId");
                                if(val!=null) {
                            %>
                            <c:set var="catid" value="<%=val%>"/>
                            <c:out value="${catid}"/>
                            <c:if test="${categoryList!=null}">
                                <c:forEach items="${categoryList}" var="cll">
                                    <c:if test="${cll.parent==0}">
                                        <c:if test="${cll.id==catid}">
                                            <option value="${cll.id}">${cll}</option>
                                        </c:if></c:if></c:forEach></c:if>
                            <%}%>
                            <option value="0">All Categories </option>
                            <c:if test="${categoryList!=null}">
                                <c:forEach items="${categoryList}" var="cl">
                                    <c:if test="${cl.parent==0}">
                                        <option value="${cl.id}">${cl}</option>
                                    </c:if></c:forEach></c:if>
                                </select></td>
                            <td><input type="submit" value="Refine"/></td>
                        </tr> <tr> <td></td></tr>
                    </table></form>
            </div>
            <div><a  href="createLink.do" style="float:right;padding-right:10px;padding-top:15px; color:red;text-decoration:none;"><img src="bbsimages/linkyoursite.png" onmouseover="this.src='bbsimages/linkyoursiteMO.png';" onmouseout="this.src='bbsimages/linkyoursite.png';"/></a></div>
            <div id="listLink" style="float:left;width:95%;margin-left:5%">
        <c:if test="${ll!=null}">
            <c:forEach items="${ll}" var="links">
                <div style="margin-left:2%;margin-bottom:2%;width:80%;float:left"><span><a target="_blank" href="${links.webUrl}"><b><u> ${links.compName}</u></b></a></span>
                    <p style="margin-top:1%">  <c:out value="${fn:replace(links.address,newLineChar,jstlbr)}" escapeXml="false"/></p>
                </div><br/>
                <%--<hr/>--%>
            </c:forEach></c:if><br/><br/>
        <c:if test="${fn:length(ll)=='0'}"><center> <span style="color:red;font-size:90%;"><strong>No links available in the requested category</strong></span></center></c:if>
    </div>
    <div style="clear:both"></div> <br/>
</div>
