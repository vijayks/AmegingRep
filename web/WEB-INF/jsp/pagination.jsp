<script type="text/javascript">
    function adTypeSelected(itemId)
    {
        var dropdownIndex = document.getElementById(itemId).selectedIndex;
        var dropdownValue = document.getElementById(itemId)[dropdownIndex].value;
        document.location.href=dropdownValue;
    }

</script>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@page import="com.buysell.util.BuySellProperties" %>
<%@page  import="com.buysell.util.Category " %>
<%@page  import="com.buysell.util.CategoryUtil " %>
<%@page  import="java.util.Iterator " %>
<%@page  import="java.util.List " %>
<%
int start = 0;
int range = 20;
int totalNoOfAds = 0;
String reqURI = "tile1.do";
int byO = 1;
int top = Integer.parseInt(BuySellProperties.getProperty("top"));
int middle = Integer.parseInt(BuySellProperties.getProperty("middle"));
int bottom = Integer.parseInt(BuySellProperties.getProperty("bottom"));

try {
    totalNoOfAds = (Integer) request.getAttribute("c");

} catch (Exception e) {
    // e.printStackTrace();
}
try {

    start = Integer.parseInt(request.getParameter("start"));

} catch (Exception e) {
    //e.printStackTrace();
}
try {

    range = Integer.parseInt(request.getParameter("range"));

} catch (Exception e) {
    //e.printStackTrace();
}
try {

    byO = Integer.parseInt(request.getParameter("byO"));
} catch (Exception e) {
    // e.printStackTrace();
}
if (request.getAttribute("reqURI") != null) {
    reqURI = (String) request.getAttribute("reqURI");
    if(reqURI.equals("displayClfAds.do") && request.getSession().getAttribute("surl")!=null && request.getSession().getAttribute("surl").toString().startsWith("catCityChange")) {
        reqURI=request.getSession().getAttribute("surl").toString().replace("catCityChange/", "");
    }
}
String sci=request.getParameter("subCatId");
if (totalNoOfAds > 0) {

%>
<c:if test="${reqURI == 'displayClfAds.do' }" >
    <% String localUrlPath = "/";
    if (BuySellProperties.getProperty("localurl") != null && BuySellProperties.getProperty("localurl").trim().length() > 0) {
                    localUrlPath = BuySellProperties.getProperty("localurl");
                }
            CategoryUtil cu = new CategoryUtil();
            String catName = cu.getCategoryNameWithId(Integer.parseInt(sci));
            List clfIds = cu.getClfCatIdsWithSubCatId(Integer.parseInt(sci));;
                if (clfIds != null && clfIds.size() > 0) {
                    for (Iterator itr1 = clfIds.iterator(); itr1.hasNext();) {
                        Integer clfId = (Integer) itr1.next();
                        Category cat = cu.getCategoryByID(clfId);}
                                     }
            String clfName = (String) request.getAttribute("title");
            clfName= clfName.replace((clfName.substring(0,6)),"");

    %>
    <c:set var="scnm"><%=cu.getCategoryNameWithId(Integer.parseInt(sci))%></c:set>
    <div class="car_category" style="width:590px;margin-left:10px;">
        <ul>
            <li><a href="<%=localUrlPath%>/">Home <img src="bbsimages/New/car_side_arrow.png" alt="" width="6" height="7" border="0" /></a></li>
            <li><c:set var="scnm"><%=cu.getCategoryNameWithId(Integer.parseInt(sci))%></c:set><a href="<%=localUrlPath%>/<c:if test="${city!=null && city!='All India'}">${fn:toLowerCase(city)}-</c:if>${fn:toLowerCase(fn:replace(fn:replace(fn:trim(scnm),'/','-'),' ','-'))}-sc<%=sci%>.in" ><%= catName %>&nbsp;&nbsp;<img src="bbsimages/New/car_side_arrow.png" alt="" width="6" height="7" border="0" /></a></li>
            <li><b> <%= clfName%></b> </li>
        </ul>
    </div>
</c:if>



<div id="sortBar" class="latest_ads_in_Car_cont_txt" style="margin-top:0px">


    <div style="float:left;text-align:left;width:425px;overflow:hidden;" ><div style="width:300px;float:left"><% if (request.getAttribute("title") != null) {%> <%= request.getAttribute("title")%><% if (totalNoOfAds > 100) { %> (<%= totalNoOfAds%>)<% } %> <% } else {%> Requested Ads List <% }%></div>
        <c:if test="${reqURI == 'displayClfAds.do' }" >

            <div style="float:right;text-align:left;font-size:12px;width:125px;" >
                Ad Type:&nbsp;&nbsp;<select   style="font-size:10px;" name="adType1" id="adType1" onchange="javascript:adTypeSelected('adType1')">
                    <option value="javascript:changeHrefForm('<%= reqURI%>?byO=1&start=0&range=<%= range%><c:if test="${rqry != null}">&<c:out value="${ rqry }" /></c:if><c:if test="${clfId !=null }" >&clfId=<c:out value="${ clfId }" /></c:if><% if (sci != null) {%>&subCatId=<%= sci%><% }%>&adType=all')" > All </option>
                    <option value="javascript:changeHrefForm('<%= reqURI%>?byO=<%= byO%>&start=0&range=<%= range%><c:if test="${rqry != null}">&<c:out value="${ rqry }" /></c:if><c:if test="${clfId !=null }" >&clfId=<c:out value="${ clfId }" /></c:if><% if (sci != null) {%>&subCatId=<%= sci%><% }%>&adType=offered')" > offered </option>
                    <option value="javascript:changeHrefForm('<%= reqURI%>?byO=<%= byO%>&start=0&range=<%= range%><c:if test="${rqry != null}">&<c:out value="${ rqry }" /></c:if><c:if test="${clfId !=null }" >&clfId=<c:out value="${ clfId }" /></c:if><% if (sci != null) {%>&subCatId=<%= sci%><% }%>&adType=wanted')"  > wanted </option>
                </select>
            </div>

            <script type="text/javascript">
                document.getElementById('adType1').value="javascript:changeHrefForm('<%= reqURI%>?byO=<%= byO%>&start=0&range=<%= range%><% if (request.getAttribute("rqry") != null) {%>&<%= request.getAttribute("rqry")%><% }%><% if (request.getAttribute("clfId") != null) {%>&clfId=<%= request.getAttribute("clfId")%><% }%><% if (sci != null) {%>&subCatId=<%= sci%><% }%><% if (request.getAttribute("adType") != null) {%>&adType=<%= request.getAttribute("adType")%><% }%>')";
            </script>

        </c:if>
    </div>



    <div class="" style="float:right;width:280px;text-align:left;font-size:12px;" >
        <c:if test="${reqURI != 'latestAds.do' }" >
            Sort By : <select style="font-size:10px;width:100px; " name="selectname3" id="sortBy1" onchange="javascript:sortBy('sortBy1')">

                <option value="javascript:changeHrefForm('<%= reqURI%>?byO=1&range=<%= range%><c:if test="${rqry != null}">&<c:out value="${ rqry }" /></c:if><c:if test="${clfId !=null }" >&clfId=<c:out value="${ clfId }" /></c:if><% if (sci != null) {%>&subCatId=<%= sci%><% }%><% if (request.getAttribute("adType") != null) {%>&adType=<%= request.getAttribute("adType")%><% }%>')"  >Newest First</option>
                <option value="javascript:changeHrefForm('<%= reqURI%>?byO=2&range=<%= range%><c:if test="${rqry != null}">&<c:out value="${ rqry }" /></c:if><c:if test="${clfId !=null }" >&clfId=<c:out value="${ clfId }" /></c:if><% if (sci != null) {%>&subCatId=<%= sci%><% }%><% if (request.getAttribute("adType") != null) {%>&adType=<%= request.getAttribute("adType")%><% }%>')"  >Oldest First</option>
                <option value="javascript:changeHrefForm('<%= reqURI%>?byO=4&range=<%= range%><c:if test="${rqry != null}">&<c:out value="${ rqry }" /></c:if><c:if test="${clfId !=null }" >&clfId=<c:out value="${ clfId }" /></c:if><% if (sci != null) {%>&subCatId=<%= sci%><% }%><% if (request.getAttribute("adType") != null) {%>&adType=<%= request.getAttribute("adType")%><% }%>')"  >Text   First</option>
                <option value="javascript:changeHrefForm('<%= reqURI%>?byO=3&range=<%= range%><c:if test="${rqry != null}">&<c:out value="${ rqry }" /></c:if><c:if test="${clfId !=null }" >&clfId=<c:out value="${ clfId }" /></c:if><% if (sci != null) {%>&subCatId=<%= sci%><% }%><% if (request.getAttribute("adType") != null) {%>&adType=<%= request.getAttribute("adType")%><% }%>')"  >Photo  First</option>
                <option value="javascript:changeHrefForm('<%= reqURI%>?byO=5&range=<%= range%><c:if test="${rqry != null}">&<c:out value="${ rqry }" /></c:if><c:if test="${clfId !=null }" >&clfId=<c:out value="${ clfId }" /></c:if><% if (sci != null) {%>&subCatId=<%= sci%><% }%><% if (request.getAttribute("adType") != null) {%>&adType=<%= request.getAttribute("adType")%><% }%>')"  >Ad Title(A-Z)</option>
                <option value="javascript:changeHrefForm('<%= reqURI%>?byO=6&range=<%= range%><c:if test="${rqry != null}">&<c:out value="${ rqry }" /></c:if><c:if test="${clfId !=null }" >&clfId=<c:out value="${ clfId }" /></c:if><% if (sci != null) {%>&subCatId=<%= sci%><% }%><% if (request.getAttribute("adType") != null) {%>&adType=<%= request.getAttribute("adType")%><% }%>')"  >Ad Title(Z-A)</option>
                <% if (request.getAttribute("adType") != null && !request.getAttribute("adType").equals("all")) { %>
                <option value="javascript:changeHrefForm('<%= reqURI%>?byO=7&range=<%= range%><c:if test="${rqry != null}">&<c:out value="${ rqry }" /></c:if><c:if test="${clfId !=null }" >&clfId=<c:out value="${ clfId }" /></c:if><% if (sci != null) {%>&subCatId=<%= sci%><% }%><% if (request.getAttribute("adType") != null) {%>&adType=<%= request.getAttribute("adType")%><% }%>')"  >Price(Ascending)</option>
                <option value="javascript:changeHrefForm('<%= reqURI%>?byO=8&range=<%= range%><c:if test="${rqry != null}">&<c:out value="${ rqry }" /></c:if><c:if test="${clfId !=null }" >&clfId=<c:out value="${ clfId }" /></c:if><% if (sci != null) {%>&subCatId=<%= sci%><% }%><% if (request.getAttribute("adType") != null) {%>&adType=<%= request.getAttribute("adType")%><% }%>')"  >Price(Descending)</option>
                <% }%>
            </select>&nbsp;&nbsp;
            <script type="text/javascript">

                document.getElementById('sortBy1').value="javascript:changeHrefForm('<%= reqURI%>?byO=<%= byO%>&range=<%= range%><% if (request.getAttribute("rqry") != null) {%>&<%= request.getAttribute("rqry")%><% }%><% if (request.getAttribute("clfId") != null) {%>&clfId=<%= request.getAttribute("clfId")%><% }%><% if (sci != null) {%>&subCatId=<%= sci%><% }%><% if (request.getAttribute("adType") != null) {%>&adType=<%= request.getAttribute("adType")%><% }%>')";

            </script>

        </c:if>
        <%-- <c:if test="${reqURI == 'latestAds.do' }" > <% if (totalNoOfAds > 100) { %> &nbsp;&nbsp;&nbsp;&nbsp;(Only : 100)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<% } %>
         </c:if>--%>

        # Of Ads :  &nbsp;

        <select  style="font-size:10px;width:45px " name="selectname1" id="selectRange1" onchange="javascript:adsPerPage('selectRange1')">

            <option value="javascript:changeHrefForm('<%= reqURI%>?byO=<%= byO%>&start=0&range=<%= top%><c:if test="${rqry != null}">&<c:out value="${ rqry }" /></c:if><c:if test="${clfId !=null }" >&clfId=<c:out value="${ clfId }" /></c:if><% if (sci != null) {%>&subCatId=<%= sci%><% }%><% if (request.getAttribute("adType") != null) {%>&adType=<%= request.getAttribute("adType")%><% }%>')"                 >10</option>
            <option value="javascript:changeHrefForm('<%= reqURI%>?byO=<%= byO%>&start=0&range=<%= middle%><c:if test="${rqry != null}">&<c:out value="${ rqry }" /></c:if><c:if test="${clfId !=null }" >&clfId=<c:out value="${ clfId }" /></c:if><% if (sci != null) {%>&subCatId=<%= sci%><% }%><% if (request.getAttribute("adType") != null) {%>&adType=<%= request.getAttribute("adType")%><% }%>')"              >20</option>
            <option value="javascript:changeHrefForm('<%= reqURI%>?byO=<%= byO%>&start=0&range=<%= bottom%><c:if test="${rqry != null}">&<c:out value="${ rqry }" /></c:if><c:if test="${clfId !=null }" >&clfId=<c:out value="${ clfId }" /></c:if><% if (sci != null) {%>&subCatId=<%= sci%><% }%><% if (request.getAttribute("adType") != null) {%>&adType=<%= request.getAttribute("adType")%><% }%>')"              >30</option>

        </select>
    </div>

    <script type="text/javascript">

        document.getElementById('selectRange1').value="javascript:changeHrefForm('<%= reqURI%>?byO=<%= byO%>&start=0&range=<%= range%><% if (request.getAttribute("rqry") != null) {%>&<%= request.getAttribute("rqry")%><% }%><% if (request.getAttribute("clfId") != null) {%>&clfId=<%= request.getAttribute("clfId")%><% }%><% if (sci != null) {%>&subCatId=<%= sci%><% }%><% if (request.getAttribute("adType") != null) {%>&adType=<%= request.getAttribute("adType")%><% }%>')";

    </script>

</div>

<% }%>

