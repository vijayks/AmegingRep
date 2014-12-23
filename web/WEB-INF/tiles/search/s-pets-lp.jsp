<table>
    <tr>
        <td class="advance_search_txt">Pet Type :&nbsp; </td>
        <td> <input type="text" class="advance_search_txt_input" style="" name="typ" value="<% if (request.getAttribute("typ") != null) {%><%= (String) request.getAttribute("typ")%><% }%>" /></td>
    </tr>
    <tr>
        <td class="advance_search_txt">Pet Name :&nbsp; </td>
        <td> <input type="text" class="advance_search_txt_input" style=""  name="nm" value="<% if (request.getAttribute("nm") != null) {%><%= (String) request.getAttribute("nm")%><% }%>" /></td>
    </tr>
    <tr>
        <td class="advance_search_txt">Lost Date :&nbsp; </td>
        <td> <input type="text" class="advance_search_txt_input" style="" name="brnd" value="<% if (request.getAttribute("brnd") != null) {%><%= (String) request.getAttribute("brnd")%><% }%>" /></td>
    </tr>
</table>
