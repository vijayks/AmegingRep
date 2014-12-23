<%--
    Document   : editProductDetails
    Created on : Mar 15, 2010, 5:01:06 PM
    Author     : bbsadmin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%@page  import="com.buysell.webshop.beans.Product" %>
<%@page import="java.util.StringTokenizer" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">


<style>

    #mainDv legend{
        color:#3366cc;
    }

    #mainDv fieldset{

        FONT-SIZE: 12px;
        FONT-FAMILY: Verdana, Arial, Helvetica, sans-serif;
        COLOR:#000000;
    }
    #mainDv td{
        width:220px;
    }


</style>
<script>
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

function createSpec(){
    var j=i;
    i=parseInt(i)+1;

    var r=document.createElement('tr');
    var ca=document.createElement('td');
    var cb=document.createElement('td');

    var t=document.getElementById('addSpec');
    ca.innerHTML="Specification "+j;
    cb.innerHTML="<textarea style='width:180px;' name='longspec' id='spec"+j+"'> </textarea>";


    r.appendChild(ca);
    r.appendChild(cb);
    t.appendChild(r);

    if(i>=16){
        document.getElementById('specButton').style.display='none';
    }
}

function addAcc(){
    var n=m;
    m=parseInt(m)+1;

    var r=document.createElement('tr');
    var ca=document.createElement('td');
    var cb=document.createElement('td');

    var t=document.getElementById('suggAcc');
    ca.innerHTML="Product "+n;
    cb.innerHTML="<select style='width:180px' name='acces' id='access"+n+"'><option value='0'>Select Product</option><c:forEach items='${prodList}' var='pl'><c:if test='${pl.prodId!=prod.prodId}'><option value='${pl.prodId}'>${pl.name}</option></c:if></c:forEach></select>";
    r.appendChild(ca);
    r.appendChild(cb);
    t.appendChild(r);

    if(m>=11){
        document.getElementById("accButton").style.display='none';
    }

}

function validateEditProd(editProd){



    var name=editProd.name.value;
    var shortDesc=editProd.shortDesc.value;
    var description=editProd.description.value;
    var modelId=editProd.modelId.value;
    var chk=true;

    if(name==""){
        inlineMsg('name','Please enter Product Name.');
        chk=false;
    }else if(shortDesc==""){
        inlineMsg('shortDesc','Please enter Short Description.');
        chk=false;
    }else if(description==""){
        inlineMsg('description','Please enter Description');
        chk=false;
    }else if(modelId==""){
        inlineMsg('modelId','Please enter ModelId.');
        chk=false;
    }else if(!(chkAccE())){
            chk=false;
    }else{
        chk=true;
    }
    return chk;


}
function addImg(){
    var k=p;

    p=parseInt(p)+1;
    if((p)>=5){
        document.getElementById('addImgs').style.display='none';
    }

    var r=document.createElement('tr');
    var ca=document.createElement('td');
    var cb=document.createElement('td');

    var t=document.getElementById('addImg').getElementsByTagName("TBODY")[0];
    ca.innerHTML="Image "+p;
    cb.innerHTML="<input type='file' name='img"+p+"'/>";


    r.appendChild(ca);
    r.appendChild(cb);
    t.appendChild(r);


}
function chkAccE(){
    var accList=document.getElementsByName("acces");
    var accboo=1;
    for(var accvar1=0;accvar1<accList.length;accvar1++){
        for(var accvar2=accvar1+1;accvar2<accList.length;accvar2++){
            if(accList[accvar1].value==accList[accvar2].value && accList[accvar1].value!=0){
                inlineMsg(accList[accvar2].id,'Product Already Selected');
                accboo=0;
                return false;
            }
        }
    }
    if(accboo==1) return true;
}
</script>

<c:if test="${prod!=null}">

    <form name="editProd" enctype="multipart/form-data" method="POST" action="edtProd.do" onsubmit="return validateEditProd(this)">
        <input name="prodId" type="hidden" value="<%= request.getParameter("prodId")%>"/>
        <div id="mainDv" style="width:720px">
            <div><input type="hidden" name="up" value="up"/>
                <fieldset>
                    <legend><b>Product Basic Details</b></legend>
                    <table style="margin-left:25px">
                        <tr>
                            <td>Product  Name </td>
                            <td>:&nbsp;&nbsp;<input type="text" id="name" name="name" value="${prod.name}"/></td>
                        </tr>
                        <tr>
                            <td>Product Small Description</td>
                            <td>:&nbsp;&nbsp;<input type="text" id="shortDesc" maxlength="100" name="shortDesc" value="${prod.shortDesc}"/></td>
                        </tr>
                        <tr>
                            <td>Product Large Description </td>
                            <td>:&nbsp;&nbsp;<input type="text" id="description" name="description" value="${prod.description}"/></td>
                        </tr>
                        <tr>
                            <td>Model Number :</td>
                            <td>:&nbsp;&nbsp;<input type="text" id="modelId" name="modelId" value="${prod.modelId}"/></td>
                        </tr>
                    </table>
                </fieldset>
            </div>

            <div>
                <fieldset>
                    <legend><b>Important Specifications</b></legend>

                    <table style="margin-left:25px">
                        <c:if test="${prod.shortSpecifics!=null}">

                            <c:set var="hh1" value="${prod.shortSpecifics}"/>
                            <c:set var="i" value="1"/>
                            <% String str = (String) pageContext.getAttribute("hh1");
            StringTokenizer st = new StringTokenizer(str, "^^");
            while (st.hasMoreTokens()) {
                String val = st.nextToken();%>

                            <tr>
                                <td>Specification ${i}</td>
                                <td>:&nbsp;&nbsp;<input type="text" name="shortspec" id="spec${i}" value="<%=val%>"></td>
                            </tr> <c:set var="i" value="${i+1}"/><%}
                            %></c:if>
                            <c:if test="${i<6}">
                                <c:forEach begin="${i}" end="5" step="1">
                                    <tr>
                                        <td>Specification ${i}</td>
                                        <td>:&nbsp;&nbsp;<input type="text" name="shortspec" id="spec${i}"></td>
                                    </tr><c:set var="i" value="${i+1}"/>
                                </c:forEach>
                            </c:if>
                        </table>
                    </fieldset>
                </div>

                <div>
                    <fieldset>
                        <legend><b>Price Details</b></legend>
                        <table style="margin-left:25px">
                            <tr>
                                <td>Actual Price</td>
                                <td>:&nbsp;&nbsp;<input type="text" name="actualPrice" value="${prod.actualPrice}"onkeypress="return numbersonly(event,false)"/></td>
                        </tr>
                        <tr>
                            <td>Discount</td>
                            <td>:&nbsp;&nbsp;<input type="text" name="discount" value="${prod.discount}" onkeypress="return numbersonly(event,false)"/></td>
                        </tr>
                        <tr>
                            <td>Offer Price</td>
                            <td>:&nbsp;&nbsp;<input type="text" name="offerPrice" value="${prod.offerPrice}"onkeypress="return numbersonly(event,false)"/></td>
                        </tr>
                        <tr>
                            <td>Currency</td>
                            <td>:&nbsp;&nbsp;<input type="text" name="currency" value="${prod.currency}"/></td>
                        </tr>
                        <tr>
                            <td>Offer Till</td>
                            <td>:&nbsp;&nbsp;<input type="text" value="${prod.offerTill}" name="offerTill"/></td>
                        </tr>
                        <tr>
                            <td>Stock Status</td>
                            <td>:&nbsp;&nbsp;<select name="stockStatus" style="width:180px">
                                    <option selected>${prod.stockStatus}</option>
                                    <option>In Stock</option>
                                    <option>Out Of Stock</option>
                                    <option>Coming Soon</option>
                                    <option>Limited Stock</option>
                                    <option>New Arrival</option></select></td>
                        </tr>
                    </table>
                </fieldset>
            </div>

            <div>
                <fieldset>
                    <legend><b>Photo Gallery</b></legend>
                    <table id="addImg" style="margin-left:25px">
                            <c:set var="i" value="0"/>
                        <c:if test="${prod.imageLocation!=null}">

                            <c:set var="hh2" value="${prod.imageLocation}"/>
                            <% String str22 = (String) pageContext.getAttribute("hh2");
            StringTokenizer stk = new StringTokenizer(str22, "|");
            while (stk.hasMoreTokens()) {
                String val = stk.nextToken();%>
                            <c:if test="${i==0}">
                                <tr>
                                    <td>Thumb Image </td><td><img src="resourceGetter?imd=${userBean.path}<%=val%>" border="0" height="60px" width="100px"/></td>
                                    <td><input type="file" name="thImg" id="" value="<%=val%>"><input type="hidden" value="<%=val%>" name="thmbPrevImg"/></td>
                                </tr>
                            </c:if>
                            <c:if test="${i>0}">
                                <tr>
                                    <td>Image ${i} </td><td style="width:120px;"><img src="resourceGetter?imd=${userBean.path}<%=val%>" border="0" height="60px" width="100px"/></td>
                                    <td><input type="file" name="img${i}" id="" value="<%=val%>"><input type="hidden" value="<%=val%>" name="prevImg${i}"/></td>
                                </tr>
                            </c:if>
                            <c:set var="i" value="${i+1}"/>
                            <%}%>
                        </c:if>
                        <tr>
                            <td><input type="hidden" id="iValP" value="${i}"/></td>
                            <td></td>
                        </tr>
                        <%-- <tr>
                             <td>Thumbnail</td>
                             <td><input type="file" id="thImg" name="thImg"/></td>
                         </tr>
                         <tr>
                             <td>Photo 1</td>
                             <td><input type="file" name="img1"/></td>
                         </tr>ss
                         <tr>
                             <td>Photo 2</td>
                             <td><input type="file" name="img2"/></td>
                         </tr>
                         <tr>
                             <td>Photo 3</td>
                             <td><input type="file" name="img3"/></td>
                         </tr>
                         <tr>
                             <td>Photo 4</td>
                             <td><input type="file" name="img4"/></td>
                         </tr>
                         <tr>
                             <td>Photo 5</td>
                             <td><input type="file" name="img5"/></td>
                         </tr>--%>
                    </table>  <div style="margin-left:253px;"><input id="addImgs" type="button" value="Add Images" onclick="addImg()"/></div>
                </fieldset>
            </div>

            <div>
                <fieldset>
                    <legend><b>Specifications</b></legend>
                    <table id="addSpec"style="margin-left:25px">
                            <c:set var="i" value="1"/>
                        <c:if test="${prod.longSpecifics!=null}">

                            <c:set var="hh" value="${prod.longSpecifics}"/>
                            <% String str3 = (String) pageContext.getAttribute("hh");
                                StringTokenizer stk2 = new StringTokenizer(str3, "^^");
                                while (stk2.hasMoreTokens()) {
                                    String val = stk2.nextToken();%>

                                                <tr>
                                <td>Specification ${i}</td>
                                <td><textarea style="width:180px" name="longspec" id="spec${i}" value=""><%=val%> </textarea></td>
                            </tr> <c:set var="i" value="${i+1}"/><%}
                            %>  </c:if>
                        </table><input type="hidden" id="iVal" value="${i}"/>
                        <div id="specButton" style="margin-left:253px;"><input type="button" value="Add More Specifications" onclick="return createSpec();"/></div>
                    </fieldset>
                </div>
                <div>
                    <fieldset>
                        <legend><b>Suggested Accessories</b></legend>
                        <table style="margin-left:25px;" id="suggAcc">
                            <c:set var="i" value="1"/>
                        <c:if test="${prod.accessories!=null}">
                            <c:set var="hhh" value="${prod.accessories}"/>
                            <% String str1 = (String) pageContext.getAttribute("hhh");
                               StringTokenizer stt = new StringTokenizer(str1, "|");
                               while (stt.hasMoreTokens()) {
                                    String val1 = stt.nextToken();
                                                %>
                                                <tr>
                                <td>Product ${i}</td>
                                <td><select  name="acces" id="access${i}" style="width:180px"><c:set var="pVal"><%=val1%></c:set>
                                        <c:if test="${prodList!=null}">
                                            <c:forEach items="${prodList}" var="pl">
                                                <c:if test="${pl.prodId==pVal}">
                                                    <option value="${pl.prodId}" selected>${pl.name}</option>
                                                </c:if>
                                            </c:forEach>
                                            <c:forEach items="${prodList}" var="pl">
                                                <c:if test="${pl.prodId!=prod.prodId}">
                                                    <option value="${pl.prodId}">${pl.name}</option>
                                                </c:if>
                                            </c:forEach>
                                        </c:if>
                                    </select></td><c:set var="i" value="${i+1}"/>
                            </tr><% }%></c:if>
                        </table><input type="hidden" id="iVal1" value="${i}"/>
                        <div style="margin-left:252px;"><input id="accButton" type="button" onclick="return addAcc();" value="Add Suggested Accessories"/></div>
                    </fieldset>
                </div>
                <center><div style="margin-top:20px;margin-bottom:10px;"><input type="submit" value="Submit"/></div></center>

            </div>
        </form>
</c:if>
<script>
var i=document.getElementById("iVal").value;
var m=document.getElementById("iVal1").value;
var p=document.getElementById("iValP").value-1;
    if(i==16){
        document.getElementById('specButton').style.display='none';
    }
    if(m==11){
        document.getElementById("accButton").style.display='none';
    }
    if((p)==5){
        document.getElementById('addImgs').style.display='none';
    }
</script>
