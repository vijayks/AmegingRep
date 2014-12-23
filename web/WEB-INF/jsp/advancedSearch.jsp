<%--
    Document   : adTemplate
    Created on : Apr 1, 2009, 12:50:13 PM
    Author     : bbsadmin
--%>
<%@ taglib uri="http://struts.apache.org/tags-tiles" prefix="tiles" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn"%>
<script type="text/javascript">
    var globalCok=0;
    function isEligibleToRefine(lcsChieldName, clfsChieldName){
    <c:if test="${cityObj.name == 'All India'}">
        alert("You are in 'All India' , Please Select City to search");
        return false;
    </c:if>
        var locationOk=0;
        var clfOk=globalCok;
        var chieldsList = document.getElementsByName(lcsChieldName);
        if(chieldsList != null && chieldsList.length>0){
            for(var i=0 ; i<chieldsList.length ;i++ )
            {
                if(chieldsList[i].checked ==true)
                {
                    locationOk=1;
                    break;
                }
            }
        }
        chieldsList = document.getElementsByName(clfsChieldName);
        if(chieldsList != null && chieldsList.length>0){
            for(var i=0 ; i<chieldsList.length ;i++ )
            {
                if(chieldsList[i].checked ==true)
                {
                    clfOk=1;
                    break;
                }
            }
        }
        if(locationOk == 0 || clfOk == 0){
            if(locationOk ==0 && clfOk ==0){
                alert("One location and one Classfication must");
            }else if(locationOk ==1 && clfOk ==0){
                alert("One Classfication must");
            }else if(locationOk ==0 && clfOk ==1){
                    alert("One location must") ;
            }
            return false;
        } else {
            var bsf = document.basicSearch;
            if(bsf.keyword.value!=""&&bsf.keyword.value!='What you are looking...? ')
            document.getElementById("rfnKw").value=bsf.keyword.value;
            else
            document.getElementById("rfnKw").value='';
            document.getElementById("rfnSc").value=document.getElementById("subCatId").value;
            document.getElementById("rfnAdt").value=document.getElementById("adType").value;
            document.refnSrch.submit();
        }
        }
        function checkAll(allIdStatus,chieldName)
        {
            var chieldsList = document.getElementsByName(chieldName);
            if(chieldsList != null && chieldsList.length>0){
                for(var i=0 ; i<chieldsList.length ;i++ )
                {
                    chieldsList[i].checked= allIdStatus.checked;
                }
            }
        }
        function reCheckTheAll(chieldIdStatus,allId,chieldName){
            var trimdValue=chieldIdStatus.value;
            while(trimdValue.indexOf(" ")>-1)
                trimdValue=trimdValue.replace(" ","");
            if(chieldIdStatus.checked == false){
                document.getElementById(allId).checked=false;
                document.getElementById(chieldName+trimdValue).checked=false;
            }else{
                document.getElementById(chieldName+trimdValue).checked=true;
                var chieldsList = document.getElementsByName(chieldName);
                if(chieldsList != null && chieldsList.length>0){
                    var c=chieldsList.length ;
                    for(var i=0 ; i<chieldsList.length ;i++ )
                    {
                        if(chieldsList[i].checked== false)
                        {
                            break;
                        }
                    }
                    if(i==chieldsList.length){
                        document.getElementById(allId).checked=true;
                    }
                }
            }

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
<c:if test="${subCatId == '0' }">
    <script type="text/javascript" language="javascript">
    var globalCok=1;
    </script>
</c:if>
<style type="text/css">
    #rfnTbls table{
        width:100%;
       <%-- border-top:1px dashed #BFBFBF;--%>
        <%--font-size:12px;
        font-weight:normal;
        color:#6F6F6F;--%>
    }
    #rfnTbls tr {
        float:left;
        padding:5px 0 0 10px;
        width:175px;
        height:30px;
    }



    .highslide-footer,.highslide-header { display:none; }
</style>
<script type="text/javascript" src="highslide/highslide-full.js"></script>
<link href="highslide/highslide.css" type="text/css" rel="stylesheet" />
<script type="text/javascript">
    hsf.graphicsDir = 'highslide/graphics/';
    hsf.outlineType = 'rounded-white';
    hsf.wrapperClassName = 'draggable-header';
    hsf.dimmingOpacity = 0.25;
    hsf.align='center';
</script>

<!--advance search start-->
                                <div id="accordion2" style="position:relative;">
                                    <dl class="accordion2" id="slider2">
                                        <dt><span>Advanced Search</span><br/></dt>
                                        <dd>
                                            <div>
                                                <div id="txt_part">
                                                    <table width="602" border="0" cellspacing="0" cellpadding="0" style="float:left; background-color:#eeeeee;">
                                                        <tr>
                                                            <td align="left" valign="top">
                                                                <form name="refnSrch" action="sRefine.do" method="post" >
                                                                    <input type="hidden" id="rfnKw" name="keyword" <% String keyword = (String) request.getAttribute("keyword");
                                                                            if (keyword != null) {%> value="<%= keyword%>"<% }%>/>
                                                                    <input type="hidden" id="rfnSc" name="subCatId" <% String subCatId = (String) request.getAttribute("subCatId");if (subCatId != null) {%> value="<%= subCatId%>" <% }%> />
                                                                    <input type="hidden" id="rfnAdt" name="adType" value="<c:out value="${adType}" />" >
                                                                    <input type="hidden" name="from" value="refine" />
                                                                    <!-- If it is directly form Refine search -->
                                                                    <div id="rfnTbls"  class="advance_search_txt" style="">
                                                                        <%--<span class="fv11bw" style="padding-left:25px;"> Select one or more options to refine the search :</span><br />--%>
                                                                        <c:forEach items="${tilesList}" var="tile">
                                                                            <tiles:insert name="${tile}"/>
                                                                        </c:forEach>
                                                                    </div>
                                                                    <div id="lcschk" style="display:none"></div>
                                                                    <div id="clfschk" style="display:none"></div>
                                                                    <input type="hidden" name="m" value="<c:out value="${m}" />">
                                                                </form>
                                                            </td>
                                                        </tr>
                                                        <tr><td>






                                                         <div style="margin-top:10px;padding-left:25px;">
        <c:if test="${cityObj != null && cityObj.name != 'All India'}" >
            <a href="javascript:void(0);" onclick="return hsf.htmlExpand(this,{width:'700',headingText : 'Select One or More Localities'})" style="margin-right:30px;text-decoration:none"><input type="button" value="Refine By locality"  /></a>
            <div id="lclrf" class="highslide-maincontent" style="display:none">   <div style="width:98%;float:left;padding:5px 0 2px 0px;">     <span class="fv11"></span> <br />
                    <div style="margin-bottom:10px;width:100%;text-align:right;font-weight:bold;"><a onclick="return hsf.close(this);"><input type="button" value="Proceed"></a></div>
                    <div  style="height:auto;max-height:250px;overflow:auto;color:#222222;margin-top:4px;border:1px solid #fff;background-color:#FFFFFF;">
                        <c:if test="${cityObj != null }"> <c:if test="${cityObj.loc != null }">
                                <table border="0" cellpadding="0px" cellspacing="0px" style="padding-left:5%;width:650px;">
                                    <tr>
                                        <td> <input id="allLcs" type="checkbox"  value=""  onclick="checkAll(this,'lcs')" <c:if  test="${(localsSelected == null) || (localsSelected != null && (fn:length(localsSelected)) == (fn:length(cityObj.loc)))}" > checked </c:if> ></td>
                                        <td style="padding-left:4px;">All</td>
                                        <c:set var="locCount" value="1"/> <c:forEach items="${cityObj.loc}" var="local">
                                            <td>  <input name="lcs" type="checkbox"  onclick="reCheckTheAll(this,'allLcs','lcs')" value="<c:out value="${local.name}"/>"
                                                         <c:choose> <c:when test="${localsSelected != null }"> <c:forEach items="${localsSelected}" var="selectedLoc"> <c:if test="${local.name == selectedLoc }"> checked="true"  </c:if> </c:forEach> </c:when>
                                                             <c:otherwise> checked="true" </c:otherwise>
                                                       </c:choose> >
                                                <script type="text/javascript">
                                                    var inhdn=document.createElement("input");
                                                                       inhdn.setAttribute("type","checkbox");
                                                                       inhdn.setAttribute("id",'lcs<c:out value="${fn:replace(local.name,' ','')}"/>');
                                                                       inhdn.setAttribute("value",'<c:out value="${local.name}"/>');
                                                                       inhdn.setAttribute("name","lcs");
                                                                       inhdn.checked=false;
                                                   if(!document.getElementById('lcs<c:out value="${fn:replace(local.name,' ','')}"/>'))
                                                                       document.getElementById("lcschk").appendChild(inhdn);
                                                                   </script>
                                                    <c:choose>
                                                    <c:when test="${localsSelected != null }"> <c:forEach items="${localsSelected}" var="selectedLoc">
                                                            <c:if test="${local.name == selectedLoc }">  <script> document.getElementById('lcs<c:out value="${fn:replace(local.name,' ','')}"/>').checked=true; </script> </c:if>
                                                        </c:forEach>  </c:when>
                                                    <c:otherwise> <script> document.getElementById('lcs<c:out value="${fn:replace(local.name,' ','')}"/>').checked=true; </script> </c:otherwise>
                                                       </c:choose>
                                            </td>
                                            <td style="padding-left:4px;"><c:out value="${local.name}"/> </td>
                                        <c:set var="locCount" value="${locCount+1}"/>
                                        <c:if test="${locCount==3}">
                                        </tr>
                                            <tr> <c:set var="locCount" value="0"/>
                                        </c:if>
                                    </c:forEach>
                                            </tr>
                                </table>
                            </c:if>
                        </c:if>
                    </div>
                </div>
        </div>
            </c:if>
            <c:if test="${subCatId != null && subCatId != '0' }">
            <a href="javascript:void(0);" onclick="return hsf.htmlExpand(this,{width:'700',headingText : 'Select One or More Classifications'})" style="margin-right:30px;text-decoration:none"><input type="button" value="Refine By Classification"></a>
            <div id="clfrf" class="highslide-maincontent" style="display:none"> <div style="width:98%;float:left;padding:5px 0 2px 0px;"> <span class="fv11"></span> <br />
                    <div style="margin-bottom:10px;width:100%;text-align:right;font-weight:bold;"><a onclick="return hsf.close(this);"><input type="button" value="Proceed" /></a></div>
                    <div  style="height:auto;max-height:250px;overflow:auto;color:#222222;margin-top:4px;border:1px solid #fff;background-color:#FFFFFF;">
                        <c:if test="${clfIds != null }">  <c:if test="${categoryList != null}" >
                                <table border="0" cellpadding="0px" cellspacing="0px" style="padding-left:5%;width:650px;">
                                    <tr>
                                        <td style="width:26px;"> <input id="allClfs" type="checkbox"  value="" onclick="checkAll(this,'clfs')" <c:if  test="${(clfsSelected == null)||(clfsSelected != null && (fn:length(clfsSelected)) == (fn:length(clfIds))) }" > checked </c:if> ></td>
                                        <td style="padding-left:4px;width:170px;">All</td>
                                        <c:set var="clfCount" value="1"/> <c:forEach items="${clfIds}" var="clfId"> <c:forEach items="${categoryList}" var="cat"> <c:if test="${cat.id == clfId}" >
                                            <script type="text/javascript">
                                                                       var inhdn=document.createElement("input");
                                                                       inhdn.setAttribute("type","checkbox");
                                                                       inhdn.setAttribute("id",'clfs<c:out value="${clfId}"/>');
                                                                       inhdn.setAttribute("value",'<c:out value="${clfId}"/>');
                                                                       inhdn.setAttribute("name","clfs");
                                                                       inhdn.setAttribute("checked","false");
                                                                       document.getElementById("clfschk").appendChild(inhdn);
                                                                   </script>
                                                <td style="width:26px;"> <input name="clfs" type="checkbox"  onclick="reCheckTheAll(this,'allClfs','clfs')" value="<c:out value="${clfId}"/>"
                                                                                <c:choose> <c:when test="${clfsSelected != null }"> <c:forEach items="${clfsSelected}" var="selectedClf"> <c:if test="${clfId == selectedClf }"> checked="true" </c:if> </c:forEach> </c:when>
                                                                                    <c:otherwise> checked="true" </c:otherwise>
                                                               </c:choose> >
                                                    <c:choose>  <c:when test="${clfsSelected != null }"> <c:forEach items="${clfsSelected}" var="selectedClf"> <c:if test="${clfId == selectedClf }">
                                                                    <script> document.getElementById('clfs<c:out value="${clfId}"/>').setAttribute("checked","true"); </script>
                                                                </c:if>  </c:forEach> </c:when>
                                                        <c:otherwise> <script> document.getElementById('clfs<c:out value="${clfId}"/>').setAttribute("checked","true"); </script> </c:otherwise>
                                                               </c:choose>
                                                    </td>
                                                <td style="padding-left:4px;width:170px;"><c:out value="${cat.name}"  escapeXml="false"/></td>
                                                <c:set var="clfCount" value="${clfCount+1}"/>
                                                <c:if test="${clfCount==3}">
                                                </tr>
                                                <tr>
                                                    <c:set var="clfCount" value="0"/>
                                                </c:if>
                                            </c:if>
                                        </c:forEach>
                                    </c:forEach>
                                                </tr>
                                </table>
                            </c:if>
                        </c:if>
                    </div>
                </div>
                </div>
            </c:if>
                <c:if test="${clfId != null }">
                <script type="text/javascript">
                                                                       var inhdn=document.createElement("input");
                                                                       inhdn.setAttribute("type","checkbox");
                                                                       inhdn.setAttribute("id",'clfs<c:out value="${clfId}"/>');
                                                                       inhdn.setAttribute("value",'<c:out value="${clfId}"/>');
                                                                       inhdn.setAttribute("name","clfs");
                                                                       inhdn.setAttribute("checked","true");
                                                                       document.getElementById("clfschk").appendChild(inhdn);
                                                                   </script>
                </c:if>

 <div class="refine_search_bot"><a onclick="return isEligibleToRefine('lcs','clfs')"></a></div>
        </div>









                                                        <%--<tr>
                                                            <td align="left" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0" style="float:left; padding-left:10px; padding-top:8px;">
                                                                    <tr>
                                                                        <td width="55" align="left" valign="middle" class="advance_search_txt">Price :</td>
                                                                        <td width="97" align="left" valign="top"><input type="text" name="textfield"  class="advance_search_txt_input" /></td>
                                                                        <td width="76" align="center" valign="middle" class="advance_search_txt">To</td>
                                                                        <td  align="left" valign="top"><input type="text" name="textfield"  class="advance_search_txt_input" style="width:129px;" /></td>
                                                                        <td align="left" valign="top" class="advance_search_txt">(INR)</td>
                                                                        <td align="left" valign="top"><input type="checkbox" name="checkbox" id="checkbox" style="margin-top:5px;" /></td>
                                                                        <td align="left" valign="top" class="advance_search_txt">Only Photo Ads</td>
                                                                    </tr>
                                                                </table></td>
                                                        </tr>--%>
                                                       <%-- <tr>
                                                            <td align="left" valign="top">
                                                                <div class="refine_bot"><a href="#"></a></div>



                                                            </td>
                                                        </tr>--%>
                                                       </td></tr>
                                                    </table>

                                                </div>
                                            </div>
                                        </dd>
                                    </dl>
                                </div>

<%--<div id="RefineSearch" style="width:100%;float:left;">--%>
    <%--<form name="refnSrch" action="sRefine.do" method="post" >
         <input type="hidden" id="rfnKw" name="keyword"
        <% String keyword = (String) request.getAttribute("keyword");
            if (keyword != null) {%>
            value="<%= keyword%>"
        <% }%>/>
        <input type="hidden" id="rfnSc" name="subCatId"
               <% String subCatId = (String) request.getAttribute("subCatId");
            if (subCatId != null) {%>
         value="<%= subCatId%>"
        <% }%> />
        <input type="hidden" id="rfnAdt" name="adType" value="<c:out value="${adType}" />" >
        <input type="hidden" name="from" value="refine" />
        <!-- If it is directly form Refine search -->
        <div id="rfnTbls"  style="width:100%;float:left;padding:5px 0 0 5px;border-bottom:1px dashed #BFBFBF;">
            <span class="fv11bw" style="padding-left:25px;"> Select one or more options to refine the search :</span><br />
            <c:forEach items="${tilesList}" var="tile">
                <tiles:insert name="${tile}"/>
            </c:forEach>
        </div>
                        <div id="lcschk" style="display:none"></div>
                <div id="clfschk" style="display:none"></div>
            <input type="hidden" name="m" value="<c:out value="${m}" />">
    </form>--%>
        <%--    <div style="clear:both"></div>
        <div style="margin-top:10px;padding-left:25px;">
        <c:if test="${cityObj != null && cityObj.name != 'All India'}" >
            <a href="javascript:void(0);" onclick="return hsf.htmlExpand(this,{width:'700',headingText : 'Select One or More Localities'})" style="margin-right:30px;text-decoration:none"><input type="button" value="Refine By locality"  /></a>
            <div id="lclrf" class="highslide-maincontent">   <div style="width:98%;float:left;padding:5px 0 2px 0px;">     <span class="fv11"></span> <br />
                    <div style="margin-bottom:10px;width:100%;text-align:right;font-weight:bold;"><a onclick="return hsf.close(this);"><input type="button" value="Proceed"></a></div>
                    <div  style="height:auto;max-height:250px;overflow:auto;color:#222222;margin-top:4px;border:1px solid #fff;background-color:#FFFFFF;">
                        <c:if test="${cityObj != null }"> <c:if test="${cityObj.loc != null }">
                                <table border="0" cellpadding="0px" cellspacing="0px" style="padding-left:5%;width:650px;">
                                    <tr>
                                        <td> <input id="allLcs" type="checkbox"  value=""  onclick="checkAll(this,'lcs')" <c:if  test="${(localsSelected == null) || (localsSelected != null && (fn:length(localsSelected)) == (fn:length(cityObj.loc)))}" > checked </c:if> ></td>
                                        <td style="padding-left:4px;">All</td>
                                        <c:set var="locCount" value="1"/> <c:forEach items="${cityObj.loc}" var="local">
                                            <td>  <input name="lcs" type="checkbox"  onclick="reCheckTheAll(this,'allLcs','lcs')" value="<c:out value="${local.name}"/>"
                                                         <c:choose> <c:when test="${localsSelected != null }"> <c:forEach items="${localsSelected}" var="selectedLoc"> <c:if test="${local.name == selectedLoc }"> checked="true"  </c:if> </c:forEach> </c:when>
                                                             <c:otherwise> checked="true" </c:otherwise>
                                                       </c:choose> >
                                                <script type="text/javascript">
                                                    var inhdn=document.createElement("input");
                                                                       inhdn.setAttribute("type","checkbox");
                                                                       inhdn.setAttribute("id",'lcs<c:out value="${fn:replace(local.name,' ','')}"/>');
                                                                       inhdn.setAttribute("value",'<c:out value="${local.name}"/>');
                                                                       inhdn.setAttribute("name","lcs");
                                                                       inhdn.checked=false;
                                                   if(!document.getElementById('lcs<c:out value="${fn:replace(local.name,' ','')}"/>'))
                                                                       document.getElementById("lcschk").appendChild(inhdn);
                                                                   </script>
                                                    <c:choose>
                                                    <c:when test="${localsSelected != null }"> <c:forEach items="${localsSelected}" var="selectedLoc">
                                                            <c:if test="${local.name == selectedLoc }">  <script> document.getElementById('lcs<c:out value="${fn:replace(local.name,' ','')}"/>').checked=true; </script> </c:if>
                                                        </c:forEach>  </c:when>
                                                    <c:otherwise> <script> document.getElementById('lcs<c:out value="${fn:replace(local.name,' ','')}"/>').checked=true; </script> </c:otherwise>
                                                       </c:choose>
                                            </td>
                                            <td style="padding-left:4px;"><c:out value="${local.name}"/> </td>
                                        <c:set var="locCount" value="${locCount+1}"/>
                                        <c:if test="${locCount==3}">
                                        </tr>
                                            <tr> <c:set var="locCount" value="0"/>
                                        </c:if>
                                    </c:forEach>
                                            </tr>
                                </table>
                            </c:if>
                        </c:if>
                    </div>
                </div>
        </div>
            </c:if>
            <c:if test="${subCatId != null && subCatId != '0' }">
            <a href="javascript:void(0);" onclick="return hsf.htmlExpand(this,{width:'700',headingText : 'Select One or More Classifications'})" style="margin-right:30px;text-decoration:none"><input type="button" value="Refine By Classification"></a>
            <div id="clfrf" class="highslide-maincontent"> <div style="width:98%;float:left;padding:5px 0 2px 0px;"> <span class="fv11"></span> <br />
                    <div style="margin-bottom:10px;width:100%;text-align:right;font-weight:bold;"><a onclick="return hsf.close(this);"><input type="button" value="Proceed" /></a></div>
                    <div  style="height:auto;max-height:250px;overflow:auto;color:#222222;margin-top:4px;border:1px solid #fff;background-color:#FFFFFF;">
                        <c:if test="${clfIds != null }">  <c:if test="${categoryList != null}" >
                                <table border="0" cellpadding="0px" cellspacing="0px" style="padding-left:5%;width:650px;">
                                    <tr>
                                        <td style="width:26px;"> <input id="allClfs" type="checkbox"  value="" onclick="checkAll(this,'clfs')" <c:if  test="${(clfsSelected == null)||(clfsSelected != null && (fn:length(clfsSelected)) == (fn:length(clfIds))) }" > checked </c:if> ></td>
                                        <td style="padding-left:4px;width:170px;">All</td>
                                        <c:set var="clfCount" value="1"/> <c:forEach items="${clfIds}" var="clfId"> <c:forEach items="${categoryList}" var="cat"> <c:if test="${cat.id == clfId}" >
                                            <script type="text/javascript">
                                                                       var inhdn=document.createElement("input");
                                                                       inhdn.setAttribute("type","checkbox");
                                                                       inhdn.setAttribute("id",'clfs<c:out value="${clfId}"/>');
                                                                       inhdn.setAttribute("value",'<c:out value="${clfId}"/>');
                                                                       inhdn.setAttribute("name","clfs");
                                                                       inhdn.setAttribute("checked","false");
                                                                       document.getElementById("clfschk").appendChild(inhdn);
                                                                   </script>
                                                <td style="width:26px;"> <input name="clfs" type="checkbox"  onclick="reCheckTheAll(this,'allClfs','clfs')" value="<c:out value="${clfId}"/>"
                                                                                <c:choose> <c:when test="${clfsSelected != null }"> <c:forEach items="${clfsSelected}" var="selectedClf"> <c:if test="${clfId == selectedClf }"> checked="true" </c:if> </c:forEach> </c:when>
                                                                                    <c:otherwise> checked="true" </c:otherwise>
                                                               </c:choose> >
                                                    <c:choose>  <c:when test="${clfsSelected != null }"> <c:forEach items="${clfsSelected}" var="selectedClf"> <c:if test="${clfId == selectedClf }">
                                                                    <script> document.getElementById('clfs<c:out value="${clfId}"/>').setAttribute("checked","true"); </script>
                                                                </c:if>  </c:forEach> </c:when>
                                                        <c:otherwise> <script> document.getElementById('clfs<c:out value="${clfId}"/>').setAttribute("checked","true"); </script> </c:otherwise>
                                                               </c:choose>
                                                    </td>
                                                <td style="padding-left:4px;width:170px;"><c:out value="${cat.name}"  escapeXml="false"/></td>
                                                <c:set var="clfCount" value="${clfCount+1}"/>
                                                <c:if test="${clfCount==3}">
                                                </tr>
                                                <tr>
                                                    <c:set var="clfCount" value="0"/>
                                                </c:if>
                                            </c:if>
                                        </c:forEach>
                                    </c:forEach>
                                                </tr>
                                </table>
                            </c:if>
                        </c:if>
                    </div>
                </div>
                </div>
            </c:if>
                <c:if test="${clfId != null }">
                <script type="text/javascript">
                                                                       var inhdn=document.createElement("input");
                                                                       inhdn.setAttribute("type","checkbox");
                                                                       inhdn.setAttribute("id",'clfs<c:out value="${clfId}"/>');
                                                                       inhdn.setAttribute("value",'<c:out value="${clfId}"/>');
                                                                       inhdn.setAttribute("name","clfs");
                                                                       inhdn.setAttribute("checked","true");
                                                                       document.getElementById("clfschk").appendChild(inhdn);
                                                                   </script>
                </c:if>
  <input type="image" onclick="return isEligibleToRefine('lcs','clfs')"  onmouseout="this.src='bbsimages/buttons/RefineSearch.png'" onmouseover="this.src='bbsimages/buttons/RefineSearch_MouseOver.png'" src="bbsimages/buttons/RefineSearch.png" style="vertical-align:bottom;" />
        </div>--%>
        <!-- this is used to display the left menu as per prev menu-->
    <c:if test="${cityObj != null && cityObj.name != 'All India'}" > </c:if>
    <c:if test="${subCatId != null && subCatId != '0' }"> </c:if>
        <%--</div>--%>
        <script type="text/javascript">
            function setInWdths() {
                var rt=document.getElementById("rfnTbls");
                var rtt = rt.getElementsByTagName("table");
                for(var i=0;i<(rtt.length-1);i++) {
                    var rttin = rtt[i].getElementsByTagName("input");
                    for(var j=0;j<rttin.length;j++) {
                        rttin[j].style.width="100px";
                    }
                }
            }
            //setInWdths();
           /* if(document.location.href.indexOf("/bs/")>-1||document.location.href.indexOf("latestAds.do")>-1) {
                document.getElementById("RefineSearch").style.display="none";
            } else {
                document.getElementById("bSearchGo").style.display="none";
        document.basicSearch.setAttribute("action","sRefine.do");
            }*/
        </script>