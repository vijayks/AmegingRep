<table>
    <tr>
        <td class="advance_search_txt">Model :&nbsp; </td>
        <td> <input type="text" class="advance_search_txt_input" style="" name="mod" value="<% if (request.getAttribute("mod") != null) {%><%= (String) request.getAttribute("mod")%><% }%>" /></td>
    </tr>
    <tr>
        <td class="advance_search_txt">Color :&nbsp; </td>
        <td> <input type="text" class="advance_search_txt_input" style="" name="clr" value="<% if (request.getAttribute("clr") != null) {%><%= (String) request.getAttribute("clr")%><% }%>" /></td>
    </tr>
    <tr>
        <td class="advance_search_txt">Mfg. Year :&nbsp; </td>
        <td> <input type="text" class="advance_search_txt_input" style="" name="yso" value="<% if (request.getAttribute("yso") != null) {%><%= (String) request.getAttribute("yso")%><% }%>" /></td>
    </tr>
</table>
