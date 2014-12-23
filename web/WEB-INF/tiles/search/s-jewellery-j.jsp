<table>
    <tr>
        <td class="advance_search_txt">Make :&nbsp; </td>
        <td> <input type="text" class="advance_search_txt_input" style="" name="brnd" value="<% if (request.getAttribute("brnd") != null) {%><%= (String) request.getAttribute("brnd")%><% }%>" /></td>
    </tr>
    <tr style="width:210px">
        <td class="advance_search_txt">Material :&nbsp; </td>
        <td> <input type="text"  class="advance_search_txt_input" style="" name="mtr" value="<% if (request.getAttribute("mtr") != null) {%><%= (String) request.getAttribute("mtr")%><% }%>" /></td>
    </tr>    
</table>
