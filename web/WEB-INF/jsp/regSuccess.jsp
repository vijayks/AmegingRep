<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<c:if test="${mobileVerified != null}">
    <div style="width:100%">
        Thank you for registering with Bharathbuysell.com.One more step you have to do to finish the registration. A mail has been sent to the email address  provided while registering at Bharathbuysell.com with Username, Password & Activation link.
        Click on the Activation link to activate your free membership and login in with your Username & Password.
        Open your gates of Bharathbuysell with a simple step as provided above

        <div style="margin:0 auto;width:500px;border:1px solid #046def">
            <c:forTokens var="token" items="${mobileVerified}" delims="|" >
                User Name:<c:out value="${token}" /> <br />
                Password : <c:out value="${token}" /> <br />
            </c:forTokens>

        </div>



        registration success & mobile confirmed
    </div>

</c:if>
<c:if test="${mobileNotVerified != null}">
    <div style="width:100%;margin:0 auto">
        Thank you for registering with Bharathbuysell.com.One more step you have to do to finish the registration. A mail has been sent to the email address  provided while registering at Bharathbuysell.com with Username, Password & Activation link.
        Click on the Activation link to activate your free membership and login in with your Username & Password.
        Open your gates of Bharathbuysell with a simple step as provided above
        <br />
        <br />
        <br />

        <c:out value="${mobileNotVerified}"  escapeXml="false"/>
        <div style="margin:0 auto;width:500px;border:1px solid #046def">
            <c:forEach var="token" items="${mobileNotVerified}" >
                User Name:<c:out value="${token}" /> <br />
                Password : <c:out value="${token}" /> <br />
            </c:forEach>

        </div>
        <br />
        <br />
        <span style='color:#ff0000'>Mobile verification not completed.</span>
        <br />
        <br />

    </div>
</c:if>