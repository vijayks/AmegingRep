<table>
    <tr>
        <td class="advance_search_txt">Name :&nbsp; </td>
        <td><input type="text" class="advance_search_txt_input" style="" name="nm" value="<% if (request.getAttribute("nm") != null) {%><%= (String) request.getAttribute("nm")%><% }%>" /></td>
    </tr>
    <tr style="width:210px">
        <td class="advance_search_txt">Interest Rate :&nbsp; </td>
        <td><input type="text" class="advance_search_txt_input" style="" name="kmr" value="<% if (request.getAttribute("kmr") != null) {%><%= (String) request.getAttribute("kmr")%><% }%>" /></td>
    </tr>
</table>
