<%--
    Document   : city
    Created on : May 3, 2009, 5:46:15 PM
    Author     : bbsadmin
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<html>
    <head>
        <meta name="verify-v1" content="PwZKjgUkv/eSDfv+Uy0B+3cq/8kRGNuDOWAJpSWyHSw=" />
        <meta name="google-site-verification" content="otOLqBKAgj_fgOlHw-rn8uqTr2q5IzwwTZi4KaNZoDE" />
        <title> Bharatbuysell.com | Search and Post Free Classified Ads in India</title>
        <meta name="description" content=" Bharatbuysell.com  , Free online classified ads. Find  Buyers and sellers for  flats, apartments, Properties, houses, PG, jobs, IT jobs, BPO jobs, cars, used cars, used bikes, mobiles, computers, packers and movers in India, travel  packages India." />
       <meta name="keywords" content="Free Classifieds, buy and sell, buysell, free india classified, online car classifieds, pre owned cars,	commercial property for rent, commercial properties for sale,	residential property for sale, property for sale, Used bikes, residential property for rent, electronic items, used laptops india, furniture sale, interior designers, livingroom furniture, modular kitchen, furniture in bangalore, used refrigerators, packers and movers, home appliances for sale, electric home appliances, home appliances, electronic appliances, second hand car, second hand bike." />
        <script type="text/javascript" src="js/alljs.js"></script>
        <link rel="shortcut Icon" href="bbsimages/favicon.ico" />
        <style type="text/css">
            <!--

            #city
            {
                font-family:Arial;
                color:#ffffff;
                /* font-weight:bold; */

                margin:0 auto;
                width:750px;
            }
            #city a
            {
                text-decoration:none;
                font-size:11px;
                color:#ffffff;
            }
            #city a:hover
            {

                text-decoration:underline;
                font-size:11px;
                color:orange;


            }
            -->
        </style>
        <script type="text/javascript">
            function callTbClose(ctname,pth){
                self.parent.tb_remove();
                createCookie('si',ctname,1);
                top.location=pth;
            }
            function createCookie(name,value,days) {
                    if (days) {
                            var date = new Date();
                            date.setTime(date.getTime()+(days*24*60*60*1000));
                            var expires = "; expires="+date.toGMTString();
                    }
                    else var expires = "";
                    document.cookie = name+"="+value+expires+"; path=/";
            }
        </script>
    </head>
    <body>
        <div id="city" ><%--<br />--%>
            <%--<table>
                <tr>
                    <td style="width:750px;" ><img src="bbsimages/cityPageLogo.gif" style="width:150px;height:80px;margin-left:-3px;" /></td>
                    <td style="width:250px;color:#666666;text-align:right;vertical-align:bottom">
                        <span style="font-size:13px;font-weight:bold;">Buysell &nbsp;&nbsp;</span>
                        <a title="Browse across Globe" href="globalHome.jsp" style="vertical-align:bottom"><img src="bbsimages/buttonGlobalHome.gif" style="border:0;width:85px;height:17px;" alt="Global Home" ></a>
                    </td>
                </tr>
            </table>--%>


           <%-- <div style="background-image:url(bbsimages/cityBar.gif);width:600px;height:30px;clear:both">
                <div style="padding:5px 0 0 25px;font-size:13px;font-weight:bold"> Welcome to Bharatbuysell, the Indian E-shop for best and Geniune deals.</div>
            </div>--%>

            <div style="background-image:url(bbsimages/cityPage_bg.jpg);width:750px;height:372px">
            <%--<div style="background-color:#4D9EDF;width:600px;height:350px">--%>
                <br />
                
                <span style="padding-left:25px;font-size:13px;color:#CCC"><u> Popular Cities</u> </span>
                <div style="height:2px"></div>
                <c:if test="${cities!=null }" >
                    <div id="c12" style="padding-left:10px;text-align:left;float:left;width:100px;">
                        <ul style="list-style: none;">
                            <c:forEach items="${cities}" var="city" begin="0" end="11" >
                                <li style="width:90px">
                                    <a title="<c:out value="${city.name}" /> Classifieds" style="" href="tile1.do?start=0&range=10&byO=1&city=<c:out value="${city.name}" />&state=<c:out value="${city.state}" />&country=<c:out value="${city.country}" />"  onclick="callTbClose('${city.name}','tile1.do?start=0&range=10&byO=1&city=<c:out value="${city.name}" />&state=<c:out value="${city.state}" />&country=<c:out value="${city.country}" />');">
                                        <c:choose>
                                            <c:when test="${city.name=='Bangalore'||city.name=='Chennai'||city.name=='Hyderabad'||city.name=='Delhi'||city.name=='Ahmedabad'}"><span style="color:yellow;"><c:out value="${city.name}" /></span></c:when>
                                            <c:otherwise><c:out value="${city.name}" /></c:otherwise>
                                        </c:choose>
                                    </a>
                                </li>
                            </c:forEach>

                        </ul>
                    </div>
                    <div id="c24" style="padding-left:25px;text-align:left;float:left;width:100px;">
                        <ul style="list-style: none;">
                            <c:forEach items="${cities}" var="city" begin="12" end="23" >
                                <li style="width:90px">
                                    <a title="<c:out value="${city.name}" /> Classifieds"style="" href="tile1.do?start=0&range=10&byO=1&city=<c:out value="${city.name}" />&state=<c:out value="${city.state}" />&country=<c:out value="${city.country}" />"  onclick="callTbClose('${city.name}','tile1.do?start=0&range=10&byO=1&city=<c:out value="${city.name}" />&state=<c:out value="${city.state}" />&country=<c:out value="${city.country}" />');">
                                        <c:choose>
                                            <c:when test="${city.name=='Kolkata'||city.name=='Mumbai'}"><span style="color:yellow;"><c:out value="${city.name}" /></span></c:when>
                                            <c:otherwise><c:out value="${city.name}" /></c:otherwise>
                                        </c:choose>
                                    </a>
                                </li>
                            </c:forEach>

                        </ul>
                    </div>
                    <div id="c36" style="padding-left:25px;text-align:left;float:left;width:100px;">
                        <ul style="list-style: none;">
                            <c:forEach items="${cities}" var="city" begin="24" end="35" >
                                <li style="width:90px">
                                    <a title="<c:out value="${city.name}" /> Classifieds" style="" href="tile1.do?start=0&range=10&byO=1&city=<c:out value="${city.name}" />&state=<c:out value="${city.state}" />&country=<c:out value="${city.country}" />" onclick="callTbClose('${city.name}','tile1.do?start=0&range=10&byO=1&city=<c:out value="${city.name}" />&state=<c:out value="${city.state}" />&country=<c:out value="${city.country}" />');">
                                        <c:choose>
                                            <c:when test="${city.name=='Pune'}"><span style="color:yellow;"><c:out value="${city.name}" /></span></c:when>
                                            <c:otherwise><c:out value="${city.name}" /></c:otherwise>
                                        </c:choose>
                                    </a>
                                </li>
                            </c:forEach>

                        </ul>
                    </div>
                </c:if>
                <div style="clear:both"></div><br />
                <span style="padding-left:50px;"> <a title="Browse All India Classifieds" style="font-size:12px;color:#CCC" href="tile1.do?start=0&range=10&byO=1&city=All India" onclick="callTbClose('All India','tile1.do?start=0&range=10&byO=1&city=All India');" >
                        All India</a> </span><br />
                        <%--<div style="float:right;padding-right:20px;"><input type="submit" value="Continue with All India" onclick="callTbClose('All India','tile1.do?start=0&range=10&byO=1&city=All India');" /></div>--%>
            <%--</div>--%>
            <%--<div style="width:750px;padding-top:10px;font-size:10px;font-weight:normal;color:#222222">
                <span style="float:left"><b>&copy; </b>Copyright 2009 Bharatbuysell.com (India) &nbsp;|&nbsp;
                    <a title="View Terms and Conditions" href="javascript:return false;" onclick="termsAndConditions('tc.do');event.returnValue=false;return false;" style="font-size:10px;color:#222222">Terms & Conditions of website use.</a></span>
                <span style="float:right">Powered by <b style="font-size:12px"><a href="http://focus9.in" style="text-decoration:none;color:#222222">Focus9.in</a></b></span>
            </div>--%>
        </div>
        </div>

        <script type="text/javascript">
            var gaJsHost = (("https:" == document.location.protocol) ? "https://ssl." : "http://www.");
            document.write(unescape("%3Cscript src='" + gaJsHost + "google-analytics.com/ga.js' type='text/javascript'%3E%3C/script%3E"));
        </script>
        <script type="text/javascript">
            try {
                var pageTracker = _gat._getTracker("UA-12685965-1");
                pageTracker._trackPageview();
            } catch(err) {}</script>

    </body>
</html>