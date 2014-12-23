<table>
    <tr style="width:210px">
        <td class="advance_search_txt">Vehicle Model :&nbsp; </td>
        <td> <input type="text" class="advance_search_txt_input" style=""  name="nm" value="<% if (request.getAttribute("nm") != null) {%><%= (String) request.getAttribute("nm")%><% }%>" /></td>
    </tr>
    <tr>
        <td class="advance_search_txt">Make :&nbsp; </td>
        <td> <input type="text" class="advance_search_txt_input" style=""  name="brnd" value="<% if (request.getAttribute("brnd") != null) {%><%= (String) request.getAttribute("brnd")%><% }%>" /></td>
    </tr>
    <tr style="width:210px">
        <td class="advance_search_txt">Tyre Model :&nbsp; </td>
        <td> <input type="text" class="advance_search_txt_input" style="" name="mod" value="<% if (request.getAttribute("mod") != null) {%><%= (String) request.getAttribute("mod")%><% }%>" /></td>
    </tr>
</table>
