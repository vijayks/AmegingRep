/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.buysell.actionclass;

import com.buysell.beans.AdsResultsBean;
import com.buysell.beans.UserBean;
import com.buysell.servlets.DealerService;
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
public class EditOrRenewOffersAction extends org.apache.struts.action.Action {
    
    /* forward name="success" path="" */
    private static final String SUCCESS = "success";
    private static Logger LOG = Logger.getLogger(EditOrRenewOffersAction.class);
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
        

        UserBean ub = (UserBean) request.getSession().getAttribute("userBean");
        DealerService ds = new DealerService();
        if(ub!=null) {
            int dId = ds.getDealerId(ub.getUserId());
            ArrayList al = ds.getEditorRenewOffersList(dId);

            request.setAttribute("title", "Edit/Renew Offers");

            AdsResultsBean arb = new AdsResultsBean();
            arb.setResults(al);
            request.setAttribute("editRenewOffersList", arb);
            request.setAttribute("m", "ma");
            return mapping.findForward(SUCCESS);
        }
        else {
            return mapping.findForward("notLogin");
        }
    }
}
