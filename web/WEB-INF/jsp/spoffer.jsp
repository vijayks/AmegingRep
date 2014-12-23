<%--
    Document   : spoffer
    Created on : Jun 11, 2009, 3:01:47 PM
    Author     : bbsadmin
--%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<style>
    <!--
.decn
    {
        font-size:16px;
        color:#222222;
        font-weight:bold;
        font-family:Arial;
        margin:10px 5px 5px 50px;
    }
 .deadd
    {
       font-size:12px;
        color:#0066ff;
        font-weight:bold;
        font-family:Arial;
        margin:10px 5px 5px 75px;
        overflow:hidden;
    }
    .rstrike
    {
        color:red;
        text-decoration:line-through;
    }
    .lp
    {
        /*margin:5px 0 0 150px;*/
        font-size:15px;
        font-weight:bold;
    }
-->
</style>
<div style="width:730px;float:left;margin:5px 0 0 0">
    <div class="pt"><div class="pb"><div class="pl" ><div class="pr"><div class="pbl"><div class="pbr"><div class="ptl">
    <div class="ptr">
    <c:if test="${slist != null}" >
        <c:forEach items="${slist}" var="slist" >
            <br />
            <div style="margin-left:10px">
           <div class="sprt"><div class="sprb"><div class="sprl" ><div class="sprr">
               <div class="sprbl"><div class="sprbr"><div class="sprtl"><div class="sprtr">
           <div class="" style="width:100%;padding:15px 0 5px 0;height:100px">
                <div style="float:left;width:70%">
                  <span class="decn"> <c:out value="${slist.companyName}" /> </span><br />
                  <span class="deadd">
                    <c:out value="${slist.address}" />
                  </span><br />
                  <span class="deadd">
                    <c:out value="${slist.city}" />
                  </span>

                </div>
                <div style="float:right;width:30%">
                   <img src="resourceGetter?imf=${slist.logo}" style="border:5px double #222222;height:80px;width:185px" />
                </div>
            </div>
        </div></div></div></div></div></div></div></div>
            <br />
            <div style="width:30%;float:left;height:150px;">
               <!-- <img src="resourceGetter?imf=${slist.img1}" style="height:150px;width:100px;margin-left:50px;" /> -->
               <img src="resourceGetter?imf=${slist.img2}" style="height:150px;width:100px;margin-left:50px" />
            </div>
           <div style="width:68%;float:left;height:150px;text-align:center;">
               <span class="fv14bc" style="text-align:center;margin:0 10px"><c:out value="${slist.scrTitle}" /></span>
                <br /><br />
                <span class="lp">List Price &nbsp; :<span class="rstrike"> INR <c:out value="${slist.lprice}" /> </span> </span> <br />
                <span class="lp">Offer Price :<span> INR <c:out value="${slist.oprice}" /> </span> </span>
            </div>
           <div style="clear:both"> </div><br />
            <span class="fv12bc" >Product Description  </span> <br /><br />
            <div class="fv11" style="margin:0 15px ;text-align:justify;">
                <span style="padding-left:10px"><c:out value="${slist.desc}" /></span>
            </div>
            <br /><br />
            <span class="fv12bc" > Offer Details   </span> <br /><br />
            <div class="fv11" style="width:90%;padding:0 0 0 20px">
               - Offer Valid From :<c:out value="${slist.sDate}" /><br />
               - Offer Valid To:<c:out value="${slist.eDate}" /><br />
               - Terms & Conditions apply for the purchase.<br />
               - Only limited stock available.<br />
            </div>
            <br /><br /><br />
        </c:forEach>
    </c:if>
</div>
</div></div></div></div></div></div></div></div>
</div>