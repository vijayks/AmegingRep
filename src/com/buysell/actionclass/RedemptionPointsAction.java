/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.buysell.actionclass;

import com.buysell.beans.UserBean;
import com.buysell.db.DbConnection;
import com.buysell.servlets.AdsService;
import com.buysell.util.CategoryUtil;
import java.util.ArrayList;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.ActionForward;

/**
 *
 * @author bbsadmin
 */
public class RedemptionPointsAction extends org.apache.struts.action.Action {
    
    /* forward name="success" path="" */
    private final static String SUCCESS = "success";
      private static Logger LOG = Logger.getLogger(RedemptionPointsAction.class);

    
    /**
     * This is the action called from the Struts framework.
     * @param mapping The ActionMapping used to select this instance.
     * @param form The optional ActionForm bean for this request.
     * @param request The HTTP Request we are processing.
     * @param response The HTTP Response we are processing.
     * @throws java.lang.Exception
     * @return
     */
    public ActionForward execute(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
          LOG.info("RedemptionPointsAction execute() strarted");
          request.setAttribute("categoryList", CategoryUtil.getCategories());
 
        UserBean ub = (UserBean) request.getSession().getAttribute("userBean");
        if(ub != null)
        {
        AdsService as= new AdsService();
        ArrayList al=as.getRedemptionPointsList(ub,request);
        request.setAttribute("RedemptionPointsList", al);
        request.setAttribute("m", "ma");
         return mapping.findForward(SUCCESS);
        }else
        {
            return mapping.findForward("notLogin");
        }
    }
}
