<%--
    Document   : recentSearches
    Created on : Jul 28, 2009, 6:22:22 PM
    Author     : bbsadmin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%@page import="java.util.*" %>
<%@page import="com.buysell.beans.RecentSearch" %>


<%--<script type="text/javascript" src="js/utilAjax.js"></script>--%>
<div style="margin:5px 0 0 0;clear:both"></div>

<c:if test="${recentSearches != null }" >
    <div id="recentS"   style="width:100%;float:left;height:12px;padding:0 0 10px 10px;">
        <div id="recent1" class="fv10c" style="width:650px;float:left;height:12px;overflow:hidden;">
            Recent Searches :&nbsp;
            <%
            LinkedHashMap<String, String> recentSearches = (LinkedHashMap<String, String>) request.getSession().getAttribute("recentSearches");
            if (recentSearches != null) {
                ArrayList<String> al = null;
                al = new ArrayList<String>();
                Set<String> set = recentSearches.keySet();
                for (String keyS : set) {
                        al.add(0, keyS);
                }
                for (String key : al) {
            %>

            <a title="" class="link11" href="<%= recentSearches.get(key)%>&city=<%=request.getSession().getAttribute("city")%>" ><span class="fv10c"><%= key%></span></a><span>,&nbsp;</span>
            <% }
        }%>
        </div>

        <div id="recent2" class="fv10c" style="float:right;width:50px;text-align:center;"> <a title="Clear" class="link11" href="javascript:return false;" onclick="RecentSearch();event.returnValue=false;return false;"><span class="fv10c">Clear</span></a> </div>
    </div>
</c:if>


