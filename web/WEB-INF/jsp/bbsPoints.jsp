<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page  import="com.buysell.beans.AdsResultsBean " %>
<%@page  import="java.io.OutputStream " %>
<%@page  import="java.io.FileInputStream " %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<script type="text/javascript" src="js/tooltip.js"></script>
<script type="text/javascript">


    window.onload = function() {

        document.getElementById('scroller').innerHTML = '<marquee id="marquee" onmouseover="this.stop()" width="440px" onmouseout="this.start()" scrollAmount="4">'+document.getElementById('scroller').innerHTML+'</marquee>';
        document.getElementById('marquee').start()

    }
    function moveRight()
    {
        document.getElementById('marquee').direction="right";

    }
    function moveLeft()
    {
        document.getElementById('marquee').direction="left";

    }
</script>
<div style="padding-top:15px;padding-bottom:5px;width:100%"  class="verdana_form_mainhead"><b>BBS Points</b></div>

<div class="boxBorder2" style="width:710px;float:left;background-color:#F1F1EB;">
    <div style="float:left;width:auto">
        <img alt=""  src="bbsimages/arrow_left.png" onmouseover="moveLeft()" style="height:85px" />
    </div>

    <div id="scroller" style="width:440px;float:left;background-color:#FFFFFF;">
        <img alt="" src="images/SpecialAd.png" />
        <img alt="" src="images/Cap.png" />
        <img alt="" src="images/TShirt.png" />
        <img alt="" src="images/CoffeeMug.png" />
        <img alt="" src="images/TravellingBag.png" />
        <img alt="" src="images/Ipod.png" />
        <img alt="" src="images/SpecialAd.png" />
        <img alt="" src="images/Cap.png" />
        <img alt="" src="images/TShirt.png" />
        <img alt="" src="images/CoffeeMug.png" />
        <img alt="" src="images/TravellingBag.png" />
        <img alt="" src="images/Ipod.png" />
        <img alt="" src="images/SpecialAd.png" />
        <img alt="" src="images/Cap.png" />
        <img alt="" src="images/TShirt.png" />
        <img alt="" src="images/CoffeeMug.png" />
        <img alt="" src="images/TravellingBag.png" />
        <img alt="" src="images/Ipod.png" />
        <img alt="" src="images/SpecialAd.png" />
        <img alt="" src="images/Cap.png" />
        <img alt="" src="images/TShirt.png" />
        <img alt="" src="images/CoffeeMug.png" />
        <img alt="" src="images/TravellingBag.png" />
        <img alt="" src="images/Ipod.png" />
        <img alt="" src="images/SpecialAd.png" />
        <img alt="" src="images/Cap.png" />
        <img alt="" src="images/TShirt.png" />
        <img alt="" src="images/CoffeeMug.png" />
        <img alt="" src="images/TravellingBag.png" />
        <img alt="" src="images/Ipod.png" />
        <img alt="" src="images/SpecialAd.png" />
        <img alt="" src="images/Cap.png" />
        <img alt="" src="images/TShirt.png" />
        <img alt="" src="images/CoffeeMug.png" />
        <img alt="" src="images/TravellingBag.png" />
        <img alt="" src="images/Ipod.png" />



    </div>
    <div style="float:left;width:auto">
        <img alt=""src="bbsimages/arrow_right.png"  onmouseover="moveRight()" style="height:85px"/>
    </div>

    <div class="fv11b" style="width:210px;float:left;background-color:#F1F1EB;padding:20px 0 0 5px">
        <table style="" >
            <tr>
                <td>Total earnings till date </td>
                <td>: <%= request.getAttribute("earned")%></td>
            </tr>
            <tr>
                <td>Current Balance</td>
                <td>: <%= request.getAttribute("current")%></td>
            </tr>
            <tr>
                <td>Redeemed till now </td>
                <td>: <%= request.getAttribute("redemned")%></td>
            </tr>
        </table>
    </div>

</div>

<div class="clear"> </div>

<div style="width:100%;float:left;padding-top:15px;">
    <logic:present name="BbsPointsResults">
        <a href="bbsPoints.do"><span class="lhb">Earned Points</span></a>
        <span style="padding-left:175px" ><a href="redemnPoints.do"><span class="lhb2" >Redeemed Points</span></a></span>
    </logic:present>

    <logic:present name="RedemptionPointsList">
        <a  href="bbsPoints.do"><span class="lhb2">Earned Points</span></a>
        <span style="padding-left:175px" ><a href="redemnPoints.do"><span  class="lhb" >Redeemed Points</span></a></span>
    </logic:present>
    <a  href="bbsPoints.do"><span class="lhb2">Earned Points</span></a>
    <span style="padding-left:175px" ><a href="redemnPoints.do"><span  class="lhb" >Redeemed Points</span></a></span>

</div>

<div class="clear"> </div>
<div  style="width:740px;height:5px;"></div>

<logic:present name="BbsPointsResults">
    <bean:size id="size" name="BbsPointsResults" />
    <logic:equal name="size" value="0">
        <div  class="fv11b" style="width:740px;">
            <div  style="width:740px;height:20px;">
                No Earned Points  found
            </div>
            <div  style="width:740px;height:20px;">
                You Wish  To  Earen Points ...
            </div>

            <div  style="width:740px;height:20px;">
                1.) Make your friend Register in this website.(5 points)
            </div>
            <div  style="width:740px;height:20px;">
                2.) Receive sms about special offers.(10 points)
            </div>
            <div  style="width:740px;height:20px;">
                3.) Post Special Ad. (15 pints)
            </div>
            <div  style="width:740px;height:20px;">
                4.) Post an artical about this website. (points depends)
            </div>
        </div>
    </logic:equal>

    <logic:greaterThan name="size" value="0">

        <div style="width:710px;">
            <div class="pt"><div class="pb"><div class="pl"><div class="pr"><div class="pbl"><div class="pbr"><div class="ptl"><div class="ptr">
                                            <table  align="center" cellpadding="0" cellspacing="0" >
                                                <tr class="fv12bc">
                                                    <th width="150" bgcolor="#F1F1EB" height="30">Date </th>
                                                    <th width="2"  height="30"></th>
                                                    <th width="400" bgcolor="#F1F1EB" height="30">Reason </th>
                                                    <th width="2"  height="30"></th>
                                                    <th width="150" bgcolor="#F1F1EB" height="30">Points </th>
                                                </tr>
                                                <tr >
                                                    <td width="150" height="2" ></td>
                                                    <td width="2"  height="2"></td>
                                                    <td width="400" bgcolor="#F1F1EB" height="2"></td>
                                                    <td width="2"  height="2"></td>
                                                    <td width="150" bgcolor="#F1F1EB" height="2"></td>
                                                </tr>


                                                <logic:iterate id="result"  name="BbsPointsResults" >

                                                    <tr class="fv11">

                                                        <td width="150" align="center" height="25" bgcolor="#F1F1EB"> <bean:write name="result" property="pointsOn" /></td>
                                                        <td width="2"  height="25" ></td>
                                                        <td width="400" height="25" style="padding-left:10px;"><bean:write name="result" property="reason" /></td>
                                                        <td width="2" bgcolor="#F1F1EB" height="25"></td>
                                                        <td width="150" align="center" height="25"><bean:write  name="result" property="points" /></td>

                                                    </tr>
                                                    <tr >
                                                        <td width="150" height="2" ></td>
                                                        <td width="2" bgcolor="#F1F1EB"  height="2"></td>
                                                        <td width="400" bgcolor="#F1F1EB" height="2"></td>
                                                        <td width="2"bgcolor="#F1F1EB" height="2"></td>
                                                        <td width="150" bgcolor="#F1F1EB" height="2"></td>
                                                    </tr>

                                                </logic:iterate>
                                            </table>
                                        </div>
                                    </div></div></div></div></div></div></div></div>
                                </logic:greaterThan>


</logic:present>
<logic:present name="RedemptionPointsList" >
    <bean:size id="size" name="RedemptionPointsList" />
    <logic:equal name="size" value="0">
        <div  style="width:740px;height:20px;">
            No Redemptions  found
        </div>
    </logic:equal>
    <logic:greaterThan name="size" value="0">
        <div  style="width:710px;">
            <div class="pt"><div class="pb"><div class="pl"><div class="pr"><div class="pbl"><div class="pbr"><div class="ptl"><div class="ptr">
                                            <table  align="center" cellpadding="0" cellspacing="0" >
                                                <tr class="fv12bc">
                                                    <th width="150" bgcolor="#F1F1EB" height="30">Date </th>
                                                    <th width="2"  height="30"></th>
                                                    <th width="150" bgcolor="#F1F1EB" height="30">Item </th>
                                                    <th width="2"  height="30"></th>
                                                    <th width="90" bgcolor="#F1F1EB" height="30">Quantity</th>
                                                    <th width="2"  height="30"></th>
                                                    <th width="90" bgcolor="#F1F1EB" height="30">Points </th>
                                                    <th width="2"  height="30"></th>
                                                    <th width="110" bgcolor="#F1F1EB" height="30">Status</th>
                                                    <th width="2"  height="30"></th>
                                                    <th width="100" bgcolor="#F1F1EB" height="30">Deliver Address</th>
                                                </tr>

                                                <tr >
                                                    <td width="150" height="2" ></td>
                                                    <td width="2"  height="2"></td>
                                                    <td width="150" bgcolor="#F1F1EB" height="2"></td>
                                                    <td width="2"  height="2" ></td>
                                                    <td width="90" bgcolor="#F1F1EB" height="2"></td>
                                                    <td width="2"  height="2"></td>
                                                    <td width="90" bgcolor="#F1F1EB" height="2"></td>
                                                    <td width="2"  height="2" ></td>
                                                    <td width="110" bgcolor="#F1F1EB" height="2"></td>
                                                    <td width="2"  height="2" ></td>
                                                    <td width="100" bgcolor="#F1F1EB" height="2"></td>
                                                </tr>

                                                <logic:iterate id="result"  name="RedemptionPointsList" >
                                                    <tr class="fv11">
                                                        <td width="150" align="center" height="25" bgcolor="#F1F1EB"> <bean:write name="result" property="pointsOn" /></td>
                                                        <td width="2"  height="25"></td>
                                                        <td width="150" height="25" align="center"><bean:write name="result" property="reason" /></td>
                                                        <td width="2" bgcolor="#F1F1EB" height="25"></td>
                                                        <td width="90" align="center" height="25"><bean:write  name="result" property="qty" /></td>
                                                        <td width="2" bgcolor="#F1F1EB" height="25"></td>
                                                        <td width="90" align="center" height="25"><bean:write  name="result" property="points" /></td>
                                                        <td width="2" bgcolor="#F1F1EB" height="25"></td>
                                                        <td width="110" align="center" height="25"><bean:write  name="result" property="status" /></td>
                                                        <td width="2" bgcolor="#F1F1EB" height="25"></td>
                                                        <td width="100" height="25" style="padding-left:20px;"> <a href="#" onmouseover="Tip('<bean:write name="result" property="name" />, <bean:write name="result" property="addr" />, <bean:write name="result" property="locality" />, <bean:write  name="result" property="city" />, <bean:write  name="result" property="state" />, <bean:write  name="result" property="country" />, cell:&nbsp;<bean:write name="result" property="mobile" />.', PADDING, 9, BGCOLOR, '#F7F8B1', BORDERCOLOR, '#4D9EDF', CLICKCLOSE, true, WIDTH, -1, TITLE, 'Deliver Address', TITLEBGCOLOR, '#4D9EDF', FADEIN, 900, FADEOUT, 900, OPACITY, 900)" onmouseout="UnTip()" >  deliver addr... </a> </td>

                                                        <%--  <td width="70" align="center" height="25"><bean:write  name="result" property="deliverOn" /></td>
                                                       <td width="2" bgcolor="#F1F1EB" height="25"></td>
                                                       <td width="90" align="center" height="25"><bean:write  name="result" property="name" /></td>
                                                       <td width="2" bgcolor="#F1F1EB" height="25" ></td>
                                                       <td width="156" height="25" style="padding-left:10px;">
                                                           <bean:write name="result" property="country" />, <bean:write name="result" property="state" />......more <bean:write name="result" property="city" />, <bean:write name="result" property="addr" />, <bean:write name="result" property="mobile" />
                                                       </td>--%>
                                                    </tr>

                                                    <tr >
                                                        <td width="150" height="2" ></td>
                                                        <td width="2" bgcolor="#F1F1EB"  height="2"></td>
                                                        <td width="150" bgcolor="#F1F1EB" height="2"></td>
                                                        <td width="2"bgcolor="#F1F1EB" height="2"></td>
                                                        <td width="90" bgcolor="#F1F1EB" height="2"></td>
                                                        <td width="2"bgcolor="#F1F1EB" height="2"></td>
                                                        <td width="90" bgcolor="#F1F1EB" height="2"></td>
                                                        <td width="2"bgcolor="#F1F1EB" height="2"></td>
                                                        <td width="110" bgcolor="#F1F1EB" height="2"></td>
                                                        <td width="2"bgcolor="#F1F1EB" height="2"></td>
                                                        <td width="100" bgcolor="#F1F1EB" height="2"></td>
                                                    </tr>
                                                </logic:iterate>
                                            </table>

                                        </div></div></div></div></div></div></div></div>
        </div>
    </logic:greaterThan>

</logic:present>
