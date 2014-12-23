/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.buysell.webshop.actionclasses;

import com.buysell.beans.DealerMoreInfo;
import com.buysell.servlets.DealerService;
import com.buysell.webshop.db.CategoryDBManager;
import java.util.HashMap;
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
public class WebsiteAction extends Action {

    /* forward name="success" path="" */
    private static final String SUCCESS = "success";
    private static final String NOSUBDOMAIN = "nsd";
    private static Logger LOG = Logger.getLogger(WebsiteAction.class);
    DealerService ds = new DealerService();
    CategoryDBManager cdm = new CategoryDBManager();
    public static HashMap hmp = new HashMap();

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

        LOG.debug("Website Action called ...");
        String dws = request.getParameter("dw");
        if(dws==null){
            dws=(String) request.getSession().getAttribute("dw");
        }
        if (dws != null && dws.trim().length() > 0) {

            DealerMoreInfo dm = (DealerMoreInfo) hmp.get(dws.trim());
            if (dm != null) {
                request.getSession().setAttribute("dw", dm.getWebsite());
            } else {
                dm = ds.getDealerMoreInfoByWebsite(dws);
                dm.setWsCatList(cdm.getWebshopDetailsByWebId(dm.getActiveWsId()));
                dm.setWebsiteImages(cdm.getWebsiteAdImages(dm.getdId()));
                hmp.put(dws.trim(), dm);
            }
            request.getSession().setAttribute("dw", dm.getWebsite());
            request.getSession().setAttribute("activeWsId", dm.getActiveWsId());
            request.setAttribute("dealerWebsite", dm);
        } else {
            return mapping.findForward(NOSUBDOMAIN);
        }

        return mapping.findForward(SUCCESS);
    }
}
