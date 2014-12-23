<%--
    Document   : createLink
    Created on : Feb 15, 2010, 3:51:59 PM
    Author     : bbsadmin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<script type="text/javascript" language="javascript" src="js/alljs.js"></script>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<style>

    #linkTab{
        FONT-SIZE:12px;
        margin-left:23px;
    }



</style>

<script>
    var count=0;
    function changeVrificationCode1()
    {
        document.getElementById("regCode").value="";

        document.getElementById("codeTestNo").style.display='none';
        document.getElementById("codeTestYes").style.display='none';

        toggle_disable('rButtonDis','rButton');
        count++;
        document.getElementById('verId1').src='rig?1='+count;
    }


</script>
<script>
    function  validate(){<%--alert('mn');--%>

        var emailRegex = /^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$/;

        var category=document.getElementById('category').value;
        var url=document.getElementById('url').value;
        var title=document.getElementById('title').value;
        var email=document.getElementById('lprice').value;
        var desc=document.getElementById('description').value;
        var mob=document.getElementById('oprice').value;

        var chk=true;
        if(category==0){
            alert("Please select a category!"); return false;
        }else if(url==""){
            alert("Please enter url !"); return false;
        }else if((url!="")){

            var cnt=0;
            for(i=0;i<url.toString().length;i++){
                if((url[i-1]=='.') &&(url[i])=='.'){
                   alert("Please enter valid URl !");
                    return false;
                }
                if(url[i]=='.')
                    cnt++;
            }
                if(cnt==0)  {
                alert("Please enter valid URL !");
                 return false;}

        }
        if(title==""){
            alert("Please enter title!"); return false;
        }else if((email=="") || (!email.match(emailRegex))){
            alert("Please enter appropriate Email!"); return false;
        }else if(mob==""){
            alert("Please enter Mobile Number!"); return false;
        }else if(desc==""){
            alert("Please enter Description!"); return false;
        }else {
           // return true;

            document.createLink.submit();
        }
       <%-- return chk;--%>
    }
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
</script>

<br/><br/>
<div style="border:1px solid #cccccc">
    <div style="border:1px solid #cccccc;"><span style="margin-left:8px;color:red;font-size:13px"><b>Link Your URLs:</b></span></div>
    <br/>
    <center>
        <c:if test="${okF!=null}">
            <span style="color:red">${okF}</span>
        </c:if>
        <c:if test="${okS!=null}">
            <span style="color:green">${okS}</span>
        </c:if>
    </center>
    <div style="margin-left:10px"><span style="font-size:10px;color:#0066cc"><b>Submit your URLs:</b></span></div>
    <form name="createLink" action="createLinkAc.do" method="POST" >

        <table id="linkTab" style="margin-left:20%">
            <tr>
                <td>Category </td>
                <td style="padding-left:10px"><select name="category" id="category" >
                        <option value="0">Select Category</option>

                        <c:forEach items="${categoryList}" var="cats">
                            <c:if test="${cats.parent == 0}" >
                                <option value="<c:out value='${cats.id}'/>"> <c:out value='${cats.name}' escapeXml="false"/> </option>
                            </c:if>
                        </c:forEach>
                    </select></td>
                <td></td>
            </tr>
            <tr>
                <td>Website URL</td>
                <td style="padding-left:10px"><input type="text" name="url" id="url" value="http://www"/></td>
                <td></td>
            </tr>
            <tr>
                <td>Title</td>
                <td style="padding-left:10px"><input type="text" id="title" name="title"/></td>
                <td></td>
            </tr>
            <tr>
                <td>Email:</td>
                <td style="padding-left:10px"><input type="text" id="lprice"name="lprice"/></td>
                <td></td>
            </tr>
            <tr>
                <td>Mobile :</td>
                <td style="padding-left:10px"><input type="text" id="oprice" name="oprice" onKeyPress="return numbersonly(event, false)" maxlength="10" /></td>
                <td></td>
            </tr>
            <tr>
                <td>Description:</td>
                <td style="padding-left:10px"><textarea rows="5" cols="50" id="description" name="description" onKeyDown="limitText(this.form.description,this.form.countdown,250);" onKeyUp="limitText(this.form.description,this.form.countdown,250);"></textarea></td>
                <td></td>
            </tr>
            <tr>
                <td>Enter the code:</td>
                <td style="padding-left:10px"> <input id="regCode" name="regCode" type="text" style="width:250px;"
                                                      onblur="CheckRegCode(this)" />
                    <br/>
                    <span id="codeTestNo" style="color:red;display:none" >&nbsp;&nbsp;&nbsp;Verification doesn't matched</span>
                    <span id="codeTestYes" style="color:red;display:none" >Code Matched</span></td>
                <td>   <div id="firstCode" style="display:inline;" >
                        <img alt="" id="verId1" src="rig" style="height:35px;width:130px;"/>
                    </div>
                    &nbsp;&nbsp;
                    <div id="firstLink" style="display:inline">

                        <a class="link11"  href="javascript:return false;" onclick="changeVrificationCode1();event.returnValue=false;return false;" > <img src="bbsimages/referesh_button.jpg" style="border:none;height:50px" /></a>
                    </div></td>
            </tr>
            <tr>
                <td></td>
                <td style="padding-left:10px">   <input id="rButtonDis" type="button" value="submit" disabled  onclick="" />
                    <input id="rButton" type="button" style="display:none" value="submit" onclick="validate()"></td>
                <td></td>
            </tr>
        </table>

    </form></div>


