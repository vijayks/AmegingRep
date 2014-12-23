
<%-- Document   : DealerAllAds
 Created on : Dec 29, 2009, 1:20:03 PM
 Author     : bbsadmin
--%>

<%-- <%@ taglib uri="/WEB-INF/pagination.tld" prefix="pagination-tag"%> --%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page  import="com.buysell.beans.AdsBean " %>
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
<script type="text/javascript" src="js/allAjax.js"></script>
<script type="text/javascript" src="js/alljs.js"></script>
<style>
    <!--
    .boxBorder4
    {
        height:90px;
        -moz-border-radius:0 0 5px 5px;
        -webkit-border-radius: 10px;
    }
    -->
</style>

<link rel="StyleSheet" href="css/stylesheet.css" type="text/css">


<script type="text/javascript" src="highslide/highslide-with-html.js"></script>
<link rel="stylesheet" type="text/css" href="highslide/highslide.css" />
<script type="text/javascript">
    hs.graphicsDir = 'highslide/graphics/';
    hs.outlineType = 'rounded-white';
    hs.wrapperClassName = 'draggable-header';
</script>

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




    function openWindowAssign(url){

        alert(url);

        window.open(url,'mywindow','width=1000,height=1300,menubar=no,status=no,location=yes,toolbar=no,scrollbars=no,screenX=300,screenY=300');
    }

</script>


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
        alert(itemId);
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

        alert(itemId);

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

    function SaveAdWL(itemId,adId)
    {

        showingLoading(itemId);
        var qrystr="adId="+adId+"&loginName="+document.getElementById("l"+itemId).value+"&pwd="+document.getElementById("p"+itemId).value;
        SaveAdAjaxFun(itemId,qrystr);
    }
    function SaveAdAL(itemId,qrystr)
    {
        showingLoading(itemId);
        SaveAdAjaxFun(itemId,qrystr);
    }
    function sendToFriendAL(itemId,adId,title,catId)
    {
        showingLoading(itemId);
        var qrystr="adId="+adId+"&fName="+document.getElementById("fn"+itemId).value+"&fEmail="+document.getElementById("fe"+itemId).value+"&title="+title+"&catId="+catId;
        sendToFriendAjaxFun(itemId,qrystr);
    }
    function sendToFriendWL(itemId,adId,title,catId)
    {
        showingLoading(itemId);
        var qrystr="adId="+adId+"&loginName="+document.getElementById("l"+itemId).value+"&pwd="+document.getElementById("p"+itemId).value+"&fName="+document.getElementById("fn"+itemId).value+"&fEmail="+document.getElementById("fe"+itemId).value+"&title="+title+"&catId="+catId;
        sendToFriendAjaxFun(itemId,qrystr);
    }
    function smsAdvertiserAL(itemId,adId)
    {
        showingLoading(itemId);
        var qrystr="adId="+adId+"&mobile="+document.getElementById("m"+itemId).value+"&adTitle="+document.getElementById("adt"+itemId).value;
        smsAdvertiserAjaxFun(itemId,qrystr);
    }
    function smsAdvertiserWL(itemId,adId)
    {
        showingLoading(itemId);
        var qrystr="adId="+adId+"&loginName="+document.getElementById("l"+itemId).value+"&pwd="+document.getElementById("p"+itemId).value+"&mobile="+document.getElementById("m"+itemId).value+"&adTitle="+document.getElementById("adt"+itemId).value;
        smsAdvertiserAjaxFun(itemId,qrystr);
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

</script>



<%--<script type="text/javascript" src="js/alljs.js"></script>
<script type="text/javascript" src="js/tooltip.js"></script>
<script type="text/javascript" src="js/allAjax.js" ></script>--%>


<style>
    .headerLogo
    {
        background-color:#4D9EDF;
        height:70px;
        width:980px;
        font-size:small;
        font-family:Arial;
        color:#ffffff;
    }


    <!--
    .boxBorder5
    {
        -moz-border-radius:13px 13px 13px 13px;
        -webkit-border-radius: 10px;
    }
    -->

</style>
<style>

    <!--
    .boxBorder6
    {

        -moz-border-radius:5px 15px 15px 15px;
        -webkit-border-radius: 10px;
    }
    -->



</style>
<script type="text/javascript" src="highslide/highslide-with-html.js"></script>

<link rel="stylesheet" type="text/css" href="highslide/highslide.css" />
<script type="text/javascript">
    hs.graphicsDir = 'highslide/graphics/';
    hs.outlineType = 'rounded-white';
    hs.wrapperClassName = 'draggable-header';
</script>


<div style="width:1000px;background-color:#ffffff" >

    <div style="height:90px;width:1000px ">
        <c:if test="${dAdBean!=null}">

            <c:set var="db" value="${dAdBean}"/>

                <div class="headerLogo" style="width:970px">
                    <div style="float:left;padding-left:10px;padding-bottom:5px"><span><img src="resourceGetter?imf=${db.logoPath}"
                                                                width="75px" height="65px" style="border:none"  ></span></div>

                    <div style="float:left;width:530px;padding:20px;padding-bottom:40px"> ${db.description}</div>


                    <div class="boxBorder5" style="font-size:small;float:left;padding-bottom:5px;height:60px;width:200px;padding-left:20px">
                        <table style="color:#ffffff;font-family:arial">
                            <tr>
                                <td><span style="font-size:smaller;font-family:arial"><b>Address</b></span></td>
                                <td>:</td>
                                <td><span style="font-size:smaller"><b>${db.description}</b></span></td>

                            </tr>
                            <tr>
                                <td><span style="font-size:smaller"><b>Mobile</b></span></td>
                                <td>:</td>
                                <td><span style="font-size:smaller"><b>fghgfh</b></span></td>
                            </tr>
                            <tr>
                                <td><span style="font-size:smaller"><b>Landline</b></span></td>
                                <td>:</td>
                                <td><span style="font-size:x-small;width:50px"><b>ghffghfhfh</b></span></td>
                            </tr>

                        </table>
                    </div>
                </div>

        </c:if>
    </div>


    <div style="">

        <div style="width:210px;height:auto;float:left;background-color:#4D9EDF;margin-left:10px">
            <div id="menuheader" align="left" style="padding-top:2px;width:210px;margin-top:5px">&nbsp;
                <span class="verdana_menu_head"  > &nbsp;Offers by ${domainNM}  &nbsp; </span>
            </div> <br /><br />
            <script type="text/javascript">
                //specify path to your external page:

                var dealerId=document.getElementById("dId");
                var iframesrc="dealerScrolls.do?dId=${dId}";
                //You may change most attributes of iframe tag below, such as width and height:
                document.write('<iframe style="background-color:#4D9EDF" id="datamain" src="'+iframesrc+'" width="210px" height="220px" marginwidth="0" marginheight="0" hspace="0" vspace="0" frameborder="0" scrolling="no"></iframe>')
            </script>
        </div>
               <%--<c:out value="${fn:length(ab)}"/>--%>
        <c:if test="${fn:length(ab)==0}">

                    <div style="height:330px;width:750px;margin-left:10px">
                        <center><span style="color:red">  No Ads found for this Dealer !</span></center>
                    </div>
               </c:if>
        <div style="width:750px;float:left;margin-left:10px">

            <input type="hidden" name="dId" id="dId" value="${dId}">
            <c:if test="${ab!=null}">

                <c:set var="i" value="0" /> <!-- this value  used forcommercial ads count -->
                <c:forEach items="${ab}" var="ab">

                    <script language="javascript">
                        smsWL[count]="sms"+${ab.adId}+"wl";
                        smsAL[count]="sms"+${ab.adId}+"al";
                        saveWL[count]="save"+${ab.adId}+"wl";
                        saveAL[count]="save"+${ab.adId}+"al";
                        emailWL[count]="email"+${ab.adId}+"wl";
                        emailAL[count]="email"+${ab.adId}+"al";
                        //eu[count]="eu"+;
                        nu[count]="nu"+${ab.adId};
                        //  sent[count]="sent"+;
                        fp[count]="fp"+${ab.adId};
                        count++;
                    </script>


                    <div class="adt"><div class="adb"><div class="adl"><div class="adr"><div class="adbl"><div class="adbr"><div class="adtl"><div class="adtr">
                                                    <div  style="height:95px;width:740px" >
                                                        <div class="rb" style="float:left;width:85px;height:85px;padding-top:12px" align="center" >
                                                            <a class="imglink" style=""><img src="resourceGetter?imf=${ab.image1}" width="75px" height="75px" style="border:none" >

                                                                <%-- <img src="bbsimages/noimage.png" width="75px" height="75px" style="border:none"  >--%>
                                                            </a>
                                                        </div>
                                                        <div class="rb" style="float:left;height:95px;width:530px;overflow:hidden">
                                                            <div class="fv12bc" style="text-align:left;float:left;padding-left:3px;width:440px;padding-top:5px;overflow:hidden">
                                                                <a class="link" style="font-size:11px;color:#046DBE"  href="moreDetails.do?adId=${ab.adId}&catId=${ab.catId}#moredetail" onclick="return hs.htmlExpand(this, { objectType: 'ajax'} )">
                                                                    <c:if test="${fn:length(ab.title) <= 50 }">
                                                                        <c:out value="${ab.title}" />&nbsp;(${ab.parentCatName})
                                                                    </c:if>
                                                                    <c:if test="${fn:length(ab.title) > 50 }">
                                                                        <c:out value="${fn:substring(ab.title,0,45)}"  />&nbsp;(${ab.parentCatName})
                                                                    </c:if>
                                                                </a>
                                                            </div>
                                                            <div class="fv11b" style="float:left;text-align:right;width:85px;padding-right:2px;padding-top:5px"><b>
                                                                    <a class="link" style="font-size:11px;color:#222222"  href="moreDetails.do?adId=${ab.adId}&catId=${ab.catId}#moredetail" onclick="return hs.htmlExpand(this, { objectType: 'ajax'} )">More Details...</a>
                                                                </b></div>
                                                            <div class="fv11" style="height:55px;width:524px;padding-right:3px;float:left;text-align:left;padding-left:3px;padding-top:6px;overflow:hidden">
                                                                ${ab.description}
                                                            </div>
                                                            <div class="fv11" style="height:25px;padding-left:3px;float:left;width:227px;text-align:left;padding-bottom:5px">
                                                                <%--to
                                                                       <span class="fv11b" >Rs.</span>

                                                                <span class="fv11b">Rs.</span>



                                                            <span class="fv11bc" style="padding-right:2px">Contact for Price</span>--%>

                                                            </div>
                                                            <div class="fv11" style="height:25px;float:left;width:300px;text-align:right;padding-bottom:5px">Posted By
                                                                <span class="fv11bc"  > ${ab.firstName} </span>

                                                                on&nbsp;   <span class="fv11bc" style="padding-right:2px">${ab.postedDate}
                                                                </span>
                                                            </div>
                                                        </div>
                                                        <div  style="float:left;width:105px;height:95px;" align="right"><span style="height:25px;background-color:#6699ff;"></span>
                                                            <img src="bbsimages/images.jpg" alt=""  width="95px" height="60px" style="padding-left:12px;padding-top:19.5px;padding-bottom:15.5px" />
                                                        </div>
                                                    </div></div></div></div></div></div></div></div></div>
                                                    <%--</div>--%>
                    <div style="clear:left"></div>
                    <div id="smsdiv" style="width:740px;background-color:#4D9EDF;height:20px;"><!-- Sms Div -->
                        <table align="left" class="fv11" style="color:#FFFFFF;">
                            <tr style="vertical-align:top">
                                <td style="width:400px;font-weight:normal;" >  ${ab.locality} - ${ab.city}</td>
                                <td style="width:25px;"><img src="bbsimages/blank.gif" class="latestAdSms mail" style="vertical-align:top" alt=""/></td>
                                <td style="width:100px;"><a href="javascript:return false" style="color:#FFFFFF;" onclick="toggle_email_it('email${ab.adId}');event.returnValue=false;return false;"> Send To Friend</a></td>
                                <td style="width:25px;"><img src="bbsimages/blank.gif" class="latestAdSms sms" alt=""/></td>
                                <td style="width:100px;"><a href="javascript:return false;" style="color:#FFFFFF;" onclick="toggle_sms_it('sms${ab.adId}');event.returnValue=false;return false;">SMS Advertiser</a></td>
                                <td style="width:25px;"><img src="bbsimages/blank.gif" class="latestAdSms save" alt=""/></td>
                                <td style="width:50px;"> <a href='javascript:return false' style="color:#FFFFFF;" onclick="toggle_save_it('save${ab.adId}');event.returnValue=false;return false;">Save Ad</a></td>
                            </tr>
                        </table>
                    </div>
                    <div style="clear:both;height:5px">
                    </div>


                    <%--    <!-- ********************************************************************************************************** -->
                                <!--   SAVE AD BLOCK STARTS   -->
                                <!-- ********************************************************************************************************** -->
                    --%>
                    <!-- this works when user not logged in -->
                    <div class="boxBorder4" id="save${ab.adId}wl" style="width:737px;float:left;display:none">
                        <div id="header" style="width:737px" >
                            <div style="float:left;width:60%;text-align:left;"><span style="font-family:Arial;font-size:10px;font-weight:bold;padding-left:3px">To save this Ad</span>
                                <span style="font-family:Arial;font-size:10px;">&nbsp;(Please Login)</span>
                            </div>
                            <div style="float:left;width:35%;text-align:right;font-size:9px;font-family:Arial;"><a href="javascript:return false;" onclick="toggle_qr('nu${ab.adId}','save');event.returnValue=false;return false;">Register</a>&nbsp;|&nbsp;
                                <a href="javascript:return false;" onclick="toggle_fp('fp${ab.adId}');event.returnValue=false;return false;">Forgot Password</a></div>
                            <div style="float:left;width:5%;text-align:right;">
                                <input type="image" src="images/close.png" onclick="toggle_close_it('save${ab.adId}wl')"/>
                            </div>
                        </div>
                        <div id="formsave${ab.adId}wl" style="font-family:Arial;font-size:9px;padding: 1px auto;">
                            <br>
                            <table style="margin:0 auto;">
                                <tr>
                                    <td  width="12%" style="text-align:center"> User Id</td>
                                    <td> <input id="lsave${ab.adId}wl" name="loginName" style="height:12px;font-size:9px;" type="text" size="35" /></td>
                                    <td width="15%" style="text-align:center">Password</td>
                                    <td><input id="psave${ab.adId}wl" name="pwd" style="height:12px;font-size:9px;" type="password" size="35" /></td>
                                    <td width="15%" style="text-align:right"><input type="image"  src="bbsimages/buttons/SaveAd.png" onmouseover="this.src='bbsimages/buttons/SaveAd_MouseOver.png'" onmouseout="this.src='bbsimages/buttons/SaveAd.png'" onclick="SaveAdWL('save${ab.adId}wl',${ab.adId})" /></td>
                                </tr>
                            </table>
                        </div>
                        <div id="loadsave${ab.adId}wl" style="width:auto;padding:2px 0 2px 350px;display:none"> <img src="images/loading.gif"  style="width:32px;height:32px"/><br></div>
                        <span style="padding:0 0 0 150px" class="fv12bc" id="msgsave${ab.adId}wl"> </span>

                        <div style="width:737px;height:10px;float:left"></div>
                    </div>

                    <!-- this works when user already logged in -->
                    <div class="boxBorder4" id="save${ab.adId}al" style="width:737px;height:60px;padding:2px 0 10px 0;float:left;display:none">
                        <div id="header" style="background-color:#CCC;width:737px" >
                            <div style="float:left;width:60%;text-align:left;">
                                <span style="font-family:Arial;font-size:10px;font-weight:bold;padding-left:3px"> To Save the Ad</span>
                            </div>
                            <div style="float:left;width:35%;"></div>
                            <div style="float:left;width:5%;text-align:right">
                                <input type="image" src="images/close.png" onclick="toggle_close_it('save${ab.adId}al')"/>
                            </div>
                        </div>
                        <div id="formsave${ab.adId}al" style="font-family:Arial;font-size:9px;padding: 1px auto;">
                            <br />
                            <table style="margin:0 auto;">
                                <tr>
                                    <td class="fv12bc"> This ad will be saved in "myAccount" by saving here
                                        <input type="image"  src="bbsimages/buttons/SaveAd.png" onmouseover="this.src='bbsimages/buttons/SaveAd_MouseOver.png'" onmouseout="this.src='bbsimages/buttons/SaveAd.png'" onclick="SaveAdAL('save${ab.adId}al','adId=${ab.adId}')" />
                                    </td>
                                </tr>
                            </table>

                        </div>
                        <div id="loadsave${ab.adId}al" style="width:auto;padding:2px 0 2px 350px;display:none"> <img src="images/loading.gif"  style="height:32px;width:32px;"/><br></div>
                        <span style="padding:0 0 0 150px" class="fv12bc" id="msgsave${ab.adId}al"> </span>
                    </div>
                    <%--   <!-- ********************************************************************************************************** -->
                       <!--   SAVE AD BLOCK END   -->
                       <!-- ********************************************************************************************************** -->

            <!-- ********************************************************************************************************** -->
            <!-- this div for quick registration -->
            <!-- ********************************************************************************************************** -->
                    --%>
                    <c:if test="${userBean == null}">
                        <script>

                        </script>
                        <div class="boxBorder4" id="nu${ab.adId}" style="width:737px;height:109px;float:left;display:none">
                            <div id="header" style="background-color:#CCC;width:737px" >
                                <div style="float:left;width:60%;text-align:left;">
                                    <span style="font-family:Arial;font-size:10px;font-weight:bold;padding-left:3px">To Register</span>
                                    <span style="font-family:Arial;font-size:10px;">&nbsp;(Please Enter the information)</span>
                                </div>
                                <div style="float:left;width:35%;text-align:right;font-size:9px;font-family:Arial;"><a href="javascript:return false;" onclick="toggle_qr('nu${ab.adId}','smsadvt','${ab.adId}','${ab.adId}');event.returnValue=false;return false;">Register</a>&nbsp;|&nbsp;
                                    <a href="javascript:return false;" onclick="toggle_fp('fp${ab.adId}');event.returnValue=false;return false;">Forgot Password</a></div>
                                <div style="float:left;width:5%;text-align:right;">
                                    <input type="image" src="images/close.png" onclick="toggle_close_it('nu${ab.adId}');" />
                                </div>
                            </div>
                            <br />
                            <form name="qrform" id="formnu${ab.adId}" method="get" action="quickReg.do" onsubmit="return validateQuickRegFormLA(this)">
                                <input type="hidden" name="adId" value="nu${ab.adId}" />
                                <table id="tablenu${ab.adId}" border="0" style="font-size:9px;margin:0 auto;margin-top:10px;_margin-top:-14px;" >
                                    <tr>
                                        <td width="">
                                            User Id
                                        </td>
                                        <td>
                                            <input style="height:12px;font-size:9px;width:120px" type="text" name="userName"
                                                   id="l${ab.adId}" onchange="checkUsName('l${ab.adId}','nu${ab.adId}')" />
                                        </td>
                                        <td width="">
                                            Your Name
                                        </td>
                                        <td width="">
                                            <input style="height:12px;font-size:9px;width:120px"  type="text" name="firstName" id="n${ab.adId}" />
                                        </td>
                                        <td style="width:30px" align="right">
                                            City
                                        </td>
                                        <td>
                                            <select size="1"  id="ct${ab.adId}" style="font-size:9px;width:122px;_width:125px;" name="city" >
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
                                            <input style="height:12px;font-size:9px;width:120px" type="text" name="mobile" id="ph${ab.adId}" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>&nbsp;</td>
                                        <td  style="width:130px;" align="center" valign="middle">
                                            <img alt="" id="verIdnu${ab.adId}" src="rig" style="height:21px;width:100px"/>&nbsp;
                                            <a class="link11" href="javascript:return false;" onclick="changeVrificationCodeQr('verIdnu${ab.adId}');event.returnValue=false;return false;"><img border="0" alt="verificationCode" src="bbsimages/referesh_button.jpg" style="height:24px;width:24px;"/></a>
                                        </td>
                                        <td>
                                            Enter&nbsp;Code
                                        </td>
                                        <td>
                                            <input id="vrCode${ab.adId}" type="text" name="regCode" style="width:120px;font-size:9px;" onblur="qrCheckRegCode('vrCode${ab.adId}','nu${ab.adId}')">
                                        </td>
                                        <td align="right">
                                            <input type="checkbox" name="iagree" ></td>
                                        <td><a href="javascript:return false;" onclick="termsAndConditions('tc.do');event.returnValue=false;return false;" style="color:#046DBE">I agree Terms &amp; Conditions.</a></td>
                                        <td></td>
                                        <td width="">
                                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input type="image" id="butdnu${ab.adId}"  src="bbsimages/buttons/RegisterSDis.png" disabled />
                                            <input type="image"  src="bbsimages/buttons/RegisterS.png" disabled onmouseover="this.src='bbsimages/buttons/RegisterS_MouseOver.png'" onmouseout="this.src='bbsimages/buttons/RegisterS.png'"
                                                   id="butnu${ab.adId}" style="display:none"      />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">&nbsp</td>
                                        <td colspan="4" align="center"><span id="codeTestNonu${ab.adId}" name="codeTestNo" style="color:red;font-size:10px;display:none" >Verfication doesn't matched</span></td>
                                        <td colspan="2">&nbsp</td>
                                    </tr>
                                </table>
                                <div class="fv12bc" style="text-align:center" id="msgnu${ab.adId}"></div>
                                <div class="fv11b" style="text-align:center;" id="confnu${ab.adId}" ></div>
                                <div id="imgnu${ab.adId}" style="display:none;text-align:center">Loading...</div>
                            </form>
                        </div>
                    </c:if>

                    <c:if test="${userBean != null}">
                        <div class="boxBorder4" id="nu${ab.adId}" style="width:737px;float:left;display:none"></div>
                    </c:if>

                    <%--
                                <!-- ********************************************************************************************************** -->
                                <!-- this div for quick registration end -->
                                <!-- ********************************************************************************************************** -->

            <!-- ********************************************************************************************************** -->
            <!-- this div for forget password -->
            <!-- ********************************************************************************************************** -->--%>

                    <c:if test="${userBean == null }" >
                        <div class="boxBorder4" id="fp${ab.adId}" style="width:737px;float:left;display:none">
                            <div id="header" style="background-color:#CCC;width:737px" >
                                <div style="float:left;width:60%;text-align:left;">
                                    <span style="font-family:Arial;font-size:10px;font-weight:bold;padding-left:3px">To Reset Your Password</span>
                                    <span style="font-family:Arial;font-size:10px;">&nbsp;(Please Enter the information)</span>
                                </div>
                                <div style="float:left;width:35%;text-align:right;font-size:9px;font-family:Arial;"><a href="javascript:return false;" onclick="toggle_qr('nu${ab.adId}','smsadvt','${ab.adId}','${ab.adId}');event.returnValue=false;return false;">Register</a>&nbsp;|&nbsp;
                                    <a href="javascript:return false;" onclick="toggle_fp('fp${ab.adId}');event.returnValue=false;return false;">Forget Password</a></div>
                                <div style="float:left;width:5%;text-align:right;">
                                    <input type="image" src="images/close.png" onclick="toggle_close_it('fp${ab.adId}')"/>
                                </div>
                            </div>

                            <div id="fpfp${ab.adId}" style="font-family:Arial;font-size:9px;margin:0 auto;">
                                <br><br/><br>
                                <table style="margin:0 auto;_margin-top:-12px;">
                                    <tr><td>Enter Email Id</td><td>&nbsp;</td>
                                        <td><input id="emfp${ab.adId}" style="height:12px;font-size:9px;width:150px" type="text" /></td>
                                        <td>&nbsp;&nbsp;</td><td>Enter Mobile Number</td><td>&nbsp;</td>
                                        <td><input id="yfp${ab.adId}" style="height:12px;font-size:9px;width:150px" type="text" /></td>
                                        <td><span style="padding-left:20px">
                                                <input type="image"  src="bbsimages/buttons/ResetPasswordS.png" onmouseover="this.src='bbsimages/buttons/ResetPasswordS_MouseOver.png'" onmouseout="this.src='bbsimages/buttons/ResetPasswordS.png'"
                                                       onclick="sendPassword('fp${ab.adId}');event.returnValue=false;return false;"/>
                                            </span></td></tr></table>
                            </div>
                            <div id="imgfp${ab.adId}" style="width:auto;padding:2px 0 2px 350px;display:none"> Loading... </div>
                            <span style="padding:0 0 0 150px" class="fv12bc" id="msgfp${ab.adId}">
                            </span>
                            <div style="width:737px;height:5px;float:left"></div>
                        </div>
                    </c:if>
                    <c:if test="${userBean != null }" >
                        <div class="boxBorder4" id="fp${ab.adId}" style="width:737px;float:left;display:none">
                        </div>
                    </c:if>
                    <%-- <!-- ********************************************************************************************************** -->
                     <!--End  div for forget password -->
                     <!-- ********************************************************************************************************** -->

            <!-- #############################################################################################################
                                                     DIV FOR SMS TO ADVERTISER STARTS
                 #############################################################################################################-->--%>

                    <div id="sms${ab.adId}wl" class="boxBorder4" style="width:737px;float:left;display:none">
                        <div id="header" style="background-color:#CCC;width:737px" >
                            <div style="float:left;width:60%;text-align:left;">
                                <span style="font-family:Arial;font-size:10px;font-weight:bold;padding-left:3px">Sms To Advertiser</span>
                                <span style="font-family:Arial;font-size:10px;">&nbsp;(Please Enter the information)</span>
                            </div>
                            <div style="float:left;width:35%;text-align:right;font-size:9px;font-family:Arial;"><a href="javascript:return false;" onclick="toggle_qr('nu${ab.adId}','smsadvt','${ab.adId}','${ab.adId}');event.returnValue=false;return false;">Register</a>&nbsp;|&nbsp;
                                <a href="javascript:return false;" onclick="toggle_fp('fp${ab.adId}');event.returnValue=false;return false;">Forget Password</a></div>
                            <div style="float:left;width:5%;text-align:right">
                                <input type="image" src="images/close.png" onclick="toggle_close_it('sms${ab.adId}wl')"/>
                            </div>
                        </div>
                        <br>

                        <div id="formsms${ab.adId}wl" style="font-family:Arial;font-size:9px;padding:1px auto">

                            <table style="margin: 10px auto;_margin-top: -10px;">
                                <tr> <input type="hidden" id="msms${ab.adId}wl" value="${ab.adId}" /> <%-- mobile--%>
                                <input type="hidden" id="adtsms${ab.adId}wl" value="${ab.title}" />
                                <td  width="12%" style="text-align:left">User Id</td>
                                <td ><input style="height:12px;font-size:9px;" id="lsms${ab.adId}wl" type="text" size="35"  /></td>

                                <td  width="12%" style="text-align:left">Password</td>
                                <td><input style="height:12px;font-size:9px;" id="psms${ab.adId}wl" type="password" size="35"   /></td>
                                </tr>
                                <tr>
                                    <td>Message</td>
                                    <td colspan="3"><input style="height:12px;font-size:9px;width:405px;_width:415px" type="text" readonly value="Hi, I am insterested in your ad, please contact me, I need more information about your Ad." /></td>
                                    <td> <input type="image" src="bbsimages/buttons/SendSMS.png" onmouseover="this.src='bbsimages/buttons/SendSMS_MouseOver.png'" onmouseout="this.src='bbsimages/buttons/SendSMS.png'" onclick="smsAdvertiserWL('sms${ab.adId}wl','${ab.adId}')" /></td>
                                </tr>
                            </table>
                        </div>
                        <div id="loadsms${ab.adId}wl" style="width:auto;padding:2px 0 2px 350px;display:none"> <img src="images/loading.gif" style="height:32px;width:32px;" /><br></div>
                        <span style="padding:0 0 0 150px" class="fv12bc" id="msgsms${ab.adId}wl"> </span>
                    </div>
                    <div id="sms${ab.adId}al" class="boxBorder4" style="width:737px;height:60px;float:left;display:none;padding:2px 0 10px 0">
                        <div id="header" style="background-color:#CCC;width:737px" >
                            <div style="float:left;width:60%;text-align:left;">
                                <span style="font-family:Arial;font-size:10px;font-weight:bold;padding-left:3px">Sms To Advertiser</span>

                            </div>
                            <div style="float:left;width:35%;text-align:right;font-size:9px;font-family:Arial;">
                            </div>
                            <div style="float:left;width:5%;text-align:right">
                                <input type="image" src="images/close.png" onclick="toggle_close_it('sms${ab.adId}al')"/>
                            </div>
                        </div>

                        <div id="formsms${ab.adId}al" style="font-family:Arial;font-size:9px;padding: 1px auto;">
                            <br /><input type="hidden" id="msms${ab.adId}al" value="${ab.mobile}" />         <%--mobile--%>
                            <input type="hidden" id="adtsms${ab.adId}al" value="${ab.title}" />
                            <table style="margin:0 auto;">
                                <tr>
                                    <td>  <input type="text" size="92" style="height:12px;font-size:9px;" readonly value="Hi, I am insterested in your ad, please contact me, I need more information about your Ad."/></td>
                                    <td><input type="image" src="bbsimages/buttons/SendSMS.png" onmouseover="this.src='bbsimages/buttons/SendSMS_MouseOver.png'" onmouseout="this.src='bbsimages/buttons/SendSMS.png'" onclick="smsAdvertiserAL('sms${ab.adId}al','${ab.adId}')" /></td>

                                </tr>
                            </table>
                        </div>

                        <div id="loadsms${ab.adId}al" style="width:auto;padding:2px 0 2px 350px;display:none"> <img src="images/loading.gif" alt="loading" style="height:32px;width:32px;"/><br></div>

                        <span  style="padding:0 0 0 150px;" class="fv12bc" id="msgsms${ab.adId}al"> </span>



                    </div>

                    <%--         <!-- #############################################################################################################
                                                          DIV FOR SMS TO ADVERTISER ENDS
                      #############################################################################################################-->



            <!-- #############################################################################################################
                                                     DIV FOR E-MAIL TO FRIEND  STARTS
                 #############################################################################################################-->

            <!-- email to  friend for without login  users -->
                    --%>
                    <div class="boxBorder4" id="email${ab.adId}wl"  style="width:737px;float:left;display:none;">

                        <div id="header" style="background-color:#ffcc33;width:737px;" >
                            <div style="float:left;width:60%;text-align:left;"><span style="font-family:Arial;font-size:10px;font-weight:bold;padding-left:3px">To Email this Ad to Friend</span>

                                <span style="font-family:Arial;font-size:10px;">&nbsp;(Please Enter the information)</span>
                            </div>
                            <div style="float:left;width:35%;text-align:right;font-size:9px;font-family:Arial;"><a href="javascript:return false;" onclick="toggle_qr('nu${ab.adId}','emailFriend');event.returnValue=false;return false; ">Register</a>&nbsp;|&nbsp;
                                <a href="javascript:return false;" onclick="toggle_fp('fp${ab.adId}');event.returnValue=false;return false;">Forget Password</a></div>

                            <div style="float:left;width:5%;text-align:right">
                                <input type="image" src="images/close.png" onclick="toggle_close_it('email${ab.adId}wl')"/>
                            </div>
                        </div>
                        <br />
                        <div id="formemail${ab.adId}wl" style="font-family:Arial;font-size:9px;padding:1px auto">
                            <table style="margin: 10px auto;_margin-top: -10px;">

                                <tr>
                                    <td  width="12%" style="text-align:left">Friend's Name </td>
                                    <td><input style="height:12px;font-size:9px;" id="fnemail${ab.adId}wl" type="text" size="35"   /> </td>
                                    <td width="6%" > &nbsp;</td>
                                    <td  width="12%" style="text-align:left">Friend's Email </td>
                                    <td><input style="height:12px;font-size:9px;" id="feemail${ab.adId}wl" type="text" size="35"   /> </td>
                                    <td> &nbsp;</td>
                                </tr>

                                <tr>
                                    <td  width="12%" style="text-align:left">User Id</td>
                                    <td><input style="height:12px;font-size:9px;" id="lemail${ab.adId}wl" type="text" size="35"  /></td>
                                    <td width="6%" > &nbsp;</td>
                                    <td  width="12%" style="text-align:left">Password</td>
                                    <td><input style="height:12px;font-size:9px;_width:160px;" id="pemail${ab.adId}wl" type="password" size="35"   /></td>
                                    <td  width="15%" style="text-align:right"><input type="image" src="bbsimages/buttons/SendEmail.png" onmouseover="this.src='bbsimages/buttons/SendEmail_MouseOver.png'" onmouseout="this.src='bbsimages/buttons/SendEmail.png'"  onclick="sendToFriendWL('email${ab.adId}wl','${ab.adId}','${ab.title}','${ab.catId}')" /></td>
                                </tr>
                            </table>
                        </div>

                        <div id="loademail${ab.adId}wl" style="width:auto;padding:2px 0 2px 350px;display:none"> <img src="images/loading.gif" style="height:32px;width:32px;" /><br></div>

                        <span style="padding:0 0 0 150px" class="fv12bc" id="msgemail${ab.adId}wl"> </span>

                    </div>

                    <!-- email to  friend for logged in users  -->

                    <div id="email${ab.adId}al" class="boxBorder4" style="width:737px;height:60px;float:left;display:none;padding:2px 0 10px 0;">

                        <div id="header" style="background-color:#ffcc33;width:737px" >
                            <div style="float:left;width:60%;text-align:left;">
                                <span style="font-family:Arial;font-size:10px;font-weight:bold;padding-left:3px">To Email this Ad to Friend</span> <span style="font-family:Arial;font-size:10px;">&nbsp;(Please Enter the information)</span>
                            </div>
                            <div style="float:left;width:35%;">
                            </div>
                            <div style="float:left;width:5%;text-align:right">
                                <input type="image" src="images/close.png" onclick="toggle_close_it('email${ab.adId}al')"/>
                            </div>
                        </div>
                        <br />
                        <div id="formemail${ab.adId}al" style="font-family:Arial;font-size:9px;padding: 1px auto;">

                            <table style="margin:0 auto;font-size:9px; margin-top:00px;">
                                <tr>
                                    <td  width="12%" style="text-align:left">Friend's Name </td>
                                    <td><input style="height:12px;font-size:9px;" id="fnemail${ab.adId}al" type="text" size="35" name="friendName"  /> </td>
                                    <td width="6%" > &nbsp;</td>
                                    <td  width="12%" style="text-align:left">Friend's Email </td>
                                    <td><input style="height:12px;font-size:9px;" id="feemail${ab.adId}al" type="text" size="35" name="friendEmail" /> </td>
                                    <td  width="15%" style="text-align:right"><input type="image" src="bbsimages/buttons/SendEmail.png" onmouseover="this.src='bbsimages/buttons/SendEmail_MouseOver.png'" onmouseout="this.src='bbsimages/buttons/SendEmail.png'" onclick="sendToFriendAL('email${ab.adId}al','${ab.adId}','${ab.title}','${ab.catId}')" /></td>
                                </tr>
                            </table>
                        </div>
                        <div id="loademail${ab.adId}al" style="width:auto;padding:2px 0 2px 350px;display:none"> <img src="images/loading.gif" style="height:32px;width:32px;" /><br></div>
                        <span  style="padding:0 0 0 150px;" class="fv12bc" id="msgemail${ab.adId}al"> </span></div>
                        <%--
                    <!-- #############################################################################################################
                                                 DIV FOR E-MAIL TO FRIEND  ENDS
             #############################################################################################################-->--%>
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

                </c:forEach>
            </c:if>

        </div>



    </div>


    <div style="clear:both"></div>

    <div style="<%--background-color:#633fff;--%>height:90px;width:1100px ">
        <c:if test="${dAdBean!=null}">
            <c:set var="db" value="${dAdBean}"/>

                <div class="headerLogo" style="width:970px;height:80px">
                    <div style="float:left;padding-top:10px;padding-left:10px"><span><img src="resourceGetter?imf=${db.logoPath}"
                                                                width="75px" height="65px" style="border:none"  ></span></div>

                    <div style="float:left;width:530px;padding:20px;padding-bottom:40px">${db.description}  </div>

                    <div class="boxBorder5" style="font-size:small;margin-top:5px;float:left;padding-bottom:5px;height:60px;width:200px;padding-left:20px">
                        <table style="color:#ffffff;">
                            <tr>
                                <td style="vertical-align:top"><span style="font-size:smaller"><b>Address</b></span></td>
                                <td>:</td>
                                <td style="vertical-align:top"><span style="font-size:smaller"><b>${db.AREA}${db.LOCALITY},${db.CITY}<br/>${db.STATE}<br/>${db.COUNTRY}</b></span></td>
                            </tr>
                            <tr>
                                <td><span style="font-size:smaller"><b></b></span></td>
                                <td>:</td>
                                <td><span style="font-size:smaller"><b>fghgfh</b></span></td>
                            </tr>
                            <tr>
                                <td><span style="font-size:smaller"><b>Landline</b></span></td>
                                <td>:</td>
                                <td><span style="font-size:x-small;width:50px"><b>ghffghfhfh</b></span></td>
                            </tr>

                        </table>
                    </div>
                </div>

        </c:if></div>


</div>