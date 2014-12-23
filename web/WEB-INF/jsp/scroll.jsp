<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%! String scrollLinkClr="#ffffff";String scrollBBClr="double #ffffff"; String scrollBGClr="#4d9edf"; String scrollTmp=null;%>
<%! public void getScrollPrmtrs(){scrollLinkClr="#ffffff";scrollBBClr="double #ffffff";scrollBGClr="#4d9edf";scrollTmp=null;}%>
        <%getScrollPrmtrs();%>
        <%scrollTmp=(String)request.getParameter("clr");if(scrollTmp!=null)scrollLinkClr=scrollTmp;scrollTmp=null;
        scrollTmp=(String)request.getParameter("bbclr");if(scrollTmp!=null)scrollBBClr=scrollTmp;scrollTmp=null;
        scrollTmp=(String)request.getParameter("scrbgclr");if(scrollTmp!=null)scrollBGClr=scrollTmp;%>
<style>
    .scroll
    {
        margin:5px 0 0 0;
        padding-bottom:1px;

        border-bottom:1px <%=scrollBBClr%>;

    }


    .link
    {
        text-decoration:none;font-family:Arial;font-size:11px;color:<%=scrollLinkClr%>;;
    }
</style>
<c:set var="i" value="1"/>
<c:forEach begin="${i}" end="2" step="1">
<div id="datacontainer${i}"  style="background-color:<%=scrollBGClr%>;position: absolute; left: 0px; top:5px; width: 100%;" onmouseover="scrollspeed=0" onmouseout="scrollspeed=cache">
    <c:choose>
        <c:when test="${scrollAds==null}">
    <c:forEach begin="1" end="8" step="1">
              <div class="scroll">
                <div style="float:left;width:42px;" >
                    <img src="" style="padding-left:5px;width:20px;height:25px" alt="NoImg" />
                </div>
                <div style="float:right;width:165px;text-align:justify" >
                    <span style="color:#FFFFFF;font-size:smaller"> No special offers</span>
                </div>
                <div style="clear:both"></div>
            </div>
    </c:forEach>
        </c:when>

<c:otherwise >
    <c:forEach begin="1" end="4" step="1">
    <c:if test="${scrollAds != null}" >
        <c:forEach items="${scrollAds}" var="ad" >
            <div class="scroll">
                <div style="float:left;width:42px;" >
                    <img src="resourceGetter?imf=${ad.thumbImg}" style="padding-left:5px;width:40px;height:25px" alt="OfferImg"/>
                </div>
                <div style="float:right;width:165px;text-align:justify" >
                    <a title="${ad.scrTitle}"class="link" href="spoffer.do?sid=${ad.sid}&from=spo" target="_top">
                        <c:out value="${ad.scrTitle}" />
                    </a>
                </div>
                <div style="clear:both"></div>
            </div>


        </c:forEach>
    </c:if>
    </c:forEach>
</c:otherwise>
</c:choose>

</div><c:set var="i" value="${i+1}"/>
</c:forEach>


<script type="text/javascript">
    //Specify speed of scroll. Larger=faster (ie: 5)
    var scrollspeed=cache=1

    //Specify intial delay before scroller starts scrolling (in miliseconds):
    var initialdelay=0

    function initializeScroller(){
        dataobj=document.getElementById("datacontainer1");
        dataobj1=document.getElementById("datacontainer2");
        dataobj.style.top=dataobj.offsetHeight;
        dataobj1.style.top="0px";
        setTimeout("getdataheight()", initialdelay);
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

