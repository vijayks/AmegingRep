<%--
    Document   : assignWebshop
    Created on : Mar 18, 2010, 7:13:11 PM
    Author     : madhuri
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<script>
    function submtFrmWW(){
        if(document.getElementById("ww").value=="Select")
        {
            alert("Please select a Webshop");
            return false;
        }
        //  alert(document.getElementById("ww").value);
        document.assignWeb.submit();
        return true;
    }
</script>
<div style="float:left;font-size:12px;margin-top:25px">
    <c:if test="${ws!=null}">
        <center><span style="color:green;font-size:12px"><b> ${ws}</b> </span></center>
    </c:if>
    <c:if test="${wsMsg!=null}">
        <center><span style="green">${wsMsg}</span></center>
    </c:if>
        <c:if test="${fn:length(webshopList)=='0'}">
           <center><span style="font-size:14px;color:red;margin-left:300px"><b> No webshop is created.</b></span></center>
        </c:if>
    <c:if test="${wsMsgF!=null}">
        <center><span style="red">${wsMsgF}</span></center>
    </c:if>
    <c:if test="${fn:length(webshopList)!='0'}">
    <form name="assignWeb" action="assignWeb.do" method="post">
        <fieldset style="width:700px;"><legend><span style="color:#3366cc;font-size:12px"><b>Assign Webshop to Website</b></span></legend>
            <div style="float:left;margin-top:10px;margin-left:120px">
		<c:set var="caws" value="0"/>
                Current Assigned Webshop : <c:forEach items="${webshopList}" var="wl"><c:if test="${wl.status==5}"><span style="color:green">${wl.name}</span><c:set var="caws" value="1"/></c:if></c:forEach><c:if test="${caws==0}"><span style="color:red">Not Assigned Yet</span></c:if>
            </div>
            <div style="margin-top:40px;margin-left:120px">
		<c:if test="${caws==1}">Change </c:if><c:if test="${caws==0}">Select </c:if>Webshop : 
                <c:if test="${webshopList!=null}">
                    <select id="ww" name="wId" style="width:150px"><option>Select</option>
                        <c:forEach items="${webshopList}" var="wl">
                            <c:if test="${wl.status==1}">
                                <option value="${wl.id}">${wl.name}</option>
                            </c:if>
                        </c:forEach>
                    </c:if>
                </select></div><br/>
            <img src="bbsimages/buttons/assignWebshop.png" onclick="return submtFrmWW()" alt="Assign Webshop" border="0"/ style="padding-left:220px">
        </fieldset>
    </form>
    </c:if>
</div>