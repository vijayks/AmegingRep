function verifyInputsFeedBack(name,lid,ph)
{var check=true;var emailregx=/^[a-z]+(([a-z_0-9]*)|([a-z_0-9]*\.[a-z_0-9]+))*@([a-z_0-9\-]+)((\.[a-z]{3})|((\.[a-z]{2})+)|(\.[a-z]{3}(\.[a-z]{2})+))$/;var emailt=document.getElementById(lid).value.toLowerCase();if(document.getElementById(name).value=='')
{document.getElementById(name).style.borderColor='red';check=false;}
else if(document.getElementById(lid).value=='')
{document.getElementById(name).style.borderColor='green';document.getElementById(lid).style.borderColor='red';check=false;}
else if(!emailregx.test(emailt))
{document.getElementById(lid).style.borderColor='red';alert("Please give login id as yourname@company.com");check=false;}
else if(document.getElementById(ph).value=='')
{document.getElementById(lid).style.borderColor='green';document.getElementById(ph).style.borderColor='red';check=false;}
return check;}
function limitText(limitField,limitCount,limitNum){if(limitField.value.length>limitNum){limitField.value=limitField.value.substring(0,limitNum);}else{limitCount.value=limitNum-limitField.value.length;}}
function termsAndConditions(url,title)
{window.open(url,"title",'width=500,height=300,resizable=yes,menubar=no,status=no,location=no,toolbar=no,scrollbars=yes,screenX=500,screenY=400');}
function openAlertWindow(url){window.open(url,"SaveAlert",'width=400,height=200,resizable=no,menubar=no,status=no,location=no,toolbar=no,scrollbars=yes,screenX=500,screenY=400');}
function toggle_disable(dis,nor)
{document.getElementById(dis).style.display="inline";document.getElementById(nor).style.display="none";}
function toggle_enable(dis,nor)
{document.getElementById(dis).style.display="none";document.getElementById(nor).style.display="inline";}
function submitPressed(fn,bn)
{document.getElementById(bn).disabled=true;document.getElementById(fn).submit();}
var MSGTIMER=20;var MSGSPEED=5;var MSGOFFSET=3;var MSGHIDE=3;function inlineMsg(target,string,autohide){var msg;var msgcontent;if(!document.getElementById('msg')){msg=document.createElement('div');msg.id='msg';msgcontent=document.createElement('div');msgcontent.id='msgcontent';document.body.appendChild(msg);msg.appendChild(msgcontent);msg.style.filter='alpha(opacity=0)';msg.style.opacity=0;msg.alpha=0;}else{msg=document.getElementById('msg');msgcontent=document.getElementById('msgcontent');}
msgcontent.innerHTML=string;msg.style.display='block';var msgheight=msg.offsetHeight;var targetdiv=document.getElementById(target);targetdiv.focus();var targetheight=targetdiv.offsetHeight;var targetwidth=targetdiv.offsetWidth;var topposition=topPosition(targetdiv)-((msgheight-targetheight)/2);var leftposition=leftPosition(targetdiv)+targetwidth+MSGOFFSET;msg.style.top=topposition+'px';msg.style.left=leftposition+'px';clearInterval(msg.timer);msg.timer=setInterval("fadeMsg(1)",MSGTIMER);if(!autohide){autohide=MSGHIDE;}}
function hideMsg(msg){var msg=document.getElementById('msg');if(!msg.timer){msg.timer=setInterval("fadeMsg(0)",MSGTIMER);}}
function fadeMsg(flag){if(flag==null){flag=1;}
var msg=document.getElementById('msg');var value;if(flag==1){value=msg.alpha+MSGSPEED;}else{value=msg.alpha-MSGSPEED;}
msg.alpha=value;msg.style.opacity=(value/100);msg.style.filter='alpha(opacity='+value+')';if(value>=99){clearInterval(msg.timer);msg.timer=null;}else if(value<=1){msg.style.display="none";clearInterval(msg.timer);}}
function leftPosition(target){var left=0;if(target.offsetParent){while(1){left+=target.offsetLeft;if(!target.offsetParent){break;}
target=target.offsetParent;}}else if(target.x){left+=target.x;}
return left;}
function topPosition(target){var top=0;if(target.offsetParent){while(1){top+=target.offsetTop;if(!target.offsetParent){break;}
target=target.offsetParent;}}else if(target.y){top+=target.y;}
return top;}

function createCookie(name,value,hours) {
    if (hours) {
            var date = new Date();
            date.setTime(date.getTime()+(hours*60*60*1000));
            var expires = "; expires="+date.toGMTString();
    }
    else var expires = "";
    document.cookie = name+"="+value+expires+"; path=/";
}
 function readCookie(name) {
    var nameEQ = name + "=";
    var ca = document.cookie.split(';');
    for(var i=0;i < ca.length;i++) {
            var c = ca[i];
            while (c.charAt(0)==' ') c = c.substring(1,c.length);
            if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length,c.length);
    }
    return null;
}

function eraseCookie(name) {
    createCookie(name,"",-1);
}