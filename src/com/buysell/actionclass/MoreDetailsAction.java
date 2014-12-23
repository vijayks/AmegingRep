/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.buysell.actionclass;

import com.buysell.beans.AdsBean;
import com.buysell.db.DbConnection;
import com.buysell.db.DbConnectionPool;
import com.buysell.servlets.AdsService;
import com.buysell.util.CategoryUtil;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
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
public class MoreDetailsAction extends org.apache.struts.action.Action {

    /* forward name="success" path="" */
    private static String SUCCESS = "success";
    private final static Logger LOG = Logger.getLogger(MoreDetailsAction.class);
    AdsService as = new AdsService();

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
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        LOG.info("MoreDetailsAction execute() started");
        request.setAttribute("categoryList", CategoryUtil.getCategories());
        LOG.debug("catId=" + request.getParameter("catId"));
        LOG.debug("adId=" + request.getParameter("adId"));
        int adId = Integer.parseInt(request.getParameter("adId"));
        int catId = 0;
        if(request.getParameter("catId") !=null && request.getParameter("catId").trim().length()>0)
            catId = Integer.parseInt(request.getParameter("catId"));
        else
            catId = Integer.parseInt(request.getParameter("amp;catId"));//This is for escaping '&amp;' in url
        String name = null;
        try {
            String qry = "SELECT VIEW_FIELDS FROM CATEGORY_TEMPLATE_T WHERE CATEGORY_ID=?";
            con = DbConnectionPool.getConnection();
            ps = con.prepareStatement(qry);
            ps.setInt(1, catId);
            rs = ps.executeQuery();
            if (rs != null && rs.next()) {
                name = rs.getString(1);
                request.setAttribute("catName", name);
            }
        } catch (Exception e) {
            LOG.error("Error in Db oprations :" + e);
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException e) {
                    LOG.error("= Exception Occured in ResultSet of MoreDetailsAction execute () ::=" + e);
                }
            }
            if (ps != null) {
                try {
                    ps.close();
                } catch (SQLException e) {
                    LOG.error("= Exception Occured in PreparedStatement of MoreDetailsAction execute () ::=" + e);
                }
            }
            if (con != null) {
                DbConnectionPool.closeConnection(con);
            }


        }
        AdsBean ab = as.getMoreDetails(adId);
        request.setAttribute("moreDetails", ab);
        return mapping.findForward(SUCCESS);
    }
}
