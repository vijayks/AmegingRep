/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.buysell.actionclass;

import com.buysell.beans.UserBean;
import com.buysell.db.DbConnection;
import com.buysell.db.DbConnectionPool;
import com.buysell.util.BuySellProperties;
import com.buysell.util.CategoryUtil;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Calendar;
import java.util.Date;
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
public class RedemptionAction extends org.apache.struts.action.Action {

    /* forward name="success" path="" */
    private final static String SUCCESS = "success";
    private static Logger LOG = Logger.getLogger(RedemptionAction.class);
    CategoryUtil cu = new CategoryUtil();
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
    public ActionForward execute(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        LOG.info("RedemptionAction execute() strarted");
        request.setAttribute("categoryList", CategoryUtil.getCategories());
        UserBean ub = (UserBean) request.getSession().getAttribute("userBean");
        if (ub != null) {
            String itemSelected = request.getParameter("itemSelected");
            String qty1 = request.getParameter("qty");
            int itemValue = Integer.parseInt(request.getParameter("itemValue"));
            String name = request.getParameter("name");
            String country = request.getParameter("country");
            String state = request.getParameter("state");
            String city = request.getParameter("city");
            String locaity = request.getParameter("locality");
            String addr = request.getParameter("addr");
            String mobile = request.getParameter("mobile");

            int qty = 0;

            try {
                qty = Integer.parseInt(qty1);
            } catch (Exception e) {
            }
            LOG.info("itemSelected =" + itemSelected);
            LOG.info("qty =" + qty1);
            LOG.info("itemValue =" + itemValue);
            LOG.info("name =" + name);
            LOG.info("country =" + country);
            LOG.info("state =" + state);
            LOG.info("city =" + city);
            LOG.info("addr =" + addr);
            LOG.info("mobile =" + mobile);

            if (itemValue != 0 && qty != 0 && ub != null) {
                int uPoints = 0;
                try {
                    String qry1 = " select USER_POINTS FROM USER_T WHERE USER_ID=?";
                    con = DbConnectionPool.getConnection();
                    ps = con.prepareStatement(qry1);
                    ps.setInt(1, ub.getUserId());
                    rs = ps.executeQuery();
                    if (rs != null && rs.next()) {
                        uPoints = rs.getInt(1);
                    }
                    if (uPoints < qty * itemValue) {
                        request.getSession().setAttribute("ok", " Sorry you have insufficient Points, Pls select less no. of Items !");
                    } else {
                        db.callRedemptionPoints(ub.getUserId(), itemSelected, qty, itemValue, "requested", name + "|" + country + "|" + state + "|" + city + "|" + locaity + "|" + addr + "|" + mobile, request);
                        db.executeQuery("UPDATE USER_T SET  USER_POINTS = USER_POINTS - " + qty * itemValue + " WHERE USER_ID=" + ub.getUserId());

                    }
                } catch (Exception e) {
                    LOG.info("error: " + e);
                    request.getSession().setAttribute("ok", " Sorry you are unable to redemn this product, pls try again !");
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
                        LOG.debug("Error occured in RedemptionAction in Closing connection" + e);
                    }
                }
            } else {
                request.getSession().setAttribute("ok", " Sorry you are unable to redemn this product, pls try again !");
            }

            request.setAttribute("m", "ma");
            return mapping.findForward(SUCCESS);
        } else {
            return mapping.findForward("notLogin");
        }

    }
}
