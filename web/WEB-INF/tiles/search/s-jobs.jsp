<table>
   <tr style="width:210px">
        <td class="advance_search_txt">Qualification :&nbsp; </td>
        <td> <input type="text" class="advance_search_txt_input" style=""  name="qlf" value="<% if (request.getAttribute("qlf") != null) {%><%= (String) request.getAttribute("qlf")%><% }%>" /></td>
    </tr>
    <tr style="width:210px">
        <td class="advance_search_txt">Salary :&nbsp; </td>
        <td> <input type="text" class="advance_search_txt_input" style=""  name="kmr" value="<% if (request.getAttribute("kmr") != null) {%><%= (String) request.getAttribute("kmr")%><% }%>" /></td>
    </tr>
</table>
