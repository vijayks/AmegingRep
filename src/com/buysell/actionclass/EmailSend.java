/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.buysell.actionclass;

import com.buysell.util.SendMail;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

/**
 *
 * @author bbsadmin
 */
public class EmailSend extends org.apache.struts.action.Action {

    private final static String SUCCESS = "success";
    private static Logger LOG = Logger.getLogger(EmailSend.class);

    @Override
     public ActionForward execute(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        

         LOG.info("== Request comes to email send action class ==");
         String fn = request.getParameter("fname");
         String fe = request.getParameter("femail");
         String s = "www.bharatbuysell.com";
         String msg = "<html><head><title>" +
                        request.getParameter("fname") +
                        "</title></head><body><h1>" +
                        request.getParameter("femail") +
                        "</h1><p>This is a test of sending an HTML e-mail" +
                        " through Java.<a> clcik here </a></body></html> ";

         LOG.info("== Friends name =="+request.getParameter("fname"));
         LOG.info("== friends mail =="+request.getParameter("femail"));

         SendMail sm=new SendMail();
         boolean res=sm.send(fe, s, msg);
         LOG.info("== Message sent =="+res);
        request.getSession().setAttribute("ok", " Your message sent :"+res+"...");


     return mapping.findForward(SUCCESS);
     }


}
