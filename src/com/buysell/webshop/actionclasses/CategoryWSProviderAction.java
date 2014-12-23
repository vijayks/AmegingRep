/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.buysell.webshop.actionclasses;

import com.buysell.beans.DealerBean;
import com.buysell.webshop.db.CategoryDBManager;
import java.util.ArrayList;
import org.apache.log4j.Logger;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

/**
 *
 * @author bbsadmin
 */
public class CategoryWSProviderAction extends Action {

    /* forward name="success" path="" */
    private static final String SUCCESS = "success";
    private static Logger LOG = Logger.getLogger(CategoryWSProviderAction.class);
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
        LOG.debug("===============EXECUTE() Started==========");
        DealerBean db = (DealerBean) request.getSession().getAttribute("userBean");
        long dId = db.getDlId();
        if (dId != '0') {
            ArrayList al = new ArrayList();

            al = cdm.getCategoriesByDid(dId);
            request.setAttribute("catList", al);

        }

        return mapping.findForward(SUCCESS);
    }
}
