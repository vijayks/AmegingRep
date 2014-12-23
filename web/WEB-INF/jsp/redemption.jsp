
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<div   style="clear:both;width:720px;height:5px;"></div>
<div class="pt"><div class="pb"><div class="pl"><div class="pr"><div class="pbl"><div class="pbr"><div class="ptl"><div class="ptr">
                                <table align="center"><td><div style="width:720px;">

                                            <div style="padding-top:15px; padding-left:10px;" width="100%" valign="top" class="verdana_form_mainhead">Redemption Options</div>
                                            <div style="width:700px">
                                                <div style="border:1px solid #ffcc33"> </div>
                                            </div>

                                            <div class="fv12b" style="width:720px;float:left;padding-left:10px;padding-top:15px;">
                                                <div style="width:180px;float:left;height:20px;">Total earnings till date</div><div style="width:20px;float:left;height:20px;">:</div><div style="width:520px;float:left;height:20px;"> <%= request.getAttribute("earned")%></div>
                                                <div style="width:180px;float:left;height:20px;">Current Balance</div><div style="width:20px;float:left;height:20px;">:</div><div style="width:520px;float:left;height:20px;"> <%= request.getAttribute("current")%></div>
                                                <div style="width:180px;float:left;height:20px;">Total redemeed till date</div><div style="width:20px;float:left;height:20px;">:</div><div style="width:520px;float:left;height:20px;"> <%= request.getAttribute("redemned")%></div>
                                            </div>
                                            <div style="width:720px;float:left;height:20px;"></div>



                                            <div style="width:720px;float:left;height:auto;" align="center">
                                                <div  style="width:720px;float:left;height:200px;" align="center">


                                                    <c:if test="${redumptionError != null}">
                                                        <center><span style="font-weight:600;font-size:11px;color:#FF0000">You Have Insufficient BBS Points to redemen this Product.<%--'<c:out value="${redumptionError}"/>'--%>.</span></center>
                                                    </c:if>
                                                    <c:out value="${curr}"/>

                                                    <form action="redemptionPageV.do" method="post">
                                                        <input type="hidden" value="SpecialAd" name="rP">
                                                        <div   style="width:240px;float:left;height:200px;">
                                                            <img src="images/SpecialAd.png" width="150px" height="165px"  >
                                                            <div style="width:240px;float:left;height:25px;padding-top:10px;">
                                                                <input  type="image" name="option" src="bbsimages/buttons/Select.png" onmouseover="this.src='bbsimages/buttons/Select_MouseOver.png';" onmouseout="this.src='bbsimages/buttons/Select.png';" onclick="" >
                                                            </div>
                                                        </div>
                                                    </form>

                                                    <form action="redemptionPageV.do" method="post">
                                                        <input type="hidden" value="Cap" name="rP">
                                                        <div   style="width:240px;float:left;height:200px;">
                                                            <img src="images/Cap.png" width="150px" height="165px" align="center" >
                                                            <div style="width:240px;float:left;height:25px;padding-top:10px;">
                                                                <input  type="image" name="option" src="bbsimages/buttons/Select.png" onmouseover="this.src='bbsimages/buttons/Select_MouseOver.png';" onmouseout="this.src='bbsimages/buttons/Select.png';" onclick="" >
                                                            </div>
                                                        </div>
                                                    </form>

                                                    <form action="redemptionPageV.do" method="post">
                                                        <input type="hidden" value="T-Shirt" name="rP">
                                                        <div   style="width:240px;float:left;height:200px;">
                                                            <img src="images/TShirt.png" width="150px" height="165px" align="center" >
                                                            <div style="width:240px;float:left;height:25px;padding-top:10px;">
                                                                <input  type="image" name="option" src="bbsimages/buttons/Select.png" onmouseover="this.src='bbsimages/buttons/Select_MouseOver.png';" onmouseout="this.src='bbsimages/buttons/Select.png';" onclick="" >
                                                            </div>
                                                        </div>
                                                    </form>

                                                </div>
                                                <div style="width:720px;float:left;height:40px;"></div>
                                                <div  style="width:720px;float:left;height:200px;">

                                                    <form action="redemptionPageV.do" method="post">
                                                        <input type="hidden" value="CoffeeMug" name="rP">
                                                        <div   style="width:240px;float:left;height:200px;">

                                                            <img src="images/CoffeeMug.png" width="150px" height="165px" align="center" >

                                                            <div style="width:240px;float:left;height:25px;padding-top:10px;">

                                                                <input  type="image" name="option" src="bbsimages/buttons/Select.png" onmouseover="this.src='bbsimages/buttons/Select_MouseOver.png';" onmouseout="this.src='bbsimages/buttons/Select.png';" onclick="" >
                                                            </div>
                                                        </div>
                                                    </form>

                                                    <form action="redemptionPageV.do" method="post">
                                                        <input type="hidden" value="Travelling-Bag" name="rP">
                                                        <div  style="width:240px;float:left;height:200px;">
                                                            <img src="images/TravellingBag.png" width="150px" height="165px" align="center" >
                                                            <div style="width:240px;float:left;height:25px;padding-top:10px;">

                                                                <input  type="image" name="option" src="bbsimages/buttons/Select.png" onmouseover="this.src='bbsimages/buttons/Select_MouseOver.png';" onmouseout="this.src='bbsimages/buttons/Select.png';" onclick="" >
                                                            </div>
                                                        </div>
                                                    </form>
                                                    <form action="redemptionPageV.do" method="post">
                                                        <input type="hidden" value="Ipod" name="rP">
                                                        <div style="width:240px;float:left;height:200px;">
                                                            <img src="images/Ipod.png" width="150px" height="165px" align="center" >

                                                            <div style="width:240px;float:left;height:25px;padding-top:10px;">

                                                                <input  type="image" name="option" src="bbsimages/buttons/Select.png" onmouseover="this.src='bbsimages/buttons/Select_MouseOver.png';" onmouseout="this.src='bbsimages/buttons/Select.png';" onclick="" >
                                                            </div>

                                                        </div>
                                                    </form>
                                                </div>
                                            </div>


                                        </div>
                                    </td>
                                </table>
                            </div></div></div></div></div></div></div></div>
