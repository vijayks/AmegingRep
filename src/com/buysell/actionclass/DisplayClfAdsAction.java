/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.buysell.actionclass;
import com.buysell.beans.AdsBean;                              //Karteek
import com.buysell.servlets.SponsoredAdsThread;               //Karteek
import java.util.HashMap;                                      //Karteek
import com.buysell.beans.AdsResultsBean;                        //Karteek
import com.buysell.servlets.AdsService;
import com.buysell.util.BuySellProperties;
import com.buysell.util.CategoryUtil;
import java.util.ArrayList;
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
public class DisplayClfAdsAction extends org.apache.struts.action.Action {

    /* forward name="success" path="" */
    private final static String SUCCESS = "success";
    private final static Logger LOG = Logger.getLogger(DisplayClfAdsAction.class);

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
        LOG.info("DisplayClfAdsAction execute started");


        CategoryUtil cu = new CategoryUtil();
        request.setAttribute("categoryList", cu.getCategories());

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
            adType = "all";
        }
        request.setAttribute("adType", adType);

        String adTypeQuery = "";

        if (adType.equals("offered")) {
            adTypeQuery = " AND AD_FIELDS.AD_TYPE='offered' ";
        } else if (adType.equals("wanted")) {
            adTypeQuery = " AND AD_FIELDS.AD_TYPE='wanted' ";
        } else if (adType.equals("all")) {
            adTypeQuery = "";
        }

        int oBy = 1;
        int start = 0;
        int range = Integer.parseInt(BuySellProperties.getProperty("middle"));

        try {

            if(request.getParameter("start")!=null)
            start = Integer.parseInt(request.getParameter("start"));

        } catch (Exception e) {
            LOG.error("start:" + e);
        }
        try {

            if(request.getParameter("range")!=null)
            range = Integer.parseInt(request.getParameter("range"));

        } catch (Exception e) {
            LOG.error("range:" + e);
        }
        try {

            if(request.getParameter("byO")!=null)
            oBy = Integer.parseInt(request.getParameter("byO"));
        } catch (Exception e) {
            LOG.error("oBy:" + e);
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
                } else if (adType.equals("wanted")) {
                    oBy0 = " MINI ASC ";
                } else {
                    oBy0 = " PRICE ASC,MINI ASC ";
                }
                break;
            case 8:
                if (adType.equals("offered")) {
                    oBy0 = " PRICE DESC ";
                } else if (adType.equals("wanted")) {
                    oBy0 = " MINI DESC ";
                } else {
                    oBy0 = " PRICE DESC ,MINI DESC ";
                }
                break;
            default:
                oBy0 = " AD_T.AD_ID DESC ";
                break;
        }

        LOG.info("Last oBy0=" + oBy0);

        String clfId1 = request.getParameter("clfId");
        LOG.info("clfid=" + clfId1);



        String city = (String) request.getSession().getAttribute("city");

        String qry1 = null;
        String qry2 = null;
        LOG.info("\n\n\n**************************city=" + city + "****************************\n\n\n");
        if (city.trim().equals("All India")) {
            qry1 = "SELECT TITLE,IMAGE1,DESCRIPTION,ADDITIONAL_CONTENT, AD_T.AD_ID, AD_T.CREATION_DATE, FIRST_NAME,PRICE,NEGOTIABLE,CATEGORY_ID,LOGIN_NAME,AD_TYPE,ADDRESS_1,MINI,MAX,CITY,CONTACT_PRICE,PHONE,LOCALITY,AD_T.TAGS,AD_T.SPONSORED_TYPE from AD_FIELDS,AD_T,USER_T,USER_LOGIN_T,ADDRESS_T WHERE ADDRESS_T.ADDRESS_ID=AD_FIELDS.ADD_ID AND USER_T.USER_ID=USER_LOGIN_T.USER_ID AND AD_T.USER_ID=USER_T.USER_ID AND AD_FIELDS.AD_ID=AD_T.AD_ID  AND AD_T.STATUS=1 AND CATEGORY_ID=" + clfId1 + adTypeQuery + " ORDER BY " + oBy0 + "  LIMIT " + start + "," + range;  //Karteek

            qry2 = "SELECT COUNT(*) FROM AD_FIELDS,AD_T,USER_T,USER_LOGIN_T,ADDRESS_T WHERE ADDRESS_T.ADDRESS_ID=AD_FIELDS.ADD_ID AND USER_T.USER_ID=USER_LOGIN_T.USER_ID AND AD_T.USER_ID=USER_T.USER_ID AND AD_T.STATUS=1 AND AD_FIELDS.AD_ID=AD_T.AD_ID   AND CATEGORY_ID=" + clfId1 + adTypeQuery;

        } else {

            qry1 = "SELECT TITLE,IMAGE1,DESCRIPTION,ADDITIONAL_CONTENT, AD_T.AD_ID, AD_T.CREATION_DATE, FIRST_NAME,PRICE,NEGOTIABLE,CATEGORY_ID,LOGIN_NAME,AD_TYPE,ADDRESS_1,MINI,MAX,CITY,CONTACT_PRICE,PHONE,LOCALITY,AD_T.TAGS,AD_T.SPONSORED_TYPE from AD_FIELDS,AD_T,USER_T,USER_LOGIN_T,ADDRESS_T WHERE ADDRESS_T.ADDRESS_ID=AD_FIELDS.ADD_ID AND USER_T.USER_ID=USER_LOGIN_T.USER_ID AND AD_T.USER_ID=USER_T.USER_ID AND AD_FIELDS.AD_ID=AD_T.AD_ID  AND AD_T.STATUS=1 AND CATEGORY_ID=" + clfId1 + adTypeQuery + " AND ADDRESS_T.CITY='" + city + "' ORDER BY " + oBy0 + "  LIMIT " + start + "," + range;  //Karteek

            qry2 = "SELECT COUNT(*) FROM AD_FIELDS,AD_T,USER_T,USER_LOGIN_T,ADDRESS_T WHERE ADDRESS_T.ADDRESS_ID=AD_FIELDS.ADD_ID AND USER_T.USER_ID=USER_LOGIN_T.USER_ID AND AD_T.USER_ID=USER_T.USER_ID AND AD_T.STATUS=1 AND AD_FIELDS.AD_ID=AD_T.AD_ID  AND ADDRESS_T.CITY='" + city + "'  AND CATEGORY_ID=" + clfId1 + adTypeQuery;
        }

        AdsService as = new AdsService();
        ArrayList al = as.getClfAdsList(qry1, qry2, request);

        AdsResultsBean arb = new AdsResultsBean();
        arb.setResults(al);

        //Karteek Starts
        String fromRelated = request.getParameter("fromRelated");
        if(fromRelated == null) {
        if (start == 0) {
            ArrayList<AdsBean> sar = new ArrayList();
            sar = (ArrayList) SponsoredAdsThread.getCatCitySponsoredAds(5,Integer.parseInt(clfId1),city.trim());
            if (sar.size() > 0) {
                HashMap<Long, AdsBean> hm = new HashMap();
                for (int i = 0; i < sar.size(); i++) {
                    hm.put(sar.get(i).getAdId(), sar.get(i));
                }
                 for(int i=0;i<al.size();i++) {
                    if(!hm.containsKey(((AdsBean)al.get(i)).getAdId()))
                        sar.add(((AdsBean)al.get(i)));
                }
                arb.setResults(sar);
            }
        }
        }
//Karteek ends
        request.setAttribute("title", "Ads in " + cu.getCategoryNameWithId(Integer.parseInt(clfId1)));
        request.setAttribute("clfId", clfId1);
        LOG.info(" Title is saved in request' Object \n");
        request.setAttribute("latestAdResultsBean", arb);
        long endTime = System.currentTimeMillis();
        LOG.info("time taken to search= " + (endTime - startTime));
        request.setAttribute("m", "h");
        return mapping.findForward(SUCCESS);
    }
}
