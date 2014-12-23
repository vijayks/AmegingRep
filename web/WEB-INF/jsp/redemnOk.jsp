<script>
    function closeAndRefresh()
  {
        opener.location.reload(true);
     self.close();
  }


</script>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:if test="${AlertNotSave != null}" >
    <span style="color:red">Alert not saved maximum limit reached (Max 10). </span>
</c:if>
<c:if test="${AlertNotSave == null}" >
   <span style="color:green">You successfully saved your Alert !</span>
</c:if>

<br/><br/><center><input type="button" value="Close Me" onClick="closeAndRefresh();"/></center>