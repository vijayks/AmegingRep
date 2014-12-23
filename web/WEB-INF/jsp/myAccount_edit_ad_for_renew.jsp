<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page  import="com.buysell.beans.AdsBean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>

<script>

    function browseOpen(open,close)
    {
        document.getElementById(open).style.display = 'none';

        document.getElementById(close).style.display = 'inline';
    }
    function browseClose(open,close)
    {
        document.getElementById(open).style.display = 'inline';

        document.getElementById(close).style.display = 'none';


    }

    function deleteImage(del,img,removed)
    {
        document.getElementById(del).style.display = 'none';
        document.getElementById(img).style.display = 'none';
        document.getElementById(removed).style.display = 'inline';

        oFormObject = document.forms[1];
        oFormElement = oFormObject.elements["imageRemoved"];
        oFormObject.elements["imageRemoved"].value = '1';
        alert(oFormObject.elements["imageRemoved"].value);
    }

</script>



<% AdsBean ab = (AdsBean) request.getAttribute("editAdForRenewBean");%>

<form action="upload_renew_ad.do" method="post" name="renewAds" enctype="multipart/form-data">
       <div id="masterrightbodybg" >

        <table width="100%" border="0" cellspacing="2" cellpadding="2">
            <tr>

                <td><input type="hidden" name="adId" value="<%= ab.getAdId()%>" />
                    <input type="hidden" name="imageRemoved"  />
                </td>

            </tr>
            <tr>
                <td width>AD Title</td>
                <td><input type="text" name="adTitle" value=" <%= ab.getTitle()%>" /></td>
                <td> &nbsp; </td>
            </tr>
            <tr>
                <td>Ad Description</td>
                <td> <textarea rows="5" cols="50" name="description"> <%=  ab.getDescription()%> </textarea></td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td>Country</td>
                <td><select name=""><option> select </option></select></td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td>State </td>
                <td><select name=""><option> select </option></select></td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td>City</td>
                <td><select name=""><option> select </option></select></td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td>Locality</td>
                <td><select name=""><option> select </option></select></td>
                <td></td>
            </tr>


<tr>
  <td> Image </td>
    <td>
 <div style="display:inline  " id="img" >
            <img src="resourceGetter?imf=<%=  ab.getImage1()%>"  width="120px" height="125px" align="center" >
        </div>
 <div style="display:none  " id="removed" >

            Successfully your image is deleted
        </div>
    </td>
 <td align="left">
  <div style="display:inline  " id="open" >
      <a title="Edit Images" href="#" onclick="browseOpen('open','close')">Edit image</a>
                    </div>
 <div style="display:none " id="close" >
                        change image:<input type="file" name="image1" /><br />
                        <a title="Set Previous Image" href="#" onclick="browseClose('open','close')">Set previous image</a>
                    </div><br>


                    <div style="display:inline  " id="del" >
                        <a title="Delete Images" href="#" onclick="deleteImage('del','img','removed')">Delete image</a>
                    </div>

                </td>
            </tr>
 <tr>
                <td>Additional Content</td>
                <td> <textarea rows="4" cols="50" name="addtionalContent"> <%= ab.getAddtionalContent()%> </textarea></td>
            </tr>
            <tr>
                <td>Email </td>
                <td><input type="text" name="" /></td>
            </tr>
            <tr>
                <td>Phone Number:</td>
                <td><input type="text"  /> </td>
            </tr>
            <tr>
                <td></td>
                <td><input type="image" name="submit" src="images/button.jpg" /></td>
            </tr>
        </table>
</div>
</form>
