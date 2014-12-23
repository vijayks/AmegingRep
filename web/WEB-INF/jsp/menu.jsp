<%--
    Document   : searchBar
    Created on : May 11, 2009, 12:11:42 PM
    Author     : bbsadmin
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script type="text/javascript">
    function toggle_s(itemID,img)
    {
        if((document.getElementById(itemID).style.display == 'none'))
        {
            document.getElementById(itemID).style.display = 'inline';
            document.getElementById(img).src='bbsimages/arrowd.jpg';
        }
        else
        {
            document.getElementById(itemID).style.display = 'none';
            document.getElementById(img).src='bbsimages/arrow.jpg';
        }
        return;
    }
    function sc(catid)
    {
        alert(catid);
    }
    function openCat(itemID)
    {
        document.getElementById(itemID).style.display = 'inline' ;
        document.getElementById('more').style.display = 'none';
        document.getElementById('hide').style.display = 'inline';
    }
    function hideCat(itemID)
    {
        document.getElementById(itemID).style.display = 'none' ;
        document.getElementById('more').style.display = 'inline';
        document.getElementById('hide').style.display = 'none';
    }
</script>
<style type="text/css">
    <!--
    .li12
    {
        font-family:Arial;
        font-size:12px;
        list-style:none;
    }
    .li11
    {
        font-family:Arial;
        font-size:11px;
        font-weight:normal;
        list-style:inside;
        list-style-type:square;
        color:#ffffff;
        margin-left:50px;
        line-height:20px
    }
    -->
</style>
<!-- left body background start and end -->
<!-- Master main body div start -->
<div id="masterleftbodybg">       <!-- left body background start and end -->
    <div id="mastercontentbody">      <!-- Master content body div start   -->
        <div id="leftcategorymenu">       <!-- Left menu div start  -->

<div style="margin:0% 5%">
        <jsp:include page="/WEB-INF/jsp/delearSearch.jsp"/>
</div>
<script type="text/javascript">
    if(document.location.href.indexOf("dealer")>-1||document.location.href.indexOf("Dealer")>-1) {
        document.getElementById("userLead").style.display="block";
    }
</script>
<%--<center><div style="width:1em;font-size:48px;color:silver">B h a r a t buy sell</div></center>--%>
        </div>
    </div><!-- Left menu div End -->
</div>

