<table>
    <tr>
        <td class="advance_search_txt">Object :&nbsp; </td>
        <td><input type="text" class="advance_search_txt_input" style="" name="obj" value="<% if (request.getAttribute("obj") != null) {%><%= (String) request.getAttribute("obj")%><% }%>" /></td>
    </tr>
    <tr>
        <td class="advance_search_txt">Year/Era :&nbsp; </td>
        <td><input type="text" class="advance_search_txt_input" style="" name="yso" value="<% if (request.getAttribute("yso") != null) {%><%= (String) request.getAttribute("yso")%><% }%>" /></td>
    </tr>
</table>
