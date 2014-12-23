<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import="com.buysell.util.BuySellProperties" %>
<%


        int start = 0;
        int range = 20;
        int totalNoOfAds = 0;
        String reqURI = "tile1.do";
        int byO = 1;
        int pages = 0;
        int perPage = 0;
        int pno0 = 0;
        int NOfpageNums=Integer.parseInt(BuySellProperties.getProperty("NOfpageNums"));


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
            //e.printStackTrace();
        }

        if (request.getAttribute("reqURI") != null) {
            reqURI = (String) request.getAttribute("reqURI");
                if(reqURI.equals("displayClfAds.do") && request.getSession().getAttribute("surl")!=null && request.getSession().getAttribute("surl").toString().startsWith("catCityChange")) {
        reqURI=request.getSession().getAttribute("surl").toString().replace("catCityChange/", "");
    }
        }

        pno0 = ((start / range < NOfpageNums) ? 0 : ((start / range) - ((start / range) % NOfpageNums)));
        totalNoOfAds = (Integer) request.getAttribute("c");

        if (totalNoOfAds % range == 0) {
            pages = totalNoOfAds / range;
        } else {
            pages = (totalNoOfAds / range) + 1;
        }
        String sci=request.getParameter("subCatId");
        if (totalNoOfAds - range > 0) {
%>

<div id="pagenav" style="padding:2px 0 12px 0;width:725px;float:left;height:12px;text-align:right;">


    <%  if ((start - range) >= 0) { %>
    <a title="Previous" href="javascript:changeHrefForm('<%= reqURI%>?byO=<%= byO%>&start=<%=  start - range%>&range=<%= range%><c:if test="${rqry != null}">&<c:out value="${ rqry }" /></c:if><c:if test="${clfId !=null }" >&clfId=<c:out value="${ clfId }" /></c:if><% if (sci != null) {%>&subCatId=<%= sci%><% }%><% if (request.getAttribute("adType") != null) {%>&adType=<%= request.getAttribute("adType")%><% }%>')"><span style="border:none;color:#05446B;"><</span></a>

    <a title="First" href="javascript:changeHrefForm('<%= reqURI%>?byO=<%= byO%>&start=0&range=<%= range%><c:if test="${rqry != null}">&<c:out value="${ rqry }" /></c:if><c:if test="${clfId !=null }" >&clfId=<c:out value="${ clfId }" /></c:if><% if (sci != null) {%>&subCatId=<%= sci%><% }%><% if (request.getAttribute("adType") != null) {%>&adType=<%= request.getAttribute("adType")%><% }%>')"><span>1</span></a>
    <% } else { %>
    <span style="background-color:#05446B;color:#ffffff;">1</span>
    <% } if(start/range > 2){%> <b class="fv11bc" style="color:#05446B">&nbsp;.....</b>  <%}%>
    <% for (int pno = 1; pno < pages-1 && perPage < pages-1; pno++, perPage++) {
                if (start / range == pno) {%>
    <span style="background-color:#05446B;color:#ffffff;"> <%= (pno + 1)%> </span>
    <% } else {if((start / range == (pno-1)) || (start / range == (pno+1))) { %>
    <a title="Results <%=(pno*range)+1%>-<%=(pno+1)*range%>" style="text-decoration:none" href="javascript:changeHrefForm('<%= reqURI%>?byO=<%= byO%>&start=<%= pno * range%>&range=<%=range%><c:if test="${rqry != null}">&<c:out value="${ rqry }" /></c:if><c:if test="${clfId !=null }" >&clfId=<c:out value="${ clfId }" /></c:if><% if (sci != null) {%>&subCatId=<%= sci%><% }%><% if (request.getAttribute("adType") != null) {%>&adType=<%= request.getAttribute("adType")%><% }%>')" ><span  ><% out.println(pno + 1);
        %></span></a>
        <% }}}%>
        <% if(start/range < pages-3){%> <b class="fv11bc" style="color:#05446B">&nbsp;.....&nbsp;</b>  <% } %>
    <% if(start/range < (pages-1)) { %>
    <a title="Last" href="javascript:changeHrefForm('<%= reqURI%>?byO=<%= byO%>&start=<%= (pages-1)*range%>&range=<%= range%><c:if test="${rqry != null}">&<c:out value="${ rqry }" /></c:if><c:if test="${clfId !=null }" >&clfId=<c:out value="${ clfId }" /></c:if><% if (sci != null) {%>&subCatId=<%= sci%><% }%><% if (request.getAttribute("adType") != null) {%>&adType=<%= request.getAttribute("adType")%><% }%>')"><span><%=pages%></span></a>

    <a title="Next" href="javascript:changeHrefForm('<%= reqURI%>?byO=<%= byO%>&start=<%=  start + range%>&range=<%= range%><c:if test="${rqry != null}">&<c:out value="${ rqry }" /></c:if><c:if test="${clfId !=null }" >&clfId=<c:out value="${ clfId }" /></c:if><% if (sci != null) {%>&subCatId=<%= sci%><% }%><% if (request.getAttribute("adType") != null) {%>&adType=<%= request.getAttribute("adType")%><% }%>')"><span style="border:none;color:#05446B;">></span></a>
    <% } else { %>
    <span style="background-color:#05446B;color:#ffffff;"> <%=pages%> </span>
    <% }%>

</div>

<% }%>


