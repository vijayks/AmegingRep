/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.buysell.actionclass;

import com.buysell.beans.AdsBean;
import com.buysell.beans.AdsResultsBean;
import com.buysell.servlets.AdsService;
import com.buysell.servlets.SponsoredAdsThread;
import com.buysell.util.BuySellProperties;
import com.buysell.util.CategoryUtil;
import com.buysell.util.City;
import com.buysell.util.CityUtil;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.ActionForward;

/**
 *
 * @author praveen.ch
 */
public class LatestAdAction extends org.apache.struts.action.Action {

    /* forward name="success" path="" */
    private final static String SUCCESS = "success";
    private static Logger LOG = Logger.getLogger(LatestAdAction.class);
    CityUtil cUtil = new CityUtil();
    CategoryUtil cu = new CategoryUtil();

    /**
     * This is the action called from the Struts framework.
     *
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
        LOG.info("LatestAdAction execute() started");



        request.setAttribute("categoryList", cu.getCategories());

        String urlstr = request.getRequestURI();

        if (urlstr.contains("/Buysell")) {
            request.setAttribute("reqURI", urlstr.substring(9));

            urlstr = urlstr.substring(9);

        } else {
            request.setAttribute("reqURI", urlstr.substring(1));

            urlstr = urlstr.substring(1);

        }

        // int oBy = 1;
        int start = 0;
        int range = Integer.parseInt(BuySellProperties.getProperty("middle"));
        String oBy0 = " AD_T.AD_ID DESC ";

        if (urlstr.equals("tile1.do")) {
            range = 10;

        } else {

            try {
                if (request.getParameter("start") != null) {
                    start = Integer.parseInt(request.getParameter("start"));
                } else {
                    start = 0;
                }
            } catch (Exception e) {
                LOG.error("start:" + e);
            }
            try {
                if (request.getParameter("range") != null) {
                    range = Integer.parseInt(request.getParameter("range"));
                } else {
                    range = 20;
                }


            } catch (Exception e) {
                LOG.error("range:" + e);
            }

        }


        City cityObj = (City) request.getSession().getAttribute("cityObj");

        String city = request.getParameter("city");

        if (city != null) {
            if (city.equals("All India")) {
                cityObj = new City();
                cityObj.setName("All India");
                String country = request.getParameter("country");
                String state = request.getParameter("state");

                if (state == null || country == null || state.trim().length() == 0 || country.trim().length() == 0) {
                    cityObj = (City) request.getSession().getAttribute("cityObj");
                    if (cityObj != null) {
                        country = cityObj.getCountry();
                        state = cityObj.getState();
                    }
                }
                if (state != null || country != null) {
                    request.getSession().setAttribute("state", state);
                    request.getSession().setAttribute("country", country);
//To do check this condition again
                    cityObj = cUtil.readCity(city, country, state);
                    if (cityObj != null) {
                        cityObj.setCountry(country);
                        cityObj.setState(state);
                        request.getSession().setAttribute("cityObj", cityObj);
                    }
                }
                request.getSession().setAttribute("city", city);
            }
        } else {

            city = (String) request.getSession().getAttribute("city");
        }
        if (cityObj == null) {
            cityObj = cUtil.getCityByName(city);
        }

        String cityName = (String) request.getSession().getAttribute("city");
        List cityClassList = new ArrayList();
        cityClassList = cUtil.viewAllCities();
        request.getSession().setAttribute("cities", cityClassList);
        request.getSession(true).setAttribute("city", cityName);
        request.getSession().setAttribute("cityObj", cityObj);
        AdsService ltas = new AdsService();
        String qry1 = null;
        String qry2 = null;
// All India
        LOG.debug("\n\n\n**************************city=" + city + "****************************\n\n\n");
        if (city.trim().equals("All India")) {

            qry1 = "SELECT TITLE,IMAGE1,DESCRIPTION,ADDITIONAL_CONTENT, AD_T.AD_ID, AD_T.CREATION_DATE, FIRST_NAME,PRICE,NEGOTIABLE,CATEGORY_ID,LOGIN_NAME,AD_TYPE,ADDRESS_1,MINI,MAX,CITY,CONTACT_PRICE,AD_T.USER_ID,PHONE,LOCALITY,AD_T.TAGS,RENT_MONTH,AD_T.DEALER_LOGO,AD_T.SPONSORED_TYPE from AD_FIELDS,AD_T,USER_T,USER_LOGIN_T,ADDRESS_T WHERE ADDRESS_T.ADDRESS_ID=AD_FIELDS.ADD_ID AND USER_T.USER_ID=USER_LOGIN_T.USER_ID AND AD_T.USER_ID=USER_T.USER_ID AND AD_FIELDS.AD_ID=AD_T.AD_ID  AND AD_T.STATUS=1    ORDER BY " + oBy0 + "  LIMIT " + start + "," + range + "";

            qry2 = "SELECT COUNT(*) FROM AD_FIELDS,AD_T,USER_T,USER_LOGIN_T,ADDRESS_T WHERE ADDRESS_T.ADDRESS_ID=AD_FIELDS.ADD_ID AND USER_T.USER_ID=USER_LOGIN_T.USER_ID AND AD_T.USER_ID=USER_T.USER_ID AND AD_T.STATUS=1 AND AD_FIELDS.AD_ID=AD_T.AD_ID  ";

        } else {
            qry1 = "SELECT TITLE,IMAGE1,DESCRIPTION,ADDITIONAL_CONTENT, AD_T.AD_ID, AD_T.CREATION_DATE, FIRST_NAME,PRICE,NEGOTIABLE,CATEGORY_ID,LOGIN_NAME,AD_TYPE,ADDRESS_1,MINI,MAX,CITY,CONTACT_PRICE,AD_T.USER_ID,PHONE,LOCALITY,AD_T.TAGS,RENT_MONTH,AD_T.DEALER_LOGO,AD_T.SPONSORED_TYPE from AD_FIELDS,AD_T,USER_T,USER_LOGIN_T,ADDRESS_T WHERE ADDRESS_T.ADDRESS_ID=AD_FIELDS.ADD_ID AND USER_T.USER_ID=USER_LOGIN_T.USER_ID AND AD_T.USER_ID=USER_T.USER_ID AND AD_FIELDS.AD_ID=AD_T.AD_ID  AND AD_T.STATUS=1   AND ADDRESS_T.CITY='" + city + "' ORDER BY " + oBy0 + "  LIMIT " + start + "," + range + "";

            qry2 = "SELECT COUNT(*) FROM AD_FIELDS,AD_T,USER_T,USER_LOGIN_T,ADDRESS_T WHERE ADDRESS_T.ADDRESS_ID=AD_FIELDS.ADD_ID AND USER_T.USER_ID=USER_LOGIN_T.USER_ID AND AD_T.USER_ID=USER_T.USER_ID AND AD_T.STATUS=1 AND AD_FIELDS.AD_ID=AD_T.AD_ID  AND ADDRESS_T.CITY='" + city + "'";
        }


        ArrayList<AdsBean> results = (ArrayList) ltas.getLatestAdsList(qry1, qry2, request);

        AdsResultsBean arb = new AdsResultsBean();
        arb.setResults(results);
        if (start == 0) {
            ArrayList<AdsBean> sar = new ArrayList();
            sar = (ArrayList) SponsoredAdsThread.getCitySponsoredAds(5, city.trim());
            if (sar.size() > 0) {
                HashMap<Long, AdsBean> hm = new HashMap();
                for (int i = 0; i < sar.size(); i++) {
                    hm.put(sar.get(i).getAdId(), sar.get(i));
                }
                for (int i = 0; i < results.size(); i++) {
                    if (!hm.containsKey(results.get(i).getAdId())) {
                        sar.add(results.get(i));
                    }
                }
                arb.setResults(sar);
            }
        }

        request.setAttribute("title", "Latest Ads");

        request.setAttribute("latestAdResultsBean", arb);

//        ArrayList s_Ads = new ArrayList();
//        s_Ads = ltas.getScrollAdsList(request);
//
//        request.setAttribute("scrollAds", s_Ads);

        long endTime = System.currentTimeMillis();
        LOG.debug("=////////////////////////////////////////////////////////////////  =");
        LOG.debug("time taken to search= " + (endTime - startTime));
        LOG.debug("= ///////////////////////////////////////////////////////////// =");
        request.setAttribute("m", "h");
        return mapping.findForward(SUCCESS);
    }
}
