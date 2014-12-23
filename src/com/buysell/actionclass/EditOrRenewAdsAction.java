 /*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.buysell.actionclass;

import com.buysell.beans.AdsResultsBean;
import com.buysell.beans.UserBean;
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
public class EditOrRenewAdsAction extends org.apache.struts.action.Action {

    /* forward name="success" path="" */
    private final static String SUCCESS = "success";
    private static Logger LOG = Logger.getLogger(EditOrRenewAdsAction.class);

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

        LOG.info("EditOrRenewAdsAction execute() started");


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


        int oBy = 1;
        int start = 0;
        int range = Integer.parseInt(BuySellProperties.getProperty("middle"));

        try {

            start = Integer.parseInt(request.getParameter("start"));

        } catch (Exception e) {
            LOG.error("start:" + e);
        }
        try {

            range = Integer.parseInt(request.getParameter("range"));

        } catch (Exception e) {
            LOG.error("range:" + e);
        }
        try {

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


        AdsService as = new AdsService();
        UserBean ub = (UserBean) request.getSession().getAttribute("userBean");

        if (ub != null) {

            ArrayList results = (ArrayList) as.getEditOrRenewAdsList(start, range, oBy0, ub, request);
            LOG.info("Results are captured form EditOrRenewAdsService [as.getLatestAdsList()]");

            AdsResultsBean arb = new AdsResultsBean();
            arb.setResults(results);

            request.setAttribute("title", "Edit / Renew Ads");
            LOG.info(" Title is saved in request' Object \n");


            request.setAttribute("editOrRenewAdsResultsBean", arb);
            LOG.info("EditOrRenewAdsResultsBean objects are Stored in 'request' Object \n");
            request.setAttribute("m", "ma");
            if(request.getParameter("from")!=null && request.getParameter("from").startsWith("fail")) {
                request.setAttribute("notOwnAd", "Requested Ad does not belongs to you");
            }
            return mapping.findForward(SUCCESS);
        } else {
            return mapping.findForward("notLogin");
        }


    }
}
