<%--
    Document   : wsCreateTopNList
    Created on : Mar 4, 2010, 10:35:14 AM
    Author     : Madhuri
--%>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<style>

    #topNlist td{
        width:100px;
    }
    #topNlist1 td{
        width:200px;
    }

    fieldset{
        FONT-SIZE: 12px;
        FONT-FAMILY: Verdana, Arial, Helvetica, sans-serif;
        COLOR:#000000;
    }
</style>
<script>
    function pId(assignWCT){

        var pid=assignWCT.prod.value;
        var chk=true;
        if(pid==0){
            inlineMsg('prod',"Please select a Product");
            chk=false;
        }
         return chk;

    }
    <%--function hello(prod){

        alert(document.getElementById("prod").value);

    }--%>


    </script>

<div class="verdana_form_post" style="width:730px">
    <br/>
    <br/>
    <c:if test="${fn:length(productsList)=='0'}">
 <center><span style="font-size:14px;color:red"><b> No product yet created .Hence , no list of Whats new products </b></span></center>

</c:if>
<c:if test="${fn:length(productsList)!='0'}">
    <fieldset><legend style="color:#3366cc"><b>What's New</b></legend>
        <center><span style="color:red"><c:if test="${exist!=null}">
        ${exist}</c:if></span></center>
          <center><span style="color:green"><c:if test="${ok!=null}">
        ${ok}</c:if></span></center>
    <form name="assignWCT" action="assignWCT.do?m=in" method="POST" onsubmit="return pId(this)">
        <table id="topNlist" style="margin-left:70px">
            <tr>
                <td>Products</td>
                <td><select id="prod" name="prod" style="margin-left:20px" onchange="return hello(this)">
                        <option value="0">Select Product</option>
                        <c:if test="${productsList!=null}">
                            <c:forEach items="${productsList}" var="pd">
                                <option value="${pd.prodId}+${pd.modelId}">${pd.name}</option>
                            </c:forEach>
                        </c:if>
                    </select></td>

            </tr>
        </table><br/><input type="hidden" name="prodList" value="${productsList}"/><input type="hidden" name="assign" value="s"/>
        <span style="margin-left:150px"><input type="submit" value="Assign"/></span><input type="hidden" name="lT" value="new"/>
    </form>
    </fieldset>

    <br/>
    <br/>

    <fieldset>
        <legend style="color:#3366cc"><b>Existing What's New Products</b></legend>
        <table id="topNlist1" style="margin-left:70px">

            <tr>
                <td style="color:#3366cc"><b>Product</b></td>
                <td style="color:#3366cc"><b>ModelId</b></td>
                <td style="color:#3366cc"><b>Description</b></td>
            </tr>
            <c:if test="${assignList!=null}">
                <c:set var="i" value="1"/>
                <c:forEach items="${assignList}" var="pd">
                    <tr>
                        <td>${pd.name}</td>
                        <td>${pd.modelId}</td>
                        <td>${pd.shortDesc}</td>
                        <td> <input name="rem" value="yes" type="hidden"/><input type="hidden" name="iVal" value="${i}"/><input type="hidden" name="prodId${i}" value="${pd.id}"/><input type="hidden" name="type" value="${pd.type}"/></td>
                        <td><a href="delAssign.do?id=${pd.id}&lT=new" ><input type="button" value="Remove"/></a></td>
                    </tr>
                    <c:set var="i" value="${i+1}"/>
                </c:forEach>
            </c:if>
        </table>
    </fieldset></c:if>
</div>