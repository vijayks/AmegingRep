/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.buysell.actionclass;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import com.buysell.util.BuySellProperties;

import java.sql.ResultSet;
import org.apache.log4j.Logger;
import com.buysell.db.DbConnectionPool;
import com.buysell.beans.UserBean;
import java.sql.Connection;
import java.sql.PreparedStatement;

/**
 *
 * @author blueignite
 */
public class RedemptionPointsCheck extends org.apache.struts.action.Action {

    /* forward name="success" path="" */
    private static final String SUCCESS = "success";
    private static final String FAILURE = "failure";
    private static Logger LOG = Logger.getLogger(RedemptionPointsCheck.class);
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
    @Override
    public ActionForward execute(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        int currentPoints = 0;
        String cp = null;
        int points = 0;

//        UserBean ub = (UserBean) request.getSession().getAttribute("userBean");
//        if (ub != null) {
//
//            int earned = 0, redemned = 0;
//            String qry1 = "SELECT SUM(REFERAL_POINTS) FROM USER_REFERAL_POINTS_T WHERE USER_ID=?";
//            String qry2 = "SELECT SUM(POINTS_REDEMN) FROM REDEMPTION_T WHERE USER_ID=?";
//            try {
//                con = DbConnectionPool.getConnection();
//                ps = con.prepareStatement(qry1);
//                ps.setInt(1, ub.getUserId());
//                rs = ps.executeQuery();
//                if (rs != null && rs.next()) {
//                    earned = rs.getInt(1);
//                }
//                ps = con.prepareStatement(qry2);
//                ps.setInt(1, ub.getUserId());
//                rs = ps.executeQuery();
//
//                if (rs != null && rs.next()) {
//                    redemned = rs.getInt(1);
//                    currentPoints = earned - redemned;
//                }
//            } catch (Exception e) {
//                LOG.info("Error In Db Operations:" + e);
//            } finally {
//                try {
//                    rs.close();
//                    ps.close();
//                    DbConnectionPool.closeConnection(con);
//
//                } catch (Exception e) {
//                    LOG.error("= Exception Occured in closing db connections ::=" + e);
//                }
//
//            }
//        }
//


        String itemSelected = request.getParameter("rP");
        if (itemSelected != null) {
            points = Integer.parseInt(BuySellProperties.getProperty(itemSelected));

        } else {
            request.setAttribute("redumptionError", itemSelected);
            return mapping.findForward(FAILURE);
        }
        Object lastObj = request.getAttribute("current");
        Integer last = new Integer(lastObj.toString());
        currentPoints = last.intValue(); // the added 1 is just for program logic


        if (currentPoints >= points) {
            request.setAttribute("points", points);
            request.setAttribute("itemSelected", itemSelected);
            request.setAttribute("current", currentPoints);
            return mapping.findForward(SUCCESS);
        } else {

            request.setAttribute("current", currentPoints);
            request.setAttribute("redumptionError", itemSelected);
            return mapping.findForward(FAILURE);

        }

    }
}

         