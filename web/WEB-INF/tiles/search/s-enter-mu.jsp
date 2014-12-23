<table>
    <tr>
        <td class="advance_search_txt">Name :&nbsp; </td>
        <td> <input type="text" class="advance_search_txt_input" style="" name="nm" value="<% if (request.getAttribute("nm") != null) {%><%= (String) request.getAttribute("nm")%><% }%>" /></td>
    </tr>
    <tr style="width:210px">
        <td class="advance_search_txt">Type of Music :&nbsp; </td>
        <td> <input type="text" class="advance_search_txt_input" style=""  name="typ" value="<% if (request.getAttribute("typ") != null) {%><%= (String) request.getAttribute("typ")%><% }%>" /></td>
    </tr>
</table>
