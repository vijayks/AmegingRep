<table>
    <tr style="width:210px">
        <td class="advance_search_txt">Area (Per Sqft) :&nbsp; </td>
        <td> <input type="text" class="advance_search_txt_input"  style="" name="are" value="<% if (request.getAttribute("are") != null) {%><%= (String) request.getAttribute("are")%><% }%>" /></td>
    </tr>
    <tr style="width:210px">
        <td class="advance_search_txt">Total No. of Floors :&nbsp; </td>
        <td> <input type="text" class="advance_search_txt_input"  style="" name="tfl" value="<% if (request.getAttribute("tfl") != null) {%><%= (String) request.getAttribute("tfl")%><% }%>" /></td>
    </tr>
    <tr style="width:210px">
        <td class="advance_search_txt">Furnished :&nbsp; </td>
        <td> <input type="text" class="advance_search_txt_input" style="" name="fnd" value="<% if (request.getAttribute("fnd") != null) {%><%= (String) request.getAttribute("fnd")%><% }%>" /></td>
    </tr>
</table>
