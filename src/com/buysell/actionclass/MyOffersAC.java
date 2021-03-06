/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.buysell.actionclass;

import com.buysell.beans.MyAdDetailsBean;
import com.buysell.beans.UserBean;
import com.buysell.servlets.AdsService;

import com.buysell.servlets.DealerService;
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
public class MyOffersAC extends org.apache.struts.action.Action {

    /* forward name="success" path="" */
    private static final String SUCCESS = "success";
    Logger LOG = Logger.getLogger(MyOffersAC.class);

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
        LOG.info("  MyOffersAC EXECUTE() started! ");


        UserBean ub = (UserBean) request.getSession().getAttribute("userBean");
        if (ub != null) {
            DealerService ds = new DealerService();
            int dId=ds.getDealerId(ub.getUserId());
            MyAdDetailsBean madb = ds.setMyOfferDetails(dId);
            request.getSession().setAttribute("myOfferDetailsBean", madb);
            request.setAttribute("m", "ma");
            return mapping.findForward(SUCCESS);

        } else {
            return mapping.findForward("notLogin");
        }

    }
    // return mapping.findForward(SUCCESS);
    }
//}

