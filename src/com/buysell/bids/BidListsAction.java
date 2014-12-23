/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.buysell.bids;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
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
public class BidListsAction extends Action {
    
    /* forward name="success" path="" */
    private static final String SUCCESS = "success";
    public static Map<Long,BidItemBean> bidmap = new HashMap();
    public static Map<Long,BidItemBean> futurebid = new HashMap();
    BidAnnouncer ba = new BidAnnouncer();
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

            List l =new ArrayList(BidListsAction.bidmap.values());
            Collections.reverse(l);
            request.setAttribute("currentBids", l);
            l = new ArrayList(BidListsAction.futurebid.values());
            Collections.reverse(l);
            request.setAttribute("comingBids", l);
            request.setAttribute("closedBids", ba.bidAnn.elements());
        return mapping.findForward(SUCCESS);
    }

}
