/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.buysell.bids;

import com.buysell.beans.UserBean;
import com.buysell.db.DbConnectionPool;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
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
public class GetWLBidsAction extends Action {
    
    /* forward name="success" path="" */
    private static final String SUCCESS = "success";
    private static final String NOTLOGIN = "notLogin";
    private static Logger LOG =Logger.getLogger(GetWLBidsAction.class);
    String qry = "SELECT BID_ID from BID_WATCHLIST_T WHERE USER_ID=?";
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

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        ArrayList lb = new ArrayList();
        ArrayList al = new ArrayList();
        UserBean ub = (UserBean) request.getSession().getAttribute("userBean");
        if(ub!=null) {
        try {
            con  = DbConnectionPool.getConnection();
            ps = con.prepareStatement(qry);
            ps.setInt(1, ub.getUserId());
            rs=ps.executeQuery();
            if(rs!=null) {
                while (rs.next()) {
                   if(BidListsAction.bidmap.containsKey(rs.getLong(1))){
                        lb.add(BidListsAction.bidmap.get(rs.getLong(1)));
                   }
                   al.add(rs.getLong(1));
                }
            }
        } catch (Exception e) {
            LOG.error("Error Occurred "+e);
        } finally{
            if(rs!=null){
                try {
                    rs.close();
                } catch (Exception e) {
                    LOG.error("Exception Occurred while closing resultset "+e);
                }
            }
            if(ps!=null){
                try {
                    ps.close();
                } catch (Exception e) {
                    LOG.error("Exception Occurred while closing prepared statement "+e);
                }
            }
            if(con!=null){
                DbConnectionPool.closeConnection(con);
            }
        }
        request.setAttribute("currentBids", lb);
        request.setAttribute("bidsWatchList", al);
        request.setAttribute("closedBids", BidAnnouncer.bidAnn.elements());

        return mapping.findForward(SUCCESS);
        }
        return mapping.findForward(NOTLOGIN);
        
    }
}
