<table>
    <tr style="width:210px">
        <td class="advance_search_txt">Company Name :&nbsp; </td>
        <td> <input type="text" class="advance_search_txt_input" style=""    name="nm" value="<% if (request.getAttribute("nm") != null) {%><%= (String) request.getAttribute("nm")%><% }%>" /></td>
    </tr>
    <tr style="width:210px">
        <td class="advance_search_txt">Product Name :&nbsp; </td>
        <td> <input type="text" class="advance_search_txt_input" style=""    name="brnd" value="<% if (request.getAttribute("brnd") != null) {%><%= (String) request.getAttribute("brnd")%><% }%>" /></td>
    </tr>
</table>
