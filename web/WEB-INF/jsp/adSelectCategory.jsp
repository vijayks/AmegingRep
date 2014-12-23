<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<table border="0" cellpadding="2" cellspacing="3" style="border-collapse: collapse" bordercolor="#111111" width="100%" id="AutoNumber1" class="producttitle">

<tr>
<td width="100%" valign="top" class="producttitle"><b>Category:</b></td>
<td width="100%" valign="top" align="left" class="producttitle">
<form action="adSearch.do">

<select size="1" name="catId" >
    <option selected  value="0" >Select </option>
    <logic:present name="categoryList"  >

        <bean:size id="size" name="categoryList" />
        <logic:greaterThan name="size" value="0">
            <logic:iterate id="res"  name="categoryList" >

                <logic:equal name="res" property="parent" value="0">

                  <option onclick="sendReq()" value="<bean:write name="res" property="id" />"><bean:write name="res" property="name" /> </option>

                
               </logic:equal>
            </logic:iterate>
        </logic:greaterThan>
    </logic:present>


</select>
</form>
</td>

</tr>
</table>
<form action="rs.do?catId" >
    <input type="hidden" name="catId" value=<%=request.getAttribute("catId") %> />
