/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.buysell.actionclass;

import com.buysell.beans.UserBean;
import com.buysell.db.DbConnection;
import com.buysell.util.CategoryUtil;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.ActionForward;

/**
 *
 * @author root
 */
public class UserLogoutAction extends org.apache.struts.action.Action {

    /* forward name="success" path="" */
    private final static String SUCCESS = "signout";
    private static Logger LOG = Logger.getLogger(UserLogoutAction.class);
    List ll = new ArrayList();

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

        LOG.info("UserLogoutAction execute() is started");
        CategoryUtil cu = new CategoryUtil();
        request.setAttribute("categoryList", cu.getCategories());
        LOG.info("1");
        DbConnection db = new DbConnection();
        LOG.info("2");
        UserBean ub = (UserBean) request.getSession().getAttribute("userBean");
        LOG.info("3");

        if (ub != null) {
            LOG.info("4");
            db.executeQuery("UPDATE USER_LOGIN_T SET LAST_LOGIN_DATE=NOW() WHERE USER_ID=" + ub.getUserId() + "");
            LOG.info("Last visited is saved into Database table \n");
            String city = (String) request.getSession().getAttribute("city");
            ll = (ArrayList) request.getSession().getAttribute("cities");

            request.getSession().invalidate();

            request.getSession(true).setAttribute("city", city);
            request.getSession(true).setAttribute("cities", ll);

            request.setAttribute("logout", "Successfully logged out,thanks for visiting our website");
            LOG.debug("= city =" + request.getSession().getAttribute("city"));
        }
        LOG.info("User 'Login' session is destroyed \n");
        request.setAttribute("m", "h");
        return mapping.findForward(SUCCESS);
    }
}
