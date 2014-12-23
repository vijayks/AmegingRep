<%-- 
    Document   : dealerScroll
    Created on : Dec 31, 2009, 5:36:17 PM
    Author     : bbsadmin
--%>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<style>
    .scroll
    {
        margin:5px 0 0 0;
        padding-bottom:1px;
            
        border-bottom:1px double #ffffff;

    }


    .link
    {
        text-decoration:none;font-family:Arial;font-size:11px;color:#ffffff;;
    }
</style>

<div id="datacontainer"  style="background-color:#4D9EDf;position: absolute; left: 0px; top:5px; width: 100%;" onmouseover="scrollspeed=0" onmouseout="scrollspeed=cache">


    <c:if test="${scrollAds != null}" >
        <c:forEach items="${scrollAds}" var="ad">
            <div class="scroll">
                <div style="float:left;width:42px;" >
                     <img src="resourceGetter?imf=${ad.thumbImg}" style="padding-left:5px;width:40px;height:25px" />
                </div>
                <div style="float:right;width:165px;text-align:justify" >
                       <a class="link" href="spoffer.do?sid=${ad.thumbImg}&from=spo" target="_top">
                        <c:out value="${ad.scrTitle}" />
                    </a>
                </div>
                <div style="clear:both"></div>
            </div>


        </c:forEach>
    </c:if>
 <c:if test="${scrollAds != null}" >
        <c:forEach items="${scrollAds}" var="ad">
            <div class="scroll">
                <div style="float:left;width:42px;" >
                     <img src="resourceGetter?imf=${ad.thumbImg}" style="padding-left:5px;width:40px;height:25px" />
                </div>
                <div style="float:right;width:165px;text-align:justify" >
                       <a class="link" href="spoffer.do?sid=${ad.sid}&from=spo" target="_top">
                        <c:out value="${ad.scrTitle}" />
                    </a>
                </div>
                <div style="clear:both"></div>
            </div>


        </c:forEach>
    </c:if>
     <c:if test="${scrollAds != null}" >
        <c:forEach items="${scrollAds}" var="ad">
            <div class="scroll">
                <div style="float:left;width:42px;" >
                     <img src="resourceGetter?imf=${ad.thumbImg}" style="padding-left:5px;width:40px;height:25px" />
                </div>
                <div style="float:right;width:165px;text-align:justify" >
                       <a class="link" href="spoffer.do?sid=${ad.sid}&from=spo" target="_top">
                        <c:out value="${ad.scrTitle}" />
                    </a>
                </div>
                <div style="clear:both"></div>
            </div>


        </c:forEach>
    </c:if>
 <c:if test="${scrollAds != null}" >
        <c:forEach items="${scrollAds}" var="ad">
            <div class="scroll">
                <div style="float:left;width:42px;" >
                     <img src="resourceGetter?imf=${ad.thumbImg}" style="padding-left:5px;width:40px;height:25px" />
                </div>
                <div style="float:right;width:165px;text-align:justify" >
                       <a class="link" href="spoffer.do?sid=${ad.sid}&from=spo" target="_top">
                        <c:out value="${ad.scrTitle}" />
                    </a>
                </div>
                <div style="clear:both"></div>
            </div>


        </c:forEach>
    </c:if>


</div>

<!-- this div is same as the above datacontaier content div , used to make the visibility continious flow... -->

<div id="datacontainer1"  style="background-color:#4D9EDf;position: absolute; left: 0px; top:5px; width: 100%;" onmouseover="scrollspeed=0" onmouseout="scrollspeed=cache">
    <c:if test="${scrollAds != null}" >
        <c:forEach items="${scrollAds}" var="ad">
            <div class="scroll">
                <div style="float:left;width:42px;" >
                    <img src="resourceGetter?imf=${ad.thumbImg}" style="padding-left:5px;width:40px;height:25px" />
                </div>
                <div style="float:right;width:165px;text-align:justify" >
                    <a class="link" href="spoffer.do?sid=${ad.sid}&from=spo" target="_top">
                        <c:out value="${ad.scrTitle}" />
                    </a>
                </div>
                <div style="clear:both"></div>
            </div>


        </c:forEach>
    </c:if>

  <c:if test="${scrollAds != null}" >
        <c:forEach items="${scrollAds}" var="ad">
            <div class="scroll">
                <div style="float:left;width:42px;" >
                     <img src="resourceGetter?imf=${ad.thumbImg}" style="padding-left:5px;width:40px;height:25px" />
                </div>
                <div style="float:right;width:165px;text-align:justify" >
                       <a class="link" href="spoffer.do?sid=${ad.sid}&from=spo" target="_top">
                        <c:out value="${ad.scrTitle}" />
                    </a>
                </div>
                <div style="clear:both"></div>
            </div>


        </c:forEach>
    </c:if>
     <c:if test="${scrollAds != null}" >
        <c:forEach items="${scrollAds}" var="ad">
            <div class="scroll">
                <div style="float:left;width:42px;" >
                    <img src="resourceGetter?imf=${ad.thumbImg}" style="padding-left:5px;width:40px;height:25px" />
                </div>
                <div style="float:right;width:165px;text-align:justify" >
                    <a class="link" href="spoffer.do?sid=${ad.sid}&from=spo" target="_top">
                        <c:out value="${ad.scrTitle}" />
                    </a>
                </div>
                <div style="clear:both"></div>
            </div>


        </c:forEach>
    </c:if>

  <c:if test="${scrollAds != null}" >
        <c:forEach items="${scrollAds}" var="ad">
            <div class="scroll">
                <div style="float:left;width:42px;" >
                     <img src="resourceGetter?imf=${ad.thumbImg}" style="padding-left:5px;width:40px;height:25px" />
                </div>
                <div style="float:right;width:165px;text-align:justify" >
                       <a class="link" href="spoffer.do?sid=${ad.sid}&from=spo" target="_top">
                        <c:out value="${ad.scrTitle}" />
                    </a>
                </div>
                <div style="clear:both"></div>
            </div>


        </c:forEach>
    </c:if>
</div>




<script type="text/javascript">
    //Specify speed of scroll. Larger=faster (ie: 5)
    var scrollspeed=cache=1

    //Specify intial delay before scroller starts scrolling (in miliseconds):
    var initialdelay=0

    function initializeScroller(){
        dataobj=document.all? document.all.datacontainer : document.getElementById("datacontainer")
        dataobj1=document.all? document.all.datacontainer1 : document.getElementById("datacontainer1")
        dataobj.style.top=dataobj.offsetHeight
        dataobj1.style.top="0px"
        setTimeout("getdataheight()", initialdelay)
    }
    function getdataheight(){
        thelength=dataobj.offsetHeight
        if (thelength==0)
            setTimeout("getdataheight()",10)
        else
            scrollDiv()
    }
    function scrollDiv(){
        dataobj.style.top=parseInt(dataobj.style.top)-scrollspeed+"px"
        dataobj1.style.top=parseInt(dataobj1.style.top)-scrollspeed+"px"
        if (parseInt(dataobj.style.top)<thelength*(-1))
            dataobj.style.top=dataobj.offsetHeight
        if (parseInt(dataobj1.style.top)<thelength*(-1))
            dataobj1.style.top=dataobj1.offsetHeight
        setTimeout("scrollDiv()",40)
    }
    if (window.addEventListener)
        window.addEventListener("load", initializeScroller, false)
    else if (window.attachEvent)
        window.attachEvent("onload", initializeScroller)
    else
        window.onload=initializeScroller

</script>


