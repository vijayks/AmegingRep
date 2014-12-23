/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.buysell.actionclass;

import com.buysell.util.SendMail;
import javax.servlet.RequestDispatcher;
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
public class SendToFriendAction extends org.apache.struts.action.Action {

    /* forward name="success" path="" */
    private final static String SUCCESS = "success";
    private static Logger LOG = Logger.getLogger(SendToFriendAction.class);

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
        LOG.info("sentofriend execute() started");
        String fName = request.getParameter("friendName");
        String fEmail = request.getParameter("friendEmail");
        LOG.info("== fname ==" + fName);
        LOG.info("== femail ==" + fEmail);

        String forwardToFriend = request.getParameter("forwardToFriend");
        String to = request.getParameter("to");
        String sentId = request.getParameter("sentId");
        String friendName = request.getParameter("friendName");
        String friendEmail = request.getParameter("friendEmail");
        LOG.info("forwardTo=" + forwardToFriend);
        LOG.info("to=" + to);
        LOG.info("sentId=" + sentId);
        LOG.info("from=" + form);
        LOG.info("friendName=" + friendName);
        LOG.info("friendEmail=" + friendEmail);
        boolean res =false ;

        try {
            SendMail sm = new SendMail();
            String sub = "Hi, " + fName + " I think you are looking for this";
            String msg = " <html><body>" +
                    "\n\n    Hello " + fName + "  Welcome to Bharatbuysell.com  <br>" +
                    "\n\n    your friend suggested this ad helps for u,   <br> " +
                    "\n\n To see more ads click www.getmyprints.co.in  </body></html>";

             res = sm.send(fEmail, sub, msg);
            LOG.info("== Message sent ==" + res);
        } catch (Exception e) {
            e.printStackTrace();
        }
        if(res)
        {
             request.getSession().setAttribute("sent", "successfully mail sent !");
        }else
        {
             request.getSession().setAttribute("sent", "mail sent failed !");
        }

        if (forwardToFriend != null && forwardToFriend.trim().length() > 0) {
           response.sendRedirect(response.encodeRedirectURL("/Buysell"+forwardToFriend));
         //   RequestDispatcher rd = request.getRequestDispatcher(forwardToFriend);
          //  rd.forward(request, response);
        }


        return mapping.findForward(SUCCESS);
    }
}
