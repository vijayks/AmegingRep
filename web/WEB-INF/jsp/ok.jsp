<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<center> <c:out value='${ok}' escapeXml="false" /> </center>

<br /><br /><% request.getSession().removeAttribute("ok"); %>
<img id="finalad" src="bbsimages/finalad4.jpg" style="width:600px;height:300px;margin:5px 0 0 75px"/><br/><br/><br/>
