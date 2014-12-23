/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.buysell.webshop.actionclasses;

import com.buysell.beans.DealerBean;
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
public class EditWebshopAction extends org.apache.struts.action.Action {

    /* forward name="success" path="" */
    private static final String SUCCESS = "success";
    private static final String NOTLOGIN = "notLogin";
    private static final String EDITSUCCESS = "editSuccess";
    private static Logger LOG = Logger.getLogger(EditWebshopAction.class);
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

        LOG.debug("== EXECUTE() started==");
        DealerBean db = (DealerBean) request.getSession().getAttribute("userBean");
        long dId1 = db.getDlId();
        ArrayList al = new ArrayList();
        if (db != null && request.getParameter("nm") == null) {
            long dId = db.getDlId();
            al = cdm.getWebshopsBydId(dId);
            request.setAttribute("webshopList", al);
            return mapping.findForward(SUCCESS);
        } else if (request.getParameter("nm") != null && request.getParameter("wsId") != null) {
            String webId = request.getParameter("wsId");
            String wenNM = request.getParameter("nm");
            int cId = Integer.parseInt(webId);
            ArrayList al2 = cdm.getWebshopDetailsByWebId(Integer.parseInt(webId));
            request.setAttribute("categoryWS", al2);

            ArrayList al3 = new ArrayList();
            al3 = cdm.getCategoriesByDid(dId1);
            request.setAttribute("catList", al3);
//        request.setAttribute("categoryList", wsCategoryUtil.getCategories());
            return mapping.findForward(EDITSUCCESS);
        }
        return mapping.findForward(NOTLOGIN);

    }
}
