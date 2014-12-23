<%--
    Document   : wsProductCreation
    Created on : Feb 25, 2010, 10:36:10 AM
    Author     : Madhuri
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
    var i=3;
    var m=3;
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
    i=i+1;

    <%--alert('hi');--%>

        var r=document.createElement('tr');
        var ca=document.createElement('td');
        var cb=document.createElement('td');

        var t=document.getElementById('addSpec').getElementsByTagName("TBODY")[0];
        ca.innerHTML="Specification "+j;
        cb.innerHTML="<textarea style='width:180px;' name='longspec' id='spec"+j+"'> </textarea>";


        r.appendChild(ca);
        r.appendChild(cb);
        t.appendChild(r);

        if(i==16){
            document.getElementById('specButton').style.display='none';
        }
    }

    function addAcc(){

        var n=m;
        m=m+1;

        var r=document.createElement('tr');
        var ca=document.createElement('td');
        var cb=document.createElement('td');

        var t=document.getElementById('suggAcc').getElementsByTagName('TBODY')[0];
        ca.innerHTML="Product "+n;
        cb.innerHTML="<select style='width:180px' name='acces' id='access"+n+"'><option value='0'>Select Product</option><c:forEach items='${productsList}' var='pl'><option value='${pl.prodId}'>${pl.name}</option></c:forEach></select>";
        r.appendChild(ca)   ;
        r.appendChild(cb);
        t.appendChild(r);

        if(m==11){
            document.getElementById("accButton").style.display='none';
        }

    }

    function validateCreateProd(createProd){



        var name=createProd.name.value;
        var shortDesc=createProd.shortDesc.value;
        var description=createProd.description.value;
        var modelId=createProd.modelId.value;

        var shortSpec=createProd.shortSpec.value;

        var thImg=createProd.thImg.value;


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
        }else if(thImg==""){
            inlineMsg('thImg','Please attach Thumb Image.');
            chk=false;
        }else if(!(chkAcc())){
            chk=false;
        }else{
            chk=true;
        }
        return chk;


    }
    function chkAcc(){
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
<c:if test="${sucMsg!=null}">
    <center><span style="color:green;font-size:12px;padding-top:20px;"><b>${sucMsg}</b></span></center>
</c:if>
<c:if test="${failMsg!=null}">
    <center><span style="color:red;font-size:12px;padding-top:20px;"><b>${failMsg}</b></span></center>
</c:if>
<form name="createProd"  enctype="multipart/form-data" method="POST" action="wsCreateProduct.do" onsubmit="return validateCreateProd(this)">
    <div id="mainDv" style="width:720px">
        <div>
            <fieldset>
                <legend><b>Product Basic Details</b></legend>
                <table style="margin-left:25px">
                    <tr>
                        <td>Product  Name </td>
                        <td>:&nbsp;&nbsp;<input type="text" id="name" name="name"/></td>
                    </tr>
                    <tr>
                        <td>Product Small Description</td>
                        <td>:&nbsp;&nbsp;<input type="text" id="shortDesc" maxlength="100" name="shortDesc"/></td>
                    </tr>
                    <tr>
                        <td>Product Large Description </td>
                        <td>:&nbsp;&nbsp;<input type="text" id="description" name="description"/></td>
                    </tr>
                    <tr>
                        <td>Model Number :</td>
                        <td>:&nbsp;&nbsp;<input type="text" id="modelId" name="modelId"/></td>
                    </tr>
                </table>
            </fieldset>
        </div>

        <div>
            <fieldset>
                <legend><b>Important Specifications</b></legend>

                <table style="margin-left:25px">
                    <tr>
                        <td>Specification 1</td>
                        <td>:&nbsp;&nbsp;<input type="text" id="shortSpec" name="shortspec"/></td>
                    </tr>
                    <tr>
                        <td>Specification 2</td>
                        <td>:&nbsp;&nbsp;<input type="text" id="shortSpec" name="shortspec"/></td>
                    </tr>
                    <tr>
                        <td>Specification 3</td>
                        <td>:&nbsp;&nbsp;<input type="text" id="shortSpec" name="shortspec"/></td>
                    </tr>
                    <tr>
                        <td>Specification 4</td>
                        <td>:&nbsp;&nbsp;<input type="text" id="shortSpec" name="shortspec"/></td>
                    </tr>
                    <tr>
                        <td>Specification 5</td>
                        <td>:&nbsp;&nbsp;<input type="text" id="shortSpec" name="shortspec"/></td>
                    </tr>
                </table>
            </fieldset>
        </div>

        <div>
            <fieldset>
                <legend><b>Price Details</b></legend>
                <table style="margin-left:25px">
                    <tr>
                        <td>Actual Price</td>
                        <td>:&nbsp;&nbsp;<input type="text" name="actualPrice" onkeypress="return numbersonly(event,false)"/></td>

                    </tr>
                    <tr>
                        <td>Discount</td>
                        <td>:&nbsp;&nbsp;<input type="text" name="discount" onkeypress="return numbersonly(event,false)"/></td>

                    </tr>
                    <tr>
                        <td>Offer Price</td>
                        <td>:&nbsp;&nbsp;<input type="text" name="offerPrice" onkeypress="return numbersonly(event,false)"/></td>
                    </tr>
                    <tr>
                        <td>Currency</td>
                        <td>:&nbsp;&nbsp;<input type="text" name="currency"/></td>
                    </tr>
                    <tr>
                        <td>Offer Till</td>
                        <td>:&nbsp;&nbsp;<input type="text" name="offerTill"/></td>
                    </tr>
                    <tr>
                        <td>Stock Status</td>
                        <td>:&nbsp;&nbsp;<select name="stockStatus" style="width:180px"><option>In Stock</option>
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
                <table style="margin-left:25px">
                    <tr>
                        <td>Thumbnail</td>
                        <td><input type="file" id="thImg" name="thImg"/></td>
                    </tr>
                    <tr>
                        <td>Photo 1</td>
                        <td><input type="file" name="img1"/></td>
                    </tr>
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
                    </tr>
                </table>
            </fieldset>
        </div>

        <div>
            <fieldset>
                <legend><b>Specifications</b></legend>


                <table id="addSpec"style="margin-left:25px">

                    <tr>
                        <td>Specification 1</td>
                        <td><textarea style="width:180px" name="longspec" id="spec1"></textarea></td>
                    </tr>
                    <tr>
                        <td>Specification 2</td>
                        <td><textarea style="width:180px" name="longspec" id="spec2"></textarea></td>
                    </tr>
                    <tr>
                        <td></td>
                        <td></td>
                    </tr>
                </table>
                <div id="specButton" style="margin-left:253px;"><input type="button" value="Add More Specifications" onclick="return createSpec();"/></div>
            </fieldset>
        </div>

        <div>
            <fieldset>
                <legend><b>Suggested Accessories</b></legend>
                <table style="margin-left:25px;" id="suggAcc">
                    <tr>
                        <td>Product 1</td>
                        <td><select id="access1"  name="acces" style="width:180px"><option value="0">Select Product</option>
                                 <c:if test="${productsList!=null}">
                                      <c:forEach items="${productsList}" var="pl">
                                          <option value="${pl.prodId}">${pl.name}</option>
                                    </c:forEach>
                                </c:if>
                               </select></td>
                    </tr>
                    <tr>
                        <td>Product 2</td>
                        <td><select id="access2" name="acces" style="width:180px">
                                <option value="0">Select Product</option>
                                   <c:if test="${productsList!=null}">
                                      <c:forEach items="${productsList}" var="pl">
                                          <option value="${pl.prodId}">${pl.name}</option>
                                    </c:forEach>
                                </c:if></select>

                    </tr>
                </table>
                <div style="margin-left:252px;"><input id="accButton" type="button" onclick="return addAcc();" value="Add Suggested Accessories"/></div>
            </fieldset>
        </div>
        <center><div style="margin-top:20px;margin-bottom:10px;"><input type="submit" value="Submit"/></div></center>

    </div>
</form>