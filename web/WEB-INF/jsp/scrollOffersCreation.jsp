<%--
    Document   : scrOffCreation
    Created on : Aug 2, 2009, 6:40:46 PM
    Author     : bbsadmin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
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
            maxDate: '+1Y'
        });
    });
    $(function() {
        $('#datepicker2').datepicker({
            changeMonth: true,
            changeYear: true,
            minDate: '-2Y',
            maxDate: '+1Y'
        });
    });
</script>
<style>
    #scoForm input[type=text]{
        width:250px
    }
    #scoForm select{
        width:250px
    }
</style>

<div id="masterrightbodybg" >
    <div class="pt"><div class="pb"><div class="pl"><div class="pr"><div class="pbl"><div class="pbr"><div class="ptl">
                                <div class="ptr">

                                    <div class="verdana_form_mainhead" style="width:auto;padding:20px 0 0 15px">Offers Creation</div><br /><hr><br />

    <div style="text-align:center" class="fv12bc">

        <c:if test="${scok != null}" >
            <span style="color:#008800"><c:out value="${scok}" /></span>
        </c:if>
        <c:if test="${catError != null}" >
            <span style="color:#ff0000"><c:out value="${catError}" /></span>
        </c:if>

    </div>
    <form action="scoUpload.do" id="scoForm" method="post" autocomplete="off" enctype="multipart/form-data" >

        <table class="verdana_form" style="width:700px;font-weight:bold;margin-left:15px" >
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
                <td>Normal Offer<input type="hidden" name="offType" value="Normal"/></td>
            </tr>
            <tr>
                <td>Offer Category<font color="red">*</font></td>
                <td> <select  name="category" >
                        <option value="0" > Select Category </option>
                        <c:forEach items="${categoryList}" var="cat">
                            <c:if test="${cat.parent== 0}" >
                                <option value="<c:out value='${cat.id}'/>"> <c:out value='${cat.name}'  escapeXml="false"/> </option>
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
                    <input type="text" name="title" >
                </td>
            </tr>
            <tr>
                <td>
                    Description<font color="red">*</font>
                </td>
                <td>
                    <textarea  name="description"></textarea>
                </td>
            </tr>
            <tr>
                <td>Small Image<font color="red">*</font></td>
                <td> <input type="file" name="thumbImg"></td>
            </tr>
            <tr>
                <td>Big Image<font color="red">*</font></td>
                <td> <input type="file" name="img1" ></td>
            </tr>

            <tr>
                <td>Offer Start Date<font color="red">*</font></td>
                <td><input type="text" id="datepicker1" name="dateS">
                </td>

            </tr>
            <tr>
                <td>Offer Closing Date<font color="red">*</font></td>
                <td><input type="text" id="datepicker2" name="dateE">
                </td>
            </tr>
            <tr>

                <td>
                    List Price<font color="red">*</font>
                </td>
                <td>
                    <input type="text" name="lprice" />
                </td>

            </tr>

            <tr>
                <td>Offer Price<font color="red">*</font></td>
                <td><input type="text" name="oprice" />
            </tr>
            <tr>
                <td>
                    Offer in city<font color="red">*</font>
                </td>
                <td>
                    <select  name="offCity"    >
                        <option value="0" > Select City </option>
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
                    <input type="submit" value="Create Offer"> &nbsp;&nbsp;
                    <input type="reset" value="Clear"/>
                </td>

            </tr>

        </table>
            <br><br>
    </form>
</div></div></div></div></div></div></div></div></div>