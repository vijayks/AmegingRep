<%--
    Document   : editOffer
    Created on : Dec 23, 2009, 9:34:58 AM
    Author     : bbsadmin
--%>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet" href="css/jquery-ui-1.7.2.custom.css" type="text/css" media="screen" />
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/ui.datepicker.js"></script>
<script type="text/javascript" language="javascript">
    $(function() {
        $('#datepicker1').datepicker({
            changeMonth: true,
            changeYear: true,
            minDate: '-2Y',
            maxDate: '0'
        });
    });
    $(function() {
        $('#datepicker2').datepicker({
            changeMonth: true,
            changeYear: true,
            minDate: '-2Y',
            maxDate: '0'
        });
    });
</script>
<style>
    #upoForm input[type=text] {
        width:250px;
    }
    #upoForm select {
        width:250px;
    }
</style>

<div id="masterrightbodybg" >
     <div class="pt"><div class="pb"><div class="pl"><div class="pr"><div class="pbl"><div class="pbr"><div class="ptl">
                                <div class="ptr">

                                    <div class="verdana_form_mainhead" style="width:auto;padding:20px 0 0 15px">
   <%-- <span style="padding-left:10px">--%>Edit Offer<%--</span>--%></div><br /><hr><br />
<%--<div class="tilepad">--%>
    <div style="text-align:center" class="fv12bc">

        <c:if test="${scok != null}" >
            <span style="color:#008800"><c:out value="${scok}" /></span>
        </c:if>
        <c:if test="${catError != null}" >
            <span style="color:#ff0000"><c:out value="${catError}" /></span>
        </c:if>

    </div>
    <form action="updateOffer.do"  id ="upoForm" method="post" autocomplete="off" enctype="multipart/form-data" >

        <input type="hidden" name="id" value="${sId}"/>
        <table class="verdana_form" cellpadding="2px" style="width:700px;font-weight:bold;margin-left:15px">
            <c:if test="${offerList!=null}">
                <c:forEach items="${offerList}" var="col">
            <%--<tr>
                <td>
                    Dealer Id
                </td>
                <td>
                    <input type="text" name="dealerId" />
                </td>
            </tr>--%>
            <tr>
                <td style="width:150px">Offer Type</td>
                <td>Normal Offer</td>
            </tr>
            <tr>
                <td>Offer Category<font color="red">*</font></td>
                <td> <select  name="category" >
                        <option value="0" > Select Category </option>
                        <c:forEach items="${categoryList}" var="cat">
                            <c:if test="${col.categoryId==cat.id}">
                            <option value="${cat.id}" selected>${cat.name}</option>
                            </c:if>
                            <c:if test="${cat.parent== 0}" >
                                <option value="<c:out value='${cat.id}'/>"> <c:out value='${cat.name}'  escapeXml="false"/></option>
                            </c:if>
                        </c:forEach>
                    </select>
                </td>
            </tr>
            <tr>
                <td>
                    Offer Title<font color="red">*</font>
                </td>
                <td>
                    <input type="text" name="title" value="${col.scrTitle}">
                </td>
            </tr>
            <tr>
                <td>
                    Description<font color="red">*</font>
                </td>
                <td>
                    <textarea  name="description">${col.desc}</textarea>
                </td>
            </tr>
            <tr>
                <td>Current Small Image</td>
                <td> <img src="resourceGetter?imf=${col.img1}" border="0" style="width:100px;height:75px"></td>
            </tr>
            <tr>
                <td>Small Image</td>
                <td> <input type="file" name="thumbImg"></td>
                <td><input type="hidden" name="prevThumbImg" value="${col.img1}"></td>
            </tr>
            <tr>
                <td>Current Big Image</td>
                <td> <img src="resourceGetter?imf=${col.img2}" border="0" style="width:100px;height:75px"></td>
            </tr>
            <tr>
                <td>Big Image</td>
                <td> <input type="file" name="img1" ></td>
                <td><input type="hidden" name="prevImg1" value="${col.img2}"></td>
            </tr>

            <tr>
                <td>Offer Start Date<font color="red">*</font></td>
                <td><input type="text" id="datepicker1" name="dateS" value="${col.sDate}">
                </td>

            </tr>
            <tr>
                <td>Offer Closing Date<font color="red">*</font></td>
                <td><input type="text" id="datepicker2" name="dateE" value="${col.eDate}">
                </td>
            </tr>
            <tr>

                <td>
                    List Price<font color="red">*</font>
                </td>
                <td>
                    <input type="text" name="lprice" value="${col.lprice}"/>
                </td>

            </tr>

            <tr>
                <td>Offer Price<font color="red">*</font></td>
                <td><input type="text" name="oprice" value="${col.oprice}" />
            </tr>
            <tr>
                <td>
                    Offer in city<font color="red">*</font>
                </td>
                <td>
                    <select  name="offCity"    >
                        <option value="0" > Select City </option>
                        <option value="${col.city}" selected>${col.city}</option>
                        <c:forEach items="${cities}" var="city">
                            <option value="<c:out value='${city.name}'/>"> <c:out value='${city.name}'/> </option>
                        </c:forEach>
                    </select>
                </td>
            </tr>
            <tr>
                <td></td>
                <td>
                   &nbsp;
                </td>

            </tr>
            <tr>
                <td></td>
                <td>
                    <input type="submit" value="${submitValue}"> &nbsp;&nbsp;
                </td>

            </tr>
            </c:forEach>
            </c:if>
        </table>
        <br><br>
    </form>
<%--</div>--%>
      </div></div></div></div></div></div></div></div></div>