/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.buysell.actionclass;

import com.buysell.beans.AdsResultsBean;
import com.buysell.servlets.AdsService;
import java.util.ArrayList;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

/**
 *
 * @author bbsadmin
 */
public class RecentAdsAction extends Action {
    
    /* forward name="success" path="" */
    private static final String SUCCESS = "success";
    private static Logger LOG = Logger.getLogger(RecentAdsAction.class);
//    CityUtil cUtil = new CityUtil();
//    CategoryUtil cu = new CategoryUtil();
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

//        request.setAttribute("categoryList", cu.getCategories());
//        String urlstr = request.getRequestURI();
//
//        if (urlstr.contains("/Buysell")) {
//            request.setAttribute("reqURI", urlstr.substring(9));
//
//            urlstr = urlstr.substring(9);
//
//        } else {
//            request.setAttribute("reqURI", urlstr.substring(1));
//
//            urlstr = urlstr.substring(1);
//
//        }
//        List cityClassList = new ArrayList();
//        cityClassList = cUtil.viewAllCities();
//        request.getSession().setAttribute("cities", cityClassList);
//        request.setAttribute("title", "Recent Ads");
//        request.setAttribute("m", "h");

        String city = (String) request.getSession().getAttribute("city");

        AdsService ltas = new AdsService();
        String qry1 = null;
        String qry2 = null;
        // All India
        if (city!=null && city.trim().equals("All India")) {

            qry1 = "SELECT TITLE,IMAGE1,DESCRIPTION,ADDITIONAL_CONTENT, AD_T.AD_ID, AD_T.CREATION_DATE, FIRST_NAME,PRICE,NEGOTIABLE,CATEGORY_ID,LOGIN_NAME,AD_TYPE,ADDRESS_1,MINI,MAX,CITY,CONTACT_PRICE,AD_T.USER_ID,PHONE,LOCALITY,AD_T.TAGS,RENT_MONTH,AD_T.DEALER_LOGO,SPONSORED_TYPE from AD_FIELDS,AD_T,USER_T,USER_LOGIN_T,ADDRESS_T WHERE ADDRESS_T.ADDRESS_ID=AD_FIELDS.ADD_ID AND USER_T.USER_ID=USER_LOGIN_T.USER_ID AND AD_T.USER_ID=USER_T.USER_ID AND AD_FIELDS.AD_ID=AD_T.AD_ID  AND AD_T.STATUS=1  AND AD_T.CREATION_DATE BETWEEN (ADDDATE(NOW(),INTERVAL -2 DAY)) AND (ADDDATE(NOW(),INTERVAL 1 DAY)) ORDER BY AD_T.AD_ID DESC ";

            qry2 = "SELECT COUNT(*) FROM AD_FIELDS,AD_T,USER_T,USER_LOGIN_T,ADDRESS_T WHERE ADDRESS_T.ADDRESS_ID=AD_FIELDS.ADD_ID AND USER_T.USER_ID=USER_LOGIN_T.USER_ID AND AD_T.USER_ID=USER_T.USER_ID AND AD_T.STATUS=1 AND AD_FIELDS.AD_ID=AD_T.AD_ID  AND AD_T.CREATION_DATE BETWEEN (ADDDATE(NOW(),INTERVAL -2 DAY)) AND (ADDDATE(NOW(),INTERVAL 1 DAY)) ";

        } else {
            qry1 = "SELECT TITLE,IMAGE1,DESCRIPTION,ADDITIONAL_CONTENT, AD_T.AD_ID, AD_T.CREATION_DATE, FIRST_NAME,PRICE,NEGOTIABLE,CATEGORY_ID,LOGIN_NAME,AD_TYPE,ADDRESS_1,MINI,MAX,CITY,CONTACT_PRICE,AD_T.USER_ID,PHONE,LOCALITY,AD_T.TAGS,RENT_MONTH,AD_T.DEALER_LOGO,SPONSORED_TYPE from AD_FIELDS,AD_T,USER_T,USER_LOGIN_T,ADDRESS_T WHERE ADDRESS_T.ADDRESS_ID=AD_FIELDS.ADD_ID AND USER_T.USER_ID=USER_LOGIN_T.USER_ID AND AD_T.USER_ID=USER_T.USER_ID AND AD_FIELDS.AD_ID=AD_T.AD_ID  AND AD_T.STATUS=1  AND AD_T.CREATION_DATE BETWEEN (ADDDATE(NOW(),INTERVAL -2 DAY)) AND (ADDDATE(NOW(),INTERVAL 1 DAY)) AND ADDRESS_T.CITY='" + city + "' ORDER BY AD_T.AD_ID DESC ";

            qry2 = "SELECT COUNT(*) FROM AD_FIELDS,AD_T,USER_T,USER_LOGIN_T,ADDRESS_T WHERE ADDRESS_T.ADDRESS_ID=AD_FIELDS.ADD_ID AND USER_T.USER_ID=USER_LOGIN_T.USER_ID AND AD_T.USER_ID=USER_T.USER_ID AND AD_T.STATUS=1 AND AD_FIELDS.AD_ID=AD_T.AD_ID  AND AD_T.CREATION_DATE BETWEEN (ADDDATE(NOW(),INTERVAL -2 DAY)) AND (ADDDATE(NOW(),INTERVAL 1 DAY)) AND ADDRESS_T.CITY='" + city + "'";
        }

        ArrayList results = (ArrayList) ltas.getLatestAdsList(qry1, qry2, request);

        AdsResultsBean arb = new AdsResultsBean();
        arb.setResults(results);
        request.setAttribute("recentAdResultsBean", arb);

        return mapping.findForward(SUCCESS);
    }
}
