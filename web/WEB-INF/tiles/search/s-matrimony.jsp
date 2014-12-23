<table>
    <tr>
        <td class="advance_search_txt">Age :&nbsp; </td>
        <td> <input type="text" class="advance_search_txt_input" style=""  name="yso" value="<% if (request.getAttribute("yso") != null) {%><%= (String) request.getAttribute("yso")%><% }%>" /></td>
    </tr>
    <tr style="width:210px">
        <td class="advance_search_txt">Religion :&nbsp; </td>
        <td> <input type="text" class="advance_search_txt_input" style=""  name="typ" value="<% if (request.getAttribute("typ") != null) {%><%= (String) request.getAttribute("typ")%><% }%>" /></td>
    </tr>
</table>
