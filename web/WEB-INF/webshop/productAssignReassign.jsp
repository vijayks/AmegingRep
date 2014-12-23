<%--  Document   : ProductAssignReassign
  Created on : Mar 4, 2010, 12:00:31 PM
  Author     : bbsadmin
--%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/jquery-ui-1.7.2.custom.min.js"></script>
<script type="text/javascript" src="js/jquery-drag-drop-list.js"></script>
<script type="text/javascript" src="js/dealerAjax.js"></script>
<style type='text/css'>

    .panel {float:left;width:200px;margin:20px;font-size:12px;float:left}

    ul {
        list-style-type:none;
        border:1px solid #999;
        background:#4d9edf;
        padding:20px;
        min-height:150px;
        width:150px;
    }

    li {
        display:block;
        border:1px solid #999;
        background:#ffc;
        width:130px;
        padding:5px 10px;
        margin-bottom:5px;
    }

    .dds_selected {
        background:#fc3;
    }
    .dds_ghost {
        opacity:0.5;
    }
    .dds_move {
        background:#cfc;
    }
    .dds_hover {
        background:#070;
        border:3px dashed #c96;
    }

    .holder {
        border:3px dashed #333;
        background:#fff;
    }

</style>

<script type="text/javascript">
    $(function(){
        mychange = function ( $list ){
            $( '#'+$list.attr('id')+'_serialised').html( $.dds.serialize( $list.attr('id')) );
        }
        $('ul').drag_drop_selectable({
            onListChange:mychange
        });
        $( '#prdList_serialised').html( $.dds.serialize( 'prdList' ) );
        $( '#catPrdList_serialised').html( $.dds.serialize( 'catPrdList' ) );
    });
    function showPrAsRe(){
        document.getElementById("prAsRe").style.display="inline";
    }

    function createHid(){
        var l=document.getElementById("catPrdList").getElementsByTagName("li");
        var hidDiv=document.getElementById("hDiv");
        hidDiv.innerHTML="";
        for(i=0;i<l.length;i++){
            var f=document.createElement("input");
            f.setAttribute("type","hidden");
            f.setAttribute("name","asPr");
            f.setAttribute("value",l[i].value);
            // hidDiv.appendData("<input type='hidden' name='asPr' value='"+l[i].value+"'/>");alert("hi2");
            hidDiv.appendChild(f);

        };
    }
</script>
<div class="verdana_form_postAd">

    <br><br>
    <div id="prAsRe">
        <fieldset><legend>Assign Products to SubCategory <c:if test="${nm!=null}"><b>&ldquo;${nm}&rdquo;</b></c:if></legend>
            <form action="assignD.do" method="POST" name="assignedPrd" onsubmit="return createHid()">
                <div class='panel' style="float:left">
                    <h4>Products List </h4>
                    <p>Select:
                        <a href='#' onclick='return $.dds.selectAll("prdList");'>all</a>
                        <a href='#' onclick='return $.dds.selectNone("prdList");'>none</a>
                        <a href='#' onclick='return $.dds.selectInvert("prdList");'>invert</a>

                    </p>

                    <ul id="prdList">
                        <c:if test="${assignedPrd!=null}">
                            <c:forEach items="${prodList}" var="pd">
                                    <c:set var="i" value="1"/>
                                    <c:forEach items="${assignedPrd}" var="ad">
                                        <c:if test="${pd.prodId==ad.prodId}">
                                            <c:set var="i" value="0"/>
                                        </c:if>
                                    </c:forEach>
                                    <c:if test="${i==1}"><li value="${pd.prodId}" title="${pd.name} (${pd.modelId})">${pd.name}</li></c:if>
                            </c:forEach>
                        </c:if>
                    </ul>
                    <%--<p>Products List contains:<br><span id='prdList_serialised'></span></p>--%>
                </div>
                <div class="panel" style="padding-top:100px;margin-left:0">
                    <center>Just Drag &amp; drop<br><br>
                        <span style="color:#070;">-->-->-->Assign-->-->--></span><br><br>
                        <span style="color:red;"><--<--<--Reassign<--<--<--</span></center>
                </div>
                <div class='panel'>
                    <h4>Existing Products List</h4>
                    <p>Select:
                        <a href='#' onclick='return $.dds.selectAll("catPrdList");'>all</a>
                        <a href='#' onclick='return $.dds.selectNone("catPrdList");'>none</a>
                        <a href='#' onclick='return $.dds.selectInvert("catPrdList");'>invert</a>
                    </p>
                    <ul id="catPrdList">
                        <c:if test="${assignedPrd!=null}">
                            <c:forEach items="${assignedPrd}" var="ad">
                                <c:forEach items="${prodList}" var="pd">
                                    <c:if test="${pd.prodId==ad.prodId}">
                                        <li value="${pd.prodId}" title="${pd.name} (${pd.modelId})">${pd.name}</li>
                                    </c:if>
                                </c:forEach>
                            </c:forEach>
                        </c:if>
                    </ul>
                    <div id="hDiv">

                    </div>
                    <input type="hidden" value="${nm}" name="catName"/>
                    <input type="hidden" value="${catId}" name="catId"/>
                    <input type="hidden" name="wi" value="<%= request.getParameter("wi")%>"/>
                    <input type="hidden" name="wn" value="<%= request.getParameter("wn")%>"/>
                    <input type="hidden" name="ws" value="<%= request.getParameter("ws")%>"/>
                    <%--<p>Existing Products List contains:<br><span id='catPrdList_serialised'></span></p>--%>
                    <center><input type="submit" value="Submit"/></center>
                </div></form>
        </fieldset>
    </div>
</div>