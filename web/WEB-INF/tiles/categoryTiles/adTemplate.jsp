
<%--
Document   : adTemplate
Created on : Apr 1, 2009, 12:50:13 PM
Author     : bbsadmin
--%>

<%@ taglib uri="http://struts.apache.org/tags-tiles" prefix="tiles" %>
<%@ page language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:choose>
    <c:when test="${tileList!=null}">
        <c:forEach items="${tileList}" var="tile">
            <tiles:insert name="${tile}"/>
        </c:forEach>
    </c:when>
    <c:otherwise>
           <c:if test="${reqURI!='createAdMy.do'}">
        <div class="car_main_cont" >
            <div class="postAd_part">
                <div class="postAd_heading">Post A Free Ad in BharatBuySell for free !</div>
                <jsp:include page="/WEB-INF/tiles/categoryTiles/login.jsp"/>
                <jsp:include page="/WEB-INF/tiles/categoryTiles/selectedCategory.jsp"/>
                <div id="priceJsp"></div>
                <jsp:include page="/WEB-INF/tiles/categoryTiles/additionalContent.jsp"/>
                <div id="slCtgJsp"></div>
                <jsp:include page="/WEB-INF/tiles/categoryTiles/footer.jsp"/>
            </div>
        </div>
            </c:if>
        <c:if test="${reqURI=='createAdMy.do'}">
            <div>
                <div>
                    <div style="color:#093B8F;margin-top:15px;margin-bottom:-20px">Post A Free Ad in BharatBuySell for free !</div>
                    <jsp:include page="/WEB-INF/tiles/categoryTiles/login.jsp"/>
                    <jsp:include page="/WEB-INF/tiles/categoryTiles/selectedCategory.jsp"/>
                    <div id="priceJsp"></div>
                    <jsp:include page="/WEB-INF/tiles/categoryTiles/additionalContent.jsp"/>
                    <div id="slCtgJsp"></div>
                    <jsp:include page="/WEB-INF/tiles/categoryTiles/footer.jsp"/>
                </div>
            </div>
        </c:if>
    </c:otherwise>
</c:choose>

