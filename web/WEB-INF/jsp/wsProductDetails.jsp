<%--
    Document   : wsProductDetails
    Created on : Feb 25, 2010, 10:44:53 AM
    Author     : bbsadmin
--%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<script type="text/javascript" src="js/curvycorners.js"></script>
<%@page import="java.util.StringTokenizer" %>
<script>
    function showDiv1(){
    <%--alert("d1");--%>
            document.getElementById("spec").style.display='inline';
            var dv=document.getElementById("div21").getElementsByTagName("a");
            dv[0].setAttribute("class", "selected");
            document.getElementById("acc").style.display='none';
            dv=document.getElementById("div22").getElementsByTagName("a");
            dv[0].setAttribute("class", "");
        }
        function showDiv2(){
    <%--alert("d2");--%>
            document.getElementById("acc").style.display='inline';
            var dv=document.getElementById("div22").getElementsByTagName("a");
            dv[0].setAttribute("class", "selected");
            document.getElementById("spec").style.display='none';
            dv=document.getElementById("div21").getElementsByTagName("a")
            dv[0].setAttribute("class", "");
        }
</script>
<style>
    #div2{
        width:100%;
        float:left;
        margin-top:20px;
        margin-left:12px;
        color:gray;
        font-size:12px;
    }
    #div2 a{
        color:gray;
        text-decoration:none;
    }
    #div21 a,#div22 a{
        padding-left:4px;
        height:25px;
        display:block;
        background:transparent url(bbsimages/tableft.gif) no-repeat scroll left top;
    }
    #div21 a.selected,#div22 a.selected{
        color:white;
        background:transparent url(bbsimages/tableftActive.gif) no-repeat scroll left top;
    }
    #div21 a span,#div22 a span{
        padding:5px 5px;
        height:25px;
        display:block;
        background:transparent url(bbsimages/tabright.gif) no-repeat scroll right top;
    }
    #div21 a.selected span,#div22 a.selected span{
        background:transparent url(bbsimages/tabrightActive.gif) no-repeat scroll right top;
    }
    #mainDiv p{
        margin-bottom:5px;font-size:11px;
    }
    #acShDesc a{
        color:#4D9EDF;
    }
    #acShDesc a:hover{
        text-decoration:underline;
    }
</style>
<script  type="text/javascript">
hs.graphicsDir = 'highslide/graphics/';
hs.align = 'center';
hs.transitions = ['expand', 'crossfade'];
hs.fadeInOut = true;
hs.outlineType = 'rounded-black';
hs.wrapperClassName = 'dark';
hs.captionEval = 'this.a.title';
hs.numberPosition = 'caption';
hs.useBox = true;
hs.width = 600;
hs.height = 400;

//hs.dimmingOpacity = 0.8;


// Add the slideshow providing the controlbar and the thumbstrip

 hs.addSlideshow({

//slideshowGroup: 'group1',
interval: 3000,
repeat: true,
useControls: true,
fixedControls: 'fit',
overlayOptions: {
position: 'bottom right',
opacity: .75,
offsetY:'60',
hideOnMouseOut: true
},

thumbstrip: {
position: 'above',
mode: 'horizontal',
relativeTo: 'expander'
}

});


// Make all images animate to the one visible thumbnail

var miniGalleryOptions1 = {
    thumbnailId: 'thumb1'
}
function imgGall(){
    return hs.expand(document.getElementById('thumb1'), miniGalleryOptions1);
}
</script>
<div id="mainDiv" style="margin-top:10px;width:95%;color:#5B5B5B;">
    <c:if test="${prod!=null}">
        <div style="margin-top:48px;">
                <div style="float:left;width:50%;margin-left:10px;">
                    <img alt="${prod.name} image" src="resourceGetter?imd=${dealerWebsite.path}${fn:split(prod.imageLocation,'|')[0]}" border="0" style="height:240px;width:240px"/>
                </div>
                <div style="font-size:11px;float:left">
                    <h2 style="font-size:12px;font-weight:bold;margin:0 0 6px;color:#4d9edf">${prod.name}</h2>
                    <p>${prod.modelId}</p>
                    <c:if test="${prod.shortSpecifics!=null}">
                        <ul style="padding-left:12px;">
                            <c:set var="hh1" value="${prod.shortSpecifics}"/>
                            <c:set var="i" value="1"/>
                            <% String str = (String) pageContext.getAttribute("hh1");
                               StringTokenizer st = new StringTokenizer(str, "^^");
                               while (st.hasMoreTokens()) {
                               String val = st.nextToken();%>
                            <li><%= val%></li>
                            <c:set var="i" value="${i+1}"/><%}
                            %> </ul>
                    </c:if>
                    <span style="font-size:14px;color:#999999;font-weight:bold">
                        <c:if test="${prod.offerPrice!=0}">${prod.currency} ${prod.offerPrice} inc. VAT<br/></c:if>
                        <c:if test="${prod.offerPrice==0 && prod.discount!=0 && prod.actualPrice!=0}">${prod.currency} ${prod.actualPrice-prod.discount} inc. VAT<br/></c:if>
                    </span>
                    <c:if test="${prod.actualPrice!=0}">
                        <span style="color:#FA6C30;font-size:12px;font-weight:bold">
                            <c:choose>
                                <c:when test="${prod.offerPrice!=0 || prod.discount!=0}">
                                    <strike style="font-weight:normal">${prod.currency} <span style="font-size:14px">${prod.actualPrice}</span> inc. VAT</strike>
                                    <c:if test="${prod.offerTill!=null}"><br/><br/><span style="color:#5B5B5B">Offer Till ${prod.offerTill}</span></c:if>
                                </c:when>
                                <c:otherwise>
                                    ${prod.currency} ${prod.actualPrice} inc. VAT
                                </c:otherwise>
                            </c:choose>
                        </span><br/>
                    </c:if>
                    <%--<span style="font-size:80%"><a href="#" >Add to Basket</a></span>--%>
                    <p>${prod.stockStatus}.</p>
            </div>
            <div style="clear:both"></div>
            <div class="highslide-gallery">
                <c:set var="hh1" value="${prod.imageLocation}"/>
                <div class="hidden-container">
                <% String imgStr = (String) pageContext.getAttribute("hh1");
                    StringTokenizer imgSt1 = new StringTokenizer(imgStr, "|");
                    int cn=1;
                    while (imgSt1.hasMoreTokens()) {
                    String imgval = imgSt1.nextToken();if(cn==2){%>
                    <a class='highslide' title="${prod.name}" id="thumb1" href='resourceGetter?imd=${dealerWebsite.path}${fn:split(prod.imageLocation,'|')[1]}' onclick="return hs.expand(this, miniGalleryOptions1);" style="padding-left:20px;"><img src="resourceGetter?imd=${dealerWebsite.path}${fn:split(prod.imageLocation,'|')[1]}"/></a><br/>

                    <%}else if(cn>2){%>
                    <a class='highslide' title="${prod.name}" href='resourceGetter?imd=${dealerWebsite.path}<%=imgval%>' onclick="return hs.expand(this, miniGalleryOptions1)">
                    <img src='resourceGetter?imd=${dealerWebsite.path}<%=imgval%>' alt=''/>
                    </a>
                    <%}cn=cn+1;}%>
                </div>
            </div><br/>
            <% if(cn>=3){%>
            <a href="#" onclick="imgGall();" style="padding-left:20px;color:#4d9edf;font-size:12px;"> > Photo Gallery</a><br/>
            <%}%>
        </div>

        <%--start of second div--%>

        <div id="div2">
            <c:if test="${prod.longSpecifics!=null&&fn:length(prod.longSpecifics)>0}"><div id="div21" style="float:left"><a href="javascript:showDiv1();"  title="specifications"><span>Specifications</span></a></div></c:if>
            <c:if test="${prod.accessories!=null&&fn:length(prod.accessories)>0}"><div id="div22" style="float:left"><a href="javascript:showDiv2();" title="accessory"><span>Suggested Accessories</span></a></div></c:if>

            <c:if test="${prod.longSpecifics!=null&&fn:length(prod.longSpecifics)>0}">
            <div id="spec" class="ccsa" style="width:98%;float:left;border:1px solid #cccccc;height:auto;display:none;margin-bottom:25px">
                    <c:set var="hh1" value="${prod.longSpecifics}"/>
                    <% String str1 = (String) pageContext.getAttribute("hh1");
                       int m=1;
                       StringTokenizer st1 = new StringTokenizer(str1, "^^");
                       while (st1.hasMoreTokens()) {
                       String val = st1.nextToken();
                         if((m%2)!=0){
                    %>
                    <div style="background-color:#FFFFFF;height:auto;max-height:55px;border-bottom:1px solid #e1e1e1;padding:5px 0"><span style="margin-left:10px"><%=val%></span></div>

                    <%} else {%>
                    <div style="background-color:#EEEEEE;height:auto;max-height:55px;border-bottom:1px solid #e1e1e1;padding:5px 0"><span style="margin-left:10px;color:gray"><%=val%></span></div>
                        <%}
                        m=m+1;
                      }%>
            </div>
            </c:if>

            <c:if test="${prod.accessories!=null&&fn:length(prod.accessories)>0}">
            <div id="acc" class="ccsa" style="width:98%;height:auto;float:left;display:none;border:1px solid #cccccc;margin-bottom:25px;background:#FFFFFF none;">
                <div style="width:98%;float:left;border-bottom:1px solid #E1E1E1;height:20px;padding:5px 0 0 12px;">Accessories for <span style="color:#4D9EDF;">${prod.name} ${prod.modelId}</span></div><div style="clear:both"></div>
                <div style="width:100%;float:left;border-bottom:1px solid #E1E1E1;height:20px;color:#4D9EDF">
                    <div style="float:left;width:20%;height:100%;border-right:1px solid #E1E1E1"></div>
                     <div style="float:left;width:20%;height:90%;border-right:1px solid #E1E1E1;padding:2px 0 0 5px;">Products</div>
                     <div style="float:left;width:38%;height:90%;border-right:1px solid #E1E1E1;padding:2px 0 0 5px;">Description</div>
                     <div style="float:left;width:18%;height:90%;padding:2px 0 0 5px;">Price</div>
                </div><div style="clear:both"></div>
                            <c:set var="hh1" value="${prod.accessories}"/>
                            <c:set var="i" value="1"/>
                            <% String str2 = (String) pageContext.getAttribute("hh1");
                               StringTokenizer st2 = new StringTokenizer(str2, "|");
                               int m2=1;
                               while (st2.hasMoreTokens()) {
                               String val = st2.nextToken();%>
                                <c:set var="pa"><%=val%></c:set>
                                <%if((m2%2)!=0){%>
                                     <c:set var="chk" value="0"/> <%-- This variable is used for breaking the forEach loop if product is shown once--%>
                                     <c:forEach items="${wsProducts}" var="wsp">
                                         <c:if test="${wsp.prodId==pa&&wsp.status==1&&chk==0}">
                                             <c:set var="chk" value="1"/>
                                             <div style="background-color:#FFFFFF;height:65px;max-height:95px;border-bottom:1px solid #E1E1E1;font-size:12px;">
                                                 <div style="float:left;width:20%;height:100%;border-right:1px solid #E1E1E1"><a href="newProdDet.do?prodId=${wsp.prodId}"><img src="resourceGetter?imd=${dealerWebsite.path}${fn:split(wsp.imageLocation,'|')[0]}" width="98%" height="98%"/></a></div>
                                                 <div style="float:left;width:20%;height:100%;border-right:1px solid #E1E1E1;color:#4D9EDF;padding:2px 0 0 5px;">${wsp.name}</div>
                                                 <div id="acShDesc" style="float:left;width:38%;height:100%;border-right:1px solid #E1E1E1;color:#4D9EDF;padding:2px 0 0 5px;"><a href="newProdDet.do?prodId=${wsp.prodId}">${wsp.shortDesc}</a><br/><div style="color:black;font-size:11px;padding-top:12px;">${wsp.stockStatus}</div></div>
                                                 <div style="float:left;width:18%;height:100%;padding:2px 0 0 5px;">
                                                     <span style="font-size:11px;color:#4D9EDF;">
                                                        <c:if test="${wsp.offerPrice!=0}">${wsp.currency} ${wsp.offerPrice} inc. VAT<br/></c:if>
                                                        <c:if test="${wsp.offerPrice==0 && wsp.discount!=0 && wsp.actualPrice!=0}">${wsp.currency} ${wsp.actualPrice-wsp.discount} inc. VAT<br/></c:if>
                                                    </span>
                                                    <c:if test="${wsp.actualPrice!=0}">
                                                        <span style="color:#FA6C30;font-size:10px;">
                                                            <c:choose>
                                                                <c:when test="${wsp.offerPrice!=0 || wsp.discount!=0}">
                                                                    <strike>${wsp.currency} <span style="font-size:11px">${wsp.actualPrice}</span> inc. VAT</strike>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    ${wsp.currency} ${wsp.actualPrice} inc. VAT
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </span><br/>
                                                    </c:if>
                                                 </div>
                                             </div><div style="clear:both"></div>
                                         </c:if>
                                     </c:forEach>
                                <% }else{%>
                                     <c:set var="chk" value="0"/> <%-- This variable is used for breaking the forEach loop if product is shown once--%>
                                     <c:forEach items="${wsProducts}" var="wsp">
                                         <c:if test="${wsp.prodId==pa&&wsp.status==1&&chk==0}">
                                             <c:set var="chk" value="1"/>
                                             <div style="background-color:#EEEEEE;height:65px;max-height:95px;border-bottom:1px solid #E1E1E1;font-size:12px;">
                                                 <div style="float:left;width:20%;height:100%;border-right:1px solid #E1E1E1"><a href="newProdDet.do?prodId=${wsp.prodId}"><img src="resourceGetter?imd=${dealerWebsite.path}${fn:split(wsp.imageLocation,'|')[0]}" width="98%" height="98%"/></a></div>
                                                 <div style="float:left;width:20%;height:100%;border-right:1px solid #E1E1E1;color:#4D9EDF;padding:2px 0 0 5px;">${wsp.name}</div>
                                                 <div id="acShDesc" style="float:left;width:38%;height:100%;border-right:1px solid #E1E1E1;color:#4D9EDF;padding:2px 0 0 5px;"><a href="newProdDet.do?prodId=${wsp.prodId}">${wsp.shortDesc}</a><br/><div style="color:black;font-size:11px;padding-top:12px;">${wsp.stockStatus}</div></div>
                                                 <div style="float:left;width:18%;height:100%;padding:2px 0 0 5px;">
                                                     <span style="font-size:11px;color:#4D9EDF;">
                                                        <c:if test="${wsp.offerPrice!=0}">${wsp.currency} ${wsp.offerPrice} inc. VAT<br/></c:if>
                                                        <c:if test="${wsp.offerPrice==0 && wsp.discount!=0 && wsp.actualPrice!=0}">${wsp.currency} ${wsp.actualPrice-wsp.discount} inc. VAT<br/></c:if>
                                                    </span>
                                                    <c:if test="${wsp.actualPrice!=0}">
                                                        <span style="color:#FA6C30;font-size:10px;">
                                                            <c:choose>
                                                                <c:when test="${wsp.offerPrice!=0 || wsp.discount!=0}">
                                                                    <strike>${wsp.currency} <span style="font-size:11px">${wsp.actualPrice}</span> inc. VAT</strike>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    ${wsp.currency} ${wsp.actualPrice} inc. VAT
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </span><br/>
                                                    </c:if>
                                                 </div>
                                             </div><div style="clear:both"></div>
                                         </c:if>
                                     </c:forEach>
                                <%}m2=m2+1;
                               }%>
               </div>
               </c:if>
        </div>
            <c:if test="${prod.longSpecifics!=null&&fn:length(prod.longSpecifics)>0}"><script type="text/javascript">showDiv1();</script></c:if>
            <c:if test="${(prod.longSpecifics==null||fn:length(prod.longSpecifics)==0)&&(prod.accessories!=null&&fn:length(prod.accessories)>0)}"><script type="text/javascript">showDiv2();</script></c:if>
        <script type="text/javascript">
            settings = {
            tl: { radius: 5 },
            tr: { radius: 5 },
            bl: { radius: 5 },
            br: { radius: 5 },
            antiAlias: true,
            autoPad: true,
            validTags: ["div"]
        }
        var myBoxObject = new curvyCorners(settings, "ccsa");
        myBoxObject.applyCornersToAll();
        </script>

    </c:if>
</div>