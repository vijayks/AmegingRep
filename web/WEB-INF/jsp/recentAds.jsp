<%--
    Document   : recentAds
    Created on : Dec 13, 2010, 12:06:53 PM
    Author     : bbsadmin
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page import="com.buysell.util.URlUtil" %>

<div class="line"></div>

<div id="recaddiv" style="float:left;max-height:710px;overflow-y:scroll;*height:710px">
    <logic:present name="recentAdResultsBean" property="results">
        <bean:size id="size" name="recentAdResultsBean" property="results"/>
        <logic:greaterThan name="size" value="0">
            <logic:iterate id="result"  name="recentAdResultsBean" property="results">

                <div class="adt"><div class="adb"><div class="adl"><div class="adr"><div class="adbl"><div class="adbr"><div class="adtl"><div class="adtr">
                        <div  style="height:65px;width:740px;border-bottom:1px solid #4d9edf;margin-top:5px;" >
                                    <c:set var="adDesc" value="${result.title}" scope="request"/>
                                    <c:set var="urlAdId" scope="request"><bean:write name="result" property="adId"  /></c:set>
                                    <c:set var="urlCatId" scope="request"><bean:write name="result" property="catId"  /></c:set>
                                    <% String url="";
                                        String uAdId="";
                                        String uCatId="";
                                        url=(String)request.getAttribute("adDesc");
                                        uAdId=(String)request.getAttribute("urlAdId");
                                        uCatId=(String)request.getAttribute("urlCatId");
                                        if(url!=null)
                                        url=URlUtil.getUrlString(url,uAdId,uCatId);
                                        else
                                            url=".htm";
                                        url=url.replaceAll("\\<?","");
                                        url="bs/"+url;
                                         %>


                            <div style="float:left;height:65px;width:720px;overflow:hidden;padding-left:10px">
                                <div class="fv12bc" style="text-align:left;float:left;padding-left:3px;width:615px;padding-top:5px;overflow:hidden">
                                    <a class="link" style="font-size:11px;color:#046DBE"  href="<%=url%>" title="${result.title}">
                                        <c:if test="${fn:length(result.title) <= 50 }">
                                            <c:out value="${result.title}" />&nbsp;(<bean:write name="result" property="parentCatName" filter="false"  />)
                                        </c:if>
                                        <c:if test="${fn:length(result.title) > 50 }">
                                            <c:out value="${fn:substring(result.title,0,45)}"  />&nbsp;(<bean:write name="result" property="parentCatName" filter="false"  />)
                                        </c:if>
                                    </a>
                                </div>
                                <div class="fv11b" style="float:left;text-align:right;width:100px;padding-right:2px;padding-top:5px"><b>
                                        <a class="link" style="font-size:11px;color:#222222"  href="<%=url%>" title="Details of ${result.title}">More Details...</a>
                                    </b></div>
                                <div class="fv11" style="height:25px;width:714px;float:left;text-align:left;padding:2px 3px;overflow:hidden">
                                    <c:if test="${fn:length(result.description) <= 250 }" >
                                        <c:out value="${result.description}" />
                                    </c:if>
                                    <c:if test="${fn:length(result.description) > 250 }" >
                                        <c:out value="${fn:substring(result.description,0,250)}" />&nbsp;&nbsp;<a href="<%=url%>" title="Details of ${result.title}"><span style="color:#046dbe">More...</span></a>
                                    </c:if>
                                </div>
                                <div class="fv11" style="padding-left:3px;float:left;width:317px;text-align:left;padding-bottom:5px">
                                    <logic:equal name="result" property="adType" value="wanted">
                                        <c:if test="${result.max != 0}">
                                        <span class="fv11b" >Rs.</span><fmt:formatNumber type="currency"  value="${result.min}" pattern="#,##,###.00" /> to <fmt:formatNumber type="currency"  value="${result.max}" pattern="#,##,###.00" />
                                        </c:if>
                                    </logic:equal>
                                    <logic:equal name="result" property="adType" value="offered">
                                        <logic:notEqual name="result" property="cfp" value="on">

                                           <c:if test="${result.price != 0}">
                                                <span class="fv11b" >Rs.</span>
                                                <fmt:formatNumber type="currency"  value="${result.price}" pattern="#,##,###.00" />
                                                (<logic:equal name="result" property="neg" value="yes">Neg</logic:equal><logic:equal name="result" property="neg" value="no">Not-Neg</logic:equal>)
                                            </c:if>
                                            <c:if test='${result.rentMonth != 0}'>
                                                <span class="fv11b">Rs.</span>
                                                <fmt:formatNumber type="currency"  value="${result.rentMonth}" pattern="#,##,###.00" />
                                                (<c:if test="${result.neg == 'yes' }">Neg</c:if><c:if test="${result.neg == 'no'}">Not-Neg</c:if>)
                                            </c:if>
                                        </logic:notEqual>
                                        <logic:equal name="result" property="cfp" value="on">
                                            <span class="fv11bc" style="padding-right:2px">Contact for Price</span>
                                        </logic:equal>
                                    </logic:equal>
                                </div>
                                <div class="fv11" style="float:left;width:400px;text-align:right;padding-bottom:5px">Posted By
                                    <span class="fv11bc"  ><bean:write name="result" property="firstName" /> </span>
                                    on <span class="fv11bc" style="padding-right:2px">
                                    <bean:write name="result" property="postedDate"/> </span>
                                </div>
                            </div>
                        </div>
                </div></div></div></div></div></div></div></div>
                <div style="clear:both"></div>
             </logic:iterate>
        </logic:greaterThan>
    </logic:present>
</div>
<br/>
<script type="text/javascript">
window.onload = function () {
  // only apply to IE
  if (!/*@cc_on!@*/0) return;

  // find every element to test
  var all = document.getElementById('recaddiv');

    if (all.scrollWidth > all.offsetWidth) {
      all.style['paddingRight'] = '15px';
      all.style['overflowX'] = 'hidden';
  }
};
</script>