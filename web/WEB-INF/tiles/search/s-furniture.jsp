<table>
    <tr style="width:210px;">
        <td class="advance_search_txt">Material :&nbsp; </td>
        <td> <input type="text" class="advance_search_txt_input" style=""  name="mtr" value="<% if (request.getAttribute("mtr") != null) {%><%= (String) request.getAttribute("mtr")%><% }%>" /></td>
    </tr>
    <tr>
        <td class="advance_search_txt">Model :&nbsp; </td>
        <td> <input type="text" class="advance_search_txt_input" style=""  name="mod" value="<% if (request.getAttribute("mod") != null) {%><%= (String) request.getAttribute("mod")%><% }%>" /></td>
    </tr>
    <tr>
        <td class="advance_search_txt">Color :&nbsp; </td>
        <td> <input type="text" class="advance_search_txt_input" style=""  name="clr" value="<% if (request.getAttribute("clr") != null) {%><%= (String) request.getAttribute("clr")%><% }%>" /></td>
    </tr>
</table>
