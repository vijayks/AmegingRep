<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<style>
    <!--
    #sco a
    {
        text-decoration:none;
    }
    #sco img
    {
        display: block;
        margin-left: auto;
        margin-right: auto;
        border:none;
    }
    #sco
    {


    }
    -->
</style>
<c:if test="${spoImgList != 'null'}" >
    <br /><br />
    <div id="sco" style="margin:0 auto;width:700px;">

        <c:forEach items="${spoImgList}" var="i">

            <c:if test="${i.img1 != 'null' }">
                <a target="_blank" href="${i.url}" ><img src="resourceGetter?imf=${i.img1}" /></a>
                </c:if>
                <c:if test="${i.img2 != 'null'  }">
                <a target="_blank" href="${i.url}" ><img src="resourceGetter?imf=${i.img2}" /></a>
                </c:if>
                <c:if test="${i.img3 != 'null'}">
                <a target="_blank" href="${i.url}" ><img src="resourceGetter?imf=${i.img3}" /></a>
                </c:if>
                <c:if test="${i.img4 != 'null'}">
                <a target="_blank" href="${i.url}" ><img src="resourceGetter?imf=${i.img4}" /></a>
                </c:if>
                <c:if test="${i.img5 != 'null'}">
                <a target="_blank" href="${i.url}" ><img src="resourceGetter?imf=${i.img5}" /></a>
                </c:if>
                <c:if test="${i.img6 != 'null'}">
                <a target="_blank" href="${i.url}" ><img src="resourceGetter?imf=${i.img6}" /></a>
                </c:if>
                <c:if test="${i.img7 != 'null'}">
                <a target="_blank" href="${i.url}" ><img src="resourceGetter?imf=${i.img7}" /></a>
                </c:if>
                <c:if test="${i.img8 != 'null'}">
                <a target="_blank" href="${i.url}" ><img src="resourceGetter?imf=${i.img8}" /></a>
                </c:if>
                <c:if test="${i.img9 != 'null'}">
                <a target="_blank" href="${i.url}" ><img src="resourceGetter?imf=${i.img9}" /></a>
                </c:if>
            </c:forEach>

    </div>
</c:if>