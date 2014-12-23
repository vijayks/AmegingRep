/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.buysell.actionclass;

import com.buysell.beans.UserBean;
import com.buysell.util.ContactImporter;
import com.buysell.util.Mutil;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.log4j.Logger;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.castor.jdo.conf.Mapping;

/**
 *
 * @author bbsadmin
 */
public class InviteFriends extends org.apache.struts.action.Action {

    /* forward name="success" path="" */
    private static final String SUCCESS = "success";
    private static final String DISPLAYLIST = "displaylist";
    private static Logger LOG = Logger.getLogger(InviteFriends.class);
    ContactImporter ci = new ContactImporter();

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
            HttpServletRequest request, HttpServletResponse response) {

        UserBean ub = (UserBean) request.getSession().getAttribute("userBean");
        if (ub != null) {
            String name = request.getParameter("name");
            String act = request.getParameter("actfrom");
            if (act.equalsIgnoreCase("displayList")) {
                String e = request.getParameter("mailId");
                String dname = request.getParameter("dname");
                String pwd = request.getParameter("pwd");


                String email = e + "@" + dname;
                List li = new ArrayList();
                if (li != null) {
                    try {
                        li = ci.getContactList(email, pwd);
                    } catch (Exception exception) {
                        request.setAttribute("errorInFetch", "Unable to fecth records");
                        LOG.error("Error in fecth ids::" + exception);

                    }
                    request.setAttribute("mailList", li);
                    LOG.debug("= Number of contacts we get for mail id::" + email + " <====>" + li.size());
                }

                return mapping.findForward(DISPLAYLIST);
            } else if (act.equalsIgnoreCase("sendMessage")) {
                String sendMail[] = request.getParameterValues("sendMail");
                int i = 0;
                List ll = new ArrayList();
                if (sendMail != null) {
                    int k = 0;// this variable for to count number of invitations send
                    for (i = 0; i < sendMail.length; i++) {
                        String nem = sendMail[i];
                        if (nem != null && nem.length() > 0 && !nem.contains("$^$")) {
                            String fname = ",";
                            String mailId = nem;
                            NameEmail ne = new NameEmail(fname, mailId);
                            ll.add(ne);
                            k++;
                        } else if (nem != null && nem.contains("$^$")) {
                            String fname = nem.substring(0, nem.indexOf("$^$")) + ",";
                            String mailId = nem.substring(nem.indexOf("$^$") + 3, nem.length());
                            NameEmail ne = new NameEmail(fname, mailId);
                            ll.add(ne);
                            k++;

                        }
                    }
                    int id = ub.getUserId();
                    Mutil mu = new Mutil();
                    String rcode = id + mu.getRandomCode(10);
                    LOG.debug("= Invite friends registration code::::: =" + rcode);
                    String city = (String) request.getSession().getAttribute("city");
                    if (city == null || city.length() <= 0) {
                        city = "All India";
                    }
                    ci.sendInviteMailsByEmails(ll, ub.getFirstName(), rcode, city);
                    request.getSession().setAttribute("ok", "Invite " + k + " friends successfully");
                }
                return mapping.findForward(SUCCESS);
            } else {
                return mapping.findForward(SUCCESS);
            }
        } else {
            return mapping.findForward("notLogin");
        }

        /* ContactImporter ci=new ContactImporter();

        ci.sendMailToContacts(email, pwd, name);
        request.setAttribute("ok", "Invite Friends Successfully");
         */

    }

    public class NameEmail {

        String name;
        String email;

        private NameEmail(String name, String mailId) {
            this.name = name;
            this.email = mailId;
        }

        public String getEmail() {
            return email;
        }

        public void setEmail(String email) {
            this.email = email;
        }

        public String getName() {
            return name;
        }

        public void setName(String name) {
            this.name = name;
        }
    }
}
