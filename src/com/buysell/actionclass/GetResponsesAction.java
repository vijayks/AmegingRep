/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.buysell.actionclass;

import com.buysell.servlets.AdsService;
import com.buysell.beans.UserBean;
import com.buysell.beans.AdsBean;
import com.buysell.beans.ResponseBean;
import com.buysell.beans.DealerLeads;
import com.buysell.db.DbConnectionPool;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import com.buysell.servlets.DealerService; //Karteek
import com.buysell.db.DbConnection;

/**
 *
 * @author Sujith
 */
public class GetResponsesAction extends Action {

    private static final String SUCCESS = "success";
    private static final String MSG = "msg";
    private static final Logger LOG = Logger.getLogger(GetResponsesAction.class);

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

        LOG.info("GetResponsesAction execute() started");
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        DbConnection db = new DbConnection();

        UserBean ub = (UserBean) request.getSession().getAttribute("userBean");

        String type = "ad";
        String Vtype = "VRFD";

        StringBuffer sb = new StringBuffer();
        String delRespId = request.getParameter("respId");
        LOG.debug("Deleted Responce ID : " + delRespId);
        if (delRespId != null && delRespId.trim().length() > 0) {
            db.executeQuery("UPDATE RESPONSE_T SET STATUS=2 WHERE ID=" + delRespId + " ");
            LOG.debug(" Sucessfully Responce Deleted ");
        }

        sb.append("SELECT A.ID,A.RESPONSE_TYPE,A.RELATED_ID,A.USER_ID,A.USER_NAME,A.EMAIL,A.CONTACT,A.CITY,A.RESPONSE_DATE,A.STATUS FROM RESPONSE_T A WHERE A.STATUS=1 AND A.RELATED_USER_ID =" + ub.getUserId());


//        if (type.equalsIgnoreCase("ad")) {
//            sb.append("SELECT A.ID,A.RESPONSE_TYPE,A.RELATED_ID,A.USER_ID,A.USER_NAME,A.EMAIL,A.CONTACT,A.CITY,A.RESPONSE_DATE,A.STATUS,B.TITLE,B.CATEGORY_ID FROM RESPONSE_T A,AD_T B WHERE A.RELATED_ID=B.AD_ID AND A.RESPONSE_TYPE='AD' AND A.STATUS=1 AND A.RELATED_USER_ID =" + ub.getUserId());
//        } else if (type.equalsIgnoreCase("ms")) {
//            sb.append("SELECT A.ID,A.RESPONSE_TYPE,A.RELATED_ID,A.USER_ID,A.USER_NAME,A.EMAIL,A.CONTACT,A.CITY,A.RESPONSE_DATE,A.STATUS FROM RESPONSE_T A WHERE A.RESPONSE_TYPE='MICROSITE' AND A.RELATED_USER_ID =" + ub.getUserId());
//        }
        String month = request.getParameter("month");
        if (month != null) {
            LOG.debug("Month search request");

            String srchMnthFrom = "";
            String srchMnthTo = "";
            LOG.info("Slected Month =" + month);
            if (month != null && month.trim().length() > 0) {
                request.setAttribute("month", month);
                srchMnthFrom = "2013-" + request.getParameter("month") + "-1";
                srchMnthTo = "2013-" + request.getParameter("month") + "-31";
                LOG.info("Selected Result Date From =" + srchMnthFrom);
                LOG.info("Slected Result Date To =" + srchMnthTo);

                if (srchMnthFrom != null && srchMnthTo != null && srchMnthFrom.trim().length() > 0 && srchMnthTo.trim().length() > 0) {
                    sb.append("  AND A.RESPONSE_DATE BETWEEN '" + srchMnthFrom + "'  AND '" + srchMnthTo + "'");
                }
            }
        }

        String SrchBy = request.getParameter("SrchBy");
        if (SrchBy == null || SrchBy.equalsIgnoreCase("lst")) {
            LOG.debug(" Latest Sortby search request");
            request.setAttribute("SrchBy", SrchBy);
            sb.append(" ORDER BY A.RESPONSE_DATE DESC");
        } else if (SrchBy != null && SrchBy.equalsIgnoreCase("old")) {
            LOG.debug(" Older Sortby search request");
            request.setAttribute("SrchBy", SrchBy);
            sb.append(" ORDER BY A.RESPONSE_DATE ASC");
        }

        ArrayList rl = new ArrayList();

        {
            try {
                con = DbConnectionPool.getConnection();
                ps = con.prepareStatement(sb.toString());
                rs = ps.executeQuery();
                if (rs != null) {
                    while (rs.next()) {
                        ResponseBean rb = new ResponseBean();
                        rb.setRespId(rs.getLong(1));
                        rb.setResponseType(rs.getString(2));
                        rb.setRelatedId(rs.getInt(3));
                        rb.setUserId(rs.getInt(4));
                        rb.setUserName(rs.getString(5));
                        rb.setEmail(rs.getString(6));
                        rb.setContact(rs.getString(7));
                        rb.setCity(rs.getString(8));
                        rb.setResponseDate(new java.text.SimpleDateFormat("dd/MM/yyyy").format(rs.getTimestamp(9)));
                        rb.setStatus(rs.getInt(10));
                        ResultSet rs1 = null;
                        if ((rs.getString(2)).equalsIgnoreCase("AD")) {
                            String qry2 = "SELECT A.RELATED_ID,B.TITLE,B.CATEGORY_ID FROM RESPONSE_T A,AD_T B WHERE A.RELATED_ID=B.AD_ID AND A.RESPONSE_TYPE='AD' AND A.STATUS=1 AND A.RELATED_USER_ID =?";
                            ps = con.prepareStatement(qry2);
                            ps.setInt(1, ub.getUserId());
                            rs1 = ps.executeQuery();
                            rs1.next();
                            rb.setAdTitle(rs1.getString(2));
                            rb.setAdCatId(rs1.getInt(3));
                            rl.add(rb);
                        } else if ((rs.getString(2)).equalsIgnoreCase("VRFD")) {
                            String qry3 = "SELECT A.RELATED_ID,B.DESCRIPTION,B.CATEGORY_ID FROM RESPONSE_T A,REQUESTED_LEADS_T B WHERE A.RELATED_ID=B.L_ID AND A.RESPONSE_TYPE='VRFD' AND A.STATUS=1 AND A.RELATED_USER_ID =?";
                            ps = con.prepareStatement(qry3);
                            ps.setInt(1, ub.getUserId());
                            rs1 = ps.executeQuery();
                            rs1.next();
                            rb.setAdTitle(rs1.getString(2));
                            rb.setAdCatId(rs1.getInt(3));
                            rl.add(rb);
                        }
//                        if (type.equalsIgnoreCase("ad")) {
//                            rb.setAdTitle(rs.getString(11));
//                            rb.setAdCatId(rs.getInt(12));
//                        }
                        rl.add(rb);
                    }
                }
                request.setAttribute("resps", rl);
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
//            sb.append("SELECT A.LEAD_ID,A.TYPE,B.CATEGORY_ID,B.USER_ID,B.USER_NAME,B.USER_EMAIL,B.USER_CONTACT,A.CITY,A.DELIVERY_DATE,A.STATUS,A.COMMENTS,B.CATEGORY_ID FROM DEALER_LEADS_T A,REQUESTED_LEADS_T B WHERE A.L_ID=B.L_ID AND A.TYPE='VRFD' AND B.USER_ID =" + ub.getUserId());
//
//            try {
//                con = DbConnectionPool.getConnection();
//                ps = con.prepareStatement(sb.toString());
//                rs = ps.executeQuery();
//                if (rs != null) {
//                    while (rs.next()) {
//                        DealerLeads dl = new DealerLeads();
//                        dl.setId(rs.getLong(1));
//                        dl.setType(rs.getString(2));
//                        dl.setDeliveryDate(new java.text.SimpleDateFormat("dd/MM/yyyy").format(rs.getTimestamp(9)));
//                        dl.setCatID(rs.getInt(3));
//                        dl.setUserId(rs.getString(4));
//                        dl.setStatus(rs.getString(10));
//                        if (Vtype.equalsIgnoreCase("VRFD")) {
//                            dl.setComments(rs.getString(11));
//                            dl.setCatID(rs.getInt(12));
//                        }
//
//
//                        rs.getString(5);
//                        rs.getString(6);
//                        rs.getString(7);
//                        dl.setCity(rs.getString(8));
//
//                        dl.setStatus(rs.getString(10));
//                        if (Vtype.equalsIgnoreCase("VRFD")) {
//                            dl.setComments(rs.getString(11));
//                            dl.setCatID(rs.getInt(12));
//                        }
//                        rl.add(dl);
//                    }
//                }
//                request.setAttribute("resps", rl);
//            }
//            catch (Exception e) {
//                LOG.error("= Exception Occured in  ::=" + e);
//            } finally {
//                if (rs != null) {
//                    try {
//                        rs.close();
//                    } catch (Exception e) {
//                        LOG.error("= Exception Occured in closing ResultSet ::=" + e);
//                    }
//                }
//                if (ps != null) {
//                    try {
//                        ps.close();
//                    } catch (Exception e) {
//                        LOG.error("= Exception Occured in closing PreparedStatement ::=" + e);
//                    }
//                }
//                if (con != null) {
//                    DbConnectionPool.closeConnection(con);
//                }
//            }
            AdsService as = new AdsService();
            HashMap hm = as.getUserAdsCountDeatils(ub.getUserId());
            if (hm
                    != null) {
                request.setAttribute("totalResponses", hm.get("All"));
                LOG.info("Total Ads Responses Count is " + hm.get("All"));
            }
//        Karteek Starts
            DealerService ds = new DealerService();
            int MsCount = 0;
            MsCount = ds.getDealerMicrositeCountDeatils(ds.getDealerId(ub.getUserId()));

            request.setAttribute("totalMicrositeCount", MsCount);
            LOG.info(
                    "Total Microsite Responses Count is " + MsCount);
            //        Karteek Ends
            return mapping.findForward(SUCCESS);
        }
    }
}
