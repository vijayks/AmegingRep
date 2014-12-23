
var reqForBid;


if (window.XMLHttpRequest) { // Non-IE browsers
    reqForBid = new XMLHttpRequest();
} else if (window.ActiveXObject) { // IE
    reqForBid = new ActiveXObject("Microsoft.XMLHTTP");
}
var userBid = reqForBid;

function bidIt(id,name,price,bidId){

    var arg = "uid="+id+"&unm="+name+"&pr="+price+"&bidId="+bidId+"&frm=bid";
    var url = "bid";
    sendBidRequest(url, arg, handleBidReqResponse);
    putBidMsg(bidId,"Please wait ...","red");

}

function sendBidRequest(url,args) {



    if(userBid.readyState == 4 || userBid.readyState== 0){


        userBid.open("POST", url , true);  //Opens a connection and retrieves response from the specified URL

        userBid.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');

        userBid.send(args); //Transmits request (can include postable string or DOM object data)

        //showGif(true);

        userBid.onreadystatechange = handleBidReqResponse; //to make sure that request is complete.

    }
}

function handleBidReqResponse() {



    if (userBid.readyState == 4) {



        response = reqForBid.responseXML.documentElement;


        if (response != null) {
            //        showGif(false);
            var results = response.getElementsByTagName('check');


            if (results != null && results.length > 0) {

                var x=results[0].getAttribute("value");
                var y=results[0].getAttribute("name");
                var bi = results[0].getAttribute("bidid");
                var status=results[0].getAttribute("status");
                var lmt = results[0].getAttribute("bidrange");
                document.getElementById("bidpr"+bi).value="";
                if(status == "ok"){
                    document.getElementById("bprice"+bi).style.backgroundColor="#90ee90";
                    document.getElementById("bprice"+bi).innerHTML="";
                    document.getElementById("bprice"+bi).innerHTML=x;
                    document.getElementById("buName"+bi).innerHTML="";
                    document.getElementById("buName"+bi).innerHTML=y;
                    if(!(lmt!="" || lmt!=null || lmt!="null")){
                        document.getElementById("bidLm"+bi).innerHTML="";
                        document.getElementById("bidLm"+bi).innerHTML=lmt;
                    }
                    putBidMsg(bi,"Bidded Successfully","green");
                }else if(status == "wrong Bid"){
                    putBidMsg(bi,x,"red");
                }else{
                    alert("Error occured while bidding");
                }


            }

        }
    }

}

function putBidMsg(id,msg,colr){
    document.getElementById("bidMsg"+id).innerHTML="";
    document.getElementById("bidMsg"+id).style.color=colr;
    document.getElementById("bidMsg"+id).innerHTML=msg;
}

/********************************************************************************************************************************************/

var reqBidRef;
if (window.XMLHttpRequest) { // Non-IE browsers
    reqBidRef = new XMLHttpRequest();
} else if (window.ActiveXObject) { // IE
    reqBidRef = new ActiveXObject("Microsoft.XMLHTTP");
}
var bidRefresh = reqBidRef;
var refCn=1;
function callBidRefresh(){
    var arg = "bidId=0";
    var url = "bidref";
    sendBidRefreshReq(url, arg, BidRefreshRes);

}
function callSingleBidRefresh(bidId){
    var arg = "bidId="+bidId;
    var url = "bidref";
    sendBidRefreshReq(url, arg, BidRefreshRes);

}

function sendBidRefreshReq(url,args) {

    if(bidRefresh.readyState == 4 || bidRefresh.readyState== 0){
        bidRefresh.open("POST", url , true);  //Opens a connection and retrieves response from the specified URL
        bidRefresh.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        bidRefresh.send(args); //Transmits request (can include postable string or DOM object data)
        bidRefresh.onreadystatechange = BidRefreshRes; //to make sure that request is complete.
    }
}

function BidRefreshRes(){
    if (bidRefresh.readyState == 4) {
        response = reqBidRef.responseXML.documentElement;
//        alert(response);
        if (response != null) {
            var results = response.getElementsByTagName('bid');
            if (results != null && results.length > 0) {
                for (var b = 0; b < results.length; b++){
                var bidId=results[b].getAttribute("bidid");
                var bnm=results[b].getAttribute("bidderName");
                var bpr=results[b].getAttribute("bidPrice");
                var blmt=results[b].getAttribute("bidRange");
                var biddiv="#bprice"+bidId;
                if($(biddiv).length){
                if(document.getElementById("bprice"+bidId).innerHTML!=bpr){
                    document.getElementById("bprice"+bidId).style.backgroundColor="#90ee90";
                    document.getElementById("bidMsg"+bidId).innerHTML="";
                } else{
                    document.getElementById("bprice"+bidId).style.backgroundColor="#FFFFFF";
                }
                document.getElementById("bprice"+bidId).innerHTML="";
                document.getElementById("bprice"+bidId).innerHTML=bpr;
                document.getElementById("buName"+bidId).innerHTML="";
                document.getElementById("buName"+bidId).innerHTML=bnm;
                if(blmt!=""&&blmt!=null){
                    document.getElementById("bidLm"+bidId).innerHTML="";
                    document.getElementById("bidLm"+bidId).innerHTML=blmt;
                }
                }
            }
            }
               
        }
        
    }
}


/********************************************************************************************************************************************/

var reqBidWL;
if (window.XMLHttpRequest) { // Non-IE browsers
    reqBidWL = new XMLHttpRequest();
} else if (window.ActiveXObject) { // IE
    reqBidWL = new ActiveXObject("Microsoft.XMLHTTP");
}
var bidWL = reqBidWL;
function addBidWL(bidId){
    var arg = "&bidId="+bidId+"&pr=0&frm=bidWL";
    var url = "bid";
    sendBidWLRequest(url, arg, handleBidWLResponse);

}


function sendBidWLRequest(url,args) {

    if(bidWL.readyState == 4 || bidWL.readyState== 0){
        bidWL.open("POST", url , true);  //Opens a connection and retrieves response from the specified URL
        bidWL.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        bidWL.send(args); //Transmits request (can include postable string or DOM object data)
        bidWL.onreadystatechange = handleBidWLResponse; //to make sure that request is complete.
    }
}

function handleBidWLResponse(){
    if (bidWL.readyState == 4) {
        response = reqBidWL.responseXML.documentElement;
//        alert(response);
        if (response != null) {
            var results = response.getElementsByTagName('check');
            if (results != null && results.length > 0) {
                var x=results[0].getAttribute("value");
                var bi = results[0].getAttribute("bidid");
                var status=results[0].getAttribute("status");
                if(status == "ok"){
                    putBidMsg(bi,"Added Successfully","green");
                }else if(status == "wrong Bid"){
                    putBidMsg(bi,x,"red");
                }else{
                    alert("Error occured while bidding");
                }
            }
        }

    }
}


/********************************************************************************************************************************************/


var reqSingBidRef;
if (window.XMLHttpRequest) { // Non-IE browsers
    reqSingBidRef = new XMLHttpRequest();
} else if (window.ActiveXObject) { // IE
    reqSingBidRef = new ActiveXObject("Microsoft.XMLHTTP");
}
var singBidRefresh = reqSingBidRef;

function callSingleBidRefresh(bidId){
    var arg = "bidId="+bidId;
    var url = "bidref";
    sendSingleBidRefreshReq(url, arg, singleBidRefreshRes);

}

function sendSingleBidRefreshReq(url,args) {

    if(singBidRefresh.readyState == 4 || singBidRefresh.readyState== 0){
        singBidRefresh.open("POST", url , true);  //Opens a connection and retrieves response from the specified URL
        singBidRefresh.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        singBidRefresh.send(args); //Transmits request (can include postable string or DOM object data)
        singBidRefresh.onreadystatechange = singleBidRefreshRes; //to make sure that request is complete.
    }
}

function singleBidRefreshRes(){
    if (singBidRefresh.readyState == 4) {
        response = reqSingBidRef.responseXML.documentElement;
//        alert(response);
        var bdSize=0;
        if (response != null) {
            var results = response.getElementsByTagName('bid');
            if (results != null && results.length > 0) {
                for (var b = 0; b < results.length; b++){
                var bidId=results[b].getAttribute("bidid");
                var bnm=results[b].getAttribute("bidderName");
                var bpr=results[b].getAttribute("bidPrice");
                var blmt=results[b].getAttribute("bidRange");
                var biddiv="#bprice"+bidId;
                bdSize=results[b].getAttribute("bidderSize");
                if($(biddiv).length){
                if(document.getElementById("bprice"+bidId).innerHTML!=bpr){
                    document.getElementById("bprice"+bidId).style.backgroundColor="#90ee90";
                    document.getElementById("bidMsg"+bidId).innerHTML="";
                } else{
                    document.getElementById("bprice"+bidId).style.backgroundColor="#FFFFFF";
                }
                document.getElementById("bprice"+bidId).innerHTML="";
                document.getElementById("bprice"+bidId).innerHTML=bpr;
                document.getElementById("buName"+bidId).innerHTML="";
                document.getElementById("buName"+bidId).innerHTML=bnm;
                if(blmt!=""&&blmt!=null){
                    document.getElementById("bidLm"+bidId).innerHTML="";
                    document.getElementById("bidLm"+bidId).innerHTML=blmt;
                }
                }
            }
            }
            var results2 = response.getElementsByTagName('bidDetails');
            if (results2 != null && results2.length > 0) {
            var histRows=document.getElementById('bidHistory').tBodies[0];
                for (var b2 = 0; b2 <1; b2++){
                    var bdnm=results2[b2].getAttribute("userName");
                    var bdpr=results2[b2].getAttribute("price");
                    var bdtm=results2[b2].getAttribute("time");
                    if(histRows.rows.length==1||histRows.rows[1].cells[1].innerHTML!=bdpr){
                        var rw = histRows.insertRow(1);
                        histRows.rows[1].style.backgroundColor="#EEE";
                        var c1=rw.insertCell(0);
                        c1.innerHTML=bdnm;
                        var c2=rw.insertCell(1);
                        c2.innerHTML=bdpr;
                        var c3=rw.insertCell(2);
                        c3.innerHTML=bdtm;
                        if(parseInt(bdSize)+2<=histRows.rows.length)
                            histRows.deleteRow(histRows.rows.length-1);
                    }
                }
            }
        }

    }
}

/********************************************************************************************************************************************/


var reqBidQL;
if (window.XMLHttpRequest) { // Non-IE browsers
    reqBidQL = new XMLHttpRequest();
} else if (window.ActiveXObject) { // IE
    reqBidQL = new ActiveXObject("Microsoft.XMLHTTP");
}
var bidQL = reqBidQL;

function bidQuickLogin(usName,pswd) {
    var arg ="act=bid&loginName="+usName+"&pwd="+pswd;
    var url="irrs";
    sendBidQL(url,arg,handleBidQLResponse);
}

function sendBidQL(url,args) {
    if(bidQL.readyState == 4 || bidQL.readyState== 0){
        bidQL.open("POST", url , true);  //Opens a connection and retrieves response from the specified URL
        bidQL.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        bidQL.send(args); //Transmits request (can include postable string or DOM object data)
        bidQL.onreadystatechange = handleBidQLResponse; //to make sure that request is complete.
    }
}

function handleBidQLResponse(){
    if (bidQL.readyState == 4) {
        response = reqBidQL.responseXML.documentElement;
        if (response != null) {
            var results = response.getElementsByTagName('login');
            if (results != null && results.length > 0) {
                document.getElementById('bidpwd').value="";
                alert("Wrong user name or password.");
            }else
            {
                results = response.getElementsByTagName('saveAd');
                if (results != null && results.length > 0) {
                    var fr=results[0].getAttribute("from");
                    var x=results[0].getAttribute("value");
                    var nm=results[0].getAttribute("name");
                    if(fr=="NOTLOG"&&x=="ERROR"&&nm!="")
                    {
                        document.getElementById("dr").innerHTML="Logout";
                        document.getElementById("myAccount").setAttribute("href", "my_ads_details.do")
                        document.getElementById("login").setAttribute("href", "logout.do")
                        document.getElementById("guest").style.display = 'none';
                        document.getElementById("guest1").innerHTML=nm;
                        uidbidder="0";
                        nmbidder="nm";
                        alert("Logged in successFully");
                        hs.close();
                    }
                }
            }
        }
    }
}