/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.buysell.actionclass;

import com.buysell.beans.ChangePWDFormBean;
import com.buysell.beans.UserBean;
import com.buysell.db.DbConnection;
import com.buysell.util.CategoryUtil;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionError;
import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.ActionForward;

/**
 *
 * @author bbsadmin
 */
public class ChangePWDAction extends org.apache.struts.action.Action {

    /* forward name="success" path="" */
    private final static String SUCCESS = "success";
    private final static String FAILURE = "failure";
    private static Logger LOG = Logger.getLogger(ChangePWDAction.class);
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
    public ActionForward execute(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        LOG.info("ChangerPWDAction execute() method started");
        CategoryUtil cu = new CategoryUtil();
        request.setAttribute("categoryList", cu.getCategories());
        String from = request.getParameter("pwdfrom");
        UserBean ub = (UserBean) request.getSession().getAttribute("userBean");
        if (ub != null) {

            int UserId = ub.getUserId();
            String pwd = ub.getPwd();

            String newPWD = request.getParameter("newPWD");
            String oldPWD = request.getParameter("oldPWD");

            if (from != null && from.equals("2pwd") && newPWD != null) {
                db.executeQuery("UPDATE USER_LOGIN_T SET LOGIN_PASSWORD='" + newPWD + "',MODIFICATION_DATE=NOW() WHERE USER_ID=" + UserId);
                ub.setPwd(newPWD);

                request.getSession().setAttribute("ok", "You successfully changed your password!");
            } else if (oldPWD != null && newPWD != null && oldPWD.endsWith(pwd) && !from.equals("2pwd")) {
                db.executeQuery("update USER_LOGIN_T set LOGIN_PASSWORD='" + newPWD + "', MODIFICATION_DATE=NOW() where USER_ID=" + UserId);
                ub.setPwd(newPWD);
                request.getSession().setAttribute("ok", "You successfully changed your password!");

            } else {
                request.setAttribute("ok", "Old password is incorrect !");
                return mapping.findForward(FAILURE);
            }
            return mapping.findForward(SUCCESS);
        } else {

            return mapping.findForward("notLogin");
        }

    }
}
