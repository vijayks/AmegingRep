<%--
    Document   : refine
    Created on : Apr 4, 2009, 9:42:58 PM
    Author     : bbsadmin
--%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div id="masterrightcontentbody">
<%
String reqURI= (String)request.getAttribute("reqURI");
if (!reqURI.equalsIgnoreCase("tile1.do") && !reqURI.equalsIgnoreCase("clf.do") ) {%>
   
    <c:if test="${refineSearch != null}" >
   <%--<jsp:include page='/WEB-INF/jsp/advancedSearch.jsp'/>--%>
  <%-- <jsp:include page='/WEB-INF/jsp/delearSearch.jsp' />--%>
   </c:if>
 
 <jsp:include page='/WEB-INF/jsp/pagination.jsp'/>
 <jsp:include page='/WEB-INF/jsp/paginationNums.jsp'/>
<% } %>
<jsp:include page='/WEB-INF/jsp/latestAds.jsp'/>
<% if (!reqURI.equalsIgnoreCase("tile1.do") && !reqURI.equalsIgnoreCase("clf.do")) {%>
  <jsp:include page='/WEB-INF/jsp/paginationNums.jsp'/>
<% }%>
</div>