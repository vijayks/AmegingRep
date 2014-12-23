<%--
    Document   : wsSubCategoryCreation
    Created on : Feb 24, 2010, 7:41:02 PM
    Author     : sujith
--%>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script type="text/javascript">
    function validateWSC(SubCat)
    {
        var parId=SubCat.parentId.value;
        var catNM=SubCat.catNM.value;
        var chk=false;
        if(parId==0){
            inlineMsg('NM','Please select a Main Category');
            chk=false;
        }
        else if(catNM == "") {
            inlineMsg('catNM','Please enter the SubCategory Name');
            chk=false;
        }
        else
        {
            chk=true;
        }
        return chk;
    }
    function validateWSC1(editCat)
    {
        var catNM=editCat.catNM.value;

        var chk=false;

        if(catNM == "") {
            alert('Please enter the SubCategory Name');
            chk=false;
        }
        else
        {
            chk=true;
        }
        return chk;
    }
    function showEdit(csId) {
        var eId="edit"+csId;
        document.getElementById(eId).style.display='inline';
    }
    function hideEdit(csId) {
        var eId="edit"+csId;
        document.getElementById(eId).style.display='none';
    }
</script>

<div class="verdana_form_postAd" style="width:720px">
        <div style="color:#3366cc;margin-top:25px;font-size:16px"><b>Sub Categories</b></div>
            <fieldset style="margin-left:30px;margin-top:25px">
                <legend style="color:#3366cc">
                    <b>Sub Category Creation</b></legend>
                <center><c:if test="${exists!=null}">
                        <span style="color:red">${exists}</span></c:if></center>
                <center><c:if test="${noEx!=null}">
                        <span style="color:green">${noEx}</span></c:if></center>
              <form action="wsCreateSubCategory.do" method="POST" name="SubCat" onsubmit="return validateWSC(this);">
              <table  style="margin-left:70px;width:100%">
                    <tr>
                        <td style="width:200px">Main Category</td>
                        <td><select id="NM" name="parentId" style="width:180px"><option value="0">Select Category</option>
                                <c:if test="${catInfo!=null}">
                                    <c:forEach items="${catInfo}" var="ci">
                                        <c:if test="${ci.parentId=='0'}">
                                            <option value="${ci.catId}">${ci.name}</option>
                                        </c:if>
                                    </c:forEach>
                                </c:if></select></td>
                    </tr>
                    <tr>
                        <td>SubCategory Name</td>
                        <td><input style=""type="text" id="catNM" name="catNM"><input type="hidden" name="f" value="cr"/></td>
                    </tr>
                    <tr>
                        <td>Short Description</td>
                        <td><input id="catShrtDesc" type="text" name="catShrtDesc"/></td>
                    </tr>
                </table><br>
                <center><input type="submit" value="Create" ></center>
                    </form>
            </fieldset>
                           <c:if test="${catInfo!=null}">
     <fieldset style="margin-left:30px;margin-top:20px">
                <legend style="color:#3366cc"><b>List Of Sub Categories</b></legend>
                <table style="margin-left:70px;width:100%;table-layout:fixed">
                    <tr style="color:#3366cc;text-align:left">
                        <th>Main Category</th>
                        <th>SubCategory</th>
                    </tr>
                        <c:forEach items="${catInfo}" var="ci">
                            <c:if test="${ci.parentId!='0'}">
                                <c:set var="parId" value="${ci.parentId}"/>
                                <tr>
                                    <td>
                                    <c:forEach items="${catInfo}" var="cii">
                                        <c:if test="${cii.catId==parId}">
                                            ${cii.name}
                                        </c:if>
                                    </c:forEach>
                                    </td>
                                    <td>${ci.name}</td>
                                    <td><input type="button" value="Edit" onclick="showEdit('${ci.catId}');"></td>
                                    <td><form action="deleteSubCat.do" onsubmit="return confirm('Are you sure to delete ?')">
                                        <input type="hidden" name="f" value="d"/>
                                        <input type="hidden" name="catId" value="${ci.catId}"/>
                                        <input type="submit" value="Delete" >
                                    </form>
                                    </td>
                                </tr>
                            <tr style="display:none;" id="edit${ci.catId}"><td><%----%>

                                    <form name="editCat" action="editSubCat.do" method="post" enctype="multipart/form-data" onsubmit="return validateWSC1(this)">
                                        <table style="width:600px;padding-bottom:20px">
                                            <tr><td>Main Category</td><td><select name="parentId">
                                            <c:forEach items="${catInfo}" var="cii">
                                                <c:if test="${cii.catId==parId}">
                                                    <option value="${cii.catId}" selected>${cii.name}</option>
                                                </c:if>
                                            </c:forEach>
                                            <c:forEach items="${catInfo}" var="cii">
                                                <c:if test="${cii.parentId=='0'}">
                                                    <option value="${cii.catId}">${cii.name}</option>
                                                </c:if>
                                            </c:forEach>
                                                                     </select></td></tr>
                                            <tr><td>Sub Category name</td><td><input type="text" name="catNM" value="${ci.name}"/></td></tr>
                                            <tr><td></td><td><input type="submit" value="Update"/><input type="button" value="Cancel" onclick="hideEdit('${ci.catId}');" style="margin-left:20px"></td></tr>
                                        </table>
                                        <input type="hidden" name="f" value="e"/>
                                        <input type="hidden" name="catId" value="${ci.catId}"/>
                                    </form>

                                </td></tr>
                            </c:if>
                        </c:forEach>

                    </c:if>
                </table>
            </fieldset>
</div>