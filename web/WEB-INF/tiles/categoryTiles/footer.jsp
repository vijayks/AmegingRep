<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<script type="text/javascript" language="javascript"></script>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@page import="com.buysell.beans.UserBean" %>
<%@page  import="com.buysell.beans.AdsBean" %>
<% UserBean ub = (UserBean) request.getSession().getAttribute("userBean");%>

<style type="text/css">
    .pad:hover{
        background:#FFFFCC;
    }
    .pad1{
        background:white;
    }
    .pad1:hover{
        background:whitesmoke;
    }
    .pad2{
         background-color:#EBF3FF;
    }
    .pad2:hover{
         background:#FFF5CC;
    }
</style>
<div  id="general" class="tilepad">
    <logic:present name="editAdForUpdateBean" >
        <table class="verdana_form_postAd" align="left" cellspacing="10px">
            <tr><td></td>
                <td style="width:500px"> <input type="checkbox" name="iagree"  />
                    <a  href="#" title="Click to agree with terms and conditions" onclick="termsAndConditions('tc.do');" >I agree Terms & Conditions.</a>
                </td>
            </tr>
            <tr><td style="padding-bottom:15px"></td></tr>
            <tr>
                <td><input type="hidden" name="sponsType" value="1"></td>
                <td style="width:500px">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <input type="image" id="sub"  name="sub" src="bbsimages/buttons/PublishAd.png" onclick="return postAdForm(this)" onmouseover="this.src='bbsimages/buttons/PublishAd_MouseOver.png';" onmouseout="this.src='bbsimages/buttons/PublishAd.png';">
                    <!-- <input name="sub" type="button" value="Publish Ad" disabled onclick="submitForm()"/> -->
                    <!--<input type="button" value="cancel" /> -->
                </td>
            </tr>
        </table>
        <script type="text/javascript">
            getTileJsps(<%=request.getParameter("catId")%>);
        </script>
    </logic:present>
    <c:if test="${editAdForUpdateBean == null}" >
        <c:if test="${userBean != null}">
            <script type="text/javascript">

                function dlrFreeAd()
                {
                <%--document.getElementById("gld").style.display= 'none';--%>
                        document.getElementById("dlrSlvr").style.display= 'none';
                    }
                    function dlrSlvrAd()
                    {
                        document.getElementById("dlrSlvr").style.display= 'inline';
                <%-- document.getElementById("gld").style.display= 'none';--%>
                    }
                <%--function dlrGldAd()
                {
                    document.getElementById("gld").style.display= 'inline';
                    document.getElementById("dlrSlvr").style.display= 'none';
                }
                function usrFreeAd()
                {
                    document.getElementById("gld").style.display= 'none';
                    document.getElementById("slvr").style.display= 'none';
                }

                function slvrAd()
                {
                    document.getElementById("slvr").style.display= 'inline';
                    document.getElementById("gld").style.display= 'none';
                }

                function usrGldAd()
                {
                    document.getElementById("gld").style.display= 'inline';
                    document.getElementById("slvr").style.display= 'none';
                }--%>
            </script>
            <c:set var="dt"><%=((UserBean) request.getSession().getAttribute("userBean")).getUserType().startsWith("D") ? "D" : "N"%>
            </c:set>
            <c:if test='${dt=="D"}'>
                <table  class="verdana_form_postAd" style="width:100%;padding-bottom:15px;border:1px solid #9CCFEF;background:#DEF;-moz-border-radius:5px;-webkit-border-radius:5px;border-radius:5px;">
                    <tr><td style="padding:5px 10px;color:#05446B">Choose the Ad Type</td></tr>
                    <tr><td style="padding:5px 10px">
                            <table style="width:100%;height:100px;" cellspacing="0">
                                <tr valign="top" >
                                    <td class="pad1" style="padding:10px;">
                                        <input type="radio" name="sponsType" value="1" checked onclick="dlrFreeAd()"><b> Normal Ad ( ${blanceAd} Ads )</b><br/>
                                        <br/><p style="padding-left:10px">You can voluntarily contribute if you are happy with free ad</p>
                                    </td>
                                    <td class="pad2" style="padding:10px;"><input type="radio" name="sponsType" value="2" onclick="dlrSlvrAd()"><b> Preferred Ad( ${preffbal} Ads )</b><br/>
                                        <br/><p style="padding-left:10px">Ad will be highlighted and given priority in listing of related category page with differnet color</p>
                                    </td>
                                    <%-- <td style="background-color:#D4A017;">  <input type="radio" name="sponsType" value="3" onclick="dlrGldAd()"><b>Gold Ad(0 Ad)</b>
                                         <br/><p style="padding-left:10px">Ad will be highlighted and given priority in listing of related category page</p>
                                     </td>--%>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table><br/>
                <div id="dlrSlvr"  style="display:none;">
                    <table style="float:left;"><tr>
                            <td style="font-size:14px;width:180px;color:#FF7600;font-weight:bold;">Youtube Video URL :&nbsp;&nbsp;</td>
                            <td><input type="text" name="videoUrl" id="video"></td>
                        </tr>
                        <tr><td style="padding-bottom:15px"></td></tr>
                    </table>
                </div>
                <%-- <div id="gld"  style="display:none;"><br/>Dealer can post Glod Ad by paying<br/></div>--%>
            </c:if>
            <c:if test='${dt=="N"}'>
              <input type="hidden" name="sponsType" value="1">
            </c:if>
            <%-- <c:if test='${dt=="N"}'>
             <table  class="verdana_form_postAd" style="width:100%;border:1px solid #9CCFEF;background:#DEF;-moz-border-radius:5px;-webkit-border-radius:5px;border-radius:5px;">
                 <tr><td style="padding:5px 10px;color:#05446B">Choose the Ad Type</td></tr>
                 <tr><td style="padding:5px 10px">
                         <table style="width:100%;height:100px;border:1px solid #9CCFEF;" cellspacing="0">
                             <tr valign="top">
                                 <td style="background-color:#FFF">
                                     <input type="radio" name="sponsType" value="1" checked onclick="usrFreeAd()"><b>Free Ad (${blanceAd} Ads)</b>
                                     <br/><p style="padding-left:10px">You can voluntarily contribute if you are happy with free ad</p>
                                 </td>
                                 <td style="background-color:silver;"><input type="radio" name="sponsType" value="2" onclick="slvrAd()"><b>Silver Ad (0 Ad)</b>
                                     <br/><p style="padding-left:10px">Ad will be highlighted to get more attention</p>
                                 </td>
                                 <td style="background-color:#D4A017;">  <input type="radio" name="sponsType" value="3" onclick="usrGldAd()"><b>Gold Ad (0 Ad)</b>
                                     <br/><p style="padding-left:10px">Ad will be highlighted and given priority in listing of related category page</p>
                                 </td>
                             </tr>
                         </table>
                     </td>
                 </tr>
             </table>
             <div id="slvr"  style="display:none;"><br/>User can post Sliver Ad by paying<br/></div>
             <div id="gld"  style="display:none;"><br/>User can post Glod Ad by paying<br/></div>
             </c:if>--%>
        </c:if>
        <table class="verdana_form_postAd" align="left" cellspacing="10px">
            <c:if test="${userBean != null}">
                <tr><td style="padding-bottom:5px"></td></tr>
                <tr>
                    <td></td>
                    <td style="width:500px">
                        <input type="checkbox" name="iagree"  />
                        <a  href="#" title="Click to agree with terms and conditions" onclick="termsAndConditions('tc.do');" >I agree Terms & Conditions.</a>
                    </td>
                </tr>
                <tr><td style="padding-bottom:15px"></td></tr>
                <tr>
                    <td></td>
                    <td style="width:500px" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <input type="image" id="sub"  name="sub" src="bbsimages/buttons/PublishAd.png" onclick="return postAdForm(this)" onmouseover="this.src='bbsimages/buttons/PublishAd_MouseOver.png';" onmouseout="this.src='bbsimages/buttons/PublishAd.png';">
                        <!-- <input name="sub" type="button" value="Publish Ad" disabled onclick="submitForm()"/> -->
                        <%--<input type="image" id="" src="bbsimages/buttons/Cancel.png" onmouseover="this.src='bbsimages/buttons/Cancel_MouseOver.png';" onmouseout="this.src='bbsimages/buttons/Cancel.png';" >--%>
                        <!--<input type="button" value="cancel" /> -->
                    </td>
                </tr>

            </c:if>
        </table>
        <script type="text/javascript" language="javascript">
            var count=0;
            function changeVrificationCodeInPostAd()
            {
                document.getElementById("regCode").value="";
                document.getElementById("codeTestNo").style.display='none';
                document.getElementById("codeTestYes").style.display='none';
                toggle_disable('rButtonDis','rButton');
                count++;
                document.getElementById('verId1').src='rig?1='+count;
            }

            function usrFreeAd()
            {
                document.getElementById("gld").style.display= 'none';
                document.getElementById("slvr").style.display= 'none';
            }

            function slvrAd()
            {
                document.getElementById("slvr").style.display= 'inline';
                document.getElementById("gld").style.display= 'none';
            }

            function usrGldAd()
            {
                document.getElementById("gld").style.display= 'inline';
                document.getElementById("slvr").style.display= 'none';
            }
        </script>
        <c:if test="${userBean == null}" >
            <%--   <table  class="verdana_form_postAd" style="width:100%;border:1px solid #9CCFEF;background:#DEF;-moz-border-radius:5px;-webkit-border-radius:5px;border-radius:5px;">
                   <tr><td style="padding:5px 10px;color:#05446B">Choose the Ad Type</td></tr>
                   <tr><td style="padding:5px 10px">
                           <table style="width:100%;height:100px;border:1px solid #9CCFEF;" cellspacing="0">
                               <tr valign="top">
                                   <td style="background-color:#FFF">
                                       <input type="radio" name="sponsType" value="1" checked onclick="usrFreeAd()"><b>Free Ad (3 Ads)</b>
                                       <br/><p style="padding-left:10px">You can voluntarily contribute if you are happy with free ad</p>
                                   </td>
                                   <td style="background-color:silver;"><input type="radio" name="sponsType" value="2" onclick="slvrAd()"><b>Silver Ad (0 Ad)</b>
                                       <br/><p style="padding-left:10px">Ad will be highlighted to get more attention</p>
                                   </td>
                                   <td style="background-color:#D4A017;">  <input type="radio" name="sponsType" value="3" onclick="usrGldAd()"><b>Gold Ad (0 Ad)</b>
                                       <br/><p style="padding-left:10px">Ad will be highlighted and given priority in listing of related category page</p>
                                   </td>
                               </tr>
                           </table>
                       </td>
                   </tr>
               </table>
               <div id="slvr"  style="display:none;"><br/>User can post Sliver Ad by paying<br/></div>
               <div id="gld"  style="display:none;"><br/>User can post Glod Ad by paying<br/></div>--%>
            <table class="verdana_form_postAd" align="left" cellspacing="10px">
                <tr>
                    <td> Verification Code</td>
                    <td style="width:400px">
                        <div id="firstCode" style="display:inline">
                            <img alt="" id="verId1" src="rig" style="height:40px;width:200px"/>
                        </div>
                        &nbsp;&nbsp;
                        <div id="firstLink" style="display:inline">
                            <a class="link11"  title="Change Verification code" href="javascript:return false;" onclick="changeVrificationCodeInPostAd();event.returnValue=false;return false;" > <img src="bbsimages/referesh_button.jpg" border="0"  style="height:40px;" /></a>
                        </div>
                    </td>
                </tr>
                <tr><td style="padding-bottom:5px"></td></tr>
                <tr>
                    <td>Enter Code <span style="color:red">*</span> </b>
                    </td>
                    <td>
                        <input id="regCode" name="regCode" type="text" style="width:250px;height:18px" onblur="CheckRegCode(this)" />
                        <span id="codeTestNo" style="color:red;display:none" >&nbsp;&nbsp;&nbsp;Verfication doesn't matched</span>
                        <span id="codeTestYes" style="color:red;display:none" >Code Matched</span>
                    </td>
                </tr>
                <tr><td style="padding-bottom:5px"></td></tr>
                <tr>
                    <td></td>
                    <td style="width:500px">
                        <input type="checkbox" name="iagree" id="iagree" />
                        <a  href="#" title="click here to agree with terms & conditions" onclick="termsAndConditions('tc.do');" >I agree Terms & Conditions.</a>
                    </td>
                </tr>
                <tr><td style="padding-bottom:15px"></td></tr>
                <tr>
                    <td></td>
                    <td style="width:500px">
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <input type="image" id="rButtonDis" name="rButtonDis" disabled src="bbsimages/buttons/PublishAdDis.png"  onclick="return postAdWithRegisterFormSubmit(this)" />
                        <input type="image" id="rButton"  name="rButton" style="display:none"  src="bbsimages/buttons/PublishAd.png" onmouseover="this.src='bbsimages/buttons/PublishAd_MouseOver.png';" onmouseout="this.src='bbsimages/buttons/PublishAd.png';">
                        <!-- <input name="sub" type="button" value="Publish Ad" disabled onclick="submitForm()"/> -->
                        <%--<input type="image" id="" src="bbsimages/buttons/Cancel.png" onmouseover="this.src='bbsimages/buttons/Cancel_MouseOver.png';" onmouseout="this.src='bbsimages/buttons/Cancel.png';" >--%>
                        <!--<input type="button" value="cancel" /> -->
                    </td>
                </tr>
            </c:if>

        </table>
    </c:if>
    <script type="text/javascript">
        <% if (request.getAttribute("cityId") != null) {%>
            document.getElementById('city').value='<%= (String) request.getAttribute("cityId")%>';
        <% }%>

        <% if (request.getAttribute("locality") != null) {%>
            document.getElementById('locality').value='<%= (String) request.getAttribute("locality")%>';
        <% }%>
            hideTables("addCont");
    </script>
</div>
        <div class="line" style="height:10px;" ></div>
<logic:notPresent name="userBean">
    <script type="text/javascript">
        checkall();
    </script>
</logic:notPresent>