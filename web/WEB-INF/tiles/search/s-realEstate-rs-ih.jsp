<table>
     <tr style="width:210px">
        <td class="advance_search_txt">Area (Per Sqft) :&nbsp; </td>
        <td> <input type="text" class="advance_search_txt_input" style="" name="are" value="<% if (request.getAttribute("are") != null) {%><%= (String) request.getAttribute("are")%><% }%>" /></td>
    </tr>
    <tr>
        <td class="advance_search_txt">Bedrooms :&nbsp; </td>
        <td> <input type="text" class="advance_search_txt_input" style="" name="nbr" value="<% if (request.getAttribute("nbr") != null) {%><%= (String) request.getAttribute("nbr")%><% }%>" /></td>
    </tr>
    <tr>
        <td class="advance_search_txt">Facing :&nbsp; </td>
        <td> <input type="text" class="advance_search_txt_input" style="" name="fc" value="<% if (request.getAttribute("fc") != null) {%><%= (String) request.getAttribute("fc")%><% }%>" /></td>
    </tr>
</table>
