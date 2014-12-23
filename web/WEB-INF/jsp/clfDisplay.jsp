<%--
    Document   : body
    Created on : Mar 1, 2009, 1:03:49 PM
    Author     : bbsadmin
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.buysell.util.AddCountUtil" %>
<%@page import="com.buysell.beans.BodyResultBean" %>
<%@page  import="com.buysell.beans.AdsResultsBean " %>
<%@page  import="com.buysell.util.Category " %>
<%@page  import="com.buysell.util.CategoryUtil " %>
<%@page  import="java.io.OutputStream " %>
<%@page  import="java.io.FileInputStream " %>
<%@page  import="java.util.List " %>
<%@page  import="java.util.Iterator " %>
<%@page import="com.buysell.beans.UserBean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import="com.buysell.util.BuySellProperties" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<script type='text/javascript' src='js/New/jquery.simplemodal.js'></script>
<%
        String subCatId = request.getParameter("subCatId");
        if (subCatId == null) {
            subCatId = "15";
        }
        CategoryUtil cu = new CategoryUtil();
        if (cu != null) {
            Category cat1 = cu.getCategoryByID((Integer.parseInt(subCatId)));

%>
<% String localUrlPath = "/";
if (BuySellProperties.getProperty("localurl") != null && BuySellProperties.getProperty("localurl").trim().length() > 0) {
                localUrlPath = BuySellProperties.getProperty("localurl");
            }
%>




<script type="text/javascript">
    
    function areaConverterPop()
    {
        $('#basic-area-converter').modal();
          
        $( "#area_Cnvtr_Pop_Close" ).click(function (e) {
            $.modal.close();
        });
    }
    function numbersonly(e, decimal) {

        var key;
        var keychar;
        if (window.event) {key = window.event.keyCode;}
        else if (e) {key = e.which;}
        else {return true;}
        keychar = String.fromCharCode(key);
        if ((key==null) || (key==0) || (key==8) ||  (key==9) || (key==13) || (key==27) ) {
            return true;
        }
        else if ((("0123456789").indexOf(keychar) > -1)) {return true;}
        else if (decimal && (keychar == ".")) {return true;}
        else return false;
    }
    function convertUnit() 
    {
        var Value1 = document.getElementById('first').value;
        var dropdown = document.getElementById("List");
        var dropdown2 = document.getElementById("List1");
        var List = dropdown.options[dropdown.selectedIndex].value;
        var List1 = dropdown2.options[dropdown2.selectedIndex].value;

        if(Value1==""){
            alert("Please Enter Value");
           return false;
        }else if(List=="")
        {
            alert("Please Select ' From ' Option");
            return false;
        }else if(List1=="")
        {
            alert("Please Select ' To ' Option");
            return false;
        }
        else if(Value1 >0)
        { 
            if(List==1)
            {
                var result=document.unitForm.toField.value;
                result=  document.unitForm.fromField.value*1.0;
            }
            else if(List==2){result=document.unitForm.fromField.value*14.947594963951362;}
            else if(List==3){result =document.unitForm.fromField.value*4961;}
            else if(List==4){result = document.unitForm.fromField.value*6.2509225092250915;}
            else if(List==5){result =document.unitForm.fromField.value*15.128294489218037;}
            else if(List==6){result =document.unitForm.fromField.value*75.00431965442765;}
            else if(List==7){result=document.unitForm.fromField.value*151.31590413943357;}
            else if(List==8){result =document.unitForm.fromField.value* 0.14936344086021505;}
            else if(List==9){result =document.unitForm.fromField.value*605.2636165577343;}
            else if(List==10){result = document.unitForm.fromField.value*242.42233856893545;}
            else if(List==11){result =document.unitForm.fromField.value*6.050000000000001;}
            else if(List==12){result =document.unitForm.fromField.value*33.343254920787324;}
            else if(List==13){result =document.unitForm.fromField.value*1509.8695652173913;}
            else if(List==14){result =document.unitForm.fromField.value*10.002016129032259;}
            else if(List==15){result =document.unitForm.fromField.value*0.0138908;}
            else if(List==16){result=document.unitForm.fromField.value*0.12501719989998625;}
        }
        if(Value1>0)
        {
            if(List1==1){document.unitForm.toField.value=result*1.0;}
            else if(List1==2){document.unitForm.toField.value=result*0.06690039450571601;} 
            else if(List1==3){document.unitForm.toField.value = result *0.00020157226365652087;}   
            else if(List1==4){document.unitForm.toField.value = result *0.15997638724911453;} 
            else if(List1==5){document.unitForm.toField.value = result *0.066101304460506233;}    
            else if(List1==6){document.unitForm.toField.value = result *0.013332565438995594;} 
            else if(List1==7){document.unitForm.toField.value = result *0.006608690644167362;}   
            else if(List1==8){document.unitForm.toField.value = result *6.695078757163015;}  
            else if(List1==9){document.unitForm.toField.value = result *0.0016521726610418406;} 
            else if(List1==10){document.unitForm.toField.value = result *0.004125032395542373;}
            else if(List1==11){document.unitForm.toField.value = result *0.16528925619834708;} 
            else if(List1==12){document.unitForm.toField.value = result *0.029991073228323784;}
            else if(List1==13){document.unitForm.toField.value = result *0.0006623088662999971;}
            else if(List1==14){document.unitForm.toField.value = result *0.09997984277363434;} 
            else if(List1==15){document.unitForm.toField.value = result *71.99009416304317;} 
            else if(List1==16){document.unitForm.toField.value = result *7.9988993578483605;}  
        }
        else
        {document.unitForm.toField.value = "ERROR";}
    }
</script>
<div style="clear: both;"></div>
<div class="car_category" style="padding-left: 15px;">
    <ul> <li><a href="<%=localUrlPath%>/">Home <img src="bbsimages/New/car_side_arrow.png" alt="" width="6" height="7" border="0" /></a></li>
        <li><b> <c:set var="parentId"><%=cat1.getParent() %></c:set> <%= cat1.getName()%></b> </li>
    </ul>
</div>
<div class="car_fistpage_main_right_mt_cont_707_inner">
    <div class="car_9854_left_cont">
        <div class="car_9854_txt" >
            <b> <%= cat1.getName()%>  (<%= cat1.getTotalSubCatAdCount((String)request.getSession().getAttribute("city"))%>)</b>
        </div>
        <div class="car_9854_inner_cont_01">
            <div class="car_fistpage_right_img_3"><img src="resourceGetter?imf=<%= cat1.getImagePath()%>" width="161px" height="166px" ></div></div>
        <div class="car_9854_inner_cont_txt">
            <%
            int count=1;
            List clfIds = (List) request.getAttribute("clfIds");
            if (clfIds != null && clfIds.size() > 0) {
                for (Iterator itr1 = clfIds.iterator(); itr1.hasNext();) {
                    Integer clfId = (Integer) itr1.next();
                    Category cat = cu.getCategoryByID(clfId);%>
            <div class="maruthi_3164_txt">
                <ul>
                    <li> <a title="<%= cat.getName()%>" href="<%if(request.getSession().getAttribute("city")!=null&&!request.getSession().getAttribute("city").toString().equals("All India")){%><%= request.getSession().getAttribute("city").toString().toLowerCase()%>-<%}%><%if(cat1.getName()!=null){%><%= cat1.getName().trim().replace("/","-").replace(" ","-").toLowerCase()%>-<%}%><%if(cat.getName()!=null){%><%= cat.getName().trim().replace("/","-").replace(" ","-").toLowerCase()%><%}%>-cl<%= clfId%>cs<%= subCatId%>.in" >
                            <%= cat.getName()%> (<%=AddCountUtil.getAddCountByCatID(String.valueOf(clfId),(String)request.getSession().getAttribute("city")) %>)
                        </a></li></ul>
            </div>
            <% count ++;
                if(count >10)
                    {
                break;}
                }
            }
            %>

        </div>
        <div class="car_9854_inner_cont_txt">
            <%
            if (clfIds != null && clfIds.size() > 10) {%>
            <style type="text/css">
                .car_9854_inner_cont_txt {
                    width:135px;
                }
            </style>
            <%
                for (Iterator itr2 = clfIds.iterator(); itr2.hasNext();) {
                    if(count > 10)
                        {
                        for(int i=1 ;i <=10; i++)
                            {
                            itr2.next();
                            }
                        count = 1;
                        }
                    Integer clfId = (Integer) itr2.next();
                    Category cat = cu.getCategoryByID(clfId);%>
            <div class="maruthi_3164_txt">
                <ul>
                    <li>
                        <a title="<%= cat.getName()%>" href="<%if(request.getSession().getAttribute("city")!=null&&!request.getSession().getAttribute("city").toString().equals("All India")){%><%= request.getSession().getAttribute("city").toString().toLowerCase()%>-<%}%><%if(cat1.getName()!=null){%><%= cat1.getName().trim().replace("/","-").replace(" ","-").toLowerCase()%>-<%}%><%if(cat.getName()!=null){%><%= cat.getName().trim().replace("/","-").replace(" ","-").toLowerCase()%><%}%>-cl<%= clfId%>cs<%= subCatId%>.in" >
                            <%= cat.getName()%> (<%=AddCountUtil.getAddCountByCatID(String.valueOf(clfId),(String)request.getSession().getAttribute("city")) %>)
                        </a></li>
                </ul>
            </div>
            <% }
            }
            %>
        </div>
        <%--  For Cart Hunt
          <c:if test="${userBean!=null && subCatId==373}">
              <div align="right" style="margin-top:180px;"> <img src="bbsimages/New/cart3.png" width="50" height="50"/></div>
              </c:if>
              For Cart Hunt--%>
    </div>
    <div class="car_9854_right_cont"><a href="postAd.do"> <div class="car_postadd_bg_img"> </div> </a></div>
    <c:if test="${subCatId==370||subCatId==371||subCatId==372||subCatId==373||subCatId==754||subCatId==756}">
        <div id='basic-modal-area'>
            <div align="right" style="margin-top:120px;" id ="areaConverterPop"> <img src="bbsimages/New/area_converter.png" style="cursor:pointer;margin-top: 10px" width="200" height="60" class='basic' href="javascript:void(0);" onclick="areaConverterPop(this);" /></div>
        </div>
        <div id="basic-area-converter" style="display: none">
            <div class="popup_main_sml2" > 

                <div style="height:35px;"></div>
                <div class="area_cvntr_pop">
                    <div class="area_cvntr_icon" >
                        <div class="area_cvntr_img" style="float:left"><img src="<%=localUrlPath%>/bbsimages/New/House-Calculator.png" /></div>
                        <strong style="font-family:Arial, Helvetica, sans-serif; color:#ff6000; font-size:18px; font-weight:bold; line-height:50px;">Area Unit Converter</strong></div>
                    <form action="" name="unitForm" >
                        <table width="350" border="0" cellspacing="0" cellpadding="0" style="float:right; margin-top:30px;">
                            <tr>
                                <td align="right" valign="top" class="registering_txt1" >Enter Value :</td>
                                <td align="left" valign="top" >&nbsp;&nbsp;&nbsp;<input type="text"  maxlength="10"  name="fromField"  id="first" style="width:150px;height:23px;background-color: #FFFFFF; border: 1px solid #CCCCCC;color: #333333;font-size: 12px;padding-left: 5px;"  onfocus="this.form.fromField.value=''; style.background='lightyellow';" onblur="style.background='white';" onKeyPress="return numbersonly(event, false)"/></td>
                            </tr>

                            <tr>
                                <td align="right" valign="top" class="registering_txt1" >From :</td>
                                <td align="left" valign="top" >&nbsp;&nbsp;
                                    <select name="fromList" id="List">
                                        <option value="" selected="selected">unit</option>
                                        <option id="fromAankanam" value="1">Aankanam</option> <option id="fromAres"  value="2">Ares</option><option id="fromBiswa" value="3">Biswa</option> <option id="fromchataks" value="4">Chataks</option> <option id="fromGuntha" value="5">Guntha</option> <option id="fromKanal" value="6">Kanal</option> <option id="fromRood"  value="7">Rood</option> <option id="fromSquareMeter" value="8">Square Meter</option>
                                        <option id="fromAcres"  value="9">Acres</option> <option id="fromBhighas" value="10">Bhighas</option> <option id="fromcentes" value="11">Centes</option> <option id="fromGrounds" value="12">Grounds</option> <option id="fromHectares" value="13">Hectares</option> <option id="fromKottha" value="14">Kottha</option> <option id="fromSquareFeet" value="15">Square Feet</option>  <option id="fromSquareYards"   value="16">Square Yards</option></select>
                                </td>
                            </tr>

                            <tr>
                                <td align="right" valign="top" class="registering_txt1" >To :</td>
                                <td align="left" valign="top" >&nbsp;&nbsp;
                                    <select name="fromList1" id="List1">
                                        <option value="" selected="selected">unit</option>
                                        <option id="toAankanam" value="1">Aankanam</option> <option id="toAres" value="2">Ares</option> <option id="toBiswa" value="3">Biswa</option> <option id="tochataks" value="4">Chataks</option> <option id="toGuntha" value="5">Guntha</option> <option id="toKanal" value="6">Kanal</option> <option id="toRood" value="7">Rood</option> <option id="toSquareMeter"    value="8">Square Meter</option>
                                        <option id="toAcres" value="9">Acres</option> <option id="toBhighas" value="10">Bhighas</option> <option id="tocentes" value="11">Centes</option> <option id="toGrounds" value="12">Grounds</option> <option id="toHectares" value="13">Hectares</option> <option id="toKottha" value="14">Kottha</option> <option id="toSquareFeet" value="15">Square Feet</option> <option id="toSquareYards" value="16">Square Yards</option></select>
                                </td>
                            </tr>
                            <tr>
                                <td align="right" valign="top" class="registering_txt1" >Result Value :</td>
                                <td align="left" valign="top" >&nbsp;&nbsp;&nbsp;<input type="text" name="toField" value="?" readonly="readonly" maxlength="18" style="width:150px;background-color:#CCCCCC;height:23px;border: 1px solid #CCCCCC;font-size: 12px;padding-left: 5px;"/></td>
                            </tr>
                        </table>
                        <table style="float:left; margin-top:10px;" width="250">
                            <tr>
                                <td align="right" valign="top" ><input type="button" value=" Convert "  onclick="return(convertUnit())"/></td>
                                <td>&nbsp;&nbsp;</td>
                                <td align="left" valign="top" ><input type="reset" value=" Reset " /></td>
                            </tr>
                        </table>
                    </form>
                    <style type="text/css">
                        #simplemodal-container a.modalCloseImg {
                            margin:430px 25px 0px 0px;
                        }
                    </style>
                </div>
            </div>
        </div>


    </c:if>
</div>

<% }%>
<!-- Ads Display Content -->
<div style="clear:both"></div>
<div class="latest_ads_in_Car_cont_txt" ><% if (request.getAttribute("title") != null) {%> <%= request.getAttribute("title")%> <% } else {%> Requested Ads List <% }%></div>
<div> <jsp:include page='/WEB-INF/jsp/refine.jsp'/> </div>
<%--<script>
    toggle_s("sub<c:out value='${parentId}' />","img<c:out value='${parentId}' />");
    openCat('lmhide');
</script>--%>
