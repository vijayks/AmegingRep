<%--
    Document   : wsBody
    Created on : Feb 25, 2010, 10:49:25 AM
    Author     : bbsadmin
--%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn"%>
<%@page import="com.buysell.webshop.actionclasses.WebsiteAction" %>
<%@page import="com.buysell.beans.DealerMoreInfo" %>

<style type="text/css">
    .myBox
    {
        text-align: left;
        background-color: #FFF;
        border: 1px solid #bbbbbb;
        margin-top:10px;
        width:199px;
	*width:170px;
        float:left;

    }
</style>
<script type="text/javascript" src="js/curvycorners.js"></script>
<script type="text/JavaScript">

    function CallCurveCorners()
    {
        /*
      The new 'validTags' setting is optional and allows
      you to specify other HTML elements that curvyCorners
      can attempt to round.
      The value is comma separated list of html elements
      in lowercase.
      validTags: ["div", "form"]
      The above example would enable curvyCorners on FORM elements.
         */
        settings = {
            tl: { radius: 5 },
            tr: { radius: 5 },
            bl: { radius: 5 },
            br: { radius: 5 },
            antiAlias: true,
            autoPad: true,
            validTags: ["div"]
        }
        /*
      Usage:
      newCornersObj = new curvyCorners(settingsObj, classNameStr);
      newCornersObj = new curvyCorners(settingsObj, divObj1[, divObj2[, divObj3[, . . . [, divObjN]]]]);
         */
        var myBoxObject = new curvyCorners(settings, "myBox");
        myBoxObject.applyCornersToAll();
    }

</script>
<script type="text/javascript">

    var pageCount =new Array();
    var subMore =new Array();
    var subLink =new Array();
    var hideMore=new Array();
    var hideLink=new Array();
    var pageNum=new  Array();
    var cnt=0;
    var cntm=0;
    var cnth=0;
    var cnt1=0;

    function pageNo(itemId,itemId2)
    {
        for(var i=0;i<pageCount.length;i++)
        {
            document.getElementById(pageCount[i]).style.display = 'none' ;
        }
        document.getElementById(itemId).style.display = 'inline' ;

        for(var j=0;j<pageNum.length;j++)
        {
            document.getElementById(pageNum[j]).style.backgroundColor = '#ffffff' ;
            document.getElementById(pageNum[j]).style.color = '#4D9EDF' ;

        }
        document.getElementById(itemId2).style.backgroundColor = '#4D9EDF';
        document.getElementById(itemId2).style.color= '#ffffff';

    }


    function openCatb(itemID1,itemID2)
    {
        if ((document.getElementById(itemID1).style.display == 'none'))
        {
            for(var i=0;i<subMore.length;i++)
            {

                document.getElementById(subMore[i]).style.display = 'inline' ;
                document.getElementById(subLink[i]).style.display = 'inline' ;
                document.getElementById(hideMore[i]).style.display = 'none' ;
            }
            document.getElementById(itemID1).style.display = 'inline' ;
            document.getElementById(itemID2).style.display = 'none';
        }
    }
    function hideCatb(itemID1,itemID2)
    {
        document.getElementById(itemID1).style.display = 'none' ;
        document.getElementById(itemID2).style.display = 'inline';
    }
    <%-- //this function to view all categories...--%>
        function viewAll()
        {
            for(var i=0;i<pageCount.length;i++)
            {
                document.getElementById(pageCount[i]).style.display ='inline' ;
            }
            document.getElementById("bpagenav").style.display='none';
            document.getElementById("pagenavv").style.display='inline';
            document.getElementById("latestads").style.display='none';
            document.getElementById("la").style.display='none';
            document.getElementById("laimg").style.display='none';
        }
        function hideAll()
        {
            for(var i=0;i<pageCount.length;i++)
            {
                document.getElementById(pageCount[i]).style.display ='none' ;
            }
            document.getElementById(pageCount[0]).style.display ='inline' ;
            document.getElementById("bpagenav").style.display='inline';
            document.getElementById("pagenavv").style.display='none';
            document.getElementById("latestads").style.display='inline';
            document.getElementById("la").style.display='inline';
            document.getElementById("laimg").style.display='inline';
            pageNo('cat1','1');
        }
</script>
<div id="maincontentbody">            <!-- main content body div start -->
    <div id="leftcontentbody" style="width:100%">            <!-- left content body div start -->
        <img alt="bharatbuysellLogo" src="bbsimages/tvjpg.jpg" border="0" style="height:160px;width:620px;padding:0px 10px 10px;" /><br>
         <% String du = (String) request.getSession().getAttribute("dw");
       if(du!=null) {
        DealerMoreInfo dm = (DealerMoreInfo) WebsiteAction.hmp.get(du);
        if(dm!=null){
            request.setAttribute("dealerWebsite",dm);
    %>

    <c:set var="awsCategories" value="${dealerWebsite.wsCatList}"/>
        <c:if test='${awsCategories != null}' >
            <c:set var="i" value="0" />
            <c:set var="j" value="1" />
            <c:forEach items="${awsCategories}" var="category" >
                <c:if test='${category.parentId == 0 && category.status==1}' >
                    <c:if test='${i == 0}' >
                        <c:if test="${j >= 2}">
                            <div id="cat<c:out value='${j}'/>" class="leftcontent1" style="display:none;width:100%;">
                            </c:if>
                            <c:if test='${j==1}'>
                                <div id="cat<c:out value='${j}'/>" class="leftcontent1" style="width:100%">
                                </c:if>
                                <script type="text/javascript">
                                    pageCount[cnt]="cat"+<c:out value='${j}'/>;
                                    cnt++;
                                </script>
                            </c:if >
                            <c:set var="i"  value="${i + 1}" />
                            <div   id="content1" style="margin-left:10px;margin-top:1px;width:199px;">
                                <span class="verdana_automobile" style="padding:0 0 0 3px" ><c:out value="${category.name}" escapeXml="false"/></span>
                                <div class="myBox" style="">
                                    <img src="resourceGetter?imd=${dealerWebsite.path}${category.cImg}" style="width:167px;padding-left:2px;height:50px" align="center" alt='<c:out value="${category.name}" escapeXml="false"/>' title="${category.name}" > <!-- here we insert image -->
                                    <div  id="content2"   style="margin-top:4px;">
                                        <div id="o<c:out value='${category.name}' />" class="fv12" style="float:left;width:100%" >
                                                <c:forEach items="${awsCategories}" var ="cat" >
                                                    <c:set var="lp1" value="1" />
                                                    <c:if test="${cat.parentId==category.catId && cat.status==1}">
                                                       <c:if test="${lp1 <= 5}"><div style="float:left;width:167px"><div style="float:left;width:17px"><img src="bbsimages/innerimage.gif" border="0" alt="-" style="height:9px;width:13px;"/></div><div style="float:left;width:150px"><a title="${cat.name}" class="link11"  href="getWSProducts.do?subcat=${cat.name}@${cat.id}"><c:out value="${cat.name}" escapeXml="false"/> </a></div></div></c:if>
                                                    </c:if>
                                                </c:forEach>
                                                        <c:if test="${lp1 > 6 }" >
                                                           <a title="More" id="ol<c:out value="${category.name}" />" href="javascript:return false" class="more" onclick="openCatb('h<c:out value="${category.name}" />','ol<c:out value="${category.name}" />');event.returnValue=false;return false;">More... </a>
                                                    <!-- this script block used to store all the id of the subcat display div in order to open one more option at a time -->
                                                    <script type="text/javascript">
                                                        subMore[cntm]="o${category.name}";
                                                        subLink[cntm]="ol${category.name}";
                                                        cntm++;
                                                    </script>
                                                </c:if>
                                        </div>

                                        <div id="h<c:out value="${category.name}" />" class="fv12"  style="float:left;width:98%;display:none">
                                            <c:forEach items="${awsCategories}" var ="cat">
                                                <c:set var="lp2" value="1"/>
                                                <c:if test="${cat.parentId==category.catId && cat.status==1}">
                                                <c:if test="${lp2 > 5}"><div style="float:left;width:167px"><div style="float:left;width:17px"><img src="bbsimages/innerimage.gif" border="0"  alt="-"  style="height:9px;width:13px;"/></div><div style="float:left;width:150px"><a title="${cat.name}" class="link11"  href="getWSProducts.do?subcat=${cat.name}@${cat.id}"><c:out value="${cat.name}" escapeXml="false" /></a></div></div></c:if>
                                                </c:if>
                                            </c:forEach>
                                                        <c:if test="${lp2 > 6 }" >
                                                    <a title="Hide" id="hl<c:out value='${category.name}' />" href="javascript:return false" class="more" onclick="hideCatb('h<c:out value="${category.name}" />','ol<c:out value="${category.name}" />');event.returnValue=false;return false; "> ...Hide </a>
                                                    <script language="javascript">
                                                        hideMore[cnth]="h${category.name}";
                                                        hideLink[cnth]="hl${category.name}";
                                                        cnth++;
                                                    </script>
                                                </c:if>
                                        </div>
                                    </div>

                                </div>
                            </div>
                        </c:if>

                        <c:if test='${i == 3}'>
                            <div style="clear:both"></div>
                        </c:if>
                        <c:if test="${i == 6}">
                            <c:set var="i" value="0" />
                            <c:set var="j" value="${j+1}" />
                            <div style="clear:both"></div>
                        </div>
                    </c:if>
                </c:forEach >

            </c:if>

        </div>
        <!-- left content1 div end -->
        <div id="bpagenav" style="float:left">
            <c:if test='${i == 0 && j>2}' >
                <a  style="text-align:left;padding:0 400px 0 10px;font-size:12px" href="javascript:return false;" onclick="viewAll();event.returnValue=false;return false;"> View All</a>
                <c:forEach var="page" begin="1" end="${j-1}" step="1" varStatus ="status">

                    <a style="padding-left:300px" href="javascript:return  false"  style="text-decoration:none" onclick="pageNo('cat${page}','${page}');event.returnValue=false;return false;" > <span id="${page}"> <c:out value="${page}" /> </span> </a>
                    <script type="text/javascript">
                        pageNum[cnt1]='${page}';
                        cnt1++;
                        document.getElementById('1').style.backgroundColor ='#4D9EDF' ;
                        document.getElementById('1').style.color = '#ffffff';
                    </script>

                </c:forEach>
            </c:if>

                    <c:if test='${i != 0 && j>=2}' >
                <a style="color:#046dbe;text-align:left;margin:0 290px 0 10px;font-size:12px;font-weight:bold" href="javascript:return false;" onclick="viewAll();event.returnValue=false;return false;"> View All Categories</a>
                <c:forEach var="page" begin="1" end="${j}" step="1" varStatus ="status">

                    <a href="javascript:return false;"  style="text-decoration:none;cursor:url" onclick="pageNo('cat${page}','${page}');event.returnValue=false;return false;" > <span id="${page}"> <c:out value="${page}" /> </span> </a>
                    <script type="text/javascript">
                       pageNum[cnt1]='${page}';
                       cnt1++;
                       document.getElementById('1').style.backgroundColor ='#4D9EDF' ;
                       document.getElementById('1').style.color = '#ffffff';
                    </script>

                </c:forEach>
            </c:if>
        </div>
    </div>
</div>
<!-- main content body div End -->
<div style="clear:both"> </div>
<br />
<a id="pagenavv"  style="color:#046dbe;;display:none;padding-left:10px" href="javascript:return false;" onclick="hideAll();event.returnValue=false;return false;">Back</a>

            <%}else {%>
            Please access from the Home Page
            <%}}%>
<script type="text/javascript">
    CallCurveCorners();
</script>