<%-- 
    Document   : s-realEstate-pgr
    Created on : Dec 11, 2009, 2:44:03 PM
    Author     : bbsadmin
--%>

<table>
    <tr>
        <td class="advance_search_txt">Gender :&nbsp; </td>
        <td> <input type="text" class="advance_search_txt_input" style="" name="brnd" value="<% if (request.getAttribute("brnd") != null) {%><%= (String) request.getAttribute("brnd")%><% }%>" /></td>
    </tr>
    <tr style="width:230px">
        <td class="advance_search_txt">Room Type(No. of Sharings) :&nbsp; </td>
        <td> <input type="text" class="advance_search_txt_input" style="" name="mod" value="<% if (request.getAttribute("mod") != null) {%><%= (String) request.getAttribute("mod")%><% }%>" /></td>
    </tr>
</table>

