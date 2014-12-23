/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.buysell.webshop.actionclasses;

import com.buysell.beans.DealerBean;
import com.buysell.webshop.db.ProductDBManager;
import java.sql.Connection;
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
public class AssignDProducts extends Action {

    /* forward name="success" path="" */
    private static final String SUCCESS = "success";
    private static final String NOTLOGIN = "notLogin";
    private static Logger LOG = Logger.getLogger(AssignDProducts.class);
    Connection con = null;
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
        LOG.debug("===========EXECUTE() started==========");
        DealerBean db = (DealerBean) request.getSession().getAttribute("userBean");
        if (db != null) {
            String pId[] = request.getParameterValues("asPr");
            String catNM = request.getParameter("catName");
            String catId = request.getParameter("catId");
            long cId = 0;
            if (catId != null && catId.trim().length() > 0) {
                cId = Long.parseLong(catId);
            }
            String rs = null;
            StringBuffer sb = new StringBuffer();
            int l = 0;
            if (pId != null) {
                l = pId.length;
            }
            for (int i = 0; i < l; i++) {
                sb.append(pId[i]);
                sb.append('^');
            }
            rs = pdbm.assignProductCategory(cId, sb.toString(), l);
            if (rs != null && rs.startsWith("suc")) {
                request.setAttribute("succMsg", "Assigned successfully");
            } else {
                request.setAttribute("errMsg", "Error occurred while Assigning products");
            }
            return mapping.findForward(SUCCESS);
        }
        return mapping.findForward(NOTLOGIN);
    }
}
