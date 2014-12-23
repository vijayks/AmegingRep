<%--
    Document   : detailView
    Created on : Apr 25, 2009, 11:35:32 AM
    Author     : praveen.ch
--%>

  <%@ taglib uri="http://struts.apache.org/tags-tiles" prefix="tiles" %>
   <%@ page language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>





        <input type="hidden" name="adId" value=<%=request.getParameter("adId") %> />
        Ad Id : <%=request.getParameter("adId") %><br />
        Title : <input type="text" name="adTitle" value='<%=request.getParameter("title") %>' />
       <br />
        Description :  <input type="text" name="description" value='<%=request.getParameter("description") %>' /><br />
        Image : <img name="image1" src="resourceGetter?imf=<%=request.getParameter("image1") %>" width="75px" height="75px" align="center" />
        <br />
       
   





