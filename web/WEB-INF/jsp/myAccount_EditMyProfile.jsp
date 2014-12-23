<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page  import="com.buysell.beans.UserProfileBean" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<script type="text/javascript" language="javascript" src="js/ajx.js"></script>
<style type="text/css">
    <!--
    #linkDiv {
        float:left;
        padding-left:10px;
        width:180px;
        height:25px;
        text-align:left;
    }
    #editMyProfilet a{
        text-decoration:none;
        font-size:12px;
        color:#046dbe;
    }
    #editMyProfilet a:hover{
        text-decoration:underline;
        font-size:12px;
        color:#046dbe;
    }
    #editMyProfilet select{width:253px;}
    #editMyProfilet{margin:10px 0 10px 15px;font-weight:bold;}
    #editMyProfilet input[type=text]{width:250px;}
    -->
</style>
<script type="text/javascript">
    function dateOfBirthValidation(regform)
    {
        var day=regform.date.value;
        var month=regform.month.value;
        var year=regform.year.value;
        var monthValid, yearValid, dayValid,leapYear;
        var daysInMonth;
        //       alert("Day ::"+day+" Month ::" +month+" Year::"+year);
        //Check to see if month is valid
        if(month >= 1 && month <= 12)
            monthValid = true;
        else
            monthValid = false;
        //Check to see if year is valid
        if(year >= 1000 && year <= 1999)
            yearValid = true;
        else
            yearValid = false;
        //Determine whether it's a leap year
        if((year % 400 == 0) || (year % 100 != 0 && year % 4 == 0))
            leapYear = true;
        else
            leapYear = false;
        //Determine number of days in month
        if(month == 1 || month == 3 || month == 5 || month == 7 || month == 8 || month == 10 || month == 12)
            daysInMonth = 31;
        else
            if(month == 4 || month == 6 || month == 9 || month == 11)
                daysInMonth = 30;
        else
        {
            if(month == 2 && leapYear == true)
                daysInMonth = 29;
            else
                daysInMonth = 28;
        }
        //User number of days in month to check to see if day is valid
        if(day >= 1 && day <= daysInMonth)
            dayValid = true;
        else
            dayValid = false;
        //Determine whether date is valid and print appropriate message
        /* alert("Day valid"+dayValid);
    alert("Month Valid::" +monthValid);
    alert("yearValid::"+yearValid);*/
        if(dayValid == false || monthValid == false || yearValid == false)
            return false;
        else
            return true;
    }
    function valform(regForm){
        var fName=regForm.firstName.value;
        var city=regForm.city.value;
        var location=regForm.location.value;
        var address=regForm.address.value;
        var chk=false;
        if(fName == ""){
            inlineMsg('firstName','Enter your First Name');
            chk=false;
        }
        else if(!dateOfBirthValidation(regForm)){
            inlineMsg('year','Please select Correct Date of Birth.');
            chk=false;
        }
        else if(city == ""){
            inlineMsg('city','Select your city');
            chk=false;
        }
        else if(location == ""){
            inlineMsg('location','Select your Location');
            chk=false;
        }
        else if(address == ""){
            inlineMsg('address','Enter your Address.');
            chk=false;
        }
        else{
            chk=true;
            submitPressed("ad","sub");
        }
        return chk;
    }
</script>
<div style="width:100%;height:5px;"> </div>
<div id="masterrightbodybg" ><div class="verdana_form_mainhead" >Edit My Profile</div>
    <c:if test="${userProfileBean  != null }">
        <div style="color:#FF9600;"><div style="padding:10px 0 10px 120px">Contact Information</div></div>
        <form id="rform" name="regform" method="POST" action="update_user_profile.do" enctype="multipart/form-data" onsubmit="return valform(this);">
            <input type="hidden" name="type" value="user" /><%    UserProfileBean upb = (UserProfileBean) request.getAttribute("userProfileBean");%>
            <table id="editMyProfilet" cellpadding="2px" class="verdana_form" style="width:700px;clear:both" >
                <tr> <td>First Name<font color="red">*</font></td>
                    <td> <input type="text" style="width:250px;height:18px" id="firstName" name="firstName" value="<%= upb.getFirstName()%>"></td>
                </tr>
                <tr><td style="padding-bottom:5px"></td></tr>
                <tr><td>Last Name</td>
                    <td> <input type="text" style="width:250px;height:18px" id="lastName" name="lastName" value="<%= upb.getLastName()%>"></td>
                </tr>
                 <tr><td style="padding-bottom:5px"></td></tr>
                <tr><td>Gender<font color="red">*</font></td>
                    <td><select  id="gender" style="width:253px;" name="gender"> <option value="Male">Male</option><option value="Female">Female</option> </select></td>
                </tr>
                 <tr><td style="padding-bottom:5px"></td></tr>
                <tr> <td>Date of Birth<font color="red">*</font></td>
                    <td><select style="width:45px;" id="date"  name="date">
                            <option value="01">01</option><option value="02">02</option><option value="03">03</option><option value="04">04</option><option value="05">05</option><option value="06">06</option> <option value="07">07</option> <option value="08">08</option> <option value="09">09</option> <option value="10">10</option> <option value="11">11</option> <option value="12">12</option> <option value="13">13</option> <option value="14">14</option> <option value="15">15</option>
                            <option value="16">16</option> <option value="17">17</option> <option value="18">18</option> <option value="19">19</option> <option value="20">20</option> <option value="21">21</option> <option value="22">22</option> <option value="23">23</option> <option value="24">24</option> <option value="25">25</option> <option value="26">26</option> <option value="27">27</option> <option value="28">28</option> <option value="29">29</option> <option value="30">30</option> <option value="31">31</option>
                        </select>
                        <select name="month" style="width:140px" id="month" >
                            <option value="01">January</option><option value="02">February</option><option value="03">March</option> <option value="04">April</option> <option value="05">May</option> <option value="06">June</option> <option value="07">July</option> <option value="08">August</option> <option value="09">September</option> <option value="10">October</option> <option value="11">November</option> <option value="12">December</option>
                        </select>
                        <select style="width:62px" name="year" id="year" >
                            <option value="1910">1910</option> <option value="1911">1911</option> <option value="1912">1912</option> <option value="1913">1913</option> <option value="1914">1914</option> <option value="1915">1915</option> <option value="1916">1916</option> <option value="1917">1917</option> <option value="1918">1918</option> <option value="1919">1919</option><option value="1920">1920</option> <option value="1921">1921</option> <option value="1922">1922</option> <option value="1923">1923</option> <option value="1924">1924</option> <option value="1925">1925</option> <option value="1926">1926</option> <option value="1927">1927</option> <option value="1928">1928</option> <option value="1929">1929</option>
                            <option value="1930">1930</option> <option value="1931">1931</option> <option value="1932">1932</option> <option value="1933">1933</option> <option value="1934">1934</option> <option value="1935">1935</option> <option value="1936">1936</option> <option value="1937">1937</option> <option value="1938">1938</option> <option value="1939">1939</option><option value="1940">1940</option> <option value="1941">1941</option> <option value="1942">1942</option> <option value="1943">1943</option> <option value="1944">1944</option> <option value="1945">1945</option> <option value="1946">1946</option> <option value="1947">1947</option> <option value="1948">1948</option> <option value="1949">1949</option>
                            <option value="1950">1950</option> <option value="1951">1951</option> <option value="1952">1952</option> <option value="1953">1953</option> <option value="1954">1954</option> <option value="1955">1955</option> <option value="1956">1956</option> <option value="1957">1957</option><option value="1958">1958</option><option value="1959">1959</option> <option value="1960">1960</option> <option value="1961">1961</option> <option value="1962">1962</option> <option value="1963">1963</option> <option value="1964">1964</option> <option value="1965">1965</option> <option value="1966">1966</option> <option value="1967">1967</option> <option value="1968">1968</option> <option value="1969">1969</option>
                            <option value="1970">1970</option> <option value="1971">1971</option> <option value="1972">1972</option> <option value="1973">1973</option> <option value="1974">1974</option> <option value="1975">1975</option> <option value="1976">1976</option> <option value="1977">1977</option> <option value="1978">1978</option> <option value="1979">1979</option> <option value="1980">1980</option> <option value="1981">1981</option> <option value="1982">1982</option> <option value="1983">1983</option> <option value="1984">1984</option> <option value="1985">1985</option> <option value="1986">1986</option> <option value="1987">1987</option> <option value="1988">1988</option> <option value="1989">1989</option>
                            <option value="1990">1990</option> <option value="1991">1991</option> <option value="1992">1992</option> <option value="1993">1993</option> <option value="1994">1994</option> <option value="1995">1995</option> <option value="1996">1996</option>
                        </select>
                    </td>
                </tr>
                 <tr><td style="padding-bottom:5px"></td></tr>
                <tr> <td>Occupation</td>
                    <td><select  id="occupation" style="width:253px" name="occupation">
                            <option value="Artist">Artist</option> <option value="Business">Business/Self employed</option> <option value="Consultant">Consultant</option> <option value="Director">Director / Senior Management</option> <option value="Doctor">Doctor</option> <option value="Engineer">Engineer</option> <option value="Executive">Executive / Middle level</option> <option value="UN EMPLOYEED">Unemployed</option>
                        </select>
                    </td>
                </tr>
                 <tr><td style="padding-bottom:5px"></td></tr>
                <tr><td>City<font color="red">*</font></td>
                    <td><select  id="city" name="city" onchange="getLocalitiesR(this)"> <option value="" selected="true" >Select City</option>
                            <c:if test="${cities  != null }"> <c:forEach items="${cities}" var="city"> <option value="<c:out value='${city.name}'/>"><c:out value="${city.name}"/></option> </c:forEach> </c:if>
                        </select>
                </tr>
                 <tr><td style="padding-bottom:5px"></td></tr>
                <tr> <td>Locality<font color="red">*</font></td>
                    <td><select  id="location" name="location"> <option value="" selected="true" >Select Locality</option> <c:if test="${locationClasses  != null }"> <c:forEach items="${locationClasses}" var="location"> <option value="<c:out value='${location.name}'/>"><c:out value="${location.name}"/></option> </c:forEach> </c:if> </select> </td>
                </tr>
                 <tr><td style="padding-bottom:5px"></td></tr>
                <tr><td>Address<font color="red">*</font></td>
                    <td><textarea name="address" id="address" style="text-align:left;width:240px;"><%= upb.getAddress()%></textarea></td>
                </tr>
                 <tr><td style="padding-bottom:5px"></td></tr>
                <%--  <tr> <td>PinCode</td> <td><input type="text" style="width:250px;" name="pinCode" value="<%= upb.getPinCode()%>" ></td> </tr>--%>
                <tr><td>Contact No<font color="red">*</font></td>
                    <td><input type="text" style="width:250px;height:18px" readonly name="mobile" value="<%=upb.getMobile()%>" ></td>
                </tr>
                 <tr><td style="padding-bottom:20px"></td></tr>
                <tr> <td> <span style="color:red">  Note: </span> </td>
                    <td> To change your mobile number <a href="myAccount_ChangeMobile.do" style="color:red">Click Here</a> </td>
                </tr>
            </table>
            <div style="width:690px;height:10px">&nbsp;</div>
            <span style="padding-left:260px"><input type="image" src="bbsimages/buttons/Update.png" onmouseover="this.src='bbsimages/buttons/Update_MouseOver.png';" onmouseout="this.src='bbsimages/buttons/Update.png';"> </span>
        </form>
         <div style="width:690px;height:20px"> &nbsp;</div>
        <script type="text/javascript">
            <% if (upb.getCity() != null) {%>
                document.getElementById('city').value='<%= upb.getCity()%>';
            <% }%>
            <% if (upb.getLocation() != null) {%>
                document.getElementById('location').value='<%= upb.getLocation()%>';
            <% }%>
            <% if (upb.getDate() != null) {%>
                document.getElementById('date').value='<%= upb.getDate()%>';
            <% }%>
            <% if (upb.getMonth() != null) {%>
                document.getElementById('month').value='<%= upb.getMonth()%>';
            <% }%>
            <% if (upb.getYear() != null) {%>
                document.getElementById('year').value='<%= upb.getYear()%>';
            <% }%>
            <% if (upb.getGender() != null) {%>
                document.getElementById('gender').value='<%= upb.getGender()%>';
            <% }%>
            <% if (upb.getOccupation() != null) {%>
                document.getElementById('occupation').value='<%= upb.getOccupation()%>';
            <% }%>
        </script>
    </c:if>
    <c:if test="${userProfileBean  == null }"> Unable to process the given request, please try again.</c:if>
</div>