<%--
    Document   : CategoryPreferences
    Created on : Mar 11, 2010, 11:15:13 AM
    Author     : Madhuri--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<script type="text/javascript" src="js/strz.js"></script>
<script type="text/javascript" language="javaScript">

    function checks(checkAllState, idStr)
    {
        //  alert("fun called idStr="+idStr);
        var separator = "|";

        var tokenizer = new StringTokenizer (idStr, separator);

        while (tokenizer.hasMoreTokens())
        {
            document.getElementById(tokenizer.nextToken()).checked=checkAllState.checked;

        }

        /*      for(var j=0; j<intarr.length ; j++)
            {
                alert(intarr[j]);
            }
      /  elements  = document.getElementsByName('cat');
        alert("elements.length="+elements.length);

        for (i = 0; i < elements.length; i++)
        {
            if(elements[i].value == cbGroups)
            {

                elements[i].checked = checkAllState.checked;
            }

        }*/

    }

    function reCheck(curStatus,mainCatId,idStr)
    {
        var separator = "|";
        var i=0;
        var tokenizer = new StringTokenizer (idStr, separator);
        // alert(mainCatId);
        // alert(idStr);
        // alert("No. of tokens="+tokenizer.countTokens());
        if(curStatus.checked == true)
        {

            document.getElementById(mainCatId).checked = true;

        }
        else
        {

            while (tokenizer.hasMoreTokens())
            {

                if(document.getElementById(tokenizer.nextToken()).checked==curStatus.checked)
                {

                    i++;//alert("i="+i);
                }

            }
            if(i == tokenizer.countTokens())
            {
                //  alert("inside");
                document.getElementById(mainCatId).checked=curStatus.checked;
            }
        }



    }


    function toggle_s(itemID,img)
    {

        if((document.getElementById(itemID).style.display == 'none'))
        {

            document.getElementById(itemID).style.display = 'inline';
            document.getElementById(img).src='images/minus.png';

        }
        else
        {
            document.getElementById(itemID).style.display = 'none';
            document.getElementById(img).src='images/plus.png';
        }
    }

    function validatMe(){
        alert("hi");
        return false;
    <%--var timeFrom = prForm.smsTimeFrom.value;
    var timeTo = prForm.smsTimeTo.value;
    var period=timeFrom-timeTo;
    if(period==0 ||period==1 || period==-1){
        inlineMsg('smsTimeTo','Select Minimum two hours timeslot.');
        return false;
    }
    return true;--%>
        }


</script>
<script>

    function submitFrm1(){

        //alert(document.updateFrm.wbId.value);

        var webNm=document.updateFrm.wbNM.value; //alert(webNm);
        if(webNm==""){ alert("Please enter Webshop Name."); return false;}

        var chkBoxLength=document.updateFrm.cat.length;

        //alert(chkBoxLength);

        var chk=0;

        for(var i=0;i<chkBoxLength;i++){

            if(eval(document.updateFrm.cat[i]).checked==true){
                chk++;
            }
        }

        if(chk=='0'){
            alert("Please select atleast one category and one sub-category");
            return false;
        }

        document.updateFrm.submit();
        return true;

    }
</script>


<c:if test="${(catList!=null)}">
    <c:if test="${(categoryWS==null)}">
        <div   style="clear:both;width:720px;">
            <div class="pt" style=""><div class="pb"><div class="pl"><div class="pr"><div class="pbl"><div class="pbr"><div class="ptl"><div class="ptr">
                                            <table align="center"><td><div style="height:500px;width:720px;">

                                                        <form action="wsCreation.do" method="post" name="prefFrm" onsubmit="return validatMe(this)">
                                                            <div style="font-size:12px;padding-top:40px">Webshop&nbsp;&nbsp;<input type="text" name="wbNM" value=""/></div>

                                                            <div style="margin-top:30px;padding-top:10px; padding-left:25px" width="100%" valign="top" class="fv12bc"><b>Category Preferences</b></div>
                                                            <div  class="fv11" style="clear:both;width:685px;height:10px;padding-left:35px;padding-top:5px;">( select minimum One Category and One Sub-Category )</div>
                                                            <div class="fv11" style="width:720px;float:left;height:10px;"></div>

                                                            <div class="fv11" style="width:720px;float:left;">

                                                                <c:if test="${catList != null}" >

                                                                    <c:forEach items="${catList}" var="category" >

                                                                        <c:if test="${category.parentId == 0}">
                                                                            <div align="left" style="font-family:verdana;font-size:11px;padding-left:25px;padding-top:10px;">
                                                                                <c:set var="s">sub<c:out value="${category.catId}" /></c:set>
                                                                                <c:set var="i">img<c:out value="${category.catId}" /></c:set>
                                                                                <img id="${i}" src="images/plus.png" onclick="toggle_s('${s}','${i}')"/>

                                                                                <c:set var="tmp" value=""/>
                                                                                <c:forEach items="${catList}" var="cll">
                                                                                    <c:if test="${cll.parentId!=0}">
                                                                                        <c:if test="${cll.parentId==category.catId}">
                                                                                            <c:set var="tmp" value="${tmp}${cll.catId}|" />
                                                                                        </c:if>
                                                                                    </c:if>
                                                                                </c:forEach>
                                                                                &nbsp;<input type="checkbox" name="cat" checked id="${category.catId}" value="${category.catId}" onClick="checks(this,'<c:out value="${tmp}"/>')">&nbsp;

                                                                                <a  title="<c:out value="${category.name}" escapeXml="false"/>" href="javascript:return false" style="text-decoration:none;color:#222222;padding-left:5px" onclick="toggle_s('${s}','${i}')"  >
                                                                                <c:out value="${category.name}" escapeXml="false"/> </a>
                                                                            </div>

                                                                            <c:if test="${catList != null}" >

                                                                                <div align="left" id="${s}" style="font-family:verdana;font-size:11px;display:none;">
                                                                                    <c:forEach items="${catList}" var="cat">
                                                                                        <c:if test="${cat.parentId!=0}">
                                                                                            <c:set var="pId" value="${cat.catId}"/> <c:if test="${category.catId==cat.parentId}">
                                                                                                <c:if test="${cat.catId==pId}">

                                                                                                    <div style="padding-left:40px;padding-top:3px">
                                                                                                        <img src="images/arrow.gif" style="padding-right:5px;border-color:#ffffff" />

                                                                                                        <input type="checkbox" checked name="cat" id="${cat.catId}" value="${cat.catId}" onclick="reCheck(this,'${category.catId}','<c:out value="${tmp}"/>')" />


                                                                                                    <c:out value="${cat.name}" escapeXml="false"/> </c:if></div>
                                                                                            </c:if>
                                                                                        </c:if>

                                                                                    </c:forEach>
                                                                                </div>
                                                                                <c:set var="tmp" value="${tmp}${cat.catId}|" />

                                                                            </c:if>

                                                                        </c:if>

                                                                    </c:forEach>
                                                                </c:if>

                                                            </div>
                                                        </form>
                                                        <script>
                                                            function submitFrm(){
                                                                var webNm=document.prefFrm.wbNM.value;
                                                                if(webNm==""){ alert("Please enter Webshop Name."); return false;}
                                                                var chkBoxLength=document.prefFrm.cat.length;
                                                            <%-- alert(chkBoxLength);--%>
                                                                    var chk=0;
                                                                    for(var i=0;i<chkBoxLength;i++){
                                                                        if(eval(document.prefFrm.cat[i]).checked==true){
                                                                            chk++;
                                                                        }
                                                                    }
                                                                    if(chk=='0'){
                                                                        alert("Please select atleast one category and one sub-category");
                                                                        return false;
                                                                    }

                                                                    document.prefFrm.submit();
                                                                    return true;

                                                                }</script>
                                                    </div>
                                                </td>
                                            </table><center> <img src="bbsimages/buttons/Generate.png" onclick="submitFrm()" style="border:0" alt="generate"/>
                                                <a href="#"><img src="bbsimages/buttons/Cancel.png" style="border:0"alt="cancel" /></a></center><br/>
                                        </div></div></div></div></div></div></div></div>

        </div></c:if>
    <c:if test="${categoryWS!=null}">
        <div   style="clear:both;width:720px;">
            <div class="pt" style=""><div class="pb"><div class="pl"><div class="pr"><div class="pbl"><div class="pbr"><div class="ptl"><div class="ptr">
                                            <table align="center"><td><div style="height:500px;width:720px;">
                                                        <form action="updateWS.do" method="post" name="updateFrm" onSubmit="return validateMe(this)">
                                                            <div style="font-size:12px;padding-top:40px">Webshop&nbsp;&nbsp;<input type="text" name="wbNM" value="<%= request.getParameter("nm") %>"/><input type="hidden" name="wbId" value="<%= request.getParameter("wsId")%>"/></div>

                                                            <div style="margin-top:30px;padding-top:10px; padding-left:25px" width="100%" valign="top" class="fv12bc"><b>Category Preferences </b></div>
                                                            <div  class="fv11" style="clear:both;width:685px;height:10px;padding-left:35px;padding-top:5px;">( select minimum One Category and One Sub-Category )</div>
                                                            <div class="fv11" style="width:720px;float:left;height:10px;"></div>
                                                            <div class="fv11" style="width:720px;float:left;">
                                                                <c:if test="${catList != null}" >
                                                                    <c:forEach items="${catList}" var="category" >
                                                                        <c:if test="${category.parentId == 0}">
                                                                            <div align="left" style="font-family:verdana;font-size:11px;padding-left:25px;padding-top:10px;">
                                                                                <c:set var="s">sub<c:out value="${category.catId}" /></c:set>
                                                                                <c:set var="i">img<c:out value="${category.catId}" /></c:set>
                                                                                <img id="${i}" src="images/plus.png" onclick="toggle_s('${s}','${i}')"/>
                                                                                <c:set var="tmp" value=""/>
                                                                                <c:forEach items="${catList}" var="cll">
                                                                                    <c:if test="${cll.parentId!=0}">
                                                                                        <c:if test="${cll.parentId==category.catId}">
                                                                                            <c:set var="tmp" value="${tmp}${cll.catId}|" />
                                                                                        </c:if>
                                                                                    </c:if>
                                                                                </c:forEach>
                                                                                &nbsp;<input type="checkbox" name="cat"

                                                                                             <c:forEach items="${categoryWS}" var="existL">

                                                                                                 <c:if test="${category.catId==existL.catId}">

                                                                                                     checked
                                                                                                 </c:if>
                                                                                             </c:forEach>
                                                                                             id="${category.catId}" value="${category.catId}" onClick="checks(this,'<c:out value="${tmp}"/>')">&nbsp;

                                                                                <a  title="<c:out value="${category.name}" escapeXml="false"/>" href="javascript:return false" style="text-decoration:none;color:#222222;padding-left:5px" onclick="toggle_s('${s}','${i}')"  >
                                                                                <c:out value="${category.name}" escapeXml="false"/> </a>
                                                                            </div>

                                                                            <c:if test="${catList != null}" >

                                                                                <div align="left" id="${s}" style="font-family:verdana;font-size:11px;display:none;">
                                                                                    <c:forEach items="${catList}" var="cat">
                                                                                        <c:if test="${cat.parentId!=0}">
                                                                                            <c:set var="pId" value="${cat.catId}"/> <c:if test="${category.catId==cat.parentId}">
                                                                                                <c:if test="${cat.catId==pId}">

                                                                                                    <div style="padding-left:40px;padding-top:3px">
                                                                                                        <img src="images/arrow.gif" style="padding-right:5px;border-color:#ffffff" />

                                                                                                        <input type="checkbox"
                                                                                                               <c:forEach items="${categoryWS}" var="existL">
                                                                                                                   <c:if test="${cat.catId==existL.catId}">
                                                                                                                       checked
                                                                                                                   </c:if>
                                                                                                               </c:forEach>

                                                                                                               name="cat" id="${cat.catId}" value="${cat.catId}" onclick="reCheck(this,'${category.catId}','<c:out value="${tmp}"/>')" />


                                                                                                    <c:out value="${cat.name}" escapeXml="false"/> </div></c:if>
                                                                                            </c:if>
                                                                                        </c:if>

                                                                                    </c:forEach>

                                                                                </div>
                                                                                <c:set var="tmp" value="${tmp}${cat.catId}|" />

                                                                            </c:if>

                                                                        </c:if>

                                                                        <%--</c:forEach>--%>

                                                                    </c:forEach>
                                                                </c:if>
                                                            </div>
                                                        </form>

                                                    </div>
                                                </td>
                                            </table><center><img src="bbsimages/buttons/Update.png" onclick="return submitFrm1()" style="border:0" alt="generate"/>
                                                <a href="#"><img src="bbsimages/buttons/Cancel.png" style="border:0"alt="cancel" /></a></center><br/>
                                        </div></div></div></div></div></div></div></div>
        </div>

    </c:if></c:if>

    <div style="margin-top:200px">
    <c:if test="${fn:length(categoryWS)=='0'}">
        <center><span style="font-size:14px;color:red"><b> No webshop is created .</b></span></center>
</c:if></div>