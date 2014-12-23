/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.buysell.actionclass;

import com.buysell.beans.UserBean;
import com.buysell.db.DbConnection;
import com.buysell.db.DbConnectionPool;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
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
public class MobileVerificationAction extends org.apache.struts.action.Action {

    /* forward name="success" path="" */
    private static final String SUCCESS = "success";
    private static final String FAILURE = "failure";
    private static final Logger LOG = Logger.getLogger(MobileVerificationAction.class);
    Connection con;
    PreparedStatement ps;
    ResultSet rs;
    DbConnection db = new DbConnection();

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

        LOG.debug("= Mobile verification Action class entered =");
        UserBean ub = (UserBean) request.getSession().getAttribute("userBean");


        String cde = request.getParameter("UEMVC");
        String sessionCode = null;
        String fdb = (String) ub.getMvStatus();
        if (fdb != null && fdb.length() > 0) {
            sessionCode = fdb;
        }
        if (cde != null && sessionCode != null && cde.equals(sessionCode)) {
            try {
                if (ub != null) {
                    db.executeQuery("UPDATE USER_T SET MOBILE_CODE='V" + cde + "' WHERE USER_ID=" + ub.getUserId());
                    db.executeQuery("UPDATE USER_LOGIN_T SET STATUS=1 WHERE USER_ID=" + ub.getUserId());
                    ub.setMvStatus("V" + cde);
                    ub.setLoginType("NORMAL LOGIN");
                    ub.setUserStatus(1);
                }
            } catch (Exception e) {
                LOG.debug("= Error ocured in updating mobile verification code =");
            }
            return mapping.findForward(SUCCESS);
        } else {
            request.setAttribute("mcError", "Entered code error");
            return mapping.findForward(FAILURE);
        }



    }
}
