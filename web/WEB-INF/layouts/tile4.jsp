<%--
    Document   : tile4
    Created on : Feb 4, 2010, 11:55:51 AM
    Author     : bbsadmin
--%>
<%@ taglib uri="http://struts.apache.org/tags-tiles" prefix="tiles" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<style type="text/Stylesheet">
    html{
        background:#FFFFFF;
	width:100%;
    }
</style>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>${dw}@Bharatbuysell.com</title>
        <link href="css/stylesheet.css" rel="stylesheet" type="text/css" />
        <link rel="shortcut Icon" href="bbsimages/favicon.ico"  />
    </head>
    <body style="color:#656565;background-color:#ffffff;width:100%">
        <c:set var="act"><tiles:getAsString name="button" ignore="true" /></c:set>
        <c:set var="button" value="${act}" scope="session" />
        <div id="wrapper" style="padding:5px;width:1000px;margin:0 auto" >                                                                <!-- Main wrapper start -->
            <div id="masterheader" style="background-image:none;background-color:white">  <!-- master header div  start -->
                <tiles:insert attribute="header" />
            </div>  <!-- master header div  end -->
            <div id="" style="clear:left;" >
                <tiles:insert attribute="searchBar" />
            </div>
            <div id="body_container2" style="clear:both;">
                <div id="body_container1" >
                    <div style="float:left;width:18%">
                        <tiles:insert attribute="menu"/>
                    </div>
                    <div id="mastermainbody" style="float:left;width:82%">                                                              <!-- Master main body div start -->
                        <div id="masterrightbodybg" style="float:left;width:78%">

                            <tiles:insert attribute="recentSearches" />

                            <tiles:insert attribute="body" />
                        </div>
                            <div style="float:left;width:22%">
                                <tiles:insert attribute="rightDiv" />
                            </div>
                    </div>                                                              <!-- Master main body div end -->
                </div>
            </div>
            <div id="masterfooter" style="background-image:none;background-color:white">                                                                <!-- Footer div start -->
                <tiles:insert attribute="footer" />
            </div>                                                               <!-- Footer div end -->
        </div>              <!-- Main wrapper end -->


    </body>
</html>