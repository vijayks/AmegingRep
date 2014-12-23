/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.buysell.actionclass;

import com.buysell.beans.AdsBean;                              //Karteek
import com.buysell.beans.AdsResultsBean;                      //Karteek
import com.buysell.servlets.SponsoredAdsThread;               //Karteek
import java.util.HashMap;                                      //Karteek
import com.buysell.servlets.AdsService;
import com.buysell.util.CategoryUtil;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
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
public class ClfDisplayAction extends org.apache.struts.action.Action {

    /* forward name="success" path="" */
    private final static String SUCCESS = "success";
    private static Logger LOG = Logger.getLogger(ClfDisplayAction.class);

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
        String subCatId1 = request.getParameter("subCatId");
        int subCatId = 6;
        if (subCatId1 != null) {
            subCatId = Integer.parseInt(subCatId1);
            request.setAttribute("subCatId", subCatId + "");
        }


        CategoryUtil cu = new CategoryUtil();
        request.setAttribute("categoryList", cu.getCategories());
        LOG.debug("CategoryList object is stored in the request scope");


        List clfIds = new ArrayList();
        clfIds = cu.getClfCatIdsWithSubCatId(subCatId);
        request.setAttribute("clfIds", clfIds);

        String clfList = null;


        if (!clfIds.isEmpty()) {
            StringBuffer sb = new StringBuffer();
            sb.append(" AND CATEGORY_ID IN( ");
            for (Iterator itr = clfIds.iterator(); itr.hasNext();) {
                sb.append(itr.next() + ",");
            }
            clfList = sb.substring(0, sb.length() - 1) + ")  ";
        }


        String urlstr = request.getRequestURI();

        if (urlstr.contains("/Buysell")) {
            request.setAttribute("reqURI", request.getRequestURI().substring(9));
            LOG.debug("reqURI=" + request.getRequestURI().substring(9));
        } else {
            request.setAttribute("reqURI", request.getRequestURI().substring(1));
            LOG.debug("reqURI=" + request.getRequestURI().substring(1));
        }

        //      int oBy = 1;
        int start = 0;
        int range = 10;
        String oBy0 = " AD_T.AD_ID DESC ";
        /*    int range = 20;

        try {
        start = Integer.parseInt(request.getParameter("start"));
        range = Integer.parseInt(request.getParameter("range"));
        oBy = Integer.parseInt(request.getParameter("byO"));

        } catch (Exception e) {
        LOG.info("Error start range values passing:" + e);
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
        oBy0 = " PRICE ASC ";
        break;
        case 8:
        oBy0 = " PRICE DESC ";
        break;
        default:
        oBy0 = " AD_T.AD_ID DESC ";
        break;
        }

        LOG.info("Last oBy0=" + oBy0);
         */
        String city = request.getParameter("city");
        if (city != null) {
            Cookie cityCookie = new Cookie("presentCity", city);
            LOG.debug("getMaxAge=" + cityCookie.getMaxAge());
            cityCookie.setMaxAge(360 * 24 * 60 * 60);
            response.addCookie(cityCookie);
            request.getSession().setAttribute("city", city);

        } else {
            city = (String) request.getSession().getAttribute("city");
        }

        // String  city = (String) request.getSession().getAttribute("city");
        LOG.debug("User Selected City>>>>>>>>" + city);

        AdsService ltas = new AdsService();
        LOG.debug("LatestAdService is instantiated");
        String qry1 = null;
        String qry2 = null;
        LOG.debug("\n\n\n**************************city=" + city + "****************************\n\n\n");
        if (city.trim().equals("All India")) {


            qry1 = "SELECT TITLE,IMAGE1,DESCRIPTION,ADDITIONAL_CONTENT, AD_T.AD_ID, AD_T.CREATION_DATE, FIRST_NAME,PRICE,NEGOTIABLE,CATEGORY_ID,LOGIN_NAME,AD_TYPE,ADDRESS_1,MINI,MAX,CITY,CONTACT_PRICE,AD_T.USER_ID,PHONE,LOCALITY,TAGS,RENT_MONTH,AD_T.DEALER_LOGO,AD_T.SPONSORED_TYPE from AD_FIELDS,AD_T,USER_T,USER_LOGIN_T,ADDRESS_T WHERE ADDRESS_T.ADDRESS_ID=AD_FIELDS.ADD_ID AND USER_T.USER_ID=USER_LOGIN_T.USER_ID AND AD_T.USER_ID=USER_T.USER_ID AND AD_FIELDS.AD_ID=AD_T.AD_ID  AND AD_T.STATUS=1 " + clfList + "   ORDER BY " + oBy0 + "  LIMIT " + start + "," + range + "";      //Karteek

            qry2 = "SELECT COUNT(*) FROM AD_FIELDS,AD_T,USER_T,USER_LOGIN_T,ADDRESS_T WHERE ADDRESS_T.ADDRESS_ID=AD_FIELDS.ADD_ID AND USER_T.USER_ID=USER_LOGIN_T.USER_ID AND AD_T.USER_ID=USER_T.USER_ID AND AD_T.STATUS=1 AND AD_FIELDS.AD_ID=AD_T.AD_ID  " + clfList;



        } else {
            qry1 = "SELECT TITLE,IMAGE1,DESCRIPTION,ADDITIONAL_CONTENT, AD_T.AD_ID, AD_T.CREATION_DATE, FIRST_NAME,PRICE,NEGOTIABLE,CATEGORY_ID,LOGIN_NAME,AD_TYPE,ADDRESS_1,MINI,MAX,CITY,CONTACT_PRICE,AD_T.USER_ID,PHONE,LOCALITY,TAGS,RENT_MONTH,AD_T.DEALER_LOGO,AD_T.SPONSORED_TYPE from AD_FIELDS,AD_T,USER_T,USER_LOGIN_T,ADDRESS_T WHERE ADDRESS_T.ADDRESS_ID=AD_FIELDS.ADD_ID AND USER_T.USER_ID=USER_LOGIN_T.USER_ID AND AD_T.USER_ID=USER_T.USER_ID AND AD_FIELDS.AD_ID=AD_T.AD_ID  AND AD_T.STATUS=1 " + clfList + "  AND ADDRESS_T.CITY='" + city + "' ORDER BY " + oBy0 + "  LIMIT " + start + "," + range + "";    //Karteek

            qry2 = "SELECT COUNT(*) FROM AD_FIELDS,AD_T,USER_T,USER_LOGIN_T,ADDRESS_T WHERE ADDRESS_T.ADDRESS_ID=AD_FIELDS.ADD_ID AND USER_T.USER_ID=USER_LOGIN_T.USER_ID AND AD_T.USER_ID=USER_T.USER_ID AND AD_T.STATUS=1 AND AD_FIELDS.AD_ID=AD_T.AD_ID  AND ADDRESS_T.CITY='" + city + "'" + clfList;


        }


            ArrayList results = (ArrayList) ltas.getLatestAdsList(qry1, qry2, request);
        LOG.debug("count=" + request.getAttribute("c"));
        LOG.debug("Results are captured form LatestAdService [ltas.getLatestAdsList()]");

        AdsResultsBean arb = new AdsResultsBean();
        arb.setResults(results);
 //Karteek Starts

        if (start == 0) {
            ArrayList<AdsBean> sar = new ArrayList();
            sar = (ArrayList) SponsoredAdsThread.getCatCitySponsoredAds(5,subCatId,city.trim());
            if (sar.size() > 0) {
                HashMap<Long, AdsBean> hm = new HashMap();
                for (int i = 0; i < sar.size(); i++) {
                    hm.put(sar.get(i).getAdId(), sar.get(i));
                }
                 for(int i=0;i<results.size();i++) {
                    if(!hm.containsKey(((AdsBean)results.get(i)).getAdId()))
                        sar.add(((AdsBean)results.get(i)));
                }
                arb.setResults(sar);
            }
        }

//Karteek ends

        request.setAttribute("title", "Latest Ads in " + cu.getCategoryNameWithId(subCatId));
        LOG.debug(" Title is saved in request' Object \n");



        request.setAttribute("latestAdResultsBean", arb);
        LOG.debug("LatestAdBean objects are Stored in 'request' Object \n");


        long endTime = System.currentTimeMillis();
        LOG.debug("time taken to search= " + (endTime - startTime));
        // request.setAttribute("subCatAdsCount", subCatAdsCount);
        //  request.setAttribute("clfCount", hm);

        request.setAttribute("m", "h");
        return mapping.findForward(SUCCESS);
    }
}
