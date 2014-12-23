<%--
    Document   : currentOffers
    Created on : Sep 8, 2009, 4:15:38 PM
    Author     : praveen.ch
--%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn"%>
<script type="text/javascript" src="js/curvycorners.js"></script>


<style>

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

    //this function to view all categories...
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
    <div id="leftcontentbodyOffers" >            <!-- left content body div start -->

        <c:if test='${categoryList != null}' >
            <c:set var="i" value="0" />

            <c:forEach items="${categoryList}" var="category" >

                <c:if test='${category.parent == 0}' >
                         <div   id="content1" style="margin-left:9px;margin-top:1px;">
                                <span class="verdana_automobile" style="padding:0 0 0 3px" ><c:out value="${category.name}" escapeXml="false"/></span>
                                <div class="myBox" style="">

                                    <img src="resourceGetter?imf=<c:out value='${category.imagePath}'/>" style="width:167px;padding-left:2px" align="center" > <!-- here we insert image -->
                                    <div  id="content2offers"   style="margin-top:4px;">
                                        <c:set var="morecount" value="0" />
                                        <div id="o<c:out value='${category.name}' />" class="fv12" style="float:left;width:100%" >
                                            <c:if test="${offers != null}">
                                                <c:forEach items="${offers}" var ="off" >
                                                    <c:if test="${off.categoryId == category.id}">
                                                        <c:if test="${morecount <= 3}" >
                                                            <div style="float:left;width:167px">
                                                                <div style="float:left;width:17px"><img src="bbsimages/innerimage.gif" border="0" /></div>
                                                                <div style="float:left;width:150px">
                                                              <a title="<c:out value="${off.scrTitle}" escapeXml="false"/>"class="link11"  href="spoffer.do?sid=<c:out value="${off.sid}" />"><c:out value="${off.scrTitle}" escapeXml="false"/> </a>
                                                                </div>
                                                                <c:set var="morecount" value="${morecount + 1}" />
                                                                <c:set var="catId" value="${off.categoryId}" />
                                                            </div>
                                                        </c:if>
                                                    </c:if>
                                                </c:forEach>
                                             </c:if>
                                            </div>
                                            <c:if test="${morecount > 1}">
                                                <div style="float:left;width:98%">
                                                    <a title="Browse More" href="moreCurrentOffers.do?catId=${catId}" class="more" >More...</a>
                                                </div>
                                            </c:if>
                                        <%--   <div id="h<c:out value="${category.name}" />" class="fv12"  style="float:left;width:98%;display:none">
                                               <c:if test="${category.subCategories != null}">
                                                   <c:forEach items="${category.subCategories}" var ="cat"  varStatus="loop2" >
                                                       <c:if test="${loop2.index > 5}">
                                                           <div style="float:left;width:167px">
                                                               <div style="float:left;width:17px"><img src="bbsimages/innerimage.gif" border="0" /></div>
                                                               <div style="float:left;width:150px">
                                                                   <a class="link11"  href="clf.do?subCatId=<c:out value="${cat.id}" />"><c:out value="${cat.name}" escapeXml="false" /></a>
                                                               </div>
                                                           </div>
                                                       </c:if>
                                                   </c:forEach>
                                                   <c:set var="len"> <c:out value="${fn:length(category.subCategories)}"/></c:set>
                                                   <c:if test="${len > 6 }" >
                                                       <a id="hl<c:out value='${category.name}' />" href="javascript:return false" class="more" onclick="hideCatb('h<c:out value="${category.name}" />','ol<c:out value="${category.name}" />');event.returnValue=false;return false; "> ...Hide </a>
                                                       <script language="javascript">
                       hideMore[cnth]="h${category.name}";
                       hideLink[cnth]="hl${category.name}";
                       cnth++;
                                                       </script>
                                                   </c:if>
                                               </c:if>
                                           </div>--%>


                                    </div>

                                </div>
                            </div>
                                         <c:set var="i"  value="${i + 1}" />
                        </c:if>

                        <c:if test='${i == 4}'>
                            <div style="clear:both"></div>
                        </c:if>

                </c:forEach >
            </c:if>

        </div>
        <!-- left content1 div end -->
    </div>

    <!-- left content body div End -->
</div>
<!-- main content body div End -->
<div style="clear:both"> </div>
<script>
    CallCurveCorners();
</script>
