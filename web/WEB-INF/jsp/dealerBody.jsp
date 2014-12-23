<%-- 
    Document   : dealerBody
    Created on : Dec 24, 2009, 4:30:21 PM
    Author     : bbsadmin
--%>

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
    var subMore =new Array();
    var subLink =new Array();
    var hideMore=new Array();
    var hideLink=new Array();
    var cnt=0;
    var cntm=0;
    var cnth=0;
    var cnt1=0;

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
</script>
<div id="maincontentbody">            <!-- main content body div start -->
    <div id="leftcontentbody" >            <!-- left content body div start -->
        <c:if test='${categoryList != null}' >
             <c:set var="i" value="0" />
            <c:forEach items="${categoryList}" var="category" >
                <c:if test='${category.parent == 0}' >
                            <c:set var="i"  value="${i + 1}" />
                            <div   id="content1" style="margin-left:7px;margin-top:1px;">
                                <span class="verdana_automobile" style="padding:0 0 0 3px" ><c:out value="${category.name}" escapeXml="false"/></span>
                                <div class="myBox" style="">
                                    <img src="resourceGetter?imf=<c:out value='${category.imagePath}'/>" style="width:167px;padding-left:2px;height:50px" align="center" alt='<c:out value="${category.name}" escapeXml="false"/>'> <!-- here we insert image -->
                                    <div  id="content2"   style="margin-top:4px;">
                                        <div id="o<c:out value='${category.name}' />" class="fv12" style="float:left;width:100%" >
                                            <c:if test="${category.subCategories != null}">
                                                <c:forEach items="${category.subCategories}" var ="cat"  varStatus="loop1" >
                                                    <c:if test="${loop1.index <= 5}">
                                                        <div style="float:left;width:167px">
                                                            <div style="float:left;width:17px"><img src="bbsimages/innerimage.gif" border="0" alt="-" style="height:9px;width:13px;"/></div>
                                                            <div style="float:left;width:150px">
                                                                <a title="<c:out value="${cat.name}" escapeXml="false"/>" class="link11"  href="dealers.do?subCatId=<c:out value="${cat.id}" />&start=0&range=20&byO=1"><c:out value="${cat.name}" escapeXml="false"/> </a>
                                                            </div>
                                                        </div>
                                                    </c:if>
                                                </c:forEach>
                                                        <c:set var="len"> <c:out value="${fn:length(category.subCategories)}"/></c:set>
                                                        <c:if test="${len > 6 }" >
                                                            <a title="Browse More" id="ol<c:out value="${category.name}" />" href="javascript:return false" class="more" onclick="openCatb('h<c:out value="${category.name}" />','ol<c:out value="${category.name}" />');event.returnValue=false;return false;">More... </a>
                                                    <!-- this script block used to store all the id of the subcat display div in order to open one more option at a time -->
                                                    <script type="text/javascript">
                                                        subMore[cntm]="o${category.name}";
                                                        subLink[cntm]="ol${category.name}";
                                                        cntm++;
                                                    </script>
                                                </c:if>
                                            </c:if>
                                        </div>

                                        <div id="h<c:out value="${category.name}" />" class="fv12"  style="float:left;width:98%;display:none">
                                            <c:if test="${category.subCategories != null}">
                                                <c:forEach items="${category.subCategories}" var ="cat"  varStatus="loop2" >
                                                    <c:if test="${loop2.index > 5}">
                                                        <div style="float:left;width:167px">
                                                            <div style="float:left;width:17px"><img src="bbsimages/innerimage.gif" border="0"  alt="-"  style="height:9px;width:13px;"/></div>
                                                            <div style="float:left;width:150px">
                                                                <a title="<c:out value="${cat.name}" escapeXml="false" />"class="link11"  href="dealers.do?subCatId=<c:out value="${cat.id}" />&start=0&range=20&byO=1"><c:out value="${cat.name}" escapeXml="false" /></a>
                                                            </div>
                                                        </div>
                                                    </c:if>
                                                </c:forEach>
                                                        <c:set var="len"> <c:out value="${fn:length(category.subCategories)}"/></c:set>
                                                        <c:if test="${len > 6 }" >
                                                            <a title="Hide" id="hl${category.name}" href="javascript:return false" class="more" onclick="hideCatb('h${category.name}','ol${category.name}');event.returnValue=false;return false; "> ...Hide </a>
                                                    <script language="javascript">
                                                        hideMore[cnth]="h${category.name}";
                                                        hideLink[cnth]="hl${category.name}";
                                                        cnth++;
                                                    </script>
                                                </c:if>
                                            </c:if>
                                        </div>
                                    </div>

                                </div>
                            </div>
                        <c:if test='${i == 3}'>
                            <c:set var="i" value="0" />
                            <div style="clear:both"></div>
                        </c:if>
                        </c:if>


                </c:forEach >
            </c:if>
    </div>

    <div id="rightcontentadbody" style="margin-top:5px;">
        <img src="bbsimages/rightAd.gif" width="183" height="442" alt="http://bharatbuysell.com" />
        <!--       <img id="BannerAd2" src="bbsimages/rightadd.jpg" style="height:400px;width:185px;" border="0" /> -->
    </div>
    <!-- left content body div End -->
</div>