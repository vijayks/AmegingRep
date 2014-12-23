
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script>
    function ShowArticleMessage(id)
    {
        if((document.getElementById(id).style.display == 'inline'))
        {
            document.getElementById(id).style.display='none';
        }else if((document.getElementById(id).style.display == 'none'))
        {
            document.getElementById(id).style.display='inline';
        }
    }
</script>
<div style="width:720px;height:5px;"> </div>
<div class="pt"><div class="pb"><div class="pl"><div class="pr"><div class="pbl"><div class="pbr"><div class="ptl"><div class="ptr">

                                <div style="width:720px;" ><table><td>

                                            <div style="padding-top:15px; padding-bottom:10px;padding-left:10px" width="100%" valign="top" class="verdana_form_mainhead">My Articles</div>

                                            <div class="fvl2b"  style="float:left;width:720px;"></div>
                                            <% int c=1; %>
                                            <c:if test="${articles != null  }" >
                                                <c:forEach items="${articles}" var="article">

                                                    <div id="bg<c:out value="${article.uuid}" />" class="fv14bc" onmouseover="this.style.backgroundColor='#A6ACA0'" onmouseout="this.style.backgroundColor='#DBD9DA'"  style="float:left;width:680px;background-color:#DBD9DA;padding-left:20px;"><%= c %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a title="<c:out value="${article.title}" />"href="javascript:return false;" onclick="ShowArticleMessage('<c:out value="${article.uuid}" />');event.returnValue=false;return false;" > </a></div>

                                                    <div style="float:left;width:720px;height:10px;"></div>

                                                   <div class="fv11"  id="<c:out value="${article.uuid}" />" style="float:left;width:660px;display:none;padding-left:20px;padding-right:20px;" >

                                                       

                                                       <c:out value='${article.message}' escapeXml="false" />

                                                   <div style="float:left;width:720px;height:5px;"></div>
                                                   </div>

                                                   <% c++; %>
                                                </c:forEach>
                                            </c:if>

                                            <div  style="float:left;width:720px;height:10px;"></div>

                                            <div style="float:left;width:720px;height:10px;"></div>
                                    </td></table>
                                </div>

</div></div></div></div></div></div></div></div>