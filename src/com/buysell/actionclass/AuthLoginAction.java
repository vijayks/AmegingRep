/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.buysell.actionclass;

import com.buysell.beans.DealerBean;
import com.buysell.beans.UserBean;
import com.buysell.db.DbConnection;
import com.buysell.db.DbConnectionPool;
import com.buysell.util.CategoryUtil;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
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
public class AuthLoginAction extends Action {

    /* forward name="success" path="" */
    private static final String SUCCESS = "success";
    private static final String FAILURE = "failure";
    private static final String MOBILE = "mobile";
    private static Logger LOG = Logger.getLogger(AuthLoginAction.class);
    UserAction ua = new UserAction();
    DbConnection dbc = new DbConnection();

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

        request.setAttribute("categoryList", CategoryUtil.getCategories());
        UserBean ub = null;
        DealerBean dlb = null;
        String userId = request.getParameter("ui");
        String authId = request.getParameter("ai");


        if (authId != null && userId != null) {
            ub = createUserBean(authId, userId);
            if (ub != null) {
                request.getSession().setAttribute("userBean", ub);
                if (ub.getLoginType().equals("LOGIN WITH MOBILE NUMBER")) {
                    LOG.debug("= login with mobile =");
                    // this value for to identify the mobile number based login so we dont permit him to postad,sms to advt,send mail to friend.
                    request.getSession().setAttribute("ML", ub.getPwd());
                    if (ub.getUserType().startsWith("DEALER")) {
                        dlb = ua.createDealerBean(ub.getUserId(), ub);
                        if (dlb != null) {
                            request.getSession().setAttribute("userBean", dlb);
                        }
                    }
                    dbc.executeQuery("UPDATE MAIL_HISTORY_T SET AUTH_ID=CONCAT('Ex',AUTH_ID) WHERE AUTH_ID='"+authId+"' AND USER_ID="+userId);
                    return mapping.findForward(MOBILE);
                } else if (ub.getLoginType().equals("NORMAL LOGIN")) {
                    if (ub.getUserType().startsWith("DEALER")) {
                        dlb = ua.createDealerBean(ub.getUserId(), ub);
                        if (dlb != null) {
                            request.getSession().setAttribute("userBean", dlb);
                        }
                    }
                    dbc.executeQuery("UPDATE MAIL_HISTORY_T SET AUTH_ID=CONCAT('Ex',AUTH_ID) WHERE AUTH_ID='"+authId+"' AND USER_ID="+userId);
                    return mapping.findForward(SUCCESS);
                } else {
                    request.setAttribute("res", "Invalid user name or password");
                }
            } else {
                request.setAttribute("res", "Link expired, Please login with your credentials");
            }
        }
        return mapping.findForward(FAILURE);
    }

    public UserBean createUserBean(String authId, String id) {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        UserBean ub = null;
        UserBean ubok = null;
        String qry = "SELECT USER_T.USER_ID, LOGIN_NAME, LOGIN_PASSWORD, LAST_LOGIN_DATE, TYPE, FIRST_NAME, LAST_NAME, PHONE, MOBILE_CODE, STATUS, EMAIL_CODE FROM USER_LOGIN_T,USER_T,MAIL_HISTORY_T  WHERE  USER_T.USER_ID=USER_LOGIN_T.USER_ID AND USER_T.USER_ID=? AND MAIL_HISTORY_T.AUTH_ID=?";
        try {
            con = DbConnectionPool.getConnection();
            ps = con.prepareStatement(qry);
            ps.setString(1, id);
            ps.setString(2, authId);
            rs = ps.executeQuery();
            if (rs != null && rs.next()) {
                ub = new UserBean();

                ub.setUserId(rs.getInt(1));
                ub.setLoginName(rs.getString(2));
                ub.setPwd(rs.getString(3));
                ub.setLastVisited(new java.text.SimpleDateFormat("dd/MM/yyyy hh:mm aa zz").format(rs.getTimestamp(4)));
                ub.setSavedCount(1);
                ub.setUserType(rs.getString(5));
                ub.setFirstName(rs.getString(6));
                ub.setLastName(rs.getString(7));
                ub.setMobile(rs.getString(8));
                ub.setMvStatus(rs.getString(9));
                ub.setUserStatus(rs.getInt(10));
                ub.setEvStatus(rs.getString(11));
                // request.getSession().setAttribute("userBean", ub);
                LOG.info("UserBean created\n");
                //return mapping.findForward(s);

                if (ub.getUserStatus() == 1) {
                    ub.setLoginType("NORMAL LOGIN");
                    ubok = ub;
                } else if (ub.getUserStatus() == 2) {
                    ub.setLoginType("LOGIN WITH MOBILE NUMBER");
                    ubok = ub;
                } else {
                    ub.setLoginType("MISSING");
                    ubok = null;
                    LOG.debug("= here log printed to identified any missing cases in login options =");
                }
            }
        } catch (SQLException ex) {
            LOG.info("Error in DataBase operations\n " + ex);
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (Exception e) {
                    LOG.error("= Exception Occured in closing Resultset ::=" + e);
                }
            }
            if (ps != null) {
                try {
                    ps.close();
                } catch (Exception e) {
                    LOG.error("= Exception Occured in closing Prepared Statement ::=" + e);
                }
            }
            if (con != null) {
                DbConnectionPool.closeConnection(con);
            }
        }
        return ubok;
    }
}
