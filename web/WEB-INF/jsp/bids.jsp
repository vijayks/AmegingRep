<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<script type="text/javascript" src="js/bidAjax.js"></script>
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/jquery.countdown.min.js"></script>
<script type="text/javascript" src="js/curvycorners.js"></script>
<script type="text/javascript" src="js/jq-scroll.js"></script>
<script type="text/javaScript">

    function CallCurveCorners()
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
        var myBoxObject = new curvyCorners(settings, "bidBox");
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
        width:200px;
        float:left;
        height:390px;
        border:1px solid #CCCCCC;
        margin:20px 0px 0px 20px;
        text-align:center;
        font-family:Arial;
	*height:410px;
	*margin-left:15px;
    }
    .bidBox p{
        margin:0 !important;
    }
    .rp {
        vertical-align:sub;
        *vertical-align:inherit;
    }
    .bb {
        margin-top:15px;
        *margin-top:0px;
        *left:0px;
    }
    #bdiv{
        height:auto;
        min-height:810px;
        * height:810px;
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
        if(uidbidder==""){
            putBidMsg(bidId,"Please login to bid","red");
            return hs.htmlExpand( document.getElementById("bidDet"+bidId), { maincontentId: 'login-content',  minWidth: 230, maxWidth:250 } );
        }else if(price==""){
            putBidMsg(bidId,"Please enter bid Price","red");
        } 
        else{
            bidIt(uidbidder,nmbidder,price,bidId);
        }
    }

    function refreshBid(){
        callBidRefresh();
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
    function makeClose(jid){
        var bi=jid;
        var wnr = document.createElement('span');
        wnr.innerHTML="Winner : "+document.getElementById('buName'+bi).innerHTML+"<br/>";
        var wnp = document.createElement('span');
        wnp.innerHTML="Won Price : <img src='bbsimages/rpRed.gif' alt='Rs.' style='height:15px;vertical-align:sub'/>&nbsp;"+document.getElementById('bprice'+bi).innerHTML;
        document.getElementById('bidDet'+bi).innerHTML="";
        document.getElementById('bidDet'+bi).style.color="green";
        document.getElementById('bidDet'+bi).style.fontSize="14px";
        document.getElementById('bidDet'+bi).appendChild(wnr);
        document.getElementById('bidDet'+bi).appendChild(wnp);
    }

    
</script>


<div id="bdiv" style="width:100%;float:left;font-size:12px;" >
	<br/>
	<center><img src="bbsimages/bid_banner.png" style="" alt="Bidding in Bharatbuysell"/></center>
    <div style="margin:20px 10px 0px 10px;border:2px solid #CCCCCC;width:70%;display:block;padding-bottom:10px;float:left;*margin-left:5px;">
        <div style="color:white;font-size:14px;font-weight:bold;background:url(bbsimages/hdr_m.gif) repeat-x;padding:5px 0 0 20px;height:30px;">Live Auctions</div>
        <c:if test="${currentBids!=null&&fn:length(currentBids)>0}">
            <c:set var="i" value="0"/>
            <c:forEach items="${currentBids}" var="cb">
                <c:if test="${cb.status==2}">
                    <div class="bidBox">
                    <script type="text/javascript">
                        $(function () {
                                var bidend${cb.id}='${cb.bidEnd}';
                                var mn${cb.id} = bidend${cb.id}.substr(5, 2);
                                if((mn${cb.id}).substr(0, 1)=="0"){
                                    mn${cb.id} = parseInt((mn${cb.id}).substr(1, 1));
                                }
                                jsid=${cb.id};
                                var austDay${cb.id} = new Date((bidend${cb.id}).substr(0, 4), (mn${cb.id})-1, (bidend${cb.id}).substr(8, 2), (bidend${cb.id}).substr(11, 2), (bidend${cb.id}).substr(14, 2), (bidend${cb.id}).substr(17, 2), (bidend${cb.id}).substr(20, 1));
                                $('#cdBid${cb.id}').countdown({until: austDay${cb.id}, serverSync: getServerTm,layout: getLayout(austDay${cb.id}),expiryText:'<span style="color:red;font-size:14px">Closed</span>',onExpiry: function(){makeClose('${cb.id}')},alwaysExpire:true});
                                 ;
                        });
                    </script>
                        <span style="color:#4d9edf;font-size:13px;height:25px;display:block;*height:35px"><b> ${cb.prodName}</b></span><br/>
                        <p>MRP : <img src="bbsimages/rp1.gif" alt="Rs." style="height:14px;background:none;vertical-align:middle" class="rp"/> <b>${cb.productPrice}</b></p>
                        <br/>
                        <a href="bidMoreDetails.do?bidId=${cb.id}" target="_blank"><img src="resourceGetter?imf=${cb.prodImg}" alt="${cb.prodName}" width="130px" height="70px"  style="padding:10px 0 20px;border:none" title="${cb.prodName}"></a>
                        <p style="display:block">
                            <span style="color:gray;">Time left : </span><span id="cdBid${cb.id}" style="color:red;font:14px bold;"></span>
                        </p>
                        <span style="color:#444444;font-size:11px;font-family:serif;font-weight:100"> <%--<%= new java.text.SimpleDateFormat("MMM dd, yyyy hh:mm a").format(new java.util.Date()) %>--%> <fmt:formatDate pattern="MMM dd, yyyy hh:mm a" value="${cb.bidEnd}" />&nbsp;IST</span><br/>
                        <br/>
                        <div id="bidDet${cb.id}" style="height:95px;display:block">
                            <p style="font-size:14px;font-weight:bold;">
                                Current Bid : <img src="bbsimages/rpRed.gif" alt="Rs." style="height:15px;vertical-align:middle" class="rp"/>&nbsp;<span id="bprice${cb.id}" style="color:#f26522"><c:choose><c:when test="${cb.currentPrice!=null}">${cb.currentPrice}</c:when><c:otherwise>${cb.initialPrice}</c:otherwise></c:choose></span>
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
                            </p><br/>
                        </div>
                        
                        <a href="javascript:void(0);" onclick="bidNow(${cb.id},${cb.currentPrice})"><input type="image" src="bbsimages/bid_now.png" alt="bid" style="border:none;" /></a>
                        <br/><span id="bidMsg${cb.id}" style="font-weight:bold;height:14px;display:block"></span>
                        <div style="width:200px;height:30px;color:white;font-weight:bold;display:block;-moz-opacity:.80; filter:alpha(opacity=80); opacity:.80;position:absolute;z-index:99;" class="bb">
                      <img src="bbsimages/bidBottom.png" alt="MW" usemap="#Map${cb.id}" style="border:none"/>
                      <map name="Map${cb.id}" id="Map${cb.id}"><area shape="rect" coords="0,0,83,22" href="bidMoreDetails.do?bidId=${cb.id}" alt="More Details" target="_blank"/>
                          <area shape="rect" coords="86,0,200,22" href="javascript:void(0);" onclick="addBidWL(${cb.id});" alt="Add to WatchList"/>
                        </map>
                  </div>
                    </div>
                <c:set var="i" value="${i+1}"/><c:if test="${(i/3)==0}"><br/></c:if>
                </c:if>
            </c:forEach><div style="clear:both"></div><script type="text/javascript">refreshBid();</script>
        </c:if>
        <c:if test="${currentBids==null||fn:length(currentBids)==0}">
            <br/><center><span style="color:red">No Live Auctions Found</span></center><br/>
        </c:if>
                </div>
        
        <div style="margin-top:20px;;width:26%;float:left;vertical-align:bottom">
            <c:if test="${comingBids!=null && fn:length(comingBids)>0}">
            <div style="border:5px solid #DDDDDD;width:99%;display:block;padding-bottom:10px;">
                 <div style="color:white;font-size:14px;font-weight:bold;background:url(bbsimages/hdr_o.gif);padding:10px 0 0 20px;height:20px;">Coming Up Auctions</div>
                 <div id="cmBids" style="overflow:hidden">
                    <ul style="list-style-type:none;padding:0px;margin:0px">
                <c:forEach items="${comingBids}" var="cmb">
                    <li><a href="bidMoreDetails.do?bidId=${cmb.id}&f=cm" target="_blank">
                        <div style="border-top:1px solid #DDDDDD;margin-top:5px;margin-bottom:15px;padding-top:5px">
                            <img src="resourceGetter?imf=${cmb.prodImg}" alt="${cmb.prodName}" style="width:80px;height:80px;float:left;padding-top:10px;border:none"/>
                            <div><span style="color:#4d9edf;font-weight:bold;font-size:13px">${cmb.prodName}</span><br/>
                                <p style="margin:0">
                                MRP : <img src="bbsimages/rp1.gif" alt="Rs." style="height:14px;background:none;border:none" class="rp"/><b>${cmb.productPrice}</b><br/>
                                Start Price : <img src="bbsimages/rp1.gif" alt="Rs." style="height:14px;background:none;border:none" class="rp"/><b>${cmb.initialPrice}</b>
                            <br/>
                            </p>
                            <span style="font-size:90%">Starting On : <fmt:formatDate pattern="MMM dd,yyyy hh:mm a" value="${cmb.bidStart}"/></span>
                            </div>
                        </div>
                        </a>
                    </li>
                </c:forEach>
                         </ul>
                    </div>
            </div><br/>
   <%-- <script type="text/javascript">
        $('#cmBids').scrollList('up','105','2000','4');
    </script>--%>
            </c:if>
           <%--     <c:if test="${closedBids!=null}">
            <div style="border:5px solid #DDDDDD;width:99%;display:block;padding-bottom:10px;">
                <div style="color:white;font-size:14px;font-weight:bold;background:url(bbsimages/hdr_o.gif);padding:10px 0 0 20px;height:20px;z-index:1001">Recently Closed Auctions</div>
                <div id="clBids" style="overflow:hidden">
                    <ul style="list-style-type:none;padding:0px;margin:0px;">
                <c:forEach items="${closedBids}" var="clb">
                    <li>
                        <div style="border-top:1px solid #DDDDDD;margin-top:5px;margin-bottom:15px;padding-top:5px;height:100px;">
                            <img src="resourceGetter?imf=${clb.prodImg}" alt="${clb.prodName}" style="width:80px;height:80px;float:left;padding-top:10px"/>
                            <div><span style="color:#4d9edf;font-weight:bold;font-size:13px">${clb.prodName}</span><br/>
                            <div style="margin:10px 0px;">
                                <span style="float:left">Auction Price : <img src="bbsimages/rp1.gif" alt="Rs." style="height:14px;background:none" class="rp"/><b>${clb.wonPrice}</b><br/>
                                    Winner : <span style="text-transform:capitalize">${clb.wonUserName}</span></span>
                                <span style="color:white;background-color:orange;float:right;"><b>&nbsp;<fmt:formatNumber maxFractionDigits="1" value="${((clb.productPrice-clb.wonPrice)/clb.productPrice)*100}"/>%</b><br/>Savings</span><br/>
                            <br/>
                            </div>
                            <span style="font-size:90%">Ended On : <fmt:formatDate pattern="MMM dd,yyyy hh:mm a" value="${clb.bidEndDt}"/></span>
                            </div>
                        </div>
                    </li>
                </c:forEach>
                    </ul>
                    </div>
            </div>
    <script type="text/javascript">
                    $('#clBids').scrollList('up','125','1000','4',false);
    </script>
                </c:if>--%>
        </div>
</div>
            <div id="login-content" style="display:none;background-color:#FFCC33;width:220px;padding:10px 0px">
                <table>
                <tr>
                    <td  width="12%" style="text-align:left">User Id</td>
                    <td ><input style="height:12px;font-size:9px;" id="bidlogin" type="text" /></td>
                </tr><tr>
                    <td  width="12%" style="text-align:left">Password</td>
                    <td><input style="height:12px;font-size:9px;" id="bidpwd" type="password" /></td>
                </tr>
                </table>
                <center><input  type="image" src="bbsimages/buttons/Login.png" onmouseover="this.src='bbsimages/buttons/Login_MouseOver.png';" onmouseout="this.src='bbsimages/buttons/Login.png';" onclick="return isEmptys()" /><br/>New User? <a href="register.do"><u>Register</u></a> Here</center>
            </div>
    <script type="text/javascript">
        CallCurveCorners();
    </script>