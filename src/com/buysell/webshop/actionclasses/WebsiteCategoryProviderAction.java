/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.buysell.webshop.actionclasses;

import com.buysell.webshop.db.CategoryDBManager;
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
public class WebsiteCategoryProviderAction extends Action {

    /* forward name="success" path="" */
    private static final String SUCCESS = "success";
    private static final String FAILURE = "failure";
    private static Logger LOG = Logger.getLogger(WebsiteCategoryProviderAction.class);
    CategoryDBManager cdm = new CategoryDBManager();

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
        LOG.debug("WebsiteCategoryProviderAction execute started ...");
        long awId = (Long) (request.getSession().getAttribute("activeWsId"));
        if (awId != 0) {
            ArrayList al = cdm.getWebshopDetailsByWebId(awId);
            request.getSession().setAttribute("awsCategories", al);
            return mapping.findForward(SUCCESS);
        }
        LOG.error("Session Webshop Id is null");
        return mapping.findForward(FAILURE);
    }
}
