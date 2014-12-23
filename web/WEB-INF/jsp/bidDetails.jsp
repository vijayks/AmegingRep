<%--
    Document   : bidDetails
    Created on : Sep 29, 2010, 11:27:21 AM
    Author     : bbsadmin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<% pageContext.setAttribute("newLineChar", "\n"); %>
<% pageContext.setAttribute("jstlbr", "<br>"); %>
<script type="text/javascript" src="js/bidAjax.js"></script>
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/jquery.countdown.min.js"></script>
<script type="text/javascript" src="js/curvycorners.js"></script>
<script type="text/JavaScript">

    function CallCurveCorners(id)
    {

        settings = {
            tl: { radius: 5 },
            tr: { radius: 5 },
            bl: { radius: 5 },
            br: { radius: 5 },
            antiAlias: true,
            autoPad: false,
            validTags: ["div"]
        }
        var myBoxObject = new curvyCorners(settings, id);
        myBoxObject.applyCornersToAll();
    }
    function isEmptys()
    {
        var check=true;
        if(document.getElementById('bidlogin').value.length == 0)
        {
           alert("Please enter User Id!");
           check=false;
        }
        else if( document.getElementById('bidpwd').value.length == 0 )
        {   alert("Please enter Password!");
            check=false;
        }
        else if(check != false){

         bidQuickLogin(document.getElementById('bidlogin').value,document.getElementById('bidpwd').value);
        }
        return check;
    }
</script>
<style type="text/css">
    .bidBox {
        width:20%;
        float:left;
        height:300px;
        border:1px solid #CCCCCC;
        margin:20px 0px 0px 30px;
        text-align:center;
    }
    .bidBox p{
        margin:0;
    }
    #imagebox {
         float:left;
         margin:20px 0px 0px 30px;
         padding:0px 10px;
         height:300px;
         width :33%;
    }
    .rp {
        vertical-align:sub;
        *vertical-align:inherit;
    }
    .login-class .highslide-move{
        display:none;
    }
    .login-class .highslide-footer{
        display:none;
    }
    .login-calss{
        background-color:#ffcc33;
    }
</style>
<%!
        long getSysDtLong(){
           return new java.util.Date().getTime();
        }
%>
<script type="text/javascript">
     hs.wrapperClassName = 'login-class';
     var nmbidder='${userBean.firstName}';
    var uidbidder='${userBean.userId}';
    function bidNow(bidId,cprice){
        var price=document.getElementById("bidpr"+bidId).value;
        var nm=nmbidder;
        var uid=uidbidder;
        if(uid==""){
            putBidMsg(bidId,"Please login to bid","red");
            return hs.htmlExpand( document.getElementById("bidDet"+bidId), { maincontentId: 'login-content',  minWidth: 230, maxWidth:230 } );
        }else if(price==""){
            putBidMsg(bidId,"Please enter bid Price","red");
        }
        else{
            bidIt(uid,nm,price,bidId);
        }
    }

    function refreshBid(){
        callSingleBidRefresh('<%=request.getParameter("bidId") %>');
        setTimeout('refreshBid()',2500);
    }
    function getServerTm(){
        var sysD=<%=getSysDtLong()%>;
        return new Date(sysD);
    }
    function getLayout(bidEnDt){
        if(((bidEnDt).getTime()- <%=getSysDtLong()%>)>86400000) {
            return'{dn}{dl} {hn}{hl} {mn}{ml} {sn}{sl} ';
        } else{
            return '{hn}{hl} {mn}{ml} {sn}{sl} ';
        }
    }
    var jsid=0;

    function showImg(divid) {
        var n=document.getElementById('noim').value;
        var i=1;
        for(i=1;i<=n;i++) {
            document.getElementById('im'+i).style.display='none';
        }
        document.getElementById(divid).style.display='inline-block';
    }
</script>
<c:set var="reqId"><%= request.getParameter("bidId") %></c:set>
<c:set var="selectedBid" value="${currentBids}"/>
<c:set var="bidCrSt" value="0"/> <%--live bid--%>
    <% if(request.getParameter("f")!=null && request.getParameter("f").equals("cm")) { %>
<c:set var="selectedBid" value="${comingBids}"/>
<c:set var="bidCrSt" value="1"/> <%--future bid--%>
        <%}%>


<c:if test="${selectedBid!=null}">
    <div style="font-size:12px;font-family:Arial">
    <c:set var="flag" value="false"/>
            <c:forEach items="${selectedBid}" var="cb">
                <c:if test="${cb.id==reqId}"><c:set var="flag" value="true"/>
                    <div id="imagebox">
                    <%--<img src="resourceGetter?imf=${cb.prodImg}" alt="${cb.prodName}" width="330px" height="200px"  style="padding:20px 0 20px;border:none;" title="${cb.prodName}"/>--%>
                    <c:if test="${cb.images!=null}">
                        <c:set var="ic" value="1"/>
                    <c:forTokens items="${cb.images}" delims="^^^" var="imag">
                        <div id="im${ic}" style="display:none;width:330px;height:220px;">
                                <img src="resourceGetter?imf=${imag}"  style="width:330px;height:220px" alt="Image${ic}"/>
                        </div>
                        <c:set var="ic" value="${ic+1}"/>
                    </c:forTokens>
                       <c:set var="ic" value="1"/>
                    <div style="width:98%;height:60px;">
                        <ul style="list-style-type:none;padding:0px;">
                        <c:forTokens items="${cb.images}" delims="^^^" var="imag">
                            <li  style="border:1px solid silver;margin-left:10px;float:left;padding:5px;">
                                <a title="${cb.prodName}" href="javascript:void(0)" onclick="showImg('im${ic}');" >
                                    <img src="resourceGetter?imf=${imag}"  style="width:75px;height:50px;border:none" alt="Image${ic}"/>
                                </a>
                            </li>
                        <c:set var="ic" value="${ic+1}"/>
                        </c:forTokens>
                        </ul>
                    </div>
                        <input type="hidden" id="noim" value="${ic-1}">
                        <script type="text/javascript">showImg('im1');</script>
                    </c:if>
                    </div>
                    <div class="bidBox">
                    <script type="text/javascript">
                        $(function () {
                            <c:choose>
                            <c:when test="${bidCrSt==0}">
                                var bidend${cb.id}='${cb.bidEnd}';
                             </c:when>
                            <c:otherwise>
                                var bidend${cb.id}='${cb.bidStart}';
                            </c:otherwise>
                            </c:choose>
                                var mn${cb.id} = bidend${cb.id}.substr(5, 2);
                                if((mn${cb.id}).substr(0, 1)=="0"){
                                    mn${cb.id} = parseInt((mn${cb.id}).substr(1, 1));
                                }
                                jsid=${cb.id};
                                var austDay${cb.id} = new Date((bidend${cb.id}).substr(0, 4), (mn${cb.id})-1, (bidend${cb.id}).substr(8, 2), (bidend${cb.id}).substr(11, 2), (bidend${cb.id}).substr(14, 2), (bidend${cb.id}).substr(17, 2), (bidend${cb.id}).substr(20, 1));
                                $('#cdBid${cb.id}').countdown({until: austDay${cb.id}, serverSync: getServerTm,layout: getLayout(austDay${cb.id}),expiryText:'<span style="color:red;font-size:14px">Closed</span>',onExpiry: makeClose,alwaysExpire:true});
                        });
                    </script>
                        <span style="color:#4d9edf;font-size:13px;height:25px;display:block"><b> ${cb.prodName}</b></span><br/>
                        <p>MRP : <img src="bbsimages/rp1.gif" alt="Rs." style="height:14px;background:none;" class="rp"/> <b>${cb.productPrice}</b></p>
                        <br/>
                        <p style="display:block">
                            <span style="color:gray;">Time left : </span><span id="cdBid${cb.id}" style="color:red;font:14px bold;"></span>
                        </p>
                        <c:choose>
                            <c:when test="${bidCrSt==0}">
                        <span style="color:#444444;font-size:11px;font-family:serif;font-weight:100"> <%--<%= new java.text.SimpleDateFormat("MMM dd, yyyy hh:mm a").format(new java.util.Date()) %>--%> <fmt:formatDate pattern="MMM dd, yyyy hh:mm a" value="${cb.bidEnd}" />&nbsp;IST</span><br/>
                        <br/>
                        <div id="bidDet${cb.id}" style="height:95px;display:block">
                            <p style="font-size:14px;font-weight:bold">
                                Current Bid : <img src="bbsimages/rpRed.gif" alt="Rs." style="height:15px;" class="rp"/>&nbsp;<span id="bprice${cb.id}" style="color:#f26522"><c:choose><c:when test="${cb.currentPrice!=null}">${cb.currentPrice}</c:when><c:otherwise>${cb.initialPrice}</c:otherwise></c:choose></span>
                            </p>
                            <p style="margin-top:5px">Last Bidder : <span id="buName${cb.id}" style="text-transform:capitalize"><c:choose><c:when test="${cb.bidderName!=null}">${cb.bidderName}</c:when><c:otherwise>Admin</c:otherwise></c:choose></span></p><br/>
                            <form action="javascript:void(0)" onsubmit="bidNow(${cb.id},${cb.currentPrice});">
                            <p style="font-size:14px;font-weight:bold">
                                    Bid Amount : <input type="text" name="bidpr${cb.id}" id="bidpr${cb.id}" style="width:75px;height:15px"/>
                            </p>
                            </form>
                            <p style="font-size:12px;color:#f26522;margin-top:5px;">
                                <c:if test="${cb.bidLimit==1}">Next Bid Range : <span id="bidLm${cb.id}"></span>
                                    <script type="text/javascript">
                                        var cp${cb.id} = document.getElementById("bprice${cb.id}").innerHTML;
                                        var icp${cb.id} = parseFloat(cp${cb.id});
                                        var llp${cb.id} = ((icp${cb.id}))+parseFloat(((${cb.initialPrice})*(${cb.lowerLimit}))/100);
                                        var ulp${cb.id} = ((icp${cb.id}))+parseFloat(((${cb.initialPrice})*(${cb.upperLimit}))/100);
                                        document.getElementById("bidLm${cb.id}").innerHTML=(llp${cb.id})+' - '+(ulp${cb.id});
                                    </script>
                                </c:if>
                            </p>
                        </div><br/>

                        <a href="javascript:void(0);" onclick="bidNow(${cb.id},${cb.currentPrice})"><input type="image" src="bbsimages/bid_now.png" alt="bid" style="border:none;" /></a>
                        <br/><span id="bidMsg${cb.id}" style="font-weight:bold;height:14px;display:block;margin-top:15px;"></span>
                            </c:when>
                            <c:otherwise>
                                Auction Starts at <br/>
                                <span style="color:#444444;font-size:11px;font-family:serif;font-weight:100"> <fmt:formatDate pattern="MMM dd, yyyy hh:mm a" value="${cb.bidStart}" />&nbsp;IST</span><br/>
                                <br/>
                                <p style="font-size:14px;font-weight:bold">
                                    Initial Price : <img src="bbsimages/rpRed.gif" alt="Rs." style="height:15px;" class="rp"/>&nbsp;<span id="bprice${cb.id}" style="color:#f26522">${cb.initialPrice}</span>
                                </p>
                                <p style="margin-top:5px">Last Bidder : No Bids Yet</p><br/>
                                <span style="font-size:3em;color:#4d9edf;">Coming Soon</span>
                            </c:otherwise>
                        </c:choose>
                  <%--<div style="width:200px;height:30px;margin-top:15px;color:white;font-weight:bold;display:block;-moz-opacity:.80; filter:alpha(opacity=80); opacity:.80;position:absolute;z-index:99">
                      <img src="bbsimages/bidBottom.png" alt="MW" usemap="#Map${cb.id}" style="border:none"/>
                      <map name="Map${cb.id}" id="Map${cb.id}"><area shape="rect" coords="0,0,83,22" href="bidMoreDetails.do?bidId=${cb.id}" alt="More Details"/>
                          <area shape="rect" coords="86,0,200,22" href="javascript:void(0);" onclick="addBidWL(${cb.id});" alt="Add to WatchList"/>
                        </map>
                  </div>--%>
                    </div>
                    <div class="bidHistoryBox" style="float:left;margin-left:30px;margin-top:20px;border:1px solid #CCCCCC;width:32%">
                        <span style="font-size:14px;font-weight:bold;margin-left:100px;">Bidding History</span>
                        <table id="bidHistory" style="color:black;width:100%;text-align:center;border-top:1px solid gray" cellpadding="2" cellspacing="5">
                            <tr>
                                <th>Bidder</th>
                                <th>Bid Price</th>
                                <th>Bid Time</th>
                            </tr>
                            <c:forEach items="${cb.bidDetails}" var="bd">
                                <c:if test="${bd.currentPrice!=0}">
                                    <tr bgcolor="#EEEEEE">
                                    <td>${bd.bidderName}</td>
                                    <td>${bd.currentPrice}</td>
                                    <td>${bd.biddingTime}</td>
                                </tr>
                                </c:if>
                            </c:forEach>
                        </table>
                        <script type="text/javascript">
                            CallCurveCorners('bidHistoryBox');
                        </script>
                    </div>
                    <div style="clear:both"></div>
                    <div class="bidDetailsBox" style="margin:40px 0 0 40px;width:95%;">
                        <div style="padding:5px 5px 0px 10px">
                        <h2 style="margin-bottom:0px;font-size:18px">Product Description</h2>
                        <br/><c:out value="${fn:replace(cb.description,newLineChar,jstlbr)}" escapeXml="false"/><br/><br/>
                        <c:if test="${cb.shortSpecs!=null&&fn:length(cb.shortSpecs)>0}">
                        <h2 style="margin-bottom:0px;font-size:18px">Important Specifications</h2>
                        <c:forTokens items="${cb.shortSpecs}" delims="^^^" var="ss">
                        <br/>${ss}
                        </c:forTokens><br/><br/>
                        </c:if>
                        <c:if test="${cb.longSpecs!=null&&fn:length(cb.longSpecs)>0}">
                            <h2 style="margin-bottom:0px;font-size:18px">Specifications</h2>
                        <c:forTokens items="${cb.longSpecs}" delims="^^^" var="ls">
                        <br/>> <c:out value="${fn:replace(ls,newLineChar,jstlbr)}" escapeXml="false" /><br/>
                        </c:forTokens><br/>
                        </c:if>
                        </div>
                    </div>
                </c:if>
            </c:forEach><div style="clear:both"></div><c:if test="${bidCrSt==0}"><script type="text/javascript">refreshBid();</script></c:if>
            <script type="text/javascript">
        CallCurveCorners('bidBox');
    </script>
    </div>
        </c:if>
<div id="login-content" style="display:none;background-color:#FFCC33;width:220px;">
        <table>
        <tr>
            <td  width="12%" style="text-align:left">User Id</td>
            <td ><input style="height:12px;font-size:9px;" id="bidlogin" type="text" /></td>
        </tr><tr>
            <td  width="12%" style="text-align:left">Password</td>
            <td><input style="height:12px;font-size:9px;" id="bidpwd" type="password" /></td>
        </tr>
        </table>
        <center><input  type="image" src="bbsimages/buttons/Login.png" onmouseover="this.src='bbsimages/buttons/Login_MouseOver.png';" onmouseout="this.src='bbsimages/buttons/Login.png';" onclick="return isEmptys()" /></center>
    </div>
<c:if test="${!flag}"><center><span style="color:red">No Details Found</span></center></c:if><br/><br/>
<script type="text/javascript">
    function makeClose(){
        <c:choose>
        <c:when test="${bidCrSt==0}">
        var bi=jsid;
        var wnr = document.createElement('span');
        wnr.innerHTML="Winner : "+document.getElementById('buName'+bi).innerHTML+"<br/>";
        var wnp = document.createElement('span');
        wnp.innerHTML="Win Price : "+document.getElementById('bprice'+bi).innerHTML;
        document.getElementById('bidDet'+bi).innerHTML="";
        document.getElementById('bidDet'+bi).appendChild(wnr);
        document.getElementById('bidDet'+bi).appendChild(wnp);
        </c:when>
        <c:otherwise>
            document.location="bidMoreDetails.do?bidId="+<%= request.getParameter("bidId") %>;
        </c:otherwise>
        </c:choose>
    }

</script>