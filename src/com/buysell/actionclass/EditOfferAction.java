/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.buysell.actionclass;

import com.buysell.servlets.AdsService;
import com.buysell.util.CategoryUtil;
import com.buysell.util.CityUtil;
import java.util.List;
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
public class EditOfferAction extends org.apache.struts.action.Action {
    
    /* forward name="success" path="" */
    private static final String SUCCESS = "success";
    private static final Logger LOG = Logger.getLogger("EditOfferAction.class ");
    CategoryUtil cu = new CategoryUtil();
    CityUtil ctu = new CityUtil();
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
        
        if(request.getParameter("sid")!=null) {

            int id = Integer.parseInt(request.getParameter("sid"));
            AdsService as =new AdsService();
            List ofl = as.getCurrentOffers(id);
            request.setAttribute("offerList", ofl);
            request.setAttribute("sId", id);
        }
        if(request.getParameter("from")!=null && request.getParameter("from").equals("tide")) {
            request.setAttribute("submitValue", "Update");
        }
        else if(request.getParameter("from")!=null && request.getParameter("from").equals("newre")) {
            request.setAttribute("submitValue", "Update & Renew");
        }
        else if(request.getParameter("from")!=null && request.getParameter("from").equals("cejr")) {
            request.setAttribute("submitValue", "Repost");
        }        
        request.setAttribute("categoryList", cu.getCategories());
        request.setAttribute("cities", ctu.viewAllCities());
        return mapping.findForward(SUCCESS);
    }
}
