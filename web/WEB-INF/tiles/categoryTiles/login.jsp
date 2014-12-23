<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%@page import="com.buysell.beans.UserBean" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script language="javascript">
    function checkall()
    {

        for(i=0; i<document.ad.elements.length; i++)
        {
            document.ad.elements[i].disabled=true;
        }
        document.getElementById("rButton").disabled=true;
        document.getElementById("lo").style.display = 'inline';
    }

    function uncheckallp()
    {
        for(i=0; i<document.ad.elements.length; i++)
        {

            document.ad.elements[i].disabled=false;

        }
        document.getElementById("rButton").disabled=false;
        document.getElementById("lo").style.display = 'none';

    }
    function hideTables(id)
    {
        var tbs = document.getElementById(id).getElementsByTagName("table");
        for(var i=0;i<tbs.length;i++) {
            tbs[i].style.display='none';
        }
        var dv = document.getElementById(id+'MinMax');
        dv.innerHTML="(&nbsp;+&nbsp;)";
        dv.setAttribute("onclick", "showTables('"+id+"')");
        if(id=="adDtls"){
            document.getElementById("priceJsp").style.display="none";
            document.getElementById("adImgs").style.display="none";
        }
        if(id=="addCont")
            document.getElementById("slCtgJsp").style.display="none";
    }
    function showTables(id)
    {
        var tbs = document.getElementById(id).getElementsByTagName("table");
        for(var i=0;i<tbs.length;i++) {
            tbs[i].style.display='table';
        }
        var dv = document.getElementById(id+'MinMax');
        dv.innerHTML="(&nbsp;&ndash;&nbsp;)";
        dv.setAttribute("onclick", "hideTables('"+id+"')");
        if(id=="adDtls") {
            document.getElementById("priceJsp").style.display="inline";
            document.getElementById("adImgs").style.display="inline";
        }
        if(id=="addCont")
            document.getElementById("slCtgJsp").style.display="inline";
    }
</script>

<div class="line" style="height:10px" > </div>
<logic:present name="editAdForUpdateBean" >
</logic:present>
<c:if test='${editAdForUpdateBean == null}' >
    <c:if test='${userBean != null}'>
      <br />
    </c:if>
    <c:if test='${userBean == null}'>


        <div class="tilepad">
            <div style="float:left;width:680px;text-align:left;padding-bottom:10px;">
                <label style="padding-left:100px" for="rb1">
                <input type="radio" id="rb1" name="R2" value="euser" checked onselect="checkall()" onclick="checkall()" ><span class="verdana_form_postAd"> Existing User</span></label>
                <label style="padding-left:70px" for="rb2">
                    <input type="radio" id="rb2" name="R2" value="nuser" onselect="uncheckallp()" onclick="uncheckallp()"><span class="verdana_form_postAd"> New User </span>
                </label>
            </div>
            <div id="lo"  style="float:left;width:100%;text-align:left">
                <form  method="post" action="validate.do" >
                    <input type="hidden" name="from" value="postAd" />
                    <input type="hidden" name="select3" value=0 />
                    <table class="verdana_form_postAd" align="left" cellspacing="10px">
                        <tr>
                          <td>User Name</td>
                          <td> <input class="fv11c" style="width:250px;height:18px" type="text" name="loginName" /></td>
                       </tr>
                        <tr><td style="padding-bottom:5px"></td></tr>
                        <tr>
                            <td>Password</td>
                            <td style="width:250px"> <input class="fv11c" style="width:250px;height:18px" type="password" name="pwd" /></td>
                            <td>&nbsp;&nbsp;&nbsp;&nbsp; <input align="middle" name="but" type="image" src="bbsimages/buttons/Loginw.png" onmouseover="this.src='bbsimages/buttons/Loginw_MouseOver.png';"
                                                    onmouseout="this.src='bbsimages/buttons/Loginw.png';" /></td>
                        </tr>
                    </table>
                </form>
            </div>
        </div>
        <br />
    </c:if>
</c:if>
        <jsp:include page="/WEB-INF/tiles/categoryTiles/personal.jsp"/>