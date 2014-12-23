<%--
    Document   : clock
    Created on : May 12, 2009, 9:52:26 PM
    Author     : bbsadmin
--%>
<%@taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>

<%@page import="com.buysell.util.BuySellProperties" %>
<% String localUrlPath = "/";
if (BuySellProperties.getProperty("localurl") != null && BuySellProperties.getProperty("localurl").trim().length() > 0) {
                localUrlPath = BuySellProperties.getProperty("localurl");
            }
%>
  <style type="text/css">
  .searchBox
    {
        clear:both;
        background-color: #F1F1F1;
        border: 1px solid #BFBFBF;
        width:95%;
        height:auto;
        margin:20px;
        display:block;
        padding:10px 0px;
    }
    .searchBox input[type=button] {
        cursor:pointer;color:black;
    }
    .searchBox input,select{
        color:black;
        font-size:10px;
    }
   </style>
<script type="text/javascript">
    function searchSubmit()
    {
      document.basicSearch.submit();
      return true;
    }
    function CallCurveCorners(divclass,topRad,botRad)
    {
        /*
      The new 'validTags' setting is optional and allows
      you to specify other HTML elements that curvyCorners
      can attempt to round.
      The value is comma separated list of html elements
      in lowercase.
      validTags: ["div", "form"]
      The above example would enable curvyCorners on FORM elements.
         */
        settings = {
            tl: { radius: topRad },
            tr: { radius: topRad },
            bl: { radius: botRad },
            br: { radius: botRad },
            antiAlias: true,
            autoPad: true,
            validTags: ["div"]
        }
        /*
      Usage:
      newCornersObj = new curvyCorners(settingsObj, classNameStr);
      newCornersObj = new curvyCorners(settingsObj, divObj1[, divObj2[, divObj3[, . . . [, divObjN]]]]);
         */
        var myBoxObject = new curvyCorners(settings, divclass);
        myBoxObject.applyCornersToAll();
    }

</script>

  <div class="searchBox">
  <div>
            <form id="basicSearch" name="basicSearch" method="post" action="/basicSearch.do">
        <div style="width:31%;float:left;padding-left:30px;*padding-left:20px">
            <% String keyword = (String) request.getAttribute("keyword");
            if (keyword != null) {%>
            <input type="text" class="" style="width:80%;vertical-align:bottom" value="<%= keyword %>"  name="keyword"  onfocus="if(this.value=='Keyword') this.value='';" onblur="if(this.value=='') this.value='Keyword';"  />
            <% } else {%>
            <input type="text" class=""  name="keyword" style="width:80%;vertical-align:bottom" value="Keyword"  onfocus="if(this.value=='Keyword') this.value='';" onblur="if(this.value=='') this.value='Keyword';" />
            <% }%>
        </div>
        <div style="width:32%;*width:31%;float:left;">
            <select  name="subCatId" id="subCatId" style="width:80%;vertical-align:bottom;">
                <option  selected value="0"  > Select Category </option>
                <c:if test="${categoryList != null}" >
                    <c:forEach items="${categoryList}" var="category">
                        <c:if test="${category.parent == 0}"><optgroup style="background:#dddddd;font-style:normal;font-weight:normal" label="${category.name}">
                            <c:if test="${category.subCategories != null}">
                                <c:forEach items="${category.subCategories}" var ="cat"><option style="background:#ffffff" value="${cat.id}" ><c:out value="${cat.name}" escapeXml="false"/></option></c:forEach>
                            </c:if>
                                </optgroup>
                        </c:if>
                    </c:forEach>
                </c:if>
            </select>
        </div>
        <div style="width:31%;float:left;">
            <select id="adType" name="adType" style="width:60%;vertical-align:bottom;float:left">
                <option value="offered">Offered</option><option value="wanted">Wanted</option>
            </select>
            <input type="hidden" name="start" value="0">
            <input type="hidden" name="range" value="20">
            <input type="hidden" name="byO" value="1">
            <input type="hidden" name="m" value="<c:out value="${m}" />">
            <span id="bSearchGo" style="float:left">&nbsp;
            <a href="javascript:void(0);" onclick="return searchSubmit();" style="color:#D55D0C;text-decoration:underline;" ><input type="image" src="<%=localUrlPath%>/bbsimages/Search.jpg" style="height:26px;padding-left:10px;"/></a>
            </span>
        </div>
    </form>
    <%--<div style="color:white;font-size:11px;padding:10px 30px;">Enter Keyword,Select Category & Type of Classified to search Bharatbuysell Classifieds</div>--%>

       <div style="clear:both"></div>
       <div><jsp:include page='/WEB-INF/jsp/advancedSearch.jsp'/></div>
       <div style="clear:both"></div>
        </div>
        </div>

            <script type="text/javascript">
    CallCurveCorners("searchBox",5,5);
<% if(request.getAttribute("subCatId") != null) { %>
    document.getElementById('subCatId').value='<%=request.getAttribute("subCatId")%>';
    document.getElementById('subCatId').options[document.getElementById('subCatId').options.selectedIndex].selected=true;
        <% } else if(request.getParameter("subCatId")!=null) { %>
            document.getElementById('subCatId').value='<%=request.getParameter("subCatId")%>';
            document.getElementById('subCatId').options[document.getElementById('subCatId').options.selectedIndex].selected=true;
             <%} if(request.getAttribute("adType") != null) { %>
                 document.getElementById('adType').value='<%= (String) request.getAttribute("adType")%>';
                 document.getElementById('adType').options[document.getElementById('adType').options.selectedIndex].selected=true;
        <% } %>
            if(document.getElementById('subCatId').value>0) {
        <%--document.getElementById('subCatId').disabled = true;--%>
    }
</script>