/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.buysell.actionclass;

import com.buysell.beans.AdsResultsBean;
import com.buysell.beans.UserBean;
import com.buysell.servlets.AdsService;
import com.buysell.util.CategoryUtil;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.ActionForward;
import java.lang.Integer;
import java.util.ArrayList;

/**
 *
 * @author Karteek
 */
public class SpecificPreffAdsAction extends org.apache.struts.action.Action {

    /* forward name="success" path="" */
    private final static String SUCCESS = "success";
    private static Logger LOG = Logger.getLogger(SpecificAdsAction.class);

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

        LOG.info("SpecificAdsAction execute() method started");
        int status = Integer.parseInt(request.getParameter("status"));

        request.setAttribute("categoryList", CategoryUtil.getCategories());

        AdsService as = new AdsService();
        UserBean ub = (UserBean) request.getSession().getAttribute("userBean");
        if (ub != null) {
            ArrayList al = as.getSpecificPreffAdsList(ub, status);
            if (status == 1) {
                request.setAttribute("title", "Active Ads");
            } else if (status == 2) {
                request.setAttribute("title", "On Hold Ads");

            } else if (status == 4) {
                request.setAttribute("title", "Expired Ads");

            } else if (status == 5) {
                request.setAttribute("title", "Deleted Ads");

            } else if (status == 6) {
                request.setAttribute("title", "Incomplete Ads");

            } else if (status == 7) {
                request.setAttribute("title", "Rejected Ads");
            }
            AdsResultsBean arb = new AdsResultsBean();
            arb.setResults(al);
            request.setAttribute("specificAdsList", arb);
            request.setAttribute("m", "ma");
            return mapping.findForward(SUCCESS);
        } else {
            return mapping.findForward("notLogin");
        }


    }
}
