/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.buysell.actionclass;

import com.buysell.beans.UserBean;
import com.buysell.util.Mutil;
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
public class InviteFriendsBeforeAction extends org.apache.struts.action.Action {
    
    /* forward name="success" path="" */
    private static final String SUCCESS = "success";
    private static final Logger LOG = Logger.getLogger(InviteFriendsBeforeAction.class);

    
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
        if(ub!=null){
            int id = ub.getUserId();
                    Mutil mu = new Mutil();
                    String rcode = id + mu.getRandomCode(10);
                    LOG.debug("= Invite friends registration code::::: =" + rcode);
                    String city = (String) request.getSession().getAttribute("city");
                    if (city == null || city.length() <= 0) {
                        city = "All India";
                    }
                    request.setAttribute("city", city);
                    request.setAttribute("rid", rcode);
                    return mapping.findForward(SUCCESS);
        }else{
            return mapping.findForward("notLogin");
        }

    }
}
