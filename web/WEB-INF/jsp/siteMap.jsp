<%--
    Document   : siteMap
    Created on : Aug 20, 2009, 7:41:45 PM
    Author     : bbsadmin
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<style>
    #sitemap a{color:#046dbe;}
</style><br/>
<img src="bbsimages/Site-Map.png" style="width:100%"/>
<div style="border-left:1px solid #D7D4D4;border-right:1px solid #D7D4D4;padding:0 4px 0 4px;margin-top:-5px">
    <table id="sitemap" style="width:850px;font-size:14px;color:black;padding-left:40px;">
        <tr>
            <td style="color:black;">
                <b>*&nbsp;</b><a title="Home" href="tile1.do?start=0&range=10&byO=1" >Home</a><br/>
                <b>*&nbsp;</b><a title="Post Ad" href="postAd.do" >Post Ad </a><br/>
                <b>*&nbsp;</b><a title="Register" href="register.do">Register</a><br/>
                <b>*&nbsp;</b><a title="My Account" href="my_ads_details.do">My Account</a><br/>
                <b>*&nbsp;</b><a title="Latest Ads" href="latestAds.do?start=0&range=20&byO=1">Latest Ads</a><br/>
            </td>
            <td>
                <b>*&nbsp;</b><a title="Current Offers" href="#">Current Offers</a><br/>
                <b>*&nbsp;</b><a title="Login" href="myAccountNL.do">Login</a><br/>
                <b>*&nbsp;</b><a title="About Us" href="aboutUs.do" >About Us</a><br/>
                <b>*&nbsp;</b><a title="Contact Us" href="contactUs.do" >Contact Us</a><br/>
                <b>*&nbsp;</b><a title="Feedback" href="contactUs.do" >Feedback</a><br/>
            </td>
            <td>
                <b>*&nbsp;</b><a title="Help" href="help.do" >Help</a><br/>
                <b>*&nbsp;</b><a title="Terms of Service" href="tc.do" >Terms of Service</a><br/>
                <b>*&nbsp;</b><a title="Privacy Statement" href="ps.do" >Privacy Statement</a><br/>
                <b>*&nbsp;</b><a title="Business Links" href="getLinks.do" >Business Links</a><br/>
                <b>*&nbsp;</b><a title="Auctions" href="auctions.do" >Auctions</a><br/>
            </td>
        </tr>
    </table>
</div>
<img src="bbsimages/footer-border.png" style="width:100%;height:25px;"/><br/><br/>

<%--<div style="margin:0 auto">

    Welcome to post ad load testing <br /><br />

   Number of Ads Posted :: <%=request.getAttribute("pa100") %> <br /><br />


    <form action="pa100.do">
        <table>
            <tr>
                <td>Number of Ads ::</td>
                <td><input type="text" name="max"></td>
            </tr>

        </table>

        <input type="submit" name="postAds" >
    </form>--%>

<%--</div>--%>