/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.buysell.actionclass;

import com.buysell.servlets.AdsService;
import com.buysell.util.CategoryUtil;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.ActionForward;

/**
 *
 * @author bbsadmin
 */
public class SpOfferAction extends org.apache.struts.action.Action {
    
    /* forward name="success" path="" */
    private final static String SUCCESS = "success";
     private final static String SCROLLOFFER = "scrolloffer";
    
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
         CategoryUtil cu = new CategoryUtil();
        request.setAttribute("categoryList", cu.getCategories());
        List al=new ArrayList();
        int sid=Integer.parseInt(request.getParameter("sid"));
        String from=request.getParameter("from");

        AdsService ads=new AdsService();
        if(from != null && from.equals("spo"))
        {
            al=ads.getScrollfferImg(sid);
            request.setAttribute("spoImgList", al);
            return mapping.findForward(SCROLLOFFER);
        }
        al=ads.getCurrentOffers(sid);
        request.setAttribute("slist", al);
        request.setAttribute("m", "h");
        return mapping.findForward(SUCCESS);
    }
}
