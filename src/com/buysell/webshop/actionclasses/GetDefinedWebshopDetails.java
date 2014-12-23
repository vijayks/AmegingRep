/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.buysell.webshop.actionclasses;

import com.buysell.beans.DealerBean;
import com.buysell.webshop.db.CategoryDBManager;
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
public class GetDefinedWebshopDetails extends Action {

    /* forward name="success" path="" */
    private static final String SUCCESS = "success";
    private static final String NOTLOGIN = "notLogin";
    private static Logger LOG = Logger.getLogger(GetDefinedWebshopDetails.class);
    CategoryDBManager cdbm = new CategoryDBManager();
    ProductDBManager pdbm = new ProductDBManager();

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
        DealerBean db = (DealerBean) request.getSession().getAttribute("userBean");
        if (db != null) {
            String webId = request.getParameter("wi");
            String webName = request.getParameter("wn");
            String webStatus = request.getParameter("ws");
            long wsId = 0;
            if (webId != null && webId.trim().length() > 0) {
                wsId = Long.parseLong(webId);
                request.setAttribute("wi", wsId);
            }
//            ArrayList al1= cdbm.getCategoriesByDid(db.getDlId());
//            request.setAttribute("catList", al1);
            ArrayList al2 = cdbm.getWebshopDetailsByWebId(wsId);
            request.setAttribute("webshopCategories", al2);
//            ArrayList al3 = pdbm.getProductsByDealerId(db.getDlId());
//            request.setAttribute("prodList", al3);
            ArrayList al4 = pdbm.getProductsByWebshopId(wsId);
            request.setAttribute("webshopProducts", al4);
            if (webName != null && webName.trim().length() > 0) {
                request.setAttribute("wn", webName);
            }
            if (webStatus != null && webStatus.trim().length() > 0) {
                request.setAttribute("ws", webStatus);
            }
            return mapping.findForward(SUCCESS);
        }
        return mapping.findForward(NOTLOGIN);
    }
}
