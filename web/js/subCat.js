/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 *
 *
 *
 * editCatForm
 */


var xmlhttp;
if (window.XMLHttpRequest)
{
    // code for IE7+, Firefox, Chrome, Opera, Safari
    xmlhttp=new XMLHttpRequest();
}
else if (window.ActiveXObject)
{
    // code for IE6, IE5
    xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
}
else
{
    alert("Your browser does not support XMLHTTP!");
}
var http=xmlhttp;

function hello(element){
    alert("hi");
    var url = 'wss';
    var args = 'ci='+element.value;
    sendSubCatRequest(url,args,handleSubCatHttpResponse);
}
function sendSubCatRequest(url,args,responceMethod) {
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

}

   function handleSubCatHttpResponse(){


	if (http.readyState == 4) {
		response = xmlhttp.responseXML.documentElement;

		if (response != null) {
			var results = response.getElementsByTagName('cat');
			if (results != null && results.length > 0) {
               formObj = document.getElementsByName("getSubCat");
               var lb= document.getSubCat.subcat;
                clear(lb);
//                var llb= document.getSubCat.classcat;
//                clear(llb);
				for (var i = 0; i < results.length; i++) {
                    options=new Option(results[i].getAttribute("name"), results[i].getAttribute("id"));
                    lb.options.add(options);
				}
			}
		}
	}
}




