/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.buysell.actionclass;

import com.buysell.beans.AdsResultsBean;
import com.buysell.servlets.AdsService;
import com.buysell.util.BuySellProperties;
import com.buysell.util.CategoryUtil;
import com.buysell.util.City;
import com.buysell.util.CityUtil;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.ActionForward;

/**
 *
 * @author bbsadmin
 */
public class BasicSearchAction extends org.apache.struts.action.Action {

    private final static String SUCCESS = "success";
    private static Logger LOG = Logger.getLogger(BasicSearchAction.class);
    CategoryUtil cu = new CategoryUtil();

    /**
     * This is the action called from the Struts framework.
     * @param mapping The ActionMapping used to select this instance.
     * @param form The optional ActionForm bean for this request.
     * @param request The HTTP Request we are processing.
     * @param response The HTTP Response we are processing.
     * @throws java.lang.Exception
     * @return
     */
    public ActionForward execute(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        long startTime = System.currentTimeMillis();



        LOG.info("BasicSearchAction execute() started");

        request.setAttribute("categoryList", CategoryUtil.getCategories());
        String urlstr = request.getRequestURI();
        if (urlstr.contains("/Buysell")) {
            request.setAttribute("reqURI", request.getRequestURI().substring(9));

        } else {
            request.setAttribute("reqURI", request.getRequestURI().substring(1));


        }

        String adType = request.getParameter("adType");
        if (adType == null || adType.trim().length() == 0) {
            adType = "offered";
        }
        request.setAttribute("adType", adType);
        int oBy = 1;
        int start = 0;
        int range = Integer.parseInt(BuySellProperties.getProperty("middle"));
        try {
            if (request.getParameter("start") != null) {
                start = Integer.parseInt(request.getParameter("start"));
            } else {
                start = 0;
            }

        } catch (Exception e) {
            LOG.error("start:" + e);
            start = 0;
        }
        try {
            if (request.getParameter("range") != null) {
                range = Integer.parseInt(request.getParameter("range"));
            } else {
                range = 20;
            }


        } catch (Exception e) {
            LOG.error("range:" + e);
            range = 20;
        }
        try {
            if (request.getParameter("byO") != null) {
                oBy = Integer.parseInt(request.getParameter("byO"));
            } else {
                oBy = 1;
            }

        } catch (Exception e) {
            LOG.error("oBy:" + e);
            oBy = 1;
        }
        String oBy0 = request.getParameter("byO");
        switch (oBy) {
            case 1:
                oBy0 = " AD_T.AD_ID DESC ";
                break;
            case 2:
                oBy0 = " AD_T.AD_ID ASC ";
                break;
            case 3:
                oBy0 = " AD_T.IMAGE1 ASC ";
                break;
            case 4:
                oBy0 = " AD_T.IMAGE1 DESC ";
                break;
            case 5:
                oBy0 = " TRIM(AD_T.TITLE) ASC ";
                break;
            case 6:
                oBy0 = " TRIM(AD_T.TITLE) DESC ";
                break;
            case 7:
                if (adType.equals("offered")) {
                    oBy0 = " PRICE ASC ";
                } else {
                    oBy0 = " MINI ASC ";
                }
                break;
            case 8:
                if (adType.equals("offered")) {
                    oBy0 = " PRICE DESC ";
                } else {
                    oBy0 = " MINI DESC ";
                }
                break;
            default:
                oBy0 = " AD_T.AD_ID DESC ";
                break;
        }
        String city = request.getParameter("city");
        if (city != null) {
            Cookie cityCookie = new Cookie("presentCity", city);
            LOG.info("getMaxAge=" + cityCookie.getMaxAge());
            cityCookie.setMaxAge(360 * 24 * 60 * 60);
            response.addCookie(cityCookie);
            request.getSession().setAttribute("city", city);

            CityUtil cUtil = new CityUtil();
            City cityObj = (City) request.getSession().getAttribute("cityObj");

            if (cityObj != null) {
                String country = cityObj.getCountry();
                String state = cityObj.getState();

                cityObj = cUtil.readCity(city, country, state);
                if (cityObj != null) {
                    cityObj.setCountry(country);
                    cityObj.setState(state);
                    request.getSession().setAttribute("cityObj", cityObj);
                }

            }


        } else {
            city = (String) request.getSession().getAttribute("city");
        }

        String subCatId1 = request.getParameter("subCatId");
        int subCatId = 0;

        try {
            subCatId = Integer.parseInt(subCatId1.trim());
        } catch (Exception e) {
            LOG.debug("error:" + e);
        }

        request.setAttribute("clfIds", cu.getClfCatIdsWithSubCatId(subCatId));

        String clfList = " ";
        if (subCatId != 0) {
            ArrayList allCatIdsHirachy = cu.getAll(subCatId);
            if (!allCatIdsHirachy.isEmpty()) {
                StringBuffer sb = new StringBuffer();
                sb.append(" AND CATEGORY_ID IN( ");
                for (Iterator itr = allCatIdsHirachy.iterator(); itr.hasNext();) {
                    sb.append(itr.next() + ",");
                }
                clfList = sb.substring(0, sb.length() - 1) + ")";
            }
        }
        String keyword = request.getParameter("keyword");
        if (keyword != null && keyword.trim().equalsIgnoreCase("What you are looking...?")) {
            keyword = " ";
        }
        StringBuffer sb1 = new StringBuffer();
        StringBuffer sb2 = new StringBuffer();
        LOG.info("\n\n\n**************************city=" + city + "****************************\n\n\n");
        if (city.trim().equals("All India")) {
            sb1.append("SELECT TITLE,IMAGE1,DESCRIPTION,ADDITIONAL_CONTENT, AD_T.AD_ID, AD_T.CREATION_DATE, FIRST_NAME,PRICE,NEGOTIABLE,CATEGORY_ID,LOGIN_NAME,AD_TYPE,ADDRESS_1,MINI,MAX,CITY,CONTACT_PRICE,AD_T.USER_ID,PHONE,LOCALITY,TAGS,RENT_MONTH,AD_T.DEALER_LOGO,SPONSORED_TYPE from AD_FIELDS,AD_T,USER_T,ADDRESS_T,USER_LOGIN_T WHERE USER_LOGIN_T.USER_ID = USER_T.USER_ID AND USER_T.USER_ID = AD_T.USER_ID AND ADDRESS_T.ADDRESS_ID = AD_FIELDS.ADD_ID AND AD_FIELDS.AD_ID = AD_T.AD_ID AND AD_T.STATUS=1 AND  AD_FIELDS.AD_TYPE='" + adType + "' ");
            sb2.append("SELECT COUNT(*) from AD_FIELDS,AD_T,USER_T,ADDRESS_T,USER_LOGIN_T WHERE USER_LOGIN_T.USER_ID = USER_T.USER_ID AND USER_T.USER_ID = AD_T.USER_ID AND ADDRESS_T.ADDRESS_ID = AD_FIELDS.ADD_ID AND AD_FIELDS.AD_ID = AD_T.AD_ID AND AD_T.STATUS=1 AND  AD_FIELDS.AD_TYPE='" + adType + "' ");
        } else {
            sb1.append("SELECT TITLE,IMAGE1,DESCRIPTION,ADDITIONAL_CONTENT, AD_T.AD_ID, AD_T.CREATION_DATE, FIRST_NAME,PRICE,NEGOTIABLE,CATEGORY_ID,LOGIN_NAME,AD_TYPE,ADDRESS_1,MINI,MAX,CITY,CONTACT_PRICE,AD_T.USER_ID,PHONE,LOCALITY,TAGS,RENT_MONTH,AD_T.DEALER_LOGO,SPONSORED_TYPE from AD_FIELDS,AD_T,USER_T,ADDRESS_T,USER_LOGIN_T WHERE USER_LOGIN_T.USER_ID = USER_T.USER_ID AND USER_T.USER_ID = AD_T.USER_ID AND ADDRESS_T.ADDRESS_ID = AD_FIELDS.ADD_ID AND AD_FIELDS.AD_ID = AD_T.AD_ID AND AD_T.STATUS=1 AND ADDRESS_T.CITY='" + city + "'  AND AD_FIELDS.AD_TYPE='" + adType + "' ");
            sb2.append("SELECT COUNT(*) from AD_FIELDS,AD_T,USER_T,ADDRESS_T,USER_LOGIN_T WHERE USER_LOGIN_T.USER_ID = USER_T.USER_ID AND USER_T.USER_ID = AD_T.USER_ID AND ADDRESS_T.ADDRESS_ID = AD_FIELDS.ADD_ID AND AD_FIELDS.AD_ID = AD_T.AD_ID AND AD_T.STATUS=1 AND ADDRESS_T.CITY='" + city + "'  AND AD_FIELDS.AD_TYPE='" + adType + "' ");
        }


        if ((subCatId == 0 && keyword == null) || (subCatId == 0 && keyword.trim().length() == 0)) {
            LOG.info("All search");
            request.setAttribute("title", "Latest Ads");

            // this block executes when both keyword and category given
        } else if (subCatId != 0 && keyword != null && keyword.trim().length() > 0) {

            sb1.append(clfList);
            sb2.append(clfList);
            getKeywordQuery2(keyword, sb1, sb2);
            LOG.info("keyword & category search");
            request.setAttribute("title", "Ads in " + cu.getCategoryNameWithId(subCatId) + " with '" + keyword + "'");
            //this block executes only keyword given
        } else if (keyword != null && keyword.trim().length() > 0) {
            getKeywordQuery2(keyword, sb1, sb2);
            LOG.info("keyword search");
            request.setAttribute("title", "Ads with '" + keyword + "'");
            // this block executes only when category given
        } else {
            sb1.append(clfList);
            sb2.append(clfList);
            LOG.info("cateogy search");
            request.setAttribute("title", "Ads in " + cu.getCategoryNameWithId(subCatId));
        }


        //limit addeing to  DB string
        sb1.append(" ORDER BY " + oBy0 + "  LIMIT " + start + "," + range);
        LOG.debug("\n\nfinal query1=" + sb1);
        LOG.debug("\n\nfinal query2=" + sb2);

        StringBuffer queryString = new StringBuffer("keyword=" + keyword.trim() + "&subCatId=" + subCatId + "&adType=" + adType);
        StringBuffer alertPattern = new StringBuffer();
        alertPattern.append("|" + keyword + "|" + subCatId + "|" + city + "|" + "adType^" + adType);

        HashMap alertPatternMap = (HashMap) request.getSession().getAttribute("smap");
        if (alertPatternMap == null) {
            alertPatternMap = new HashMap();
            request.getSession().setAttribute("smap", alertPatternMap);
        }
        if (keyword != null && keyword.trim().length() > 0) {
            alertPatternMap.put(keyword.trim(), alertPattern.toString());
        } else {
            alertPatternMap.put("$NULL$", alertPattern.toString());
        }


        alertPatternMap.put("qryStr", queryString.toString() + "&city=" + city);

        AdsService as = new AdsService();
        ArrayList al = null;

        al = as.getLatestAdsList(sb1.toString(), sb2.toString(), request);
        AdsResultsBean arb = new AdsResultsBean();
        arb.setResults(al);
        request.setAttribute("latestAdResultsBean", arb);
        request.setAttribute("saveThisSearch", request.getRequestURI() + "?");
        request.setAttribute("subCatId", subCatId1);
        request.setAttribute("keyword", keyword);
        request.setAttribute("refineSearch", "refineSearch");
        // this code for recent searches
        LinkedHashMap<String, String> recentSearches = (LinkedHashMap<String, String>) request.getSession().getAttribute("recentSearches");
        if (recentSearches == null) {
            recentSearches = new LinkedHashMap<String, String>(10, 0.75f, false);
        }
        if (keyword != null && keyword.trim().length() > 0) {
            recentSearches.remove(keyword);
            recentSearches.put(keyword, request.getRequestURI() + "?" + queryString.toString());
            request.getSession().setAttribute("recentSearches", recentSearches);
        }
        request.setAttribute("rqry", queryString.toString());
        long endTime = System.currentTimeMillis();
        LOG.debug("= Time taken to complete db operation :: =" + (endTime - startTime) + "  Seconds");
        request.setAttribute("m", request.getParameter("m"));

        return mapping.findForward(SUCCESS);
    }

    private void getKeywordQuery2(String keyword, StringBuffer sb1, StringBuffer sb2) {
        sb1.append("AND AD_T.AD_ID IN ((SELECT AD_ID FROM AD_T  WHERE MATCH(DESCRIPTION,TITLE,TAGS,ADDITIONAL_CONTENT) AGAINST ('" + keyword + "') UNION SELECT AD_ID FROM AD_FIELDS WHERE MATCH(COLOR, BRAND, NAME, BREED, PET, QUALIFICATION, SKILL_SET, INDUSTARY, AUTHOR, LANGUAGE, PUBLICATION) AGAINST ('" + keyword + "')))");
        sb2.append("AND AD_T.AD_ID IN ((SELECT AD_ID FROM AD_T  WHERE MATCH(DESCRIPTION,TITLE,TAGS,ADDITIONAL_CONTENT) AGAINST ('" + keyword + "') UNION SELECT AD_ID FROM AD_FIELDS WHERE MATCH(COLOR, BRAND, NAME, BREED, PET, QUALIFICATION, SKILL_SET, INDUSTARY, AUTHOR, LANGUAGE, PUBLICATION) AGAINST ('" + keyword + "')))");
    }
}
