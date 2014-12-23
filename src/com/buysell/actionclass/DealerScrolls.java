/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.buysell.actionclass;

import com.buysell.beans.ScrAdsBean;
import com.buysell.db.DbConnectionPool;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.log4j.Logger;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

/**
 *
 * @author bbsadmin
 */
public class DealerScrolls extends org.apache.struts.action.Action {

    /* forward name="success" path="" */
    private static final String SUCCESS = "success";
    private static final Logger LOG = Logger.getLogger(DealerScrolls.class);
    Connection con;

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

            PreparedStatement ps=null;
            ResultSet rs=null;


        LOG.debug("===============DealerScrolls EXECUTE() started =========");

        LOG.debug("dealerId::" + request.getParameter("dId"));

        String dealerId = request.getParameter("dId");
        try {
            String qry = "select A.THUMB_IMG,A.SCR_TITLE,A.S_ID,B.DOMAIN_NAME from SCROLL_ADS_T A,DEALER_INFO_T B where OFFER_TYPE='special' AND STATUS=1 AND A.DEALER_ID=? AND B.DEALER_ID=?";

            con = DbConnectionPool.getConnection();
            ps = con.prepareStatement(qry);
            ps.setString(1,dealerId);
            ps.setString(2,dealerId);
            rs = ps.executeQuery();
            ArrayList al=new ArrayList();
            if(rs != null && rs.next()){
                do {
                    ScrAdsBean sab = new ScrAdsBean();
                    sab.setThumbImg(rs.getString(1));
                    sab.setScrTitle(rs.getString(2));
                    sab.setSid(rs.getInt(3));
                    sab.setCompanyName(rs.getString(4));
                    al.add(sab);
                   } while(rs != null && rs.next());
                 request.setAttribute("scrollAds",al);
            }
        } catch (Exception e) {
            LOG.error("error :" + e);
        } finally {
            
               if (rs != null) {
                    try {
                        rs.close();
                    } catch (SQLException e) {
                        LOG.error("= Exception Occured in ResultSet of DealerScrolls execute () ::=" + e);
                    }
                }
                 if (ps != null) {
                    try {
                        ps.close();
                    } catch (SQLException e) {
                        LOG.error("= Exception Occured in PreparedStatement of DealerScrolls execute () ::=" + e);
                    }
                }
                if (con != null) {
                    DbConnectionPool.closeConnection(con);
                }
           
        }
        return mapping.findForward(SUCCESS);
    }
}
