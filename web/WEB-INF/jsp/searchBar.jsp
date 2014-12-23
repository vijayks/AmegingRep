<%--
    Document   : searchBar
    Created on : May 11, 2009, 12:11:42 PM
    Author     : bbsadmin
--%>
<%--<%@page import="com.buysell.beans.UserBean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- Welcome body start -->
<script type="text/javascript">
    function searchSubmit()
    {
      document.basicSearch.submit();
      return true;
    }
</script>
<div style="width:275px;height:25px;float:left;padding:2px 0 2px 0;background-color:#ffffff">
    <span class="verdana_welcome">&nbsp;&nbsp; Welcome,</span>&nbsp;<span class="verdana_welcome_1">
        <logic:present name="userBean">
            <% UserBean ub = (UserBean) request.getSession().getAttribute("userBean");
            if (ub.getFirstName() != null && ub.getLastName() != null && !ub.getLastName().equalsIgnoreCase("null")  && !ub.getFirstName().equalsIgnoreCase("null")) {
            %>
            <%= ub.getFirstName()%>&nbsp;<%= ub.getLastName()%>
            <%   } else if (ub.getFirstName() != null && !ub.getFirstName().equalsIgnoreCase("null")) {%>
            <%= ub.getFirstName()%>
            <%    } else if (ub.getLastName() != null && !ub.getLastName().equalsIgnoreCase("null")) {%>
            <%= ub.getFirstName()%>
          <%  } else {%> Guest  <% }%>
        </logic:present>
        <logic:notPresent name="userBean">
            <span id="guest" style=""> Guest </span><span id="guest1" style=""></span>
        </logic:notPresent>
    </span>
</div>
<c:if test="${sessionScope.button != 'auctions'}" >
<div style="width:725px;float:left;padding:5px 0 2px 0;height:22px;background-color:#ffffff" >
    <form id="basicSearch" name="basicSearch" method="post" action="basicSearch.do">
        <div style="width:225px;float:left">
            <% String keyword = (String) request.getAttribute("keyword");
            if (keyword != null) {%>
            <input type="text" class="" style="width:200px;vertical-align:bottom" value="<%= keyword %>"  name="keyword"  onfocus="if(this.value=='Keyword') this.value='';" onblur="if(this.value=='') this.value='Keyword';"  />
            <% } else {%>
            <input type="text" class=""  name="keyword" style="width:200px;vertical-align:bottom" value="Keyword"  onfocus="if(this.value=='Keyword') this.value='';" onblur="if(this.value=='') this.value='Keyword';" />
            <% }%>
        </div>
        <div style="width:225px;float:left;">
            <select  name="subCatId" id="subCatId" style="width:200px;vertical-align:bottom">
                <option value="0"  selected="selected"> Select Category </option>
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
        <div style="width:275px;float:left;">
            <select id="adType" name="adType" style="width:150px;vertical-align:bottom">
                <option value="offered">Offered</option><option value="wanted">Wanted</option>
            </select>
            <input type="hidden" name="start" value="0"/>
            <input type="hidden" name="range" value="20"/>
            <input type="hidden" name="byO" value="1"/>
            <input type="hidden" name="m" value="<c:out value="${m}" />"/>
            &nbsp;
            <input  type="image" name="option" onclick="return searchSubmit();" src="bbsimages/buttons/Search.png" onmouseover="this.src='bbsimages/buttons/Search_MouseOver.png';" onmouseout="this.src='bbsimages/buttons/Search.png';" style="height:18px;vertical-align:bottom"  />
        </div>
    </form>
</div>
      <script type="text/javascript">
    <% if(request.getAttribute("subCatId") != null) { %> document.getElementById('subCatId').value='<%=request.getAttribute("subCatId")%>';
        <% } %>
             <% if(request.getAttribute("adType") != null) { %> document.getElementById('adType').value='<%= (String) request.getAttribute("adType")%>';
        <% } %>
</script>
</c:if>--%>
