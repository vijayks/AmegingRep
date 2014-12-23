<table>
    <tr style="width:50%">
        <td class="advance_search_txt">Location :&nbsp;  </td>
        <td> <input type="text" class="advance_search_txt_input" style="" name="pflc" value="<% if (request.getAttribute("pflc") != null) {%><%= (String) request.getAttribute("pflc")%><% }%>" /></td>
    </tr>
    <tr style="width:210px">
        <td class="advance_search_txt" >Area (Per Sqft) :&nbsp; </td>
        <td> <input type="text" class="advance_search_txt_input" style="" name="are" value="<% if (request.getAttribute("are") != null) {%><%= (String) request.getAttribute("are")%><% }%>" /></td>
    </tr>
</table>
