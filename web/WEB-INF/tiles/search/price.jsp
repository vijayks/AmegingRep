<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<table>
    <tr style="width:50%;">
        <td class="advance_search_txt">
            Price (Rs)&nbsp;:&nbsp;
        </td>
    <td style="border:none">
        <input type="text" class="advance_search_txt_input" name="minPrc" style="" maxlength="8" onKeyPress="return numbersonly(event, false) " value="<% if (request.getAttribute("minPrc") != null) {%><%= (String) request.getAttribute("minPrc")%><% }%>"  />
        &nbsp;to&nbsp;

            <input type="text" class="advance_search_txt_input" name="maxPrc" style="" maxlength="8" onKeyPress="return numbersonly(event, false) "  value="<% if (request.getAttribute("maxPrc") != null) {%><%= (String) request.getAttribute("maxPrc")%><% }%>"   />
        </td>
    </tr>
    <tr>

        <td class="advance_search_txt" style="text-align:center">
            <input type="checkbox" style="margin-top:5px;" name="opa" <c:if test="${opa != null}" > checked </c:if> /><span>&nbsp;Only photo ads</span>
        </td>
    </tr>
</table>