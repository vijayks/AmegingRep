<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%@page import="com.buysell.beans.UserBean" %>
<%@page language="java" %>
<script type="text/javascript">
    function disableTotalCost(itemId)
    {
        inlineMsg('cfp1',' ');
        document.getElementById("price").style.disabled=itemId.checked;
        document.getElementById("neg1").style.disabled=itemId.checked;
        document.getElementById("neg2").style.disabled=itemId.checked;
        if(itemId.checked)
        {
            document.getElementById('info11').style.display='inline'
        }else
        {
            document.getElementById('info11').style.display='none'
        }
    }
    function priceValid(ad){
        var price=ad.price.value;
        var chked=false;
        var isChecked=document.getElementById('cfp').checked;
        for (var i=0; i < document.ad.adType.length; i++)
        {
            if (document.ad.adType[i].checked)
            {
                var adType = document.ad.adType[i].value;
            }
        }
        if(adType == "offered"){
            if(!isChecked) {
                if(price == ""){
                    return chked;}}
        }return true;
    }
    function priceValid1(ad){
        var min=ad.min.value;
        var max=ad.max.value;
        for (var i=0; i < document.ad.adType.length; i++)
        {
            if (document.ad.adType[i].checked)
            {
                var adType = document.ad.adType[i].value;
            }
        }
        if(adType == "wanted"){
            if(min == "" || max == ""){
                inlineMsg('max1','Enter Min and Max Values');
                return false;
            }
        }
        return true;
    }
    function faclitiesCheckedTest()
    {
        var facList=document.getElementsByName("fac");
        var facStr="";
        if(facList != null && facList.length > 0)
        {
            for(var i=0;i<facList.length;i++)
            {
                if(facList[i].checked == true)
                    facStr=facStr+facList[i].value+" , ";
            }
        }
        document.getElementById("facilities").value=facStr;
    }
    // This function to submit the post ad form,in user login case...
    function postAdForm(ad)
    {
        var adTitle=ad.adTitle.value;
        var description=ad.description.value;
        var city=ad.city.value;
        var locality=ad.locality.value;
        var clfid=ad.catId.value;
        var chk=false;
        // this method to add facilities check in real estate ad
        if(document.getElementById("facilities"))
        {
            faclitiesCheckedTest();
        }
        if(clfid<1) {
            alert("Select Category");
            chk=false;
        }else if(adTitle == "")
        {
            inlineMsg('adTitle','Enter Ad Title .');
            chk=false;
        }
        else if(description == "")
        {
            inlineMsg('description','Enter Description about ur Ad .');
            chk=false;
        }
    <%-- else if(!priceValid(ad)){
         inlineMsg('cfp1','Enter your Price');
         chk=false;
     }
     else if(!priceValid1(ad)){

            inlineMsg('max1','Enter Min and Max Values');
            chk=false;
        }--%>
                else if(city == ""){
                    inlineMsg('city','Select a city');
                    chk=false;
                }
                else if(locality == ""){
                    inlineMsg('locality','Select a Location');
                    chk=false;
                }
                else if(!document.ad.iagree.checked)
                {
                    alert("please accept the terms and conditions ");
                    chk=false;
                }
                else{
                    chk=true;
                    submitPressed("ad","sub");
                }
                return chk;
            }
            // This function to submit the post ad form where user not loggged in case..
            function postAdWithRegisterFormSubmit(ad)
            {
                var email=ad.email.value;
                var fname=ad.fname.value;
                var city=ad.city.value;;
                var locality=ad.locality.value;
                var address=ad.address.value;
                var ph1=ad.ph1.value;
                var regCode=ad.regCode.value;
                var adTitle=ad.adTitle.value;
                var description=ad.description.value;
                var clfid=ad.catId.value;
                var chk=false;
                //       var qselection=adValidation.qselection.value;
                var nameRegex = /^[a-zA-Z]+(([\'\,\.\- ][a-zA-Z ])?[a-zA-Z]*)*$/;
                var emailRegex = /^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$/;
                var mobileRegex= /^([98]{1})([0123456789]{1})([0-9]{8})$/;
                // this method to add facilities check
                if(document.getElementById("facilities"))
                {
                    faclitiesCheckedTest();
                }
                if(clfid<1){
                    alert("Select Category");
                    chk=false;
                }
                else if(adTitle == "")
                {
                    inlineMsg('adTitle','Enter Ad Title .');
                    chk=false;
                }
                else if(description == "")
                {
                    inlineMsg('description','Enter Description about ur Ad .');
                    chk=false;
                }
    <%--else if(!priceValid(ad)){
        inlineMsg('cfp1','Enter your Price');
        chk=false;
    }
    else if(!priceValid1(ad)){

            inlineMsg('max1','Enter Min and Max Values');
            chk=false;

        }--%>
                else
                    if(fname == "") {
                        inlineMsg('fname','You must enter your name.');
                        chk=false;
                    }
                else if(!fname.match(nameRegex)) {
                    inlineMsg('fname','You have entered an invalid name.');
                    chk=false;
                }else if(city == "")
                {
                    inlineMsg('city','Please select City');
                    chk=false;
                }
                else if(locality == "")
                {
                    inlineMsg('locality','Please select Location');
                    chk=false;
                } else if(address == "") {
                    inlineMsg('address','You must enter Address.');
                    chk=false;
                }
                else if(ad.address.value.length > 100){
                    inlineMsg('address',"You can't enter more than 100 chars.");
                    chk=false;
                }
                else if(email == "") {
                    inlineMsg('email','You must enter your email.');
                    chk=false;
                }
                else if(!email.match(emailRegex)) {
                    inlineMsg('email','You have entered an invalid email.');
                    chk=false;
                }
                else if(!(document.getElementById("notValid").style.display == 'none'))
                {
                    alert("username already exists");
                    chk=false;
                }
                else if(ph1 == "") {
                    inlineMsg('ph1','You must enter your phone number.');
                    chk=false;
                }
                else if(!ph1.match(mobileRegex)) {
                    inlineMsg('ph1','You have entered an invalid phone number.');
                    chk=false;
                }else if(regCode == "")
                {
                    inlineMsg('regCode','Please Enter the code appear in the picture');
                    chk=false;
                }else if(!document.ad.iagree.checked)
                {
                    alert("please accept the terms and conditions ");
                    chk=false;
                }
                else
                {
                    chk=true;
                    submitPressed("ad","rButton");
                }
                return chk;
            }
</script>
<script type="text/javascript">
    function showHideDiv(id)
    {
        if( document.getElementById('postImg1').style.display == 'none' || document.getElementById('postImg2').style.display == 'none' || document.getElementById('postImg3').style.display == 'none' )
        {
            document.getElementById(id).style.display = 'inline';
        }
    }
    function showAndHide(id1,id2)
    {
        document.getElementById(id1).style.display = 'inline';
        document.getElementById(id2).style.display = 'none';
    }
    function adTypeSelected(itemId1,itemId2)
    {
        // THIS CONDITION IS FOR MAKING OTHER PRICE NORMAL
        if(itemId1=='price1')
        {
            //  alert("clear budget");
            document.getElementById('min').value="";
            document.getElementById('max').value="";
        }
        else
        {
            // alert("clear total cost");
            document.getElementById('price').value="";
            //alert(document.getElementById("cfp").checked);
            //   alert(document.getElementById("neg1").checked);
            //    alert(document.getElementById("neg1").checked);
            document.getElementById("cfp").checked=false;
            disableTotalCost(document.getElementById("cfp"));
            document.getElementById("neg1").checked=true;
            document.getElementById("neg2").checked=false;
        }
        document.getElementById(itemId1).style.display = 'inline';
        document.getElementById(itemId2).style.display = 'none';
    }
    function yODis(con){
        var x=document.getElementById("yearsOld");
        if(con=='New'){
            x.value="";
            x.disabled=true;
        }
        if(con=='Used'){
            x.disabled=false;
        }
    }
    function inputLimiter(e,allow) {
        var AllowableCharacters = '';
        AllowableCharacters=' ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789.';
        var k;
        k=document.all?parseInt(e.keyCode): parseInt(e.which);
        if (k!=13 && k!=8 && k!=0){
            if ((e.ctrlKey==false) && (e.altKey==false)) {
                return (AllowableCharacters.indexOf(String.fromCharCode(k))!=-1);
            } else {
                return true;
            }
        } else {
            return true;
        }
    }
</script>
<div id="adDtls" class="tilepad">
    <div class="blueHeader">
        <div style="float:left;padding-top:6px;">Ad Details</div><div id="adDtlsMinMax" style="float:right;font-size:20px;cursor:pointer" onclick="hideTables('adDtls');">(&nbsp;&ndash;&nbsp;)</div>
    </div>
    <logic:present name="editAdForUpdateBean" >
        <%@page  import="com.buysell.beans.AdsBean" %>
        <% AdsBean ab = (AdsBean) request.getAttribute("editAdForUpdateBean");%>
        <table class="verdana_form_postAd" align="left" cellspacing="10px">
            <tr>
                <td class="textRight">Selected Category </td>
                <td>
                    <c:set var="su" > <%= ab.getCatId()%></c:set>
                    <input type="hidden" name="catId" value=${su} />
                    <c:if test="${categoryList != null}" >
                        <c:forEach items="${categoryList}" var="cat">
                            <c:if test="${cat.id == su}" >
                                <c:set var="clfname" >${cat.name}</c:set>
                                <c:set var="par">${cat.parent}</c:set>
                            </c:if>
                        </c:forEach>
                        <c:forEach items="${categoryList}" var="cat1">
                            <c:if test="${cat1.id == par}" >
                                <c:set var="parentName">${cat1.name}</c:set>
                            </c:if>
                        </c:forEach>
                    </c:if>
                    <input type="text" style="width:250px;height:18px" value='<c:out value="${parentName}" escapeXml="false"/> --> <c:out value="${clfname}" escapeXml="false" />'  readonly />
                </td>
            </tr>
            <tr><td style="padding-bottom:5px"></td></tr>
            <tr>
                <td >Ad Type</td>
                <td style="width:250px"> <input id="offered" name="adType" type="radio" value="offered" <% if (ab.getAdType().equals("offered")) {%> checked <% }%> onclick="adTypeSelected('price1','price2')"  /> Offered  <input id="wanted" name="adType" type="radio" value="wanted" <% if (ab.getAdType().equals("wanted")) {%> checked <% }%> onclick="adTypeSelected('price2','price1')"  /> Wanted
            </tr>
            <tr><td style="padding-bottom:5px"></td></tr>
            <tr>
                <td width>AD Title<font color="red"> * </font></td>
                <td><input type="text" id="adTitle" name="adTitle" style="width:250px;height:18px" value="<%= ab.getTitle()%>" maxlength="90" onkeypress="return inputLimiter(event,'NameCharacters')"/></td>
            </tr>
            <tr><td style="padding-bottom:5px"></td></tr>
            <tr>
                <td valign="top">Ad Description<font color="red"> * </font></td>
                <td><textarea rows="5" cols="50" id="description" name="description" ><%= ab.getDescription()%></textarea><br/><font color="#FF4545">Please don't give your email & moblie number here.</font></td>
            </tr>
            <tr><td style="padding-bottom:5px"></td></tr>

        </table>
        <input type="hidden" name="EImage1" value="<c:out value="${editAdForUpdateBean.image1}" />">
        <input type="hidden" name="EImage2" value="<c:out value="${editAdForUpdateBean.image2}" />">
        <input type="hidden" name="EImage3" value="<c:out value="${editAdForUpdateBean.image3}" />">
        <div style="clear:both"> </div>
        <div id="adImgs" style="padding-left:10px">
            <div class="textRight" style="float:left;width:730px;">
                <div class="textRight" style="float:left;"> Image 1</div>
                <div id="editImg1" style="float:left;width:210px;">
                    <img alt="" src="resourceGetter?imf=<%= ab.getImage1()%>" style="width:80px;height:80" >
                    <input  type="file" style="width:250px;" name="image1" value="<%= ab.getImage1()%>">
                </div>
                <div id="changeImg1" style="float:left;width:200px;display:none;">
                    <a href="javascript:return false" title="Change or Delete Images" onclick="showAndHide('postImg3','postImg22')" > Change / Delete Image</a>
                </div>
                <div id="addMoreImg1" style="float:left;width:200px;display:none;">
                    <a href="javascript:return false" title="Add more Images" onclick="showAndHide('postImg3','postImg22')" >Add More Images</a>
                </div>
            </div>
            <div class="textRight" style="float:left;width:730px;">
                <div class="textRight" style="float:left;padding-bottom:10px;"> Image 2</div>
                <div id="editImg2" style="float:left;width:210px;">
                    <img alt="" src="resourceGetter?imf=<%= ab.getImage2()%>" style="width:80px;height:80" ><input  type="file" style="width:250px;;height:18px" name="image2" value="<%= ab.getImage2()%>">
                </div>
                <div id="changeImg2" style="float:left;width:200px;display:none;">
                    <a href="javascript:return false" title="Change or Delete Images" onclick="showAndHide('postImg3','postImg22')" > Change / Delete Image</a>
                </div>
                <div id="addMoreImg2" style="float:left;width:200px;display:none;">
                    <a href="javascript:return false" title="Add more Images" onclick="showAndHide('postImg3','postImg22')" >Add More Images</a>
                </div>
            </div>
            <div class="textRight" style="float:left;width:730px;">
                <div class="textRight" style="float:left;"> Image 3</div>
                <div id="editImg3" style="float:left;width:210px;padding-bottom:10px;">
                    <img alt="" src="resourceGetter?imf=<%= ab.getImage3()%>" style="width:80px;height:80"  ><input  type="file" style="width:250px;;height:18px" name="image3" value="<%= ab.getImage3()%>">
                </div>
                <div id="changeImg3" style="float:left;width:200px;display:none;">
                    <a href="javascript:return false" title="Change or Delete Images" onclick="showAndHide('postImg3','postImg22')" > Change / Delete Image</a>
                </div>
                <div id="addMoreImg3" style="float:left;width:200px;display:none;padding-bottom:10px;">
                    <a href="javascript:return false" title="Add more Images" onclick="showAndHide('postImg3','postImg22')" >Add More Images</a>
                </div>
            </div>
        </div>
    </logic:present>
    <logic:notPresent name="editAdForUpdateBean" >
        <table class="verdana_form_postAd" align="left" cellspacing="10px" style="width:100%;table-layout:fixed">
            <tr>
                <td class="textRight" valign="top">Select Category </td>
                <td style="width:100%;"><div style="width:140px;float:left;">
                        <select   name="select" id="select" onchange="callme(this)" style="width:98%;x">
                            <option value="0" selected>Select Category</option>
                            <c:forEach items="${categoryList}" var="cat">
                                <c:if test="${cat.parent== 0}" >
                                    <option value="<c:out value='${cat.id}'/>"> <c:out value='${cat.name}' escapeXml="false"/> </option>
                                </c:if>
                            </c:forEach>
                        </select>
                    </div>
                    <%--<c:set var="su" > <%= request.getAttribute("select3")%></c:set>
                    <input type="hidden" name="catId" value=${su} />
                    <c:if test="${categoryList != null}" >
                        <c:forEach items="${categoryList}" var="cat">
                            <c:if test="${cat.id == su}" >
                                <c:set var="clfname" >${cat.name}</c:set>
                                <c:set var="par">${cat.parent}</c:set>
                            </c:if>
                        </c:forEach>
                        <c:forEach items="${categoryList}" var="cat1">
                            <c:if test="${cat1.id == par}" >
                                <c:set var="parentName">${cat1.name}</c:set>
                            </c:if>
                        </c:forEach>
                    </c:if>
                    <input type="text" style="width:250px" value='<c:out value="${parentName}" escapeXml="false"/> --> <c:out value="${clfname}" escapeXml="false" />'  readonly />--%>
                    <div style="width:165px;float:left">
                        <select  name="select3"  id="select2" onchange="callme1(this)" style="width:98%;"><option value="0" selected>Select Sub-Category</option></select>
                    </div>
                    <div style="width:165px;float:left">
                        <select name="catId"   id="select3" onchange="getTileJsps(this.value);" style="width:98%;" ><option value="0" selected>Select Classification</option></select>
                    </div>
                    <div id="lding" style="float:left;display:none"><img src="images/loading.gif" style="height:20px" alt="wait"></div>
                </td>
            </tr>
            <tr><td style="padding-bottom:10px"></td></tr>
            <tr>
                <td >Ad Type</td>
                <td style="width:100%"> <input id="offered" name="adType" type="radio" value="offered" checked onclick="adTypeSelected('price1','price2')" /> Offered  <input id="wanted" name="adType" type="radio" value="wanted" onclick="adTypeSelected('price2','price1')" /> Wanted
                </td>
            </tr>
            <tr><td style="padding-bottom:5px"></td></tr>
            <tr>
                <td width>AD Title<font color="red"> * </font></td>
                <td><input type="text" maxlength="90" style="width:450px;height:18px" id="adTitle" name="adTitle" onkeypress="return inputLimiter(event,'NameCharacters')"/></td>
            </tr>
            <tr><td style="padding-bottom:5px"></td></tr>
            <tr>
                <td valign="top">Ad Description<font color="red"> * </font></td>
                <td><textarea rows="5" cols="350" id="description" name="description" style="width:450px;"></textarea> <br/><font color="#FF4545">Please don't give your email & moblie number here.</font></td>
            </tr>
            <tr><td style="padding-bottom:5px"></td></tr>
        </table>
        <div style="clear:both"> </div>
        <input  type="hidden" name="image1" id="image1" value="" >
        <input  type="hidden" name="image2" id="image2" value="" >
        <input  type="hidden" name="image3" id="image3" value="" >
        <div id="adImgs">
            <div id="postImg1" style="float:left;width:450px;display:inline;height:20px;padding-bottom:10px;" >
                <div  class="textRight" style="float:left;width:140px"> Image 1 </div>
                <div  style="float:inherit;width:250px;">
                    <input type="file" style="width:250px;" name="image1" onchange="showHideDiv('postImg11')" />
                </div>
            </div>
            <div  id="postImg11" style="float:inherit;width:210px;display:none;;padding-bottom:10px;">
                <a href="javascript:return false" title="Add more Images" onclick="showAndHide('postImg2','postImg11')" > Add more images </a>
            </div>
            <div id="postImg2" style="float:left;width:450px;display:none;" >
                <div  class="textRight" style="float:left;width:140px;"> Image 2 </div>
                <div  style="float:left;width:250px;display:inline;padding-bottom:10px;">
                    <input type="file" style="width:250px;" name="image2" onchange="showHideDiv('postImg22')" />
                </div>
            </div>
            <div id="postImg22" style="float:inherit;width:210px;display:none">
                <a href="javascript:return false" title="Add more Images" onclick="showAndHide('postImg3','postImg22')" > Add more images </a>
            </div>
            <div id="postImg3" style="float:left;width:450px;display:none;padding-bottom:10px;" >
                <div  class="textRight" style="float:left;width:140px;display:inline;"> Image 3 </div>
                <div  style="float:left;width:250px;display:inline;">
                    <input type="file" style="width:250px;" name="image3" />
                </div>
            </div>
        </div>
    </logic:notPresent>
</div>              <div class="line" ></div>
