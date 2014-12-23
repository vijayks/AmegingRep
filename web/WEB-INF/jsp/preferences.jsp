<%--
    Document   : preferences
    Created on : May 6, 2009, 5:50:26 PM
    Author     : bbsadmin
--%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<script type="text/javascript" src="js/strz.js"></script>
<script type="text/javascript" language="javaScript">

    function checks(checkAllState, idStr)
    {
        // alert("fun called idStr="+idStr);
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

function validatMe(prForm){
    var timeFrom = prForm.smsTimeFrom.value;
    var timeTo = prForm.smsTimeTo.value;
    var period=timeFrom-timeTo;
    if(period==0 ||period==1 || period==-1){
        inlineMsg('smsTimeTo','Select Minimum two hours timeslot.');
        return false;
    }
    return true;
}

</script>

<c:if test="${prefs != null}" >
    <div   style="clear:both;width:720px;">
        <div   style="width:720px;height:5px;"></div>
        <div class="pt"><div class="pb"><div class="pl"><div class="pr"><div class="pbl"><div class="pbr"><div class="ptl"><div class="ptr">
                                        <table align="center"><td><div style="width:720px;">

                                                    <form action="prefsInsert.do" name="prForm" method="post" onsubmit="return validatMe(this)">

                                                        <div style="padding-top:15px; padding-left:15px" width="100%" valign="top" class="verdana_form_mainhead"><b>Preferences</b></div>
                                                         <div  style="width:700px;"><div style="border:1px solid #ffcc33"></div></div>

                                                        <div style="padding-top:10px; padding-left:25px" width="100%" valign="top" class="fv12bc"><b>Ad Preferences</b></div>
                                                        <div class="fv11" align="left" style="float:left;width:720px;padding-top:5px;">
                                                            <div   style="float:left;width:150px;padding-left:35px;padding-top:5px;"> Maximum Ads per day<font color="red">*&nbsp; </font></div>
                                                            <div   style="float:left;width:530px;padding-left:5px;padding-top:5px;">
                                                                <select name="maxSms" id="maxSms" >
                                                                    <option value="3">3</option>
                                                                    <option value="5">5</option>
                                                                    <option value="7">7</option>
                                                                    <option value="10">10</option>
                                                                </select>
                                                            </div>
                                                            <div   style="float:left;width:150px;padding-left:35px;padding-top:5px;">Receive ads between<font color="red">* </font></div>
                                                            <div   style="float:left;width:530px;padding-left:5px;padding-top:5px;">
                                                                <select name="smsTimeFrom" id="smsTimeFrom"  >
                                                                    <option value="0">12 AM</option>

                                                                    <option value="1">1 AM</option>
                                                                    <option value="2">2 AM</option>
                                                                    <option value="3">3 AM</option>
                                                                    <option value="4">4 AM</option>
                                                                    <option value="5">5 AM</option>
                                                                    <option value="6">6 AM</option>
                                                                    <option value="7">7 AM</option>
                                                                    <option value="8">8 AM</option>
                                                                    <option value="9">9 AM</option>

                                                                    <option value="10">10 AM</option>
                                                                    <option value="11">11 AM</option>
                                                                    <option value="12">12 PM</option>
                                                                    <option value="13">1 PM</option>
                                                                    <option value="14">2 PM</option>
                                                                    <option value="15">3 PM</option>
                                                                    <option value="16">4 PM</option>
                                                                    <option value="17">5 PM</option>
                                                                    <option value="18">6 PM</option>

                                                                    <option value="19">7 PM</option>
                                                                    <option value="20">8 PM</option>
                                                                    <option value="21">9 PM</option>
                                                                    <option value="22">10 PM</option>
                                                                    <option value="23">11 PM</option>
                                                                    <option value="24">12 PM</option>
                                                                </select>
                                                                to
                                                                <select name="smsTimeTo" id="smsTimeTo" size="1" >
                                                                    <option value="0">12 AM</option>

                                                                    <option value="1">1 AM</option>
                                                                    <option value="2">2 AM</option>
                                                                    <option value="3">3 AM</option>
                                                                    <option value="4">4 AM</option>
                                                                    <option value="5">5 AM</option>
                                                                    <option value="6">6 AM</option>
                                                                    <option value="7">7 AM</option>
                                                                    <option value="8">8 AM</option>
                                                                    <option value="9">9 AM</option>

                                                                    <option value="10">10 AM</option>
                                                                    <option value="11">11 AM</option>
                                                                    <option value="12">12 PM</option>
                                                                    <option value="13">1 PM</option>
                                                                    <option value="14">2 PM</option>
                                                                    <option value="15">3 PM</option>
                                                                    <option value="16">4 PM</option>
                                                                    <option value="17">5 PM</option>
                                                                    <option value="18">6 PM</option>

                                                                    <option value="19">7 PM</option>
                                                                    <option value="20">8 PM</option>
                                                                    <option value="21">9 PM</option>
                                                                    <option value="22">10 PM</option>
                                                                    <option value="23">11 PM</option>
                                                                    <option value="24">12 PM</option>
                                                                </select>

                                                            </div>

                                                            <div   style="float:left;width:150px;padding-left:35px;padding-top:5px;">Channel<font color="red">* </font></div>
                                                            <div   style="float:left;width:530px;padding-left:5px;padding-top:5px;">
                                                                <select name="share" id="share"  size="1">

                                                                    <option value="3" >Email &amp; Mobile</option>
                                                                    <option value="2" >Email</option>
                                                                    <option value="1">Mobile</option>
                                                                </select>
                                                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" name="callMe" id="callMe" value="1"<c:if test="${prefs.callMe == 1}"> checked </c:if> > Call Me
                                                            </div>

                                                        </div>
                                                        <div   style="clear:both;width:720px;height:10px;"></div>

                                                        <div style="padding-top:10px; padding-left:25px" width="100%" valign="top" class="fv12bc"><b>Category Preferences</b></div>

                                                        <div  class="fv11" style="clear:both;width:685px;height:10px;padding-left:35px;padding-top:5px;">( select minimun five categories )</div>
                                                        <div class="fv11" style="width:720px;float:left;height:10px;"></div>
                                                        <div class="fv11" style="width:720px;float:left;">

                                                            <c:if test="${categoryList != null}" >

                                                                <c:forEach items="${categoryList}" var="category" >

                                                                    <c:if test="${category.parent == 0}">



                                                                        <div  style="width:685px;padding-left:35px;">
                                                                            <c:set var="s">sub<c:out value="${category.id}" /></c:set>
                                                                            <c:set var="i">img<c:out value="${category.id}" /></c:set>
                                                                            <img id="${i}" src="images/plus.png" onclick="toggle_s('${s}','${i}')"/>


                                                                            <c:set var="tmp" value=""/>
                                                                            <c:if test="${category.subCategories != null}">
                                                                                <c:forEach items="${category.subCategories}" var ="catt" varStatus="loop">
                                                                                    <c:set var="tmp" value="${tmp}${catt.id}|" />


                                                                                </c:forEach>
                                                                            </c:if>

                                                                            &nbsp;<input type="checkbox" name="cat"  id="${category.id}" value="${category.id}"
                                                                                         <c:if test="${prefs.catIds != null}">
                                                                                             <c:forEach items="${prefs.catIds}" var ="aaa" >
                                                                                                 <c:if test="${aaa  == category.id}">
                                                                                                     checked="true"

                                                                                                 </c:if>

                                                                                             </c:forEach>
                                                                                         </c:if>
                                                                                         onClick="checks(this,'<c:out value="${tmp}"/>')">&nbsp;

                                                                            <a title="<c:out value='${category.name}' escapeXml='false'/>" href="javascript:return false" style="text-decoration:none;color:#222222;padding-left:5px" onclick="toggle_s('${s}','${i}')"  >
                                                                            <c:out value="${category.name}" escapeXml="false"/></a>
                                                                        </div>

                                                                        <c:if test="${category.subCategories != null}">
                                                                            <div style="width:720px;float:left;display:none;"  id="${s}"  >
                                                                                <c:forEach items="${category.subCategories}" var ="cat">

                                                                                    <div style="width:665px;padding-left:55px;" >
                                                                                        <img src="images/arrow.gif" />

                                                                                        <input type="checkbox"  name="cat" id="${cat.id}"   value="${cat.id}"
                                                                                               <c:if test="${prefs.catIds != null}">
                                                                                                   <c:forEach items="${prefs.catIds}" var ="aaa" >
                                                                                                       <c:if test="${aaa  == cat.id}">
                                                                                                           checked="true"

                                                                                                       </c:if>

                                                                                                   </c:forEach>
                                                                                               </c:if>
                                                                                               onclick="reCheck(this,'${category.id}','<c:out value="${tmp}"/>')" />

                                                                                        <c:out value="${cat.name}" escapeXml="false"/>
                                                                                    </div>
                                                                                    <div class="fv11" style="width:720px;float:left;height:6px;"></div>
                                                                                </c:forEach>
                                                                            </div>

                                                                        </c:if>
                                                                        <div class="fv11" style="width:720px;float:left;height:8px;"></div>
                                                                    </c:if>

                                                                </c:forEach>
                                                            </c:if>

                                                        </div>

                                                        <div  style="width:720px;float:left;height:10px;"></div>

                                                        <div style="padding-top:10px; padding-left:25px" width="100%" valign="top" class="fv12bc"><b>Other Preferences</b></div>
                                                        <div  class="fv11" style="clear:both;width:685px;height:10px;padding-left:35px;padding-top:5px;">( Apart from the preferences selected above, you can specify other preferences below )</div>
                                                        <div class="fv11" style="width:720px;float:left;height:10px;"></div>

                                                        <div  style="width:685px;padding-left:35px;">
                                                            <textarea name="otherInterestField" id="otherInterestField" cols="50" rows="2" wrap="hard"></textarea>
                                                        </div>
                                                        <div  style="width:720px;float:left;height:10px;"></div>
                                                        <div class="fv11" style="width:520px;padding-left:200px;float:left;" >
                                                            <input type="image" src="bbsimages/buttons/Save.png" onmouseover="this.src='bbsimages/buttons/Save_MouseOver.png';" onmouseout="this.src='bbsimages/buttons/Save.png';"  onclick="return validMe(this)">
                                                            <input type="image" src="bbsimages/buttons/Cancel.png" onmouseover="this.src='bbsimages/buttons/Cancel_MouseOver.png';" onmouseout="this.src='bbsimages/buttons/Cancel.png';" >
                                                        </div>


                                                        <div style="width:720px;float:left;height:10px;"></div>




                                                    </form>
                                                </div>
                                            </td>
                                        </table>
                                    </div></div></div></div></div></div></div></div>
    </div>

    <script >
        document.getElementById('smsTimeFrom').value='<c:out value="${prefs.smsTimeFrom}" />';
        document.getElementById('smsTimeTo').value='<c:out value="${prefs.smsTimeTo}" />';
        document.getElementById('maxSms').value='<c:out value="${prefs.maxSms}" />';
        document.getElementById('share').value='<c:out value="${prefs.respType}" />';
    </script>


</c:if>





<c:if test="${prefs == null}" >

    <div   style="clear:both;width:720px;">
        <div class="pt"><div class="pb"><div class="pl"><div class="pr"><div class="pbl"><div class="pbr"><div class="ptl"><div class="ptr">
                                        <table align="center"><td><div style="width:720px;">

                                                    <form action="prefsInsert.do"  method="post" onsubmit="return validatMe(this)">
                                                        <input  type="hidden"  name="havePreps" value="have">
                                                        <div style="padding-top:15px; padding-left:15px" width="100%" valign="top" class="verdana_form_mainhead"><b>Preferences</b></div>
                                                        <div  style="width:700px;"><div style="border:1px solid #ffcc33"></div></div>
                                                        <div style="padding-top:10px; padding-left:25px" width="100%" valign="top" class="fv12bc"><b>Ad Preferences</b></div>
                                                        <div class="fv11" align="left" style="float:left;width:720px;padding-top:5px;">
                                                            <div   style="float:left;width:150px;padding-left:35px;padding-top:5px;"> Maximum Ads per day<font color="red">*&nbsp; </font></div>
                                                            <div   style="float:left;width:530px;padding-left:5px;padding-top:5px;">
                                                                <select name="maxSms" id="maxSms" >
                                                                    <option value="3">3</option>
                                                                    <option value="5">5</option>
                                                                    <option value="7">7</option>
                                                                    <option value="10">10</option>
                                                                </select>
                                                            </div>
                                                            <div   style="float:left;width:150px;padding-left:35px;padding-top:5px;">Receive ads between<font color="red">* </font></div>
                                                            <div   style="float:left;width:530px;padding-left:5px;padding-top:5px;">
                                                                <select name="smsTimeFrom" id="smsTimeFrom"  >
                                                                    <option value="0">12 AM</option>

                                                                    <option value="1">1 AM</option>
                                                                    <option value="2">2 AM</option>
                                                                    <option value="3">3 AM</option>
                                                                    <option value="4">4 AM</option>
                                                                    <option value="5">5 AM</option>
                                                                    <option value="6">6 AM</option>
                                                                    <option value="7">7 AM</option>
                                                                    <option value="8">8 AM</option>
                                                                    <option value="9">9 AM</option>

                                                                    <option value="10">10 AM</option>
                                                                    <option value="11">11 AM</option>
                                                                    <option value="12">12 PM</option>
                                                                    <option value="13">1 PM</option>
                                                                    <option value="14">2 PM</option>
                                                                    <option value="15">3 PM</option>
                                                                    <option value="16">4 PM</option>
                                                                    <option value="17">5 PM</option>
                                                                    <option value="18">6 PM</option>

                                                                    <option value="19">7 PM</option>
                                                                    <option value="20">8 PM</option>
                                                                    <option value="21">9 PM</option>
                                                                    <option value="22">10 PM</option>
                                                                    <option value="23">11 PM</option>
                                                                    <option value="24">12 PM</option>
                                                                </select>
                                                                to
                                                                <select name="smsTimeTo" id="smsTimeTo" size="1" >
                                                                    <option value="0">12 AM</option>

                                                                    <option value="1">1 AM</option>
                                                                    <option value="2">2 AM</option>
                                                                    <option value="3">3 AM</option>
                                                                    <option value="4">4 AM</option>
                                                                    <option value="5">5 AM</option>
                                                                    <option value="6">6 AM</option>
                                                                    <option value="7">7 AM</option>
                                                                    <option value="8">8 AM</option>
                                                                    <option value="9">9 AM</option>

                                                                    <option value="10">10 AM</option>
                                                                    <option value="11">11 AM</option>
                                                                    <option value="12">12 PM</option>
                                                                    <option value="13">1 PM</option>
                                                                    <option value="14">2 PM</option>
                                                                    <option value="15">3 PM</option>
                                                                    <option value="16">4 PM</option>
                                                                    <option value="17">5 PM</option>
                                                                    <option value="18">6 PM</option>

                                                                    <option value="19">7 PM</option>
                                                                    <option value="20">8 PM</option>
                                                                    <option value="21">9 PM</option>
                                                                    <option value="22">10 PM</option>
                                                                    <option value="23">11 PM</option>
                                                                    <option value="24">12 PM</option>
                                                                </select>

                                                            </div>

                                                            <div   style="float:left;width:150px;padding-left:35px;padding-top:5px;">Channel<font color="red">* </font></div>
                                                            <div   style="float:left;width:530px;padding-left:5px;padding-top:5px;">
                                                                <select name="share" id="share"  size="1">

                                                                    <option value="3" >Email &amp; Mobile</option>
                                                                    <option value="2" >Email</option>
                                                                    <option value="1">Mobile</option>
                                                                </select>
                                                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" name="callMe" id="callMe" value="1"<c:if test="${prefs.callMe == 1}"> checked </c:if> > Call Me
                                                            </div>

                                                        </div>
                                                        <div   style="clear:both;width:720px;height:10px;"></div>

                                                        <div style="padding-top:10px; padding-left:25px" width="100%" valign="top" class="fv12bc"><b>Category Preferences</b></div>

                                                        <div  class="fv11" style="clear:both;width:685px;height:10px;padding-left:35px;padding-top:5px;">( select minimun five categories )</div>
                                                        <div class="fv11" style="width:720px;float:left;height:10px;"></div>
                                                        <div class="fv11" style="width:720px;float:left;">

                                                            <c:if test="${categoryList != null}" >

                                                                <c:forEach items="${categoryList}" var="category" >

                                                                    <c:if test="${category.parent == 0}">



                                                                        <div align="left" style="font-family:verdana;font-size:11px;padding-left:25px;padding-top:10px;">
                                                                            <c:set var="s">sub<c:out value="${category.id}" /></c:set>
                                                                            <c:set var="i">img<c:out value="${category.id}" /></c:set>
                                                                            <img id="${i}" src="images/plus.png" onclick="toggle_s('${s}','${i}')"/>


                                                                            <c:set var="tmp" value=""/>
                                                                            <c:if test="${category.subCategories != null}">
                                                                                <c:forEach items="${category.subCategories}" var ="catt" varStatus="loop">
                                                                                    <c:set var="tmp" value="${tmp}${catt.id}|" />


                                                                                </c:forEach>
                                                                            </c:if>

                                                                            &nbsp;<input type="checkbox" name="cat" checked id="${category.id}" value="${category.id}" onClick="checks(this,'<c:out value="${tmp}"/>')">&nbsp;

                                                                            <a  title="<c:out value="${category.name}" escapeXml="false"/>" href="javascript:return false" style="text-decoration:none;color:#222222;padding-left:5px" onclick="toggle_s('${s}','${i}')"  >
                                                                            <c:out value="${category.name}" escapeXml="false"/></a>
                                                                        </div>

                                                                        <c:if test="${category.subCategories != null}">
                                                                            <div align="left" id="${s}" style="font-family:verdana;font-size:11px;display:none;">
                                                                                <c:forEach items="${category.subCategories}" var ="cat">

                                                                                    <div style="padding-left:40px;padding-top:3px">
                                                                                        <img src="images/arrow.gif" style="padding-right:5px;border-color:#ffffff" />

                                                                                        <input type="checkbox" checked name="cat" id="${cat.id}" value="${cat.id}" onclick="reCheck(this,'${category.id}','<c:out value="${tmp}"/>')" />

                                                                                    <c:out value="${cat.name}" escapeXml="false"/> </div>

                                                                                </c:forEach>
                                                                            </div>
                                                                        </c:if>

                                                                    </c:if>

                                                                </c:forEach>
                                                            </c:if>

                                                        </div>

                                                        <div  style="width:720px;float:left;height:10px;"></div>

                                                        <div style="padding-top:10px; padding-left:25px" width="100%" valign="top" class="fv12bc"><b>Other Preferences</b></div>
                                                        <div  class="fv11" style="clear:both;width:685px;height:10px;padding-left:35px;padding-top:5px;">( Apart from the preferences selected above, you can specify other preferences below )</div>
                                                        <div class="fv11" style="width:720px;float:left;height:10px;"></div>

                                                        <div  style="width:685px;padding-left:35px;">
                                                            <textarea name="otherInterestField" id="otherInterestField" cols="50" rows="2" wrap="hard"></textarea>
                                                        </div>
                                                        <div  style="width:720px;float:left;height:10px;"></div>
                                                        <div class="fv11" style="width:520px;padding-left:200px;float:left;" >
                                                            <input type="submit" value="Save" onclick="return validMe(this)">  <input type="button" value="Cancel">
                                                        </div>


                                                        <div style="width:720px;float:left;height:10px;"></div>




                                                    </form>
                                                </div>
                                            </td>
                                        </table>
                                    </div></div></div></div></div></div></div></div>

    </div>


</c:if>

