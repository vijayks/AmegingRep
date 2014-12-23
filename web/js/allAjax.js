var lclurl="";
if(document.location.href.indexOf(":8080/Buy")>0)
    lclurl="/Buysell";
/*Starting of UserIdAvailabilityCheck.js*/
var reqForUserId;


if (window.XMLHttpRequest) { // Non-IE browsers
    reqForUserId = new XMLHttpRequest();
} else if (window.ActiveXObject) { // IE
    reqForUserId = new ActiveXObject("Microsoft.XMLHTTP");
}
var userIdAvailablity = reqForUserId;

function isValidUserId(queryString){


    var sbox = document.getElementById(queryString).value;

    var arg = "un="+sbox;
    var url = "vuid";
    sendUserIdAvalabilityRequest(url, arg, handleuserIdReqResponse1);


}

function sendUserIdAvalabilityRequest(url,args) {



    if(userIdAvailablity.readyState == 4 || userIdAvailablity.readyState== 0){


        userIdAvailablity.open("POST", url , true);  //Opens a connection and retrieves response from the specified URL

        userIdAvailablity.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');

        userIdAvailablity.send(args); //Transmits request (can include postable string or DOM object data)

        //showGif(true);

        userIdAvailablity.onreadystatechange = handleuserIdReqResponse1; //to make sure that request is complete.

    }
}
function showNotAvailDiv()
{

    document.getElementById("notValid").style.display = 'inline' ;
    document.getElementById("valid").style.display = 'none' ;
}

function showAvailDiv()
{
    document.getElementById("valid").style.display = 'inline' ;
    document.getElementById("notValid").style.display = 'none' ;

}

function handleuserIdReqResponse1() {



    if (userIdAvailablity.readyState == 4) {



        response = reqForUserId.responseXML.documentElement;


        if (response != null) {
            //        showGif(false);
            var results = response.getElementsByTagName('check');


            if (results != null && results.length > 0) {

                var x=results[0].getAttribute("value");

                if(x =="YES"){
                    showAvailDiv();
                    document.getElementById("rButton").disabled = false ;

                }else{
                    showNotAvailDiv();
                    document.getElementById("rButton").disabled = true ;
                }


            }

        }
    }

}
/*End of userIdAvailabilityCheck.js*/
/********************************************************************************************************************************************/


/*Starting of regCodeValidateAjax.js*/
var reqVerifyCode;
if (window.XMLHttpRequest) { // Non-IE browsers
    reqVerifyCode = new XMLHttpRequest();
} else if (window.ActiveXObject) { // IE
    reqVerifyCode = new ActiveXObject("Microsoft.XMLHTTP");
}
var userRegister = reqVerifyCode;
function CheckRegCode(element){
    var sbox = document.getElementById("regCode").value;

    var arg = "code="+sbox;
    var url = "rcv";
    sendTestVerifcationCodeReq(url, arg, VericationCodeMatRes);

}


function sendTestVerifcationCodeReq(url,args) {

    if(userRegister.readyState == 4 || userRegister.readyState== 0){
        userRegister.open("POST", url , true);  //Opens a connection and retrieves response from the specified URL
        userRegister.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        userRegister.send(args); //Transmits request (can include postable string or DOM object data)
        userRegister.onreadystatechange = VericationCodeMatRes; //to make sure that request is complete.
    }
}
//this method used to show the user already existed div
function YesReg()
{

    //document.getElementById("rButton").disabled = false ;

    document.getElementById("codeTestNo").style.display = 'none' ;
    toggle_enable('rButtonDis','rButton');
}
function NoReg()
{


    document.getElementById("codeTestNo").style.display = 'inline' ;
    toggle_disable('rButtonDis','rButton');
}
function VericationCodeMatRes(){
    if (userRegister.readyState == 4) {
        response = reqVerifyCode.responseXML.documentElement;
        if (response != null) {
            var results = response.getElementsByTagName('display');
            if (results != null && results.length > 0) {
                var x=results[0].getAttribute("name");

                if(x =="NO"){
                    NoReg();
                }else if(x == "YES")
                {
                    YesReg();
                }
            }

        }
    }
}


//var verifCodeflag = false;
//function CheckRegCodeNew(element){
//    var sbox = document.getElementById("regCode").value;
//
//    var arg = "code="+sbox;
//    var url = "rcv";
//    window.verifCodeflag = false;
//    sendTestVerifcationCodeReqNew(url, arg, VericationCodeMatResNew);
//
//}
//
//function sendTestVerifcationCodeReqNew(url,args) {
//
//    if(userRegister.readyState == 4 || userRegister.readyState== 0){
//        userRegister.open("POST", url , true);  //Opens a connection and retrieves response from the specified URL
//        userRegister.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
//        userRegister.send(args); //Transmits request (can include postable string or DOM object data)
//        userRegister.onreadystatechange = VericationCodeMatResNew; //to make sure that request is complete.
//    }
//}
//
//function VericationCodeMatResNew(){
//    if (userRegister.readyState == 4) {
//        response = reqVerifyCode.responseXML.documentElement;
//        if (response != null) {
//            var results = response.getElementsByTagName('display');
//            if (results != null && results.length > 0) {
//                var x=results[0].getAttribute("name");
////                alert(x);
//                if(x == "YES")
//                {
////                   alert(x);
//                    window.verifCodeflag = true;
//
//                }
//            }
//
//        }
//    }
//}
//
//function getVerifCodeFlag() {
//   alert("hi")
//    return window.verifCodeflag;
//  // alert("hai")
////    alert(verifCodeflag)
//    }

/*End of regCodeValidateAjax.js*/
/********************************************************************************************************************************************/
/*Starting of quickRegAjax.js*/
var qrVar;

if (window.XMLHttpRequest) { // Non-IE browsers
    qrVar = new XMLHttpRequest();
} else if (window.ActiveXObject) { // IE
    qrVar = new ActiveXObject("Microsoft.XMLHTTP");
}
var ajxQrVar = qrVar;

function  quickRegAjax(lid,name,city,ph,code,divID){

    var qrystr="userId="+document.getElementById(lid).value+"&fname="+document.getElementById(name).value+"&city="+document.getElementById(city).value+
    "&ph="+document.getElementById(ph).value+"&code="+document.getElementById(code).value+"&divId="+divID+"&action=register";
    var arg=qrystr;
    var url ="qrs";
    sendRequestQR(url,arg, QrResponse);

}

function qrCheckRegCode(element,divID)
{
    var sbox = document.getElementById(element).value;
    var arg = "code="+sbox+"&divId="+divID+"&action=register";
    var url = lclurl+"/qrs";
    sendRequestQR(url,arg, QrResponse);
}

function checkUsName(name,divId){

    var emailregx=/^[a-z]+(([a-z_0-9]*)|([a-z_0-9]*\.[a-z_0-9]+))*@([a-z_0-9\-]+)((\.[a-z]{3})|((\.[a-z]{2})+)|(\.[a-z]{3}(\.[a-z]{2})+))$/;
    var emailt = document.getElementById(name).value.toLowerCase();
    var target= document.getElementById(name);
    if(document.getElementById(name).value == '')
    {
        document.getElementById(name).style.borderColor = 'red';
        alert("Please enter valid email id");
        target.focus();
    }
    else if ( !emailregx.test ( emailt ) )
    {

        document.getElementById(name).style.borderColor = 'red';
        alert("Please give login id as yourname@company.com");
        target.focus();

    }else
    {
        document.getElementById(name).style.borderColor = '';
        var arg="un="+document.getElementById(name).value+"&divId="+divId+"&action=check";
        var url =lclurl+"/qrs";
        sendRequestQR(url,arg, QrResponse);

    }

}
function checkMobileNum(name,divId)
{
    var mobileRegx=/^([9]{1})([234789]{1})([0-9]{8})$/;
    var mobileNum = document.getElementById(name).value.toLowerCase();
    var chk=true;

    if(document.getElementById(name).value == '')
    {
        document.getElementById(name).style.borderColor = 'red';
        alert("Please enter mobile number");
        chk=false;

    }
    else if ( !mobileRegx.test ( mobileNum ) )
    {
        document.getElementById(name).style.borderColor = 'red';
        alert("Enter a valid mobile num");
        chk=false;
    }
    return chk;
}




function sendRequestQR(url,arg,QrResponse) {

    if(ajxQrVar.readyState == 4 || ajxQrVar.readyState== 0){
        ajxQrVar.open("POST", url , true);  //Opens a connection and retrieves response from the specified URL
        ajxQrVar.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        ajxQrVar.send(arg); //Transmits request (can include postable string or DOM object data)
        ajxQrVar.onreadystatechange = QrResponse; //to make sure that request is complete.
    }
}


function qrResult(resajax)
{
    var res=false;
    res=resajax;

    return res;
}

function ShowOk(value,divId)
{

    document.getElementById("conf"+divId).innerHTML="";
    document.getElementById("conf"+divId).style.color="green";
    document.getElementById("conf"+divId).innerHTML=value;

    document.getElementById("but"+divId).disabled = false;
}

function ShowNotOk(value,divId)
{
    document.getElementById("conf"+divId).innerHTML="";
    document.getElementById("conf"+divId).style.color="red";
    document.getElementById("conf"+divId).innerHTML=value;
    document.getElementById("but"+divId).disabled = true;
}


function QrResponse(){

    if (ajxQrVar.readyState == 4) {
        var	res = qrVar.responseXML.documentElement;

        if (res != null) {
            var results = res.getElementsByTagName('register');
            var chk=res.getElementsByTagName('check');



            if (results != null && results.length > 0) {
                var x=results[0].getAttribute("result");
                var divId=results[0].getAttribute("DIVID");
                if(x == 'CODEOK')
                {
                    document.getElementById("codeTestNo"+divId).style.display = 'none';
                    toggle_enable("butd"+divId,"but"+divId);
                }
                if(x == "ERRORCODE")
                {
                    document.getElementById("codeTestNo"+divId).style.display = 'inline';
                    toggle_disable("butd"+divId,"but"+divId);

                }
            }

            else if(chk != null && chk.length > 0)
            {

                var ch=chk[0].getAttribute("value");

                if(ch == "YES")
                {
                    ShowOk("User Name Avalable",chk[0].getAttribute("divId"));
                }
                if(ch == "NO")
                {
                    ShowNotOk("User Name Not Avalable",chk[0].getAttribute("divId"));
                }
            }



        }
    }
}
/*end of quickRegAjax.js*/
/*****************************************************************************************************************************************/
/*Start of postAdAjax.js*/
/**
 * @author lsadm
 */
var divCount = -1;
var pos = 0;
var last = 0;
var prv;
var upLast = 0;
var lastString;

var suggestionReq;

if (window.XMLHttpRequest) { // Non-IE browsers
    suggestionReq = new XMLHttpRequest();
} else if (window.ActiveXObject) { // IE
    suggestionReq = new ActiveXObject("Microsoft.XMLHTTP");
}
var PostAdSuggestionReq = suggestionReq;
var hashMap = new Array(10);
function init(){

    var t = document.createElement("div");
    t.id = "nt";
    t.onmouseover = mouseup;
    t.onmouseout = mouseout;
    t.onclick = mouseclick;
    var txt = document.getElementsByName("it")[0].value;
    var tk = document.createTextNode(txt);
    tk.fontcolor = "#0000FF";
    t.appendChild(tk);
    document.getElementById("sri").appendChild(t);
    divCount++;
    var tt = document.getElementsByName("it")[0];

}
function addDiv(txt,ids){
    var t = document.createElement("div");
    t.id = "nt";
    t.onmouseover = mouseup;
    t.onmouseout = mouseout;
    t.onclick = mouseclick;
    t.appendChild(document.createTextNode(txt));
    //var el = document.createTextNode(ids);
    //t.appendChild(document.createTextNode(ids));
    document.getElementById("sri").appendChild(t);
    divCount++;
}

function visible(ele, visi){
    var el = document.getElementById(ele);
    el.style.visibility = visi;
    el.onkeydown = keyDown;

}

function clearDivs(ele, val){
    var el = document.getElementById(ele);
    while (el.hasChildNodes) {

        var cel = el.firstChild;

        if(cel != null){
            el.removeChild(cel);
            pos = 0;
            divCount--;
        }else {
            return;
        }
        if (val == 1)
            break;
    }

}

function mouseup(){
    this.style.background = "#DDDDDD";
//this.style.color = "black";


}

function mouseout(){
    this.style.background = "#FFFFFF";
//this.style.color = "skyblue";

}

function mouseclick(){

    this.style.background = "#4D9EDF";
    this.style.color = "blue";
    document.getElementsByName("it")[0].value = this.firstChild.data;
    document.getElementsByName("cid")[0].value=hashMap[document.getElementsByName("it")[0].value ];
    //  alert(hashMap[document.getElementsByName("it")[0].value ]);
    visible('sri','hidden');
}

function keyDown(event){
    var key;
    if (!event && window.event)
        event = window.event;
    if (event)
        key = event.keyCode;
    else
        key = event.which;

    if (divCount > -1) {
        var l = document.getElementById("sri");
        var ch;
        ch = l.childNodes;

        switch (key) {
            case 13:
                var ent = pos;
                if (ent == 0) {
                    ent = divCount + 1;
                }

                document.getElementsByName("it")[0].value = ch[ent].firstChild.data;
                visible('sri','hidden');
                break;
            case 38: // up
                if (upLast == 1) {
                    upLast = 0;
                    pos = divCount + 1;
                    prv = divCount;
                }
                if (last == 1) {
                    pos = divCount;
                    prv = divCount + 1;
                }
                else {

                    prv = pos;
                    pos--;
                }
                if (pos == 0) {
                    pos = divCount + 1;
                    prv = 1;
                }

                last = 0;
                //alert("po "+pos+" prv "+prv+" up "+upLast+" la "+last);
                if (pos >= 1) {

                    var k = ch[prv];
                    k.style.background = "#99FFFF";
                    k.style.color = "skyblue";

                    var kl = ch[pos];
                    kl.style.background = "white";
                    kl.style.color = "black";
                }
                if (pos == divCount + 1) {
                    pos = 0;
                    upLast = 1
                }

                break;
            case 40://down
                pos++;
                if (pos > 1) {

                    var k = ch[pos - 1];
                    k.style.background = "lightblue";
                    k.style.color = "skyblue";

                    var kl = ch[pos];
                    kl.style.background = "white";
                    kl.style.color = "black";


                }
                else {

                    pos = 1;
                    var k = ch[pos];
                    k.style.background = "white";
                    k.style.color = "black";
                    var k = ch[divCount + 1];
                    k.style.background = "lightblue";
                    k.style.color = "skyblue";
                }
                if (pos == divCount + 1) {

                    last = 1;
                    pos = 0;
                }
                else {
                    last = 0;
                }
                break;
            case 27:

                break;
        }
    }
}

function changeDivs(elm){

    var obj = elm;//document.getElementsByName(elm)[0];
    var xx = findPosX(obj);
    var yy = findPosY(obj);
    var cd = document.getElementById("sri");
    //cd.style.visibility="hidden";
    //document.getElementById("sri").style.position = 'absolute';
    //document.getElementById("sri").style.top = (xx+20 ) + "px";
    //document.getElementById("sri").style.left = (yy-20) + "px";
    //cd.style.visibility = "visible";
    // alert("positions are"+findPosX(document.getElementById("sri"))+" "+findPosY(document.getElementById("sri")));
    var let = document.getElementsByName("it")[0].value;
    if(let.toString().length > 2)
    {
        getSearchInfo();
    }
    if(let.toString().length <= 2)
    {
        clearDivs("sri",0);
    }
    toggle_disable('sugg_sub_butDis', 'sugg_sub_but');
}

function findPosX(obj){

    var curleft = 0;
    if (obj.offsetParent) {
        while (obj.offsetParent) {
            curleft += obj.offsetLeft;
            obj = obj.offsetParent;
        }
    }
    else
    if (obj.x)
        curleft += obj.x;
    return curleft;
}

function findPosY(obj){

    var curtop = 0;
    if (obj.offsetParent) {
        curtop += obj.offsetHeight;
        while (obj.offsetParent) {
            curtop += obj.offsetTop;
            obj = obj.offsetParent;
        }
    }
    else
    if (obj.y) {
        curtop += obj.y;
        curtop += obj.height;
    }
    return curtop;
}


function sendRequestSugg(url,args,responceMethod) {

    if(PostAdSuggestionReq.readyState == 4 || PostAdSuggestionReq.readyState== 0){

        PostAdSuggestionReq.open("POST", url , true);  //Opens a connection and retrieves response from the specified URL

        PostAdSuggestionReq.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');

        PostAdSuggestionReq.send(args); //Transmits request (can include postable string or DOM object data)

        PostAdSuggestionReq.onreadystatechange = handleHttpResponsesugg; //to make sure that request is complete.
    }
}

function getSearchInfo(){

    var txt = document.getElementsByName("it")[0].value;
    var url = "sugg";
    var args = "it="+txt;

    if(lastString != txt){
        sendRequestSugg(url,args,handleHttpResponsesugg);
        lastString = txt;
    }
    else
    {
        visible("sri", "visible");
    }

}

function handleHttpResponsesugg(){

    if (PostAdSuggestionReq.readyState == 4) {
        response = PostAdSuggestionReq.responseXML.documentElement;
        if (response != null) {
            hashMap = new Array(10);
            visible("sri", "hidden");
            //alert("srikanth"+response.getElementsByTagName('search').length);
            var results = response.getElementsByTagName('search');

            if (results != null && results.length > 0) {
                clearDivs("sri",0);
                for (var i = 0; i < results.length; i++) {
                    hashMap[results[i].getAttribute("value")] = results[i].getAttribute("id");
                    addDiv( results[i].getAttribute("value"),results[i].getAttribute("id"));
                }
                visible("sri", "visible");
            }

        }
    }
}
/*end of postAdAjax.js*/

/*Start of postAd.js*/
function adTypeSelected(itemId1,itemId2)
{

    document.getElementById(itemId1).style.display = 'inline';
    document.getElementById(itemId2).style.display = 'none';
}
/*end of postAd.js*/

/*Start of inlineRequestResolve.js*/
var saveAdVar;

if (window.XMLHttpRequest) { // Non-IE browsers
    saveAdVar = new XMLHttpRequest();
} else if (window.ActiveXObject) { // IE
    saveAdVar = new ActiveXObject("Microsoft.XMLHTTP");
}
var ajxVar = saveAdVar;
var divId;

function SaveAdAjaxFun(itemId,qrystr){
    divId=itemId;
    var arg = qrystr+"&act=save";
    var url = lclurl+"/irrs";
    sendRequestSaveAd(url,arg, SaveAdResponse);

}



function sendRequestSaveAd(url,arg,SaveAdResponse) {

    if(ajxVar.readyState == 4 || ajxVar.readyState== 0){


        ajxVar.open("POST", url , true);  //Opens a connection and retrieves response from the specified URL

        ajxVar.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');

        ajxVar.send(arg); //Transmits request (can include postable string or DOM object data)


        ajxVar.onreadystatechange = SaveAdResponse; //to make sure that request is complete.

    }
}


function sleep(ms)
{
    var dt = new Date();
    dt.setTime(dt.getTime() + ms);
    while (new Date().getTime() < dt.getTime()){}
}

function loginChanges(name)
{
    R=1;
    document.getElementById("dr").innerHTML="Logout";
    document.getElementById("myAccount").setAttribute("href", lclurl+"/my_ads_details.do")
    document.getElementById("login").setAttribute("href", lclurl+"/logout.do")
//    document.getElementById("guest").style.display = 'none';
//    document.getElementById("guest1").innerHTML=name;
}

function loginError(value)
{
    document.getElementById("load"+divId).style.display = 'none';// to make the loading image none
    document.getElementById("form"+divId).style.display="inline";//to show the form again with error msg
    document.getElementById("msg"+divId).style.color="red";// style of color to red
    document.getElementById("msg"+divId).innerHTML=value;


}


function OperationResult(value)
{

    document.getElementById("load"+divId).style.display = 'none';// to make the loading image none
    document.getElementById("msg"+divId).style.color="#046DBE";//make the color of msg to normal

    document.getElementById("msg"+divId).innerHTML=value;

}
function errorOperationResult(value)
{
    document.getElementById("load"+divId).style.display = 'none';// to make the loading image none
    document.getElementById("msg"+divId).style.color="#f00";//make the color of msg to normal
    document.getElementById("form"+divId).style.display="inline";
    document.getElementById("msg"+divId).innerHTML=value;
}



function SaveAdResponse(){

    if (ajxVar.readyState == 4) {

        var	res = ajxVar.responseXML.documentElement;

        if (res != null) {

            var results = res.getElementsByTagName('login');
            if (results != null && results.length > 0) {
                loginError("Wrong user name or password.");
            }else
            {
                results = res.getElementsByTagName('saveAd');
                if (results != null && results.length > 0) {
                    var fr=results[0].getAttribute("from");


                    if(fr=="NOTLOG")
                    {
                        loginChanges(results[0].getAttribute("name"))
                    }

                    //document.getElementById("cont"+divId).style.display = 'inline';
                    var x=results[0].getAttribute("value");
                    if(x =="YES"){
                        OperationResult("Ad successfully saved, to view saved ads <a href='"+lclurl+"/my_saved_ads.do' class='link11' style='text-decoration:underline' >Click Here</a>");
                    }else if(x == "OVER")
                    {
                        OperationResult("Save ad limit reached, to view saved ads <a href='"+lclurl+"/my_saved_ads.do' class='link11' style='text-decoration:underline' >Click Here</a>");
                    }else if(x == "EXIST")
                    {
                        OperationResult("This ad already exist in your account, to view saved ads <a href='"+lclurl+"/my_saved_ads.do' class='link11' style='text-decoration:underline' >Click Here</a>");
                    }
                    else if(x == "OWNAD")
                    {
                        OperationResult("Own ad cannot be saved, to view saved ads <a href='"+lclurl+"/my_saved_ads.do' class='link11' style='text-decoration:underline' >Click Here</a>");
                    }
                    else
                    {
                        OperationResult("Error in saving ad, to view saved ads <a href='"+lclurl+"/my_saved_ads.do' class='link11' style='text-decoration:underline' >Click Here</a>");
                    }

                }
            }
        }

    }
}


function sendToFriendAjaxFun(itemId, qrystr){
    divId=itemId;
    var arg = qrystr+"&act=email";
    var url = lclurl+"/irrs";

    SendToFriendRequest(url, arg, handleSendToFriendReqResponse);
}

function SendToFriendRequest(url,args) {
    if(ajxVar.readyState == 4 || ajxVar.readyState== 0){
        ajxVar.open("POST", url , true);  //Opens a connection and retrieves response from the specified URL
        ajxVar.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        ajxVar.send(args); //Transmits request (can include postable string or DOM object data)
        ajxVar.onreadystatechange = handleSendToFriendReqResponse; //to make sure that request is complete.
    }
}

function handleSendToFriendReqResponse() {
    if (ajxVar.readyState == 4) {
        var response = ajxVar.responseXML.documentElement;
        if (response != null) {

            var results = response.getElementsByTagName('login');
            if (results != null && results.length > 0) {
                loginError("Wrong user name or password.");
            }else
            {
                results = response.getElementsByTagName('email');
                if (results != null && results.length > 0) {
                    var fr=results[0].getAttribute("from");


                    if(fr=="NOTLOG")
                    {
                        loginChanges(results[0].getAttribute("name"))
                    }


                    var x=results[0].getAttribute("value");

                    if(x =="YES"){
                        OperationResult("This Ad has been sent to your friend successfully.");
                    }else if(x == "NO")
                    {
                        OperationResult("Email sending to friend is failed !(pls try again)");
                    }else if(x == "NV")
                    {
                        OperationResult("Your Email or Mobile has to verified to use this option");
                    }
                    else
                    {
                        OperationResult("Mail server error !");
                    }

                }
            }


        }
    }
}

function smsAdvertiserAjaxFun(itemId, qrystr){
    divId=itemId;
    var arg = qrystr+"&act=sms";
    var url = lclurl+"/irrs";

    smsAdvertiserRequest(url, arg, handlesmsAdvertiserReqResponse);
}

function smsAdvertiserRequest(url,args) {
    if(ajxVar.readyState == 4 || ajxVar.readyState== 0){
        ajxVar.open("POST", url , true);  //Opens a connection and retrieves response from the specified URL
        ajxVar.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        ajxVar.send(args); //Transmits request (can include postable string or DOM object data)
        ajxVar.onreadystatechange = handlesmsAdvertiserReqResponse; //to make sure that request is complete.
    }
}

function handlesmsAdvertiserReqResponse() {
    if (ajxVar.readyState == 4) {
        var response = ajxVar.responseXML.documentElement;
        if (response != null) {

            var results = response.getElementsByTagName('login');
            if (results != null && results.length > 0) {
                loginError("Wrong user name or password.");
            }else
            {
                results = response.getElementsByTagName('sms');
                if (results != null && results.length > 0) {
                    var fr=results[0].getAttribute("from");


                    if(fr=="NOTLOG")
                    {
                        loginChanges(results[0].getAttribute("name"))
                    }


                    var x=results[0].getAttribute("value");
                    if(x =="YES"){
                        OperationResult("Sms has been sent to Advertiser successfully.");
                    }else if(x == "NO")
                    {
                        OperationResult("Sms sending is failed !(pls try again)");
                    }else if(x == "LIMIT REACHED")
                    {
                        OperationResult("Maximum limit reached per day to send sms.");
                    }
                    else if(x == "NV")
                    {
                        OperationResult("Your Email or Mobile has to verified to use this option");
                    }
                    else
                    {
                        OperationResult("Sms server error ! (pls try again)");
                    }

                }
            }


        }
    }
}

function saveSearchAjaxFun(itemId, qrystr){
    divId=itemId;
    var arg = qrystr+"&act=search";
    var url = "irrs";

    saveSearchRequest(url, arg, handlesaveSearchReqResponse);
}

function saveSearchRequest(url,args) {
    if(ajxVar.readyState == 4 || ajxVar.readyState== 0){
        ajxVar.open("POST", url , true);  //Opens a connection and retrieves response from the specified URL
        ajxVar.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        ajxVar.send(args); //Transmits request (can include postable string or DOM object data)
        ajxVar.onreadystatechange = handlesaveSearchReqResponse; //to make sure that request is complete.
    }
}

function handlesaveSearchReqResponse() {
    if (ajxVar.readyState == 4) {
        var response = ajxVar.responseXML.documentElement;
        if (response != null) {

            var results = response.getElementsByTagName('login');
            if (results != null && results.length > 0) {
                loginError("Wrong user name or password.");
            }else
            {
                results = response.getElementsByTagName('search');
                if (results != null && results.length > 0) {
                    var fr=results[0].getAttribute("from");


                    if(fr=="NOTLOG")
                    {
                        loginChanges(results[0].getAttribute("name"))
                    }


                    var x=results[0].getAttribute("value");
                    if(x =="YES"){
                        OperationResult("This search has been saved successfully, to view saved searches <a href='mySavedSearches.do' class='link11' style='text-decoration:underline' >Click Here</a>");
                    }else if(x == "NO")
                    {
                        OperationResult("Saving search is failed! , to view saved searches <a href='mySavedSearches.do' class='link11' style='text-decoration:underline' >Click Here</a>");
                    }
                    else if(x == "LIMIT")
                    {
                        OperationResult("Save search limit (max-20) reached, to view saved searches <a href='mySavedSearches.do' class='link11' style='text-decoration:underline' >Click Here</a>");
                    }
                    else
                    {
                        OperationResult("Error in save search, to view saved searches <a href='mySavedSearches.do' class='link11' style='text-decoration:underline' >Click Here</a>");
                    }

                }
            }


        }
    }
}

function saveAlertAjaxFun(itemId, qrystr){
    divId=itemId;
    var arg = qrystr+"&act=alert";
    var url = "irrs";

    saveAlertRequest(url, arg, handlesaveAlertReqResponse);
}

function saveAlertRequest(url,args) {
    if(ajxVar.readyState == 4 || ajxVar.readyState== 0){
        ajxVar.open("POST", url , true);  //Opens a connection and retrieves response from the specified URL
        ajxVar.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        ajxVar.send(args); //Transmits request (can include postable string or DOM object data)
        ajxVar.onreadystatechange = handlesaveAlertReqResponse; //to make sure that request is complete.
    }
}

function handlesaveAlertReqResponse() {
    if (ajxVar.readyState == 4) {
        var response = ajxVar.responseXML.documentElement;
        if (response != null) {

            var results = response.getElementsByTagName('login');
            if (results != null && results.length > 0) {
                loginError("Wrong user name or password.");
            }else
            {
                results = response.getElementsByTagName('alert');
                if (results != null && results.length > 0) {
                    var fr=results[0].getAttribute("from");



                    if(fr=="NOTLOG")
                    {
                        loginChanges(results[0].getAttribute("name"))
                    }


                    var x=results[0].getAttribute("value");
                    if(x =="YES"){
                        OperationResult("This alert has been saved successfully, to view saved alerts <a href='mySavedAlerts.do' class='link11' style='text-decoration:underline' >Click Here</a>");
                    }else if(x == "NO")
                    {
                        OperationResult("Saving alert is failed! , to view saved alerts <a href='mySavedAlerts.do' class='link11' style='text-decoration:underline' >Click Here</a>");
                    }
                    else if(x == "LIMIT")
                    {
                        OperationResult("Save alert limit (max-10) reached, to view saved alerts <a href='mySavedAlerts.do' class='link11' style='text-decoration:underline' >Click Here</a>");
                    }else if(x == "INVALIDDATE"){
                        errorOperationResult("Invalid date Selection");
                    }
                    else
                    {
                        OperationResult("Error in save alert, to view saved alerts <a href='mySavedAlerts.do' class='link11' style='text-decoration:underline' >Click Here</a>");
                    }

                }
            }


        }
    }
}
/*End of inlineRequestResolve.js*/
/******************************************************************************************************************************************/
/*Start of fpAjax.js*/
var fpVar;

if (window.XMLHttpRequest) { // Non-IE browsers
    fpVar = new XMLHttpRequest();
} else if (window.ActiveXObject) { // IE
    fpVar = new ActiveXObject("Microsoft.XMLHTTP");
}
var ajxFpVar = fpVar;

function FpAjaxFun(qrystr,itemId){

    var arg ="mailId="+qrystr+"&itemId="+itemId;
    var url =lclurl+"/fps";
    sendRequestFP(url,arg, FpResponse);

}

function sendRequestFP(url,arg,FpResponse) {

    if(ajxFpVar.readyState == 4 || ajxFpVar.readyState== 0){
        ajxFpVar.open("POST", url , true);  //Opens a connection and retrieves response from the specified URL
        ajxFpVar.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        ajxFpVar.send(arg); //Transmits request (can include postable string or DOM object data)
        ajxFpVar.onreadystatechange = FpResponse; //to make sure that request is complete.
    }
}

//this method used to show the user already existed div
/*function YesReg()
{
    document.getElementById("rButton").disabled = false ;
    document.getElementById("codeTestNo").style.display = 'none' ;
}

function NoReg()
{
    document.getElementById("rButton").disabled = true ;
    document.getElementById("codeTestNo").style.display = 'inline' ;

}*/


function fpResult(value,dId)
{

    var sId="msg"+dId;
    var fpfp="fp"+dId;
    var imgId="img"+dId;
    // var cont="cont"+dId;
    // sleep(2000);
    document.getElementById(fpfp).style.display = 'none';
    document.getElementById(imgId).style.display = 'none';
    document.getElementById(sId).innerHTML=value;


}

function fpResultError(value,dId)
{

    var sId="msg"+dId;
    var fpfp="fp"+dId;
    var imgId="img"+dId;

    document.getElementById(fpfp).style.display = 'inline';
    document.getElementById(imgId).style.display = 'none';
    document.getElementById(sId).style.color ='red';
    document.getElementById(sId).innerHTML=value;

}



function FpResponse(){

    if (ajxFpVar.readyState == 4) {

        var	res = fpVar.responseXML.documentElement;
        if (res != null) {
            var results = res.getElementsByTagName('password');

            if (results != null && results.length > 0) {
                var x=results[0].getAttribute("value");


                if(x == 'SUCCESS')
                {
                    fpResult("Your new password sent to ur mail successfully. Please Check Your Mail.",results[0].getAttribute("divId"));
                }
                if(x == "NOID")
                {
                    fpResultError("Entered user id is wrong.",results[0].getAttribute("divId"));
                }
                if(x == "WRONGMOBILE")
                {
                    fpResultError("Entered Mobile Number is Wrong",results[0].getAttribute("divId"));

                }
                if(x == "ERROR")
                {
                    fpResultError("Error in processing request.",results[0].getAttribute("divId"));
                }
                if(x == "")
                {
                    fpResultError("Error in processing request.",results[0].getAttribute("divId"));
                }

            }
            else
            {
                fpResultError("Error in processing request.",results[0].getAttribute("divId"));
            }

        }
    }
}
/*End of fpAjax.js*/
/******************************************************************************************************************************************/
/*Start of fpAjax2.js*/
var fpVar1;

if (window.XMLHttpRequest) { // Non-IE browsers
    fpVar1 = new XMLHttpRequest();
} else if (window.ActiveXObject) { // IE
    fpVar1 = new ActiveXObject("Microsoft.XMLHTTP");
}
var ajxFpVar1 = fpVar1;

function ForgetPassword(qrystr,itemId){
    var arg ="mailId="+qrystr+"&itemId="+itemId;
    var url ="fps";
    document.getElementById(itemId).style.display="inline";
    sendRequestFP1(url,arg, FpResponse1);

}

function sendRequestFP1(url,arg,FpResponse1) {

    if(ajxFpVar1.readyState == 4 || ajxFpVar1.readyState== 0){
        ajxFpVar1.open("POST", url , true);  //Opens a connection and retrieves response from the specified URL
        ajxFpVar1.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        ajxFpVar1.send(arg); //Transmits request (can include postable string or DOM object data)
        ajxFpVar1.onreadystatechange = FpResponse1; //to make sure that request is complete.
    }
}

//this method used to show the user already existed div
/*function YesReg()
{
    document.getElementById("rButton").disabled = false ;
    document.getElementById("codeTestNo").style.display = 'none' ;
}

function NoReg()
{
    document.getElementById("rButton").disabled = true ;
    document.getElementById("codeTestNo").style.display = 'inline' ;

}*/


function fpResult1(value,dId)
{

    var sId="msg"+dId;
    // var fpfp="fp"+dId;
    var imgId="img"+dId;
    // var cont="cont"+dId;
    // sleep(2000);
    document.getElementById(imgId).style.display = 'none';
    document.getElementById(dId).style.display = 'inline';
    document.getElementById(sId).innerHTML=value;


}

function fpResult1Error(value,dId)
{

    var sId="msg"+dId;
    //   var fpfp="fp"+dId;
    var imgId="img"+dId;
    // var cont="cont"+dId;
    // sleep(2000);
    document.getElementById(imgId).style.display = 'none';
    document.getElementById(dId).style.display = 'inline';
    document.getElementById(sId).style.color ='red';
    document.getElementById(sId).innerHTML=value;

}



function FpResponse1(){

    if (ajxFpVar1.readyState == 4) {

        var	res = fpVar1.responseXML.documentElement;
        if (res != null) {
            var results = res.getElementsByTagName('password');

            if (results != null && results.length > 0) {
                var x=results[0].getAttribute("value");

                if(x == 'SUCCESS')
                {
                    fpResult1("your new password sent to ur mail successfully.",results[0].getAttribute("divId"));
                }
                if(x == "NOID")
                {
                    fpResult1Error("Entered user id is wrong.",results[0].getAttribute("divId"));
                }
                if(x == "WRONGMOBILE")
                {
                    fpResult1Error("Entered mobile number wrong",results[0].getAttribute("divId"));
                }
                if(x == "ERROR")
                {
                    fpResult1Error("Error in processing request.",results[0].getAttribute("divId"));
                }
                if(x == "")
                {
                    fpResult1Error("Error in processing request.",results[0].getAttribute("divId"));
                }

            }
            else
            {
                fpResult1Error("Error in processing request.",results[0].getAttribute("divId"));
            }

        }
    }
}
/*End of fpAjax2.js*/
/******************************************************************************************************************************************/
/*Start of ajx.js*/
var reqAddress;

if (window.XMLHttpRequest) { // Non-IE browsers
    reqAddress = new XMLHttpRequest();
} else if (window.ActiveXObject) { // IE
    reqAddress = new ActiveXObject("Microsoft.XMLHTTP");
}
var addressPopulateReq = reqAddress;

function getStatesR(element){
    var sbox = document.regform.country.value;
    var arg = "cn="+sbox+"&xx=state";
    var url = "gss";
    clearStatesR();
    clearCitiesR();
    clearLocR();
    sendRequestStateR(url, arg, handleHttpResponseStateR);
}


function sendRequestStateR(url,args,responceMethod) {
    if(addressPopulateReq.readyState == 4 || addressPopulateReq.readyState== 0){
        addressPopulateReq.open("POST", url , true);  //Opens a connection and retrieves response from the specified URL
        addressPopulateReq.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        addressPopulateReq.send(args); //Transmits request (can include postable string or DOM object data)
        addressPopulateReq.onreadystatechange = handleHttpResponseStateR; //to make sure that request is complete.
    }
}
function handleHttpResponseStateR(){
    if (addressPopulateReq.readyState == 4) {
        response = reqAddress.responseXML.documentElement;
        if (response != null) {

            var results = response.getElementsByTagName('state');
            if (results != null && results.length > 0) {

                for (var i = 0; i < results.length; i++) {
                    var  op =  document.createElement("OPTION");
                    op.text = results[i].getAttribute("value");
                    op.value = results[i].getAttribute("value");
                    document.regform.state.options.add(op);

                }

            }

        }
    }
}

function clearStatesR()
{
    var lb = document.regform.state;
    for (var i=lb.options.length-1; i>=0; i--){
        lb.options[i] = null;
    }
    lb.selectedIndex = 0;
}

/* code to get the cities from the when we provide states */

function getCitiesR(element)
{
    var cbox=document.regform.country.value;
    var sbox=document.regform.state.value;
    var arg = "cn="+cbox+"&st="+sbox+"&xx=city";
    var url ="gss";
    clearCitiesR();
    clearLocR();
    sendRequsetCitiesR(url, arg, hHRCR);
}
function sendRequsetCitiesR(url,args,responceMethod) {
    if(addressPopulateReq.readyState == 4 || addressPopulateReq.readyState== 0){
        addressPopulateReq.open("POST", url , true);  //Opens a connection and retrieves response from the specified URL
        addressPopulateReq.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        addressPopulateReq.send(args); //Transmits request (can include postable string or DOM object data)
        addressPopulateReq.onreadystatechange = responceMethod; //to make sure that request is complete.
    }
}
function hHRCR(){
    if (addressPopulateReq.readyState == 4) {
        response = reqAddress.responseXML.documentElement;
        if (response != null) {

            var results = response.getElementsByTagName('city');
            if (results != null && results.length > 0) {

                for (var i = 0; i < results.length; i++)
                {
                    var  op =  document.createElement("OPTION");
                    op.text = results[i].getAttribute("value");
                    op.value = results[i].getAttribute("value");
                    document.regform.city.options.add(op);
                }

            }

        }
    }
}

function clearCitiesR(){
    var lb = document.regform.city;
    for (var i=lb.options.length-1; i>=0; i--){
        lb.options[i] = null;
    }
    lb.selectedIndex = 0;
}


function getLocalitiesR(element)
{
    // var cbox=document.regform.country.value;
    //  var sbox=document.regform.state.value;
    var ctbox=document.regform.city.value;
    var arg = "ct="+ctbox+"&xx=loc";
    var url ="gss";
    clearLocR();
    sendRequsetLocR(url, arg, hHRLR);

}
function sendRequsetLocR(url,args,responceMethod) {
    if(addressPopulateReq.readyState == 4 || addressPopulateReq.readyState== 0){
        addressPopulateReq.open("POST", url , true);  //Opens a connection and retrieves response from the specified URL
        addressPopulateReq.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        addressPopulateReq.send(args); //Transmits request (can include postable string or DOM object data)
        addressPopulateReq.onreadystatechange = responceMethod; //to make sure that request is complete.
    }
}
function hHRLR(){
    if (addressPopulateReq.readyState == 4) {
        response = reqAddress.responseXML.documentElement;
        if (response != null) {

            var results = response.getElementsByTagName('locality');
            if (results != null && results.length > 0) {


                for (var i = 0; i < results.length; i++)
                {
                    var  op =  document.createElement("OPTION");
                    op.text = results[i].getAttribute("value");
                    op.value = results[i].getAttribute("value");
                    document.regform.location.options.add(op);
                }

            }
            locationDD();
        }
    }
}

function clearLocR(){
    var lb = document.regform.location;

    for (var i=lb.options.length-1; i>0; i--){
        lb.options[i] = null;
    }
//    lb.selectedIndex = 0;

}
/*End of ajx.js*/
/****************************************************************************************************************************************/
/*Start of ajaxSaveSearch.js*/
var reqSearch;


if (window.XMLHttpRequest) { // Non-IE browsers
    reqSearch = new XMLHttpRequest();
} else if (window.ActiveXObject) { // IE
    reqSearch = new ActiveXObject("Microsoft.XMLHTTP");
}
var saveSearchReq = reqSearch;

function saveThisSearch(queryString){
    var arg =queryString;
    var url = "saveSearch";
    sendSaveSearchRequest(url, arg, handleSaveSearchReqResponse);


}
function saveThisSearchwl(queryString){
    var qry2="&ln="+document.getElementById("wln").value+"&pwd="+document.getElementById("wp").value;
    var arg =queryString+qry2;
    var url = "saveSearch";
    sendSaveSearchRequest(url, arg, handleSaveSearchReqResponse);


}


function sendSaveSearchRequest(url,args) {



    if(saveSearchReq.readyState == 4 || saveSearchReq.readyState== 0){


        saveSearchReq.open("POST", url , true);  //Opens a connection and retrieves response from the specified URL

        saveSearchReq.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');

        saveSearchReq.send(args); //Transmits request (can include postable string or DOM object data)

        //showGif(true);

        saveSearchReq.onreadystatechange = handleSaveSearchReqResponse; //to make sure that request is complete.

    }
}

//this method used to show the user already existed div
function showNotSaveDiv()
{
    document.getElementById("notSave").style.display = 'inline' ;
    document.getElementById("save").style.display = 'none' ;
}
function showSaveDiv()
{
    document.getElementById("save").style.display = 'inline' ;
    document.getElementById("notSave").style.display = 'none' ;
}
function ssNo(name)
{
    document.getElementById("lbx").style.display='none';
    document.getElementById("notSave").style.display = 'inline' ;
    document.getElementById("save").style.display = 'none' ;

    document.getElementById("dr").innerHTML="Logout";
    document.getElementById("myAccount").setAttribute("href", "my_ads_details.do")
    document.getElementById("login").setAttribute("href", "logout.do")
//   document.getElementById("guest").style.display = 'none';
//   document.getElementById("guest1").innerHTML=name;
}
function ssYes(name)
{

    document.getElementById("lbx").style.display='none';
    document.getElementById("save").style.display = 'inline' ;
    document.getElementById("notSave").style.display = 'none' ;

    document.getElementById("dr").innerHTML="Logout";
    document.getElementById("myAccount").setAttribute("href", "my_ads_details.do")
    document.getElementById("login").setAttribute("href", "logout.do")
//   document.getElementById("guest").style.display = 'none';
//   document.getElementById("guest1").innerHTML=name;
}
function ssError()
{
    document.getElementById("notSave").style.display = 'inline' ;
    document.getElementById("save").style.display = 'none' ;
    document.getElementById("notSave").innerHTML='Login Error';

}

function handleSaveSearchReqResponse() {



    if (saveSearchReq.readyState == 4) {
        response = reqSearch.responseXML.documentElement;
        if (response != null) {
            var results = response.getElementsByTagName('save');
            if (results != null && results.length > 0) {


                var x=results[0].getAttribute("value");

                if(x =="NO"){
                    showNotSaveDiv();
                }else if(x== "YES"){
                    showSaveDiv();
                }else if(x=="SSNO") {
                    ssNo(results[0].getAttribute("uname"));
                }else if(x=="SSYES"){
                    alert(results[0].getAttribute("uname"));
                    ssYes(results[0].getAttribute("uname"));
                }else if(x=="SSERROR"){
                    ssError();
                }


            }

        }
    }

}
/*End of ajaxSaveSearch.js*/
/***********************************************************************************************************************************/
/*Start of ajax.js*/
var req;

if (window.XMLHttpRequest) { // Non-IE browsers
    req = new XMLHttpRequest();
} else if (window.ActiveXObject) { // IE
    req = new ActiveXObject("Microsoft.XMLHTTP");
}
var http = req;




function sendRequest(url,args,responceMethod) {
    if(http.readyState == 4 || http.readyState== 0){
        http.open("POST", url , true);  //Opens a connection and retrieves response from the specified URL
        http.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        http.send(args); //Transmits request (can include postable string or DOM object data)
        http.onreadystatechange = responceMethod; //to make sure that request is complete.
    }
}

function clear(lb){
    for (var i=lb.options.length-1; i>=0; i--){
        lb.options[i] = null;
    }
    lb.selectedIndex = -1;
    document.getElementById("priceJsp").innerHTML="";
    document.getElementById("slCtgJsp").innerHTML="";
}


function handleHttpResponse(){

    if (http.readyState == 4) {
        response = req.responseXML.documentElement;
        if (response != null) {
            var results = response.getElementsByTagName('cat');
            if (results != null && results.length > 0) {
                var lb= document.getElementById("select2");
                clear(lb);
                var llb= document.getElementById("select3");
                clear(llb);
                var selopt=new Option("Select Sub-Category", "0");
                lb.options.add(selopt);
                var selopt1=new Option("Select Classification", "0");
                llb.options.add(selopt1);
                for (var i = 0; i < results.length; i++) {
                    options=new Option(results[i].getAttribute("name"), results[i].getAttribute("id"));
                    lb.options.add(options);
                }
            }
        }
    }
    document.getElementById("lding").style.display="none";
}

function handleHttpResponse1(){

    if (http.readyState == 4) {
        response = req.responseXML.documentElement;
        if (response != null) {
            var results = response.getElementsByTagName('cat');
            if (results != null && results.length > 0) {
                var lb= document.getElementById("select3");

                clear(lb);
                var postAd;
                var selopt=new Option("Select Classification", "0");
                lb.options.add(selopt);
                for (var i = 0; i < results.length; i++) {
                    options=new Option(results[i].getAttribute("name"), results[i].getAttribute("id"));
                    lb.options.add(options);

                /*   postAd= results[i].getAttribute("postAd");
                    if(postAd != null && postAd.toString().value == '1')
                    {
                        document.getElementById("button").disabled = false;
                    }
                    else if(postAd != null && postAd.toString().value == '0')
                    {
                        document.getElementById("button").disabled = true;
                    }*/
                }
            }
        }
    }
    document.getElementById("lding").style.display="none";
}

function callme(element){

    var url = 'ajs';
    var args = 'ci='+element.value;
    var clr= document.getElementById("select3");
    var clr2= document.getElementById("select2");
    clear(clr);
    clear(clr2);
    document.getElementById("lding").style.display="inline";
    sendRequest(url,args,handleHttpResponse);

//    toggle_disable('buttonDis','button');
}


function callme1(element){
    var url = 'ajs';
    var args = 'ci='+element.value;
    var clr= document.getElementById("select3");
    clear(clr);
    document.getElementById("lding").style.display="inline";
    sendRequest(url,args,handleHttpResponse1);
//    toggle_disable('buttonDis','button');

}
/*end of ajax.js*/
/***************************************************************************************************************************************/
/*Start of addressPopulateAjax.js*/

function getStates(element){
    var sbox = document.ad.country.value;
    var arg = "cn="+sbox+"&xx=state";
    var url = "gss";
    sendRequestState(url, arg, handleHttpResponseState);
}

function sendRequestState(url,args,responceMethod) {
    if(http.readyState == 4 || http.readyState== 0){
        http.open("POST", url , true);  //Opens a connection and retrieves response from the specified URL
        http.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        http.send(args); //Transmits request (can include postable string or DOM object data)
        http.onreadystatechange = handleHttpResponseState; //to make sure that request is complete.
    }
}
function handleHttpResponseState(){
    if (http.readyState == 4) {
        response = req.responseXML.documentElement;
        if (response != null) {
            //visible("sri", "hidden");
            var results = response.getElementsByTagName('state');
            if (results != null && results.length > 0) {
                clearStates1();
                clearCities();
                clearLoc();
                for (var i = 0; i < results.length; i++) {
                    //addDiv( results[i].getAttribute("value"));
                    //var op = new OPTION(results[i].getAttribute("value"),results[i].getAttribute("value"));
                    var  op =  document.createElement("OPTION");
                    op.text = results[i].getAttribute("value");
                    op.value = results[i].getAttribute("value");
                    document.ad.state.options.add(op);
                }
            //visible("sri", "visible");
            }

        }
    }
}

function clearStates1()
{
    var element = document.ad.state;
    element.options.length=1;
}

/* code to get the cities from the when we provide states */

function getCities(element)
{
    var cbox=document.ad.country.value;
    var sbox=document.ad.state.value;
    var arg = "cn="+cbox+"&st="+sbox+"&xx=city";
    var url ="gss";
    sendRequsetCities(url, arg, hHRC);
}
function sendRequsetCities(url,args,responceMethod) {
    if(http.readyState == 4 || http.readyState== 0){
        http.open("POST", url , true);  //Opens a connection and retrieves response from the specified URL
        http.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        http.send(args); //Transmits request (can include postable string or DOM object data)
        http.onreadystatechange = responceMethod; //to make sure that request is complete.
    }
}
function hHRC(){
    if (http.readyState == 4) {
        response = req.responseXML.documentElement;
        if (response != null) {
            //visible("sri", "hidden");
            var results = response.getElementsByTagName('city');
            if (results != null && results.length > 0) {
                //clearDivs("sri",0);
                clearCities();
                clearLoc();

                for (var i = 0; i < results.length; i++)
                {
                    var  op =  document.createElement("OPTION");
                    op.text = results[i].getAttribute("value");
                    op.value = results[i].getAttribute("value");
                    document.ad.city.options.add(op);
                }
            //visible("sri", "visible");
            }

        }
    }
}

function clearCities(){
    var element = document.ad.city;
    element.options.length=1;
}

/* THis code for to get localities    */
function getLocalities(element)
{
    //    var cbox=document.ad.country.value;
    //    var sbox=document.ad.state.value;
    var ctbox=document.ad.city.value;
    var arg = "ct="+ctbox+"&xx=loc";
    var url ="gss";
    clearLoc();
    sendRequsetLoc(url, arg, hHRL);

}
function sendRequsetLoc(url,args,responceMethod) {
    if(http.readyState == 4 || http.readyState== 0){
        http.open("POST", url , true);  //Opens a connection and retrieves response from the specified URL
        http.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        http.send(args); //Transmits request (can include postable string or DOM object data)
        http.onreadystatechange = responceMethod; //to make sure that request is complete.
    }
}
function hHRL(){
    if (http.readyState == 4) {
        response = req.responseXML.documentElement;
        if (response != null) {
            //visible("sri", "hidden");
            var results = response.getElementsByTagName('locality');
            if (results != null && results.length > 0) {


                for (var i = 0; i < results.length; i++)
                {
                    var  op =  document.createElement("OPTION");
                    op.text = results[i].getAttribute("value");
                    op.value = results[i].getAttribute("value");
                    document.ad.locality.options.add(op);
                }
            //visible("sri", "visible");
            }

        }
    }
}

function clearLoc(){
    var element = document.ad.locality;
    if(element != null){
        for (var i=element.options.length-1; i>0; i--){
            element.options[i] = null;
        }

    //                element.selectedIndex = 0;
    //        element.options.length=1;
    }
}
/*End of addressPopulateAjax.js*/
/*********************************************************************************************************************************/
/*Start of utilAjax.js*/
var utilAjaxvar;

if (window.XMLHttpRequest) { // Non-IE browsers
    utilAjaxvar = new XMLHttpRequest();
} else if (window.ActiveXObject) { // IE
    utilAjaxvar = new ActiveXObject("Microsoft.XMLHTTP");
}
var utilVar = utilAjaxvar;

function RecentSearch(){
    document.getElementById("recent1").style.display = "none";
    document.getElementById("recent2").style.display = "none";
    var arg ="action=recentSearch";
    var url ="uas";
    sendRequestUtil(url,arg, UtilResponse);

}
function getMVC(itemId)
{

    var mobileRegex= /^([98]{1})([0123456789]{1})([0-9]{8})$/;
    if(itemId.match(mobileRegex))
    {

        var arg="action=mvCode&mn="+itemId;
        var url="uas";
        sendRequestUtil(url,arg, UtilResponse);
    }

}
function getEVC()
{
    var arg="action=emailVerification";
    var url="uas";
    sendRequestUtil(url,arg, UtilResponse);
}
function verMVC(itemId)
{
    if(itemId != null && itemId != '')
    {
        var arg="action=mvCodeCheck&entercode="+itemId;
        var url="uas";
        sendRequestUtil(url,arg, UtilResponse);
    }
}
function disCodeDiv()
{
    // document.getElementById("mvcdiv").style.display = 'inline';
    document.getElementById("loadingBar").style.display = 'none';
    document.getElementById("smsconifrm").innerHTML = 'Verification code sent to ur mobile successfully.';
//    document.getElementById("smsPopupDiv2").style.display = 'inline';
}
function successMR()
{
    document.getElementById("loadingBar").style.display = 'none';
    document.getElementById("mvcmsg").style.display = 'none';
    document.getElementById("smsconifrm2").innerHTML = 'Your Mobile verification completed successfully';
}
function failMR()
{
    document.getElementById("loadingBar").style.display = 'none';
    document.getElementById("smsconifrm2").innerHTML = 'Mobile verification code error';

}
function evCodeSentSuccess()
{
    document.getElementById("loadingBar").style.display = 'none';
    document.getElementById("smsconifrm2").innerHTML = 'Mail sent to your email address successfully';

}
function evCodeSentWrong()
{
    document.getElementById("loadingBar").style.display = 'none';
    document.getElementById("smsconifrm2").innerHTML = 'Error occured while resend Email Verification code.';
}
function sendRequestUtil(url,arg,UtilResponse) {

    if(utilVar.readyState == 4 || utilVar.readyState== 0){
        utilVar.open("POST", url , true);  //Opens a connection and retrieves response from the specified URL
        utilVar.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        utilVar.send(arg); //Transmits request (can include postable string or DOM object data)
        utilVar.onreadystatechange = UtilResponse; //to make sure that request is complete.
    }
}

function UtilResponse(){
    if (utilVar.readyState == 4) {
        var res = utilAjaxvar.responseXML.documentElement;
        if (res != null) {
            var results = res.getElementsByTagName('util');
            if (results != null && results.length > 0) {
                var x=results[0].getAttribute("value");
                if(x == 'OK')
                {
                    document.getElementById("recentS").style.display = 'none';
                }
                if(x == 'CODESENT' )
                {
                    disCodeDiv();
                }
                if(x == 'CODECORRET')
                {
                    successMR();
                }
                if(x == 'CODEWRONG')
                {
                    failMR();
                }
                if( x == 'EMAILSENT')
                {
                    evCodeSentSuccess();
                }
                if( x == 'EMAILSENTWRONG')
                {
                    evCodeSentWrong();
                }
            }

        }

    }

}
/*End of utilAjax.js*/
/***************************************************************************************************************************************/



var reqpost;
if (window.XMLHttpRequest) { // Non-IE browsers
    reqpost = new XMLHttpRequest();
} else if (window.ActiveXObject) { // IE
    reqpost = new ActiveXObject("Microsoft.XMLHTTP");
}
var httppost=reqpost;
/* THis code for to get localities    */
function getTileJsps(id)
{
    //    var cbox=document.ad.country.value;
    //    var sbox=document.ad.state.value;
    var arg = "clfId="+id;
    var url ="jps";
    sendRequsetTileJsps(url, arg, handleTileJsps);

}
function sendRequsetTileJsps(url,args,responceMethod) {
    if(httppost.readyState == 4 || httppost.readyState== 0){
        httppost.open("POST", url , true);  //Opens a connection and retrieves response from the specified URL
        httppost.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        httppost.send(args); //Transmits request (can include postable string or DOM object data)
        httppost.onreadystatechange = responceMethod; //to make sure that request is complete.
    }
}
function handleTileJsps(){
    if (httppost.readyState == 4) {
        var resp = reqpost.responseText;
        if (resp != null) {
            resp=resp.replace(/<table /g,'<table cellspacing="10px" ');// For adding cellspacing to table
            if(resp.indexOf("^^^price^^^", 0)>=0) {
                var prjsp=resp.substr(resp.indexOf("^^^price^^^", 0)+11, resp.length);
                document.getElementById("priceJsp").innerHTML=prjsp;
                resp=resp.substr(0,resp.indexOf("^^^price^^^", 0));
            }
            document.getElementById("slCtgJsp").innerHTML=resp;
        }
    }
}

var reqForMobCh;

if (window.XMLHttpRequest) { // Non-IE browsers
    reqForMobCh = new XMLHttpRequest();
} else if (window.ActiveXObject) { // IE
    reqForMobCh = new ActiveXObject("Microsoft.XMLHTTP");
}
var mobileChange = reqForMobCh;

function mobAjax(vl){
    var mch = document.getElementById("mobile").value;
    var arg = "action=mobileChange&mobId="+mch+"&value="+vl;
    var url = "uas";
    //    var clr= document.getElementById("mobile");
    document.getElementById("lding").style.display="inline";

    sendMobileChangeRequest(url,arg,mobileChangeResponse);

}

function verCode(){
    var vcode = document.getElementById("verCode").value;
    var mch = document.getElementById("mobile").value;
    var arg = "action=codeVer&mobId="+mch+"&mobCode="+vcode;
    var url = "uas";

    sendCodeVerificationRequest(url,arg,codeVerificationResponse);
}

function sendMobileChangeRequest(url,args){

    if(mobileChange.readyState == 4 || mobileChange.readyState== 0){

        mobileChange.open("POST", url , true);
        mobileChange.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        mobileChange.send(args);
        mobileChange.onreadystatechange = mobileChangeResponse;
    }
}

function mobileChangeResponse(){
    if (mobileChange.readyState == 4) {
        var mob = reqForMobCh.responseXML.documentElement;
        if(mob != null){
            var results = mob.getElementsByTagName('util');
            if (results != null && results.length > 0) {
                var x=results[0].getAttribute("value");
                var y=results[0].getAttribute("number");
                if(x == "true" && y == "0"){
                    document.getElementById("sentMobT").style.display = 'block';
                    document.getElementById("chgMob").style.display = 'none';
                }else if(x == "false" && y == "0"){
                    document.getElementById("sentMobF").style.display = 'block';
                }else if(x == "true" && y == "1"){
                    document.getElementById("sentMobT").style.display = 'block';
                    document.getElementById("mobChangeT").innerHTML = 'Resend mobile code is successfull.';
                }else if(x == "false" && y == "1"){
                    document.getElementById("sentMobT").style.display = 'block';
                    document.getElementById("mobChangeF").innerHTML = 'Resend mobile code is failure.';
                }
            }
        }
    }
    document.getElementById("lding").style.display="none";
}


function sendCodeVerificationRequest(url,args){

    if(mobileChange.readyState == 4 || mobileChange.readyState== 0){

        mobileChange.open("POST", url , true);
        mobileChange.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        mobileChange.send(args);
        mobileChange.onreadystatechange = codeVerificationResponse;
    }
}

function codeVerificationResponse(){
    if (mobileChange.readyState == 4) {
        var mob = reqForMobCh.responseXML.documentElement;
        if(mob != null){
            var results = mob.getElementsByTagName('util');
            if (results != null && results.length > 0) {
                var x=results[0].getAttribute("value");
                if(x == "true"){
                    window.location = "myAccount_EditMyProfile.do";
                    document.getElementById("mobChangeT").innerHTML = 'Verification code is success.';
                }else if(x == "false"){
                    document.getElementById("mobChangeF").innerHTML = 'Verification code is wrong.';
                }else if(x == "error"){
                    document.getElementById("mobChangeF").innerHTML = 'Error is occurred.';
                }
            }
        }
    }
}


/// User Lead Js

var reqUserLead;
if (window.XMLHttpRequest) { // Non-IE browsers
    reqUserLead = new XMLHttpRequest();
} else if (window.ActiveXObject) { // IE
    reqUserLead = new ActiveXObject("Microsoft.XMLHTTP");
}
var httpUserLead=reqUserLead;

function sendUserLead(nm,des,mobNum,email,city,cat,dlrId,url) {
    document.getElementById("ulMsg").innerHTML="";
    document.getElementById("ulvc").value="";
    var arg = "task=1&nm="+nm+"&mobNum="+mobNum+"&email="+email+"&des="+des+"&cit="+city+"&catg="+cat+"&dlrId="+dlrId;
    sendRequestUserLead(url, arg, handleUserLead);
}

function sendRequestUserLead(url,args,responseMethod) {
    if(httpUserLead.readyState == 4 || httpUserLead.readyState== 0){
        httpUserLead.open("POST", url , true);  //Opens a connection and retrieves response from the specified URL
        httpUserLead.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        httpUserLead.send(args); //Transmits request (can include postable string or DOM object data)
        httpUserLead.onreadystatechange = responseMethod; //to make sure that request is complete.
    }
}

function handleUserLead(){
    if (httpUserLead.readyState == 4) {
        var resp = reqUserLead.responseXML.documentElement;
        if (resp != null) {
            var results = resp.getElementsByTagName('res');
            if (results != null && results.length > 0) {
                var rs = results[0].getAttribute("resStatus");
                if(rs=="success") {
                    document.getElementById("ulVerCode").style.display="inline";
                } else if(rs=="verSuccess") {
                    document.getElementById("ulVerMsg").innerHTML="<span style='color:green'>Request Sent Successfully</span>";
                } else if(rs=="limitExceeded") {
                    document.getElementById("ulMsg").innerHTML="<span style='color:red'>Max. 5 requests only</span>";
                } else {
                    document.getElementById("ulMsg").innerHTML="<span style='color:red'>Error Occurred</span>";
                }
            }
        }
    }
}

var reqVerUserLead;
if (window.XMLHttpRequest) { // Non-IE browsers
    reqVerUserLead = new XMLHttpRequest();
} else if (window.ActiveXObject) { // IE
    reqVerUserLead = new ActiveXObject("Microsoft.XMLHTTP");
}
var httpVerUserLead=reqVerUserLead;

function verifyUserLead(elm,url) {
    if(elm.value=="") {
        alert("Please Enter Code");
        return false;
    }
    document.getElementById("dfltVerMsg").style.display="none";
    document.getElementById("ulVerMsg").innerHTML="";
    var arg = "task=2&code="+elm.value;
    sendRequestVerUserLead(url, arg, handleVerUserLead);
}

function sendRequestVerUserLead(url,args,responseMethod) {
    if(httpVerUserLead.readyState == 4 || httpVerUserLead.readyState== 0){
        httpVerUserLead.open("POST", url , true);  //Opens a connection and retrieves response from the specified URL
        httpVerUserLead.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        httpVerUserLead.send(args); //Transmits request (can include postable string or DOM object data)
        httpVerUserLead.onreadystatechange = responseMethod; //to make sure that request is complete.
    }
}

function handleVerUserLead(){
    if (httpVerUserLead.readyState == 4) {
        var resp = reqVerUserLead.responseXML.documentElement;
        if (resp != null) {
            var results = resp.getElementsByTagName('res');
            if (results != null && results.length > 0) {
                var rs = results[0].getAttribute("resStatus");
                if(rs=="success") {
                    document.getElementById("ulVerCode").style.display="none";
                    document.getElementById("ulVerMsg").innerHTML="<span style='color:green'>Request Sent Successfully.We will get back you as soon as possible.</span>";
                } else {
                    document.getElementById("ulVerMsg").innerHTML="<span style='color:red'>Enter Verification Code is Wrong. Please Try Again.</span>";
                }
            }
        }
    }
}

var viewContactVar;

if (window.XMLHttpRequest) { // Non-IE browsers
    viewContactVar = new XMLHttpRequest();
} else if (window.ActiveXObject) { // IE
    viewContactVar = new ActiveXObject("Microsoft.XMLHTTP");
}
var vcVar = viewContactVar;

function viewContactAjaxFun(itemId,qrystr){
    divId=itemId;
    var arg = qrystr+"&act=view";
    var url = lclurl+"/irrs";
    sendRequestViewContact(url,arg, ViewContactResponse);

}

function sendRequestViewContact(url,arg,ViewContactResponse) {

    if(vcVar.readyState == 4 || vcVar.readyState== 0){

        vcVar.open("POST", url , true);
        vcVar.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        vcVar.send(arg);
        vcVar.onreadystatechange = ViewContactResponse;

    }
}

function ViewContactResponse(){

    if (vcVar.readyState == 4) {

        var res = vcVar.responseXML.documentElement;

        if (res != null) {
            var results = res.getElementsByTagName('login');
            if (results != null && results.length > 0) {
                loginError("Wrong user name or password.");
            }else {
                results = res.getElementsByTagName('viewCon');
                if (results != null && results.length > 0) {
                    var fr=results[0].getAttribute("from");

                    if(fr=="NOTLOG"||fr=="REG")
                    {
                        loginChanges(results[0].getAttribute("name"))
                        $.modal.close();
                    }

                    var x=results[0].getAttribute("value");
                    if(x =="YES"){
                        document.getElementById('viewConBtn').style.display='none';
                        var cntdtl=document.getElementById('cntdtl');
                        if(cntdtl.style.display=='none')
                        {
                            cntdtl.style.display='inline';
                        }
                    //                        if(fr=="NOTLOG")
                    //                        {
                    //                            document.getElementById("load"+divId).style.display = 'none';
                    //                            //toggle_close_it(divId);
                    //                        } else if(fr == "REG") {
                    //                            divId="nu"+divId.substr(4, divId.length-6);
                    //                            //toggle_close_it(divId);
                    //                        }
                    } else
{
                        errorOperationResult("Error occurred");
                    }

                }
            }
        }
    }
}


//Karteek's Starts

function micrositeViewAjaxFun(itemId){
    divId=itemId;
    var arg = qrystr+"&act=msView";
    var url = lclurl+"/irrs";
    sendRequestMsView(url,arg);

}
function sendRequestMsView(url,arg) {

    if(vcVar.readyState == 4 || vcVar.readyState== 0){

        vcVar.open("POST", url , true);
        vcVar.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        vcVar.send(arg);
    }
}

//Karteek's End