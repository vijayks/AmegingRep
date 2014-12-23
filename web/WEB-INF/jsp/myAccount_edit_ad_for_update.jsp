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


        </script>
        <style type="text/css">
            <!--
            #apDiv1 {
                position:absolute;
                left:5px;
                top:12px;
                width:784px;
                height:82px;
                z-index:1;
            }
            -->
        </style>
        <link href="images/sbStyle.css" rel="stylesheet" type="text/css" />
        <style type="text/css">
            <!--
            #apDiv2 {
                position:absolute;
                left:5px;
                top:114px;
                width:784px;
                height:91px;
                z-index:2;
            }
            #apDiv3 {
                position:absolute;
                left:5px;
                top:217px;
                width:784px;
                height:307px;
                z-index:3;
            }
            -->
        </style>
   
        <% AdsBean ab=(AdsBean)request.getAttribute("editAdForUpdateBean"); %>

        <form action="upload_update_ad.do" method="post" enctype="multipart/form-data" />


            <div >

                <table width="100%" border="0" cellspacing="2" cellpadding="2">
                    <tr>

                        <td><input type="hidden" name="adId" value="<%= ab.getAdId() %>" /></td>

                    </tr>

                    <tr>
                        <td width>AD Title</td>
                        <td><input type="text" name="adTitle" value="<%= ab.getTitle() %>" /></td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td>Ad Description</td>
                        <td><textarea rows="5" cols="50" name="description"> <%=  ab.getDescription() %> </textarea></td>
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
                        <td>  <img src="resourceGetter?imf=<%=  ab.getImage1() %>"  width="120px" height="125px" align="center" >
                        </td>

                        <td>
                            <div style="display:inline  " id="open" >
                                <a title="Edit Image" href="javascript:return false;" onclick="browseOpen('open','close')">Edit image</a>
                            </div>
                            
                                <div style="display:none " id="close" >
                                    change image:<input type="file"  name="image1" value="<%=  ab.getImage1() %>"/><br />
                                    <a title="Set Previous Image" href="javascript:return false;" onclick="browseClose('open','close')">Set previous image</a>
                                </div>
                            </td>
                    </tr>

                    
                    <tr>
                        <td>Additional Content</td>
                        <td> <textarea rows="4" cols="50" name="addtionalContent"> <%= ab.getAddtionalContent()  %> </textarea></td>
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
