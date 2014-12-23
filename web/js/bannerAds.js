/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
var xmlhttp,xmlhttp2,xmlhttp3;
if (window.XMLHttpRequest)
{
    // code for IE7+, Firefox, Chrome, Opera, Safari
    xmlhttp=new XMLHttpRequest();
    xmlhttp2=new XMLHttpRequest();
    xmlhttp3=new XMLHttpRequest();
}
else if (window.ActiveXObject)
{
    // code for IE6, IE5
    xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
     xmlhttp2=new ActiveXObject("Microsoft.XMLHTTP");
      xmlhttp3=new ActiveXObject("Microsoft.XMLHTTP");
}
else
{
    alert("Your browser does not support XMLHTTP!");
}
var ad1=xmlhttp;
var ad2=xmlhttp2;
var ad3=xmlhttp3;
function refreshAds(){

  setTimeout(refreshAds,30000);
  var arg;
  var url ="siteAds";
  sendRequestAds1(url, arg, handleAds1ReqResponse);
  sendRequestAds2(url, arg, handleAds2ReqResponse);
  sendRequestAds3(url, arg, handleAds3ReqResponse);
}
function sendRequestAds1(url,args) {

    if(ad1.readyState == 4 || ad1.readyState== 0){
        ad1.open("GET", url , true);  //Opens a connection and retrieves response from the specified URL
        ad1.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        ad1.send(args); //Transmits request (can include postable string or DOM object data)
        ad1.onreadystatechange = handleAds1ReqResponse; //to make sure that request is complete.
    }
}

function sendRequestAds2(url,args) {

    if(ad2.readyState == 4 || ad2.readyState== 0){
        ad2.open("GET", url , true);  //Opens a connection and retrieves response from the specified URL
        ad2.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        ad2.send(args); //Transmits request (can include postable string or DOM object data)
        ad2.onreadystatechange = handleAds2ReqResponse; //to make sure that request is complete.
    }
}
function sendRequestAds3(url,args) {

    if(ad3.readyState == 4 || ad3.readyState== 0){
        ad3.open("GET", url , true);  //Opens a connection and retrieves response from the specified URL
        ad3.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        ad3.send(args); //Transmits request (can include postable string or DOM object data)
        ad3.onreadystatechange = handleAds3ReqResponse; //to make sure that request is complete.
    }
}


function BannerAd1(itemId)
{

  var pic=document.getElementById("BannerAd");
  if(pic != null)
      {
          pic.src="bbsimages/"+itemId;
      }


}
function BannerAd2(itemId)
{

  var pic=document.getElementById("BannerAd2");
  if(pic != null)
      {
          pic.src="bbsimages/"+itemId;
      }

}
function BannerAd3(itemId)
{

  var pic=document.getElementById("BannerAd3");
   if(pic != null)
      {
          pic.src="bbsimages/"+itemId;
      }

}
/*
 *<response>
    <siteAdd url="dasd" page="1" place="1" duration="10000" image="home_img.gif" type="1"/>
    <siteAdd url="fdg" page="1" place="1" duration="10000" image="home_img2.gif" type="3"/>
    <siteAdd url="dsf" page="1" place="1" duration="10000" image="home_img3.gif" type="1"/>
    <siteAdd url="sdf" page="1" place="1" duration="10000" image="home_img4.gif" type="1"/>
  </response>
 *
 *
 */
var response1;
var response2;
var response3;
function handleAds1ReqResponse(){
    if (ad1.readyState == 4) {
        response1 = ad1.responseXML.documentElement;
        if (response1 != null) {
          var results1 = response1.getElementsByTagName('siteAdd1');
            if (results1 != null && results1.length > 0) {

                for(var i = 0; i<results1.length;i++)
                    {
                      var ads1=results1.item(i);
                      var sr1=ads1.getAttribute('image').toString();
                      var dly1=ads1.getAttribute('duration').toString();
                      setTimeout(BannerAd1, dly1,sr1);
                     }

            }
        }
    }
}

function handleAds2ReqResponse(){
    if (ad2.readyState == 4) {
        response2 = ad2.responseXML.documentElement;
        if (response2 != null) {
          var results2 = response2.getElementsByTagName('siteAdd2');
            if (results2 != null && results2.length > 0) {

                for(var i = 0; i<results2.length;i++)
                    {
                      var ads2=results2.item(i);
                      var sr2=ads2.getAttribute('image').toString();
                      var dly2=ads2.getAttribute('duration').toString();
                       setTimeout(BannerAd2, dly2,sr2);
                 }
            }
        }
    }
}

function handleAds3ReqResponse(){
    if (ad3.readyState == 4) {
        response3 = ad3.responseXML.documentElement;
        if (response3 != null) {
          var results3 = response3.getElementsByTagName('siteAdd3');
            if (results3 != null && results3.length > 0) {

                for(var i = 0; i<results3.length;i++)
                    {
                      var ads3=results3.item(i);
                      var sr3=ads3.getAttribute('image').toString();
                      var dly3=ads3.getAttribute('duration').toString();
                      setTimeout(BannerAd3, dly3,sr3);

                     }

            }
        }
    }
}

