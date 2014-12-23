/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.buysell.webshop.actionclasses;

import com.buysell.beans.DealerMoreInfo;
import com.buysell.db.DbConnectionPool;
import com.buysell.webshop.beans.Product;
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
public class GetWCTProducts extends Action {

    /* forward name="success" path="" */
    private static final String SUCCESS = "success";
    private static final String FAILURE = "failure";

    private static Logger LOG = Logger.getLogger(GetWCTProducts.class);
    Connection con = null;

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
        LOG.debug("===== EXECUTE()======");
        String du = (String) request.getSession().getAttribute("dw");
        if(du!=null){
        DealerMoreInfo dmi=(DealerMoreInfo) WebsiteAction.hmp.get(du);
        if(dmi!=null){
        long dId=dmi.getdId();
        PreparedStatement ps = null;
        ResultSet rs = null;

        String query = null;
        try {
            query = " SELECT B.PRODUCT_ID,B.STATUS,B.LAST_MODIFICATION_DATE,B.DEALER_ID,B.TITLE," +
                    " B.DESCRIPTION,B.IMAGE_LOCATION,B.SHORT_DESCRIPTION,B.MODEL_ID,B.ACTUAL_PRICE," +
                    " B.DISCOUNT,B.OFFER_PRICE,B.CURRENCY,B.SHORT_SPECIFICATIONS,B.LONG_SPECIFICATIONS,B.ACCESSORIES,B.OFFER_TILL,B.STOCK_STATUS," +
                    " A.ID,A.TYPE,B.NAME FROM DEALER_WCT_T A,PRODUCT_T B where B.PRODUCT_ID=A.PRODUCT_ID AND B.STATUS <>2 AND A.DEALER_ID='"+dId+"'";

            con = DbConnectionPool.getConnection();
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();

            if (rs != null) {
                ArrayList al = new ArrayList();
                while (rs.next()) {
                    Product p = new Product();
                    p.setProdId(rs.getLong(1));
                    p.setStatus(rs.getInt(2));
                    p.setLastModDate(rs.getString(3));
                    p.setDealerId(rs.getLong(4));
                    p.setTitle(rs.getString(5));
                    p.setDescription(rs.getString(6));
                    p.setImageLocation(rs.getString(7));
                    p.setShortDesc(rs.getString(8));
                    p.setModelId(rs.getString(9));
                    p.setActualPrice(rs.getLong(10));
                    p.setDiscount(rs.getLong(11));
                    p.setOfferPrice(rs.getLong(12));
                    p.setCurrency(rs.getString(13));
                    p.setShortDesc(rs.getString(14));
                    p.setLongSpecifics(rs.getString(15));
                    p.setAccessories(rs.getString(16));
                    p.setOfferTill(rs.getString(17));
                    p.setStockStatus(rs.getString(18));
                    p.setId(rs.getLong(19));
                    p.setType(rs.getInt(20));
                    p.setName(rs.getString(21));
                    al.add(p);
                }
                request.setAttribute("prodList", al);
            }
        } catch (Exception e) {
            LOG.error("= Exception while executing Query ::=" + e);
        } finally {
            if (ps != null) {
                try {
                    ps.close();
                } catch (Exception e) {
                    LOG.error("= Exception Occured while closing Prepared Statement ::=" + e);
                }
            }

            if (rs != null) {
                try {
                    rs.close();
                } catch (Exception e) {
                    LOG.error("= Exception Occured while closing ResultSet  ::=" + e);
                }
            }

            if (con != null) {
                DbConnectionPool.closeConnection(con);
            }
        }
        request.setAttribute("dealerWebsite", dmi);
        return mapping.findForward(SUCCESS);
        }else{
            LOG.error(" Session Expired!!");
        return mapping.findForward(FAILURE);
        }
        }else {
           return mapping.findForward(FAILURE);
    }
    }
}
