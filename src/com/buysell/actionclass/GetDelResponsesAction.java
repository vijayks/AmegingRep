/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.buysell.actionclass;

import com.buysell.beans.ResponseBean;
import com.buysell.beans.UserBean;
import com.buysell.db.DbConnection;
import com.buysell.db.DbConnectionPool;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.log4j.Logger;

/**
 *
 * @author bbsadmin
 */
public class GetDelResponsesAction extends org.apache.struts.action.Action {

    /* forward name="success" path="" */
    private static final String SUCCESS = "success";
    private static final Logger LOG = Logger.getLogger(GetDelResponsesAction.class);

    /**
     * This is the action called from the Struts framework.
     *
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
        LOG.info("GetDelResponsesAction execute() started");
        UserBean ub = (UserBean) request.getSession().getAttribute("userBean");

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        StringBuffer sb = new StringBuffer();

        sb.append("SELECT A.ID,A.RESPONSE_TYPE,A.RELATED_ID,A.USER_ID,A.USER_NAME,A.EMAIL,A.CONTACT,A.CITY,A.RESPONSE_DATE,A.STATUS FROM RESPONSE_T A WHERE A.STATUS=2 AND A.RELATED_USER_ID =" + ub.getUserId());
        LOG.info("Getting Deleted Responce Details of User ID :" + ub.getUserId());

        ArrayList rl = new ArrayList();
        try {
            con = DbConnectionPool.getConnection();
            ps = con.prepareStatement(sb.toString());
            rs = ps.executeQuery();
            if (rs != null) {
                while (rs.next()) {
                    ResponseBean rb = new ResponseBean();
                    rb.setRespId(rs.getInt(1));
                    rb.setResponseType(rs.getString(2));
                    rb.setRelatedId(rs.getInt(3));
                    rb.setUserId(rs.getInt(4));
                    rb.setUserName(rs.getString(5));
                    rb.setEmail(rs.getString(6));
                    rb.setContact(rs.getString(7));
                    rb.setCity(rs.getString(8));
                    rb.setResponseDate(new java.text.SimpleDateFormat("dd/MM/yyyy").format(rs.getTimestamp(9)));
                    rb.setStatus(rs.getInt(10));
                    if ((rs.getString(2)).equalsIgnoreCase("AD")) {
                        String qry2 = "SELECT A.RELATED_ID,B.TITLE,B.CATEGORY_ID FROM RESPONSE_T A,AD_T B WHERE A.RELATED_ID=B.AD_ID AND A.RESPONSE_TYPE='AD' AND A.STATUS=1 AND A.RELATED_USER_ID =?";
                        ps = con.prepareStatement(qry2);
                        ResultSet rs1 = null;
                        ps.setInt(1, ub.getUserId());
                        rs1 = ps.executeQuery();
                        rs1.next();
                        rb.setAdTitle(rs1.getString(2));
                        rb.setAdCatId(rs1.getInt(3));
                    } else if ((rs.getString(2)).equalsIgnoreCase("VRFD")) {
                        String qry3 = "SELECT A.RELATED_ID,B.DESCRIPTION,B.CATEGORY_ID FROM RESPONSE_T A,REQUESTED_LEADS_T B WHERE A.RELATED_ID=B.L_ID AND A.RESPONSE_TYPE='VRFD' AND A.STATUS=1 AND A.RELATED_USER_ID =?";
//                            PreparedStatement ps = null;
                        ps = con.prepareStatement(qry3);
                        ResultSet rs2 = null;
                        ps.setInt(1, ub.getUserId());
                        rs2 = ps.executeQuery();
                        rs2.next();
                        rb.setAdTitle(rs2.getString(2));
                        rb.setAdCatId(rs2.getInt(3));
                    }
                    //rb.setAdTitle(rs.getString(11));
                    //rb.setAdCatId(rs.getInt(12));
                    rl.add(rb);
                }
            }
            request.setAttribute("delResps", rl);
        } catch (Exception e) {
            LOG.error("= Exception Occured in  ::=" + e);
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (Exception e) {
                    LOG.error("= Exception Occured in closing ResultSet ::=" + e);
                }
            }
            if (ps != null) {
                try {
                    ps.close();
                } catch (Exception e) {
                    LOG.error("= Exception Occured in closing PreparedStatement ::=" + e);
                }
            }
            if (con != null) {
                DbConnectionPool.closeConnection(con);
            }
        }

        return mapping.findForward(SUCCESS);
    }
}
