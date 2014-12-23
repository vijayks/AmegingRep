/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.buysell.actionclass;

import com.buysell.servlets.AdsService;
import com.buysell.util.ScrollAdsUtil;
import java.util.ArrayList;
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
public class ScrollAdsAction extends org.apache.struts.action.Action {

    /* forward name="success" path="" */
    private final static String SUCCESS = "success";
    private static Logger LOG = Logger.getLogger(ScrollAdsAction.class);
    ScrollAdsUtil sau = new ScrollAdsUtil();
    List s_Ads = new ArrayList();

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
        String city = (String) request.getSession().getAttribute("city");
        if (city == null) {
            city = "All India";
        }

        s_Ads = sau.getScrollAds(city);
        request.setAttribute("scrollAds", s_Ads);
        return mapping.findForward(SUCCESS);
    }
}
