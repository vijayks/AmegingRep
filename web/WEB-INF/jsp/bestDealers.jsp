<%--
    Document   : BestDealers
    Created on : Mar 4, 2009, 8:15:41 PM
    Author     : bbsadmin
--%>
<%-- <%@ taglib uri="/WEB-INF/pagination.tld" prefix="pagination-tag"%> --%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page  import="com.buysell.beans.AdsResultsBean " %>
<%@page  import="java.io.OutputStream " %>
<%@page  import="java.io.FileInputStream " %>
<%@page import="com.buysell.beans.UserBean" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<script type="text/javascript" src="js/dealerAjax.js"></script>
<% UserBean ub = (UserBean) request.getSession().getAttribute("userBean");%>
<script type="text/javascript" language="javascript">

    var R=0;
    var S=0;
    var qcheck=true;
    function sendReq()
    {
        oFormObject = document.forms[1];
        oFormObject.submit();
    }
    function openAlertWindow(url){
        window.open(url,"SaveAlert",'width=400,height=200,resizable=no,menubar=no,status=no,location=no,toolbar=no,scrollbars=no,screenX=500,screenY=400');
    }
    function adsPerPage(itemId)
    {
        var dropdownIndex = document.getElementById(itemId).selectedIndex;
        var dropdownValue = document.getElementById(itemId)[dropdownIndex].value;
        document.location.href=dropdownValue;
    }
    /* this function used for quick registration validation */
    function validateqr(lid,name,city,ph,code,divID)
    {
        var chk=true;
        var result=checkMobileNum(ph,divID);
        if(result == true)
        {
            document.getElementById("table"+divID).style.display="none";
            document.getElementById("img"+divID).style.display="inline";
            var res=quickRegAjax(lid,name,city,ph,code,divID);
            if(res == true)
                chk=true;
            else
                chk=false;
        }else
        {
            document.getElementById("conf"+divID).innerHTML="";
            document.getElementById("conf"+divID).innerHTML="Invalid Data";
            document.getElementById("table"+divID).style.display="inline";
            document.getElementById("img"+divID).style.display="none";
            chk=false;
        }
        return chk;
    }

    function sortBy(itemId)
    {
        var dropdownIndex = document.getElementById(itemId).selectedIndex;
        var dropdownValue = document.getElementById(itemId)[dropdownIndex].value;
        document.location.href=dropdownValue;
    }

</script>

<c:if test='${userBean != null}' >
    <script type="text/javascript">
        R=1;
        <c:if test="${userBean.evStatus == 'V' }" >
            EV=1;
        </c:if>
    </script>
</c:if>

<c:if test='${saveThisSearch != null}' >
    <script type="text/javascript">
        S=1;
    </script>
</c:if>

<script  language="javascript">
    var smsWL =new Array();
    var emailWL=new Array();
    var saveWL=new Array();
    var saveAL=new Array();
    var smsAL=new Array();
    var emailAL=new Array();

    // var eu=new Array();
    var nu=new Array();
    var fp=new Array();
    var count=0;



    function closeAllOtherDivs(itemId)
    {

        closeAllOtherDivsNoParam();
        // to erase prev o/p
        document.getElementById("msg"+itemId+"wl").innerHTML="";
        document.getElementById("msg"+itemId+"al").innerHTML="";

    }

    function closeAllOtherDivsNoParam()
    {

        for(var i=0;i<saveWL.length;i++)
        {
            toggle_close_it(saveWL[i]) ;
            toggle_close_it(saveAL[i]) ;
            toggle_close_it(smsWL[i]) ;
            toggle_close_it(smsAL[i]) ;
            toggle_close_it(emailWL[i]) ;
            toggle_close_it(emailAL[i]) ;

            toggle_close_it(nu[i]) ;
            toggle_close_it(fp[i]) ;
        }

        if(S==1)
        {
            toggle_close_it("alertal") ;
            toggle_close_it("alertwl") ;
            toggle_close_it("searchal") ;
            toggle_close_it("searchwl") ;
        }

    }

    function displayALForm(itemId)
    {
        toggle_open_it(itemId+"al");
        toggle_open_it('form'+itemId+"al");//make inline which was individually make none
        // document.getElementById(itemId+"al").focus();
    }

    function displayWLForm(itemId)
    {
        toggle_open_it(itemId+"wl");
        toggle_open_it('form'+itemId+"wl");//make inline which was individually make none
        //  document.getElementById(itemId+"wl").focus();
    }

    function showingLoading(itemId)
    {
        document.getElementById("msg"+itemId).innerHTML="";// erase prev o/p
        toggle_close_it("form"+itemId);//make none to show process
        toggle_open_it("load"+itemId); // display loading img

    }

    function toggle_search_it(itemId)
    {


        document.getElementById('qrSaveSearch').style.display = 'none';

        document.getElementById('fpss').style.display = 'none';
        closeAllOtherDivs(itemId);

        if(R == 0)
        {
            displayWLForm(itemId);
        }
        else
        {
            displayALForm(itemId);
        }

    }

    function toggle_alert_it(itemId)
    {

        document.getElementById('qrSaveAlert').style.display = 'none';
        document.getElementById('fpsa').style.display = 'none';
        closeAllOtherDivs(itemId);


        if(R == 0)
        {
            displayWLForm(itemId);
        }
        else
        {
            displayALForm(itemId);
        }

    }
    function toggle_save_it(itemId)
    {
        //if ((document.getElementById(itemId).style.display == 'none'))

        closeAllOtherDivs(itemId);

        if(R == 0)
        {
            displayWLForm(itemId);
        }
        else
        {
            displayALForm(itemId);
        }

    }
    function toggle_sms_it(itemId){

        closeAllOtherDivs(itemId);

        if(R == 0)
        {
            displayWLForm(itemId);
        }
        else
        {
            displayALForm(itemId);
        }

        return false;
    }
    function toggle_email_it(itemId){

        closeAllOtherDivs(itemId);
        if(R == 0)
        {
            displayWLForm(itemId);
        }
        else
        {
            displayALForm(itemId);

        }

        return false;
    }
    /*This function used for qucickregistration div display*/
    function toggle_qr(itemId,purpose,mb,adt)
    {
        closeAllOtherDivsNoParam();

        toggle_open_it(itemId);


        var element1 = document.createElement("input");
        //Assign different attributes to the element.

        element1.setAttribute("id",itemId+purpose);

        element1.setAttribute("type", "hidden");

        element1.setAttribute("value", purpose);

        element1.setAttribute("name", itemId+'purpose');

        var foo = document.getElementById("form"+itemId);
        foo.appendChild(element1);


        var element2 = document.createElement("input");
        element2.setAttribute("type","hidden");
        element2.setAttribute("name","advtMobile");
        element2.setAttribute("value",mb);
        element2.setAttribute("type","hidden");
        var foo1=document.getElementById("form"+itemId);
        foo1.appendChild(element2);

        var element3 = document.createElement("input");
        element3.setAttribute("type","hidden");
        element3.setAttribute("name","adTitle");
        element3.setAttribute("value",adt);
        element3.setAttribute("type","hidden");
        var foo2=document.getElementById("form"+itemId);
        foo2.appendChild(element3);
        return false;
    }
    function toggle_fp(itemId)
    {

        closeAllOtherDivsNoParam();
        toggle_open_it(itemId);
        return false;
    }

    function sendPassword(itemId)

    {

        var ddid="em"+itemId;
        var imgid="img"+itemId;
        var fpfp="fp"+itemId;
        var year="y"+itemId;

        if(document.getElementById(ddid).value != null && document.getElementById(ddid).value != ""
            && document.getElementById(year).value != null && document.getElementById(year).value != null )
        {

            document.getElementById(fpfp).style.display = 'none';
            document.getElementById(imgid).style.display = 'inline';
            var qrstr=document.getElementById(ddid).value.toString()+"&mobile="+document.getElementById(year).value.toString();
            FpAjaxFun(qrstr,itemId);
        }
        else
        {
            alert("Please enter user Id");
            return false;
        }
    }

    function SaveToMobileDlrWL(itemId,dlId,dName,dCity,dLocality,mobile)
    {

        showingLoading(itemId);
        var qrystr="dlId="+dlId+"&loginName="+document.getElementById("l"+itemId).value+"&pwd="+document.getElementById("p"+itemId).value+"&domainName="+dName+"&city="+dCity+"&locality="+dLocality+"&mobile="+mobile;
       SaveToMobileDlrAjaxFun(itemId,qrystr);
    }
    function SaveToMobileDlrAL(itemId,dlId,dName,dCity,dLocality,mobile)
    {
        showingLoading(itemId);
        var qrystr="dlId="+dlId+"&domainName="+dName+"&city="+dCity+"&locality="+dLocality+"&mobile="+mobile;
        SaveToMobileDlrAjaxFun(itemId,qrystr);
    }
    function sendToFriendDlrAL(itemId,dlId,dName,catId)
    {
        showingLoading(itemId);
        var qrystr="dlId="+dlId+"&fName="+document.getElementById("fn"+itemId).value+"&fEmail="+document.getElementById("fe"+itemId).value+"&domainName="+dName+"&catId="+catId;
        sendToFriendDlrAjaxFun(itemId,qrystr);
    }
    function sendToFriendDlrWL(itemId,dlId,dName,catId)
    {
        showingLoading(itemId);
        var qrystr="dlId="+dlId+"&loginName="+document.getElementById("l"+itemId).value+"&pwd="+document.getElementById("p"+itemId).value+"&fName="+document.getElementById("fn"+itemId).value+"&fEmail="+document.getElementById("fe"+itemId).value+"&domainName="+dName+"&catId="+catId;
        sendToFriendDlrAjaxFun(itemId,qrystr);
    }
    function contactDlrAL(itemId,dlId,dName,mobile,subCatId)
    {
        showingLoading(itemId);
        var qrystr="dlId="+dlId+"&mobile="+mobile+"&domainName="+dName+"&subCatId="+subCatId;
        contactDlrAjaxFun(itemId,qrystr);
    }
    function contactDlrWL(itemId,dlId,dName,mobile,subCatId)
    {
        showingLoading(itemId);
        var qrystr="dlId="+dlId+"&loginName="+document.getElementById("l"+itemId).value+"&pwd="+document.getElementById("p"+itemId).value+"&mobile="+mobile+"&domainName="+dName+"&subCatId="+subCatId;
        contactDlrAjaxFun(itemId,qrystr);
    }

    function saveSearchAL(itemId)
    {

        showingLoading(itemId);
        var qrystr="keyword="+'<c:out value="${keyword}" />'+"&subCatId="+'<c:out value="${subCatId}" />'+"&searchUrl="+'<c:out value="${saveThisSearch}" />';
       saveSearchAjaxFun(itemId,qrystr);
    }
    function saveSearchWL(itemId)
    {
        showingLoading(itemId);
        var qrystr="loginName="+document.getElementById("l"+itemId).value+"&pwd="+document.getElementById("p"+itemId).value+"&keyword="+'<c:out value="${keyword}" />'+"&subCatId="+'<c:out value="${subCatId}" />'+"&searchUrl="+'<c:out value="${saveThisSearch}" />';
       saveSearchAjaxFun(itemId,qrystr);
    }
    function saveAlertAL(itemId)
    {
        showingLoading(itemId);
        var qrystr="day1="+document.getElementById("d1"+itemId).value+"&month1="+document.getElementById("m1"+itemId).value+"&year1="+document.getElementById("y1"+itemId).value+"&day2="+document.getElementById("d2"+itemId).value+"&month2="+document.getElementById("m2"+itemId).value+"&year2="+document.getElementById("y2"+itemId).value+"&keyword="+'<c:out value="${keyword}" />'+"&subCatId="+'<c:out value="${subCatId}" />';
        saveAlertAjaxFun(itemId,qrystr);
    }

    function saveAlertWL(itemId)
    {
        showingLoading(itemId);
        var qrystr="loginName="+document.getElementById("l"+itemId).value+"&pwd="+document.getElementById("p"+itemId).value+"&day1="+document.getElementById("d1"+itemId).value+"&month1="+document.getElementById("m1"+itemId).value+"&year1="+document.getElementById("y1"+itemId).value+"&day2="+document.getElementById("d2"+itemId).value+"&month2="+document.getElementById("m2"+itemId).value+"&year2="+document.getElementById("y2"+itemId).value+"&keyword="+'<c:out value="${keyword}" />'+"&subCatId="+'<c:out value="${subCatId}" />';
       saveAlertAjaxFun(itemId,qrystr);
    }
   function toggle_close_it(itemId)
    {
        document.getElementById(itemId).style.display='none';
        return false;
    }
    function toggle_open_it(itemId)
    {
       document.getElementById(itemId).style.display='inline';
        return false;
    }
    var count=0;
    function changeVrificationCodeQr(imgId)
    {
        count++;
        document.getElementById(imgId).src='rig?1='+count;
    }
       function validateQuickRegFormLA(qrform)
                    {
                        var firstName=qrform.firstName.value;
                        var city=qrform.city.value;
                        var mobile=qrform.mobile.value;
                        var iagree=qrform.iagree.checked;
                        var chk=false;

                        var mobileRegex= /^([98]{1})([0123456789]{1})([0-9]{8})$/;

                        if(firstName =="")
                        {
                            alert("Enter your name");
                            chk=false;

                        }else if(city == "")
                        {
                            alert("Please select city");
                            chk=false;
                        }
                        else if(mobile == "") {
                            alert('You must enter your phone number.');
                            chk=false;
                        }
                        else if(!mobile.match(mobileRegex)) {
                            alert('You have entered an invalid phone number.');
                            chk=false;
                        }else if(!iagree)
                        {
                            alert("please accept the terms and conditions ");
                            chk=false;
                        }else
                        {
                            chk=true;
                        }

                        return chk;
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

            if(chieldIdStatus.checked == false){

                document.getElementById(allId).checked=false;

            }else{

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
function getLoc() {
    document.getElementById('RefineSearch').style.display='inline';
    document.getElementById('rbl').style.visibility='hidden';
}
function closeLoc() {
    document.getElementById('RefineSearch').style.display='none';
    document.getElementById('rbl').style.visibility='visible';
}
function validRefineForm(rf) {
    var locationOk=0;

    var chieldsList = document.getElementsByName('lcs');
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

    if(locationOk == 0){
            alert(" Pease select atleast One Location ");
            return false;
        }
}
</script>
       <%@page import="com.buysell.util.BuySellProperties" %>
       <%
int start = 0;
int range = 20;
int totalNoOfAds = 0;
String reqURI = "dealers.do";
int byO = 1;
int top = Integer.parseInt(BuySellProperties.getProperty("top"));
int middle = Integer.parseInt(BuySellProperties.getProperty("middle"));
int bottom = Integer.parseInt(BuySellProperties.getProperty("bottom"));
int pages = 0;
        int perPage = 0;
        int pno0 = 0;
        int NOfpageNums=Integer.parseInt(BuySellProperties.getProperty("NOfpageNums"));
 try {

            start = Integer.parseInt(request.getParameter("start"));

        } catch (Exception e) {
            //e.printStackTrace();
        }
        try {

            range = Integer.parseInt(request.getParameter("range"));

        } catch (Exception e) {
            //e.printStackTrace();
        }
        try {

            byO = Integer.parseInt(request.getParameter("byO"));
        } catch (Exception e) {
            //e.printStackTrace();
        }

        if (request.getAttribute("reqURI") != null) {
            reqURI = (String) request.getAttribute("reqURI");
        }

        pno0 = ((start / range < NOfpageNums) ? 0 : ((start / range) - ((start / range) % NOfpageNums)));
        totalNoOfAds = (Integer) request.getAttribute("c");

        if (totalNoOfAds % range == 0) {
            pages = totalNoOfAds / range;
        } else {
            pages = (totalNoOfAds / range) + 1;
        }

        pno0 = ((start / range < NOfpageNums) ? 0 : ((start / range) - ((start / range) % NOfpageNums)));
        totalNoOfAds = (Integer) request.getAttribute("c");

        if (totalNoOfAds % range == 0) {
            pages = totalNoOfAds / range;
        } else {
            pages = (totalNoOfAds / range) + 1;
        }
%>
<div id="sortBar" style="width:730px;float:left;height:24px;padding-top:4px;background-color:#ddeeff;margin-bottom:8px;color:#05446b;">
            <div class="verdana_menu_head" style="float:left;text-align:left;width:300px;padding-left:15px;overflow:hidden;" ><% if (request.getAttribute("pageTitle") != null) {%> <%= request.getAttribute("pageTitle")%> <% } else {%> Requested Dealers List <% }%></div>

            <div class="fv11b" style="float:left;width:390px;text-align:right;padding-top:4px"><span style="padding-right:10px">(Total ${c})</span>
                    #Of Dealers :&nbsp;

        <select  style="height:15px;font-size:9px;" name="selectname1" id="selectRange1" onchange="javascript:adsPerPage('selectRange1')">

            <option value="<%= reqURI%>?byO=<%= byO%>&start=0&range=<%= top%>&<c:if test="${subCatId !=null }" >subCatId=<c:out value="${subCatId}" /></c:if>">10</option>
            <option value="<%= reqURI%>?byO=<%= byO%>&start=0&range=<%= middle%>&<c:if test="${subCatId !=null }" >subCatId=<c:out value="${subCatId}" /></c:if>" >20</option>
            <option value="<%= reqURI%>?byO=<%= byO%>&start=0&range=<%= bottom%>&<c:if test="${subCatId !=null }" >subCatId=<c:out value="${subCatId}" /></c:if>" >30</option>

        </select>
        </div>
        <script type="text/javascript">

            document.getElementById('selectRange1').value='<%= reqURI%>?byO=<%= byO%>&start=0&range=<%= range%>&<% if (request.getAttribute("subCatId") != null) {%>subCatId=<%= request.getAttribute("subCatId")%><% }%>';

        </script>
</div>
            <div style="width:738px;height:25px">
            <div id="locSearch" style="width:300px;float:left;">
                <c:if test="${cityObj != null && cityObj.name != 'All India'}">
                    <input type="button" id="rbl" value="Refine By Locality" onclick="getLoc();">
                </c:if>
                <c:if test="${cityObj != null && cityObj.name == 'All India'}">
                    <input type="button" value="Refine By Locality" onclick="getLoc();" disabled>
                </c:if>
            </div>
             <div id="pagenav" style="padding:0 0 7px 0;width:425px;float:left;height:12px;text-align:right;">

    <%  if ((start - range) >= 0) {
    %>
    <a title="Previous" href="<%= reqURI%>?byO=<%= byO%>&start=<%=  start - range%>&range=<%= range%><c:if test="${subCatId !=null }" >&subCatId=<c:out value="${ subCatId }" /></c:if>"><span>Previous</span></a>

    <% }
            for (int pno = pno0; pno < pages && perPage < NOfpageNums; pno++, perPage++) {
                if (start / range == pno) {%>
    <span style="background-color:#05446B;color:#ffffff;"> <%= (pno + 1)%> </span>
    <% } else {%>
    <a title="Results <%=(pno*range)+1%>-<%=(pno+1)*range%>"style="text-decoration:none" href="<%= reqURI%>?byO=<%= byO%>&start=<%= pno * range%>&range=<%=range%><c:if test="${subCatId !=null }" >&subCatId=<c:out value="${ subCatId }" /></c:if>" ><span  ><% out.println(pno + 1);
        }%></span></a>
    <% }%>
    <!-- <b class="fv11bc">&nbsp;...&nbsp;</b><span> <%= pages%></span>&nbsp; -->

    <% if (start / range < (pages - 1)) {%>
    <a title="Next" class="link11" href="<%= reqURI%>?byO=<%= byO%>&start=<%=  start + range%>&range=<%= range%><c:if test="${subCatId !=null }" >&subCatId=<c:out value="${ subCatId }" /></c:if>"><span>Next</span></a>
    <% }%>
</div>
            </div>
<div id="RefineSearch" class="boxBorder2y" style="width:738px;float:left;background-color:#aaaaaa;display:none;">
    <form action="dealers.do" method="post" onsubmit="return validRefineForm(this);">
        <input type="hidden" name="subCatId" value="${subCatId}">
    <c:if test="${cityObj != null && cityObj.name != 'All India'}" >
                <div style="width:24%;float:left;padding:5px 0 2px 7px">
                    <span class="fv11bw">Select One or More Localities:</span>
                    <br />
                    <div  style="height:100px;overflow:auto;color:#222222;margin-top:4px;border:1px solid #fff;background-color:#FFFFFF;">
                            <c:if test="${cityObj.loc != null }">
                                <table border="0" cellpadding="0px" cellspacing="0px">
                                    <tr>
                                        <td>
                                            <input id="allLcs" type="checkbox"  value=""  onclick="checkAll(this,'lcs')" <c:if  test="${(fn:length(localsSelected)) == (fn:length(cityObj.loc)) }" > checked </c:if> ></td>
                                        <td>All</td>
                                    </tr>


                                    <c:forEach items="${cityObj.loc}" var="local">
                                        <tr>
                                            <td>
                                                <input name="lcs" type="checkbox"  onclick="reCheckTheAll(this,'allLcs','lcs')" value="<c:out value="${local.name}"/>"
                                                       <c:if test="${localsSelected != null }">
                                                           <c:forEach items="${localsSelected}" var="selectedLoc">
                                                               <c:if test="${local.name == selectedLoc }">
                                                                   checked="true"
                                                               </c:if>
                                                           </c:forEach>
                                                       </c:if> >

                                            </td>
                                            <td><c:out value="${local.name}"/>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </table>
                            </c:if>
                    </div>
                </div>
            </c:if>
    <div style="padding-top:50px;padding-left:100px;float:left"><input type="submit" value="Refine"/></div>
    <div style="padding-top:50px;padding-left:50px;float:left"><input type="button" value="Cancel" onclick="closeLoc();"/></div>
    </form>
</div>
<logic:present name="bestDealersBean" >
    <bean:size id="size" name="bestDealersBean"/>

    <jsp:include page='/WEB-INF/jsp/saveSearch.jsp'/>
    <style>
        <!--
        .boxBorder4
        {
            height:90px;
            -moz-border-radius:0 0 5px 5px;
            -webkit-border-radius: 10px;
        }
        .ad:hover {
            background:#FFFFCC;
        }
        -->
    </style>

    <logic:equal name="size" value="0">
        <div class="fv11b" style="width:740px;height:15px;text-align:center;color:#EA052B;">No Dealers found under requested criteria.</div>
        <div style="width:740px;height:10px;"></div>
    </logic:equal>

    <logic:greaterThan name="size" value="0">

        <c:set var="i" value="0" /> <!-- this value  used forcommercial ads count -->
        <logic:iterate id="result"  name="bestDealersBean">
            <script language="javascript">
                smsWL[count]="sms"+<bean:write name="result" property="dlId" />+"wl";
                smsAL[count]="sms"+<bean:write name="result" property="dlId" />+"al";
                saveWL[count]="save"+<bean:write name="result" property="dlId" />+"wl";
                saveAL[count]="save"+<bean:write name="result" property="dlId" />+"al";
                emailWL[count]="email"+<bean:write name="result" property="dlId" />+"wl";
                emailAL[count]="email"+<bean:write name="result" property="dlId" />+"al";
                //eu[count]="eu"+;
                nu[count]="nu"+<bean:write name="result" property="dlId" />;
                //  sent[count]="sent"+;
                fp[count]="fp"+<bean:write name="result" property="dlId" />;
                count++;
            </script>
            <%--<div class="adt"><div class="adb"><div class="adl"><div class="adr"><div class="adbl"><div class="adbr"><div class="adtl"><div class="adtr">--%>
            <div class="ad"  style="height:75px;width:740px" >
                                                <div class="rb" style="float:left;width:45px;height:65px;padding-top:9px;border:none" align="center" >
                                                    <a title="Ad Image" class="imglink" style=""   >
                                                            <img <c:choose><c:when test="${result.dlrType==1}">src="bbsimages/platinum_icon_2.PNG"</c:when><c:when test="${result.dlrType==2}">src="bbsimages/Gold_icon_2.PNG"</c:when><c:otherwise>src="bbsimages/Silver_icon_2.PNG"</c:otherwise></c:choose> alt="BBS Dealer" width="33px" height="33px" style="border:none"  >
                                                    </a>
                                                </div>
                                                <div style="float:left;height:75px;width:570px;overflow:hidden">
                                                    <div class="fv12bc" style="text-align:left;float:left;padding-left:3px;width:475px;padding-top:9px;overflow:hidden">
                                                        <a title="More details for ${result.comp_name}" class="link" style="font-size:12px;color:#046DBE"  href="dealerMoreDetails.do?dlId=<bean:write name='result' property='dlId'  />"  >
                                                            <c:if test="${fn:length(result.comp_name) <= 50 }">
                                                                <c:out value="${result.comp_name}" /><span style="padding-left:10px">(${catName})</span>
                                                            </c:if>
                                                            <c:if test="${fn:length(result.comp_name) > 50 }">
                                                                <c:out value="${fn:substring(result.comp_name,0,45)}"  /><span style="padding-left:10px">(${catName})</span>
                                                            </c:if>
                                                        </a>
                                                    </div>
                                                    <%--<div class="fv11b" style="float:left;text-align:right;width:85px;padding-right:2px;padding-top:5px"><b>
                                                            <a title="More Details" class="link" style="font-size:11px;color:#222222"  href="dealerMoreDetails.do?dlId=<bean:write name='result' property='dlId'  />"  >More Details...</a>
                                                        </b></div>--%>
                                                    <div class="fv11" style="height:35px;width:564px;padding-right:3px;float:left;text-align:left;padding-left:3px;padding-top:6px;overflow:hidden">

                                                        <c:if test="${fn:length(result.description) <= 250 }" >
                                                            <c:out value="${result.description}" />
                                                        </c:if>
                                                        <c:if test="${fn:length(result.description) > 250 }" >
                                                            <c:out value="${fn:substring(result.description,0,250)}" />&nbsp;&nbsp;<a href="dealerMoreDetails.do?dlId=<bean:write name='result' property='dlId'  />"  ><span style="color:#046dbe">More...</span></a>
                                                        </c:if>
                                                    </div>

                                                </div>
                                                <div  style="float:left;width:105px;height:75px;border:none" align="right">
                                                    <c:set var="adimg"><bean:write name="result"  property="logoPath" /></c:set>
                                                        <c:if test='${adimg != "" && adimg != "null" }'>
                                                            <a title="Dealer Logo" href="dealersAllAds.do?Did=<bean:write name='result' property='dlId' />" target="_blank"><img src="resourceGetter?imf=<bean:write name="result"  property="logoPath" />"
                                                                 width="95px" height="60px" style="padding:10px 12px" border="0"/></a>
                                                        </c:if>
                                                        <c:if test='${adimg == "" || adimg == "null"}'>
                                                            <img src="bbsimages/noimage.png" width="95px" height="60px" style="padding:10px 12px" border="0"/>
                                                        </c:if>
                                                </div>
                                            </div><%--</div></div></div></div></div></div></div></div>--%>
            <div id="smsdiv" style="width:740px;height:25px;float:left;border-bottom:1px solid #4d9edf;"><!-- Sms Div -->
                <table  class="fv11" >
                    <tr>
                        <td style="width:45px;">&nbsp;</td>
                        <td style="width:355px;text-align:left;font-weight:normal" ><bean:write name="result" property="locality" /> - <bean:write name="result" property="city" /> </td>
                        <td style="width:25px;"><img src="bbsimages/blank.gif" class="latestAdSms mail" alt=""/></td>
                        <td style="width:100px;"><a title="Send to Friend" href="javascript:return false" style="color:teal;" onclick="toggle_email_it('email<bean:write name="result" property="dlId" />');event.returnValue=false;return false;"> Send To Friend</a></td>
                        <td style="width:25px;"><img src="bbsimages/blank.gif" class="latestAdSms save" alt=""/></td>
                        <td style="width:100px;"><a title="Save To Mobile" href="javascript:return false;" style="color:teal;" onclick="toggle_sms_it('save<bean:write name='result' property='dlId' />');event.returnValue=false;return false;">Save To Mobile</a></td>
                        <td style="width:25px;"><img src="bbsimages/blank.gif" class="latestAdSms sms" alt=""/></td>
                        <td style="width:50px;"> <a title="Contact" href='javascript:return false' style="color:teal;" onclick="toggle_save_it('sms<bean:write name="result" property="dlId" />');event.returnValue=false;return false;">Contact</a></td>
                    </tr>
                </table>
            </div>
            <div style="clear:both">
            </div>
        <%--    <!-- ********************************************************************************************************** -->
            <!--   SAVE AD BLOCK STARTS   -->
            <!-- ********************************************************************************************************** -->
--%>
            <!-- this works when user not logged in -->
            <div class="boxBorder4" id="save<bean:write name='result' property="dlId" />wl" style="width:737px;float:left;display:none">
                <div id="header" style="width:737px" >
                    <div style="float:left;width:60%;text-align:left;"><span style="font-family:Arial;font-size:10px;font-weight:bold;padding-left:3px">To save this details to Mobile</span>
                        <span style="font-family:Arial;font-size:10px;">&nbsp;(Please Login)</span>
                    </div>
                    <div style="float:left;width:35%;text-align:right;font-size:9px;font-family:Arial;"><a title="Click here to Register" href="javascript:return false;" onclick="toggle_qr('nu<bean:write name="result" property="dlId" />','save');event.returnValue=false;return false;">Register</a>&nbsp;|&nbsp;
                        <a title="Click to get back your Password"  href="javascript:return false;" onclick="toggle_fp('fp<bean:write name="result" property="dlId" />');event.returnValue=false;return false;">Forget Password</a></div>
                    <div style="float:left;width:5%;text-align:right;">
                        <input type="image" src="images/close.png" onclick="toggle_close_it('save<bean:write name="result" property="dlId" />wl')"/>
                    </div>
                </div>
                <div id="formsave<bean:write name='result' property="dlId" />wl" style="font-family:Arial;font-size:9px;padding: 1px auto;">
                    <br>
                    <table style="margin:0 auto;">
                        <tr>
                            <td  width="12%" style="text-align:center"> User Id</td>
                            <td> <input id="lsave<bean:write name='result' property="dlId" />wl" name="loginName" style="height:12px;font-size:9px;" type="text" size="35" /></td>
                            <td width="15%" style="text-align:center">Password</td>
                            <td><input id="psave<bean:write name='result' property="dlId" />wl" name="pwd" style="height:12px;font-size:9px;" type="password" size="35" /></td>
                            <td width="15%" style="text-align:right"><input type="image"  src="bbsimages/buttons/SendSMS.png" onmouseover="this.src='bbsimages/buttons/SaveAd_MouseOver.png'" onmouseout="this.src='bbsimages/buttons/SaveAd.png'" onclick="SaveToMobileDlrWL('save<bean:write name='result' property="dlId" />wl','<bean:write name="result" property="dlId" />','<bean:write name="result" property="comp_name" />','<bean:write name="result" property="city" />','<bean:write name="result" property="locality" />','<bean:write name="result" property="phone1" />')" /></td>
                        </tr>
                    </table>
                </div>
                            <div id="loadsave<bean:write name='result' property="dlId" />wl" style="width:auto;padding:2px 0 2px 350px;display:none"> <img src="images/loading.gif"  style="width:32px;height:32px"/><br></div>
                <span style="padding:0 0 0 150px" class="fv12bc" id="msgsave<bean:write name='result' property="dlId" />wl"> </span>

                <div style="width:737px;height:10px;float:left"></div>
            </div>

            <!-- this works when user already logged in -->
            <div class="boxBorder4" id="save<bean:write name='result' property="dlId" />al" style="width:737px;height:60px;padding:2px 0 10px 0;float:left;display:none">
                <div id="header" style="background-color:#CCC;width:737px" >
                    <div style="float:left;width:60%;text-align:left;">
                        <span style="font-family:Arial;font-size:10px;font-weight:bold;padding-left:3px"> To Save this details to Mobile</span>
                    </div>
                    <div style="float:left;width:35%;"></div>
                    <div style="float:left;width:5%;text-align:right">
                        <input type="image" src="images/close.png" onclick="toggle_close_it('save<bean:write name='result' property="dlId" />al')"/>
                    </div>
                </div>
                <div id="formsave<bean:write name='result' property="dlId" />al" style="font-family:Arial;font-size:9px;padding: 1px auto;">
                    <br />
                    <table style="margin:0 auto;">
                        <tr>
                            <td class="fv12bc"> This company Details will be sent to mobile by saving here
                                <input type="image"  src="bbsimages/buttons/SendSMS.png" onmouseover="this.src='bbsimages/buttons/SaveAd_MouseOver.png'" onmouseout="this.src='bbsimages/buttons/SaveAd.png'" onclick="SaveToMobileDlrAL('save<bean:write name="result" property="dlId" />al','dlId=<bean:write name="result" property="dlId" />','<bean:write name="result" property="comp_name" />','<bean:write name="result" property="city" />','<bean:write name="result" property="locality" />','<bean:write name="result" property="phone1" />')" />
                            </td>
                        </tr>
                    </table>

                </div>
                <div id="loadsave<bean:write name='result' property="dlId" />al" style="width:auto;padding:2px 0 2px 350px;display:none"> <img src="images/loading.gif"  style="height:32px;width:32px;"/><br></div>
                <span style="padding:0 0 0 150px" class="fv12bc" id="msgsave<bean:write name='result' property="dlId" />al"> </span>
            </div>
            <!-- ********************************************************************************************************** -->
            <!--   SAVE AD BLOCK END   -->
            <!-- ********************************************************************************************************** -->

            <!-- ********************************************************************************************************** -->
            <!-- this div for quick registration -->
            <!-- ********************************************************************************************************** -->

            <c:if test="${userBean == null}">
                <script>

                </script>
                <div class="boxBorder4" id="nu<bean:write name="result" property="dlId" />" style="width:737px;height:109px;float:left;display:none">
                    <div id="header" style="background-color:#CCC;width:737px" >
                        <div style="float:left;width:60%;text-align:left;">
                            <span style="font-family:Arial;font-size:10px;font-weight:bold;padding-left:3px">To Register</span>
                            <span style="font-family:Arial;font-size:10px;">&nbsp;(Please Enter the information)</span>
                        </div>
                        <div style="float:left;width:35%;text-align:right;font-size:9px;font-family:Arial;"><a title="Click to Register" href="javascript:return false;" onclick="toggle_qr('nu<bean:write name="result" property="dlId" />','smsadvt','${userBean.mobile}','<bean:write name="result" property="comp_name" />');event.returnValue=false;return false;">Register</a>&nbsp;|&nbsp;
                            <a title="Click to get Forgot password" href="javascript:return false;" onclick="toggle_fp('fp<bean:write name="result" property="dlId" />');event.returnValue=false;return false;">Forget Password</a></div>
                        <div style="float:left;width:5%;text-align:right;">
                            <input type="image" src="images/close.png" onclick="toggle_close_it('nu<bean:write name="result" property="dlId" />');" />
                        </div>
                    </div>
                    <br />
                    <form name="qrform" id="formnu<bean:write name='result' property='dlId' />" method="get" action="quickReg.do" onsubmit="return validateQuickRegFormLA(this)">
                        <input type="hidden" name="dlId" value="nu<bean:write name='result' property='dlId' />" />
                        <table id="tablenu<bean:write name='result' property='dlId' />" border="0" style="font-size:9px;margin:0 auto;margin-top:10px;_margin-top:-14px;" >
                            <tr>
                                <td width="">
                                    User Id
                                </td>
                                <td>
                                    <input style="height:12px;font-size:9px;width:120px" type="text" name="userName"
                                           id="l<bean:write name="result" property="dlId" />" onchange="checkUsName('l<bean:write name="result" property="dlId" />','nu<bean:write name="result" property="dlId" />')" />
                                </td>
                                <td width="">
                                    Your Name
                                </td>
                                <td width="">
                                    <input style="height:12px;font-size:9px;width:120px"  type="text" name="firstName" id="n<bean:write name="result" property="dlId" />" />
                                </td>
                                <td style="width:30px" align="right">
                                    City
                                </td>
                                <td>
                                    <select size="1"  id="ct<bean:write name="result" property="dlId" />" style="font-size:9px;width:122px;_width:125px;" name="city" >
                                        <option value="" selected="true" >select city</option>
                                        <c:if test="${cities  != null }">
                                            <c:forEach items="${cities}" var="con"><option value="<c:out value='${con.name}'/>"<c:if test='${city != null && city == con.name}' >selected='true'</c:if> ><c:out value="${con.name}"/></option></c:forEach>
                                        </c:if>
                                    </select>
                                </td>
                                <td align="right">
                                    Phone No
                                </td>
                                <td>
                                    <input style="height:12px;font-size:9px;width:120px" type="text" name="mobile" id="ph<bean:write name='result' property='dlId' />" />
                                </td>
                            </tr>
                            <tr>
                                <td>&nbsp;</td>
                                <td  style="width:130px;" align="center" valign="middle">
                                    <img alt="" id="verIdnu<bean:write name="result" property="dlId" />" src="rig" style="height:21px;width:100px"/>&nbsp;
                                    <a title="Change Verification Code" class="link11" href="javascript:return false;" onclick="changeVrificationCodeQr('verIdnu<bean:write name="result" property="dlId" />');event.returnValue=false;return false;"><img border="0" alt="verificationCode" src="bbsimages/referesh_button.jpg" style="height:24px;width:24px;"/></a>
                                </td>
                                <td>
                                    Enter&nbsp;Code
                                </td>
                                <td>
                                    <input id="vrCode<bean:write name="result" property="dlId" />" type="text" name="regCode" style="width:120px;font-size:9px;" onblur="qrCheckRegCode('vrCode<bean:write name="result" property="dlId" />','nu<bean:write name="result" property="dlId" />')">
                                </td>
                                <td align="right">
                                    <input type="checkbox" name="iagree" ></td>
                                <td><a title="Click to accept terms & condition" href="javascript:return false;" onclick="termsAndConditions('tc.do');event.returnValue=false;return false;" style="color:#046DBE">I agree Terms &amp; Conditions.</a></td>
                                <td></td>
                                <td width="">
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input type="image" id="butdnu<bean:write name="result" property="dlId" />"  src="bbsimages/buttons/RegisterSDis.png" disabled />
                                    <input type="image"  src="bbsimages/buttons/RegisterS.png" disabled onmouseover="this.src='bbsimages/buttons/RegisterS_MouseOver.png'" onmouseout="this.src='bbsimages/buttons/RegisterS.png'"
                                           id="butnu<bean:write name="result" property="dlId" />" style="display:none"      />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">&nbsp</td>
                                <td colspan="4" align="center"><span id="codeTestNonu<bean:write name="result" property="dlId" />" name="codeTestNo" style="color:red;font-size:10px;display:none" >Verfication doesn't matched</span></td>
                                <td colspan="2">&nbsp</td>
                            </tr>
                        </table>
                        <div class="fv12bc" style="text-align:center" id="msgnu<bean:write name="result" property="dlId" />"></div>
                        <div class="fv11b" style="text-align:center;" id="confnu<bean:write name='result' property='dlId' />" ></div>
                        <div id="imgnu<bean:write name="result" property="dlId" />" style="display:none;text-align:center">Loading...</div>
                    </form>
                </div>
            </c:if>

            <c:if test="${userBean != null}">
                <div class="boxBorder4" id="nu<bean:write name="result" property="dlId" />" style="width:737px;float:left;display:none"></div>
            </c:if>


            <!-- ********************************************************************************************************** -->
            <!-- this div for quick registration end -->
            <!-- ********************************************************************************************************** -->

            <!-- ********************************************************************************************************** -->
            <!-- this div for forget password -->
            <!-- ********************************************************************************************************** -->

            <c:if test="${userBean == null }" >
                <div class="boxBorder4" id="fp<bean:write name="result" property="dlId" />" style="width:737px;float:left;display:none">
                    <div id="header" style="background-color:#CCC;width:737px" >
                        <div style="float:left;width:60%;text-align:left;">
                            <span style="font-family:Arial;font-size:10px;font-weight:bold;padding-left:3px">To Reset Your Password</span>
                            <span style="font-family:Arial;font-size:10px;">&nbsp;(Please Enter the information)</span>
                        </div>
                        <div style="float:left;width:35%;text-align:right;font-size:9px;font-family:Arial;"><a title="Click to Register" href="javascript:return false;" onclick="toggle_qr('nu<bean:write name="result" property="dlId" />','smsadvt','${userBean.mobile}','<bean:write name="result" property="comp_name" />');event.returnValue=false;return false;">Register</a>&nbsp;|&nbsp;
                            <a title="Click to get forgot Password" href="javascript:return false;" onclick="toggle_fp('fp<bean:write name="result" property="dlId" />');event.returnValue=false;return false;">Forget Password</a></div>
                        <div style="float:left;width:5%;text-align:right;">
                            <input type="image" src="images/close.png" onclick="toggle_close_it('fp<bean:write name="result" property="dlId" />')"/>
                        </div>
                    </div>

                    <div id="fpfp<bean:write name="result" property="dlId" />" style="font-family:Arial;font-size:9px;margin:0 auto;">
                        <br><br/><br>
                        <table style="margin:0 auto;_margin-top:-12px;">
                            <tr><td>Enter Email Id</td><td>&nbsp;</td>
                                <td><input id="emfp<bean:write name="result" property="dlId" />" style="height:12px;font-size:9px;width:150px" type="text" /></td>
                                <td>&nbsp;&nbsp;</td><td>Enter Mobile Number</td><td>&nbsp;</td>
                                <td><input id="yfp<bean:write name="result" property="dlId" />" style="height:12px;font-size:9px;width:150px" type="text" /></td>
                                <td><span style="padding-left:20px">
                                        <input type="image"  src="bbsimages/buttons/ResetPasswordS.png" onmouseover="this.src='bbsimages/buttons/ResetPasswordS_MouseOver.png'" onmouseout="this.src='bbsimages/buttons/ResetPasswordS.png'"
                                               onclick="sendPassword('fp<bean:write name="result" property="dlId" />');event.returnValue=false;return false;"/>
                                    </span></td></tr></table>
                    </div>
                    <div id="imgfp<bean:write name='result' property="dlId" />" style="width:auto;padding:2px 0 2px 350px;display:none"> Loading... </div>
                    <span style="padding:0 0 0 150px" class="fv12bc" id="msgfp<bean:write name="result" property="dlId" />">
                    </span>
                    <div style="width:737px;height:5px;float:left"></div>
                </div>
            </c:if>
            <c:if test="${userBean != null }" >
                <div class="boxBorder4" id="fp<bean:write name='result' property='dlId' />" style="width:737px;float:left;display:none">
                </div>
            </c:if>
            <!-- ********************************************************************************************************** -->
            <!--End  div for forget password -->
            <!-- ********************************************************************************************************** -->

            <!-- #############################################################################################################
                                                     DIV FOR SMS TO ADVERTISER STARTS
                 #############################################################################################################-->

            <div id="sms<bean:write name="result" property="dlId" />wl" class="boxBorder4" style="width:737px;float:left;display:none">
                <div id="header" style="background-color:#CCC;width:737px" >
                    <div style="float:left;width:60%;text-align:left;">
                        <span style="font-family:Arial;font-size:10px;font-weight:bold;padding-left:3px">Contact Dealer</span>
                        <span style="font-family:Arial;font-size:10px;">&nbsp;(Please Enter the information)</span>
                    </div>
                    <div style="float:left;width:35%;text-align:right;font-size:9px;font-family:Arial;"><a title="Click to Register" href="javascript:return false;" onclick="toggle_qr('nu<bean:write name="result" property="dlId" />','smsadvt','${userBean.mobile}','<bean:write name="result" property="comp_name" />');event.returnValue=false;return false;">Register</a>&nbsp;|&nbsp;
                        <a title="Click here to get Password" href="javascript:return false;" onclick="toggle_fp('fp<bean:write name="result" property="dlId" />');event.returnValue=false;return false;">Forgot Password</a></div>
                    <div style="float:left;width:5%;text-align:right">
                        <input type="image" src="images/close.png" onclick="toggle_close_it('sms<bean:write name="result" property="dlId" />wl')"/>
                    </div>
                </div>
                <br>

                <div id="formsms<bean:write name='result' property="dlId" />wl" style="font-family:Arial;font-size:9px;padding:1px auto">

                    <table style="margin: 10px auto;_margin-top: -10px;">
                        <tr> <input type="hidden" id="msms<bean:write name='result' property="dlId" />wl" value="${userBean.mobile}" />
                        <input type="hidden" id="adtsms<bean:write name='result' property="dlId" />wl" value="<bean:write name='result' property="comp_name" />" />
                        <td  width="12%" style="text-align:left">User Id</td>
                        <td ><input style="height:12px;font-size:9px;" id="lsms<bean:write name='result' property="dlId" />wl" type="text" size="35"  /></td>

                        <td  width="12%" style="text-align:left">Password</td>
                        <td><input style="height:12px;font-size:9px;" id="psms<bean:write name='result' property="dlId" />wl" type="password" size="35"   /></td>
                        </tr>
                        <tr>
                            <td>Message</td>
                            <td colspan="3"><input style="height:12px;font-size:9px;width:405px;_width:415px" type="text" readonly value="Hi, I am insterested in your products, please contact me, I need more information." /></td>
                            <td> <input type="image" src="bbsimages/buttons/SendSMS.png" onmouseover="this.src='bbsimages/buttons/SendSMS_MouseOver.png'" onmouseout="this.src='bbsimages/buttons/SendSMS.png'" onclick="contactDlrWL('sms<bean:write name='result' property="dlId" />wl','<bean:write name='result' property="dlId" />','<bean:write name='result' property="comp_name" />','<bean:write name='result' property="mobile" />','${subCatId}')" /></td>
                        </tr>
                    </table>
                </div>
                <div id="loadsms<bean:write name='result' property="dlId" />wl" style="width:auto;padding:2px 0 2px 350px;display:none"> <img src="images/loading.gif" style="height:32px;width:32px;" /><br></div>
                <span style="padding:0 0 0 150px" class="fv12bc" id="msgsms<bean:write name='result' property="dlId" />wl"> </span>
            </div>
            <div id="sms<bean:write name='result' property='dlId' />al" class="boxBorder4" style="width:737px;height:60px;float:left;display:none;padding:2px 0 10px 0">
                <div id="header" style="background-color:#CCC;width:737px" >
                    <div style="float:left;width:60%;text-align:left;">
                        <span style="font-family:Arial;font-size:10px;font-weight:bold;padding-left:3px">Contact Dealer</span>

                    </div>
                    <div style="float:left;width:35%;text-align:right;font-size:9px;font-family:Arial;">
                    </div>
                    <div style="float:left;width:5%;text-align:right">
                        <input type="image" src="images/close.png" onclick="toggle_close_it('sms<bean:write name="result" property="dlId" />al')"/>
                    </div>
                </div>

                <div id="formsms<bean:write name='result' property="dlId" />al" style="font-family:Arial;font-size:9px;padding: 1px auto;">
                    <br /><input type="hidden" id="msms<bean:write name='result' property="dlId" />al" value="${userBean.mobile}" />
                    <input type="hidden" id="adtsms<bean:write name='result' property="dlId" />al" value="<bean:write name='result' property="comp_name" />" />
                    <table style="margin:0 auto;">
                        <tr>
                            <td><input type="text" size="92" style="height:12px;font-size:9px;" readonly value="Hi, I am insterested in your products, please contact me, I need more information."/></td>
                            <td><input type="image" src="bbsimages/buttons/SendSMS.png" onmouseover="this.src='bbsimages/buttons/SendSMS_MouseOver.png'" onmouseout="this.src='bbsimages/buttons/SendSMS.png'" onclick="contactDlrAL('sms<bean:write name='result' property="dlId" />al','<bean:write name='result' property="dlId" />','<bean:write name="result" property="comp_name" />','<bean:write name='result' property="mobile" />','${subCatId}')" /></td>

                        </tr>
                    </table>
                </div>

                <div id="loadsms<bean:write name='result' property="dlId" />al" style="width:auto;padding:2px 0 2px 350px;display:none"> <img src="images/loading.gif" alt="loading" style="height:32px;width:32px;"/><br></div>

                <span  style="padding:0 0 0 150px;" class="fv12bc" id="msgsms<bean:write name='result' property="dlId" />al"> </span>



            </div>

            <!-- #############################################################################################################
                                         DIV FOR SMS TO ADVERTISER ENDS
     #############################################################################################################-->



            <!-- #############################################################################################################
                                                     DIV FOR E-MAIL TO FRIEND  STARTS
                 #############################################################################################################-->

            <!-- email to  friend for without login  users -->

            <div class="boxBorder4" id="email<bean:write name='result' property='dlId' />wl"  style="width:737px;float:left;display:none;">

                <div id="header" style="background-color:#ffcc33;width:737px;" >
                    <div style="float:left;width:60%;text-align:left;"><span style="font-family:Arial;font-size:10px;font-weight:bold;padding-left:3px">To Email this details to Friend</span>

                        <span style="font-family:Arial;font-size:10px;">&nbsp;(Please Enter the information)</span>
                    </div>
                    <div style="float:left;width:35%;text-align:right;font-size:9px;font-family:Arial;"><a title="Click to Register" href="javascript:return false;" onclick="toggle_qr('nu<bean:write name="result" property="dlId" />','emailFriend');event.returnValue=false;return false; ">Register</a>&nbsp;|&nbsp;
                        <a title="Click to get Password" href="javascript:return false;" onclick="toggle_fp('fp<bean:write name="result" property="dlId" />');event.returnValue=false;return false;">Forget Password</a></div>

                    <div style="float:left;width:5%;text-align:right">
                        <input type="image" src="images/close.png" onclick="toggle_close_it('email<bean:write name="result" property="dlId" />wl')"/>
                    </div>
                </div>
                <br />
                <div id="formemail<bean:write name='result' property="dlId" />wl" style="font-family:Arial;font-size:9px;padding:1px auto">
                    <table style="margin: 10px auto;_margin-top: -10px;">

                        <tr>
                            <td  width="12%" style="text-align:left">Friend's Name </td>
                            <td><input style="height:12px;font-size:9px;" id="fnemail<bean:write name='result' property="dlId" />wl" type="text" size="35"   /> </td>
                            <td width="6%" > &nbsp;</td>
                            <td  width="12%" style="text-align:left">Friend's Email </td>
                            <td><input style="height:12px;font-size:9px;" id="feemail<bean:write name='result' property="dlId" />wl" type="text" size="35"   /> </td>
                            <td> &nbsp;</td>
                        </tr>

                        <tr>
                            <td  width="12%" style="text-align:left">User Id</td>
                            <td><input style="height:12px;font-size:9px;" id="lemail<bean:write name='result' property="dlId" />wl" type="text" size="35"  /></td>
                            <td width="6%" > &nbsp;</td>
                            <td  width="12%" style="text-align:left">Password</td>
                            <td><input style="height:12px;font-size:9px;_width:160px;" id="pemail<bean:write name='result' property="dlId" />wl" type="password" size="35"   /></td>
                            <td  width="15%" style="text-align:right"><input type="image" src="bbsimages/buttons/SendEmail.png" onmouseover="this.src='bbsimages/buttons/SendEmail_MouseOver.png'" onmouseout="this.src='bbsimages/buttons/SendEmail.png'"  onclick="sendToFriendDlrWL('email<bean:write name='result' property="dlId" />wl','<bean:write name='result' property="dlId" />','<bean:write name='result' property="comp_name" />','${subCatId}')" /></td>
                        </tr>
                    </table>
                </div>

                <div id="loademail<bean:write name='result' property="dlId" />wl" style="width:auto;padding:2px 0 2px 350px;display:none"> <img src="images/loading.gif" style="height:32px;width:32px;" /><br></div>

                <span style="padding:0 0 0 150px" class="fv12bc" id="msgemail<bean:write name='result' property="dlId" />wl"> </span>

            </div>

            <!-- email to  friend for logged in users  -->

            <div id="email<bean:write name="result" property="dlId" />al" class="boxBorder4" style="width:737px;height:60px;float:left;display:none;padding:2px 0 10px 0;">

                <div id="header" style="background-color:#ffcc33;width:737px" >
                    <div style="float:left;width:60%;text-align:left;">
                        <span style="font-family:Arial;font-size:10px;font-weight:bold;padding-left:3px">To Email this details to Friend</span> <span style="font-family:Arial;font-size:10px;">&nbsp;(Please Enter the information)</span>
                    </div>
                    <div style="float:left;width:35%;">
                    </div>
                    <div style="float:left;width:5%;text-align:right">
                        <input type="image" src="images/close.png" onclick="toggle_close_it('email<bean:write name="result" property="dlId" />al')"/>
                    </div>
                </div>
                <br />
                <div id="formemail<bean:write name='result' property="dlId" />al" style="font-family:Arial;font-size:9px;padding: 1px auto;">

                    <table style="margin:0 auto;font-size:9px; margin-top:00px;">
                        <tr>
                            <td  width="12%" style="text-align:left">Friend's Name </td>
                            <td><input style="height:12px;font-size:9px;" id="fnemail<bean:write name='result' property="dlId" />al" type="text" size="35" name="friendName"  /> </td>
                            <td width="6%" > &nbsp;</td>
                            <td  width="12%" style="text-align:left">Friend's Email </td>
                            <td><input style="height:12px;font-size:9px;" id="feemail<bean:write name='result' property="dlId" />al" type="text" size="35" name="friendEmail" /> </td>
                            <td  width="15%" style="text-align:right"><input type="image" src="bbsimages/buttons/SendEmail.png" onmouseover="this.src='bbsimages/buttons/SendEmail_MouseOver.png'" onmouseout="this.src='bbsimages/buttons/SendEmail.png'" onclick="sendToFriendDlrAL('email<bean:write name='result' property="dlId" />al','<bean:write name='result' property="dlId" />','<bean:write name='result' property="comp_name" />','${subCatId}')" /></td>
                        </tr>
                    </table>
                </div>
                            <div id="loademail<bean:write name='result' property="dlId" />al" style="width:auto;padding:2px 0 2px 350px;display:none"> <img src="images/loading.gif" style="height:32px;width:32px;" /><br></div>
                <span  style="padding:0 0 0 150px;" class="fv12bc" id="msgemail<bean:write name='result' property="dlId" />al"> </span></div>

            <!-- #############################################################################################################
                                         DIV FOR E-MAIL TO FRIEND  ENDS
     #############################################################################################################-->
            <!-- latestads part end here -->
            <div style="height:10px;width:100%;"></div>
            <!-- this part used to display commercial ads after every 5 ads -->
            <c:set var="i"  value="${i + 1}" />
            <c:if test='${i == 5}' >
                <%--<div><img src="bbsimages/home_img.gif" style="height:65px;width:740px"/></div><br />--%>
                <c:set var="i" value="0" />
            </c:if>
            <div style="clear:both">
            </div>
        </logic:iterate>
    </logic:greaterThan>
</logic:present>
