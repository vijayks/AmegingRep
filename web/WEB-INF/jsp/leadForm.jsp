<%--
    Document   : leadForm
    Created on : Jan 16, 2013, 4:37:52 PM
    Author     : Karteek
--%>
<%@page  import="com.buysell.util.Category " %>
<%@page import="com.buysell.util.CategoryUtil" %>

<link href="css/New/bharth.css" type="text/css" rel="stylesheet" />
<!--dropdown-->
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link rel="stylesheet" type="text/css" href="css/New/dd.css" />
<%--<script type="text/javascript" src="js/New/js/jquery-1.6.1.min.js"></script>--%>
<script type="text/javascript" src="js/jquery-1.8.2.min.js"></script>
<script type="text/javascript" src="js/jquery-ui-1.8.24.custom.min.js"></script>
<script type="text/javascript" src="js/New/js/jquery.dd.js"></script>
<script type="text/javascript" src="js/allAjax.js"></script>
<script type="text/javascript" src="js/alljs.js"></script>
<script type="text/javascript" language="javascript">


    function ulValidation1(element){
        var category = document.getElementById("ulCategory").value;
        var city = document.getElementById("ulCity").value;
        var desc = document.getElementById("ulDesc").value;
        var name = document.getElementById("ulName").value;
        var email = document.getElementById("ulEmail").value;
        var mobileNumber = document.getElementById("ulMobileNumber").value;
        var mobileRegex= /^([987]{1})([0123456789]{1})([0-9]{8})$/;
        var emailRegex = /^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$/;
        if(category == 0 ){
            alert("Select Category");
            return false;
        }else if(city == "" || city == "Select City"){
            alert("Select City");
            return false;
        }else if(desc == "" ){
            alert("Enter your valuable comment");
            return false;
        }else if(name== 'Name'|| name== ""){
            alert("Enter your name");
            return false;
        }else if(mobileNumber == "" || mobileNumber == "Phone"){
            alert("Enter your mobile number");
            return false;
        }else if(!mobileNumber.match(mobileRegex)) {
            alert("You entered an invalid mobile number");
            return false;
            }else if(email== "") {
            alert("Enter Email Id");
            return false;
        }else if(email!= 'Email (Optional)' && !email.match(emailRegex)) {
            alert("You entered an invalid email Id");
            return false;
        }
        else {
            if(email== 'Email (Optional)'||email== "")
                email="";
            var dlrId=0;
    <c:if test="${dmi!=null&&dmi.dId!=0}">
                dlrId='${dmi.dId}';
    </c:if>
                sendUserLead(name,desc,mobileNumber,email,city,category,dlrId,"<c:url value='/uls'/>");
                element.style.display="none";
                document.getElementById("pop-up").style.display="none";
            }
        }
</script>
<%--<script type="text/javascript">
    $(document).ready(function() {

        try {
            oHandler = $("#ulCategory").msDropDown({mainCSS:'dd5'}).data("dd");
            //alert($.msDropDown.version);
            //$.msDropDown.create("body select");
            $("#ver").html($.msDropDown.version);
        } catch(e) {
            alert("Error: "+e.message);
        }
    })

</script>--%>
<%--<script type="text/javascript">
    $(document).ready(function() {

        try {
            oHandler = $("#ulCity").msDropDown({mainCSS:'dd5'}).data("dd");
            //alert($.msDropDown.version);
            //$.msDropDown.create("body select");
            $("#ver").html($.msDropDown.version);
        } catch(e) {
            alert("Error: "+e.message);
        }
    })

</script>--%>
<%
    String selectedScId = request.getParameter("scId");
    if(selectedScId!=null && selectedScId.trim().length()>0) {
         int catid=0;
         try{catid=Integer.parseInt(selectedScId);}catch(Exception e){}
         CategoryUtil cu = new CategoryUtil();
         if (cu.getRootCatId(catid) != 0) {
            catid = cu.getRootCatId(catid);
            if (cu.getRootCatId(catid) != 0) {
                catid = cu.getRootCatId(catid);
            }
        }
        Category cat1 = cu.getCategoryByID(catid);
        pageContext.setAttribute("selectedScId",selectedScId);
%>
<script type="text/javascript">
    $(document).ready(function() {
        $("#MainCgName").html('<%=cat1.getName()%>');
        $(".helppage_home_img").css("background-image","url('resourceGetter?imf=<%=cat1.getImagePath()%>')");
        //$("#MainCgImage").html('<img src="resourceGetter?imf=<%=cat1.getImagePath()%>"/>');
    });
</script>
<%
}
%>
<!--dropdown-->
<div class="help_main_bg">
    <div class="helppage_img"></div>
    <div class="get_best_cont_txt">Get Best <span id="MainCgName"></span> Deals</div>
    <div class="get_best_close"><img src="bbsimages/New/Close.png" onclick="$('div#contactable', window.top.document).click();" style="cursor:pointer"/></div>
    <div class="helppage_right">
        <div class="i_am_cont_txt">I am looking for best deals in</div>
        <div class="helppage_1_box_cont" style="margin-left:-3px;">
            <select id="ulCategory" name="ulCategory" style="width:232px"><option value="0" selected="selected"> Select Category </option>
                <c:if test="${categoryList != null}" >
                    <c:forEach items="${categoryList}" var="category">
                        <c:if test="${category.parent == 0}"><optgroup style="label="${category.name}">
                                <c:if test="${category.subCategories != null}">
                                    <c:forEach items="${category.subCategories}" var ="cat">
                                        <option value="${cat.id}" <c:if test="${selectedScId>0 && selectedScId==cat.id}">selected</c:if> >
                                            <c:out value="${cat.name}" escapeXml="false"/>
                                        </option>
                                    </c:forEach>
                                </c:if>
                            </optgroup>
                        </c:if>
                    </c:forEach>
                </c:if>
            </select>
        </div>
        <div class="helppage_2_box_cont"  style="margin-left:-3px;">
            <select id="ulCity" class="txtopt" name="ulCity" style="width:232px">
                <option value="" selected="true" >Select City</option>
                <c:if test="${cities  != null }">
                    <c:forEach items="${cities}" var="city">
                        <option value="<c:out value='${city.name}'/>">
                            <c:out value="${city.name}"/>
                        </option>
                    </c:forEach>
                </c:if>
            </select>
        </div>
        <div class="helppage_3_box_cont"><strong>COMMENT:</strong>
            <textarea name="ulDesc" id="ulDesc" class="comment_txt_box"></textarea>
        </div>
        <div class="contact_details_cont_txt"><strong>Contact Details:</strong></div>

        <div class="helppage_name_mt_cont">
            <c:if test="${userBean!=null}">
                <div class="helppage_name_mt_left">
                    <input name="ulName" class="phone_txt_box"  id="ulName" type="text" value="<c:if test="${userBean.firstName!=null}">${userBean.firstName}</c:if><c:if test="${userBean.firstName==null}"></c:if>"/>
                    </div>

                    <div class="helppage_name_mt_left" style="margin-top:4px;">
                            <input name="ulMobileNumber" id="ulMobileNumber"  type="text" class="phone_txt_box" value="<c:if test="${userBean.mobile!=null}">${userBean.mobile}</c:if><c:if test="${userBean.mobile==null}"></c:if>"  />
                    </div>
                    <div style="float:left; margin-top:8px;">
                            <input name="ulEmail" id="ulEmail" class="phone_txt_box" type="text" value="<c:if test="${userBean.loginName!=null}">${userBean.loginName}</c:if><c:if test="${userBean.loginName==null}">Email (Optional)</c:if>" onfocus="if(this.value == 'Email (Optional)') this.value = ''" onblur="if(this.value == '') this.value = 'Email (Optional)'" value="Email (Optional)"  style="color:#999999; font-family:Arial, Helvetica, sans-serif; font-size:12px;"/>
                    </div>
                <%--  For Cart Hunt
                 <c:if test="${selectedScId==33}">
                     <div align="right" style=""> <img src="bbsimages/New/cart3.png" width="50" height="50"/></div>
             </c:if>
                      For Cart Hunt
                --%></c:if>
            <c:if test="${userBean==null}">
                <div class="helppage_name_mt_left">
                    <input name="ulName" class="phone_txt_box" id="ulName" type="text" value="Name" onfocus="if(this.value =='Name') this.value =''" onblur="if(this.value =='') this.value ='Name'" style="color:#6f6e6e; font-family:Arial, Helvetica, sans-serif; font-size:12px;"/>
                </div>
                <div class="helppage_name_mt_left" style="margin-top:4px;">
                    <input name="ulMobileNumber" id="ulMobileNumber"  class="phone_txt_box" type="text" value="Phone" onfocus="if(this.value == 'Phone') this.value = ''" onblur="if(this.value == '') this.value = 'Phone'" style="color:#6f6e6e; font-family:Arial, Helvetica, sans-serif; font-size:12px;"/>
                </div>
                <div style="float:left; margin-top:8px;">
                    <input name="ulEmail" id="ulEmail" class="phone_txt_box" type="text" value="<c:if test="${userBean.loginName!=null}">${userBean.loginName}</c:if><c:if test="${userBean.loginName==null}">Email (Optional)</c:if>" onfocus="if(this.value == 'Email (Optional)') this.value = ''" onblur="if(this.value == '') this.value = 'Email (Optional)'" value="Email (Optional)"  style="color:#999999; font-family:Arial, Helvetica, sans-serif; font-size:12px;"/>
                    </div>
            </c:if>
            <div class="helppage_name_mt_right">
                <div class="helppage_submit_button"><a onclick="ulValidation1(this);"></a></div>
            </div>
            <div class="dont_pop_cont_txt" id="pop-up"><input id="autoShowHelp" name="admincheck" type="checkbox" value="" style="float:left; margin-right:5px; " onclick="storeUserInput(this);" />Don't pop-up till I open</div>
            <table class="pad">
                <tr><td><div id="ulMsg" style="width:218px;"></div>
                        <div id="ulVerCode"  style="display:none;color:#a80000;font-weight:bold;width:218px;">
                            <input id="ulvc" class="captcha_txt_box" type="text" style="color:#6f6e6e; font-family:Arial, Helvetica, sans-serif; font-size:12px;"/>
                            <div class="verify_submit_button"><a onclick="verifyUserLead(document.getElementById('ulvc'),'<c:url value='/uls'/>');"></a></div>
                            <div id="dfltVerMsg" style="width:220px;float:left;height: auto;font-family: Verdana, Arial, Helvetica, sans-serif;font-size:12px;color:#0A489A;">Verification Code has been sent to your moblie. Please enter the code above</div>
                        </div>
                        <div id="ulVerMsg" style="width:220px;margin-top:35px;font-family: Verdana, Arial, Helvetica, sans-serif;font-size:12px;"></div>
                    </td></tr>
            </table>
        </div>
    </div>
    <c:if test="${selectedScId==null}" > <div class="BBS_Logo_img" ></div> </c:if>
    <c:if test="${selectedScId != null}" > <div class="helppage_home_img" id="MainCgImage"></div> </c:if>
    </div>
    <script type="text/javascript">
    <% if(request.getAttribute("subCatId") != null) { %>
        document.getElementById("ulCategory").value='<%=request.getAttribute("subCatId")%>';
    <% } else if(request.getParameter("subCatId")!=null) { %>
        document.getElementById("ulCategory").value='<%=request.getParameter("subCatId")%>';
    <% } %>
        document.getElementById("ulCity").value='${city}';

        function storeUserInput(elm) {
            eraseCookie("leadPopUpDisturb");
            createCookie("leadPopUpDisturb",elm.checked ? "yes" : "no",1);
        }
        if("yes"==readCookie("leadPopUpDisturb")) {
            document.getElementById("autoShowHelp").checked=true;
        }
</script>
