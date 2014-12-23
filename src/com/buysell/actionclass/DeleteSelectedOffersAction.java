/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.buysell.actionclass;

import com.buysell.beans.UserBean;
import com.buysell.db.DbConnection;
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
public class DeleteSelectedOffersAction extends org.apache.struts.action.Action {
    
    /* forward name="success" path="" */
    private static final String SUCCESS = "success";
    private static Logger LOG = Logger.getLogger(DeleteSelectedOffersAction.class);
    private final static String NOTLOGIN = "notLogin";
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
        
        LOG.info("DeleteSelectedOffersAction execute() is started");
        String active[] = request.getParameterValues("Active");
        String hold[] = request.getParameterValues("On Hold");
        String expired[] = request.getParameterValues("Expired");
        String reposted[] = request.getParameterValues("Reposted");
        String incomplete[] = request.getParameterValues("Incomplete");
        UserBean ub = (UserBean) request.getSession().getAttribute("userBean");

        DbConnection db = new DbConnection();
        if (ub != null) {
            int i = 0;
            if (active != null) {
                for (i = 0; i < active.length; i++) {
                    if (!active[i].trim().equals("on")) {
                        db.executeQuery("UPDATE SCROLL_ADS_T SET STATUS=5 WHERE S_ID=" + active[i]);
//                        db.executeQuery("UPDATE USER_T SET BALANCE_ADS=BALANCE_ADS+1 WHERE USER_ID=" + ub.getUserId() + "");
                    }
                }

            }


            if (hold != null) {
                for (i = 0; i < hold.length; i++) {
                    if (!hold[i].trim().equals("on")) {
                        db.executeQuery("UPDATE SCROLL_ADS_T SET STATUS=5 WHERE S_ID=" + hold[i]);
//                        db.executeQuery("UPDATE USER_T SET BALANCE_ADS=BALANCE_ADS+1 WHERE USER_ID=" + ub.getUserId() + "");
                    }
                }

            }


            if (expired != null) {
                for (i = 0; i < expired.length; i++) {
                    if (!expired[i].trim().equals("on")) {
                        db.executeQuery("UPDATE SCROLL_ADS_T SET STATUS=5 WHERE S_ID=" + expired[i]);
                    }
                }

            }


            if (reposted != null) {
                for (i = 0; i < reposted.length; i++) {
                    if (!reposted[i].trim().equals("on")) {
                        db.executeQuery("UPDATE SCROLL_ADS_T SET STATUS=5 WHERE S_ID=" + reposted[i]);
                    }
                }

            }


            if (incomplete != null) {

                for (i = 0; i < incomplete.length; i++) {
                    if (!incomplete[i].trim().equals("on")) {
                        db.executeQuery("UPDATE SCROLL_ADS_T SET STATUS=5 WHERE S_ID=" + incomplete[i]);
                    }
                }

            }
            request.setAttribute("m", "ma");
            request.setAttribute("msgSuc", "Deleted Successfully");
            return mapping.findForward(SUCCESS);
        } else {
            return mapping.findForward(NOTLOGIN);
        }
    }
}
