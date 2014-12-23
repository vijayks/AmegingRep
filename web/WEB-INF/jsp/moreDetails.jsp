<%@ taglib uri="http://struts.apache.org/tags-tiles" prefix="tiles" %>
<%@ page language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@page import="java.util.Date" %>
<%@page import="com.buysell.util.BuySellProperties" %>
<% pageContext.setAttribute("newLineChar", "\n");%>
<% pageContext.setAttribute("jstlbr", "<br>");%>
<% String localUrlPath = "/";
    if (BuySellProperties.getProperty("localurl") != null && BuySellProperties.getProperty("localurl").trim().length() > 0) {
        localUrlPath = BuySellProperties.getProperty("localurl");
    }
%>
<script type="text/javascript" src="<%=localUrlPath%>/js/latestJs.js"></script>
<!--<script type='text/javascript' src='<%=localUrlPath%>/js/New/basic.js'></script>-->
<script type='text/javascript' src='<%=localUrlPath%>/js/New/jquery.simplemodal.js'></script>
<script type="text/javascript" src="<%=localUrlPath%>/js/New/jquery.dd.js"></script>
<link rel="stylesheet" type="text/css" href="<%=localUrlPath%>/css/New/dd.css" />
<style type="text/css">
    .sImgA{
        text-decoration:none;
        padding:0px 10px;
        font-size:13px;
        font-weight:bold;
        color:#FF840E;
    }
    .sImgA:hover{
        text-decoration:none;
    }
    .mdtl {
        font-size:13px;
    }
    .mdtl table { margin-top:10px; }
    .mdtl h4 { margin:5px 0; }
    .adfs tr{
        float:left;
        width:285px;
        height:36px;
        vertical-align:top;
        overflow:auto;
    }
    .adfs tr td:first-child { width:90px; }
    .boxBorder4 { margin-top:5px;border:none; border-top:1px dashed #CCCCCC; border-bottom:1px dashed #CCCCCC; }
    .header { height:20px; }
    .crnbrds{
        border-bottom-right-radius:4px;
        border-bottom-left-radius:4px;
        border-top-right-radius:4px;
        border-top-left-radius:4px;
    }
    .crnbrdshig{
        border-bottom-right-radius:18px;
        border-bottom-left-radius:18px;
        border-top-right-radius:18px;
        border-top-left-radius:18px;
    }
</style>
<%Date date = new java.util.Date();
    pageContext.setAttribute("dat", date);%>
<%--<img src="<%=localUrlPath%>/bbsimages/logo.png" width="90" alt="Bharatbuysell"/>--%>
<c:set var="dt"><fmt:formatDate pattern="yyyy-MM-dd" type="date" value="${dat}" /></c:set>
<%--<fmt:parseDate var="apdt" pattern="yyyy-MM-dd" type="date" value="${moreDetails.postedDate}"/>--%>
<%--<c:set var="pdt"><fmt:formatDate pattern="yyyy-MM-dd" type="date" value="${apdt}"/></c:set>--%>
<c:choose><c:when test="${moreDetails.status != 1 && userBean.loginName !=moreDetails.email}">
        <div id="moredetail" class="mdtl"><br/><br/><span style="font-size:20px;color:red;margin-left:20px;">This is an inactive ad.</span><br/><br/></div>
        </c:when><c:otherwise>
<!--        <script type="text/javascript">document.title="${moreDetails.title}"+" | Bharatbuysell - Free Classifieds India";</script>-->
        <div id="moredetail" class="mdtl">
            <div class="ikon_2006" ><c:out value="${moreDetails.title}" />
                <c:if test="${moreDetails.sponsType > 1}"><div style="float: right"><img src="<%=localUrlPath%>/bbsimages/New/Fprm.png"  style="margin-top:-30px;margin-bottom:-15px; height:60px;width:130px"/></div> </c:if>
                </div>
                <div class="locations_boder_cont">
                    <div class="locations_main_left_cont">
                        <div class="locations_inner_left_cont">
                            <div class="locations_left_top_cont">
                                <div class="locations_left_top_cont">Location <br />Date Posted <br/></div>
                            </div>
                            <div class="locations_right_top_cont">: <c:out value="${moreDetails.locality}" />&nbsp;-&nbsp;<c:out value="${moreDetails.city}" /> <br />: <c:out value="${moreDetails.postedDate}" /> </div>
                            <c:if test="${catName != 'sfinance'}"><c:if test="${catName != 'shealth-ph'}"><c:if test="${catName != 'shealth-hs'}"><c:if test="${catName != 'spets-lp'}"><c:if test="${catName != 'sjobs'}"><c:if test="${catName != 'sjobs-edu'}"><c:if test="${catName != 'smat'}"><c:if test="${catName != 'stravel-v'}"><c:if test="${moreDetails.rentMonth !=0}">
                                                            <div class="locations_left_top_cont"> <div class="locations_left_top_cont" >Rent per Month </div>  </div>
                                                            <div class="locations_right_top_cont">: <c:if test="${moreDetails.cfp=='on'}">Contact For Price</c:if>
                                                                <c:if test="${moreDetails.cfp!='on'}"><c:if test="${moreDetails.adType!='wanted'}">Rs. <fmt:formatNumber type="currency" pattern="#,##,###.00"  value="${moreDetails.rentMonth}"  /><c:if test="${moreDetails.neg=='yes'}">&nbsp;(Neg)</c:if></c:if></c:if>
                                                                <c:if test="${moreDetails.adType=='wanted'}">
                                                                    <c:if test="${moreDetails.min!=''}">Rs. <fmt:formatNumber type="currency" pattern="#,##,###.00" value="${moreDetails.min}"/></c:if>&nbsp;-&nbsp;<c:if test="${moreDetails.max!=''}">Rs. <fmt:formatNumber type="currency" pattern="#,##,###.00" value="${moreDetails.max}"/></c:if>
                                                                </c:if>
                                                            </div>
                                                        </c:if>
                                                        <c:if test="${moreDetails.rentMonth == 0}">
                                                            <div class="locations_left_top_cont"> <div class="locations_left_top_cont">
                                                                    <c:if test="${moreDetails.adType!='wanted'}"> <c:if test="${moreDetails.price != ''}">Price</c:if></c:if>
                                                                    <c:if test="${moreDetails.adType=='wanted'}"><c:if test="${moreDetails.min!='' && moreDetails.max!=''}">Budget</c:if></c:if>
                                                                        </div>
                                                                    </div>
                                                                    <div class="locations_right_top_cont">: <c:if test="${moreDetails.cfp=='on'}">Contact For Price</c:if>
                                                                <c:if test="${moreDetails.cfp!='on'}"><c:if test="${moreDetails.adType!='wanted'}">
                                                                        <c:if test="${moreDetails.price ==0}">Contact for Price</c:if>
                                                                        <c:if test="${moreDetails.price !=0}">Rs. <fmt:formatNumber type="currency" pattern="#,##,###.00" value="${moreDetails.price}" /><c:if test="${moreDetails.neg=='yes'}">&nbsp;(Neg)</c:if></c:if></c:if></c:if>
                                                                <c:if test="${moreDetails.adType=='wanted'}">
                                                                    <c:if test="${moreDetails.min!=''}">Rs. <fmt:formatNumber type="currency" pattern="#,##,###.00" value="${moreDetails.min}"/></c:if>&nbsp;-&nbsp;<c:if test="${moreDetails.max!=''}">Rs. <fmt:formatNumber type="currency" pattern="#,##,###.00" value="${moreDetails.max}"/></c:if>
                                                                </c:if>
                                                            </div>
                                                        </c:if>
                                                    </c:if></c:if></c:if></c:if></c:if></c:if></c:if></c:if>
                        <c:if test="${catName == 'stravel-v'}">
                            <div class="locations_left_top_cont"><div class="locations_left_top_cont"> Price per Night </div>  </div>
                            <div class="locations_right_top_cont">: <c:if test="${moreDetails.min!=''}"><fmt:formatNumber type="currency" pattern="#,##,###.00" value="${moreDetails.min}"/></c:if>&nbsp;-&nbsp;<c:if test="${moreDetails.max!=''}"><fmt:formatNumber type="currency" pattern="#,##,###.00" value="${moreDetails.max}"/></c:if></div>
                        </c:if>
                    </div>
                    <div class="locations_inner_left_cont">
                        <div class="ikon_2006_for_cont_txt">
                            <c:out value="${fn:replace(moreDetails.description,newLineChar,jstlbr)}" escapeXml="false" />
                            <c:if test="${moreDetails.addtionalContent != null && moreDetails.addtionalContent != '' }" >
                                <c:out value="${fn:replace(moreDetails.addtionalContent,newLineChar,jstlbr)}" escapeXml="false" />
                            </c:if>
                        </div>
                    </div>
                </div>

                <div class="locations_main_right_cont">
                    <div class="share_this_ad_cont_txt"> Share this AD</div>
                    <div class="g_mt_cont">
                        <div class="car_g_img"><g:plusone></g:plusone></div>
                        <c:set var="numimg" value="0"/>
                        <div class="change_img_1">

                            <div style="height:180px"><c:if test='${moreDetails.image1 == "" || moreDetails.image1 == null || moreDetails.image1 == "null"}'>
                                    <img src="<%=localUrlPath%>/bbsimages/No_Image.png" style="" alt="No Image"/>
                                </c:if>
                                <c:if test='${moreDetails.image1 != "" && moreDetails.image1 != null && moreDetails.image1 != "null"}'>
                                    <img  id="i1${moreDetails.adId}" style="max-width:200px;max-height: 180px;width: expression(this.width >= this.height ? 160: true);height: expression(this.height >= this.width ? 180: true);" src="<%=localUrlPath%>/resourceGetter?imf=<c:out value="${moreDetails.image1}"/>"alt="${moreDetails.title}" />
                                    <c:set var="numimg" value="${numimg+1}"/>
                                </c:if>
                                <c:if test='${moreDetails.image2 != "" && moreDetails.image2 != null && moreDetails.image2 != "null"}'>
                                    <img id="i2${moreDetails.adId}" style="display:none;max-width:200px;max-height: 180px;width: expression(this.width >= this.height ? 160: true);height: expression(this.height >= this.width ? 180: true);" src="<%=localUrlPath%>/resourceGetter?imf=<c:out value="${moreDetails.image2}"/>" alt="${moreDetails.title}"/>
                                    <c:set var="numimg" value="${numimg+1}"/>
                                </c:if>
                                <c:if test='${moreDetails.image3 != "" && moreDetails.image3 != null && moreDetails.image3 != "null"}'>
                                    <img id="i3${moreDetails.adId}" style="display:none;max-width:200px;max-height: 180px;width: expression(this.width >= this.height ? 160: true);height: expression(this.height >= this.width ? 180: true);" src="<%=localUrlPath%>/resourceGetter?imf=<c:out value="${moreDetails.image3}"/>" alt="${moreDetails.title}"/>
                                    <c:set var="numimg" value="${numimg+1}"/>
                                </c:if>
                            </div>
                            <div align="center" style="padding-bottom:7px;" ><c:if test="${numimg==1}"> 1 of 1 <a href="#BgImg" ><img alt="zoom" class="sImgA" src="<%=localUrlPath%>/bbsimages/New/ad_zoom.png"/></a> </c:if>
                                    <c:if test="${numimg>1}">
                                    <script type="text/javascript">
                                        var mdImg=1;
                                        function chMdImg() {
                                            for(var i=1;i<=${numimg};i++) {
                                                document.getElementById("i"+i+${moreDetails.adId}).style.display='none';
                                            }
                                            if(mdImg==0) mdImg=${numimg};
                                            if(mdImg>${numimg}) mdImg=1;
                                            document.getElementById("i"+mdImg+${moreDetails.adId}).style.display='inline';
                                            document.getElementById("curimg").innerHTML=mdImg;
                                        }
                                    </script>
                                    <a href="javascript:void(0);" class="sImgA" title="Previous" onclick="chMdImg(mdImg--)"><img src="<%=localUrlPath%>/bbsimages/New/ad_arrow1.png"/></a>&nbsp;<span id="curimg" style="margin-top:1px">1</span> of ${numimg}
                                    <a href="javascript:void(0);" class="sImgA" title="Next"onclick="chMdImg(mdImg++)"><img src="<%=localUrlPath%>/bbsimages/New/ad_arrow2.png"/></a>&nbsp;
                                    <a href="#BgImg"><img  alt="zoom" src="<%=localUrlPath%>/bbsimages/New/ad_zoom.png"/></a>
                                    </c:if>
                            </div>
                        </div>
                    </div>
                    <c:if test="${moreDetails.videoUrl != 'null' && fn:length(moreDetails.videoUrl) >0}">
                        <div style="float: right;margin:10px 0 10px 0"><iframe width="250" height="180" src="${moreDetails.videoUrl}"  allowlscreen></iframe></div>
                        </c:if>
                </div>
            </div>
            <c:if test="${moreDetails.facilities != null && moreDetails.facilities != '' }" >
                <div class="adtypy_mt_fac_txt"> <div class="adtypy_inner_fac_left_cont">
                        <div class="adtypy_left_top_cont" style="color:#046dbe;font-size:13px;">Facilities</div><div class="adtypy_right_top_cont">: <c:out value="${moreDetails.facilities}" /></div>
                    </div>          </div> </c:if>
                <div class="adtypy_mt_cont_txt">
                    <div class="adtypy_inner_left_cont">
                        <div class="adtypy_left_top_cont">Adtype &nbsp;</div>
                        <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.adType}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>

                <%--********************* Automobiles Start *********************--%>
                <c:if test="${catName == 'sauto'}">
                    <c:if test="${moreDetails.condition!=null && moreDetails.condition!=''}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Condition &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.condition}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.yearsOld != '' && moreDetails.yearsOld != null}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Mfg. Year &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.yearsOld}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.model!=null && moreDetails.model!=''}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Model &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.model}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.regNo!=null && moreDetails.regNo!=''}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Register No &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.regNo}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.color!=null && moreDetails.color!=''}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Colour &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.color}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.ownership!=null && moreDetails.ownership!=''}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Ownership &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.ownership}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.insurance!=null && moreDetails.insurance!=''}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Insurance &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.insurance}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.kmRun!=null && moreDetails.kmRun!='0'}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">KM Run &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.kmRun}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <%--<c:if test="${moreDetails.adType!='wanted'}">
                            <c:if test="${moreDetails.price !=0}">
                                <c:if test="${moreDetails.cfp!='on'}">
                                    <tr align="left">
                                        <td><span style="font-weight:bold;">Negotiation</span></td>
                                        <td><span style="font-weight:bold;">:</span></td>
                                        <td><c:out value="${moreDetails.neg}" /></td>
                                    </tr>
                                </c:if>
                            </c:if>
                        </c:if>--%>
                    </c:if>
                    <%--********* Service Centers *******--%>
                    <c:if test="${catName == 'sauto-sc'}">
                        <c:if test="${moreDetails.name != null && moreDetails.name != ''}">
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Name of Service Center &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.name}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.prefLocation != null && moreDetails.prefLocation != ''}">
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Address</span> &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.prefLocation}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                    </c:if>
                    <%--********* Spars and Accessories *******--%>
                    <c:if test="${catName == 'sauto-asa'}">
                        <c:if test="${moreDetails.condition!=null && moreDetails.condition!=''}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Condition &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.condition}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.yearsOld != '' && moreDetails.yearsOld != null}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Mfg. Year &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.yearsOld}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.brand != '' && moreDetails.brand != null}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Make &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.brand}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.model!=null && moreDetails.model!=''}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Model &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.model}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.color!=null && moreDetails.color!=''}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Colour &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.color}" /><&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                    </c:if>
                    <%--********* Tyres *******--%>
                    <c:if test="${catName == 'sauto-t'}">
                        <c:if test="${moreDetails.type != null && moreDetails.type != ''}">
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Tyre Type &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.type}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.measurement != null && moreDetails.measurement != ''}">
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Size &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.measurement}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.name != null && moreDetails.name != ''}">
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Vehicle Model &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.name}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.brand != null && moreDetails.brand != ''}">
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Make &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.brand}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.model != null && moreDetails.model != ''}">
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Tyre Model &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.model}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                    <<%--c:if test="${moreDetails.adType!='wanted'}">
                        <c:if test="${moreDetails.cfp!='on'}">
                            <tr align="left">
                                <td><span style="font-weight:bold;">Negotiation</span></td>
                                <td><span style="font-weight:bold;">:</span></td>
                                <td><c:out value="${moreDetails.neg}" /></td>
                            </tr>
                        </c:if>
                    </c:if>--%>
                </c:if>
                <%--********************* Automobiles End *********************--%>
                <%--********************* RealEstate start *********************--%>
                <%--****************** Residential Rent => Studio, Other Residentials, Apartment/Flat,Service Apartment **************--%>
                <c:if test="${catName == 'sreal-rr'}">
                    <c:if test="${moreDetails.prefLocation != null && moreDetails.prefLocation != ''}">
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Property Location &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.prefLocation}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.area != null && moreDetails.area != ''}">
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Area &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.area}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.noBedRooms != null && moreDetails.noBedRooms != 0 }">
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">No. of Bedrooms &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.noBedRooms}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.kmRun != null && moreDetails.kmRun != 0}">
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">No. of Bathrooms &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.kmRun}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.floorNum != null && moreDetails.floorNum != 0 }">
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Floor No. &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.floorNum}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.totalFloors != null && moreDetails.totalFloors != 0 }">
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Total No. of Floors &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.totalFloors}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <%--<c:if test="${moreDetails.rentMonth != null && moreDetails.rentMonth != ''}">
                            <tr align="left">
                                <td><span style="font-weight:bold;">Rent per Month</span></td>
                                <td><span style="font-weight:bold;">:</span></td>
                                <td><c:out value="${moreDetails.rentMonth}" /></td>
                            </tr>
                        </c:if>--%>
                        <c:if test="${moreDetails.facing != null && moreDetails.facing != ''}">
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Facing &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.facing}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.furnished != null && moreDetails.furnished != ''}">
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Furnished &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.furnished}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <%--<c:if test="${moreDetails.adType!='wanted'}">
                            <c:if test="${moreDetails.cfp!='on'}">
                                <tr align="left">
                                    <td><span style="font-weight:bold;">Negotiation</span></td>
                                    <td><span style="font-weight:bold;">:</span></td>
                                    <td><c:out value="${moreDetails.neg}" /></td>
                                </tr>
                            </c:if>
                        </c:if>--%>
                    </c:if>
                    <%--****************** Residential Rent => Plot And Land **************--%>
                    <c:if test="${catName == 'sreal-rr-pl'}">
                        <c:if test="${moreDetails.prefLocation != null && moreDetails.prefLocation != ''}">
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Property Location &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.prefLocation}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.area != null && moreDetails.area != ''}">
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Area &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.area}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.rentMonth != null && moreDetails.rentMonth != 0}">
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Rent per Month</span></td>
                                <td><span style="font-weight:bold;">:</span></td>
                                <td><c:out value="${moreDetails.rentMonth}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                            </c:if>
                            <c:if test="${moreDetails.facing != null && moreDetails.facing != ''}">
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Facing &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.facing}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                    </c:if>
                    <%--****************** Residential Rent => Individual House And Farm House **************--%>
                    <c:if test="${catName == 'sreal-rr-ih'}">
                        <c:if test="${moreDetails.prefLocation != null && moreDetails.prefLocation != ''}">
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Property Location &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.prefLocation}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.area != null && moreDetails.area != ''}">
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Area &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.area}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.noBedRooms != null && moreDetails.noBedRooms != 0}">
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">No. of Bedrooms &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.noBedRooms}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.kmRun != null && moreDetails.kmRun != 0}">
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">No. of Bathrooms &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.kmRun}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.rentMonth != null && moreDetails.rentMonth != 0}">
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Rent per Month &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.rentMonth}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.facing != null && moreDetails.facing != ''}">
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Facing &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.facing}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.furnished != null && moreDetails.furnished != ''}">
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Furnished &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.furnished}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                    </c:if>
                    <%--****************** Residential Sale => Studio, Other Residentials, Apartment/Flat,Service Apartment **************--%>





                <c:if test="${catName == 'sreal-rs-a'}">
                    <c:if test="${moreDetails.prefLocation != null && moreDetails.prefLocation != ''}">
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Property Location &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.prefLocation}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.yearsOld != null && moreDetails.yearsOld != ''}">
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Age of Construction &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.yearsOld}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.area != null && moreDetails.area != ''}">
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Area &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.area}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.noBedRooms != null && moreDetails.noBedRooms != 0}">
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">No. of Bedrooms &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.noBedRooms}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.kmRun != null && moreDetails.kmRun != 0}">
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">No. of Bathrooms &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.kmRun}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.floorNum != null && moreDetails.floorNum != 0}">
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Floor No. &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.floorNum}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.totalFloors != null && moreDetails.totalFloors != 0}">
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Total No. of Floors &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.totalFloors}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.facing != null && moreDetails.facing != ''}">
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Facing &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.facing}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.furnished != null && moreDetails.furnished != ''}">
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Furnished &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.furnished}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <%--<c:if test="${moreDetails.adType!='wanted'}">
                            <c:if test="${moreDetails.cfp!='on'}">
                                <tr align="left">
                                    <td><span style="font-weight:bold;">Negotiation</span></td>
                                    <td><span style="font-weight:bold;">:</span></td>
                                    <td><c:out value="${moreDetails.neg}" /></td>
                                </tr>
                            </c:if>
                        </c:if>--%>
                    </c:if>
                    <%--****************** Residential Sale
                                           Commercial Sale                    => Plot And Land
                                           Commercial Rent ->Industrial Setup                                 **************--%>
                    <c:if test="${catName == 'sreal-ld'}">
                        <c:if test="${moreDetails.prefLocation != null && moreDetails.prefLocation != ''}">
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Property Location &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.prefLocation}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.area != null && moreDetails.area != ''}">
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Area &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.area}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <%--************ Commercial Rent => Plot & Land (Block Start)**********--%>
                        <c:if test="${moreDetails.rentMonth != null && moreDetails.rentMonth != 0}">
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Rent per Month &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.rentMonth}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if><%--************ Commercial Rent => Plot & Land (Block End)**********--%>
                        <c:if test="${moreDetails.facing != null && moreDetails.facing != ''}">
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Facing &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.facing}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <%--<c:if test="${moreDetails.adType!='wanted'}">
                            <c:if test="${moreDetails.cfp!='on'}">
                                <tr align="left">
                                    <td><span style="font-weight:bold;">Negotiation</span></td>
                                    <td><span style="font-weight:bold;">:</span></td>
                                    <td><c:out value="${moreDetails.neg}" /></td>
                                </tr>
                            </c:if>
                        </c:if>--%>
                    </c:if>
                    <%--****************** Residential Sale => Individual House And Farm House **************--%>
                    <c:if test="${catName == 'sreal-rs-ih'}">
                        <c:if test="${moreDetails.prefLocation != null && moreDetails.prefLocation != ''}">
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Property Location &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.prefLocation}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.yearsOld != null && moreDetails.yearsOld != ''}">
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Age of Construction &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.yearsOld}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.area != null && moreDetails.area != ''}">
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Area &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.area}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.noBedRooms != null && moreDetails.noBedRooms != 0}">
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">No. of Bedrooms &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.noBedRooms}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.kmRun != null && moreDetails.kmRun != 0}">
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">No. of Bathrooms &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.kmRun}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.facing != null && moreDetails.facing != ''}">
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Facing &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.facing}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.furnished != null && moreDetails.furnished != ''}">
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Furnished &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.furnished}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <%--<c:if test="${moreDetails.adType!='wanted'}">
                            <c:if test="${moreDetails.cfp!='on'}">
                                <tr align="left">
                                    <td><span style="font-weight:bold;">Negotiation</span></td>
                                    <td><span style="font-weight:bold;">:</span></td>
                                    <td><c:out value="${moreDetails.neg}" /></td>
                                </tr>
                            </c:if>
                        </c:if>--%>
                    </c:if>
                    <%--****************** Commercial Rent => Office, Business Center **************--%>
                    <c:if test="${catName == 'sreal-cr-off'}">
                        <c:if test="${moreDetails.prefLocation != null && moreDetails.prefLocation != ''}">
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Property Location &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.prefLocation}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.area != null && moreDetails.area != ''}">
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Area &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.area}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.floorNum != null && moreDetails.floorNum != 0}">
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Floor No. &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.floorNum}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.totalFloors != null && moreDetails.totalFloors != 0}">
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Total No. of Floors &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.totalFloors}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.rentMonth != null && moreDetails.rentMonth != 0}">
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Rent per Month &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.rentMonth}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.facing != null && moreDetails.facing != ''}">
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Facing &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.facing}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.furnished != null && moreDetails.furnished != ''}">
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Furnished &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.furnished}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                    </c:if>
                    <%--****************** Commercial Rent
                                           Commercial Sale  => WareHouse And Godowns **************--%>
                    <c:if test="${catName == 'sreal-w'}">
                        <c:if test="${moreDetails.prefLocation != null && moreDetails.prefLocation != ''}">
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Property Location &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.prefLocation}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.yearsOld != null && moreDetails.yearsOld != ''}">
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Age of Construction &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.yearsOld}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.area != null && moreDetails.area != ''}">
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Area &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.area}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.floorNum != null && moreDetails.floorNum != 0}">
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Floor No. &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.floorNum}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.totalFloors != null && moreDetails.totalFloors != 0}">
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Total No. of Floors &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.totalFloors}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.rentMonth != null && moreDetails.rentMonth != 0}">
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Rent per Month &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.rentMonth}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.facing != null && moreDetails.facing != ''}">
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Facing &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.facing}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <%--<c:if test="${moreDetails.adType!='wanted'}">
                            <c:if test="${moreDetails.cfp!='on'}">
                                <tr align="left">
                                    <td><span style="font-weight:bold;">Negotiation</span></td>
                                    <td><span style="font-weight:bold;">:</span></td>
                                    <td><c:out value="${moreDetails.neg}" /></td>
                                </tr>
                            </c:if>
                        </c:if>--%>
                    </c:if>
                    <%--*********************Commercial Rent => Shops, Other Commercilas *********************--%>
                    <c:if test="${catName == 'sreal-cr-sh'}">
                        <c:if test="${moreDetails.prefLocation != null && moreDetails.prefLocation != ''}">
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Property Location &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.prefLocation}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.area != null && moreDetails.area != ''}">
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Area &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.area}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.floorNum != null && moreDetails.floorNum != 0}">
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Floor No. &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.floorNum}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.totalFloors != null && moreDetails.totalFloors != 0}">
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Total No. of Floors &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.totalFloors}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.rentMonth != null && moreDetails.rentMonth != 0}">
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Rent per Month &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.rentMonth}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.facing != null && moreDetails.facing != ''}">
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Facing &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.facing}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.furnished != null && moreDetails.furnished != ''}">
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Furnished &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.furnished}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                    </c:if>
                    <%--********************** Commercial Sale => Office, Business Centers, Shops, Business Centers ***********************--%>
                    <c:if test="${catName == 'sreal-cs-off'}">
                        <c:if test="${moreDetails.prefLocation != null && moreDetails.prefLocation != ''}">
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Property Location &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.prefLocation}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.yearsOld != null && moreDetails.yearsOld != ''}">
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Age of Construction &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.yearsOld}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.area != null && moreDetails.area != ''}">
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Area &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.area}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.floorNum != null && moreDetails.floorNum != 0}">
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Floor No. &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.floorNum}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.totalFloors != null && moreDetails.totalFloors != 0}">
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Total No. of Floors &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.totalFloors}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.facing != null && moreDetails.facing != ''}">
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Facing &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.facing}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.furnished != null && moreDetails.furnished != ''}">
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Furnished &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.furnished}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <%--<c:if test="${moreDetails.adType!='wanted'}">
                            <c:if test="${moreDetails.cfp!='on'}">
                                <tr align="left">
                                    <td><span style="font-weight:bold;">Negotiation</span></td>
                                    <td><span style="font-weight:bold;">:</span></td>
                                    <td><c:out value="${moreDetails.neg}" /></td>
                                </tr>
                            </c:if>
                        </c:if>--%>
                    </c:if>
                    <%--********************** Commercial Sale => Industrial Setup ***********************--%>
                    <c:if test="${catName == 'sreal-cs-is'}">
                        <c:if test="${moreDetails.prefLocation != null && moreDetails.prefLocation != ''}">
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Property Location</span> &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.prefLocation}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.yearsOld != null && moreDetails.yearsOld != ''}">
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Age of Construction &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.yearsOld}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.area != null && moreDetails.area != ''}">
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Area &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.area}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.facing != null && moreDetails.facing != ''}">
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Facing &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.facing}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <%--<c:if test="${moreDetails.adType!='wanted'}">
                            <c:if test="${moreDetails.cfp!='on'}">
                                <tr align="left">
                                    <td><span style="font-weight:bold;">Negotiation</span></td>
                                    <td><span style="font-weight:bold;">:</span></td>
                                    <td><c:out value="${moreDetails.neg}" /></td>
                                </tr>
                            </c:if>
                        </c:if>--%>
                    </c:if>
                    <%--********************* RealEstate End *********************--%>

                <%--********************* Electronics & Computers start *********************--%>
                <c:if test="${catName == 'selec'}">

                    <c:if test="${moreDetails.condition!=null && moreDetails.condition!=''}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Condition &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.condition}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.yearsOld!=null && moreDetails.yearsOld!=''}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Years Old &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.yearsOld}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.brand != null && moreDetails.brand != ''}">
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Make &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.brand}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.model!=null && moreDetails.model!=''}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Model &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.model}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <%--<c:if test="${moreDetails.adType!='wanted'}">
                            <c:if test="${moreDetails.cfp!='on'}">
                                <tr align="left">
                                    <td><span style="font-weight:bold;">Negotiation</span></td>
                                    <td><span style="font-weight:bold;">:</span></td>
                                    <td><c:out value="${moreDetails.neg}" /></td>
                                </tr>
                            </c:if>
                        </c:if>--%>
                    </c:if>
                    <%--********** Computer Softwares & Games **********--%>
                    <c:if test="${catName == 'selec-cs'}">

                    <c:if test="${moreDetails.name != null && moreDetails.name != ''}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Company Name &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.name}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.brand!=null && moreDetails.brand!=''}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Product Name &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.brand}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.yearsOld!=null && moreDetails.yearsOld!=''}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Licence Period &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.yearsOld}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <%--<c:if test="${moreDetails.adType!='wanted'}">
                             <c:if test="${moreDetails.cfp!='on'}">
                                 <tr align="left">
                                     <td><span style="font-weight:bold;">Negotiation</span></td>
                                     <td><span style="font-weight:bold;">:</span></td>
                                     <td><c:out value="${moreDetails.neg}" /></td>
                                 </tr>
                             </c:if>
                         </c:if>--%>
                    </c:if>
                    <%--********************* Electronics & Computers End *********************--%>

                <%--********************* Furniture start *********************--%>
                <c:if test="${catName == 'sfurn'}">
                    <c:if test="${moreDetails.condition!=null && moreDetails.condition!=''}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Condition &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.condition}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.yearsOld!=null && moreDetails.yearsOld!=''}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Years Old &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.yearsOld}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.measurement!=null && moreDetails.measurement!=''}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Dimensions &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.measurement}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDeatils.brand != null && moredetails.brand != ''}">
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Make &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.brand}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.model!=null && moreDetails.model!=''}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Model &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.model}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.color!=null && moreDetails.color!=''}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Colour &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.color}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.material!=null && moreDetails.material!=''}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Material &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.material}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <%--<c:if test="${moreDetails.adType!='wanted'}">
                            <c:if test="${moreDetails.cfp!='on'}">
                                <tr align="left">
                                    <td><span style="font-weight:bold;">Negotiation</span></td>
                                    <td><span style="font-weight:bold;">:</span></td>
                                    <td><c:out value="${moreDetails.neg}" /></td>
                                </tr>
                            </c:if>
                        </c:if>--%>
                    </c:if>
                    <%--********************* Furniture End *********************--%>

                <%--********************* Home Appliances start *********************--%>
                <c:if test="${catName == 'shome'}">
                    <c:if test="${moreDetails.condition!=null && moreDetails.condition!=''}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Condition &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.condition}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.yearsOld!=null && moreDetails.yearsOld!=''}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Years Old &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.yearsOld}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDeatils.brand != null && moredetails.brand != ''}">
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Make &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.brand}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.model!=null && moreDetails.model!=''}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Model &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.model}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.color!=null && moreDetails.color!=''}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Colour &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.color}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <%--<c:if test="${moreDetails.adType!='wanted'}">
                            <c:if test="${moreDetails.cfp!='on'}">
                                <tr align="left">
                                    <td><span style="font-weight:bold;">Negotiation</span></td>
                                    <td><span style="font-weight:bold;">:</span></td>
                                    <td><c:out value="${moreDetails.neg}" /></td>
                                </tr>
                            </c:if>
                        </c:if>--%>
                    </c:if>
                    <%--********************* Home Appliances End *********************--%>

                <%--********************* Domestic Service Start *********************--%>
                <c:if test="${catName == 'sdomestic'}">
                    <c:if test="${moreDetails.name!=null && moreDetails.name!=''}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Company Name &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.name}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.prefLocation!=null && moreDetails.prefLocation!=''}" >
                        <<div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Address &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.prefLocation}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                    </c:if>
                    <%--*************** Shopping Malls ************--%>
                    <c:if test="${catName == 'sdomestic-sh'}">
                        <c:if test="${moreDetails.name!=null && moreDetails.name!=''}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Shop Name &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.name}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.prefLocation!=null && moreDetails.prefLocation!=''}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Address &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.prefLocation}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                    </c:if>
                    <%--********************* Domestic Service End *********************--%>

                <%--********************* Travel & Vacation Start *********************--%>
                <c:if test="${catName == 'stravel'}">
                    <c:if test="${moreDetails.name!=null && moreDetails.name!=''}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Travels Name &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.name}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.prefLocation!=null && moreDetails.prefLocation!=''}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Address &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.prefLocation}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                    </c:if>
                    <%--************** Vacations ************--%>
                    <c:if test="${catName == 'stravel-v'}">
                        <c:if test="${moreDetails.type!=null && moreDetails.type!=''}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Accommodation Type &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.type}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                    </c:if>
                    <%--********************* Travel & Vacation End *********************--%>

                <%--********************* Jobs & Education Start *********************--%>
                <c:if test="${catName == 'sjobs'}">
                    <c:if test="${moreDetails.name!=null && moreDetails.name!=''}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Your Name &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.name}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.qualification!=null && moreDetails.qualification!=''}" >

                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Qualification &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.qualification}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.kmRun != null && moreDetails.kmRun != 0}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Salary &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.kmRun}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.prefLocation !=null && moreDetails.prefLocation!=''}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Job Location &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.prefLocation}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                    </c:if>
                    <%--************* Education ************--%>
                    <c:if test="${catName == 'sjobs-edu'}">
                        <c:if test="${moreDetails.name!=null && moreDetails.name!=''}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Course Name &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.name}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.qualification!=null && moreDetails.qualification!=''}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Qualification &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.qualification}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.prefLocation!=null && moreDetails.prefLocation!=''}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Address &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.prefLocation}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.kmRun!=null && moreDetails.kmRun!=0}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Fee &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.kmRun}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                    </c:if>
                    <%--********************* Jobs & Education End *********************--%>

                <%--********************* Clothing & Jewellary Start *********************--%>
                <c:if test="${catName == 'sjewel'}">
                    <%--Jewellary rows--%>
                    <c:if test="${moreDetails.condition!=null && moreDetails.condition!=''}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Condition &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.condition}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.yearsOld!=null && moreDetails.yearsOld!=''}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Years Old &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.yearsOld}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.brand!=null && moreDetails.brand!=''}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Make &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.brand}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.model!=null && moreDetails.model!=''}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Model &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.model}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.material!='' && moreDetails.material!=null}">
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Meterial &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.material}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.measurement!=null && moreDetails.measurement!=''}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Size &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.measurement}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <%--<c:if test="${moreDetails.adType!='wanted'}">
                            <c:if test="${moreDetails.cfp!='on'}">
                                <tr align="left">
                                    <td><span style="font-weight:bold;">Negotiation</span></td>
                                    <td><span style="font-weight:bold;">:</span></td>
                                    <td><c:out value="${moreDetails.neg}" /></td>
                                </tr>
                            </c:if>
                        </c:if>--%>
                    </c:if>
                    <%--*************** Jewllary ***********--%>
                    <c:if test="${catName == 'sjewel-j'}">
                        <%--Jewellary rows--%>
                        <c:if test="${moreDetails.condition!=null && moreDetails.condition!=''}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Condition &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.condition}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.yearsOld!=null && moreDetails.yearsOld!=''}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Years Old &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.yearsOld}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.brand!=null && moreDetails.brand!=''}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Make &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.brand}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.material!='' && moreDetails.material!=null}">
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Meterial &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.material}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.measurement!=null && moreDetails.measurement!=''}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Size &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.measurement}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.weight!=null && moreDetails.weight!=''}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Weight &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.weight}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <%--<c:if test="${moreDetails.adType!='wanted'}">
                            <c:if test="${moreDetails.cfp!='on'}">
                                <tr align="left">
                                    <td><span style="font-weight:bold;">Negotiation</span></td>
                                    <td><span style="font-weight:bold;">:</span></td>
                                    <td><c:out value="${moreDetails.neg}" /></td>
                                </tr>
                            </c:if>
                        </c:if>--%>
                    </c:if>
                    <%--********************* Clothing & Jewellary End *********************--%>

                <%--********************* EquipMent Start *********************--%>
                <c:if test="${catName == 'soffice'}">
                    <c:if test="${moreDetails.condition!=null && moreDetails.condition!=''}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Condition &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.condition}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.yearsOld!=null && moreDetails.yearsOld!=''}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Years Old &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.yearsOld}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.brand!=null && moreDetails.brand!=''}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Make &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.brand}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.model!=null && moreDetails.model!=''}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Model &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.model}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.color!=null && moreDetails.color!=''}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Colour &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.color}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.measurement!=null && moreDetails.measurement!=''}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Dimensions &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.measurement}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <%--<c:if test="${moreDetails.adType!='wanted'}">
                            <c:if test="${moreDetails.cfp!='on'}">
                                <tr align="left">
                                    <td><span style="font-weight:bold;">Negotiation</span></td>
                                    <td><span style="font-weight:bold;">:</span></td>
                                    <td><c:out value="${moreDetails.neg}" /></td>
                                </tr>
                            </c:if>
                        </c:if>--%>
                    </c:if>
                    <%--********************* EquipMent End *********************--%>

                <%--********************* Finacial Services Start *********************--%>
                <c:if test="${catName == 'sfinance'}">
                    <c:if test="${moreDetails.name!=null && moreDetails.name!=''}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Name &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.name}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.kmRun!=null && moreDetails.kmRun!=''}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">IntrestRate &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.kmRun}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.yearsOld!=null && moreDetails.yearsOld!=''}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Tenure &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.yearsOld}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                    </c:if>
                    <%--********************* Finacial Services end *********************--%>

                <%--********************* Sports And Recreations Start *********************--%>
                <%--*********** Sports Items ***********--%>
                <c:if test="${catName == 'ssport'}">
                    <c:if test="${moreDetails.name!=null && moreDetails.name!=''}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Item Name &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.name}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.brand!=null && moreDetails.brand!=''}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Make &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.brand}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>

                </c:if>
                <%--*********** Sports Trainers & Trainings ***********--%>
                <c:if test="${catName == 'ssport-t'}">
                    <c:if test="${moreDetails.name!=null && moreDetails.name!=''}">
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Name &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.name}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.prefLocation!=null && moreDetails.prefLocation!=''}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Address &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.prefLocation}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.note!=null && moreDetails.note!=''}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Timings &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.note}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                    </c:if>
                    <%--********************* Sports And Recreations End *********************--%>

                <%--********************* Constructions Start *********************--%>
                <%--*********** Construction Labour ***********--%>
                <c:if test="${catName == 'scon'}">
                    <c:if test="${moreDetails.name!=null && moreDetails.name!=''}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Name &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.name}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.prefLocation!=null && moreDetails.prefLocation!=''}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Address &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.prefLocation}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>

                </c:if>
                <%--*********** Construction Materials ***********--%>
                <c:if test="${catName == 'scon-m'}">
                    <c:if test="${moreDetails.material!=null && moreDetails.material!=''}">
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Material &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.material}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.brand!=null && moreDetails.brand!=''}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Make &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.brand}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.measurement!=null && moreDetails.measurement!=''}" >
                        < <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Dimensions &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.measurement}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.weight!=null && moreDetails.weight!=''}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Weight &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.weight}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                    </c:if>
                    <%--********************* Constructions End *********************--%>

                <%--*********************Arts & Antiques Start*********************--%>
                <c:if test="${catName == 'santiq'}">
                    <c:if test="${moreDetails.objects != null && moreDetails.objects!=''}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Object &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.objects}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.collectables != null && moreDetails.collectables!=''}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Object&nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.collectables}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.type != null && moreDetails.type!=''}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Object &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.type}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.yearsOld != null && moreDetails.yearsOld!=''}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Year/Era &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.yearsOld}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <%--<c:if test="${moreDetails.adType!='wanted'}">
                            <c:if test="${moreDetails.cfp!='on'}">
                                <tr align="left">
                                    <td><span style="font-weight:bold;">Negotiation</span></td>
                                    <td><span style="font-weight:bold;">:</span></td>
                                    <td><c:out value="${moreDetails.neg}" /></td>
                                </tr>
                            </c:if>
                        </c:if>--%>
                    </c:if>
                    <%--********************* Arts & Antiques End *********************--%>

                <%--********************* Astro Services Start *********************--%>
                <c:if test="${catName == 'sastro'}">
                    <c:if test="${moreDetails.name != null && moreDetails.name!=''}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Name &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.name}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.prefLocation != null && moreDetails.prefLocation!=''}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Address &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.prefLocation}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                    </c:if>
                    <%--********************* Astro Services End *********************--%>

                <%--********************* Pets Start *********************--%>
                <%--*********** Pets **********--%>
                <c:if test="${catName == 'spets'}">
                    <c:if test="${moreDetails.breed!=null && moreDetails.breed!=''}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Breed &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.breed}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.yearsOld!=null && moreDetails.yearsOld!=''}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Aged &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.yearsOld}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <%--<c:if test="${moreDetails.adType!='wanted'}">
                            <c:if test="${moreDetails.cfp!='on'}">
                                <tr align="left">
                                    <td><span style="font-weight:bold;">Negotiation</span></td>
                                    <td><span style="font-weight:bold;">:</span></td>
                                    <td><c:out value="${moreDetails.neg}" /></td>
                                </tr>
                            </c:if>
                        </c:if>--%>
                    </c:if>
                    <%--************* Pet Accessories ***********--%>
                    <c:if test="${catName == 'spets-ac'}">
                        <c:if test="${moreDetails.condition!=null && moreDetails.condition!=''}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Condition &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.condition}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.yearsOld!=null && moreDetails.yearsOld!=''}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Years Old &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.yearsOld}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.type!=null && moreDetails.type!=''}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Pet Type &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.type}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.name!=null && moreDetails.name!=''}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Name &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.name}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.brand!=null && moreDetails.brand!=''}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Make &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.brand}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.model!=null && moreDetails.model!=''}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Model &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.model}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <%--<c:if test="${moreDetails.adType!='wanted'}">
                            <c:if test="${moreDetails.cfp!='on'}">
                                <tr align="left">
                                    <td><span style="font-weight:bold;">Negotiation</span></td>
                                    <td><span style="font-weight:bold;">:</span></td>
                                    <td><c:out value="${moreDetails.neg}" /></td>
                                </tr>
                            </c:if>
                        </c:if>--%>
                    </c:if>
                    <%--*************** Pet Services ************--%>
                    <c:if test="${catName == 'spets-pe'}">
                        <c:if test="${moreDetails.name!=null && moreDetails.name!=''}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Name &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.name}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.prefLocation!=null && moreDetails.prefLocation!=''}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Address &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.prefLocation}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                    </c:if>
                    <%--************* Lost Pets **********--%>
                    <c:if test="${catName == 'spets-lp'}">
                        <c:if test="${moreDetails.type!=null && moreDetails.type!=''}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Pet Type &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.type}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.name!=null && moreDetails.name!=''}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Pet Name &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.name}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.brand!=null && moreDetails.brand!=''}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Lost Date &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.brand}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.note!=null && moreDetails.note!=''}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Identifications &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.note}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.prefLocation!=null && moreDetails.prefLocation!=''}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Address &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.prefLocation}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                    </c:if>
                    <%--********************* Pets End *********************--%>

                <%--********************* Musical Equipment Start *********************--%>
                <c:if test="${catName == 'smusic'}">
                    <c:if test="${moreDetails.condition!=null && moreDetails.condition!=''}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Condition &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.condition}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.yearsOld!=null && moreDetails.yearsOld!=''}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Years Old &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.yearsOld}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.brand!=null && moreDetails.brand!=''}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Make &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.brand}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.model!=null && moreDetails.model!=''}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Model &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.model}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <%--<c:if test="${moreDetails.adType!='wanted'}">
                            <c:if test="${moreDetails.cfp!='on'}">
                                <tr align="left">
                                    <td><span style="font-weight:bold;">Negotiation</span></td>
                                    <td><span style="font-weight:bold;">:</span></td>
                                    <td><c:out value="${moreDetails.neg}" /></td>
                                </tr>
                            </c:if>
                        </c:if>--%>
                    </c:if>
                    <%--********************* Musical Equipment End **********************--%>

                <%--********************* Kids Stuff Start *********************--%>
                <c:if test="${catName == 'skids'}">
                    <c:if test="${moreDetails.condition!=null && moreDetails.condition!=''}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Condition &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.condition}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.yearsOld!=null && moreDetails.yearsOld!=''}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Years Old &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.yearsOld}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.brand!=null && moreDetails.brand!=''}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Make &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.brand}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${catName == 'shealth'}">
                            <c:if test="${moreDetails.name!=null && moreDetails.name!=''}" >
                            <div class="adtypy_inner_left_cont">
                                <div class="adtypy_left_top_cont">Name &nbsp;</div>
                                <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.name}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                            </c:if>
                            <c:if test="${moreDetails.prefLocation!=null && moreDetails.prefLocation!=''}" >
                            <div class="adtypy_inner_left_cont">
                                <div class="adtypy_left_top_cont">Address &nbsp;</div>
                                <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.prefLocation}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                                <c:if test="${moreDetails.note!=null && moreDetails.note!=''}" >
                                <div class="adtypy_inner_left_cont">
                                    <div class="adtypy_left_top_cont">Timings &nbsp;</div>
                                    <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.note}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                                </c:if>
                                <c:if test="${moreDetails.kmRun!=null && moreDetails.kmRun!=''}" >
                                <div class="adtypy_inner_left_cont">
                                    <div class="adtypy_left_top_cont">Fee &nbsp;</div>
                                    <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.kmRun}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                                </c:if>
                            </c:if>c:if test="${moreDetails.model!=null && moreDetails.model!=''}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Model &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.model}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.measurement!=null && moreDetails.measurement!=''}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Dimensions &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.measurement}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <%-- </table>--%>
                        <%--<c:if test="${moreDetails.adType!='wanted'}">
                            <c:if test="${moreDetails.cfp!='on'}">
                                <tr align="left">
                                    <td><span style="font-weight:bold;">Negotiation</span></td>
                                    <td><span style="font-weight:bold;">:</span></td>
                                    <td><c:out value="${moreDetails.neg}" /></td>
                                </tr>
                            </c:if>
                        </c:if>--%>
                    </c:if>
                    <%--********************* Kids Stuff End *********************--%>

                <%--********************* Community Start *********************--%>
                <c:if test="${catName == 'scommunity'}">
                    <%-- Community rows--%>
                </c:if>
                <%--********************* Community End *********************--%>

                <%--********************* Books & Magazines Start *********************--%>
                <c:if test="${catName == 'sbook'}">
                    <c:if test="${moreDetails.condition!=null && moreDetails.condition!=''}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Condition &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.condition}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.yearsOld!=null && moreDetails.yearsOld!=''}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Years Old &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.yearsOld}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.name!=null && moreDetails.name!=''}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Book Title &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.name}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.author!=null && moreDetails.author!=''}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Author &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.author}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.language!=null && moreDetails.language!=''}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Language &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.language}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.publication!=null && moreDetails.publication!=''}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Publications &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.publication}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.adType!='wanted'}">
                            <c:if test="${moreDetails.cfp!='on'}">
                            <div class="adtypy_inner_left_cont">
                                <div class="adtypy_left_top_cont">Negotiation &nbsp;</div>
                                <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.neg}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                            </c:if>
                        </c:if>
                    </c:if>
                    <%--********************* Books & Magazines Ends *********************--%>

                <%--********************* Entertainment & Events Start *********************--%>
                <c:if test="${catName == 'senter'}">
                    <c:if test="${moreDetails.name!=null && moreDetails.name!=''}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Name &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.name}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.prefLocation!=null && moreDetails.prefLocation!=''}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Address &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.prefLocation}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                    </c:if>
                    <%--***************** Events ***************--%>
                    <c:if test="${catName == 'senter-ev'}">
                        <c:if test="${moreDetails.name!=null && moreDetails.name!=''}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Name &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.name}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.prefLocation!=null && moreDetails.prefLocation!=''}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Venue &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.prefLocation}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.brand!=null && moreDetails.brand!=''}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Date &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.brand}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.model!=null && moreDetails.model!=''}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Timings &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.model}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                    </c:if>
                    <%--***************** Music ***************--%>
                    <c:if test="${catName == 'senter-mu'}">
                        <c:if test="${moreDetails.name!=null && moreDetails.name!=''}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Name &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.name}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.type!=null && moreDetails.type!=''}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Type Of music &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.type}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                    </c:if>
                    <%--********************* Entertainment & Events Ends *********************--%>

                <%--********************* Personal Start *********************--%>
                <c:if test="${catName == 'spersonal'}">
                    Personals rows
                </c:if>
                <%--********************* Personal Ends *********************--%>

                <%-- ********************* Health, Fitness & Beauty Start *********************--%>
                <c:if test="${catName == 'shealth'}">
                    <c:if test="${moreDetails.name!=null && moreDetails.name!=''}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Name &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.name}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.prefLocation!=null && moreDetails.prefLocation!=''}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Address &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.prefLocation}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.note!=null && moreDetails.note!=''}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Timings &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.note}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.kmRun!=null && moreDetails.kmRun!=''}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Fee &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.kmRun}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                    </c:if>
                    <%-- **************** Beauty & Health Care Products ***********--%>
                    <c:if test="${catName == 'shealth-hc'}">
                        <c:if test="${moreDetails.name!=null && moreDetails.name!=''}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Product Name &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.name}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.brand!=null && moreDetails.brand!=''}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Make &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.brand}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.model!=null && moreDetails.model!=''}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Model &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.model}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.adType!='wanted'}">
                            <c:if test="${moreDetails.cfp!='on'}">
                            <div class="adtypy_inner_left_cont">
                                <div class="adtypy_left_top_cont">Negotiation &nbsp;</div>
                                <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.neg}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                            </c:if>
                        </c:if>
                    </c:if>
                    <%-- **************** Pharmacy ************** --%>
                    <c:if test="${catName == 'shealth-ph'}">
                        <c:if test="${moreDetails.name!=null && moreDetails.name!=''}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Pharmacy Name &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.name}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.prefLocation!=null && moreDetails.prefLocation!=''}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Address &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.prefLocation}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.model!=null && moreDetails.model!=''}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Specialist &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.model}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.note!=null && moreDetails.note!=''}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Timings &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.note}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                    </c:if>
                    <%-- ************** Hospitals ************** --%>
                    <c:if test="${catName == 'shealth-hs'}">
                        <c:if test="${moreDetails.name!=null && moreDetails.name!=''}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Hospital Name &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.name}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.prefLocation!=null && moreDetails.prefLocation!=''}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Address &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.prefLocation}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.model!=null && moreDetails.model!=''}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Specialist &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.model}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.note!=null && moreDetails.note!=''}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Timings &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.note}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.kmRun!=null && moreDetails.kmRun!=''}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Consultation Fee &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.kmRun}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                    </c:if>

                <%--********************* Health, Fitness & Beauty End *********************--%>

                <%--  ********************* Matrimony Start *********************--%>


                <c:if test="${catName == 'smat'}">
                    <c:if test="${moreDetails.name!=null && moreDetails.name!=''}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Name &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.name}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.yearsOld!=null && moreDetails.yearsOld!=''}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Age &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.yearsOld}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.type!=null && moreDetails.type!=''}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Religion< &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.type}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.brand!=null && moreDetails.brand!=''}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Father's Name &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.brand}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.model!=null && moreDetails.model!=''}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">Mother's Name &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.model}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.height!=null && moreDetails.height!=''}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">No. of Sisters &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.height}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                        <c:if test="${moreDetails.weight!=null && moreDetails.weight!=''}" >
                        <div class="adtypy_inner_left_cont">
                            <div class="adtypy_left_top_cont">No. of Brothers &nbsp;</div>
                            <div class="adtypy_right_top_cont">: <c:out value="${moreDetails.weight}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
                        </c:if>
                    </c:if>
                    <%--********************* Matrimony End **********************--%>
            </div>

            <%--

                    <div class="adtypy_left_top_cont">Adtype </div>
                    <div class="adtypy_right_top_cont">: 25/12/2012</div>--%>


            <div class="user_info_cont">
                <div class="user_info_main_left_cont">
                    <div class="user_information_cont_txt" style="margin-bottom:10px;">User Information</div><br />
                    <div class="user_information_cont_txt"><img src="<%=localUrlPath%>/bbsimages/New/user_info_img.png" width="46" height="46" align="left" style="margin:7px 35px 0 0;"/><font color="#046dbe">Contact : </font> <c:out value="${moreDetails.firstName}" /><br />


                        <div id='basic-modal'>
                            <div class="car_viwe_details_buton" id ="viewConBtn">
                                <a input type="button" name='basic' value='View Details' class='basic' href="javascript:void(0);" onclick="showConDetails(this);"> </a>
                                <!-- <a href="javascript:void(0);" id="contact-button"  onclick="showConDetails(this);"></a>-->
                            </div>
                        </div>


                        <div id ="cntdtl" style="display:none" class="user_information_cont_mbl" > Mobile : <c:out value="${moreDetails.mobile}" />,<br/>
                            <c:set var="em" value="${moreDetails.email}"/><c:if test="${fn:endsWith(em,'@b.com')==false}"><c:if test="${fn:endsWith(em,'@bi.com')==false}">Email : <c:out value="${moreDetails.email}" /></c:if></c:if><br/>
                                    <div style="color: red;margin-top: 5px;"> While contacting me, please mention that you found this Ad on BharatBuySell.</div>
                                </div>
                            </div>
                        </div>
                <c:if test="${moreDetails.sponsType > 1}">
                    <div style="float:left;padding-top:20px;  ">
                        <a href="<%=localUrlPath%>/dealersAllAds.do?Uid=${moreDetails.userId}"  title="Check All Ads" target="_blank"/> <img src="<%=localUrlPath%>/resourceGetter?imf=${moreDetails.dlrLogo}" width="120px" height="60px" style="border:3px solid #CCCCCC;" /></a>
                    </div>
                </c:if>
                <div class="user_info_main_right_cont">
                    <div class="ad_options"> <strong style="margin-left:5px;font-weight:bold">Ad Options</strong></div>
                    <div class="ad_options" style="margin-top:15px;">
                        <li><a href="javascript:void(0);" onclick="toggle_email_it('email${moreDetails.adId}');event.returnValue=false;return false;" title="Email to Friend"><img src="<%=localUrlPath%>/bbsimages/New/car_send_to_img.png" alt="" width="20" height="18" border="0" align="left"  style="margin:0 20px 0px 2px;"/>Send to Friend </a></li>
                    </div>
                    <div class="ad_options" style="margin-top:7px;">
                        <li><a href="javascript:void(0);" onclick="toggle_sms_it('sms${moreDetails.adId}');event.returnValue=false;return false;" title="Contact Advertiser"><img src="<%=localUrlPath%>/bbsimages/New/car_sms_img.png" alt="" width="20" height="22" border="0" align="left" style="margin:0 20px 0 2px;"/>SMS Advertiser </a></li>
                    </div>
                    <div class="ad_options" style="margin-top:7px;">
                        <li><a href='javascript:void(0);' onclick="toggle_save_it('save${moreDetails.adId}');event.returnValue=false;return false;" title="Save Ad"><img src="<%=localUrlPath%>/bbsimages/New/car_saved_img.png" alt="" width="25" height="25" border="0" align="left" style="margin:0 20px 0 0px;"/>Save Ad </a></li>
                    </div>
                </div>
            </div>

            <%--<tr>
                         <td><table>
                 <c:if test="${moreDetails.totalVisitors != '0'}" >
                 <tr>
                     <td>&nbsp;</td>
                     <td style="text-align:right">
                         No.Of Views :<b> ${moreDetails.totalVisitors}</b>
                     </td>
                 </tr>
                 </c:if>
            --%>







            <script type="text/javascript">
                var R=0;
                var S=0;
                <c:if test='${userBean != null}' >
                    R=1;
                    <c:if test="${userBean.evStatus == 'V' }" >
                        EV=1;
                    </c:if>
                </c:if>
                    function validateqr(lid,name,city,ph,code,divID)
                    {
                        var chk=true;
                        var result=checkMobileNum(ph,divID);
                        if(result == true)
                        {
                            document.getElementById("table"+divID).style.display="none";
                            document.getElementById("img"+divID).style.display="inline";
                            var res=quickRegAjax(lid,name,city,ph,code,divID);
                            if(res == true)
                                chk=true;
                            else
                                chk=false;
                        }else
                        {
                            document.getElementById("conf"+divID).innerHTML="";
                            document.getElementById("conf"+divID).innerHTML="Invalid Data";
                            document.getElementById("table"+divID).style.display="inline";
                            document.getElementById("img"+divID).style.display="none";
                            chk=false;
                        }
                        return chk;
                    }
                    // var eu=new Array();
                    var count=0;
                    function closeAllOtherDivs(itemId)
                    {
                        closeAllOtherDivsNoParam();
                        // to erase prev o/p
                        document.getElementById("msg"+itemId+"wl").innerHTML="";
                        document.getElementById("msg"+itemId+"al").innerHTML="";
                    }
                    function closeAllOtherDivsNoParam()
                    {
                        toggle_close_it('save${moreDetails.adId}wl') ;
                        toggle_close_it('save${moreDetails.adId}al') ;
                        toggle_close_it('sms${moreDetails.adId}wl') ;
                        toggle_close_it('sms${moreDetails.adId}al') ;
                        toggle_close_it('email${moreDetails.adId}wl') ;
                        toggle_close_it('email${moreDetails.adId}al') ;
                        toggle_close_it('nu${moreDetails.adId}') ;
                        toggle_close_it('fp${moreDetails.adId}') ;
                        toggle_close_it('view${moreDetails.adId}wl');                         <%--Karteek--%>
                    }
                    function displayALForm(itemId)
                    {
                        toggle_open_it(itemId+"al");
                        toggle_open_it('form'+itemId+"al");//make inline which was individually make none
                        // document.getElementById(itemId+"al").focus();
                    }
                    function displayWLForm(itemId)
                    {
                        toggle_open_it(itemId+"wl");
                        toggle_open_it('form'+itemId+"wl");//make inline which was individually make none
                        //  document.getElementById(itemId+"wl").focus();
                    }
                    function showingLoading(itemId)
                    {
                        document.getElementById("msg"+itemId).innerHTML="";// erase prev o/p
                        toggle_close_it("form"+itemId);//make none to show process
                        toggle_open_it("load"+itemId); // display loading img
                    }
                    function toggle_search_it(itemId)
                    {
                        document.getElementById('qrSaveSearch').style.display = 'none';
                        document.getElementById('fpss').style.display = 'none';
                        closeAllOtherDivs(itemId);
                        if(R == 0)
                        {
                            displayWLForm(itemId);
                        }
                        else
                        {
                            displayALForm(itemId);
                        }
                    }
                    function toggle_alert_it(itemId)
                    {
                        document.getElementById('qrSaveAlert').style.display = 'none';
                        document.getElementById('fpsa').style.display = 'none';
                        closeAllOtherDivs(itemId);
                        if(R == 0)
                        {
                            displayWLForm(itemId);
                        }
                        else
                        {
                            displayALForm(itemId);
                        }
                    }
                    function toggle_save_it(itemId)
                    {
                        //if ((document.getElementById(itemId).style.display == 'none'))
                        closeAllOtherDivs(itemId);
                        if(R == 0)
                        {
                            displayWLForm(itemId);
                        }
                        else
                        {
                            displayALForm(itemId);
                        }
                    }
                    function toggle_sms_it(itemId){
                        closeAllOtherDivs(itemId);
                        if(R == 0)
                        {
                            displayWLForm(itemId);
                        }
                        else
                        {
                            displayALForm(itemId);
                        }
                        return false;
                    }
                    function toggle_email_it(itemId){
                        closeAllOtherDivs(itemId);
                        if(R == 0)
                        {
                            displayWLForm(itemId);
                        }
                        else
                        {
                            displayALForm(itemId);
                        }
                        return false;
                    }
                    /*This function used for qucickregistration div display*/
                    function toggle_qr(itemId,purpose,mb,adt)
                    {
                        closeAllOtherDivsNoParam();
                        toggle_open_it(itemId);
                        var element1 = document.createElement("input");
                        //Assign different attributes to the element.
                        element1.setAttribute("id",itemId+purpose);
                        element1.setAttribute("type", "hidden");
                        element1.setAttribute("value", purpose);
                        element1.setAttribute("name", itemId+'purpose');
                        var foo = document.getElementById("form"+itemId);
                        foo.appendChild(element1);
                        var element2 = document.createElement("input");
                        element2.setAttribute("type","hidden");
                        element2.setAttribute("name","advtMobile");
                        element2.setAttribute("value",mb);
                        element2.setAttribute("type","hidden");
                        var foo1=document.getElementById("form"+itemId);
                        foo1.appendChild(element2);
                        var element3 = document.createElement("input");
                        element3.setAttribute("type","hidden");
                        element3.setAttribute("name","adTitle");
                        element3.setAttribute("value",adt);
                        element3.setAttribute("type","hidden");
                        var foo2=document.getElementById("form"+itemId);
                        foo2.appendChild(element3);
                        return false;
                    }
                    function toggle_fp(itemId)
                    {
                        closeAllOtherDivsNoParam();
                        toggle_open_it(itemId);
                        return false;
                    }
                    function toggle_close_it(itemId)
                    {
                        document.getElementById(itemId).style.display='none';
                        return false;
                    }
                    function toggle_open_it(itemId)
                    {
                        document.getElementById(itemId).style.display='inline';
                        return false;
                    }
                    var count=0;
                    function changeVrificationCodeQr(imgId)
                    {
                        count++;
                        document.getElementById(imgId).src='<%=localUrlPath%>/rig?1='+count;
                    }
                    function validateQuickRegFormLA(qrform)
                    {
                        var firstName=qrform.firstName.value;
                        var city=qrform.city.value;
                        var mobile=qrform.mobile.value;
                        var iagree=qrform.iagree.checked;
                        var userName=qrform.userName.value;
                        var chk=false;
                        var mobileRegex= /^([987]{1})([0123456789]{1})([0-9]{8})$/;
                        if(userName =="")
                        {
                            alert("Enter your Mail ID");
                            chk=false;
                        }
                        else if(firstName =="")
                        {
                            alert("Enter your name");
                            chk=false;
                        }else if(city == "")
                        {
                            alert("Please select city");
                            chk=false;
                        }
                        else if(mobile == "") {
                            alert('You must enter your phone number.');
                            chk=false;
                        }
                        else if(!mobile.match(mobileRegex)) {
                            alert('You have entered an invalid phone number.');
                            chk=false;
                        }else if(!iagree)
                        {
                            alert("please accept the terms and conditions ");
                            chk=false;
                        }else
                        {
                            var purp = 'nupop${moreDetails.adId}view';
                            if(document.getElementById(purp).value=='view') {
                                chk=false;
                                viewContactAjaxFun('view${moreDetails.adId}wl',"adId=${moreDetails.adId}&adPostedUserId=${moreDetails.userId}&userName="+userName+"&firstName="+firstName+"&city="+city+"&mobile="+mobile);
                            } else {
                                chk=true;
                            }
                        }
                        return chk;
                    }
                <%--  Karteek--%>
                    function showConDetails()
                    {
                        if (R==0)
                        {
                            $('#basic-modal-content').modal();
                            $( "#frgt-pswd" ).click(function (e) {
                                                               
                                $.modal.close();
                                $( "#rst-pswd" ).modal();
                                                          
                            });
                            var itemId="nupop${moreDetails.adId}";
                            var purpose="view";
                            var element1 = document.createElement("input");
                            element1.setAttribute("id",itemId+purpose);
                            element1.setAttribute("type", "hidden");
                            element1.setAttribute("value", purpose);
                            element1.setAttribute("name", itemId+'purpose');
                            var foo = document.getElementById("form"+itemId);
                            foo.appendChild(element1);
                        }
                <%--closeAllOtherDivsNoParam();
                document.getElementById("msgview${moreDetails.adId}wl").innerHTML="";
                toggle_open_it('view${moreDetails.adId}wl');
                toggle_open_it('formview${moreDetails.adId}wl');
                document.getElementById("view${moreDetails.adId}wl").focus();--%>
                        else{
                            viewContactAjaxFun('view${moreDetails.adId}wl',"adId=${moreDetails.adId}&adPostedUserId=${moreDetails.userId}");
                        }
                        return false;
                    }
                <%-- /Karteek--%>
            </script>
            <%--    <!-- ********************************************************************************************************** -->
                    <!--   SAVE AD BLOCK STARTS   -->
                    <!-- ********************************************************************************************************** -->
            --%>
            <!-- this works when user not logged in -->
            <div class="boxBorder4" id="save${moreDetails.adId}wl" style="width:100%;float:left;display:none">
                <div class="header" style="width:100%;padding-top:10px;" >
                    <div style="float:left;width:60%;text-align:left;"><span style="font-family:sans-serif;font-size:12px;font-weight:bold;padding-left:3px">To save this Ad</span>
                        <span style="font-family:sans-serif;font-size:12px;">&nbsp;(Please Login)</span>
                    </div>
                    <div style="float:left;width:35%;text-align:right;font-size:12px;font-family:sans-serif;"><a href="javascript:return false;" onclick="toggle_qr('nu${moreDetails.adId}','save');event.returnValue=false;return false;" title="Register">Register</a>&nbsp;|&nbsp;
                        <a href="javascript:return false;" onclick="toggle_fp('fp${moreDetails.adId}');event.returnValue=false;return false;" title="Forgot Password">Forgot Password</a></div>
                    <div style="float:left;width:5%;text-align:right;"> <input type="image" src="<%=localUrlPath%>/bbsimages/c1.png" onclick="toggle_close_it('save${moreDetails.adId}wl')"/> </div>
                </div>
                <div id="formsave${moreDetails.adId}wl" style="font-family:sans-serif;font-size:12px;padding: 1px auto;"> <br/><br/>
                    <table style="margin:0 auto;">
                        <tr>
                            <td  width="12%" style="text-align:center"> User Id</td>
                            <td> <input id="lsave${moreDetails.adId}wl" name="loginName" style="height:18px;font-size:12px;" type="text" size="35" /></td>
                            <td width="15%" style="text-align:center">Password</td>
                            <td><input id="psave${moreDetails.adId}wl" name="pwd" style="height:18px;font-size:12px;" type="password" size="35" /></td>
                            <td width="15%" style="text-align:right"><input type="image"  src="<%=localUrlPath%>/bbsimages/buttons/SaveAd.png" onmouseover="this.src='<%=localUrlPath%>/bbsimages/buttons/SaveAd_MouseOver.png'" onmouseout="this.src='<%=localUrlPath%>/bbsimages/buttons/SaveAd.png'" onclick="SaveAdWL('save${moreDetails.adId}wl',${moreDetails.adId})" /></td>
                        </tr>
                    </table>
                </div><br/>
                <div id="loadsave${moreDetails.adId}wl" style="width:auto;padding:2px 0 2px 350px;display:none"> <img src="<%=localUrlPath%>/images/loading.gif"  style="width:32px;height:32px" alt="loading"/><br/></div>
                <span style="padding:0 0 0 150px" class="fv12bc" id="msgsave${moreDetails.adId}wl"> </span>
                <div style="width:100%;height:10px;float:left"></div>
            </div>
            <!-- this works when user already logged in -->
            <div class="boxBorder4" id="save${moreDetails.adId}al" style="width:100%;height:90px;float:left;display:none;padding:5px 0 5px 0">
                <div class="header" style="width:100%;padding-top:10px" >
                    <div style="float:left;width:60%;text-align:left;"> <span style="font-family:sans-serif;font-size:12px;font-weight:bold;padding-left:3px"> To Save the Ad</span>  </div>
                    <div style="float:left;width:35%;">&nbsp;</div>
                    <div style="float:left;width:5%;text-align:right">  <input type="image" src="<%=localUrlPath%>/bbsimages/c1.png" onclick="toggle_close_it('save${moreDetails.adId}al')"/> </div>
                </div>
                <div id="formsave${moreDetails.adId}al" style="font-family:sans-serif;font-size:12px;padding: 1px auto;float: left;margin-left: 150px;">
                    <table style="margin:0 auto;">
                        <tr>
                            <td><b> This ad will be saved in "myAccount" by saving here</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                            <td><input type="image"  src="<%=localUrlPath%>/bbsimages/buttons/SaveAd.png" onmouseover="this.src='<%=localUrlPath%>/bbsimages/buttons/SaveAd_MouseOver.png'" onmouseout="this.src='<%=localUrlPath%>/bbsimages/buttons/SaveAd.png'" onclick="SaveAdAL('save${moreDetails.adId}al','adId=${moreDetails.adId}')"/> <br/> </td>
                        </tr>
                    </table>
                </div>
                <div id="loadsave${moreDetails.adId}al" style="width:auto;padding:2px 0 2px 350px;display:none"> <img src="<%=localUrlPath%>/images/loading.gif"  style="height:32px;width:32px;" alt="loading"/><br/></div>
                <span style="padding:0 0 0 150px" class="fv12bc" id="msgsave${moreDetails.adId}al"> </span>
            </div>
            <%--   <!-- ********************************************************************************************************** -->
               <!--   SAVE AD BLOCK END   -->
               <!-- ********************************************************************************************************** -->

            <!-- ********************************************************************************************************** -->
            <!-- this div for quick registration -->
            <!-- ********************************************************************************************************** -->
            --%>
            <c:if test="${userBean == null}">
                <div class="boxBorder4" id="nu${moreDetails.adId}" style="width:100%;height:140px;float:left;display:none">
                    <div class="header" style="width:100%;padding-top:10px" >
                        <div style="float:left;width:60%;text-align:left;">
                            <span style="font-family:sans-serif;font-size:12px;font-weight:bold;padding-left:3px">To Register</span>
                            <span style="font-family:sans-serif;font-size:12px;">&nbsp;(Please Enter the information)</span>
                        </div>
                        <div style="float:left;width:35%;text-align:right;font-size:12px;font-family:sans-serif;"><a href="javascript:return false;" onclick="toggle_qr('nu${moreDetails.adId}','smsadvt','${moreDetails.mobile}','${moreDetails.title}');event.returnValue=false;return false;" title="Register">Register</a>&nbsp;|&nbsp;
                            <a href="javascript:return false;" onclick="toggle_fp('fp${moreDetails.adId}');event.returnValue=false;return false;" title="Forgot Password">Forgot Password</a></div>
                        <div style="float:left;width:5%;text-align:right;"> <input type="image" src="<%=localUrlPath%>/bbsimages/c1.png" onclick="toggle_close_it('nu${moreDetails.adId}');" /> </div>
                    </div>
                    <form name="qrform" id="formnu${moreDetails.adId}" method="get" action="<%=localUrlPath%>/quickReg.do" onsubmit="return validateQuickRegFormLA(this)">
                        <input type="hidden" name="adId" value="nu${moreDetails.adId}" />
                        <table id="tablenu${moreDetails.adId}" border="0" style="font-size:12px;margin:0 auto;margin-top:20px;_margin-top:-24px;" >
                            <tr>
                                <td width="">  Email Id  </td>
                                <td> <input style="height:18px;font-size:12px;width:120px" type="text" name="userName" id="l${moreDetails.adId}" onchange="checkUsName('l${moreDetails.adId}','nu${moreDetails.adId}')" />  </td>
                                <td width="">  Your Name </td>
                                <td width=""> <input style="height:18px;font-size:12px;width:120px"  type="text" name="firstName" id="n${moreDetails.adId}" /> </td>
                                <td style="width:30px" align="right"> City  <td>
                                    <select size="1"  id="ct${moreDetails.adId}" style="font-size:12px;width:122px;_width:125px;" name="city" >
                                        <option value="" selected="selected" >Select City</option>
                                        <c:if test="${cities  != null }">
                                            <c:forEach items="${cities}" var="con"><option value="<c:out value='${con.name}'/>"<c:if test='${city != null && city == con.name}' >selected='true'</c:if> ><c:out value="${con.name}"/></option></c:forEach>
                                        </c:if>
                                    </select>
                                </td>
                                <td align="right"> Phone No </td>
                                <td> <input style="height:18px;font-size:12px;width:120px" type="text" name="mobile" id="ph${moreDetails.adId}" /> </td>
                            </tr>
                            <tr>
                                <td>&nbsp;</td>
                                <td  style="width:130px;" align="center" valign="middle"> <img alt="" id="verIdnu${moreDetails.adId}" src="<%=localUrlPath%>/rig" style="height:21px;width:100px"/>&nbsp;
                                    <a class="link11" href="javascript:return false;" onclick="changeVrificationCodeQr('verIdnu${moreDetails.adId}');event.returnValue=false;return false;" title="change Captcha"><img border="0" alt="verificationCode" src="<%=localUrlPath%>/bbsimages/referesh_button.jpg" style="height:24px;width:24px;"/></a>
                                </td>
                                <td> Enter&nbsp;Code </td>
                                <td> <input id="vrCode${moreDetails.adId}" type="text" name="regCode" style="width:120px;font-size:12px;" onblur="qrCheckRegCode('vrCode${moreDetails.adId}','nu${moreDetails.adId}')" /> </td>
                                <td align="right"> <input type="checkbox" name="iagree" /></td>
                                <td><a href="javascript:return false;" onclick="termsAndConditions('tc.do');event.returnValue=false;return false;" style="color:#046DBE" title="Terms and Conditions">I agree Terms &amp; Conditions.</a></td>
                                <td></td>
                                <td width=""> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    <input type="image" id="butdnu${moreDetails.adId}"  src="<%=localUrlPath%>/bbsimages/buttons/RegisterSDis.png" disabled="disabled" />
                                    <input type="image"  src="<%=localUrlPath%>/bbsimages/buttons/RegisterS.png" disabled="disabled" onmouseover="this.src='<%=localUrlPath%>/bbsimages/buttons/RegisterS_MouseOver.png'" onmouseout="this.src='<%=localUrlPath%>/bbsimages/buttons/RegisterS.png'" id="butnu${moreDetails.adId}" style="display:none"      />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">&nbsp</td>
                                <td colspan="4" align="center"><span id="codeTestNonu${moreDetails.adId}" name="codeTestNo" style="color:red;font-size:12px;display:none" >Verfication doesn't matched</span></td>
                                <td colspan="2">&nbsp</td>
                            </tr>
                        </table>
                        <div class="fv12bc" style="text-align:center" id="msgnu${moreDetails.adId}"></div>
                        <div class="fv11b" style="text-align:center;" id="confnu${moreDetails.adId}" ></div>
                        <div id="imgnu${moreDetails.adId}" style="display:none;text-align:center">Loading...</div>
                    </form>
                </div>
            </c:if>
            <c:if test="${userBean != null}">
                <div class="boxBorder4" id="nu${moreDetails.adId}" style="width:100%;float:left;display:none"></div>
            </c:if>
            <%--
                        <!-- ********************************************************************************************************** -->
                        <!-- this div for quick registration end -->
                        <!-- ********************************************************************************************************** -->

            <!-- ********************************************************************************************************** -->
            <!-- this div for forget password -->
            <!-- ********************************************************************************************************** -->--%>
            <!-- this works when user not logged in -->
            <c:if test="${userBean == null }" >
                <div class="boxBorder4" id="fp${moreDetails.adId}" style="width:100%;float:left;display:none">
                    <div class="header" style="width:100%;padding-top:10px;" >
                        <div style="float:left;width:60%;text-align:left;">
                            <span style="font-family:sans-serif;font-size:14px;font-weight:bold;padding-left:3px">To Reset Your Password</span>
                            <span style="font-family:sans-serif;font-size:14px;">&nbsp;(Please Enter the information)</span>
                        </div>
                        <div style="float:left;width:35%;text-align:right;font-size:12px;font-family:sans-serif;"><a href="javascript:return false;" onclick="toggle_qr('nu${moreDetails.adId}','smsadvt','${moreDetails.mobile}','${moreDetails.title}');event.returnValue=false;return false;" title="Register">Register</a>&nbsp;|&nbsp;
                            <a href="javascript:return false;" onclick="toggle_fp('fp${moreDetails.adId}');event.returnValue=false;return false;" title="Forgot Password">Forgot Password</a></div>
                        <div style="float:left;width:5%;text-align:right;"> <input type="image" src="<%=localUrlPath%>/bbsimages/c1.png" onclick="toggle_close_it('fp${moreDetails.adId}')"/> </div>
                    </div>
                    <div id="fpfp${moreDetails.adId}" style="font-family:sans-serif;font-size:12px;margin:0 auto;"> <br/><br/>
                        <table style="margin:0 auto;_margin-top:-12px;">
                            <tr>
                                <td>Enter Email Id</td><td>&nbsp;</td>
                                <td><input id="emfp${moreDetails.adId}" style="height:18px;font-size:12px;width:150px" type="text" /></td>
                                <td>&nbsp;&nbsp;</td><td>Enter Mobile Number</td><td>&nbsp;</td>
                                <td><input id="yfp${moreDetails.adId}" style="height:18px;font-size:12px;width:150px" type="text" /></td>
                                <td><span style="padding-left:20px"> <input type="image"  src="<%=localUrlPath%>/bbsimages/buttons/ResetPasswordS.png" onmouseover="this.src='<%=localUrlPath%>/bbsimages/buttons/ResetPasswordS_MouseOver.png'" onmouseout="this.src='<%=localUrlPath%>/bbsimages/buttons/ResetPasswordS.png'" onclick="sendPassword('fp${moreDetails.adId}');event.returnValue=false;return false;"/> </span> </td>
                            </tr>
                        </table>
                    </div><br/>
                    <div id="imgfp${moreDetails.adId}" style="width:auto;padding:2px 0 2px 350px;display:none"> Loading... </div>
                    <span style="padding:0 0 0 150px" class="fv12bc" id="msgfp${moreDetails.adId}"> </span>
                    <div style="width:100%;height:5px;float:left"></div>
                </div>
            </c:if>
            <c:if test="${userBean != null }" >
                <div class="boxBorder4" id="fp${moreDetails.adId}" style="width:100%;float:left;display:none">
                </div>
            </c:if>
            <%-- <!-- ********************************************************************************************************** -->
             <!--End  div for forget password -->
             <!-- ********************************************************************************************************** -->

            <!-- #############################################################################################################
                                                     DIV FOR SMS TO ADVERTISER STARTS
                 #############################################################################################################-->--%>
            <!-- this works when user not logged in -->
            <div id="sms${moreDetails.adId}wl" class="boxBorder4" style="width:100%;float:left;display:none">
                <div class="header" style="width:100%;padding-top:10px;" >
                    <div style="float:left;width:60%;text-align:left;">
                        <span style="font-family:sans-serif;font-size:12px;font-weight:bold;padding-left:3px">Sms To Advertiser</span>
                        <span style="font-family:sans-serif;font-size:12px;">&nbsp;(Please Enter the information)</span>
                    </div>
                    <div style="float:left;width:35%;text-align:right;font-size:12px;font-family:sans-serif;"><a href="javascript:return false;" onclick="toggle_qr('nu${moreDetails.adId}','smsadvt','${moreDetails.mobile}','${moreDetails.title}');event.returnValue=false;return false;" title="Register">Register</a>&nbsp;|&nbsp;
                        <a href="javascript:return false;" onclick="toggle_fp('fp${moreDetails.adId}');event.returnValue=false;return false;" title="Forgot Password">Forgot Password</a></div>
                    <div style="float:left;width:5%;text-align:right"> <input type="image" src="<%=localUrlPath%>/bbsimages/c1.png" onclick="toggle_close_it('sms${moreDetails.adId}wl')"/> </div>
                </div> <br/>
                <div id="formsms${moreDetails.adId}wl" style="font-family:sans-serif;font-size:12px;padding:1px auto">
                    <table style="margin: 10px auto;_margin-top: -10px;">
                        <tr><td> <input type="hidden" id="msms${moreDetails.adId}wl" value="${moreDetails.mobile}" />
                                <input type="hidden" id="adtsms${moreDetails.adId}wl" value="${moreDetails.title}" /></td>
                            <td  width="12%" style="text-align:left">User Id</td>
                            <td><input style="height:18px;font-size:12px;" id="lsms${moreDetails.adId}wl" type="text" size="35"  /></td>
                            <td  width="5%" style="text-align:left">Password&nbsp;&nbsp;&nbsp;</td>
                            <td> <input style="height:18px;font-size:12px;" id="psms${moreDetails.adId}wl" type="password" size="35"   /></td>
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                            <td>Message</td>
                            <td colspan="3"><input style="height:21px;font-size:12px;width:560px;_width:570px;border:1px solid silver" type="text" readonly="readonly" value=" Hi, I am insterested in your ad, please contact me, I need more information about your Ad. " /></td>
                            <td> <input type="image" src="<%=localUrlPath%>/bbsimages/buttons/SendSMS.png" onmouseover="this.src='<%=localUrlPath%>/bbsimages/buttons/SendSMS_MouseOver.png'" onmouseout="this.src='<%=localUrlPath%>/bbsimages/buttons/SendSMS.png'" onclick="smsAdvertiserWL('sms${moreDetails.adId}wl','${moreDetails.adId}')" /></td>
                        </tr>
                    </table>
                </div>
                <div id="loadsms${moreDetails.adId}wl" style="width:auto;padding:2px 0 2px 350px;display:none"> <img src="<%=localUrlPath%>/images/loading.gif" style="height:32px;width:32px;" alt="loading"/><br/></div>
                <span style="padding:0 0 0 150px" class="fv12bc" id="msgsms${moreDetails.adId}wl"> </span>
            </div>
            <!-- this works when user already logged in -->
            <div id="sms${moreDetails.adId}al" class="boxBorder4" style="width:100%;height:90px;float:left;display:none;padding:5px 0 5px 0">
                <div class="header" style="width:100%;padding-top:10px;" >
                    <div style="float:left;width:60%;text-align:left;"> <span style="font-family:sans-serif;font-size:12px;font-weight:bold;padding-left:3px">Sms To Advertiser</span> </div>
                    <div style="float:left;width:35%;text-align:right;font-size:9px;font-family:Arial;">&nbsp; </div>
                    <div style="float:left;width:5%;text-align:right"> <input type="image" src="<%=localUrlPath%>/bbsimages/c1.png" onclick="toggle_close_it('sms${moreDetails.adId}al')"/>  </div>
                </div>
                <div id="formsms${moreDetails.adId}al" style="font-family:Arial;font-size:9px;padding: 1px auto;"> <br />
                    <input type="hidden" id="msms${moreDetails.adId}al" value="${moreDetails.mobile}" />
                    <input type="hidden" id="adtsms${moreDetails.adId}al" value="${moreDetails.title}" />
                    <table style="margin:0 auto;">
                        <tr>
                            <td> <input type="text" size="75" style="height:15px;font-size:12px;" readonly="readonly" value="Hi, I am insterested in your ad, please contact me, I need more information about your Ad."/></td><td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                            <td><input type="image"  src="<%=localUrlPath%>/bbsimages/buttons/SendSMS.png" onmouseover="this.src='<%=localUrlPath%>/bbsimages/buttons/SendSMS_MouseOver.png'" onmouseout="this.src='<%=localUrlPath%>/bbsimages/buttons/SendSMS.png'" onclick="smsAdvertiserAL('sms${moreDetails.adId}al','${moreDetails.adId}')" /></td>
                        </tr>
                    </table>
                </div>
                <div id="loadsms${moreDetails.adId}al" style="width:auto;padding:2px 0 2px 350px;display:none"> <img src="<%=localUrlPath%>/images/loading.gif" style="height:32px;width:32px;" alt="loading"/><br/></div>
                <span  style="padding:0 0 0 150px;" class="fv12bc" id="msgsms${moreDetails.adId}al"></span><br/>
            </div>

            <%--         <!-- #############################################################################################################
                                                  DIV FOR SMS TO ADVERTISER ENDS
              #############################################################################################################-->

            <!-- #############################################################################################################
                                                     DIV FOR E-MAIL TO FRIEND  STARTS
                 #############################################################################################################-->

            <!-- email to  friend for without login  users -->
            --%>
            <div class="boxBorder4" id="email${moreDetails.adId}wl"  style="width:100%;float:left;display:none;">
                <div class="header" style="width:100%;padding-top:10px;" >
                    <div style="float:left;width:60%;text-align:left;"><span style="font-family:sans-serif;font-size:12px;font-weight:bold;padding-left:3px">To Email this Ad to Friend</span>
                        <span style="font-family:sans-serif;font-size:12px;">&nbsp;(Please Enter the information)</span>
                    </div>
                    <div style="float:left;width:35%;text-align:right;font-size:12px;font-family:sans-serif;"><a href="javascript:return false;" onclick="toggle_qr('nu${moreDetails.adId}','emailFriend');event.returnValue=false;return false; " title="Register">Register</a>&nbsp;|&nbsp;
                        <a href="javascript:return false;" onclick="toggle_fp('fp${moreDetails.adId}');event.returnValue=false;return false;"title="Forgot Password">Forgot Password</a></div>
                    <div style="float:left;width:5%;text-align:right"> <input type="image" src="<%=localUrlPath%>/bbsimages/c1.png" onclick="toggle_close_it('email${moreDetails.adId}wl')"/> </div>
                </div>   <br/>
                <div id="formemail${moreDetails.adId}wl" style="font-family:sans-serif;font-size:12px;padding:1px auto">
                    <table style="margin: 10px auto;_margin-top: -10px;">
                        <tr>
                            <td  width="20%" style="text-align:left">Friend's Name </td>
                            <td><input style="height:18px;font-size:12px;" id="fnemail${moreDetails.adId}wl" type="text" size="35"   /> </td>
                            <td width="6%" > &nbsp;</td>
                            <td  width="17%" style="text-align:left">Friend's Email </td>
                            <td><input style="height:18px;font-size:12px;" id="feemail${moreDetails.adId}wl" type="text" size="35"   /> </td>
                            <td> &nbsp;</td>
                        </tr>
                        <tr>
                            <td  width="12%" style="text-align:left">User Id</td>
                            <td><input style="height:18px;font-size:12px;" id="lemail${moreDetails.adId}wl" type="text" size="35"  /></td>
                            <td width="6%" > &nbsp;</td>
                            <td  width="12%" style="text-align:left">Password</td>
                            <td><input style="height:18px;font-size:12px;_width:160px;" id="pemail${moreDetails.adId}wl" type="password" size="35"   /></td>
                            <td  width="15%" style="text-align:right"><input type="image" src="<%=localUrlPath%>/bbsimages/buttons/SendEmail.png" onmouseover="this.src='<%=localUrlPath%>/bbsimages/buttons/SendEmail_MouseOver.png'" onmouseout="this.src='<%=localUrlPath%>/bbsimages/buttons/SendEmail.png'"  onclick="sendToFriendWL('email${moreDetails.adId}wl','${moreDetails.adId}','${moreDetails.title}','${moreDetails.catId}')" /></td>
                        </tr>
                    </table>
                </div>
                <div id="loademail${moreDetails.adId}wl" style="width:auto;padding:2px 0 2px 350px;display:none"> <img src="<%=localUrlPath%>/images/loading.gif" style="height:32px;width:32px;" alt="loading"/><br/></div>
                <span style="padding:0 0 0 150px" class="fv12bc" id="msgemail${moreDetails.adId}wl"> </span>
            </div>
            <!-- email to  friend for logged in users  -->
            <div id="email${moreDetails.adId}al" class="boxBorder4" style="width:100%;height:90px;float:left;display:none;padding:5px 0 5px 0;">
                <div class="header" style="width:100%;padding-top:10px;" >
                    <div style="float:left;width:60%;text-align:left;"> <span style="font-family:sans-serif;font-size:14px;font-weight:bold;padding-left:3px">To Email this Ad to Friend</span> <span style="font-family:sans-serif;font-size:14px;">&nbsp;(Please Enter the information)</span> </div>
                    <div style="float:left;width:35%;">&nbsp;    </div>
                    <div style="float:left;width:5%;text-align:right"> <input type="image" src="<%=localUrlPath%>/bbsimages/c1.png" onclick="toggle_close_it('email${moreDetails.adId}al')"/> </div>
                </div> <br />
                <div id="formemail${moreDetails.adId}al" style="font-family:sans-serif;font-size:12px;padding: 1px auto;">
                    <table style="margin:0 auto;font-size:12px; margin-top:00px;">
                        <tr>
                            <td  width="20%" style="text-align:left">Friend's Name </td>
                            <td><input style="height:18px;font-size:12px;" id="fnemail${moreDetails.adId}al" type="text" size="35" name="friendName"  /> </td>
                            <td width="6%" > &nbsp;</td>
                            <td  width="20%" style="text-align:left">Friend's Email </td>
                            <td><input style="height:18px;font-size:12px;" id="feemail${moreDetails.adId}al" type="text" size="35" name="friendEmail" /> </td>
                            <td  width="15%" style="text-align:right"><input type="image" src="<%=localUrlPath%>/bbsimages/buttons/SendEmail.png" onmouseover="this.src='<%=localUrlPath%>/bbsimages/buttons/SendEmail_MouseOver.png'" onmouseout="this.src='<%=localUrlPath%>/bbsimages/buttons/SendEmail.png'" onclick="sendToFriendAL('email${moreDetails.adId}al','${moreDetails.adId}','${moreDetails.title}','${moreDetails.catId}')" /></td>
                        </tr>
                    </table>
                </div>
                <div id="loademail${moreDetails.adId}al" style="width:auto;padding:2px 0 2px 350px;display:none"> <img src="<%=localUrlPath%>/images/loading.gif" style="height:32px;width:32px;" alt="loading"/><br/></div>
                <span  style="padding:0 0 0 150px;" class="fv12bc" id="msgemail${moreDetails.adId}al"> </span>
            </div>

            <%--    <!-- ********************************************************************************************************** -->
                <!--   VIEW CONTACT BLOCK STARTS   -->
                <!-- ********************************************************************************************************** -->
            --%>

            <div class="boxBorder4" id="view${moreDetails.adId}wl" style="display:none;">
                <div id="basic-modal-content">
                    <div class="popup_main_bg">
                        <div class="logo_icon_img"></div>
                        <div class="register_user">
                            <div class="register1_icon" >
                                <div class="register1_img"><img src="<%=localUrlPath%>/bbsimages/New/register1_icon.png" /></div>
                                <strong style="font-family:Arial, Helvetica, sans-serif; color:#ff6000; font-size:14px; font-weight:bold; line-height:50px;"> &nbsp;&nbsp;Registered User</strong></div>

                            <div style="float:right;"></div>
                            <div style="float:right;" >
                                <div id="formview${moreDetails.adId}wl" >
                                    <table width="348" border="0" cellspacing="0" cellpadding="0" style="float:right; margin-top:0px;">
                                        <tr>
                                            <td align="right" valign="top" class="registering_txt1" >User ID :</td>
                                            <td align="left" valign="top" ><input id="lview${moreDetails.adId}wl" name="loginName" type="text" class="registering_input_txt" /></td>
                                        </tr>
                                        <tr>
                                            <td align="right" valign="top" class="registering_txt1" >Password : </td>
                                            <td align="left" valign="top" ><input type="password" id="pview${moreDetails.adId}wl" name="pwd"  class="registering_input_txt" /></td>
                                        </tr>
                                    </table>
                                </div>
                                <table width="348" border="0" cellspacing="0" cellpadding="0" style="float:right; margin-top:0px;">
                                    <tr>
                                        <td align="right" valign="middle" class="registering_txt1">&nbsp;</td>
                                        <td align="left" valign="top">
                                            <div style="font-family:Arial, Helvetica, sans-serif; font-size:12px; color:#333333; width:130px; float:right; margin-top:5px;">
                                                <div id="frgt-pswd" style="cursor:pointer;"onmouseout="style.color='#000000'" onmouseover="style.color='#0000E6'">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Forgot Password ?</div></div></td>
                                    </tr>
                                    <tr>
                                        <td align="right" valign="middle" class="registering_txt1">&nbsp;</td>
                                        <td align="left" valign="top"><div class="sign_in_button1"><a onclick="viewContactWL('view${moreDetails.adId}wl',${moreDetails.adId}, ${moreDetails.userId})"></a></div></td>
                                    </tr>
                                </table>
                                <table>
                                    <tr>
                                        <td>
                                            <div id="loadview${moreDetails.adId}wl" style="width:auto;padding:2px 0 2px 350px;display:none"> <img src="<%=localUrlPath%>/images/loading.gif"  style="width:32px;height:32px" alt="loading"/><br/></div>
                                            <span style="padding:0 0 0 15px" class="fv12bc" id="msgview${moreDetails.adId}wl"> </span>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                        <div class="new_register_user">
                            <div class="register1_icon" >
                                <div class="newregister1_img"><img src="<%=localUrlPath%>/bbsimages/New/register_newuser.png" /></div>
                                <strong style="font-family:Arial, Helvetica, sans-serif; color:#0a489a; font-size:14px; font-weight:bold; line-height:50px;"> &nbsp;&nbsp;New User</strong></div>
                            <form name="qrformpop" id="formnupop${moreDetails.adId}" method="get" onsubmit="return validateQuickRegFormLA(this)">
                                <div style="float:right;">
                                    <table width="348" border="0" cellspacing="0" cellpadding="0" style="float:right; margin-top:0px;">
                                        <tr>
                                            <td align="right" valign="top" class="registering_txt1" >Email ID : </td>
                                            <td align="left" valign="top" ><input type="text" name="userName" id="lpop${moreDetails.adId}" onchange="checkUsName('lpop${moreDetails.adId}','nupop${moreDetails.adId}')" class="registering_input_txt" /></td>
                                        </tr>
                                        <tr><td></td><td><div class="fv11b" style="text-align:center;" id="confnupop${moreDetails.adId}" ></div></td></tr>
                                        <tr>
                                            <td align="right" valign="top" class="registering_txt1" >Your Name : </td>
                                            <td align="left" valign="top" ><input type="text" name="firstName" id="npop${moreDetails.adId}"  class="registering_input_txt" /></td>
                                        </tr>
                                        <tr>
                                            <td align="right" valign="top" class="registering_txt1" >Phone No : </td>
                                            <td align="left" valign="top" ><input type="text" name="mobile" id="phpop${moreDetails.adId}" class="registering_input_txt" /></td>
                                        </tr>
                                        <tr>
                                            <td align="right" valign="top" class="registering_txt1">City :</td>
                                            <td align="right" valign="middle">
                                                <select name="city" id="ctPop${moreDetails.adId}" style="width:242px;" tabindex="1">
                                                    <option value="" selected="selected" >Select City</option> <c:if test="${cities  != null }">
                                                        <c:forEach items="${cities}" var="con"><option value="<c:out value='${con.name}'/>"<c:if test='${city != null && city == con.name}' >selected='true'</c:if> ><c:out value="${con.name}"/></option></c:forEach>
                                                    </c:if>
                                                </select>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right" valign="top" class="registering_txt1" style="padding-top:15px;">Verification Code :</td>
                                            <td align="right" valign="middle"><img alt=""  id="verIdPop${moreDetails.adId}" src="<%=localUrlPath%>/rig"  width="190" height="40"/><a class="link11" href="javascript:return false;" onclick="changeVrificationCodeQr('verIdPop${moreDetails.adId}');event.returnValue=false;return false;" title="change Captcha"><img src="<%=localUrlPath%>/bbsimages/New/referesh_button.jpg" width="45" height="45" /></a></td>
                                        </tr>
                                        <tr>
                                            <td align="right" valign="top" class="registering_txt1" style="padding-top:15px;">Enter Code :</td>
                                            <td align="left" valign="middle"><input type="text" id="vrCodePop${moreDetails.adId}" type="text" name="regCode" onblur="qrCheckRegCode('vrCodePop${moreDetails.adId}','nupop${moreDetails.adId}')"  class="registering_input_txt" /></td>
                                        </tr>
                                        <tr><td></td><td align="center"><span id="codeTestNonupop${moreDetails.adId}" name="codeTestNo" style="color:red;font-size:12px;display:none" >Verification doesn't matched</span></td></tr>

                                        <tr>
                                            <td align="right" valign="middle" class="registering_txt1">&nbsp;</td>
                                            <td align="left" valign="top">
                                                <div style="font-family:Arial, Helvetica, sans-serif; font-size:11px; color:#666666; width:200px;">
                                                    <input name="iagree" type="checkbox" value="" />&nbsp;&nbsp;&nbsp;<a href="javascript:return false;" onclick="termsAndConditions('<%=localUrlPath%>/tc.do');event.returnValue=false;return false;" style="color:#046DBE" title="Terms and Conditions">I agree Terms & Conditions</a></div></td>
                                        </tr>

                                        <tr>
                                            <td align="right" valign="middle" class="registering_txt1">&nbsp;</td>
                                            <td align="left" valign="top"> 
                                                <input type="image" id="butdnupop${moreDetails.adId}" style=" float: left;height: 40px;margin-left: 40px;width: 117px;margin-top:-9px;cursor:none" src="<%=localUrlPath%>/bbsimages/New/reg_dis2.png" disabled="disabled" /> <input type="image"  style=" float: left;height: 40px;margin-left: 40px;width: 117px;margin-top:-9px;display:none" src="<%=localUrlPath%>/bbsimages/New/register1.png" disabled="disabled" onmouseover="this.src='<%=localUrlPath%>/bbsimages/New/register2.png'" onmouseout="this.src='<%=localUrlPath%>/bbsimages/New/register1.png'" id="butnupop${moreDetails.adId}" />
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </form>
                        </div>
                    </div>

                    <div id="rst-pswd" style="display: none" >
                        <div class="popup_main_sml">
                            <div style="height:54px;margin:28px 100px 0 382px;"></div>
                            <div class="rst_pswd_pop">
                                <div class="rst_pswd_icon" >
                                    <div class="rst_pswd_img" style="float:left"><img src="<%=localUrlPath%>/bbsimages/New/rst_pswd_icon1.png" width="38" height="50"/></div>
                                    <strong style="font-family:Arial, Helvetica, sans-serif; color:#ff6000; font-size:14px; font-weight:bold; line-height:50px;">Reset Your Password</strong></div><br/><br/>
                                <div id="fpfppop${moreDetails.adId}" style="font-family:sans-serif;font-size:12px;margin:0 auto;"><br/>
                                    <div style="float:left">Please Enter The Information</div><br/>
                                    <table width="348" border="0" cellspacing="0" cellpadding="0" style="float:right; margin-top:30px;">
                                        <tr>
                                            <td align="right" valign="top" class="registering_txt1" >Email Id :</td>
                                            <td align="left" valign="top" ><input id="emfppop${moreDetails.adId}" type="text" class="registering_input_txt" /></td>
                                        </tr>
                                        <tr>
                                            <td align="right" valign="top" class="registering_txt1" >Mobile Number : </td>
                                            <td align="left" valign="top" ><input type="text" id="yfppop${moreDetails.adId}" class="registering_input_txt" /></td>
                                        </tr>
                                        <tr><td><br/></td></tr>
                                        <tr>
                                            <td align="right" valign="middle" class="registering_txt1">&nbsp;</td>
                                            <td align="left" valign="top"><div class="rst_pswd_button"><a onclick="sendPassword('fppop${moreDetails.adId}');event.returnValue=false;return false;"></a></div></td>
                                        </tr>
                                    </table>
                                </div>
                                <div id="imgfppop${moreDetails.adId}" style="width:auto;display:none;float:left;padding-right:100px;"> Loading... </div> <br/>
                                <span style="color:#0A489A;" class="fv12bc" id="msgfppop${moreDetails.adId}"></span><br/><br/><br/>
                            </div>
                        </div>
                    </div>                      
                </div>                        
            </div>
        </div>


        <!-- ********************************************************************************************************** -->
        <!--   VIEW CONTACT BLOCK END   -->
        <!-- ********************************************************************************************************** -->



        <div style="clear:both"></div>
        <div style="height:20px;"id="BgImg"> </div>
        <div class="car_border_cont_1">
            <div class="car_top_border"></div>
            <div class="car_middel_border">
                <div class="change_img_2" align="center">
                    <div style="height:320px">
                        <c:set var="numBimg" value="0"/>
                        <c:if test='${moreDetails.image1 == "" || moreDetails.image1 == null || moreDetails.image1 == "null"}'> No Images  </c:if>
                        <c:if test='${moreDetails.image1 != "" && moreDetails.image1 != null && moreDetails.image1 != "null"}'>
                            <img  id="iB1${moreDetails.adId}" style="max-width:100%;height: 320px;width: expression(this.width >= this.height ? 100%: true);height: expression(this.height >= this.width ? 320: true);" src="<%=localUrlPath%>/resourceGetter?imf=<c:out value="${moreDetails.image1}"/>" alt="${moreDetails.title}"/>
                            <c:set var="numBimg" value="${numBimg+1}"/>
                        </c:if>
                        <c:if test='${moreDetails.image2 != "" && moreDetails.image2 != null && moreDetails.image2 != "null"}'>
                            <img id="iB2${moreDetails.adId}" style="display:none;max-width:100%;height: 320px;width: expression(this.width >= this.height ? 100%: true);height: expression(this.height >= this.width ? 320: true);" src="<%=localUrlPath%>/resourceGetter?imf=<c:out value="${moreDetails.image2}"/>" alt="${moreDetails.title}"/>
                            <c:set var="numBimg" value="${numBimg+1}"/>
                        </c:if>
                        <c:if test='${moreDetails.image3 != "" && moreDetails.image3 != null && moreDetails.image3 != "null"}'>
                            <img id="iB3${moreDetails.adId}" style="display:none;max-width:100%;height: 320px;width: expression(this.width >= this.height ? 100%: true);height: expression(this.height >= this.width ? 320: true);" src="<%=localUrlPath%>/resourceGetter?imf=<c:out value="${moreDetails.image3}"/>" alt="${moreDetails.title}"/>
                            <c:set var="numBimg" value="${numBimg+1}"/>
                        </c:if>
                    </div><br/>
                    <div align="center">
                        <c:if test="${numBimg==1}">1 of 1  </c:if>
                        <c:if test="${numBimg>1}">
                            <script type="text/javascript">
                                var mdBImg=1;
                                function chMdBImg() {
                                    for(var i=1;i<=${numBimg};i++) {
                                        document.getElementById("iB"+i+${moreDetails.adId}).style.display='none';
                                    }
                                    if(mdBImg==0) mdBImg=${numBimg};
                                    if(mdBImg>${numBimg}) mdBImg=1;
                                    document.getElementById("iB"+mdBImg+${moreDetails.adId}).style.display='inline';
                                    document.getElementById("curBimg").innerHTML=mdBImg;
                                }
                            </script>
                            <a href="javascript:void(0);" class="sImgA" title="Previous" onclick="chMdBImg(mdBImg--)"><img src="<%=localUrlPath%>/bbsimages/New/ad_arrow1.png"/></a>&nbsp;<span id="curBimg" style="margin-top:-5px;">1</span> of ${numimg}
                            <a href="javascript:void(0);" class="sImgA" title="Next" onclick="chMdBImg(mdBImg++)"> <img src="<%=localUrlPath%>/bbsimages/New/ad_arrow2.png"/></a>&nbsp;
                            </c:if>
                    </div>
                </div>
                <div class="google_map_1" id="gmap" ></div>
                <script type="text/javascript" src="http://maps.googleapis.com/maps/api/js?sensor=false"></script>
                <script type="text/javascript">
                    var geocoder;
                    var map;
                    function codeAddress(add,zm) {
                        geocoder = new google.maps.Geocoder();
                        var latlng = new google.maps.LatLng(14.416, 79.967);
                        var myOptions = {
                            zoom: 8,
                            center: latlng,
                            mapTypeId: google.maps.MapTypeId.ROADMAP
                        }
                        map = new google.maps.Map(document.getElementById("gmap"), myOptions);
                        var address = add;
                        geocoder.geocode( { 'address': address}, function(results, status) {
                            if (status == google.maps.GeocoderStatus.OK) {
                                map.setCenter(results[0].geometry.location);
                                map.setZoom(zm);
                                var marker = new google.maps.Marker({
                                    map: map,
                                    position: results[0].geometry.location
                                });
                            } else {
                                codeAddress('${moreDetails.city}, India',10);
                            }
                        });
                    }
                    codeAddress('${moreDetails.locality}, ${moreDetails.city}, India',13);
                </script>
            </div>
            <div class="car_bottom_border"></div>
        </div>


        <script type="text/javascript">
            (function() {
                var po = document.createElement('script'); po.type = 'text/javascript'; po.async = true;
                po.src = 'https://apis.google.com/js/plusone.js';
                var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(po, s);
            })();
        </script>
    </div>
</div>
</c:otherwise>
</c:choose>

