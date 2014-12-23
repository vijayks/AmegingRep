/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.buysell.webshop.actionclasses;

import com.buysell.beans.DealerMoreInfo;
import com.buysell.webshop.beans.Product;
import com.buysell.webshop.db.ProductDBManager;
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
public class GetProductsDetails extends Action {

    /* forward name="success" path="" */
    private static final String SUCCESS = "success";
    private static Logger LOG = Logger.getLogger(GetProductsDetails.class);
    ProductDBManager pdm = new ProductDBManager();

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
        LOG.debug("== EXECUTE() started==");
        long wsId = (Long) request.getSession().getAttribute("activeWsId");
        if (request.getParameter("prodId") != null && wsId != 0) {
            String prdId = request.getParameter("prodId");
            long pId = Long.parseLong(prdId);
            Product p = new Product();
            p = pdm.getProductById(pId);
            request.setAttribute("prod", p);
            ArrayList pl = new ArrayList();
            pl = pdm.getProductsByWebshopId(wsId);
            request.setAttribute("wsProducts", pl);
            String du = (String) request.getSession().getAttribute("dw");
            if (du != null) {
                DealerMoreInfo dm = (DealerMoreInfo) WebsiteAction.hmp.get(du);
                if (dm != null) {
                    request.setAttribute("dealerWebsite", dm);
                }
            }
        }
        return mapping.findForward(SUCCESS);
    }
}
