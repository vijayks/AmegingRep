/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.buysell.actionclass;

import com.buysell.beans.UserBean;
import com.buysell.db.DbConnection;
import com.buysell.db.DbConnectionPool;
import com.buysell.util.CategoryUtil;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.ActionForward;

/**
 *
 * @author bbsadmin
 */
public class RedemptionPageAction extends org.apache.struts.action.Action {

    /* forward name="success" path="" */
    private final static String SUCCESS = "success";
    private static Logger LOG = Logger.getLogger(RedemptionPageAction.class);
    Connection con;
    PreparedStatement ps;
    ResultSet rs = null;

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
        LOG.info("RedemptionPageAction execute() started");
        request.setAttribute("categoryList", CategoryUtil.getCategories());

        UserBean ub = (UserBean) request.getSession().getAttribute("userBean");
        if (ub != null) {
            int earned = 0, redemned = 0;
            String qry1 = "SELECT SUM(REFERAL_POINTS) FROM USER_REFERAL_POINTS_T WHERE USER_ID=?";
            String qry2 = "SELECT SUM(POINTS_REDEMN) FROM REDEMPTION_T WHERE USER_ID=?";
            try {
                con = DbConnectionPool.getConnection();
                ps = con.prepareStatement(qry1);
                ps.setInt(1, ub.getUserId());
                rs = ps.executeQuery();
                if (rs != null && rs.next()) {
                    earned = rs.getInt(1);
                    request.setAttribute("earned", earned);
                }
                ps = con.prepareStatement(qry2);
                ps.setInt(1, ub.getUserId());
                rs = ps.executeQuery();

                if (rs != null && rs.next()) {
                    redemned = rs.getInt(1);
                    request.setAttribute("redemned", redemned);
                    request.setAttribute("current", earned - redemned);
                }
            } catch (Exception e) {
                LOG.info("Error In Db Operations:" + e);
            } finally {
                try {
                    if (rs != null) {
                            rs.close();
                        }
                        if (ps != null) {
                            ps.close();
                        }
                        if (con != null) {
                            DbConnectionPool.closeConnection(con);
                        }

                } catch (Exception e) {
                    LOG.error("= Exception Occured in closing db connections ::=" + e);
                }
            }
            request.setAttribute("m", "ma");
            return mapping.findForward(SUCCESS);
        } else {
            return mapping.findForward("notLogin");
        }
    }
}
