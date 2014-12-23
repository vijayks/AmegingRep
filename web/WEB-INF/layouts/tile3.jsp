<%--
    Document   : tile3
    Created on : Jan 9, 2010, 8:47:39 PM
    Author     : madhuri
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://struts.apache.org/tags-tiles" prefix="tiles" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>${domainNM} Ads - ${dAdBean.city} Ads</title>
        <meta name="description" content="${domainNM} Ads - ${dAdBean.city} Ads"/>
        <meta name="keywords" content="${domainNM} Ads - ${dAdBean.city} Ads"/>
        <link rel="shortcut Icon" href="<c:url value='/bbsimages/favicon.ico'/>"  />
    </head>
    <body>
        <script type="text/javascript" src="<c:url value='/js/allAjax.js'/>"></script>
        <script type="text/javascript" src="<c:url value='/js/alljs.js'/>"></script>
    <style>
        .boxBorder4{height:90px; -moz-border-radius:0 0 5px 5px; -webkit-border-radius: 10px;}
    </style>
    <link rel="StyleSheet" href="<c:url value='/css/stylesheet.css'/>" type="text/css">
    <script type="text/javascript" src="<c:url value='/highslide/highslide-with-html.js'/>"></script>
    <link rel="stylesheet" type="text/css" href="<c:url value='/highslide/highslide.css'/>"/>
    <script type="text/javascript">
        hs.graphicsDir = '<c:url value='/highslide/graphics/'/>';
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
            //        alert(url);
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
            // alert(itemId);
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
            //   alert(itemId);
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

    <style>
        .headerLogo { padding:8px 0px; font-size:small; font-family:Arial; color:#ffffff; }
        .boxBorder5
        {
            padding:0 2px 4px 10px; font-size:11px; font-weight:bold; font-family:Arial;  width:25%;
            -moz-border-radius:13px 13px 13px 13px;  -webkit-border-radius: 10px;
        }
        .boxBorder6 { -moz-border-radius:5px 15px 15px 15px;  -webkit-border-radius: 10px; }

    </style>

    <div id="wrapper" style="float:left;" >
        <div style="background-color:#4D9EDF;width:1000px;margin:0 auto;">
            <%--for header--%>
            <tiles:insert attribute="header" />
        </div>
        <div id="body_container2" >
            <div id="body_container1" style="padding-top:15px;border-left:1px solid #000000;border-right:1px solid #000000">
                <div style="float:left;width:25%;">
                    <%--for special offers--%>
                    <tiles:insert attribute="menu" />
                </div>
                <div id="masterrightbodybg" style="float:left;width:74%;position:relative;" >
                    <%--for dealer Ads--%>
                    <tiles:insert attribute="body" />
                </div>
            </div>
        </div>
        <div style="clear:both"></div>
        <div style="background-color:#4D9EDF;width:1000px;;margin:0 auto;">
            <%--for footer--%>
            <tiles:insert attribute="footer" />
        </div>
    </div>
    <%--  -------------------------%>
</body>
</html>
