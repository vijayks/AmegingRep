<%--
    Document   : body
    Created on : Mar 1, 2009, 1:03:49 PM
    Author     : bbsadmin
--%>
<script type="text/javascript">
    var tcs=new Date();
    var catStart=tcs.getTime();
</script>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page  import="com.buysell.beans.AdsResultsBean " %>
<%@page  import="java.io.OutputStream " %>
<%@page  import="java.io.FileInputStream " %>
<%@page import="com.buysell.beans.UserBean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn"%>

<style type="text/css">
    .myBox
    {
        text-align: left;
        background-color: #FFF;
        border: 1px solid #bbbbbb;
        margin-top:10px;
        width:171px;
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
<!-- Master right content body start -->
<!-- home navigation end -->

<div id="maincontentbody">            <!-- main content body div start -->
    <div id="leftcontentbody" >            <!-- left content body div start -->
        <c:if test='${categoryList != null}' >
            <c:set var="i" value="0" />
            <c:set var="j" value="1" />
            <c:forEach items="${categoryList}" var="category" >
                <c:if test='${category.parent == 0}' >
                    <c:if test='${i == 0}' >
                        <c:if test="${j >= 2}">
                            <div id="cat<c:out value='${j}'/>" class="leftcontent1" style="display:none">
                            </c:if>
                            <c:if test='${j==1}'>
                                <div id="cat<c:out value='${j}'/>" class="leftcontent1" style="" >
                                </c:if>
                                <script type="text/javascript">
                                    pageCount[cnt]="cat"+<c:out value='${j}'/>;
                                    cnt++;
                                </script>
                            </c:if >
                            <c:set var="i"  value="${i + 1}" />
                            <div   class="content1" style="margin-left:7px;margin-top:1px;">
                                <span class="verdana_automobile" style="padding:0 0 0 3px" ><c:out value="${category.name}" escapeXml="false"/></span>
                                <div class="myBox" style="">
                                    <img src="resourceGetter?imf=<c:out value='${category.imagePath}'/>" style="width:167px;padding-left:2px;height:50px" align="center" alt='<c:out value="${category.name}" escapeXml="false"/>' /> <!-- here we insert image -->
                                    <div  class="content2"   style="margin-top:4px;">
                                        <div id="o<c:out value='${category.id}' escapeXml='true'/>" class="fv12" style="float:left;width:100%" >
                                            <c:if test="${category.subCategories != null}">
                                                <c:forEach items="${category.subCategories}" var ="cat"  varStatus="loop1" ><c:if test="${loop1.index <= 5}"><div style="float:left;width:167px"><div style="float:left;width:17px"><img src="bbsimages/innerimage.gif" alt="-" style="height:9px;width:13px;border:none"/></div><div style="float:left;width:150px"><a title="<c:out value="${cat.name}" escapeXml="false"/>" class="link11"  href="clf.do?subCatId=<c:out value="${cat.id}" /><c:if test="${cat.name!=null}">&amp;category=${cat.name}</c:if>"><c:out value="${cat.name}" escapeXml="false"/> </a></div></div></c:if></c:forEach>
                                                        <c:set var="len"> <c:out value="${fn:length(category.subCategories)}"/></c:set>
                                                        <c:if test="${len > 6 }" >
                                                    <a title="Browse More" id="ol<c:out value="${category.id}" />" href="javascript:return false" class="more" onclick="openCatb('h<c:out value="${category.id}" />','ol<c:out value="${category.id}" />');event.returnValue=false;return false;">More... </a>
                                                    <!-- this script block used to store all the id of the subcat display div in order to open one more option at a time -->
                                                    <script type="text/javascript">
                                                        subMore[cntm]="o${category.id}";
                                                        subLink[cntm]="ol${category.id}";
                                                        cntm++;
                                                    </script>
                                                </c:if>
                                            </c:if>
                                        </div>

                                        <div id="h<c:out value="${category.id}" />" class="fv12"  style="float:left;width:98%;display:none">
                                            <c:if test="${category.subCategories != null}">
                                                <c:forEach items="${category.subCategories}" var ="cat"  varStatus="loop2" ><c:if test="${loop2.index > 5}"><div style="float:left;width:167px"><div style="float:left;width:17px"><img src="bbsimages/innerimage.gif"  alt="-"  style="height:9px;width:13px;border:none"/></div><div style="float:left;width:150px"><a class="link11"  href="clf.do?subCatId=<c:out value="${cat.id}" /><c:if test="${cat.name!=null}">&amp;category=${cat.name}</c:if>"><c:out value="${cat.name}" escapeXml="false" /></a></div></div></c:if></c:forEach>
                                                        <c:set var="len"> <c:out value="${fn:length(category.subCategories)}"/></c:set>
                                                        <c:if test="${len > 6 }" >
                                                    <a title="Hide" id="hl<c:out value='${category.id}' />" href="javascript:return false" class="more" onclick="hideCatb('h<c:out value="${category.id}" />','ol<c:out value="${category.id}" />');event.returnValue=false;return false; "> ...Hide </a>
                                                    <script type="text/javascript">
                                                        hideMore[cnth]="h${category.id}";
                                                        hideLink[cnth]="hl${category.id}";
                                                        cnth++;
                                                    </script>
                                                </c:if>
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
            <c:if test='${i == 0}' >
                <a title="View All Categories"  style="text-align:left;padding:0 400px 0 10px;font-size:12px" href="javascript:return false;" onclick="viewAll();event.returnValue=false;return false;"> View All</a>
                <c:forEach var="page" begin="1" end="${j-1}" step="1" varStatus ="status">

                    <a style="padding-left:300px" href="javascript:return  false"  style="text-decoration:none" onclick="pageNo('cat${page}','no${page}');event.returnValue=false;return false;" > <span id="no${page}"> <c:out value="${page}" /> </span> </a>
                    <script type="text/javascript">
                        pageNum[cnt1]='no${page}';
                        cnt1++;
                        document.getElementById('no1').style.backgroundColor ='#4D9EDF' ;
                        document.getElementById('no1').style.color = '#ffffff';
                    </script>

                </c:forEach>
            </c:if>

            <c:if test='${i != 0}' >
                <a title="View All the available categories" style="color:#046dbe;text-align:left;margin:0 290px 0 10px;font-size:12px;font-weight:bold" href="javascript:return false;" onclick="viewAll();event.returnValue=false;return false;"> View All Categories</a>
                <c:forEach var="page" begin="1" end="${j}" step="1" varStatus ="status">

                    <a title="<c:out value="${page}" />" href="javascript:return false;"  style="text-decoration:none;cursor:url" onclick="pageNo('cat${page}','no${page}');event.returnValue=false;return false;" > <span id="no${page}"> <c:out value="${page}" /> </span> </a>
                    <script type="text/javascript">
                       pageNum[cnt1]='no${page}';
                       cnt1++;
                       document.getElementById('no1').style.backgroundColor ='#4D9EDF' ;
                       document.getElementById('no1').style.color = '#ffffff';
                    </script>

                </c:forEach>
            </c:if>
        </div>
    </div>

    <div id="rightcontentadbody" style="margin-top:5px;">
        <img src="bbsimages/rightAd.gif" width="183" height="442" alt="http://bharatbuysell.com" />
        <!--       <img id="BannerAd2" src="bbsimages/rightadd.jpg" style="height:400px;width:185px;" border="0" /> -->
    </div>
    <!-- left content body div End -->
</div>
<!-- main content body div End -->
<div style="clear:both"> </div>
<br />
<a title="Previous page" id="pagenavv" style="color:#046dbe;;display:none;padding-left:10px" href="javascript:return false;" onclick="hideAll();event.returnValue=false;return false;">Back</a>
<script type="text/javascript">
    var tce=new Date();
    var catEnd=tce.getTime();
</script>
<script type="text/javascript">
    var tlas=new Date();
    var laStart=tlas.getTime();
</script>
<div class="line"> </div>
<script type="text/javascript">
    var tbps=new Date();
    var ccStart=tbps.getTime();
    CallCurveCorners();
    var tbpe=new Date();
    var ccEnd=tbpe.getTime();
</script>
<div id="latestads" ><img id="laimg" src="bbsimages/after_img.jpg" height="31px" width="745px" alt="http://bharatbuysell.com" style="border:none"/></div>
<!-- latest ads  -->

<div id="la" style="width:100%">            <!-- main latest ads body div start -->
    <jsp:include page='/WEB-INF/jsp/latestAds.jsp'/>
</div>
<script type="text/javascript">
    var tlae=new Date();
    var laEnd=tlae.getTime();
</script>


