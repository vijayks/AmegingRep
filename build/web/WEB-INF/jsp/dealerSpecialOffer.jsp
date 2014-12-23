<%--
    Document   : dealerSpecialOffer
    Created on : Jan 9, 2010, 8:02:38 PM
    Author     : bbsadbn
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn"%>
<script type="text/javascript" src="<c:url value='/js/allAjax.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/dealerAjax.js'/>"></script>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<div id="masterleftbodybg">       <!-- left body background start and end -->
    <div id="mastercontentbody">      <!-- Master content body div start   -->
        <div id="leftcategorymenu" style="background:none">
            <style>
                #fieldHead{font-size:13px;font-weight:bold;}
            </style>
            <div style="width:98%;float:left;margin-left:5px;margin-right:5px; ">
                <div style="width:98%;font-size:11px;border-right:1px solid #888888">
                    <c:if test="${dAdBean!=null}">
                        <c:set var="db" value="${dAdBean}"/>
                        <c:if test="${db.businessDetails!=null}">
                            <br/><span id="fieldHead">Business Details</span><br/><br/>
                            <b>*</b>&nbsp;  <c:out value="${fn:substringBefore(db.businessDetails,'|')}"/><br/><br/>
                            <b>*</b>&nbsp;  <c:out value="${fn:substringAfter(db.businessDetails,'|')}"/><br/>
                        </c:if> <br/> <br/>
                        <span id="fieldHead">Address:</span><br/>${db.address}<br/>
                        <c:if test="${db.landMark!=null}"> <br/><span id="fieldHead">Land Mark:</span><br/>${db.landMark}<br/> </c:if>
                        <br/><span id="fieldHead">Phone:</span><br/>${db.phone}<br/>
                        <br/> <span id="fieldHead">Mobile:</span><br/>${db.mobile}<br/>
                        <br/><span id="fieldHead">Email-id:</span><br/>${db.emailId}<br/>
                        <c:if test="${db.webUrl!=null && db.webUrl!=''}">
                            <br/><span id="fieldHead">Website:</span><br/>
                            <c:if test="${fn:startsWith(db.webUrl,'http://') == true}" > <a title="Dealer's Website" target="_blank" href="${db.webUrl}">${db.webUrl}</a> </c:if>
                            <c:if test="${fn:startsWith(db.webUrl,'http://') != true}" > <a title="Dealer's Website"target="_blank" href="http://${db.webUrl}">${db.webUrl}</a> </c:if>
                        </c:if><br/><br/>
                        <div style="float:left;"> <a title="Save Dealer Details in your Mobile" href="javascript:return false" onclick="SaveToMobileDlrAjaxFun('Div','dlId=${db.dId}&domainName=${db.compName}&city=${db.city}&locality=${db.locality}&mobile=${db.phone}','<c:url value="/irrsdl"/>');"><img src="<c:url value='/bbsimages/save_mbl.png;'/>" style="border:none"/> </a></div>
                        <div style="float:left;width: 200px;"> <c:if test="${userBean!=null}"><div id="msgDiv" ></div></c:if> <c:if test="${userBean==null}"><div style="color:red;">* Please Login to Save</div></c:if> </div><br/><br/><br/><br/>
                        <div id="loadDiv" style="display:none"></div> <div id="formDiv" style="display:none"></div>    
                        <div style="float:left;"> <a title="Bookmark this page" href="javascript:return false" onclick="bookmark_us();"><img src="<c:url value='/bbsimages/add_brmk.png;'/>" style="border:none"/></a><br/></div>
                        <br/><br/><br/>
                        <script type="text/javascript">
                            function showImg(divid) {
                                var n=document.getElementById('noim').value;
                                var i=1;
                                for(i=1;i<=n;i++) {
                                    document.getElementById('im'+i).style.display='none';
                                } document.getElementById(divid).style.display='inline';
                            }
                            function bookmark_us(){
                                if (window.sidebar){ // firefox
                                    window.sidebar.addPanel('${db.compName} in BharatBuySell',document.location.href, "");
                                }else if(window.opera && window.print){ // opera
                                    var elem = document.createElement('a');
                                    elem.setAttribute('href',url);
                                    elem.setAttribute('title',title);
                                    elem.setAttribute('rel','sidebar');
                                    elem.click();
                                }
                                else if(window.chrome){
                                    alert('Press ctrl+D to bookmark (Command+D for macs) after you click Ok');
                                } 
                                else if(document.all)// ie
                                    window.external.AddFavorite(document.location.href,'${db.compName} in BharatBuySell');
                            }
                        </script>
                            </c:if>
                </div><br/>
            </div>
        </div>
    </div>
</div>