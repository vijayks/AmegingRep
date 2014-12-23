<%--
    Document   : myAccount_SmsDetails
    Created on : Jan 10, 2010, 3:49:41 PM
    Author     : Sujith
--%>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%@taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<div class="boxBorder2" style="width:710px;float:left;background-color:#F1F1EB;">
    <div class="fv12bc" style="float:left;padding:20px 0 ;font-size:1em">
        <div style="float:left;padding-left:40px">Allocated SMS : <span style="color:black">${userBean.noSms}</span></div>
        <div style="float:left;padding-left:80px">Recieved SMS : <span style="color:black">${used}</span></div>
        <div style="float:left;padding-left:80px">Balance SMS : <span style="color:black"><c:out value="${userBean.noSms-used}"/></span></div>
    </div>
</div>
            <div style="clear:both"></div>
<div style="width:710px;margin-top:10px">
            <div class="pt"><div class="pb"><div class="pl"><div class="pr"><div class="pbl"><div class="pbr"><div class="ptl"><div class="ptr">
                                            <div  style="float:left;text-align:center;line-height:25px" >
                                                <div class="fv12bc" >
                                                    <div style="width:120px;background:#F1F1EB;float:left;">Date </div>
                                                    <div style="width:2px;float:left;">&nbsp;</div>
                                                    <div style="width:120px;background:#F1F1EB;float:left">Type </div>
                                                    <div style="width:2px;float:left;">&nbsp;</div>
                                                    <div style="width:150px;background:#F1F1EB;float:left">Status</div>
                                                    <div style="width:2px;float:left;">&nbsp;</div>
                                                    <div style="width:150px;background:#F1F1EB;float:left">Requestor</div>
                                                    <div style="width:2px;float:left;">&nbsp;</div>
                                                    <div style="width:150px;background:#F1F1EB;float:left">City</div>
                                                </div>
                                            </div>
                                            <div style="clear:both"></div>
                                                <c:forEach items="${leads}" var="lead">
                                                    <div class="fv11"style="float:left;line-height:20px;text-align:center;">
                                                        <div style="width:120px;float:left;"> ${lead.deliveryDate} </div>
                                                        <div style="width:2px;float:left;background:#F1F1EB;">&nbsp;</div>
                                                        <div style="width:120px;float:left;">${lead.type} </div>
                                                        <div style="width:2px;float:left;background:#F1F1EB;">&nbsp;</div>
                                                        <div style="width:150px;float:left;"><c:if test="${lead.status=='0'}">Initiated</c:if><c:if test="${lead.status=='1'}">Delivered</c:if><c:if test="${lead.status=='2'}">Not Delivered</c:if></div>
                                                        <div style="width:2px;float:left;background:#F1F1EB;">&nbsp;</div>
                                                        <div style="width:150px;float:left;">${lead.uContact}</div>
                                                        <div style="width:2px;float:left;background:#F1F1EB;">&nbsp;</div>
                                                        <div style="width:150px;float:left;">${lead.city}</div>
                                                    </div>
                                                    <div style="line-height:2px;float:left">
                                                        <div style="width:120px;float:left;background:#F1F1EB;">&nbsp;</div>
                                                        <div style="width:2px;float:left;"></div>
                                                        <div style="width:120px;float:left;background:#F1F1EB;">&nbsp;</div>
                                                        <div style="width:2px;float:left;"></div>
                                                        <div style="width:150px;float:left;background:#F1F1EB;">&nbsp;</div>
                                                        <div style="width:2px;float:left;"></div>
                                                        <div style="width:150px;float:left;background:#F1F1EB;">&nbsp;</div>
                                                        <div style="width:2px;float:left;"></div>
                                                        <div style="width:152px;float:left;background:#F1F1EB;">&nbsp;</div>
                                                    </div>
                                                </c:forEach>
                                            <div style="clear:both"></div>
          </div></div></div></div></div></div></div></div>
    </div>