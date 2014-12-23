<%@ page language="java" %>
<table class="">
    <tr style="width:210px">
        <td class="advance_search_txt">Author Name :</td>
        <td> <input type="text" class="advance_search_txt_input" name="atr" value="<% if (request.getAttribute("atr") != null) {%><%= (String) request.getAttribute("atr")%><% }%>"/> </td>
    </tr>
    <tr style="width:210px">
        <td class="advance_search_txt"> Book Name  :</td>
        <td> <input type="text"  class="advance_search_txt_input" name="nm" value="<% if (request.getAttribute("nm") != null) {%><%= (String) request.getAttribute("nm")%><% }%>"  /></td>
    </tr>

</table>
