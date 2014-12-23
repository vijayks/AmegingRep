<script>
    function closeWindow()
    {

        opener.location.reload(true);
         self.close();
    }

    function sendAlert()
    {

        oFormObject = document.forms[1];

        /*  if( oFormObject.elements["pwd"].value.length == 0 && oFormObject.elements["loginName"].value.length == 0)
                {                  alert("Please enter User and Password!");


                }
                else if( oFormObject.elements["pwd"].value.length == 0 )
                {                  alert("Please enter Password!");


                }

                else if( oFormObject.elements["loginName"].value.length == 0 )
                {
                                     alert("Please enter UserId!");

                }
                else*/
        oFormObject.submit();
    }
</script>



<div  style="width:400px;height:150px;">



    <form action="saveAlert2.do">
        <table style="color:#046dbe">

            <input  type="hidden"  name="keyword"  value="<%= request.getParameter("keyword") %>">
            <input  type="hidden"  name="subCatId"  value="<%= request.getParameter("subCatId") %>">
            <input  type="hidden"  name="city"  value="<%= request.getParameter("city")  %>">
            <tr>
            <td>

                Alert From :</td>
                <td>
                <select name="day1" id="day1" class="select">
                    <option selected="true" value="">day</option>

                    <option value="1"> 1</option>
                    <option value="2"> 2</option>
                    <option value="3"> 3</option>
                    <option value="4"> 4</option>
                    <option value="5"> 5</option>
                    <option value="6"> 6</option>
                    <option value="7"> 7</option>
                    <option value="8"> 8</option>
                    <option value="9"> 9</option>
                    <option value="10">10</option>
                    <option value="11">11</option>
                    <option value="12">12</option>
                    <option value="13">13</option>
                    <option value="14">14</option>
                    <option value="15">15</option>
                    <option value="16">16</option>
                    <option value="17">17</option>
                    <option value="18">18</option>
                    <option value="19">19</option>
                    <option value="20">20</option>
                    <option value="21">21</option>
                    <option value="22">22</option>
                    <option value="23">23</option>
                    <option value="24">24</option>
                    <option value="25">25</option>
                    <option value="26">26</option>
                    <option value="27">26</option>
                    <option value="28">28</option>
                    <option value="29">29</option>
                    <option value="30">30</option>
                    <option value="30">31</option>

                </select>

                <select name="month1" id="month1" class="select">
                    <option selected="true" value="">month</option>
                    <option value="0">January</option>
                    <option value="1">February</option>
                    <option value="2">March</option>
                    <option value="3">April</option>
                    <option value="4">May</option>
                    <option value="5">June</option>
                    <option value="6">July</option>
                    <option value="7">August</option>
                    <option value="8">September</option>
                    <option value="9">October</option>
                    <option value="10">November</option>
                    <option value="11">December</option>
                </select>

                <select name="year1" id="year1" class="select">
                    <option selected value="">year</option>

                    <option value="2009">2009</option>
                    <option value="2010">2010</option>
                    <option value="2011">2011</option>
                    <option value="2012">2012</option>

                </select>
                </td>
                </tr>
                <tr>
               <td>
                &nbsp;&nbsp;&nbsp;To:
                </td>
                <td>
                <select name="day2" id="day2" class="select">
                    <option selected="true" value="">day</option>

                    <option value="1"> 1</option>
                    <option value="2"> 2</option>
                    <option value="3"> 3</option>
                    <option value="4"> 4</option>
                    <option value="5"> 5</option>
                    <option value="6"> 6</option>
                    <option value="7"> 7</option>
                    <option value="8"> 8</option>
                    <option value="9"> 9</option>
                    <option value="10">10</option>
                    <option value="11">11</option>
                    <option value="12">12</option>
                    <option value="13">13</option>
                    <option value="14">14</option>
                    <option value="15">15</option>
                    <option value="16">16</option>
                    <option value="17">17</option>
                    <option value="18">18</option>
                    <option value="19">19</option>
                    <option value="20">20</option>
                    <option value="21">21</option>
                    <option value="22">22</option>
                    <option value="23">23</option>
                    <option value="24">24</option>
                    <option value="25">25</option>
                    <option value="26">26</option>
                    <option value="27">26</option>
                    <option value="28">28</option>
                    <option value="29">29</option>
                    <option value="30">30</option>
                    <option value="30">31</option>

                </select>

                <select name="month2" id="month2" class="select">

                    <option selected="true" value="">month</option>
                   <option value="0">January</option>
                    <option value="1">February</option>
                    <option value="2">March</option>
                    <option value="3">April</option>
                    <option value="4">May</option>
                    <option value="5">June</option>
                    <option value="6">July</option>
                    <option value="7">August</option>
                    <option value="8">September</option>
                    <option value="9">October</option>
                    <option value="10">November</option>
                    <option value="11">December</option>
                </select>

                <select name="year2" id="year2" class="select">
                    <option selected value="">year</option>

                    <option value="2009">2009</option>
                    <option value="2010">2010</option>
                    <option value="2011">2011</option>
                    <option value="2012">2012</option>

                </select>
            </td>
            <tr />
            <tr>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
            <tr>

            <td>

            </td>
            <td>
              <input type="submit" value="Save Alert" > &nbsp; &nbsp; &nbsp; &nbsp;
              <input type="button" value="Cancel" onClick="closeWindow();"/>
            </td>
            </tr>
        </table>
    </form>
</div>