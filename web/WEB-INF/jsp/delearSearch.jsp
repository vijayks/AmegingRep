<%--
    Document   : delearSearch
    Created on : Jul 24, 2009, 7:15:20 PM
    Author     : bbsadmin
--%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<script type="text/javascript" src="js/allAjax.js"></script>
<script type="text/javascript" language="javascript">
    function clear1(obj) { obj.value=""; }
    function retainValue(obj) {
        if(obj.value == '' && obj.name == 'ulName') {
            obj.value = 'Name';
        }
        else if(obj.value == '' && obj.name == 'ulMobileNumber') {
            obj.value = 'Mobile Number';
        }
        else if(obj.value == '' && obj.name == 'ulEmail') {
            obj.value = 'Email (Optional)';
        }
        else if(obj.value == '' && obj.name == 'ulDesc') {
            obj.value = document.getElementById('ulDesc').innerHTML;
        }
    }
    function ulValidation(element){
        var category = document.getElementById("ulCategory").value;
        var city = document.getElementById("ulCity").value;
        var desc = document.getElementById("ulDesc").value;
        var name = document.getElementById("ulName").value;
        var email = document.getElementById("ulEmail").value;
        var mobileNumber = document.getElementById("ulMobileNumber").value;
        var mobileRegex= /^([987]{1})([0123456789]{1})([0-9]{8})$/;
        if(category == 0 ){
            alert("Select Category");
            return false;
        }else if(city == "" || city == "Select City"){
            alert("Select City");
            return false;
        }else if(desc == "" || desc == "Please enter the details of service you are looking for (Mandatory)"){
            alert("Enter your description");
            return false;
        }else if(name == "" || name == "Name"){
            alert("Enter your name");
            return false;
        }else if(mobileNumber == "" || mobileNumber == "Mobile Number"){
            alert("Enter your mobile number");
            return false;
        }else if(!mobileNumber.match(mobileRegex)) {
            alert("You entered an invalid mobile number");
            return false;
        }else {
            if(email== 'Email (Optional)')
                email="";
            var dlrId=0;
            <c:if test="${dmi!=null&&dmi.dId!=0}">
                        dlrId='${dmi.dId}';
            </c:if>
            sendUserLead(name,desc,mobileNumber,email,city,category,dlrId);
	    element.style.display="none";
        }
    }
</script>
<style type="text/css">
    .txtopt, .pad input[type=text] {
        border:1px solid #BFBFBF;
        padding-left:3px;
        color:#6F6F6F;
        font-size:12px;
        font-family:arial;
        background-color:#FFFFFF;
    }
    .pad td { padding-top:4px; }
    .pad {
        font-size:12px;
        background-color:#efefef;
        width:100%;
        padding:5px 0px;
        padding-left:2%;
        color:#D55D0C;
    }
    .greyDiv {
        border:2px solid #BFBFBF;
        background:#BFBFBF;
        font-size:13px;
        width:99%;
        border-bottom:4px solid #BFBFBF;
        clear:both;
        margin-bottom:20px;
        -moz-border-radius:7px;
        -webkit-border-radius:7px;
    }
    .greyDivTitle {
        padding:10px 2%;
        color:black;
        font-weight:bold;
        width:96%;
        float:left;
    }
    .greyDivTitle span { float:left; }
    .greyDivTitle a{
        color:black;
        text-decoration:underline;
        font-size:12px;
        float:right;
    }
</style>
<div id="userLead" class="greyDiv" style="display:none;">
    <div class="greyDivTitle"><c:choose><c:when test="${dmi!=null && dmi.compName!=null}">Send SMS to ${dmi.compName}</c:when><c:otherwise>Receive Calls with Best Rates</c:otherwise></c:choose></div>
        <table class="pad"> <tr> <td>I am looking for service in</td> </tr>
            <tr>
                <td><select id="ulCategory" class="txtopt" name="ulCategory" style="width:180px"><option value="0" selected="selected"> Select Category </option>
                        <c:if test="${categoryList != null}" > <c:forEach items="${categoryList}" var="category">  <c:if test="${category.parent == 0}"><optgroup style="background:#dddddd;font-style:normal;font-weight:normal;label="${category.name}">
                                              <c:if test="${category.subCategories != null}"> <c:forEach items="${category.subCategories}" var ="cat"><option style="background:#ffffff" value="${cat.id}" ><c:out value="${cat.name}" escapeXml="false"/></option></c:forEach> </c:if>
                                          </optgroup> </c:if> </c:forEach>
                        </c:if></select></td>
            </tr>
            <tr>
                <td>Category of <select id="ulCity" class="txtopt" name="ulCity" style="width:116px">  <option value="" selected="true" >Select City</option> <c:if test="${cities  != null }">
                            <c:forEach items="${cities}" var="city"> <option value="<c:out value='${city.name}'/>"><c:out value="${city.name}"/></option> </c:forEach> </c:if> </select> City
                </td>
            </tr>
            <tr> <td><textarea style="width:180px" id="ulDesc" class="txtopt" name="ulDesc" rows="3" onfocus="clear1(this)" onblur="retainValue(this)">Please enter the details of service you are looking for (Mandatory)</textarea></td> </tr>
        </table>
        <table class="pad">
            <tr>
                <td><input type="text" id="ulName" name="ulName" value="<c:if test="${userBean.firstName!=null}">${userBean.firstName}</c:if><c:if test="${userBean.firstName==null}">Name</c:if>" onfocus="clear1(this)" onblur="retainValue(this)"></td>
            </tr>
            <tr>
                <td><input type="text" id="ulMobileNumber" name="ulMobileNumber" value="<c:if test="${userBean.mobile!=null}">${userBean.mobile}</c:if><c:if test="${userBean.mobile==null}">Mobile Number</c:if>" onfocus="clear1(this)" onblur="retainValue(this)"></td>
                <td rowspan="2" style="width:46px"><input type="image" src="bbsimages/go.png" onclick="ulValidation(this);"></td>
            </tr>
            <tr>
                <td><input type="text" id="ulEmail" name="ulEmail" value="<c:if test="${userBean.loginName!=null}">${userBean.loginName}</c:if><c:if test="${userBean.loginName==null}">Email (Optional)</c:if>" onfocus="clear1(this)" onblur="retainValue(this)"></td>
            </tr>
        </table>
        <table class="pad">
            <tr><td><div id="ulMsg"></div>
                    <div id="ulVerCode" style="display:none;color:#a80000;font-weight:bold;"><blink>Enter Verification Code</blink> <input type="text" id="ulvc" style="width:40px;"><input type="button" value="Verify" onclick="verifyUserLead(document.getElementById('ulvc'));"></div>
                    <div id="ulVerMsg"></div>
                </td></tr>
        </table>
    </div>
<script type="text/javascript">
<% if(request.getAttribute("subCatId") != null) { %>
    document.getElementById("ulCategory").value='<%=request.getAttribute("subCatId")%>';
<% } else if(request.getParameter("subCatId")!=null) { %>
    document.getElementById("ulCategory").value='<%=request.getParameter("subCatId")%>';
    <% } %>
    document.getElementById("ulCity").value='${city}';
</script>

