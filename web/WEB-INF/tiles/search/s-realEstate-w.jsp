<table>
    <tr style="width:210px">
        <td class="advance_search_txt">Age of Construction :&nbsp;  </td>
        <td> <input type="text" class="advance_search_txt_input" style="" name="yso" value="<% if (request.getAttribute("yso") != null) {%><%= (String) request.getAttribute("yso")%><% }%>" /></td>
    </tr>
    <tr style="width:210px">
        <td class="advance_search_txt">Area (Per Sqft) :&nbsp; </td>
        <td> <input type="text" class="advance_search_txt_input" style="" name="are" value="<% if (request.getAttribute("are") != null) {%><%= (String) request.getAttribute("are")%><% }%>" /></td>
    </tr>
</table>
