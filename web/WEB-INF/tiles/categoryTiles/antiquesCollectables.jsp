<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>

<logic:present name="editAdForUpdateBean">
 <%@page  import="com.buysell.beans.AdsBean" %>
    <% AdsBean ab=(AdsBean)request.getAttribute("editAdForUpdateBean"); %>>
<div class="tilepad" align="left">
<table class="verdana_form_postAd" align="left">




<tr>
<td>
Object
</td>
<td>
<select style="display: inline;" name="objects">
<option value="<%= ab.getObjects()%>"selected><%= ab.getObjects()%></option>
<option value="Armoires, Wardrobes">Armoires, Wardrobes</option>
<option value="Beds">Beds</option>
<option value="Benches, Stools">Benches, Stools</option>
<option value="Bookcases">Bookcases</option>
<option value="Boxes, Chests">Boxes, Chests</option><option value="Bureaux">Bureaux</option>
<option value="Cabinets">Cabinets</option>
<option value="Chairs">Chairs</option>
<option value="Chests of Drawers">Chests of Drawers</option>
<option value="Coffers">Coffers</option><option value="Desks">Desks</option>
<option value="Dressers">Dressers</option>
<option value="Dressing Tables">Dressing Tables</option>
<option value="Lamps">Lamps</option>
<option value="Mirrors">Mirrors</option>
<option value="Sideboards">Sideboards</option>
<option value="Sofas, Chaises">Sofas, Chaises</option>
<option value="Stands">Stands</option>
<option value="Tables">Tables</option>
<option value="Other Antique Furniture">Other Antique Furniture</option>
</select>


</td>
</tr>

<tr>
<td>
Object
</td>
<td>

<select style="display: inline;" name="collectables">
    <option value="<%= ab.getCollectables()%>" selected><%= ab.getCollectables()%></option>
<option value="Carpets, Rugs">Carpets, Rugs</option>
<option value="Chandeliers">Chandeliers</option>
<option value="Clocks">Clocks</option>
<option value="Door Bells, Knockers">Door Bells, Knockers</option>
<option value="Door Knobs, Handles">Door Knobs, Handles</option>
<option value="Doors">Doors</option>
<option value="Ethnographic Antiques">Ethnographic Antiques</option>
<option value="Fireplaces">Fireplaces</option>
<option value="Garden">Garden</option>
<option value="Hardware, Home">Hardware, Home</option>
<option value="Hooks, Brackets">Hooks, Brackets</option>
<option value="Light Switches">Light Switches</option>
<option value="Locks, Keys">Locks, Keys</option>
<option value="Manuscripts">Manuscripts</option>
<option value="Maps">Maps</option>
<option value="Medicine, Science">Medicine, Science</option>
<option value="Metalware">Metalware</option>
<option value="Plaques">Plaques</option>
<option value="Reproductions">Reproductions</option>
<option value="Signs">Signs</option>
<option value="Stained Glass">Stained Glass</option>
<option value="Stair, Carpet Rods">Stair, Carpet Rods</option>
<option value="Tiles">Tiles</option>
<option value="Weathervanes, Lightning Rods">Weathervanes, Lightning Rods</option>
<option value="Windows, Sashes, Locks">Windows, Sashes, Locks</option>
<option value="Woodenware">Woodenware</option>
<option value="Other objects">Other objects</option>
</select>

</td>
</tr>

<tr>
<td>
Object
</td>
<td>
<select style="display: inline;" name="type" >
<option value="<%= ab.getType()%>" selected><%= ab.getType()%></option>
<option value="Advertising">Advertising</option>
<option value="Animals">Animals</option>
<option value="Animation">Animation</option>
<option value="Autographs">Autographs</option>
<option value="Badges,  Patches">Badges,  Patches</option>
<option value="Breweriana">Breweriana</option>
<option value="Casino">Casino</option>
<option value="Cigarette,  Tea,  Gum Cards">Cigarette,  Tea,  Gum Cards</option>
<option value="Clocks">Clocks</option>
<option value="Ethnographic">Ethnographic</option>
<option value="Fantasy,  Myth,  Magic">Fantasy,  Myth,  Magic</option>
<option value="Flags">Flags</option>
<option value="Household">Household</option>
<option value="Knives,  Swords">Knives,  Swords</option>
<option value="Memorabilia">Memorabilia</option>
<option value="Metalware">Metalware</option>
<option value="Militaria">Militaria</option>
<option value="Pens &amp; Writing Equipment">Pens &amp; Writing Equipment</option>
<option value="Phone Cards">Phone Cards</option>
<option value="Photographic Images">Photographic Images</option>
<option value="Postcards">Postcards</option>
<option value="Radio,  Television,  Telephony">Radio,  Television,  Telephony</option>
<option value="Religion,  Spirituality">Religion,  Spirituality</option>
<option value="Rocks,  Fossils,  Minerals">Rocks,  Fossils,  Minerals</option>
<option value="Royalty">Royalty</option>
<option value="Science Fiction">Science Fiction</option>
<option value="Scientific">Scientific</option>
<option value="Sewing,  Fabric,  Textiles">Sewing,  Fabric,  Textiles</option>
<option value="Theatre,  Opera,  Ballet">Theatre,  Opera,  Ballet</option>
<option value="Trading Cards,  CCG">Trading Cards,  CCG</option>
<option value="Trains,  Railway Models">Trains,  Railway Models</option>
<option value="Transportation">Transportation</option>
<option value="Vanity,  Perfume,  Grooming">Vanity,  Perfume,  Grooming</option>
<option value="Vintage,  Retro">Vintage,  Retro</option>
<option value="Weird Stuff">Weird Stuff</option>
<option value="Other collectables">Other collectables</option>
</select>


</td>
</tr>


<tr>
<td>
Year/Era
</td>
<td>
    <input type="text" name="yearsOld" value="<%=ab.getYearsOld()%>">

</td>
</tr>

</table>

</div>
<div class="line" >

</div>

</logic:present>


<logic:notPresent name="editAdForUpdateBean" >




<div class="tilepad" align="left">
<table class="verdana_form_postAd" align="left">
<tr>
<td>
Object
</td>
<td>
<select style="display: inline;" name="objects" >
<option value="">Select an option</option>
<option value="Armoires, Wardrobes">Armoires, Wardrobes</option>
<option value="Beds">Beds</option>
<option value="Benches, Stools">Benches, Stools</option>
<option value="Bookcases">Bookcases</option>
<option value="Boxes, Chests">Boxes, Chests</option><option value="Bureaux">Bureaux</option>
<option value="Cabinets">Cabinets</option>
<option value="Chairs">Chairs</option>
<option value="Chests of Drawers">Chests of Drawers</option>
<option value="Coffers">Coffers</option><option value="Desks">Desks</option>
<option value="Dressers">Dressers</option>
<option value="Dressing Tables">Dressing Tables</option>
<option value="Lamps">Lamps</option>
<option value="Mirrors">Mirrors</option>
<option value="Sideboards">Sideboards</option>
<option value="Sofas, Chaises">Sofas, Chaises</option>
<option value="Stands">Stands</option>
<option value="Tables">Tables</option>
<option value="Other Antique Furniture">Other Antique Furniture</option>
</select>


</td>
</tr>

<tr>
<td>
Object
</td>
<td>

<select style="display: inline;" name="collectables" >
<option value="">Select an option</option>
<option value="Carpets, Rugs">Carpets, Rugs</option>
<option value="Chandeliers">Chandeliers</option>
<option value="Clocks">Clocks</option>
<option value="Door Bells, Knockers">Door Bells, Knockers</option>
<option value="Door Knobs, Handles">Door Knobs, Handles</option>
<option value="Doors">Doors</option>
<option value="Ethnographic Antiques">Ethnographic Antiques</option>
<option value="Fireplaces">Fireplaces</option>
<option value="Garden">Garden</option>
<option value="Hardware, Home">Hardware, Home</option>
<option value="Hooks, Brackets">Hooks, Brackets</option>
<option value="Light Switches">Light Switches</option>
<option value="Locks, Keys">Locks, Keys</option>
<option value="Manuscripts">Manuscripts</option>
<option value="Maps">Maps</option>
<option value="Medicine, Science">Medicine, Science</option>
<option value="Metalware">Metalware</option>
<option value="Plaques">Plaques</option>
<option value="Reproductions">Reproductions</option>
<option value="Signs">Signs</option>
<option value="Stained Glass">Stained Glass</option>
<option value="Stair, Carpet Rods">Stair, Carpet Rods</option>
<option value="Tiles">Tiles</option>
<option value="Weathervanes, Lightning Rods">Weathervanes, Lightning Rods</option>
<option value="Windows, Sashes, Locks">Windows, Sashes, Locks</option>
<option value="Woodenware">Woodenware</option>
<option value="Other objects">Other objects</option>
</select>

</td>
</tr>

<tr>
<td>
Object
</td>
<td>
<select style="display: inline;" name="type" >
<option value="">Select an option</option>
<option value="Advertising">Advertising</option>
<option value="Animals">Animals</option>
<option value="Animation">Animation</option>
<option value="Autographs">Autographs</option>
<option value="Badges,  Patches">Badges,  Patches</option>
<option value="Breweriana">Breweriana</option>
<option value="Casino">Casino</option>
<option value="Cigarette,  Tea,  Gum Cards">Cigarette,  Tea,  Gum Cards</option>
<option value="Clocks">Clocks</option>
<option value="Ethnographic">Ethnographic</option>
<option value="Fantasy,  Myth,  Magic">Fantasy,  Myth,  Magic</option>
<option value="Flags">Flags</option>
<option value="Household">Household</option>
<option value="Knives,  Swords">Knives,  Swords</option>
<option value="Memorabilia">Memorabilia</option>
<option value="Metalware">Metalware</option>
<option value="Militaria">Militaria</option>
<option value="Pens &amp; Writing Equipment">Pens &amp; Writing Equipment</option>
<option value="Phone Cards">Phone Cards</option>
<option value="Photographic Images">Photographic Images</option>
<option value="Postcards">Postcards</option>
<option value="Radio,  Television,  Telephony">Radio,  Television,  Telephony</option>
<option value="Religion,  Spirituality">Religion,  Spirituality</option>
<option value="Rocks,  Fossils,  Minerals">Rocks,  Fossils,  Minerals</option>
<option value="Royalty">Royalty</option>
<option value="Science Fiction">Science Fiction</option>
<option value="Scientific">Scientific</option>
<option value="Sewing,  Fabric,  Textiles">Sewing,  Fabric,  Textiles</option>
<option value="Theatre,  Opera,  Ballet">Theatre,  Opera,  Ballet</option>
<option value="Trading Cards,  CCG">Trading Cards,  CCG</option>
<option value="Trains,  Railway Models">Trains,  Railway Models</option>
<option value="Transportation">Transportation</option>
<option value="Vanity,  Perfume,  Grooming">Vanity,  Perfume,  Grooming</option>
<option value="Vintage,  Retro">Vintage,  Retro</option>
<option value="Weird Stuff">Weird Stuff</option>
<option value="Other collectables">Other collectables</option>
</select>


</td>
</tr>


<tr>
<td>
Year/Era
</td>
<td>
<input type="text" name="yearsOld">

</td>
</tr>

</table>

</div>
<div class="line" >

</div>
</logic:notPresent>