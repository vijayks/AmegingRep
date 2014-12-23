<%--
    Document   : wsCreateCategory
    Created on : Feb 24, 2010, 4:55:17 PM
    Author     : Madhuri
--%>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<script type="text/javascript">

    function validateCCE(pceForm) {
        var nm1=pceForm.catNM.value;
        var chk=false;
        if(nm1=="") {
            alert("Please Enter Category Name");
            chk=false;
        }
        else {
            chk=true;
        }
        return chk;
    }
    function showEdit(ctId) {
        var eId="edit"+ctId;
        document.getElementById(eId).style.display='inline';
    }
    function hideEdit(ctId) {
        var eId="edit"+ctId;
        document.getElementById(eId).style.display='none';
    }
    function validateCC(createCat)
    {
        // alert("g");
        var catNM=createCat.catNM.value;
        var catImg=createCat.catImg.value;
        var chk=false;
        if(catNM == "") {
            inlineMsg('catNM','Please enter the Name');
            chk=false;
        }
        else if(catImg == "") {
            inlineMsg('catImg','Please attach a image');
            chk=false;
        }
        else
        {
            chk=true;
        }
        return chk;
    }

</script>

<div class="verdana_form_postAd" style="width:720px">
        <div style="color:#3366cc;margin-top:25px;font-size:16px"><b>Categories</b></div>
            <fieldset style="margin-left:30px;margin-top:25px">
                <legend style="color:#3366cc"><b>Category Creation</b></legend>
                <center><c:if test="${exists!=null}">
                        <span style="color:red">${exists}</span></c:if></center>
                <center><c:if test="${noEx!=null}">
                        <span style="color:green">${noEx}</span></c:if></center>
                <form name="createCat" method="POST" action="createCat.do" onsubmit="return validateCC(this)" enctype="multipart/form-data" >
                    <table style="margin-left:70px;width:100%">
                        <tr>
                            <td style="width:200px">Category Name</td>
                            <td><input type="text" id="catNM" name="catNM"></td>
                        </tr>
                        <tr>
                            <td>Category Image     </td>
                            <td><input type="file" id="catImg" name="catImg"/></td>
                        </tr>
                        <tr>
                            <td>Short-Description</td>
                            <td><input id="catShrtDesc" type="text" name="catShrtDesc"/></td>
                        </tr>
                    </table><br/><input type="hidden" name="f" value="cr"/><input type="hidden" name="parentId" value="0"/>
                    <center><input type="submit" value="Create"/></center>
                </form>
            </fieldset>

          <c:if test="${catInfo!=null}">
            <fieldset style="margin-left:30px;margin-top:20px">
                <legend style="color:#3366cc"><b>List Of Categories</b></legend>
                <table style="margin-left:70px;width:100%;table-layout:fixed">
                    <tr style="color:#3366cc;">
                        <th style="text-align:left">Category Name</th>
                        <th style="text-align:center">Image</th>
                    </tr>

                    <c:forEach items="${catInfo}" var="ci">
                        <c:if test="${ci.parentId=='0'}">
                            <tr>
                                <td>${ci.name} </td>
                                <td><img src="resourceGetter?imd=${userBean.path}${ci.cImg}" height="70px" width="70px"  style="margin-left:12px"alt="Category Image"/></td>
                                <td><input type="button" value="Edit" onclick="showEdit('${ci.catId}');"></td>
                                <td><form action="deleteCat.do" onsubmit="return confirm('Are you sure to delete ?')">
                                        <input type="hidden" name="f" value="d"/>
                                        <input type="hidden" name="catId" value="${ci.catId}"/>
                                        <input type="submit" value="Delete" >
                                    </form>
                                </td>
                            </tr>
                            <tr style="display:none;" id="edit${ci.catId}"><td>

                                    <form name="editCat" action="editCat.do" method="post" onsubmit="return validateCCE(this)" enctype="multipart/form-data">
                                        <table style="width:600px;padding-bottom:20px">
                                            <tr><td>Category name</td><td><input type="text" name="catNM" value="${ci.name}"/></td></tr>
                                            <tr><td>Image</td><td><input type="file" name="catImg"/></td></tr>
                                            <tr><td></td><td><input type="submit" value="Update"/><input type="button" value="Cancel" onclick="hideEdit('${ci.catId}');" style="margin-left:20px"></td></tr>
                                        </table>
                                        <input type="hidden" name="f" value="e"/>
                                        <input type="hidden" name="parentId" value="0">
                                        <input type="hidden" name="catId" value="${ci.catId}"/>
                                        <input type="hidden" name="prevImg" value="${ci.cImg}"/>
                                    </form>

                                </td></tr>
                            </c:if>
                        </c:forEach>
                    </c:if>
            </table>
        </fieldset>
</div>