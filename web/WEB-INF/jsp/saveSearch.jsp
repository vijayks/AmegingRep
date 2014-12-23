<%--
    Document   : saveSearch
    Created on : Oct 13, 2009, 5:24:54 PM
    Author     : bbsadmin
--%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <c:if test='${saveThisSearch != null}' >

        <div style="clear:both;"></div>
        <div id="saveSearch" >
            <img src="bbsimages/Saved-searches.gif" alt="saved search" />   <a title="Save This Search" href="javascript:return false" onclick="toggle_search_it('search');event.returnValue=false;return false;" > Save This Search</a>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <img src="bbsimages/alert.gif" alt="alert" /><a title="Save Alerts" href="javascript:return false" onclick="toggle_alert_it('alert');event.returnValue=false;return false;"  > Save Alert</a>
        </div>
        <div style="clear:both;"></div>




        <!-- ********************************************************************************************************** -->
        <!--   SAVE SEARCH BLOCK STARTS   -->
        <!-- ********************************************************************************************************** -->



        <!-- this works when user not logged in -->

        <script>
            /*This functions used to hide & display the qcick registration blocks in save alert & save search*/
            function toggle_qrss(itemId)
            {

                document.getElementById('formsearchwl').style.display = 'none';
                document.getElementById('fpss').style.display = 'none';
                document.getElementById(itemId).style.display = 'inline';
            }
            function toggle_qrsa(itemId)
            {

                document.getElementById('formalertwl').style.display = 'none';
                document.getElementById('fpsa').style.display = 'none';

                document.getElementById(itemId).style.display = 'inline';
            }

            function toggle_fpsa(itemId)
            {
                document.getElementById('formalertwl').style.display = 'none';
                document.getElementById('qrSaveAlert').style.display = 'none';
                document.getElementById(itemId).style.display = 'inline';

            }
            function toggle_fpss(itemId)
            {
                document.getElementById('formalertwl').style.display = 'none';
                document.getElementById('qrSaveSearch').style.display = 'none';

                document.getElementById(itemId).style.display = 'inline';

            }
        </script>

        <div class="boxBorder4" id="searchwl" style="width:700px;float:right;display:none;margin-bottom:2px;">
            <div id="header" style="width:700px" >
                <div style="height:1px;background:#4D9EDF"></div>
                <div style="float:left;width:60%;text-align:left;">
                    <span style="font-family:Arial;font-size:10px;font-weight:bold;padding-left:3px"> To Save this search</span>
                </div>
                <div style="float:left;width:35%;text-align:right;font-size:9px;font-family:Arial;"><a title="Register" href="javascript:return false;" onclick="toggle_qrss('qrSaveSearch');event.returnValue=false;return false;">Register</a>&nbsp;|&nbsp;
                    <a title="Forgot Password" href="javascript:return false;" onclick="toggle_fpss('fpss');event.returnValue=false;return false;">Forgot Password</a></div>
                <div style="float:left;width:5%;text-align:right">
                    <input type="image" src="images/close.png" onclick="toggle_close_it('searchwl')"/>
                </div>
            </div>

            <div  id="qrSaveSearch" style="width:700px;float:right;display:none">
                <form name="qrform" id="formnu" method="get" action="quickReg.do" onsubmit="return validateQuickRegFormLA(this)">
                    <input type="hidden" name="adId" value="ss" />
                    <input type="hidden" name="sspurpose" value="save search" />
                    <input type="hidden" name="keyword" value="<c:out value="${keyword}" />" />
                    <input type="hidden" name="subCatId" value="<c:out value="${subCatId}" />" />
                    <input type="hidden" name="searchUrl" value="<c:out value="${saveThisSearch}" />" />

                    <table id="tablenu" border="0" style="font-size:9px;margin:0 auto;margin-top:10px;" >
                        <tr>
                            <td width="">
                                User Id
                            </td>
                            <td>
                                <input style="height:12px;font-size:9px;width:120px" type="text" name="userName"
                                       id="l" onchange="checkUsName('l','nu')" />
                            </td>
                            <td width="">
                                Your Name
                            </td>
                            <td width="">
                                <input style="height:12px;font-size:9px;width:120px"  type="text" name="firstName" id="n" />
                            </td>
                            <td style="width:30px" align="right">
                                City
                            </td>
                            <td>

                                <select size="1"  id="ct" style="font-size:9px;width:122px;_width:125px;" name="city" >
                                    <option value="" selected="true" >select city</option>
                                    <c:if test="${cities  != null }">
                                        <c:forEach items="${cities}" var="con">
                                            <option value="<c:out value='${con.name}'/>"<c:if test='${city != null && city == con.name}' >selected='true'</c:if> ><c:out value="${con.name}"/></option>
                                        </c:forEach>
                                    </c:if>

                                </select>
                            </td>
                            <td align="right">
                                Phone No

                            </td>
                            <td>
                                <input style="height:12px;font-size:9px;width:120px" type="text"
                                       id="ph" name="mobile"  />
                            </td>
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                            <td  style="width:130px;" align="center" valign="middle">
                                <img alt="" id="verIdnu" src="rig" style="height:21px;width:100px"/>&nbsp;
                                <a title="Change Verification Code" class="link11" href="javascript:return false;" onclick="changeVrificationCodeQr('verIdnu');event.returnValue=false;return false;"><img border="0" alt="verificationCode" src="bbsimages/referesh_button.jpg" style="height:24px;"/></a>
                            </td>
                            <td>
                                Enter&nbsp;Code
                            </td>
                            <td>
                                <input id="vrCode" type="text" name="regCode" style="width:100px;font-size:9px;" onblur="qrCheckRegCode('vrCode','nu')">
                            </td>
                            <td align="right">
                                <input type="checkbox" name="iagree" ></td>
                            <td>I agree Terms &amp; Conditions.</td>
                            <td></td>
                            <td width="">
                                <input type="image" id="butdnu"  src="bbsimages/buttons/RegisterSDis.png" disabled />
                                <input type="image"  src="bbsimages/buttons/RegisterS.png" disabled onmouseover="this.src='bbsimages/buttons/RegisterS_MouseOver.png'" onmouseout="this.src='bbsimages/buttons/RegisterS.png'"
                                       id="butnu" style="display:none" />
                            </td>
                        </tr>
                    </table>
                    <span id="codeTestNonu" name="codeTestNo" style="color:red;font-size:10px;display:none" >Verfication doesn't matched</span>

                    <div class="fv12bc" style="text-align:center" id="msgnu"></div>
                    <div class="fv11b" style="text-align:center;" id="confnu" ></div>
                    <div id="imgnu" style="display:none;text-align:center">Loading...</div>

                </form>
            </div>

            <!-- =================================== -->
            <!-- Forget Password div in save search -->
            <!-- =================================== -->

            <div  id="fpss" style="width:700px;float:right;display:none">


                <div id="fpfpss" style="font-family:Arial;font-size:9px;margin:0 auto;">
                    <br>
                    <table style="margin:0 auto;_margin-top:-12px;">
                        <tr><td>Enter Email Id</td><td>&nbsp;</td>
                            <td><input id="emfpss" style="height:12px;font-size:9px;width:150px" type="text" /></td>
                            <td>&nbsp;&nbsp;</td><td>Enter year of Birth</td><td>&nbsp;</td>
                            <td><input id="yfpss" style="height:12px;font-size:9px;width:150px" type="text" /></td>
                            <td><span style="padding-left:20px">
                                    <input type="image"  src="bbsimages/buttons/ResetPasswordS.png" onmouseover="this.src='bbsimages/buttons/ResetPasswordS_MouseOver.png'" onmouseout="this.src='bbsimages/buttons/ResetPasswordS.png'"
                                           onclick="sendPassword('fpss');event.returnValue=false;return false;"/>
                                </span></td></tr></table>
                </div>
                <div id="imgfpss" style="width:auto;padding:2px 0 2px 350px;display:none"> Loading... </div>
                <span style="padding:0 0 0 150px" class="fv12bc" id="msgfpss">
                </span>
                <div style="width:700px;height:5px;float:right"></div>
            </div>

            <div id="formsearchwl" style="font-family:Arial;font-size:9px;padding-top:1px;margin:0 auto;">
                <br />
                <table style="margin:0 auto;" border="0">
                    <tr>
                        <td  width="12%" style="text-align:center"> User Id</td>
                        <td> <input id="lsearchwl" name="loginName" style="height:12px;font-size:9px;" type="text" size="35" /></td>
                        <td width="2%" > &nbsp;</td>
                        <td width="12%" style="text-align:center">Password</td>
                        <td><input id="psearchwl" name="pwd" style="height:12px;font-size:9px;" type="password" size="35" /></td>
                        <td width="12%" style="text-align:right"><input type="image"  src="bbsimages/buttons/SaveSearch.png" onmouseover="this.src='bbsimages/buttons/SaveSearch_MouseOver.png'" onmouseout="this.src='bbsimages/buttons/SaveSearch.png'" onclick="saveSearchWL('searchwl','${keyword}','${subCatId}','${saveThisSearch}')" /></td>
                    </tr>
                </table>
            </div>



            <div id="loadsearchwl" style="width:auto;padding:2px 0 2px 350px;display:none"> <img src="images/loading.gif" /></div>
            <span style="padding:0 0 0 150px" class="fv12bc" id="msgsearchwl"> </span>

            <div style="clear:both;"></div>
        </div>

        <!-- this works when user already logged in -->
        <div class="boxBorder4" id="searchal" style="width:700px;float:right;display:none">
            <div id="header" style="width:700px" >
                <div style="height:1px;background:#4D9EDF"></div>
                <div style="float:left;width:60%;text-align:left;">
                    <span style="font-family:Arial;font-size:10px;font-weight:bold;padding-left:3px"> To Save this search</span>
                </div>
                <div style="float:left;width:35%;"></div>
                <div style="float:left;width:5%;text-align:right">
                    <input type="image" src="images/close.png" onclick="toggle_close_it('searchal')"/>
                </div>
            </div>
            <div id="formsearchal" style="font-family:Arial;font-size:9px;padding-top:1px;">
                <br />
                <table style="margin:0 auto;">
                    <tr><td class="fv12bc">This&nbsp;search&nbsp;will&nbsp;be&nbsp;saved&nbsp;in&nbsp;"myAccount"&nbsp;by&nbsp;saving&nbsp;here&nbsp;</td>
                        <td ><input type="image"  src="bbsimages/buttons/SaveSearch.png" onmouseover="this.src='bbsimages/buttons/SaveSearch_MouseOver.png'" onmouseout="this.src='bbsimages/buttons/SaveSearch.png'" onclick="saveSearchAL('searchal','${keyword}','${subCatId}','${saveThisSearch}')" /> </td>
                    </tr>
                </table>
            </div>
            <div id="loadsearchal" style="width:auto;padding:2px 0 2px 350px;display:none"> <img src="images/loading.gif" /><br></div>
            <span style="padding:0 0 0 150px" class="fv12bc" id="msgsearchal"> </span>
            <div style="clear:both;"></div>
        </div>


        <!-- ********************************************************************************************************** -->
        <!--   SAVE SEARCH BLOCK End   -->
        <!-- ********************************************************************************************************** -->



        <!-- ********************************************************************************************************** -->
        <!--   SAVE ALERT BLOCK STARTS   -->
        <!-- ********************************************************************************************************** -->

        <!-- this works when user not logged in -->
        <div class="boxBorder4" id="alertwl" style="width:700px;float:right;display:none;margin-bottom:2px;">
            <div id="header" style="width:700px" >
                <div style="height:1px;background:#4D9EDF"></div>
                <div style="float:left;width:60%;text-align:left;">
                    <span style="font-family:Arial;font-size:10px;font-weight:bold;padding-left:3px"> To save this Alert</span>
                </div>
                <div style="float:left;width:35%;text-align:right;font-size:9px;font-family:Arial;"><a title="Register" href="javascript:return false;" onclick="toggle_qrsa('qrSaveAlert');event.returnValue=false;return false;">Register</a>&nbsp;|&nbsp;
                    <a title="Forgot Password" href="javascript:return false;" onclick="toggle_fpsa('fpsa');event.returnValue=false;return false;">Forgot Password</a></div>

                <div style="float:left;width:5%;text-align:right">
                    <input type="image" src="images/close.png" onclick="toggle_close_it('alertwl')"/>
                </div>
            </div>

            <div  id="qrSaveAlert" style="width:700px;float:right;display:none">
                <form id="formnusa" name="qrform" method="get" action="quickReg.do" onsubmit="return validateQuickRegFormLA(this)">
                    <input type="hidden" name="adId" value="ss" />
                    <input type="hidden" name="sspurpose" value="save alert" />


                    <table id="tablenusa" border="0" style="font-size:9px;margin:0 auto;margin-top:10px;" >
                        <tr>
                            <td width="">
                                User Id
                            </td>
                            <td>
                                <input style="height:12px;font-size:9px;width:120px" type="text" name="userName"
                                       id="lsa" onchange="checkUsName('lsa','nusa')" />
                            </td>
                            <td width="">
                                Your Name
                            </td>
                            <td width="">
                                <input style="height:12px;font-size:9px;width:120px"  type="text" name="firstName" id="n" />
                            </td>
                            <td style="width:30px" align="right">
                                City
                            </td>
                            <td>

                                <select size="1"  id="ct" style="font-size:9px;width:122px;_width:125px;" name="city" >
                                    <option value="" selected="true" >select city</option>
                                    <c:if test="${cities  != null }">
                                        <c:forEach items="${cities}" var="con">
                                            <option value="<c:out value='${con.name}'/>"<c:if test='${city != null && city == con.name}' >selected='true'</c:if> ><c:out value="${con.name}"/></option>
                                        </c:forEach>
                                    </c:if>

                                </select>
                            </td>
                            <td align="right">
                                Phone No

                            </td>
                            <td>
                                <input style="height:12px;font-size:9px;width:120px" type="text"
                                       id="ph" name="mobile"  />
                            </td>
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                            <td  style="width:130px;" align="center" valign="middle">
                                <img alt="" id="verIdnusa" src="rig" style="height:21px;width:100px"/>&nbsp;
                                <a title="Change Verification Code" class="link11" href="javascript:return false;" onclick="changeVrificationCodeQr('verIdnusa');event.returnValue=false;return false;"><img border="0" alt="verificationCode" src="bbsimages/referesh_button.jpg" style="height:24px;"/></a>
                            </td>
                            <td>
                                Enter&nbsp;Code
                            </td>
                            <td>
                                <input id="vrCodesa" type="text" name="regCode" style="width:100px;font-size:9px;" onblur="qrCheckRegCode('vrCodesa','nusa')">
                            </td>
                            <td align="right">
                                <input type="checkbox" name="iagree" ></td>
                            <td>I agree Terms &amp; Conditions.</td>
                            <td></td>
                            <td width="">
                                <input type="image" id="butdnusa"  src="bbsimages/buttons/RegisterSDis.png" disabled />
                                <input type="image"  src="bbsimages/buttons/RegisterS.png" disabled onmouseover="this.src='bbsimages/buttons/RegisterS_MouseOver.png'" onmouseout="this.src='bbsimages/buttons/RegisterS.png'"
                                       id="butnusa" style="display:none"      />
                            </td>
                        </tr>
                    </table>
                    <span id="codeTestNonusa" name="codeTestNo" style="color:red;font-size:10px;display:none" >Verfication doesn't matched</span>

                    <div class="fv12bc" style="text-align:center" id="msgnusa"></div>
                    <div class="fv11b" style="text-align:center;" id="confnusa" ></div>
                    <div id="imgnusa" style="display:none;text-align:center">Loading...</div>

                </form>
            </div>


            <!-- =================================== -->
            <!-- Forget Password div in save alert -->
            <!-- =================================== -->
            <div  id="fpsa" style="width:700px;float:right;display:none">


                <div id="fpfpsa" style="font-family:Arial;font-size:9px;margin:0 auto;">
                    <br>
                    <table style="margin:0 auto;_margin-top:-12px;">
                        <tr><td>Enter Email Id</td><td>&nbsp;</td>
                            <td><input id="emfpsa" style="height:12px;font-size:9px;width:150px" type="text" /></td>
                            <td>&nbsp;&nbsp;</td><td>Enter year of Birth</td><td>&nbsp;</td>
                            <td><input id="yfpsa" style="height:12px;font-size:9px;width:150px" type="text" /></td>
                            <td><span style="padding-left:20px">
                                    <input type="image"  src="bbsimages/buttons/ResetPasswordS.png" onmouseover="this.src='bbsimages/buttons/ResetPasswordS_MouseOver.png'" onmouseout="this.src='bbsimages/buttons/ResetPasswordS.png'"
                                           onclick="sendPassword('fpsa');event.returnValue=false;return false;"/>
                                </span></td></tr></table>
                </div>
                <div id="imgfpsa" style="width:auto;padding:2px 0 2px 350px;display:none"> Loading... </div>
                <span style="padding:0 0 0 150px" class="fv12bc" id="msgfpsa">
                </span>
                <div style="width:700px;height:5px;float:right"></div>
            </div>



            <div id="formalertwl" style="font-family:Arial;font-size:9px;padding-top:1px;margin:0 auto;">
                <br />
                <table style="margin:0 auto;_margin-top:-10px;" border="0">
                    <tr>
                        <td  width="12%" style="text-align:left">Alert From </td>
                        <td style="font-family:Arial;font-size:9px;">
                            <select name="day1" id="d1alertwl" style="width:45px;font-family:Arial;font-size:10px;"   >
                                <option selected="true" value="0">day</option>
                                <option value="1"> 01</option>
                                <option value="2"> 02</option>
                                <option value="3"> 03</option>
                                <option value="4"> 04</option>
                                <option value="5"> 05</option>
                                <option value="6"> 06</option>
                                <option value="7"> 07</option>
                                <option value="8"> 08</option>
                                <option value="9"> 09</option>
                                <option value="10">10</option>
                                <option value="11">11</option>
                                <option value="12">12</option>
                                <option value="13">13</option>
                                <option value="14">14</option>
                                <option value="15">15</option>
                                <option value="16">16</option>
                                <option value="17">17</option>
                                <option value="18">18</option>
                                <option value="19">19</option>
                                <option value="20">20</option>
                                <option value="21">21</option>
                                <option value="22">22</option>
                                <option value="23">23</option>
                                <option value="24">24</option>
                                <option value="25">25</option>
                                <option value="26">26</option>
                                <option value="27">27</option>
                                <option value="28">28</option>
                                <option value="29">29</option>
                                <option value="30">30</option>
                                <option value="31">31</option>

                            </select>

                            <select name="month1" id="m1alertwl" style="width:62px;font-family:Arial;font-size:10px;"  >
                                <option selected="true" value="0">month</option>
                                <option value="0">January</option>
                                <option value="1">February</option>
                                <option value="2">March</option>
                                <option value="3">April</option>
                                <option value="4">May</option>
                                <option value="5">June</option>
                                <option value="6">July</option>
                                <option value="7">August</option>
                                <option value="8">September</option>
                                <option value="9">October</option>
                                <option value="10">November</option>
                                <option value="11">December</option>
                            </select>

                            <select name="year1" id="y1alertwl" style="width:55px;font-family:Arial;font-size:10px;" >
                                <option selected value="0">year</option>


                                <option value="2009">2009</option>
                                <option value="2010">2010</option>
                                <option value="2011">2011</option>
                                <option value="2012">2012</option>
                                <option value="2013">2013</option>
                                <option value="2014">2014</option>

                            </select>

                        </td>
                        <td width="6%" > &nbsp;</td>
                        <td  width="12%" style="text-align:left">Alert To </td>
                        <td>
                            <select name="day2" id="d2alertwl"  style="width:45px;font-family:Arial;font-size:10px;">
                                <option selected="true" value="0">day</option>

                                <option value="1"> 01</option>
                                <option value="2"> 02</option>
                                <option value="3"> 03</option>
                                <option value="4"> 04</option>
                                <option value="5"> 05</option>
                                <option value="6"> 06</option>
                                <option value="7"> 07</option>
                                <option value="8"> 08</option>
                                <option value="9"> 09</option>
                                <option value="10">10</option>
                                <option value="11">11</option>
                                <option value="12">12</option>
                                <option value="13">13</option>
                                <option value="14">14</option>
                                <option value="15">15</option>
                                <option value="16">16</option>
                                <option value="17">17</option>
                                <option value="18">18</option>
                                <option value="19">19</option>
                                <option value="20">20</option>
                                <option value="21">21</option>
                                <option value="22">22</option>
                                <option value="23">23</option>
                                <option value="24">24</option>
                                <option value="25">25</option>
                                <option value="26">26</option>
                                <option value="27">27</option>
                                <option value="28">28</option>
                                <option value="29">29</option>
                                <option value="30">30</option>
                                <option value="31">31</option>

                            </select>

                            <select name="month2"  id="m2alertwl"  style="width:62px;font-family:Arial;font-size:10px;">
                                <option selected="true" value="0">month</option>
                                <option value="0">January</option>
                                <option value="1">February</option>
                                <option value="2">March</option>
                                <option value="3">April</option>
                                <option value="4">May</option>
                                <option value="5">June</option>
                                <option value="6">July</option>
                                <option value="7">August</option>
                                <option value="8">September</option>
                                <option value="9">October</option>
                                <option value="10">November</option>
                                <option value="11">December</option>
                            </select>

                            <select name="year2" id="y2alertwl"  style="width:55px;font-family:Arial;font-size:10px;">
                                <option selected value="0">year</option>


                                <option value="2009">2009</option>
                                <option value="2010">2010</option>
                                <option value="2011">2011</option>
                                <option value="2012">2012</option>
                                <option value="2013">2013</option>
                                <option value="2014">2014</option>



                            </select>
                        </td>
                        <td> &nbsp;</td>
                    </tr>
                    <tr>
                        <td  width="12%" style="text-align:left"> User Id</td>
                        <td> <input id="lalertwl" name="loginName" style="height:12px;font-size:9px;width:166px;_width:162px;" type="text" size="35" /></td>
                        <td width="6%" > &nbsp;</td>
                        <td width="12%" style="text-align:left">Password</td>
                        <td><input id="palertwl" name="pwd" style="height:12px;font-size:9px;width:166px;_width:162px;" type="password" size="35" /></td>
                        <td width="12%" style="text-align:right"><input type="image"  src="bbsimages/buttons/SaveAlert.png" onmouseover="this.src='bbsimages/buttons/SaveAlert_MouseOver.png'" onmouseout="this.src='bbsimages/buttons/SaveAlert.png'" onclick="saveAlertWL('alertwl','${keyword}','${subCatId}')" /></td>
                    </tr>
                </table>
            </div>
            <div id="loadalertwl" style="width:auto;padding:2px 0 2px 350px;display:none"> <img src="images/loading.gif" /></div>
            <span style="padding:0 0 0 150px" class="fv12bc" id="msgalertwl"> </span>

            <div style="clear:both;"></div>
        </div>

        <!-- this works when user already logged in -->
        <div class="boxBorder4" id="alertal" style="width:700px;float:right;display:none">
            <div id="header" style="width:700px" >
                <div style="height:1px;background:#4D9EDF"></div>
                <div style="float:left;width:60%;text-align:left;">
                    <span style="font-family:Arial;font-size:10px;font-weight:bold;padding-left:3px"> To save this Alert</span>
                </div>
                <div style="float:left;width:35%;"></div>
                <div style="float:left;width:5%;text-align:right">
                    <input type="image" src="images/close.png" onclick="toggle_close_it('alertal')"/>
                </div>
            </div>
            <div id="formalertal" style="font-family:Arial;font-size:9px;padding-top:1px;margin:0 auto">
                <br />
                <table style="margin:0 auto">
                    <tr>
                        <td style="text-align:left">Alert From </td>
                        <td style="font-family:Arial;font-size:9px;">
                            <select name="day1" id="d1alertal" style="width:45px;font-family:Arial;font-size:10px;"   >
                                <option selected="true" value="0">day</option>
                                <option value="1"> 01</option>
                                <option value="2"> 02</option>
                                <option value="3"> 03</option>
                                <option value="4"> 04</option>
                                <option value="5"> 05</option>
                                <option value="6"> 06</option>
                                <option value="7"> 07</option>
                                <option value="8"> 08</option>
                                <option value="9"> 09</option>
                                <option value="10">10</option>
                                <option value="11">11</option>
                                <option value="12">12</option>
                                <option value="13">13</option>
                                <option value="14">14</option>
                                <option value="15">15</option>
                                <option value="16">16</option>
                                <option value="17">17</option>
                                <option value="18">18</option>
                                <option value="19">19</option>
                                <option value="20">20</option>
                                <option value="21">21</option>
                                <option value="22">22</option>
                                <option value="23">23</option>
                                <option value="24">24</option>
                                <option value="25">25</option>
                                <option value="26">26</option>
                                <option value="27">27</option>
                                <option value="28">28</option>
                                <option value="29">29</option>
                                <option value="30">30</option>
                                <option value="31">31</option>

                            </select>

                            <select name="month1" id="m1alertal" style="width:75px;font-family:Arial;font-size:10px;"  >
                                <option selected="true" value="0">month</option>
                                <option value="0">January</option>
                                <option value="1">February</option>
                                <option value="2">March</option>
                                <option value="3">April</option>
                                <option value="4">May</option>
                                <option value="5">June</option>
                                <option value="6">July</option>
                                <option value="7">August</option>
                                <option value="8">September</option>
                                <option value="9">October</option>
                                <option value="10">November</option>
                                <option value="11">December</option>
                            </select>

                            <select name="year1" id="y1alertal" style="width:50px;font-family:Arial;font-size:10px;" >
                                <option selected value="0">year</option>


                                <option value="2009">2009</option>
                                <option value="2010">2010</option>
                                <option value="2011">2011</option>
                                <option value="2012">2012</option>
                                <option value="2013">2013</option>
                                <option value="2014">2014</option>

                            </select>

                        </td>
                        <td width="6%" > &nbsp;</td>
                        <td style="text-align:left">Alert To </td>
                        <td>
                            <select name="day2" id="d2alertal"  style="width:45px;font-family:Arial;font-size:10px;">
                                <option selected="true" value="0">day</option>

                                <option value="1"> 01</option>
                                <option value="2"> 02</option>
                                <option value="3"> 03</option>
                                <option value="4"> 04</option>
                                <option value="5"> 05</option>
                                <option value="6"> 06</option>
                                <option value="7"> 07</option>
                                <option value="8"> 08</option>
                                <option value="9"> 09</option>
                                <option value="10">10</option>
                                <option value="11">11</option>
                                <option value="12">12</option>
                                <option value="13">13</option>
                                <option value="14">14</option>
                                <option value="15">15</option>
                                <option value="16">16</option>
                                <option value="17">17</option>
                                <option value="18">18</option>
                                <option value="19">19</option>
                                <option value="20">20</option>
                                <option value="21">21</option>
                                <option value="22">22</option>
                                <option value="23">23</option>
                                <option value="24">24</option>
                                <option value="25">25</option>
                                <option value="26">26</option>
                                <option value="27">26</option>
                                <option value="28">28</option>
                                <option value="29">29</option>
                                <option value="30">30</option>
                                <option value="31">31</option>

                            </select>

                            <select name="month2"  id="m2alertal"  style="width:75px;font-family:Arial;font-size:10px;">
                                <option selected="true" value="0">month</option>
                                <option value="0">January</option>
                                <option value="1">February</option>
                                <option value="2">March</option>
                                <option value="3">April</option>
                                <option value="4">May</option>
                                <option value="5">June</option>
                                <option value="6">July</option>
                                <option value="7">August</option>
                                <option value="8">September</option>
                                <option value="9">October</option>
                                <option value="10">November</option>
                                <option value="11">December</option>
                            </select>

                            <select name="year2" id="y2alertal"  style="width:50px;font-family:Arial;font-size:10px;">
                                <option selected value="0">year</option>


                                <option value="2009">2009</option>
                                <option value="2010">2010</option>
                                <option value="2011">2011</option>
                                <option value="2012">2012</option>
                                <option value="2013">2013</option>
                                <option value="2014">2014</option>



                            </select>
                        </td>
                        <td  width="12%" ><input type="image"  src="bbsimages/buttons/SaveAlert.png" onmouseover="this.src='bbsimages/buttons/SaveAlert_MouseOver.png'" onmouseout="this.src='bbsimages/buttons/SaveAlert.png'" onclick="saveAlertAL('alertal','${keyword}','${subCatId}')" /> </td>
                    </tr>


                </table>
            </div>

            <div id="loadalertal" style="width:auto;padding:2px 0 2px 350px;display:none"> <img src="images/loading.gif" /><br></div>
            <span style="padding:0 0 0 150px" class="fv12bc" id="msgalertal"> </span>
            <div style="clear:both;"></div>
        </div>




        <!-- ********************************************************************************************************** -->
        <!--   SAVE ALERT BLOCK End   -->
        <!-- ********************************************************************************************************** -->

    </c:if>

    <div style="">
        <div style="clear:both;border:1px solid #ffffff"> </div>
    </div>