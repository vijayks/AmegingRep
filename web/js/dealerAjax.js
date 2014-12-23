/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
var reqForUserIdDlr;


if (window.XMLHttpRequest) { // Non-IE browsers
    reqForUserIdDlr = new XMLHttpRequest();
} else if (window.ActiveXObject) { // IE
    reqForUserIdDlr = new ActiveXObject("Microsoft.XMLHTTP");
}

var ajxVar = reqForUserIdDlr;
var divId;

function SaveToMobileDlrAjaxFun(itemId,qrystr,url){
    divId=itemId;
    var arg = qrystr+"&act=save";
    sendRequestSaveToMobile(url,arg, SaveToMobileResponse);

}



function sendRequestSaveToMobile(url,arg,SaveToMobileResponse) {

    if(ajxVar.readyState == 4 || ajxVar.readyState== 0){


        ajxVar.open("POST", url , true);  //Opens a connection and retrieves response from the specified URL

        ajxVar.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');

        ajxVar.send(arg); //Transmits request (can include postable string or DOM object data)


        ajxVar.onreadystatechange = SaveToMobileResponse; //to make sure that request is complete.

    }
}


function sleep(ms)
{
    var dt = new Date();
    dt.setTime(dt.getTime() + ms);
    while (new Date().getTime() < dt.getTime()){}
}

function loginChangesDlr(name)
{
    R=1;
    document.getElementById("dr").innerHTML="Logout";
    document.getElementById("myAccount").setAttribute("href", "my_ads_details.do")
    document.getElementById("login").setAttribute("href", "logout.do")
    document.getElementById("guest").style.display = 'none';
    document.getElementById("guest1").innerHTML=name;
}

function loginErrorDlr(value)
{
    document.getElementById("load"+divId).style.display = 'none';// to make the loading image none
    document.getElementById("form"+divId).style.display="inline";//to show the form again with error msg
    document.getElementById("msg"+divId).style.color="red";// style of color to red
    document.getElementById("msg"+divId).innerHTML=value;


}


function OperationResultDlr(value)
{

    document.getElementById("load"+divId).style.display = 'none';// to make the loading image none
    document.getElementById("msg"+divId).style.color="#046DBE";//make the color of msg to normal

    document.getElementById("msg"+divId).innerHTML=value;

}
function errorOperationResultDlr(value)
{
  document.getElementById("load"+divId).style.display = 'none';// to make the loading image none
  document.getElementById("msg"+divId).style.color="#f00";//make the color of msg to normal
  document.getElementById("form"+divId).style.display="inline";
  document.getElementById("msg"+divId).innerHTML=value;
}



function SaveToMobileResponse(){

    if (ajxVar.readyState == 4) {

        var	res = ajxVar.responseXML.documentElement;

        if (res != null) {

            var results = res.getElementsByTagName('login');
            if (results != null && results.length > 0) {
                loginErrorDlr("Wrong user name or password.");
            }else
            {
                results = res.getElementsByTagName('sms');
                if (results != null && results.length > 0) {
                    var fr=results[0].getAttribute("from");


                    if(fr=="NOTLOG")
                    {
                        loginChangesDlr(results[0].getAttribute("name"))
                    }

                    //document.getElementById("cont"+divId).style.display = 'inline';
                    var x=results[0].getAttribute("value");
                    if(x =="YES"){
                        OperationResultDlr("Details successfully sent to mobile");
                    }
                    else if(x == "NO")
                    {
                        OperationResultDlr("Sms sending is failed !(pls try again)");
                    }
                    else if(x == "LIMIT REACHED")
                    {
                        OperationResultDlr("Maximum limit reached per day to send sms.");
                    }
                    else if(x == "NV")
                    {
                        OperationResultDlr("Your Email or Mobile has to verified to use this option");
                    }
                    else
                    {
                        OperationResultDlr("Sms server error ! (pls try again)");
                    }

                }
            }
        }

    }
}


function sendToFriendDlrAjaxFun(itemId, qrystr){
    divId=itemId;
    var arg = qrystr+"&act=email";
    var url = "irrsdl";

    SendToFriendDlrRequest(url, arg, handleSendToFriendDlrReqResponse);
}

function SendToFriendDlrRequest(url,args) {
    if(ajxVar.readyState == 4 || ajxVar.readyState== 0){
        ajxVar.open("POST", url , true);  //Opens a connection and retrieves response from the specified URL
        ajxVar.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        ajxVar.send(args); //Transmits request (can include postable string or DOM object data)
        ajxVar.onreadystatechange = handleSendToFriendDlrReqResponse; //to make sure that request is complete.
    }
}

function handleSendToFriendDlrReqResponse() {
    if (ajxVar.readyState == 4) {
        var response = ajxVar.responseXML.documentElement;
        if (response != null) {

            var results = response.getElementsByTagName('login');
            if (results != null && results.length > 0) {
                loginErrorDlr("Wrong user name or password.");
            }else
            {
                results = response.getElementsByTagName('email');
                if (results != null && results.length > 0) {
                    var fr=results[0].getAttribute("from");

                    if(fr=="NOTLOG")
                    {
                        loginChangesDlr(results[0].getAttribute("name"))
                    }

                    var x=results[0].getAttribute("value");

                    if(x =="YES"){
                        OperationResultDlr("This Dealer details has been sent to your friend successfully.");
                    }
                    else if(x == "NO")
                    {
                        OperationResultDlr("Email sending to friend is failed !(pls try again)");
                    }
                    else if(x == "NV")
                    {
                        OperationResultDlr("Your Email or Mobile has to verified to use this option");
                    }
                    else
                    {
                        OperationResultDlr("Mail server error !");
                    }

                }
            }


        }
    }
}

function contactDlrAjaxFun(itemId, qrystr){
    divId=itemId;
    var arg = qrystr+"&act=contact";
    var url = "irrsdl";

    contactDlrRequest(url, arg, handleContactDlrReqResponse);
}

function contactDlrRequest(url,args) {
    if(ajxVar.readyState == 4 || ajxVar.readyState== 0){
        ajxVar.open("POST", url , true);  //Opens a connection and retrieves response from the specified URL
        ajxVar.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        ajxVar.send(args); //Transmits request (can include postable string or DOM object data)
        ajxVar.onreadystatechange = handleContactDlrReqResponse; //to make sure that request is complete.
    }
}

function handleContactDlrReqResponse() {
    if (ajxVar.readyState == 4) {
        var response = ajxVar.responseXML.documentElement;
        if (response != null) {

            var results = response.getElementsByTagName('login');
            if (results != null && results.length > 0) {
                loginErrorDlr("Wrong user name or password.");
            }else
            {
                results = response.getElementsByTagName('sms');
                if (results != null && results.length > 0) {
                    var fr=results[0].getAttribute("from");


                    if(fr=="NOTLOG")
                    {
                        loginChangesDlr(results[0].getAttribute("name"))
                    }


                    var x=results[0].getAttribute("value");
                    if(x =="YES"){
                        OperationResultDlr("Sms has been sent to Dealer successfully.");
                    }
                    else if(x == "NO")
                    {
                        OperationResultDlr("Sms sending is failed !(pls try again)");
                    }
                    else if(x == "LIMIT REACHED")
                    {
                        OperationResultDlr("Maximum limit reached per day to send sms.");
                    }
                    else if(x == "NV")
                    {
                        OperationResultDlr("Your Email or Mobile has to verified to use this option");
                    }
                    else
                    {
                        OperationResultDlr("Sms server error ! (pls try again)");
                    }

                }
            }
        }
    }
}

//------Getting subcategories of a particular dealer category--------
    var wsxmlhttp;
    if (window.XMLHttpRequest)
    {
        // code for IE7+, Firefox, Chrome, Opera, Safari
        wsxmlhttp=new XMLHttpRequest();
    }
    else if (window.ActiveXObject)
    {
        // code for IE6, IE5
        wsxmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
    }
    else
    {
        alert("Your browser does not support XMLHTTP!");
    }
    var wshttp=wsxmlhttp;

    function getSubCategories(element){

        var url = 'wss';
        var args = 'ci='+element.value;
        sendSubCatRequest(url,args,handleSubCatHttpResponse);
    }
    function sendSubCatRequest(url,args,responceMethod) {
        if(wshttp.readyState == 4 || wshttp.readyState== 0){
            wshttp.open("POST", url , true);  //Opens a connection and retrieves response from the specified URL
            wshttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
            wshttp.send(args); //Transmits request (can include postable string or DOM object data)
            wshttp.onreadystatechange = responceMethod; //to make sure that request is complete.
        }
    }

    function clear(lb){
        for (var i=lb.options.length-1; i>=0; i--){
            lb.options[i] = null;
        }
        lb.selectedIndex = -1;

    }

    function handleSubCatHttpResponse(){


        if (wshttp.readyState == 4) {
            response = wsxmlhttp.responseXML.documentElement;

            if (response != null) {
                var results = response.getElementsByTagName('cat');
                if (results != null && results.length > 0) {
                    formObj = document.getElementsByName("getSubCat");
                    var lb= document.getSubCat.subcat;
                    clear(lb);
                    //                var llb= document.getSubCat.classcat;
                    //                clear(llb);
                    for (var i = 0; i < results.length; i++) {
                        options=new Option(results[i].getAttribute("name"), results[i].getAttribute("name")+'@'+results[i].getAttribute("id"));
                        lb.options.add(options);
                    }
                }
            }
        }
    }

