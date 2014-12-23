/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.buysell.webshop.actionclasses;

import com.buysell.beans.DealerBean;
import com.buysell.beans.UserBean;
import com.buysell.db.DbConnectionPool;
import com.buysell.webshop.beans.Product;
import com.buysell.webshop.db.ProductDBManager;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.StringTokenizer;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

/**
 *
 * @author Madhuri
 */
public class AssignProducts_WCT_Action extends Action {

    /* forward name="success" path="" */
    private static final String SUCCESS = "success";
    private static final String TOPNLIST = "topNList";
    private static final String SPOFFERS = "spcOffers";
    private static final String WHATSNEW = "whatsNew";
    private static final String NOTLOGIN = "notLogin";
    private static Logger LOG = Logger.getLogger(AssignProducts_WCT_Action.class);
    Connection con;
    ProductDBManager pdbm = new ProductDBManager();

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
        LOG.debug("AssignProducts_WCT_Action execute() started");
        DealerBean db = (DealerBean) request.getSession().getAttribute("userBean");

        if (db != null) {
            long dId = db.getDlId();
            String pmId = request.getParameter("prod");
            LOG.debug("Product Id :: " + pmId);
            String pid = null;
            String mId = null;
            if (pmId != null && pmId.trim().length() > 0) {
                StringTokenizer stz = new StringTokenizer(pmId, "+");
                if (stz != null) {
                    while (stz.hasMoreTokens()) {
                        pid = stz.nextToken();
                        mId = stz.nextToken();
                    }
                }
            }
            String mn = request.getParameter("m");
            LOG.debug("mm::" + mn);
            String query1 = null;
            String prdStat = "notExists";
            String prevStat = (String) request.getAttribute("exist");
            String linkTyp = request.getParameter("lT");
            LOG.debug("Link Type ::" + linkTyp);
            int st = 0;
            if ((linkTyp.equals("new"))) {
                st = 1;
            } else if ((linkTyp.equals("spl"))) {
                st = 2;
            } else if ((linkTyp.equals("tnl"))) {
                st = 3;
            }
            PreparedStatement ps = null;
            ResultSet rs = null;
            // For Retrieving
            String query2 = null;
            try {
                query2 = " SELECT A.ID,B.NAME,B.MODEL_ID,B.SHORT_DESCRIPTION ,A.TYPE,B.PRODUCT_ID FROM DEALER_WCT_T A,PRODUCT_T B where B.PRODUCT_ID=A.PRODUCT_ID AND A.DEALER_ID='"+dId+"' AND A.TYPE='" + st + "'";
                con = DbConnectionPool.getConnection();
                ps = con.prepareStatement(query2);
                rs = ps.executeQuery();
                if (rs != null) {
                    ArrayList al = new ArrayList();
                    while (rs.next()) {
                        Product p = new Product();
                        p.setId(rs.getLong(1));
                        p.setName(rs.getString(2));
                        p.setModelId(rs.getString(3));
                        if (mId != null && mId.trim().length() > 0 && mId.equals(rs.getString(3))) {
                            prdStat = "exists";
                        }
                        p.setShortDesc(rs.getString(4));
                        p.setType(rs.getInt(5));
                        p.setProdId(rs.getLong(6));
                        al.add(p);
                    }
                    request.setAttribute("assignList", al);
                }
            } catch (Exception e) {
                LOG.debug("error Occurred while execiting query2 in AssignProduct_WCT_T::" + e);
            } finally {
                if (rs != null) {
                    try {
                        rs.close();
                    } catch (Exception e) {
                        LOG.error("Error occurred while closing ResultSet of Query2 :: " + e);
                    }
                }
                if (ps != null) {
                    try {
                        ps.close();
                    } catch (Exception e) {
                        LOG.error("Error occurred while closing PreparedStatement of Query2 :: " + e);
                    }
                }
                if (con != null) {
                    DbConnectionPool.closeConnection(con);
                }
            }
            if (pid != null && prdStat.equals("notExists") && request.getParameter("m") != null && request.getParameter("m").equals("in")) {
                query1 = "INSERT INTO DEALER_WCT_T (DEALER_ID,PRODUCT_ID,STATUS,CREATION_DATE,TYPE) VALUES(?,?,'1',NOW(),?)";
                con = DbConnectionPool.getConnection();
                try {
                    ps = con.prepareStatement(query1);
                    ps.setLong(1, dId);
                    ps.setString(2, pid);
                    ps.setInt(3, st);
                    ps.executeUpdate();
                    LOG.debug("Product Assigned Successfully!");
                } catch (Exception e) {
                    LOG.debug("Error occurred while Execution of Query::" + e);
                } finally {
                    if (ps != null) {
                        try {
                            ps.close();
                        } catch (Exception e) {
                            LOG.debug("Error while Closing Prepared Statement of Query1 in AssignProductsWCT_Action::" + e);
                        }
                    }
                    if (con != null) {
                        DbConnectionPool.closeConnection(con);
                    }
                }
            }
            if ((mn != null && mn.equals("in") && prdStat.equals("exists")) || (mn != null && mn.equals("s") && prevStat != null)) {
                request.setAttribute("exist", "Already Exists");
            }
            if (db != null && db.getDlId() != 0) {
                ArrayList al = new ArrayList();
                al = pdbm.getProductsByDealerId(db.getDlId());
                request.setAttribute("productsList", al);
            }
            if (st == 1) {
                return mapping.findForward(WHATSNEW);
            } else if (st == 2) {
                return mapping.findForward(SPOFFERS);
            } else if (st == 3) {
                return mapping.findForward(TOPNLIST);
            }
            return mapping.findForward(SUCCESS);
        }
        return mapping.findForward(NOTLOGIN);
    }
}



