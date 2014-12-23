<%--
    Document   : defineWebshop
    Created on : Mar 13, 2010, 3:01:24 PM
    Author     : bbsadmin
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script type="text/javascript" src="js/strz.js"></script>
<script type="text/javascript" language="javaScript">

    function checksD(checkAllState, idStr)
    {
        // alert("fun called idStr="+idStr);
        var separator = "|";

        var tokenizer = new StringTokenizer (idStr, separator);

        while (tokenizer.hasMoreTokens())
        {
            if(checkAllState=="showPAc"){

                showPAc(tokenizer.nextToken());
            } else {
                showPDe(tokenizer.nextToken());
            }

        }

        /*      for(var j=0; j<intarr.length ; j++)
            {
                alert(intarr[j]);
            }
      /  elements  = document.getElementsByName('cat');
        alert("elements.length="+elements.length);

        for (i = 0; i < elements.length; i++)
        {
            if(elements[i].value == cbGroups)
            {

                elements[i].checked = checkAllState.checked;
            }

        }*/

    }

    function reCheck(curStatus,mainCatId,idStr)
    {
        var separator = "|";
        var i=0;
        var tokenizer = new StringTokenizer (idStr, separator);
        // alert(mainCatId);
        // alert(idStr);
        // alert("No. of tokens="+tokenizer.countTokens());
        if(curStatus.checked == true)
        {

            document.getElementById(mainCatId).checked = true;

        }
        else
        {

            while (tokenizer.hasMoreTokens())
            {

                if(document.getElementById(tokenizer.nextToken()).checked==curStatus.checked)
                {

                    i++;//alert("i="+i);
                }

            }
            if(i == tokenizer.countTokens())
            {
                //  alert("inside");
                document.getElementById(mainCatId).checked=curStatus.checked;
            }
        }
    }
    function toggle_s(itemID,img)
    {

        if((document.getElementById(itemID).style.display == 'none'))
        {

            document.getElementById(itemID).style.display = 'inline';
            document.getElementById(img).src='images/minus.png';

        }
        else
        {
            document.getElementById(itemID).style.display = 'none';
            document.getElementById(img).src='images/plus.png';
        }
    }
    function showMAc(dvId){
        showPAc(dvId);
        var tmp=document.getElementById("tmp"+dvId).value;
        checksD('showPAc',tmp);
    }
    function showMDe(dvId){
        showPDe(dvId);
        var tmp=document.getElementById("tmp"+dvId).value;
        checksD('showPDe',tmp);
    }
    function showAc(dvId){
        showPAc(dvId);
        var tmp=document.getElementById("tmp2"+dvId).value;
        checksD('showPAc',tmp);
    }
    function showDe(dvId){
        showPDe(dvId);
        var tmp=document.getElementById("tmp2"+dvId).value;
        checksD('showPDe',tmp);
    }
    function showPAc(dvId){
        document.getElementById("D"+dvId).style.display="none";
        document.getElementById("I"+dvId).setAttribute("value", dvId.toString().substr(4)+"^1");
        document.getElementById("A"+dvId).style.display="inline";
    }
    function showPDe(dvId){
        document.getElementById("A"+dvId).style.display="none";
        document.getElementById("I"+dvId).setAttribute("value", dvId.toString().substr(4)+"^0");
        document.getElementById("D"+dvId).style.display="inline";
    }
    function showWAc(dvId){
        showPAc(dvId);
        var tmp=document.getElementById("tmpW"+dvId).value;
        checksD('showPAc',tmp);
    }
    function showWDe(dvId){
        showPDe(dvId);
        var tmp=document.getElementById("tmpW"+dvId).value;
        checksD('showPDe',tmp);
    }
</script>
<c:if test="${webshopCategories!=null}">
    <div   style="clear:both;width:720px;">
        <div class="pt" style=""><div class="pb"><div class="pl"><div class="pr"><div class="pbl"><div class="pbr"><div class="ptl"><div class="ptr">
                                        <table align="center"><td><div style="height:500px;width:720px;">
                                                    
                                                    <form action="defineWS.do" method="post" name="defineweb" onsubmit="return validatMe(this)">
                                                        <div style="font-size:12px;padding-top:40px">
                                                            <div id="AWImg${wi}" style="display:none"><img src="bbsimages/YellowBulb.png" height="15px" width="10px" alt="Active" onclick="showWDe('WImg${wi}')"></div>
                                                            <div id="DWImg${wi}" style="display:none"><img src="bbsimages/gBulb.png" height="15px" width="10px" alt="Inactive" onclick="showWAc('WImg${wi}')"></div>
                                                            <input type="hidden" name="wsst" value="${wi}^${ws}" id="IWImg${wi}"/>
                                                            <c:if test="${ws==1||ws==5}">
                                                                <script type="text/javascript">document.getElementById('AWImg${wi}').style.display="inline";</script>
                                                            </c:if>
                                                            <c:if test="${ws==0}">
                                                                <script type="text/javascript">document.getElementById('DWImg${wi}').style.display="inline"</script>
                                                            </c:if>
                                                            Webshop&nbsp;&nbsp; <b>${wn}</b>
                                                        </div>
                                                        <div class="fv11" style="width:720px;float:left;height:10px;"></div>
                                                        <div class="fv11" style="width:720px;float:left;">
                                                            <c:set var="tmpW" value=""/>
                                                            <%--<c:if test="${catList != null}" >--%>
                                                                <%--<c:forEach items="${catList}" var="category" >--%>
                                                                    <c:forEach items="${webshopCategories}" var="wsCategory" >
                                                                        <c:if test="${wsCategory.parentId == 0}">
                                                                            <c:set var="tmpW" value="${tmpW}CImg${wsCategory.id}|"/>
                                                                            <div align="left" style="font-family:verdana;font-size:11px;padding-left:25px;padding-top:10px;">
                                                                                <c:set var="s">sub<c:out value="${wsCategory.catId}" /></c:set>
                                                                                <c:set var="i">img<c:out value="${wsCategory.catId}" /></c:set>
                                                                                <img id="${i}" src="images/plus.png" onclick="toggle_s('${s}','${i}')"/>
                                                                                <c:set var="tmp" value=""/>

                                                                                &nbsp;
                                                                                <div id="ACImg${wsCategory.id}" style="display:none"><img src="bbsimages/YellowBulb.png" height="15px" width="10px" alt="Active" onclick="showMDe('CImg${wsCategory.id}')"></div>
                                                                                <div id="DCImg${wsCategory.id}" style="display:none"><img src="bbsimages/gBulb.png" height="15px" width="10px" alt="Inactive" onclick="showMAc('CImg${wsCategory.id}')"></div>
                                                                                <input type="hidden" name="catgs" value="${wsCategory.id}^${wsCategory.status}" id="ICImg${wsCategory.id}"/>
                                                                                <c:if test="${wsCategory.status==1}">
                                                                                    <script type="text/javascript">document.getElementById('ACImg${wsCategory.id}').style.display="inline"</script>
                                                                                </c:if>
                                                                                <c:if test="${wsCategory.status==0}">
                                                                                    <script type="text/javascript">document.getElementById('DCImg${wsCategory.id}').style.display="inline"</script>
                                                                                </c:if>
                                                                                <a  title="<c:out value="${wsCategory.name}" escapeXml="false"/>" href="javascript:return false" style="text-decoration:none;color:#222222;padding-left:5px" onclick="toggle_s('${s}','${i}')"  >
                                                                                <c:out value="${wsCategory.name}" escapeXml="false"/> </a>
                                                                            </div>
                                                                            <div align="left" id="${s}" style="font-family:verdana;font-size:11px;display:none;">
                                                                                <%--<c:forEach items="${catList}" var="cat">--%>
                                                                                    <c:forEach items="${webshopCategories}" var="wsCat" >
                                                                                        <c:if test="${wsCat.parentId!=0 && wsCategory.catId==wsCat.parentId&&wsCat.status!=2}">
                                                                                            <c:set var="tmpW" value="${tmpW}CImg${wsCat.id}|" />
                                                                                            <c:set var="tmp" value="${tmp}CImg${wsCat.id}|" />
                                                                                            <c:set var="tmp2" value=""/>
                                                                                            <div style="padding-left:40px;padding-top:3px">
                                                                                                <img src="images/arrow.gif" style="padding-right:5px;border-color:#ffffff" />
                                                                                                <div id="ACImg${wsCat.id}" style="display:none"><img src="bbsimages/YellowBulb.png" height="15px" width="10px" alt="Active" onclick="showDe('CImg${wsCat.id}')"></div>
                                                                                                <div id="DCImg${wsCat.id}" style="display:none"><img src="bbsimages/gBulb.png" height="15px" width="10px" alt="Inactive" onclick="showAc('CImg${wsCat.id}')"></div>
                                                                                                <input type="hidden" name="catgs" value="${wsCat.id}^${wsCat.status}" id="ICImg${wsCat.id}"/>
                                                                                                <c:if test="${wsCat.status==1}">
                                                                                                    <script type="text/javascript">document.getElementById('ACImg${wsCat.id}').style.display="inline"</script>
                                                                                                </c:if>
                                                                                                <c:if test="${wsCat.status==0}">
                                                                                                    <script type="text/javascript">document.getElementById('DCImg${wsCat.id}').style.display="inline"</script>
                                                                                                </c:if>
                                                                                                <c:out value="${wsCat.name}" escapeXml="false"/><a href="productAssigner.do?subcat=${wsCat.name}@${wsCat.id}&wi=${wi}&wn=${wn}&ws=${ws}"><img src="bbsimages/buttons/AssignProduct.png" border="0" style="margin-left:40px" height="20px"></a>
                                                                                                <br>
                                                                                                <%--<c:forEach items="${prodList}" var="prd">--%>
                                                                                                    <c:forEach items="${webshopProducts}" var="wsPrd" >
                                                                                                        <c:if test="${wsPrd.catId==wsCat.id}">
                                                                                                            <c:set var="tmpW" value="${tmpW}PImg${wsPrd.id}|" />
                                                                                                            <c:set var="tmp" value="${tmp}PImg${wsPrd.id}|" />
                                                                                                            <c:set var="tmp2" value="${tmp2}PImg${wsPrd.id}|" />
                                                                                                            <div style="padding-left:50px;padding-top:3px">
                                                                                                                <div id="APImg${wsPrd.id}" style="display:none"><img src="bbsimages/YellowBulb.png" height="15px" width="10px" alt="Active" onclick="showPDe('PImg${wsPrd.id}')"></div>
                                                                                                                <div id="DPImg${wsPrd.id}" style="display:none"><img src="bbsimages/gBulb.png" height="15px" width="10px" alt="Inactive" onclick="showPAc('PImg${wsPrd.id}')"></div>
                                                                                                                <input type="hidden" name="pdcts" value="${wsPrd.id}^${wsPrd.status}" id="IPImg${wsPrd.id}">
                                                                                                                <c:if test="${wsPrd.status==1}">
                                                                                                                    <script type="text/javascript">document.getElementById('APImg${wsPrd.id}').style.display="inline"</script>
                                                                                                                </c:if>
                                                                                                                <c:if test="${wsPrd.status==0}">
                                                                                                                    <script type="text/javascript">document.getElementById('DPImg${wsPrd.id}').style.display="inline"</script>
                                                                                                                </c:if>
                                                                                                                <c:out value="${wsPrd.name}(${wsPrd.modelId})" />
                                                                                                            </div><br/>
                                                                                                        </c:if>
                                                                                                    </c:forEach>
                                                                                                <%--</c:forEach>--%>
                                                                                            </div>
                                                                                            <c:set var="tmp2" value="${tmp2}CImg${wsCat.id}|" />
                                                                                            <input type="hidden" id="tmp2CImg${wsCat.id}" value="${tmp2}">
                                                                                        </c:if>
                                                                                    </c:forEach>
                                                                                <%--</c:forEach>--%>
                                                                            </div>
                                                                            <c:set var="tmp" value="${tmp}CImg${wsCategory.id}|" />
                                                                            <input type="hidden" id="tmpCImg${wsCategory.id}" value="${tmp}">
                                                                        </c:if>
                                                                    </c:forEach>
                                                                <%--</c:forEach>--%>
                                                            <%--</c:if>--%>
                                                            <c:set var="tmpW" value="${tmpW}WImg${wi}|" />
                                                            <input type="hidden" id="tmpWWImg${wi}" value="${tmpW}">
                                                        </div>
                                                    </form>
                                                </div>
                                            </td>
                                        </table><center><a href="#"><img src="bbsimages/buttons/SaveChanges.png" onclick="subm()" style="border:0" alt="Save"/></a>
                                            <a href="edtWs.do"><img src="bbsimages/buttons/Cancel.png" style="border:0"alt="Cancel" /></a></center><br/>
                                    </div></div></div></div></div></div></div></div>
    </div>
    <script>
        function subm(){
            document.defineweb.submit();
            return true;
        }
    </script>
</c:if>