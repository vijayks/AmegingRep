<%--
    Document   : ProductsPhotoGallery
    Created on : Mar 22, 2010, 5:14:17 PM
    Author     : bbsadmin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%@page import="java.util.StringTokenizer" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<script type="text/javascript">
    function showImg(divid) {
        var n=document.getElementById('noim').value;
        var i=1;
        for(i=1;i<=n;i++) {
            document.getElementById('im'+i).style.display='none';
        }
        document.getElementById(divid).style.display='inline';
    }
</script>
<%--

<div style="width:555px;float:left;height:810px;margin-top:10px;font-size:12px" >
    <span style="font-size:25px;color:#007700;padding-left:20px"></span>
    <div  style="width:555px;float:left;height:300px;padding:20px" >
        <c:set var="imgs" value='<%= request.getParameter("imgs")%>'/>
        <c:if test="${imgs!=null}">

            <c:set var="hh1" value="${imgs}"/>
            <c:set var="i" value="1"/>
            <% String str = (String) pageContext.getAttribute("hh1");
            StringTokenizer st = new StringTokenizer(str, "|");
            while (st.hasMoreTokens()) {
                String val = st.nextToken();%>
            <div   style="width:185px;float:left;height:300px;">
                <a href="newProdDet.do?prodId=&et=et"><img src="resourceGetter?imd=${userBean.path}<%=val%>" width="150px" height="165px"  border="0"></a>
                     <div style="width:185px;float:left;padding:10px;">
                         ${al.name} <br/> ${al.modelId}
                         <a href="" style="color:teal">More..</a><br/>
                         400pts
                     </div>
            </div><c:if test="${(i%3)==0}"><br/></c:if><c:set var="i" value="${i+1}"/>
            <c:set var="i" value="${i+1}"/>
            <%}%>
        </c:if>

    </div></div>--%>
<div style="margin:150px;margin-top:70px">
<% String images=request.getParameter("imgs");
%>
<c:set var="images" value="<%= images %>"/>


<%--<c:set var="images" value="<%= request.getParameter('imgs')%>"/>--%>
<c:if test="${fn:length(images)==0}"><div style="width:220px;height:160px;">No images found</div></c:if>
<c:set var="hh1" value="${images}"/>

<c:if test="${images!=null}">
    <c:set var="ic" value="1"/>
    <% String str1 = (String) pageContext.getAttribute("hh1");
      StringTokenizer st1 = new StringTokenizer(str1, "|");
      while (st1.hasMoreTokens()) {
      String val = st1.nextToken();%>
    <div id="im${ic}" style="display:none;">
        <div style="width:200px;height:150px;">
            <img src="resourceGetter?imd=${userBean.path}<%=val%>"  style="width:200px;height:150px" alt="Image${ic}"/>
        </div>
    </div>
    <c:set var="ic" value="${ic+1}"/>
    <%}%>
    <c:set var="ic" value="1"/>
    <div style="width:98%;float:left">
        <% String str2 = (String) pageContext.getAttribute("hh1");
              StringTokenizer st2 = new StringTokenizer(str2, "|");
              while (st2.hasMoreTokens()) {
              String val2 = st2.nextToken();%>
        <a title="${ic}"href="javascript:return false" onclick="showImg('im${ic}');" > ${ic} |</a>
        <c:set var="ic" value="${ic+1}"/>
        <%}%>
    </div>
    <input type="hidden" id="noim" value="${ic-1}">
    <script type="text/javascript">showImg('im1');</script>
</c:if>
</div>