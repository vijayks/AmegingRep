<%--
    Document   : clock_link
    Created on : Feb 15, 2010, 1:57:37 PM
    Author     : bbsadmin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div style="margin:5px 0 0 0;clear:both">
<div id="bodybanner">

    <object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=10,0,0,0" width="728" height="95" id="buysell1" align="middle">
	<param name="allowScriptAccess" value="sameDomain" />
	<param name="allowFullScreen" value="false" />
	<param name="movie" value="bbsimages/buysell1.swf" /><param name="quality" value="high" /><param name="bgcolor" value="#ffffff" />
        <embed src="bbsimages/buysell1.swf" quality="high" bgcolor="#ffffff" width="728" height="95" name="buysell1" align="middle" allowScriptAccess="sameDomain" allowFullScreen="false" type="application/x-shockwave-flash" pluginspage="http://www.adobe.com/go/getflashplayer" />
   </object>
</div>
    <%--<div style="clear:both"></div>--%>

<!-- home banner   -->
<div id="afterbanner" style="margin:0 0 0 5px">             <!-- home navigation  start -->

  <div  style="text-align:center;float:right;width:500px">
        <span  id="clock" style="float:right;width:150px;font-family:verdana;font-size:12px;color:#444444;font-weight:bold;margin:0 40px 0 0">
        <%= new java.text.SimpleDateFormat("MMM dd, yyyy").format(new java.util.Date()) %></span> <span style="float:right"><a style="font-size:13px;color:red" href="createLink.do"><b>Link Your site Now!!&nbsp;&nbsp;&nbsp;</b></a></span>
  </div>
</div>
</div>