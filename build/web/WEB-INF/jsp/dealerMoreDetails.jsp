<%--
    Document   : dealerMoreDetails
    Created on : Dec 26, 2009, 4:44:08 PM
    Author     : Karteek
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.buysell.util.BuySellProperties" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<html>
    <head>
        <meta name="verify-v1" content="PwZKjgUkv/eSDfv+Uy0B+3cq/8kRGNuDOWAJpSWyHSw=" />
        <meta name="google-site-verification" content="otOLqBKAgj_fgOlHw-rn8uqTr2q5IzwwTZi4KaNZoDE" />
        <title>${dmi.compName} - ${dmi.city}</title>
        <meta name="description" content="${dmi.compName} - ${dmi.city}"/>
        <meta name="keywords" content="${dmi.compName} - ${dmi.city}" />

        <link rel="StyleSheet" href="<c:url value='/css/stylesheet.css'/>" type="text/css">
        <link rel="StyleSheet" href="<c:url value='/css/jquery-ui-1.8.24.custom.css'/>" type="text/css">
        <script type="text/javascript" src="<c:url value='/js/dealerAjax.js'/>"></script>
        <script type="text/javascript" src="<c:url value='/js/allAjax.js'/>"></script>
        <script type="text/javascript" src="<c:url value='/js/jquery-1.8.2.min.js'/>"></script>
        <script type="text/javascript" src="<c:url value='/js/jquery-ui-1.8.24.custom.min.js'/>"></script>
        <link rel="shortcut Icon" href="<c:url value='/bbsimages/favicon.ico'/>"/>
        <%--padding:10px 0px 5px 10px;--%>
    </head>
    <body style="margin:0px ">
        <c:set var="typ" value="${dmi.dtypeId}"/>
    <style>
        #moreMD { font-size:12px;font-weight:bold; }
        #dm { font-size:12px; }
        #ins div { background-color:${clr}; }
        #insDet div { background-color:#ffffff; }
        #fieldHead { font-size:18px;font-weight:bold;color:#046DBE; }
        .txtopt, .pad input[type=text] {
            border:1px solid #BFBFBF; padding-left:3px; color:#6F6F6F; font-size:12px;font-family:arial; background-color:#FFFFFF;
        }
        .pad td { padding-top:4px; }
        .pad {
            font-size:12px; background-color:white; width:100%;padding:5px 0px;padding-left:2%;color:#D55D0C;
        }
        .imagescolor:link {
            font-size:14px; font-weight:bold; color:#FF9900; text-decoration:none;
        }
        .imagescolor:hover {
            font-size:14px; font-weight:bold; color:#00CCFF; text-decoration:none;
        }
        .greyDiv {
            font-size:13px; width:99%; clear:both; -moz-border-radius:7px; -webkit-border-radius:7px;
        }
        .greyDivTitle {
            padding:10px 2%; color:black; font-weight:bold; width:96%; float:left;
        }
        .greyDivTitle span { float:left; }
        .greyDivTitle a {
            color:black; text-decoration:underline; font-size:12px; float:right;
        }

        h1, h2, h3, h4, h5, h6 {
            font-size: 100%;font-weight: normal;
        }
        <%--
    .send-form{ background: url('images/nav_bg.jpg') repeat-x 0 0;}
    .f-form{ z-index: 9999; position: fixed; top: 0; width: 100%;} /* this make our menu float top */
        --%>

    </style>
    <script type="text/javascript">
        function showImg(divid) {
            var n=document.getElementById('noim').value;
            var i=1;
            for(i=1;i<=n;i++) {
                document.getElementById('im'+i).style.display='none';
            } document.getElementById(divid).style.display='inline';
        }
        function bookmark_us(){
            if (window.sidebar){ // firefox
                window.sidebar.addPanel('${dmi.compName} in BharatBuySell',document.location.href, "");
            }else if(window.opera && window.print){ // opera
                var elem = document.createElement('a');
                elem.setAttribute('href',url);
                elem.setAttribute('title',title);
                elem.setAttribute('rel','sidebar');
                elem.click();
            }
            else if(window.chrome){
                alert('Press ctrl+D to bookmark (Command+D for macs) after you click Ok');
            } 
            else if(document.all)// ie
                window.external.AddFavorite(document.location.href,'${dmi.compName} in BharatBuySell');
        }
        function clear3(obj){
            obj.value="";
        }
        function retainValueMs(obj) {
            if(obj.value == '' && obj.name == 'msName') {
                obj.value = 'Name';
            }
            else if(obj.value == '' && obj.name == 'msMobileNumber') {
                obj.value = 'Mobile Number';
            }
            else if(obj.value == '' && obj.name == 'msEmail') {
                obj.value = 'Email (Optional)';
            }
            else if(obj.value == '' && obj.name == 'msDesc') {
                obj.value = document.getElementById('msDesc').innerHTML;
            }
        }
        function msValidation(){
            var category = document.getElementById("msCategory").value;
            var city = document.getElementById("msCity").value;
            var desc = document.getElementById("msDesc").value;
            var name = document.getElementById("msName").value;
            var email = document.getElementById("msEmail").value;
            var mobileNumber = document.getElementById("msMobileNumber").value;
            var mobileRegex= /^([987]{1})([0123456789]{1})([0-9]{8})$/;
            if(category == 0 ){
                alert("Select Category");
                return false;
            }else if(city == "" || city == "Select City"){
                alert("Select City");
                return false;
            }else if(desc == "" || desc == "Please enter the details of service you are looking for (Mandatory)"){
                alert("Enter your description");
                return false;
            }else if(name == "" || name == "Name"){
                alert("Enter your name");
                return false;
            }else if(mobileNumber == "" || mobileNumber == "Mobile Number"){
                alert("Enter your mobile number");
                return false;
            }else if(!mobileNumber.match(mobileRegex)) {
                alert("You entered an invalid mobile number");
                return false;
            }else {
                if(email== 'Email (Optional)')
                    email="";
                var dlrId=0;
        <c:if test="${dmi!=null&&dmi.dId!=0}">
                    dlrId='${dmi.dId}';
        </c:if>
                    sendUserLead(name,desc,mobileNumber,email,city,category,dlrId,"<c:url value='/uls'/>");
                }
            }

        <%--
                var _rys = jQuery.noConflict();
                _rys("document").ready(function(){
            _rys(window).scroll(function () {
                if (_rys(this).scrollTop() > 500) {
                    _rys('.send-form').addClass("f-form");
                } else {
                    _rys('.send-form').removeClass("f-form");
                }
            });
        });
        --%>
    </script>
    <script type="text/javascript">
        $(function() {
            var $tabs = $('#tabs').tabs();
            $(".ui-tabs-panel").each(function(i){
                var totalSize = $(".ui-tabs-panel").size() - 1;
                if (i != totalSize) {
                    next = i + 2;
                    $(this).append("<a href='#' class='next-tab mover' rel='" + next + "'>Next Page &#187;</a>");
                }
                if (i != 0) {
                    prev = i;
                    $(this).append("<a href='#' class='prev-tab mover' rel='" + prev + "'>&#171; Prev Page</a>");
                }
            });
            $('.next-tab, .prev-tab').click(function() {
                $tabs.tabs('select', $(this).attr("rel"));
                return false;
            });
        });
        function viewDetails()
        {
            document.getElementById("details").style.display="none";
            document.getElementById("showDetails").style.display="inline";
            micrositeViewAjaxFun('msView${dmi.dId}wl');resourceGetter
        }
    </script>
    <div>
        <c:if test="${dmi != null}" >
            <!--- Microsite header Starts--->
            <center><div style="color: #BFBFBF;font: 1.1em/1 arial,helvetica,sans-serif;font-size:12px;overflow: hidden;margin-top:-5px "><h1>${dmi.compName} - ${dmi.city}</h1></div></center>
            <table width="1000px" bgcolor="#ffffff" align="center" style="border:1px solid #EBEBEB;margin-top:-5px; ">
                <tr>  <td>
                        <table align="center" width="1000px" >
                            <tr> <td style="width:1000px; height:100px;">
                                    <c:if test="${images!=null}"> <c:set var="ic" value="1"/> <c:forEach items="${images}" var="imag" begin="0" end="0"> <div style="display:inline;"> <div style="width:1000px; height:100px;"> <img src="<c:url value='/resourceGetter?imf=${imag}'/>"  style="width:1000px; height:100px;background-repeat:no-repeat;" alt="${dmi.compName}"/> </div> </div> </c:forEach> </c:if>
                                        </td>
                                    </tr>
                                </table> <!--- Microsite header Ends--->
                                <!--- Microsite Body Starts--->
                                <!--- Body1 Starts--->
                                <table align="center" width="1000px">
                                    <tr>
                                        <td style="width:745px;height:300px;">
                                    <c:if test="${fn:length(images)==0}"><div style="width:745px ; height:300px;border:1px solid #AAAAAA">No images found</div></c:if>
                                    <c:if test="${images!=null}"> <c:set var="ic" value="1"/> <c:forEach items="${images}" var="imag" begin="5" end="9">
                                            <div id="im${ic}" style="display:none;"> <div style="width:745px ; height:300px;"> <img src="<c:url value='/resourceGetter?imf=${imag}'/>"  style="width:745px ; height:300px;border:1px solid #AAAAAA" alt="${dmi.compName}${ic}"/> </div> </div>
                                                    <c:set var="ic" value="${ic+1}"/> </c:forEach>
                                                <c:set var="ic" value="1"/> <div id="moreMD"align="center" style="width:745px;float:left;padding-top:3px;border:1px solid #AAAAAA">
                                            <c:forEach items="${images}" var="imag" begin="5" end="9"> <a class="imagescolor" title="${ic}"href="javascript:return false" onclick="showImg('im${ic}');" >${ic}</a> <c:set var="ic" value="${ic+1}"/> </c:forEach> </div>
                                        <input type="hidden" id="noim" value="${ic-1}"> <script type="text/javascript">showImg('im1');</script>
                                    </c:if>
                                </td>
                                <td valign="top"> <div style="border: 1px solid #AAAAAA;height:321px;width:230px;padding-left:10px;padding-right:5px;">
                                        <c:if test="${dmi.businessDetails!=null}"><br/><span id="fieldHead">Business Details</span><br/><br/><div id="dm"> <b>*</b>&nbsp; <c:out value="${fn:substringBefore(dmi.businessDetails,'|')}"/><br/><br/><b>*</b>&nbsp; <c:out value="${fn:substringAfter(dmi.businessDetails,'|')}"/><br/></div> </c:if>
                                        </div>
                                    </td>
                                </tr>
                            </table> <!--- Body1 Ends--->
                            <!--- Body2 Starts--->
                            <table align="center" width="1000px" >
                                <tr>
                                    <td style="width:725px; height:300px;padding-left:10px;border:1px solid #AAAAAA;font-size:12px;" valign="top"><br />
                                        <h1 style="font-size:23px;">${dmi.compName}</h1><span id="fieldHead">About Us</span>
                                    <div style="padding-top:5px;">  ${dmi.addInfo}</div><br/><br/><span id="fieldHead">Product/Services</span>
                                    <c:if test="${fn:length(products)==0}">No products information found</c:if>
                                    <c:if test="${products!=null}">
                                        <script type="text/javascript">
                                            $(function() {
                                                $("#products").tabs();
                                            });
                                        </script>
                                        <div id="products">
                                            <ul>
                                                <c:set var="prdCount">1</c:set>
                                                <c:forEach items="${products}" var="pds">
                                                    <c:forEach var="hdr" items="${fn:split(pds, '^^^')}" begin="0" end="0">
                                                        <li><a href="#products-${prdCount}"> ${hdr}</a></li>
                                                    </c:forEach>
                                                    <c:set var="prdCount" value="${prdCount+1}"></c:set>
                                                </c:forEach>
                                            </ul>
                                            <c:set var="prdCount">1</c:set>
                                            <c:forEach items="${products}" var="pds">
                                                <c:forEach var="prdDtls" items="${fn:split(pds, '^^^')}" begin="1" end="1">
                                                    <div id="products-${prdCount}" style="min-height:250px;border: 1px solid #AAAAAA"><p> ${prdDtls}</p></div>
                                                </c:forEach>
                                                <c:set var="prdCount" value="${prdCount+1}"></c:set>
                                            </c:forEach> </div>
                                        </c:if>
                                </td>
                                <%--Reply Form Starts--%>
                                <td style="width:244px; height:300px;" valign="top">

                                    <%--    <div class="send-form">--%>
                                    <div id="userLead" class="greyDiv" style="display:inline;"> <div <c:if test="${images!=null}"><c:set var="ic" value="1"/>
                                                <c:forEach items="${images}" var="imag" begin="2" end="2">  style="background-image:url('<c:url value='/resourceGetter?imf=${imag}'/>');color:black;font-size:15px;padding-top:15px;font-weight:bold;height:27px;background-repeat:no-repeat;"</c:forEach>
                                            </c:if>>
                                            <c:choose><c:when test="${dmi!=null && dmi.compName!=null}"><center>Send SMS Request </center> </c:when><c:otherwise>Receive Calls with Best Rates</c:otherwise></c:choose></div>
                                                <div style="border:1px solid #AAAAAA"> <table class="pad" > <tr><td><br/>I am looking for service in</td></tr>
                                                        <tr>
                                                            <td><select id="msCategory" class="txtopt" name="msCategory" style="width:180px"><option value="0" selected="selected"> Select Category </option>
                                                            <c:if test="${categoryList != null}" ><c:forEach items="${categoryList}" var="category">
                                                                    <c:if test="${category.parent == 0}"> <optgroup style="background:#dddddd;font-style:normal;font-weight:normal;label="${category.name}">
                                                                            <c:if test="${category.subCategories != null}"><c:forEach items="${category.subCategories}" var ="cat"><option style="background:#ffffff" value="${cat.id}" ><c:out value="${cat.name}" escapeXml="false"/></option></c:forEach></c:if>
                                                                        </optgroup> </c:if> </c:forEach>
                                                            </c:if>
                                                        </select>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>City <select id="msCity" class="txtopt" name="msCity" style="width:116px"> <option value="" selected="true" >Select City</option>
                                                            <c:if test="${cities  != null }"> <c:forEach items="${cities}" var="city"> <option value="<c:out value='${city.name}'/>"><c:out value="${city.name}"/></option>  </c:forEach> </c:if>
                                                                </select></td>
                                                        </tr>
                                                        <tr>  <td><br/><textarea style="width:225px;height:100px;" id="msDesc" class="txtopt" name="msDesc" rows="3" onfocus="clear3(this)" onblur="retainValueMs(this)">Please enter the details of service you are looking for (Mandatory)</textarea></td> </tr>
                                                    </table>
                                                    <table class="pad">
                                                        <tr> <td><input type="text" id="msName" name="msName" value="<c:if test="${userBean.firstName!=null}">${userBean.firstName}</c:if><c:if test="${userBean.firstName==null}">Name</c:if>" onfocus="clear3(this)" onblur="retainValueMs(this)"></td> </tr>
                                                <tr> <td><input type="text" id="msMobileNumber" name="msMobileNumber" value="<c:if test="${userBean.mobile!=null}">${userBean.mobile}</c:if><c:if test="${userBean.mobile==null}">Mobile Number</c:if>" onfocus="clear3(this)" onblur="retainValueMs(this)"></td> </tr>
                                                <tr> <td><input type="text" id="msEmail" name="msEmail" value="<c:if test="${userBean.loginName!=null}">${userBean.loginName}</c:if><c:if test="${userBean.loginName==null}">Email (Optional)</c:if>" onfocus="clear3(this)" onblur="retainValueMs(this)"></td> </tr>
                                                    <tr align="center"> <td><input type="button" value="Send SMS" onclick="msValidation();"></td> </tr>
                                                </table>
                                                <table class="pad">
                                                    <tr><td><div id="ulMsg"></div>
                                                            <div id="ulVerCode" style="display:none;color:#a80000;font-weight:bold;"><blink>Enter Verification Code</blink> 
                                                                    <input type="text" id="ulvc" style="width:40px;"><input type="button" value="Verify" onclick="verifyUserLead((document.getElementById('ulvc')),'<c:url value='/uls'/>')">
                                                        </div>
                                                        <div id="dfltVerMsg" style="font-family: Verdana, Arial, Helvetica, sans-serif;font-size:12px;color:#0A489A;"></div>
                                                        <div id="ulVerMsg"></div>
                                                    </td></tr>
                                            </table>
                                        </div>
                                    </div>
                                    <script type="text/javascript">
                                        <% if(request.getAttribute("subCatId") != null) { %>
                                            document.getElementById("msCategory").value='<%=request.getAttribute("subCatId")%>';
                                        <% } else if(request.getParameter("subCatId")!=null) { %>
                                            document.getElementById("msCategory").value='<%=request.getParameter("subCatId")%>';
                                        <% } %>
                                            document.getElementById("msCity").value='${city}';
                                    </script>
                                </td>
                                <%--Reply Form End--%>
                            </tr>
                        </table> <!--- Body2 Ends--->
                        <!--- Body3 Starts--->
                        <table id="dm" align="center" width="1000px" cellspacing="10px">
                            <tr>
                                <td valign="top" <c:if test="${images!=null}"><c:set var="ic" value="1"/> <c:forEach items="${images}" var="imag" begin="4" end="4">  style="background-image:url('<c:url value='/resourceGetter?imf=${imag}'/>');width:300px; height:300px;background-repeat:no-repeat;"  </c:forEach> </c:if>>
                                            <div style="padding-left:30px;padding-right:15px;padding-top:40px;">
                                                <span id="moreMD">Address:</span><br/> ${dmi.address}<br/>
                                        <c:if test="${dmi.landMark!=null}"> <br/><span id="moreMD">Land Mark:</span><br/> ${dmi.landMark}<br/>  </c:if>
                                            <a onclick="viewDetails()" id="details" style="text-decoration:none;"> <br/> <div style="background-color:#98BF21;border-radius:3px;font-size:15px;font-weight:bold;height:21px;width:140px;border:1px solid white;text-align:center;color:white;padding-top:3px;cursor:pointer" onmouseover="style.backgroundColor='#89AC1E'" onmouseout="style.backgroundColor='#98BF21'">Contact Us</div></a>
                                            <div id="showDetails"  style="display:none">
                                                <br/><span id="moreMD">Phone:</span><br/> ${dmi.phone}<br/>
                                            <br/><span id="moreMD">Mobile:</span><br/> ${dmi.mobile}<br/>
                                            <br/><span id="moreMD">Email-id:</span><br/> ${dmi.emailId}<br/>
                                            <c:if test="${dmi.webUrl!=null && dmi.webUrl!=''}"> <br/><span id="moreMD">Website:</span><br/>  <c:if test="${fn:startsWith(dmi.webUrl,'http://') == true}" > <a title="Dealer's Website" target="_blank" href="${dmi.webUrl}" rel="nofollow">${dmi.webUrl}</a> </c:if>
                                                <c:if test="${fn:startsWith(dmi.webUrl,'http://') != true}" > <a title="Dealer's Website"target="_blank" href="http://${dmi.webUrl}" rel="nofollow">${dmi.webUrl}</a> </c:if>
                                            </c:if></div>
                                    </div>
                                </td>
                                <td <c:if test="${images!=null}"><c:set var="ic" value="1"/> <c:forEach items="${images}" var="imag" begin="4" end="4">  style="background-image:url('<c:url value='/resourceGetter?imf=${imag}'/>');width:300px; height:300px;background-repeat:no-repeat;" </c:forEach> </c:if> >
                                    <div align="center"> <c:set var="ic" value="1"/> <c:forEach items="${images}" var="imag" begin="3" end="3"> <img src="<c:url value='/resourceGetter?imf=${imag}'/>"  style="background-repeat:no-repeat;" alt="${dmi.compName}"/> </c:forEach> </div><br/>
                                    <div style="padding-left:25px;padding-right:20px;"> Contact <b>${dmi.compName}</b> for more details<br/><br /></div>
                                    <div style="float:left;padding-left:25px;"> <a title="Save Dealer Details in your Mobile" href="javascript:return false" onclick="SaveToMobileDlrAjaxFun('Div','dlId=${dmi.dId}&domainName=${dmi.compName}&city=${dmi.city}&locality=${dmi.locality}&mobile=${dmi.phone}','<c:url value="/irrsdl"/>');"><img src="<c:url value='/bbsimages/save_mbl.png;'/>" style="border:none"/> </a></div>
                                    <div style="float:left;padding-left:25px;"> <a title="Bookmark this page" href="javascript:return false" onclick="bookmark_us();"><img src="<c:url value='/bbsimages/add_brmk.png;'/>" style="border:none"/></a><br/></div>
                                    <div style="float:left;padding-left:25px;width: 200px;"> <c:if test="${userBean!=null}"><div id="msgDiv" ></div></c:if> <c:if test="${userBean==null}"><div style="color:red;">* Please Login to Save</div></c:if> </div><br/><br/><br/><br/>



                                    <c:set var="dName" value="${dmi.compName}" scope="request"/>
                                     <c:set var="dId" scope="request"><bean:write name="dmi" property="dId"  /></c:set>
                                  
                                    <% String dUrl = ""; String dId = "";String dUrlFull = "";
                                     dUrl = (String) request.getAttribute("dName");
                                     dId = (String) request.getAttribute("dId");
                                     dUrl = dUrl.replaceAll(" ", "-" );
                                     dUrl = dUrl.replaceAll("/", "-" );
                                     dUrl ="/" + dUrl;
                                     dUrlFull="/allAds-" +dId + dUrl +".html";
                                      %>

                                    <div align="center"> <a title="Check all Dealer ads" href="<c:url value='/allAds-${dmi.dId}/${dmi.compName}.html'/>" target="_blank"><img src="<c:url value='/bbsimages/check_ads.png;'/>" style="border:none"/> </a></div><br/>

                                <td style="width:318px; height:300px;" align="right"> <c:if test="${dmi.googleMap==null }"><div style="padding:90px 70px;"> No Map Found</div></c:if>
                                    <c:if test="${dmi.googleMap!=null }"> 
                                        <iframe width="318px" height="313px" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" src="${dmi.googleMap}" style="border:1px solid #AAAAAA"> </iframe> </c:if>
                                    </td>
                                </tr>
                            </table> <!--- Body3 Ends--->
                            <!--- Microsite Body Ends--->
                            <!--- Microsite Footer Starts--->
                            <table id="dm" width="1000px" align="center" cellspacing="0" style="padding-top:5px;">
                                <tr <c:if test="${images!=null}"><c:set var="ic" value="1"/>  <c:forEach items="${images}" var="imag" begin="1" end="1">  style="background-image:url('<c:url value='/resourceGetter?imf=${imag}'/>');background-repeat:no-repeat;" </c:forEach> </c:if>>
                                        <td>
                                            <div  style="width:296px;float:right;"><a href="http://bharatbuysell.com/" title="Free Classifieds, India Classifieds, Free India Classifieds">  <img src="<c:url value='/bbsimages/dealer_footer.png'/>" style="width:295px;height:98px;border:none" alt="Free Classifieds, India Classifieds, Free India Classifieds"/></a>  </div>
                                    <div style="width:275px;float:right;padding-top:15px;text-align:center">Join <b>Bharatbuysell</b> to give Your Business the Maximum Exposure it Deserves.<br/>A Wide Variety of Products and Projects,Browse and Find the Best Deals in Your City. </div>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
            <!--- Microsite Footer Ends--->
            <div style="clear:both"></div>
            <%--these are used for save to mobile--%>
            <div id="unnecessaryDivs" style="display:none">`
                <div id="loadDiv" style="display:none"></div> <div id="formDiv" style="display:none"></div>
            </c:if>
        </div></div>
</body>
</html>
