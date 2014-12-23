<%--
    Document   : requestedOffers
    Created on : Dec 22, 2009, 7:07:44 PM
    Author     : bbsadmin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.buysell.beans.UserBean" %>
<%@page import="com.buysell.beans.MyAdDetailsBean" %>
<%@page  import="com.buysell.beans.AdsResultsBean " %>
<%@page  import="java.io.OutputStream " %>
<%@page  import="java.io.FileInputStream " %>

<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>

<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn"%>


<link href="images/lytebox/fbox.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="highslide/highslide-with-html.js"></script>
<link rel="stylesheet" type="text/css" href="highslide/highslide.css" />


<script type="text/javascript" src="images/lytebox/fbox_conf.js"></script>
<script type="text/javascript" src="images/lytebox/fbox_engine-min.js"></script>
<script type="text/javascript">

    function sortBy(itemID)
    {
        var dropdownIndex = document.getElementById(itemID).selectedIndex;
        var dropdownValue = document.getElementById(itemID)[dropdownIndex].value;
        //alert(dropdownValue);

        document.location.href=dropdownValue;

    }
    function adsPerPage(itemID)
    {
        var dropdownIndex = document.getElementById(itemID).selectedIndex;
        var dropdownValue = document.getElementById(itemID)[dropdownIndex].value;
        //alert(dropdownValue);

        document.location.href=dropdownValue;

    }

    function check(checkAllState, cbGroup)
    {//alert("cbGroup.length="+cbGroup.length);
        for (i = 0; i < cbGroup.length; i++)
        {
            //alert("cbGroup[i]="+cbGroup[i]);
            cbGroup[i].checked = checkAllState.checked;
        }
    }
    function chkAll()
    {   active =document.getElementsByName("Active");
        hold =document.getElementsByName("On Hold");
        reposted =document.getElementsByName("Reposted");
        expired =document.getElementsByName("Expired");
        incomplete=document.getElementsByName("Incomplete");

        commons(active,"checked");
        commons(hold,"checked");
        commons(reposted,"checked");
        commons(expired,"checked");

        commons(incomplete,"checked");
    }
    function unchkAll(){
        active =document.getElementsByName("Active");
        hold =document.getElementsByName("On Hold");
        reposted =document.getElementsByName("Reposted");
        expired =document.getElementsByName("Expired");

        incomplete=document.getElementsByName("Incomplete");


        commons(active,"");
        commons(hold,"");
        commons(reposted,"");
        commons(expired,"");

        commons(incomplete,"");
    }

    function commons(item,checked){
        for (i = 0; i < item.length; i++)
        {
            item[i].checked =checked;
        }
    }
chkAll();unchkAll();

</script>

<%
MyAdDetailsBean madb = (MyAdDetailsBean) request.getSession().getAttribute("myOfferDetailsBean");
%>

<div id="sortBar" style="text-align:left;color:#ffffff;width:710px;float:left;height:30px;padding-top:9px;background:url(bbsimages/sortBy710.jpg) no-repeat;">
    <span class="verdana_menu_head" style="padding-left:15px;" ><%= request.getAttribute("title") %></span>
</div>
<div style="clear:both;"></div>
     <div style="width:710px;height:1px;"></div>
      <c:if test="${msgSuc != null}" >
            <div class="fv11b" style="width:740px;height:15px;text-align:center;color:#008800;"><c:out value="${msgSuc}" /></div>
        </c:if>
    <logic:present name="deleteOffersList" property="results">
    <bean:size id="size" name="deleteOffersList" property="results"/>

    <logic:equal name="size" value="0">
        <div class="fv11b" style="width:740px;height:15px;text-align:center;color:#EA052B;">No Offers found under requested criteria.</div>
    </logic:equal>


        <% String name = "status";%>
        <c:if test="${deleteOffersList.results!=null}">
            <form action="deleteSelectedOffers.do">
            <div  style="width:740px;float:left;height:20px;">
                <div  class="fv12" style="width:5%;float:left;height:16px;padding-top:4px;padding-left:5px;">  Select </div>
                <div style="width:5%;float:left;height:16px;padding-top:4px;" align="right"> <a title="All" class="fv12bc" href="javascript:return false" onClick="chkAll()">All</a>  </div>
                <div style="width:12%;float:left;height:16px;padding-top:4px;" align="center"><a title="None" class="fv12bc" href="javascript:return false" onClick="unchkAll()">None</a> </div>
                <div class="fv12bc" style="width:12%;float:left;height:20px;">  <input title="Active" type="checkbox" name="Active" onClick="check(this,active)"> &nbsp; Active </div>
                <div class="fv12bc" style="width:12%;float:left;height:20px;">  <input title="OnHold" type="checkbox" name="On Hold" onClick="check(this,hold)"> &nbsp; On Hold </div>
                <div class="fv12bc" style="width:12%;float:left;height:20px;">  <input title="Expired" type="checkbox" name="Expired" onClick="check(this,expired)"> &nbsp; Expired </div>
                <div  class="fv12bc" style="width:15%;float:left;height:20px;">  <input title="Incomplete" type="checkbox" name="Incomplete" onClick="check(this,incomplete)"> &nbsp; Incomplete </div>
                <div  style="width:24%;float:left;height:20px;" align="right">
                <input type="image" src="bbsimages/buttons/Delete.png" onmouseover="this.src='bbsimages/buttons/Delete_MouseOver.png';" onmouseout="this.src='bbsimages/buttons/Delete.png';" /> </div>
            </div>

            <div style="clear:both;width:740px;height:12px;"></div>

        <c:forEach items="${deleteOffersList.results}" var="ol">
            <c:if test="${ol.status==1}">
                <% name = "Active";%>
            </c:if>
            <c:if test="${ol.status==2}">
                <% name = "On Hold";%>
            </c:if>
            <c:if test="${ol.status==3}">
                <% name = "Reposted";%>
            </c:if>
            <c:if test="${ol.status==4}">
                <% name = "Expired";%>
            </c:if>
            <c:if test="${ol.status==5}">
                <% name = "Deleted";%>
            </c:if>
            <c:if test="${ol.status==6}">
                <% name = "Incomplete";%>
            </c:if>

            <div class="adet"><div class="adb"><div class="adl"><div class="adr"><div class="adbl"><div class="adbr"><div class="adtl"><div class="adtr">
                                           <div  style="height:95px;width:740px" >
                                                    <div   style="float:left;width:15px;height:15px;padding-top:40px;padding-left:5px" align="left">
                                                        <input type="checkbox" name='<%= name%>' value="${ol.sid}" />
                                                    </div>
                                                    <div class="rb" style="float:left;width:85px;height:85px;padding-top:15px" align="center" >
                                                        <a title="Ad Image" class="imglink" style=""   >
                                                     <c:set var="offerImg" value="${ol.img1}"/>

                                                        <c:if test='${offerImg != "" && offerImg != "null" }'>
                                                            <img src="resourceGetter?imf=${ol.img1}" width="75px" height="75px" style="border:none"  >
                                                        </c:if>
                                                        <c:if test='${offerImg == "" || offerImg == "null"}'>
                                                            <img src="bbsimages/noimage.png" width="75px" height="75px" style="border:none"  >
                                                        </c:if>
                                                    </a>
                                                </div>

                                                <div class="rb" style="float:left;height:95px;width:495px;overflow:hidden;">
                                                    <div class="fv12bc" style="text-align:left;float:left;padding-top:5px;padding-left:3px;width:390px;">
                                                        <a title="${ol.scrTitle}" class="link" style="font-size:11px;color:#046DBE"  href="spoffer.do?sId=${ol.sid}">
                                                            ${ol.scrTitle}
                                                    </a>
                                                    </div>

                                                    <div class="fv11b" style="float:left;text-align:right;width:100px;padding-right:2px;padding-top:5px"><b>
                                                            <a title="More Details" class="link" style="font-size:11px;color:#222222"  href="spoffer.do?sId=${ol.sid}">More Details...</a>
                                                    </b></div>

                                                    <div class="fv11" style="height:55px;width:485px;float:left;text-align:left;padding-left:3px;padding-top:6px;padding-right:2px;">
                                                        <c:if test="${fn:length(ol.desc) <= 350 }" >
                                                            <c:out value="${ol.desc}" />
                                                        </c:if>
                                                        <c:if test="${fn:length(ol.desc) > 350 }" >
                                                            <c:out value="${fn:substring(ol.desc,0,350)}" />&nbsp;&nbsp;<a title="More" href="spoffer.do?sId=${ol.sid}" ><span style="color:#046dbe">More...</span></a>
                                                        </c:if>
                                                    </div>

                                                    <div class="fv11" style="padding-left:3px;float:left;width:188px;text-align:left;padding-bottom:5px">
                                                        ${ol.oprice}
                                                    </div>

                                                    <div class="fv11" style="float:left;width:330px;text-align:right;padding-bottom:5px">
                                                        Started from : <span class="fv11bc" style="padding-right:2px">
                                                        ${ol.sDate} </span>
                                                    </div>

                                                </div>



                                                <div style="float:left;width:90px;height:95px;" align="center">
                                                    <div style="float:left;width:90px;height:45px;padding-top:40px;padding-right:4px" align="center">
                                                        <%= name%>
                                                    </div>
                                                </div>

                                            <!-- main div ends --></div>
            </div></div></div></div></div></div></div></div>
            <div style="width:710px;background-color:#4D9EDF;height:18px;"><!-- Blue bar Div --></div>
            <div style="width:720px;height:5px;"></div>

        </c:forEach>
            </form>
        </c:if>

    </logic:present>
