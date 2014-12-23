/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.buysell.actionclass;

import com.buysell.beans.AdsBean;
import com.buysell.beans.AdsResultsBean;
import com.buysell.db.DbConnection;
import com.buysell.servlets.AdsService;
import com.buysell.util.AdvancedTiles;
import com.buysell.util.BuySellProperties;
import com.buysell.util.CategoryUtil;
import com.buysell.util.City;
import com.buysell.util.CityUtil;
import com.buysell.util.Demo;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.StringTokenizer;
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
public class RefineSearch extends org.apache.struts.action.Action {

    /* forward name="success" path="" */
    private final static String SUCCESS = "success";
    private static Logger LOG = Logger.getLogger(RefineSearch.class);
    DbConnection db;
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
    @Override
    public ActionForward execute(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        long startTime = System.currentTimeMillis();
        LOG.info("RefineSearch execute() started");

        request.setAttribute("categoryList", CategoryUtil.getCategories());
        String urlstr = request.getRequestURI();
        if (urlstr.contains("/Buysell")) {
            request.setAttribute("reqURI", request.getRequestURI().substring(9));
            LOG.info("reqURI=" + request.getRequestURI().substring(9));
        } else {
            request.setAttribute("reqURI", request.getRequestURI().substring(1));
            LOG.info("reqURI=" + request.getRequestURI().substring(1));
        }
        String adType = request.getParameter("adType");
        LOG.info("adType=" + adType);
        if (adType == null || adType.trim().length() == 0) {
            adType = "offered";
        }
        request.setAttribute("adType", adType);
        String oBy0;
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
            if (subCatId1 != null) {
                subCatId = Integer.parseInt(subCatId1.trim());
            }
        } catch (Exception e) {
            LOG.debug("error:" + e);
        }
        String keyword = request.getParameter("keyword");
        LOG.info("subCatId=" + subCatId);
        LOG.info("keyword=" + keyword);
        LOG.info("city=" + city);

        StringBuffer queryString = new StringBuffer("keyword=" + keyword + "&subCatId=" + subCatId + "&adType=" + adType);
        StringBuffer alertPattern = new StringBuffer("|" + keyword);

        String clfList = " ";
        // to display classifications
        request.setAttribute("clfIds", cu.getClfCatIdsWithSubCatId(subCatId));

        String clfs[] = request.getParameterValues("clfs");

        if((clfs==null||clfs.length==0) && subCatId>0) {
            ArrayList clfAl = cu.getClfCatIdsWithSubCatId(subCatId);
            clfs = new String[clfAl.size()];
            for (int i = 0; i < clfAl.size(); i++) {
                clfs[i] = ""+ clfAl.get(i);
            }
        }

        if (clfs != null && clfs.length > 0) {

            List clfsSelected = new ArrayList();
            StringBuffer sb1 = new StringBuffer("|");
            StringBuffer sb = new StringBuffer();
            sb.append(" AND CATEGORY_ID IN( ");

            for (int i = 0; i < clfs.length; i++) {

                sb.append(clfs[i] + " ,");
                queryString.append("&clfs=" + clfs[i]);
                sb1.append(clfs[i] + ",");
                clfsSelected.add(clfs[i]);
            }
            alertPattern.append(sb1.substring(0, sb1.length() - 1));
            clfList = sb.substring(0, sb.length() - 1) + ")";
            request.setAttribute("clfsSelected", clfsSelected);

        }
        alertPattern.append("|" + city + "|adType^" + adType);

//        LOG.info("clf list=" + clfList);

        String locals = " ";

        String[] localities = request.getParameterValues("lcs");

        if (localities != null && localities.length > 0) {
            List localsSelected = new ArrayList();
            StringBuffer sb1 = new StringBuffer();
            sb1.append("|lcs^");
            StringBuffer sb = new StringBuffer(" AND LOCALITY IN ( ");
            for (int i = 0; i < localities.length; i++) {

                sb.append("'" + localities[i] + "' ,");
                queryString.append("&lcs=" + localities[i]);
                sb1.append(localities[i] + ",");
                localsSelected.add(localities[i]);
            }
            alertPattern.append(sb1.substring(0, sb1.length() - 1));
            locals = sb.substring(0, sb.length() - 1) + ") ";
            request.setAttribute("localsSelected", localsSelected);
        }

//        LOG.info("locs list=" + locals);



        StringBuffer sb1 = new StringBuffer();
        StringBuffer sb2 = new StringBuffer();



        LOG.info("\n\n\n**************************city=" + city + "****************************\n\n\n");
        if (city != null && city.trim().equals("All India")) {
            sb1.append("SELECT TITLE,IMAGE1,DESCRIPTION,ADDITIONAL_CONTENT, AD_T.AD_ID, AD_T.CREATION_DATE, FIRST_NAME,PRICE,NEGOTIABLE,CATEGORY_ID,LOGIN_NAME,AD_TYPE,ADDRESS_1,MINI,MAX,CITY,CONTACT_PRICE,AD_T.USER_ID,PHONE,LOCALITY,TAGS,RENT_MONTH,AD_T.DEALER_LOGO,SPONSORED_TYPE from AD_FIELDS,AD_T,USER_T,ADDRESS_T,USER_LOGIN_T WHERE  ADDRESS_T.ADDRESS_ID=AD_FIELDS.ADD_ID AND AD_T.USER_ID=USER_T.USER_ID AND AD_T.STATUS=1 AND AD_FIELDS.AD_ID=AD_T.AD_ID  AND USER_T.USER_ID=USER_LOGIN_T.USER_ID AND AD_FIELDS.AD_TYPE='" + adType + "' ");
            sb2.append("SELECT COUNT(*) from AD_FIELDS,AD_T,USER_T,ADDRESS_T,USER_LOGIN_T WHERE  ADDRESS_T.ADDRESS_ID=AD_FIELDS.ADD_ID AND AD_T.USER_ID=USER_T.USER_ID AND AD_T.STATUS=1 AND AD_FIELDS.AD_ID=AD_T.AD_ID  AND USER_T.USER_ID=USER_LOGIN_T.USER_ID AND AD_FIELDS.AD_TYPE='" + adType + "' ");
        } else if (city != null && city.trim().length() > 0) {
            sb1.append("SELECT TITLE,IMAGE1,DESCRIPTION,ADDITIONAL_CONTENT, AD_T.AD_ID, AD_T.CREATION_DATE, FIRST_NAME,PRICE,NEGOTIABLE,CATEGORY_ID,LOGIN_NAME,AD_TYPE,ADDRESS_1,MINI,MAX,CITY,CONTACT_PRICE,AD_T.USER_ID,PHONE,LOCALITY,TAGS,RENT_MONTH,AD_T.DEALER_LOGO,SPONSORED_TYPE from AD_FIELDS,AD_T,USER_T,ADDRESS_T,USER_LOGIN_T WHERE  ADDRESS_T.ADDRESS_ID=AD_FIELDS.ADD_ID AND AD_T.USER_ID=USER_T.USER_ID AND AD_T.STATUS=1 AND AD_FIELDS.AD_ID=AD_T.AD_ID  AND USER_T.USER_ID=USER_LOGIN_T.USER_ID AND ADDRESS_T.CITY='" + city + "'  AND AD_FIELDS.AD_TYPE='" + adType + "' ");
            sb2.append("SELECT COUNT(*) from AD_FIELDS,AD_T,USER_T,ADDRESS_T,USER_LOGIN_T WHERE  ADDRESS_T.ADDRESS_ID=AD_FIELDS.ADD_ID AND AD_T.USER_ID=USER_T.USER_ID AND AD_T.STATUS=1 AND AD_FIELDS.AD_ID=AD_T.AD_ID  AND USER_T.USER_ID=USER_LOGIN_T.USER_ID AND ADDRESS_T.CITY='" + city + "'  AND AD_FIELDS.AD_TYPE='" + adType + "' ");
        }


        if ((subCatId == 0 && keyword == null) || (subCatId == 0 && keyword.trim().length() == 0)) {
            LOG.info("All search");
            request.setAttribute("title", "Latest Ads");

            // this block executes when both keyword and category given
        } else if (subCatId != 0 && keyword != null && keyword.trim().length() > 0) {

            sb1.append(clfList);
            sb2.append(clfList);
            getKeywordQuery(keyword, sb1, sb2);
            LOG.info("keyword & category search");
            request.setAttribute("title", "Ads in " + cu.getCategoryNameWithId(subCatId) + " with ' " + keyword + " '");

            //this block executes only keyword given
        } else if (keyword != null && keyword.trim().length() > 0) {
            getKeywordQuery(keyword, sb1, sb2);
            LOG.info("keyword search");
            request.setAttribute("title", "Ads with '" + keyword + "'");

            // this block executes only when category given
        } else {
            sb1.append(clfList);
            sb2.append(clfList);
            LOG.info("cateogy search");
            request.setAttribute("title", "Ads in " + cu.getCategoryNameWithId(subCatId));
        }


        //dynamic query generation 
        AdvancedTiles at = new AdvancedTiles(subCatId);
        String s = at.getSearchFields(subCatId);
//        LOG.info("Search field from SEARCH_TILES_T(SEARCH_FIELDS) ==>" + s);


        // this Class object used to get the query values & column names properly for where condition
        Demo d = new Demo();


        HashMap alertPatternMap = (HashMap) request.getSession().getAttribute("smap");
        if (alertPatternMap == null) {
            alertPatternMap = new HashMap();
            request.getSession().setAttribute("smap", alertPatternMap);
        }
        String qry = d.getDbQuery(s, request, alertPattern, queryString);
//        LOG.debug("=========qry========: " + qry);
//        LOG.debug("alertPattern is:" + alertPattern);



        if (qry != null && qry.trim().length() > 0 && !qry.startsWith(" AND")) {
            sb1.append("  AND  " + qry);
            sb2.append("  AND  " + qry);


        } else if (qry != null && qry.trim().length() > 0 && qry.startsWith(" AND")) {
            sb1.append(qry);
            sb2.append(qry);

        }


        String onlyPhotAds = request.getParameter("opa");
        if (onlyPhotAds != null) {

            sb1.append(" AND IMAGE1 IS NOT  NULL ");
            sb2.append(" AND IMAGE1 IS NOT  NULL ");
            alertPattern.append("|opa^y");
            queryString.append("&opa=y");
            request.setAttribute("opa", "y");

        }



        if (keyword != null && keyword.trim().length() > 0) {
            LOG.info("keyword");
            alertPatternMap.put(keyword.trim(), alertPattern.toString());
        } else {
            LOG.info("no key word");
            alertPatternMap.put("$NULL$", alertPattern.toString());
        }
        //Storing query string in map
        alertPatternMap.put("qryStr", queryString.toString() + "&city=" + city);


        sb1.append(locals);
        sb2.append(locals);


        StringBuffer spSb = new StringBuffer(sb1);
        spSb.append(" AND AD_T.SPONSORED_TYPE IN(3,2) LIMIT " + start + "," + range);

        sb1.append("  ORDER BY " + oBy0 + "  LIMIT " + start + "," + range);

//        LOG.info("\n\nfinal query1=" + sb1);
//        LOG.info("\n\nfinal query2=" + sb2);

        ArrayList searchResultsList = new ArrayList();
        AdsService as = new AdsService();
        ArrayList<AdsBean> sar = new ArrayList();
        sar = as.getLatestAdsList(sb1.toString(), sb2.toString(), request);
        searchResultsList = as.getLatestAdsList(sb1.toString(), sb2.toString(), request);

        LOG.info("searchResultsList.length=" + searchResultsList.size());

        AdsResultsBean arb = new AdsResultsBean();
        arb.setResults(searchResultsList);

        if (sar.size() > 0) {
                HashMap<Long, AdsBean> hm = new HashMap();
                for (int i = 0; i < sar.size(); i++) {
                    hm.put(sar.get(i).getAdId(), sar.get(i));
                }
                 for(int i=0;i<searchResultsList.size();i++) {
                    if(!hm.containsKey(((AdsBean)searchResultsList.get(i)).getAdId()))
                        sar.add(((AdsBean)searchResultsList.get(i)));
                }
                arb.setResults(sar);
            }

        request.setAttribute("latestAdResultsBean", arb);

        request.setAttribute("saveThisSearch", request.getRequestURI() + "?");
        request.setAttribute("keyword", keyword);
        request.setAttribute("subCatId", subCatId1);
        // this attribute for refine search tile display
        request.setAttribute("refineSearch", "hai");


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
//        LOG.info("query String =" + queryString);


        long endTime = System.currentTimeMillis();
        LOG.info("time taken to search= " + (endTime - startTime));

        request.setAttribute("m", request.getParameter("m"));

        return mapping.findForward(SUCCESS);
    }

    void getKeywordQuery(String keyword, StringBuffer sb1, StringBuffer sb2) {

        sb1.append(" AND ( ");
        sb2.append(" AND ( ");
        StringBuffer sb11 = new StringBuffer();
        StringBuffer sb22 = new StringBuffer();

        StringTokenizer stz = new StringTokenizer(keyword, " ");

        if (stz != null) {

            while (stz.hasMoreTokens()) {


                String keywordI = stz.nextToken();

//                LOG.info("sub keywords=" + keywordI);

                sb11.append(" TITLE LIKE '%" + keywordI + "%' OR DESCRIPTION LIKE '%" + keywordI + "%' OR ADDITIONAL_CONTENT LIKE '%" + keywordI + "%' OR TAGS LIKE '%" + keywordI + "%' OR");
                sb22.append(" TITLE LIKE '%" + keywordI + "%' OR DESCRIPTION LIKE '%" + keywordI + "%' OR ADDITIONAL_CONTENT LIKE '%" + keywordI + "%' OR TAGS LIKE '%" + keywordI + "%' OR");


            }
        }
//        LOG.info("sb1=" + sb11);
//        LOG.info("sb2=" + sb22);


        sb1 = sb1.append(sb11.substring(0, sb11.length() - 2) + ")");
        sb2 = sb2.append(sb22.substring(0, sb22.length() - 2) + ")");
    }
}
