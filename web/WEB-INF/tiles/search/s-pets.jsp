<table>
    <tr>
        <td class="advance_search_txt">Breed :&nbsp; </td>
        <td><input type="text" class="advance_search_txt_input" style=""  name="bd" value="<% if (request.getAttribute("bd") != null) {%><%= (String) request.getAttribute("bd")%><% }%>" /></td>
    </tr>
    <tr>
        <td class="advance_search_txt">Age :&nbsp; </td>
        <td><input type="text" class="advance_search_txt_input" style=""  name="yso" value="<% if (request.getAttribute("yso") != null) {%><%= (String) request.getAttribute("yso")%><% }%>" /></td>
    </tr>
</table>
