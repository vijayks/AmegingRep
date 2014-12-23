<%--
    Document   : wsLMenu
    Created on : Feb 25, 2010, 10:43:23 AM
    Author     : bbsadmin
--%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="com.buysell.webshop.actionclasses.WebsiteAction" %>
<%@page import="com.buysell.beans.DealerMoreInfo" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<script type="text/javascript" src="js/curvycorners.js"></script>
<style>

    #list li a{
        background:url("bbsimages/bullet_li.gif") no-repeat scroll 2px 2px;
        color:#656565;
        font-size:11px;
        padding-left:10px
    }
    #list li a:hover{
        color:#67A227;
    }
    #list li a.selected{
        background:url("bbsimages/bullet_minus.gif") no-repeat scroll -3px -2px;
    }
    #list li{
        width:98%;
	* width:85%;
        border-bottom:1px dashed #EBEBEB;
    }
    #findDiv {
        color:#545454;
        font-size:15px
    }
    .subCatMenu {
	*width:85%;
    }
    #list .linkSCM{
	padding-left:20px;
	* padding-left:5px;
    }
</style>
<script type="text/javascript">
    function showSubcat(id,elm){
        var as=document.getElementById("list").getElementsByTagName("a");
        var uls=document.getElementById("list").getElementsByTagName("ul");
        for(i=0;i<as.length;i++){
        	if(as[i].className!="linkSCM")
	   as[i].setAttribute("class", "");
	}
        for(i=0;i<uls.length;i++)
            uls[i].style.display="none";
        elm.setAttribute("class", "selected");
        elm.setAttribute("onclick", "hideSubcat("+id+",this);");
        document.getElementById("subCat"+id).style.display="inline";
    }
    function hideSubcat(id,elm){
        elm.setAttribute("class", "");
        elm.setAttribute("onclick", "showSubcat("+id+",this);");
        document.getElementById("subCat"+id).style.display="none";
    }
</script>


<div style="margin-top:10px;width:180px;color:gray">
    <%--<div class="pt"><div class="pb"><div class="pl"><div class="pr"><div class="pbl"><div class="pbr"><div class="ptl">
                                <div class="ptr">
                                    <div id="findDiv" style="text-align:center"><div style="background-color:#EBEBEB;padding-left:5px;text-align:left"> Find your local</div>Sony centre<br><span style="font-size:30%;letter-spacing:6px">**************</span></div>
                                </div></div></div></div></div></div></div></div>--%>
    <br/>
  <% String du = (String) request.getSession().getAttribute("dw");
       if(du!=null) {
        DealerMoreInfo dm = (DealerMoreInfo) WebsiteAction.hmp.get(du);
        if(dm!=null){
            request.setAttribute("dealerWebsite",dm);
    %>
     <c:set var="awsCategories" value="${dealerWebsite.wsCatList}"/>
    <div style="float:left;width:90%;margin-left:5px">
        <span style="margin-left:0px;color:#656565;font-size:80%;">Categories</span><br/><br/>
        <div class="pr">
                <ul id="list" style="list-style:none;padding:0;margin:0">
                    <c:if test="${awsCategories!=null}">
                        <c:forEach items="${awsCategories}" var="cats">
                            <c:if test="${cats.parentId==0&&cats.status==1}">
                                <li><a title="${cats.name}" href="#" onclick="showSubcat('${cats.catId}',this);">${cats.name}</a></li>
                            <ul id="subCat${cats.catId}" style="list-style:none;padding:0px;margin:0;display:none">
                            <c:forEach items="${awsCategories}" var="subCats">
                                <c:if test="${subCats.parentId==cats.catId&&subCats.status==1}">
                                    <li class="subCatMenu"><a class="linkSCM" href="getWSProducts.do?subcat=${subCats.name}@${subCats.id}" title="${subCats.name}" style="background:none;">${subCats.name}</a></li>
                                </c:if>
                            </c:forEach>
                            </ul>
                            </c:if>
                        </c:forEach>
                    </c:if>
                </ul>
            </div>
        <br/><br/>
        </div>
    <%}else {%>
    Please access from the Home Page
    <%}}%>
    <div id="findDiv"><center><a title="Whats new" href="getWCT.do?lT=new"><img src="bbsimages/bttn_02_en_gb.gif" border="0" alt="Whats New"/></a></center></div><br/>
    <div id="findDiv"><center><a title="Special Offer" href="getWCT.do?lT=spl"><img src="bbsimages/bttn_03_en_gb.gif" alt="Special Offer" border="0"/></a></center></div>
        <br/>
        <div style="clear:both"></div>
        <div class="wct" style="float:left;width:88%;border:1px solid #E1E1E1;margin-left:2px">
            <ul id="list" style="list-style:none;padding-left:5px">
                <li><a title="Whats New" href="getWCT.do?lT=new"> Whats New</a></li>
                <li><a title="Latest Offers" href="getWCT.do?lT=spl"> Latest Offers</a></li>
                <li><a title="Top Sellers" href="getWCT.do?lT=tnl"> Top Sellers</a></li>
            </ul>
    </div>
        <script type="text/javascript">
            settings = {
            tl: { radius: 5 },
            tr: { radius: 5 },
            bl: { radius: 5 },
            br: { radius: 5 },
            antiAlias: true,
            autoPad: true,
            validTags: ["div"]
        }
        var myBoxObject = new curvyCorners(settings, "wct");
        myBoxObject.applyCornersToAll();
        </script>


</div>
