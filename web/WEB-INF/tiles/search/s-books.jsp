<table>
    <tr>
        <td class="advance_search_txt">Title :&nbsp; </td>
        <td> <input type="text" class="advance_search_txt_input" style="" name="nm" value="<% if (request.getAttribute("nm") != null) {%><%= (String) request.getAttribute("nm")%><% }%>" /></td>
    </tr>
    <tr>
        <td class="advance_search_txt">Author :&nbsp; </td>
        <td> <input type="text"class="advance_search_txt_input" style=""  name="ath" value="<% if (request.getAttribute("ath") != null) {%><%= (String) request.getAttribute("ath")%><% }%>" /></td>
    </tr>
    <tr style="width:210px">
        <td class="advance_search_txt">Publications :&nbsp; </td>
        <td> <input type="text" class="advance_search_txt_input" style=""  name="pub" value="<% if (request.getAttribute("pub") != null) {%><%= (String) request.getAttribute("pub")%><% }%>" /></td>
    </tr>
</table>
