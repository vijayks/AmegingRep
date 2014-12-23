<%--
    Document   : postAd.jsp
    Created on : Mar 4, 2009, 8:13:30 PM
    Author     : bbsadmin
--%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%--<script src="js/postAdAjax.js" language="javascript"></script>
<script src="js/ajax.js" language="javascript"></script>--%>
<link rel="stylesheet" type="text/css" href="js/sugg.css"/>
<%@page import="java.util.StringTokenizer" %>
<%@page import="com.buysell.beans.DealerBean;" %>
<script language="javascript">
    // this function is used to enable the creat ad button when the user selects classification
    function checkSelect(){

        document.getElementById("button").disabled = false;
    }

</script>
<style type="text/css">
    <!--
    /* this is for displaying boxes in postad category,subcategory,classification */
    #apDiv1 {
        height:200px;
        margin-left:14px;
        float:left;
        width:215px;

    }
    #apDiv4 {

        width:215px;
        height:30px;
        font-weight:bold;
        FONT-SIZE: 12px;
        FONT-FAMILY: Arial, Verdana, Helvetica, sans-serif;
        COLOR:#046DBE;
        float:left;
        margin:20px 0 0 14px
    }

    #apDivCreateAD{
        margin-left:550px;
    }
    -->
</style>
<div id="masterrightbodybg">
    <br />
    <div class="pt"><div class="pb"><div class="pl"><div class="pr"><div class="pbl"><div class="pbr"><div class="ptl">
                                <div class="ptr">
                                    <br/>
                                    <div style="width:100%;height:790px;">
                                        <div class="fv14b" style="margin-left:10px;float:left">Post Ad Option 1: </div> <br />

                                        <div style="" id="apDiv4" >Step 1: Select Category</div>
                                        <div id="apDiv4" >Step 2: Select Sub Category</div>
                                        <div id="apDiv4" >Step 3: Select Classification</div>
                                        <div id="apDiv1" >
                                            <%--for Dealer--%>
                                            <c:if test="${fn:startsWith(userBean.userType,'DEALER') == true}">
                                                <form id="form2" name="form2" method="post" action="">
                                                    <select   name="select" id="select" onchange="" size="11" style="width:215px" >
                                                        <c:forEach items="${categoryList}" var="cat">
                                                            <c:if test="${cat.parent== 0}" >
                                                                <c:if test="${userBean.categoryList!=null}">
                                                                    <c:forEach items="${userBean.categoryList}" var="ucl">
                                                                        <c:if test="${ucl==cat.id}">
                                                                            <option value="<c:out value='${cat.id}'/>"> <c:out value='${cat.name}' escapeXml="false"/> </option></c:if>
                                                                    </c:forEach>
                                                                </c:if>
                                                            </c:if>
                                                        </c:forEach>
                                                    </select>
                                                </form>
                                            </c:if>
                                            <%--for Normal user--%>

                                            <c:if test="${fn:startsWith(userBean.userType,'DEALER') != true}">
                                                <form id="form2" name="form2" method="post" action="">
                                                    <select   name="select" id="select" onchange="callme(this)" size="11" style="width:215px" >
                                                        <c:forEach items="${categoryList}" var="cat">
                                                            <c:if test="${cat.parent== 0}" >
                                                                <option value="<c:out value='${cat.id}'/>"> <c:out value='${cat.name}' escapeXml="false"/> </option>
                                                            </c:if>
                                                        </c:forEach>
                                                    </select>
                                                </form>
                                            </c:if>
                                        </div>
                                        <div id="apDiv1" >
                                            <c:if test="${fn:startsWith(userBean.userType,'DEALER') == true}">
                                                <form id="form3" name="form3" method="post" action=""  >
                                                    <select  name="select3"  id="select2" onchange="callme1(this)" size="11" style="width:215px">
                                                        <c:forEach items="${categoryList}" var="cat">
                                                            <c:if test="${cat.parent!= 0}" >
                                                                <c:if test="${userBean.categoryList!=null}">
                                                                    <c:forEach items="${userBean.categoryList}" var="ucl">
                                                                        <c:if test="${ucl==cat.id}">

                                                                            <option value="<c:out value='${cat.id}'/>"> <c:out value='${cat.name}' escapeXml="false"/> </option></c:if>
                                                                    </c:forEach>
                                                                </c:if>
                                                            </c:if>
                                                        </c:forEach>
                                                    </select>
                                                </form>
                                            </c:if>
                                            <c:if test="${fn:startsWith(userBean.userType,'DEALER') != true}">
                                                <form id="form3" name="form3" method="post" action=""  >
                                                    <select  name="select3"  id="select2" onchange="callme1(this)" size="11" style="width:215px">
                                                    </select>
                                                </form>
                                            </c:if>
                                        </div>
                                        <div id="apDiv1" >
                                            <%
                                        String reqURI= (String)request.getAttribute("reqURI");
                                        if (reqURI.equalsIgnoreCase("postAdMy.do")) {%>
                                            <form id="form4" name="form4" method="get" action="createAdMy.do" >
                                                <% }else{  %>
                                                <form id="form4" name="form4" method="get" action="createAd.do" >
                                                    <% } %>
                                                    <select name="select3"   id="select3" style="width:215px"  size="11" onchange="toggle_enable('buttonDis','button')" >
                                                    </select>
                                                    </div>





                                                    <div id="apDivCreateAD">
                                                        <span style="float:right;margin-right:50px">
                                                            <input id="buttonDis" type="image"  disabled src="bbsimages/buttons/CreateAdDis.png" />
                                                            <input id="button" type="image" style="display:none" name="button" src="bbsimages/buttons/CreateAd.png" onmouseover="this.src='bbsimages/buttons/CreateAd_MouseOver.png';" onmouseout="this.src='bbsimages/buttons/CreateAd.png';" />
                                                            <!-- <input type="submit" name="button" id="button" value="Create Ad" disabled  /> -->
                                                        </span>
                                                    </div>
                                                </form>
                                                <div style="clear:both"></div>
                                                <span class="fv14b" style="margin-left:15px">  Post Ad Option 2: </span><br /><br />
                                                <script  language="javascript">
                                                    function disbut()
                                                    {

                                                        toggle_enable('sugg_sub_butDis', 'sugg_sub_but');
                                                    }
                                                </script>
                                                <% if (reqURI.equalsIgnoreCase("postAdMy.do")) {%>
                                                <form  action="createAdMy.do" autocomplete="off">
                                                    <% }else{  %>
                                                    <form  action="createAd.do" autocomplete="off">
                                                        <% }  %>

                                                        <input id="cid" type="hidden" name="cid" />

                                                        <span class="fv12bc" style="padding-left:25px;float:left;">
                                                            Type classification Keyword here &nbsp;&nbsp; <input type="text" name="it" onkeyup="changeDivs(this);"  style="width:465px"></span>
                                                        <br /><br /><br />
                                                        <span style="float:right;margin-right:50px">
                                                            <input id="sugg_sub_butDis" type="image"  disabled src="bbsimages/buttons/CreateAdDis.png" />
                                                            <input id="sugg_sub_but" type="image"  style="display:none;" src="bbsimages/buttons/CreateAd.png" onmouseover="this.src='bbsimages/buttons/CreateAd_MouseOver.png';" onmouseout="this.src='bbsimages/buttons/CreateAd.png';" />
                                                            <!--<input id="sugg_sub_but" type="submit" value="Create Ad" disabled/> </span> -->
                                                        </span>
                                                        <br /><br />

                                                        <span class="fv12bc" style="float:left;margin-left:25px;"> Select Appropriate suggestion form the below list </span>
                                                        <br />
                                                        <br />

                                                        <div id="suggdiv" class="boxBorder5" style="float:left;width:675px;margin-left:12px;">
                                                            <div class="fv12" style="width:674px;float:left" id="sri" onclick="disbut()" >
                                                            </div>
                                                        </div>
                                                    </form>
                                                    </div>
                                                    </div>
                                                    </div>
                                                    </div>
                                                    </div>
                                                    </div>
                                                    </div>
                                                    </div>
                                                    </div>
                                                    </div>
                                                    <%--  <c:if test="${userBean.categories!=null}">


                                                        <c:set var="dCat" value="${userBean.categories}"/>
                                                        <%              String imgStr = (String) pageContext.getAttribute("dCat");
                                                                        StringTokenizer imgSt1 = new StringTokenizer(imgStr, "|");
                                                                        while (imgSt1.hasMoreTokens()) {
                                                                        String imgval = imgSt1.nextToken();%>
                                                                  <%=imgval%>
                                                           <% }%>
                                                    </c:if>

                                                  <c:if test="${userBean.categor=null}"> nm
                                                  <c:if test="${categoryList!=null}">
                                                      <c:forEach items="${categoryList}" var="catNM">
                                                          ${catNM}
                                                      </c:forEach>
                                                  </c:if>
                                                  </c:if>--%>