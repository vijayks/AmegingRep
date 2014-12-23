/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.buysell.webshop.actionclasses;

import com.buysell.beans.DealerBean;
import com.buysell.webshop.db.CategoryDBManager;
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
public class UpdateWebshopAction extends Action {

    /* forward name="success" path="" */
    private static final String SUCCESS = "success";
    private static final String NOTLOGIN = "notLogin";
    private static final String DELSUCCESS = "delSuccess";
    private static Logger LOG = Logger.getLogger(UpdateWebshopAction.class);
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
        LOG.debug("===== EXECUTE() started====");

        DealerBean db = (DealerBean) request.getSession().getAttribute("userBean");
        long dId = db.getDlId();
        String webNM = request.getParameter("wbNM");
        String webId = request.getParameter("wbId");
        if (db != null) {
            if (webId != null && request.getParameter("del") == null) {
                long wid = Long.parseLong(webId);
                String[] catList = request.getParameterValues("cat");
                int catListSz = 0;
                int i = 0;
                StringBuffer sb = new StringBuffer();
                if (catList != null) {
                    for (i = 0; i < catList.length; i++) {
                        sb.append(catList[i] + '^');
                        catListSz = i;
                    }
                }
                if (wid != 0) {
                    String msg = cdm.updateWebshop(dId, webNM, sb.toString(), catListSz + 1, wid);
                    LOG.debug("Updated Successfully ::" + msg);
                }
                request.setAttribute("Msg", "Webshop Updated Successfully");
                return mapping.findForward(SUCCESS);
            } else if (request.getParameter("del") != null && request.getParameter("del").equals("del")) {
                int wId = Integer.parseInt(request.getParameter("wbId"));
                CategoryDBManager cm = new CategoryDBManager();
                String res = cm.deleteWebshop(dId, wId);
                request.setAttribute("res", res);
                return mapping.findForward(SUCCESS);
            }
        }
        return mapping.findForward(NOTLOGIN);
    }
}
