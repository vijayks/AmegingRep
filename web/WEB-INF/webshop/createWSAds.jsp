<%--
    Document   : createWSAds
    Created on : Apr 2, 2010, 4:19:56 PM
    Author     : bbsadmin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">



<c:if test="${msg!=null}"> <center><span style="color:green"><b>${msg}</b></span></center></c:if>
<c:if test="${okS!=null}"> <center><span style="color:green"><b>${okS}</b></span></center></c:if>
<c:if test="${okF!=null}"> <center><span style="color:green"><b>${okF}</b></span></center></c:if>

<c:if test="${imgList!=null}">
    <div class="verdana_form_postAd" style="width:720px;">
        <form action="upWdtAds.do?ts=ud" method="post" name="" onsubmit="" enctype="multipart/form-data">
            <c:set var="i" value="1"/>
            <fieldset>
                <legend style="color:#3366cc;"><b>Website Ads Creation</b></legend>
                <table style="margin:40px 50px 0 100px">
                    <c:forEach items="${imgList}" var="iL">
                        <tr>
                            <td style="vertical-align:middle">Ad Image ${i}  </td>
                            <c:if test="${iL!=null}"><td><img src="resourceGetter?imd=${userBean.path}${iL}" alt="Ad ${i} Image" border="0" height="100px" width="100px"/>
                                    <br/>
                                    <input type="file" id="img${i}" name="img${i}"/><input type="hidden" name="pvImg${i}" value="${iL}"/></td></c:if>
                            <c:if test="${iL==null}"><td><input type="file" id="img${i}" name="img${i}"/></td></c:if>
                        </tr>
                        <c:set var="i" value="${i+1}"/>
                    </c:forEach>
                </table> <center><input type="submit" value="Update"/></center>
            </fieldset>
        </form>
    </div>
</c:if>

<c:if test="${imgList==null}">
    <div class="verdana_form_postAd" style="width:720px;">
        <fieldset>
            <legend style="color:#3366cc;"><b>Website Ads Creation</b></legend>
            <form action="wstAds.do" method="post" enctype="multipart/form-data">
                <table style="margin:40px 50px 0 100px">

                    <c:set var="i" value="1"/>
                    <c:forEach  begin="1" end="5" step="1">
                        <tr>
                            <td style="vertical-align:middle">Ad Image ${i}  </td>

                            <td>  <input type="file" id="img${i}" name="img${i}"/></td>
                        </tr>
                        <c:set var="i" value="${i+1}"/>
                    </c:forEach>
                </table>
               <center><input type="submit" value="Create"/></center>
            </form>
        </fieldset>
       </div>
</c:if>
