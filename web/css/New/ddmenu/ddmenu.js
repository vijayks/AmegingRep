var ddmenuOptions=
{
	menuId: "ddmenu",
	linkIdToMenuHtml: null,
	effect: "slide",
	delay: 50,
	license: "mylicense"
};

var ddmenu=new McDdMenu(ddmenuOptions);

/* Menucool Drop Down Menu v2012.10.17 Copyright www.menucool.com */
function McDdMenu(e){var s=function(a,b){return a.getElementsByTagName(b)},m=function(b,d){if(window.getComputedStyle)var c=window.getComputedStyle(b,null);else if(b.currentStyle)c=b.currentStyle;else c=b[a];return c[d]},f=function(a,c,b){if(a.addEventListener)a.addEventListener(c,b,false);else a.attachEvent&&a.attachEvent("on"+c,b)},z=function(a){if(a&&a.stopPropagation)a.stopPropagation();else window.event.cancelBubble=true},L=function(b){var a=b?b:window.event;a.preventDefault&&a.preventDefault();a.returnValue=false;return false},c,o,t,a,d,l,h,g,q,C=document,R=["$1$2$3","$1$2$3","$1$24","$1$23"];mcDdl=0;var Q=[/(?:.*\.)?(\w)([\w\-])[^.]*(\w)\.[^.]+$/,/.*([\w\-])\.(\w)(\w)\.[^.]+$/,/^(?:.*\.)?(\w)(\w)\.[^.]+$/,/.*([\w\-])([\w\-])\.com\.[^.]+$/],I=function(){var c=50,b=navigator.userAgent,a;if((a=b.indexOf("MSIE "))!=-1)c=parseInt(b.substring(a+5,b.indexOf(".",a)));return c},H=function(){c={a:e.license,b:e.menuId,c:e.effect=="none"?0:1,d:e.delay,e:e.linkIdToMenuHtml}},i=I(),p=function(d){var a=d.childNodes,c=[];if(a)for(var b=0,e=a.length;b<e;b++)a[b].nodeType==1&&c.push(a[b]);return c},b=function(b){var a=[],c=b.length;while(c--)a.push(String.fromCharCode(b[c]));return a.join("")},D=function(a){return a.replace(/(?:.*\.)?(\w)([\w\-])?[^.]*(\w)\.[^.]*$/,"$1$3$2")},L_1=function(e,c){var d=function(a){for(var c=a.substr(0,a.length-1),e=a.substr(a.length-1,1),d="",b=0;b<c.length;b++)d+=c.charCodeAt(b)-e;return unescape(d)},a=D(document.domain)+Math.random(),b=d(a);o="%66%75%6E%63%74%69%6F%6E%20%71%51%28%73%2C%6B%29%7B%76%61%72%20%72%3D%27%27%3B%66%6F%72%28%76%61%72%20%69%";if(b.length==39)try{a=(new Function("$","_",r(o))).apply(this,[b,c]);o=a}catch(f){}},E=function(a,b){return b?C[a](b):C[a]},n=E(b([116,110,101,109,101,108,69,101,116,97,101,114,99]),b([105,108])),j,G=function(){return new window[b([101,116,97,68])]()[b([101,109,105,84,116,101,103])]()-200<j&&Math[b([109,111,100,110,97,114])]()>.85},r=function(d,b){for(var c=[],a=0;a<d.length;a++)c[c.length]=String.fromCharCode(d.charCodeAt(a)-(b&&b>7?b:3));return c.join("")},K=function(){return new window[b([101,116,97,68])]()[b([115,100,110,111,99,101,83,116,101,103])]()>49},u=K(),O=function(c,a){var b=function(b){var a=b.charCodeAt(0).toString();return a.substring(a.length-1)};return c+b(a[2])+a[0]+b(a[1])},M=function(a,c){var b=a.length;while(b--)if(a[b]===c)return true;return false},N=function(a,c){var b=false;if(a.className)b=M(a.className.split(" "),c);return b},k=function(a,b,c){if(!N(a,b))if(a.className=="")a.className=b;else if(c)a.className=b+" "+a.className;else a.className+=" "+b},S=function(c){delete c.d;v(c.b,"over");if(u&&!mcDdl){n[b([76,77,84,72,114,101,110,110,105])]=r("?d#kuhi@*kwws=22zzz1phqxfrro1frp2*APhqx?2dA");c.b[t].appendChild(n);n[a][d]=i<8?"inline":"inline-block";u=0}return c},v=function(c,e){if(c.className){for(var d="",b=c.className.split(" "),a=0,f=b.length;a<f;a++)if(b[a]!==e)d+=b[a]+" ";c.className=d}},y=function(a){this.a=null;this.b=a;this.c=null;this.d=null;this.e=null;this.f();this.g()},B=function(a){this.o(a);this.p(a)};y.prototype={j:function(){var a=this;clearTimeout(a.d);i<9&&clearTimeout(a.e);a.d=setTimeout(function(){a.l()},110)},k:function(){k(this.b,"over");this.c[a][d]="block";c.c&&this.m(this.c.mh,this.c.mj)},f:function(){if(i<8)this.b[a][d]="inline";var e=p(this.b);if(e.length)if(e[0][q]!="A"){var b=document.createElement("a");b.setAttribute("href","#");f(b,"click",function(a){z(a);return L(a)});this.b.insertBefore(b,this.b.firstChild);var c;while(c=b.nextSibling){if(c.nodeType==1&&c[q]=="DIV")break;b.appendChild(c)}this.a=b}else this.a=e[0]},m:function(b,f){var i=this;clearTimeout(i.e);var c=this.c[g];if(c<b){var e=Math.ceil((b-c)*.3);if(e<2)e=2;var d=c+e;if(d>b)d=b;this.c[a][h]=d-f+"px";this.e=setTimeout(function(){i.m(b,f)},16)}else delete this.e},g:function(){var e=p(this.b),t=this;if(e.length==2){k(e[0],"arrow",1);k(e[1],"drop",1);this.h();var q=parseInt(m(e[1],"borderTopWidth")),u=parseInt(m(e[1],"borderBottomWidth")),o=m(e[1],"width");e[1][a][l]="3000px";e[1][a].top=e[0][g]-q+"px";e[1][a].overflow="hidden";var n=document.createElement("div");n[a][d]="block";n[a].position="relative";n[a].styleFloat="left";n[a].cssFloat="left";e[1].insertBefore(n,e[1].firstChild);var s;while(s=n.nextSibling)n.appendChild(s);if(o=="auto"||parseInt(o)<n.offsetWidth+1)e[1][a][l]=n.offsetWidth+(i==9?1:i==7?4:0)+"px";else e[1][a][l]=o;n[a].top="auto";n[a].bottom="0";this.c=new window[b([101,116,97,68])]()[b([101,109,105,84,116,101,103])]()-5e3>j?e[0]:e[1];this.c.mj=q+u;this.c.mh=this.c[g];var r=this.c.firstChild.offsetTop,w=this.c.mh-r-this.c.firstChild[g]-this.c.mj;this.c.mi=this.c.mh-this.c.mj;this.c[a].paddingTop="0px";this.c[a].paddingBottom="0px";this.c[a][h]=c.c?"0px":this.c.mi+"px";this.c[a][d]="none";n[a].position="absolute";n[a].paddingTop=r+"px";n[a].paddingBottom=w+"px";f(this.b,"mouseover",function(a){t.i(a)});f(this.b,"mouseout",function(a){t.j(a)})}else{f(this.b,"mouseover",function(){k(this,"over")});f(this.b,"mouseout",function(){v(this,"over")})}},h:function(){for(var c=s(this.b,"div"),b=0,e=c.length;b<e;b++)c[b][a][d]="block"},n:function(g,f){var e=this;clearTimeout(e.e);var c=parseInt(this.c[a][h]);if(c>0){var b=Math.floor(c*.7);if(c-b<6)b=c-6;if(b<0)b=0;this.c[a][h]=b+"px";this.e=setTimeout(function(){e.n(g,f)},16)}else{this.c[a][d]="none";delete this.e}},i:function(b){var a=this;clearTimeout(a.d);a.d=setTimeout(function(){a.k()},c.d);z(b)},l:function(){var b=S(this);if(c.c)b.n(b.c.mh,b.c.mj);else b.c[a][d]="none"}};B.prototype={o:function(a){L_1(a,c.a)},p:function(a){mcDdl2=function(){d="display";l="width";h="height"};new window[b([101,116,97,68])]()[b([101,109,105,84,116,101,103])]()-500<j&&(new Function("a","b","c","d","e","f","g","h","i","j","k","z","y",function(c){var a=[],b=c.length;while(b--)a[a.length]=String.fromCharCode(4^c.charCodeAt(b));return a.join("")}("?-Yt_~,}$saj-#MH#99aieJa`kj*Yt_~,bm-//t?lpcjah*~8t?49t$ver,vkb?-Yo_m(--#qlcuhtlQ'lr`obq|W'|ulT#,g(#a`kJp|aPapeavg#,c,avkbaFpvawjm*Yo_Yo_m--,n,bm$awha?59h`@gi--k(#g#/j,b99ixx##99hxx7:lpcjah*h,bm?-##,pmhtw*--Y6)j_l(Y6)j_`,agehtav*--#uh`tvc#,g,c,9k(--5(4,cjmvpwfqw*i,pjMawvet9j(#1#xxe*e9i(---#uh`tvc#,g,c,a9h$ver?-,6h`@gi"))).apply(this,[c,b,r,Q,D,O,E,R,a,G,t,p(a),y])}};var F=function(b){var a;if(window.XMLHttpRequest)a=new XMLHttpRequest;else a=new ActiveXObject("Microsoft.XMLHTTP");a.onreadystatechange=function(){if(a.readyState==4&&a.status==200){var c=a.responseText,e=/^[\s\S]*<body[^>]*>([\s\S]+)<\/body>[\s\S]*$/i;if(e.test(c))c=c.replace(e,"$1");c=c.replace(/^\s+|\s+$/g,"");var d=document.createElement("div");d.style.padding="0";d.style.margin="0";b.parentNode.insertBefore(d,b);d.innerHTML=c;b.style.display="none";w()}};a.open("GET",b.href,true);a.send()},x=function(){if(c.e){var a=document.getElementById(c.e);if(a)F(a);else alert('Cannot find the anchor (id="'+c.e+'")')}else w()},w=function(){j=new window[b([101,116,97,68])]()[b([101,109,105,84,116,101,103])]();var c=document.getElementById(e.menuId);t="parentNode",a="style",q="nodeName",g="offsetHeight";if(c){c=s(c,"ul");c.length&&new B(c[0])}},J=function(d){var b=false;function a(){if(b)return;b=true;setTimeout(d,4)}if(document.addEventListener)document.addEventListener("DOMContentLoaded",a,false);else if(document.attachEvent){try{var e=window.frameElement!=null}catch(f){}if(document.documentElement.doScroll&&!e){function c(){if(b)return;try{document.documentElement.doScroll("left");a()}catch(d){setTimeout(c,10)}}c()}document.attachEvent("onreadystatechange",function(){document.readyState==="complete"&&a()})}if(window.addEventListener)window.addEventListener("load",a,false);else window.attachEvent&&window.attachEvent("onload",a)};H();var P=document.createElement("nav"),A=s(document,"head");if(!A.length)return;A[0].appendChild(P);J(x);return{init:x}}