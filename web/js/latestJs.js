    function sendPassword(itemId)

    {

        var ddid="em"+itemId;
        var imgid="img"+itemId;
        var fpfp="fp"+itemId;
        var year="y"+itemId;

        if(document.getElementById(ddid).value != null && document.getElementById(ddid).value != ""
            && document.getElementById(year).value != null && document.getElementById(year).value != null )
        {

            document.getElementById(fpfp).style.display = 'none';
            document.getElementById(imgid).style.display = 'inline';
            var qrstr=document.getElementById(ddid).value.toString()+"&mobile="+document.getElementById(year).value.toString();
            FpAjaxFun(qrstr,itemId);
        }
        else
        {
            alert("Please enter user Id");
            return false;
        }
    }

    function SaveAdWL(itemId,adId)
    {

        showingLoading(itemId);
        var qrystr="adId="+adId+"&loginName="+document.getElementById("l"+itemId).value+"&pwd="+document.getElementById("p"+itemId).value;
       SaveAdAjaxFun(itemId,qrystr);
    }
    function SaveAdAL(itemId,qrystr)
    {
        showingLoading(itemId);
        SaveAdAjaxFun(itemId,qrystr);
    }
    function sendToFriendAL(itemId,adId,title,catId)
    {
        showingLoading(itemId);
        var qrystr="adId="+adId+"&fName="+document.getElementById("fn"+itemId).value+"&fEmail="+document.getElementById("fe"+itemId).value+"&title="+title+"&catId="+catId;
        sendToFriendAjaxFun(itemId,qrystr);
    }
    function sendToFriendWL(itemId,adId,title,catId)
    {
        showingLoading(itemId);
        var qrystr="adId="+adId+"&loginName="+document.getElementById("l"+itemId).value+"&pwd="+document.getElementById("p"+itemId).value+"&fName="+document.getElementById("fn"+itemId).value+"&fEmail="+document.getElementById("fe"+itemId).value+"&title="+title+"&catId="+catId;
        sendToFriendAjaxFun(itemId,qrystr);
    }
    function smsAdvertiserAL(itemId,adId)
    {
        showingLoading(itemId);
        var qrystr="adId="+adId+"&mobile="+document.getElementById("m"+itemId).value+"&adTitle="+document.getElementById("adt"+itemId).value;
        smsAdvertiserAjaxFun(itemId,qrystr);
    }
    function smsAdvertiserWL(itemId,adId)
    {
        showingLoading(itemId);
        var qrystr="adId="+adId+"&loginName="+document.getElementById("l"+itemId).value+"&pwd="+document.getElementById("p"+itemId).value+"&mobile="+document.getElementById("m"+itemId).value+"&adTitle="+document.getElementById("adt"+itemId).value;
        smsAdvertiserAjaxFun(itemId,qrystr);
    }

    function saveSearchAL(itemId,keyword,subCatId,searchUrl)
    {

        showingLoading(itemId);
        var qrystr="keyword="+keyword+"&subCatId="+subCatId+"&searchUrl="+searchUrl;
       saveSearchAjaxFun(itemId,qrystr);
    }
    function saveSearchWL(itemId,keyword,subCatId,searchUrl)
    {
        showingLoading(itemId);
        var qrystr="loginName="+document.getElementById("l"+itemId).value+"&pwd="+document.getElementById("p"+itemId).value+"&keyword="+keyword+"&subCatId="+subCatId+"&searchUrl="+searchUrl;
       saveSearchAjaxFun(itemId,qrystr);
    }
    function saveAlertAL(itemId,keyword,subCatId)
    {
        showingLoading(itemId);
        var qrystr="day1="+document.getElementById("d1"+itemId).value+"&month1="+document.getElementById("m1"+itemId).value+"&year1="+document.getElementById("y1"+itemId).value+"&day2="+document.getElementById("d2"+itemId).value+"&month2="+document.getElementById("m2"+itemId).value+"&year2="+document.getElementById("y2"+itemId).value+"&keyword="+keyword+"&subCatId="+subCatId;
        saveAlertAjaxFun(itemId,qrystr);
    }

    function saveAlertWL(itemId,keyword,subCatId)
    {
        showingLoading(itemId);
        var qrystr="loginName="+document.getElementById("l"+itemId).value+"&pwd="+document.getElementById("p"+itemId).value+"&day1="+document.getElementById("d1"+itemId).value+"&month1="+document.getElementById("m1"+itemId).value+"&year1="+document.getElementById("y1"+itemId).value+"&day2="+document.getElementById("d2"+itemId).value+"&month2="+document.getElementById("m2"+itemId).value+"&year2="+document.getElementById("y2"+itemId).value+"&keyword="+keyword+"&subCatId="+subCatId;
       saveAlertAjaxFun(itemId,qrystr);
    }

    function viewContactWL(itemId, adId, adPostedUserId) {
        //showingLoading(itemId);
        var lname = document.getElementById("l"+itemId).value;
        var pwdValue = document.getElementById("p"+itemId).value;
        if(lname == '') {
            alert("Please enter Login Name");
            return false;
        } else if (pwdValue == '') {
            alert("Please enter Password");
            return false;
        }
        var qrystr="adId="+adId+"&adPostedUserId="+adPostedUserId+"&loginName="+lname+"&pwd="+pwdValue;
       viewContactAjaxFun(itemId,qrystr);
    }
