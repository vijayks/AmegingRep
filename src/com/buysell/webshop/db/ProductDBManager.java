/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.buysell.webshop.db;

import com.buysell.webshop.beans.Product;
import com.buysell.db.DbConnectionPool;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Types;
import java.util.ArrayList;
import org.apache.log4j.Logger;

/**
 *
 * @author bbsadmin
 */
public class ProductDBManager {

    private static final Logger LOG = Logger.getLogger(ProductDBManager.class);
    Connection con;
    String dealerProdQry = "SELECT PRODUCT_ID,STATUS,TITLE,DESCRIPTION,IMAGE_LOCATION,SHORT_DESCRIPTION,MODEL_ID,ACTUAL_PRICE,DISCOUNT,OFFER_PRICE,CURRENCY,SHORT_SPECIFICATIONS,LONG_SPECIFICATIONS,ACCESSORIES,NAME,OFFER_TILL,STOCK_STATUS FROM PRODUCT_T WHERE DEALER_ID=?";
    String prodIdQry = "SELECT DEALER_ID,STATUS,TITLE,DESCRIPTION,IMAGE_LOCATION,SHORT_DESCRIPTION,MODEL_ID,ACTUAL_PRICE,DISCOUNT,OFFER_PRICE,CURRENCY,SHORT_SPECIFICATIONS,LONG_SPECIFICATIONS,ACCESSORIES,NAME,OFFER_TILL,STOCK_STATUS,PRODUCT_ID FROM PRODUCT_T WHERE PRODUCT_ID=?";

    public int createProduct(Product prd) {
        con = DbConnectionPool.getConnection();
        int prdId = 0;
        try {
            CallableStatement pos = con.prepareCall("{call CreateProduct(?,?,?,?,?,?,?,?,?,?," +
                    "?,?,?,?,?,?,?)}");
            pos.setString(1, prd.getName());
            pos.setString(2, prd.getShortDesc());
            pos.setString(3, prd.getDescription());
            pos.setString(4, prd.getModelId());
            pos.setString(5, prd.getShortSpecifics());
            pos.setFloat(6, prd.getActualPrice());
            pos.setFloat(7, prd.getDiscount());
            pos.setFloat(8, prd.getOfferPrice());
            pos.setString(9, prd.getCurrency());
            pos.setString(10, prd.getOfferTill());
            pos.setString(11, prd.getStockStatus());
            pos.setString(12, prd.getImageLocation());
            pos.setString(13, prd.getLongSpecifics());
            pos.setString(14, prd.getAccessories());
            pos.setLong(15, prd.getDealerId());
            pos.setString(16, prd.getTitle());
            pos.registerOutParameter(17, Types.INTEGER);
            pos.execute();
            prdId = pos.getInt(17);
            LOG.info("CreateProduct Stored Routine returned product Id " + prdId + "created by Dealer" + prd.getDealerId());
        } catch (Exception e) {
            e.printStackTrace();
            LOG.error("Error while calling CreateProduct" + e);
        } finally {
            if (con != null) {
                try {
                    DbConnectionPool.closeConnection(con);
                } catch (Exception e) {
                    LOG.error("Error while closing DbConnection in createProduct method " + e);
                }
            }
        }
        return prdId;
    }

    public ArrayList getProductsByDealerId(long dlrId) {
        ArrayList prl = new ArrayList();
        con = DbConnectionPool.getConnection();
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            ps = con.prepareStatement(dealerProdQry);
            ps.setLong(1, dlrId);
            rs = ps.executeQuery();
            if (rs != null) {
                while (rs.next()) {
                    Product prd = new Product();
                    prd.setProdId(rs.getLong(1));
                    prd.setStatus(rs.getInt(2));
                    prd.setTitle(rs.getString(3));
                    prd.setDescription(rs.getString(4));
                    prd.setImageLocation(rs.getString(5));
                    prd.setShortDesc(rs.getString(6));
                    prd.setModelId(rs.getString(7));
                    prd.setActualPrice(rs.getFloat(8));
                    prd.setDiscount(rs.getFloat(9));
                    prd.setOfferPrice(rs.getFloat(10));
                    prd.setCurrency(rs.getString(11));
                    prd.setShortSpecifics(rs.getString(12));
                    prd.setLongSpecifics(rs.getString(13));
                    prd.setAccessories(rs.getString(14));
                    prd.setName(rs.getString(15));
                    prd.setOfferTill(rs.getString(16));
                    prd.setStockStatus(rs.getString(17));
                    prl.add(prd);
                }
            }
        } catch (Exception e) {
            LOG.error("Exception occured in getting products by dealerId" + e);
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (Exception e) {
                    LOG.error("Exception occured in closing resultSet while getProductsByDealerId" + e);
                }
            }
            if (ps != null) {
                try {
                    ps.close();
                } catch (Exception e) {
                    LOG.error("Exception occured in closing PreparedStatement while getProductsByDealerId" + e);
                }
            }
            if (con != null) {
                DbConnectionPool.closeConnection(con);
            }
        }
        return prl;
    }

    public Product getProductById(long pId) {

        con = DbConnectionPool.getConnection();
        Product pdt = new Product();
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            ps = con.prepareStatement(prodIdQry);
            ps.setLong(1, pId);
            rs = ps.executeQuery();
            if (rs != null && rs.next()) {
                pdt.setDealerId(rs.getLong(1));
                pdt.setStatus(rs.getInt(2));
                pdt.setTitle(rs.getString(3));
                pdt.setDescription(rs.getString(4));
                pdt.setImageLocation(rs.getString(5));
                pdt.setShortDesc(rs.getString(6));
                pdt.setModelId(rs.getString(7));
                pdt.setActualPrice(rs.getFloat(8));
                pdt.setDiscount(rs.getFloat(9));
                pdt.setOfferPrice(rs.getFloat(10));
                pdt.setCurrency(rs.getString(11));
                pdt.setShortSpecifics(rs.getString(12));
                pdt.setLongSpecifics(rs.getString(13));
                pdt.setAccessories(rs.getString(14));
                pdt.setName(rs.getString(15));
                pdt.setOfferTill(rs.getString(16));
                pdt.setStockStatus(rs.getString(17));
                pdt.setProdId(rs.getLong(18));
            }
        } catch (Exception e) {
            LOG.error("Exception occured in getting products by dealerId" + e);
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (Exception e) {
                    LOG.error("Exception occured in closing resultSet while getProductbyId" + e);
                }
            }
            if (ps != null) {
                try {
                    ps.close();
                } catch (Exception e) {
                    LOG.error("Exception occured in closing PreparedStatement while getProductbyId" + e);
                }
            }
            if (con != null) {
                DbConnectionPool.closeConnection(con);
            }
        }
        return pdt;
    }

    public ArrayList getAssignedProductsByCatId(long catId) {
        PreparedStatement ps = null;
        ResultSet rs = null;
        String query = null;
        ArrayList al=new ArrayList();
        try {
            query = "SELECT A.ID,WEBSHOP_CAT_ID,A.PRODUCT_ID,A.STATUS,B.TITLE,B.DESCRIPTION,B.IMAGE_LOCATION,B.SHORT_DESCRIPTION,B.MODEL_ID,B.ACTUAL_PRICE," +
                    " B.DISCOUNT,B.OFFER_PRICE,B.CURRENCY,B.SHORT_SPECIFICATIONS,B.LONG_SPECIFICATIONS,B.ACCESSORIES,B.OFFER_TILL,B.STOCK_STATUS,B.NAME " +
                    "FROM WEBSHOP_CATEGORY_PRODUCT_T A,PRODUCT_T B WHERE A.PRODUCT_ID=B.PRODUCT_ID AND WEBSHOP_CAT_ID='" + catId + "' AND (A.STATUS=0 or A.STATUS=1)";
            con = DbConnectionPool.getConnection();
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            if (rs != null ) {
                while(rs.next()) {
                    Product p = new Product();
                    p.setId(rs.getLong(1));
                    p.setCatId(rs.getLong(2));
                    p.setProdId(rs.getLong(3));
                    p.setStatus(rs.getInt(4));
                    p.setTitle(rs.getString(5));
                    p.setDescription(rs.getString(6));
                    p.setImageLocation(rs.getString(7));
                    p.setShortDesc(rs.getString(8));
                    p.setModelId(rs.getString(9));
                    p.setActualPrice(rs.getLong(10));
                    p.setDiscount(rs.getLong(11));
                    p.setOfferPrice(rs.getLong(12));
                    p.setCurrency(rs.getString(13));
                    p.setShortSpecifics(rs.getString(14));
                    p.setLongSpecifics(rs.getString(15));
                    p.setAccessories(rs.getString(16));
                    p.setOfferTill(rs.getString(17));
                    p.setStockStatus(rs.getString(18));
                    p.setName(rs.getString(19));
                    al.add(p);
                }
            }
        } catch (Exception e) {
            LOG.error("Execption occurred while executing query in getAssignedProductsByCatId ::" + e);
        } finally {
            try {
                if (ps != null) {
                    ps.close();
                }
            } catch (Exception e) {
                LOG.error("Error occurred while closing Prepared Statement in getAssignedProductsByCatId ::" + e);
            }
            try {
                if (rs != null) {
                    rs.close();
                }
            } catch (Exception e) {
                LOG.error("Error occurred while closing ResultSet in getAssignedProductsByCatId ::" + e);
            }
        }
        if (con != null) {
            DbConnectionPool.closeConnection(con);
        }
        return al;
    }

    public int updateProduct(Product prd){
        int res=0;
        con=DbConnectionPool.getConnection();
        String updPrdQry = "UPDATE PRODUCT_T SET NAME=?,SHORT_DESCRIPTION=?,DESCRIPTION=?,MODEL_ID=?,SHORT_SPECIFICATIONS=?,ACTUAL_PRICE=?,DISCOUNT=?,OFFER_PRICE=?,OFFER_TILL=?,CURRENCY=?,STOCK_STATUS=?,IMAGE_LOCATION=?,LONG_SPECIFICATIONS=?,ACCESSORIES=?,LAST_MODIFICATION_DATE=NOW(),STATUS=1,TITLE=? WHERE DEALER_ID=? AND PRODUCT_ID=?";
        PreparedStatement ps =null;
        try {
            ps=con.prepareStatement(updPrdQry);
            ps.setString(1, prd.getName());
            ps.setString(2, prd.getShortDesc());
            ps.setString(3, prd.getDescription());
            ps.setString(4, prd.getModelId());
            ps.setString(5, prd.getShortSpecifics());
            ps.setFloat(6, prd.getActualPrice());
            ps.setFloat(7, prd.getDiscount());
            ps.setFloat(8, prd.getOfferPrice());
            ps.setString(9, prd.getOfferTill());
            ps.setString(10, prd.getCurrency());
            ps.setString(11, prd.getStockStatus());
            ps.setString(12, prd.getImageLocation());
            ps.setString(13, prd.getLongSpecifics());
            ps.setString(14, prd.getAccessories());
            ps.setString(15, prd.getTitle());
            ps.setLong(16, prd.getDealerId());
            ps.setLong(17, prd.getProdId());
            res=ps.executeUpdate();
        } catch (Exception e) {
            LOG.error("Exception occurred in updateProduct method "+e);
        }finally{
            if(ps!=null){
                try {
                    ps.close();
                } catch (Exception e) {
                    LOG.error("Exception occurred while closing Prepared Statement in updateProduct "+e);
                }
            }
            if(con!=null) DbConnectionPool.closeConnection(con);
        }
        return res;
    }

    public int deleteProduct(long prId, long dlrId){
        int res=0;
        con=DbConnectionPool.getConnection();
        PreparedStatement ps=null;
        String delPrdQry="DELETE FROM PRODUCT_T WHERE PRODUCT_ID=? AND DEALER_ID=?";
        try {
            ps=con.prepareStatement(delPrdQry);
            ps.setLong(1, prId);
            ps.setLong(2, dlrId);
            res=ps.executeUpdate();
        } catch (Exception e) {
            LOG.error("Exception occurred in deleteProduct method "+e);
        }finally{
            if(ps!=null){
                try {
                    ps.close();
                } catch (Exception e) {
                    LOG.error("Exception occurred while closing Prepared Statement in deleteProduct "+e);
                }
            }
            if(con!=null) DbConnectionPool.closeConnection(con);
        }
        return res;
    }

    public String assignProductCategory(long catId, String prodList, int prodListSize) {
        String res=null;
        con=DbConnectionPool.getConnection();
        try {
            CallableStatement pos = con.prepareCall("{call AssignProductsCategory(?,?,?,?)}");
            pos.setLong(1, catId);
            pos.setString(2, prodList);
            pos.setInt(3, prodListSize);
            pos.registerOutParameter(4, Types.VARCHAR);
            pos.execute();
            res=pos.getString(4);
            LOG.info("AssignProductCategory stored routine returned result "+res);
        } catch (Exception e) {
            e.printStackTrace();
            LOG.error("Error occured while calling AssignProductCategory "+e);
        } finally {
            if(con!=null) {
                try {
                    DbConnectionPool.closeConnection(con);
                } catch (Exception e) {
                    LOG.error("Error occured while closing DbConnection in assignProductCategory method "+e);
                }
            }
        }
        return res;
    }

    public ArrayList getProductsByWebshopId(long wsId) {
        PreparedStatement ps = null;
        ResultSet rs = null;
        String query = null;
        ArrayList al=new ArrayList();
        try {
            query = "SELECT A.ID,WEBSHOP_CAT_ID,A.PRODUCT_ID,A.STATUS,B.IMAGE_LOCATION,B.SHORT_DESCRIPTION,B.MODEL_ID,B.ACTUAL_PRICE," +
                    " B.DISCOUNT,B.OFFER_PRICE,B.CURRENCY,B.OFFER_TILL,B.STOCK_STATUS,B.NAME FROM WEBSHOP_CATEGORY_PRODUCT_T A,PRODUCT_T B WHERE (A.STATUS=0 or A.STATUS=1) AND A.PRODUCT_ID=B.PRODUCT_ID AND WEBSHOP_CAT_ID IN (SELECT ID FROM WEBSHOP_DETAILS_T WHERE STATUS<>2 AND WEBSHOP_ID =?)";
            con = DbConnectionPool.getConnection();
            ps = con.prepareStatement(query);
            ps.setLong(1, wsId);
            rs = ps.executeQuery();
            if (rs != null ) {
                while(rs.next()) {
                    Product p = new Product();
                    p.setId(rs.getLong(1));
                    p.setCatId(rs.getLong(2));
                    p.setProdId(rs.getLong(3));
                    p.setStatus(rs.getInt(4));
                    p.setImageLocation(rs.getString(5));
                    p.setShortDesc(rs.getString(6));
                    p.setModelId(rs.getString(7));
                    p.setActualPrice(rs.getLong(8));
                    p.setDiscount(rs.getLong(9));
                    p.setOfferPrice(rs.getLong(10));
                    p.setCurrency(rs.getString(11));
                    p.setOfferTill(rs.getString(12));
                    p.setStockStatus(rs.getString(13));
                    p.setName(rs.getString(14));
                    al.add(p);
                }
            }
        } catch (Exception e) {
            LOG.error("Execption occurred while executing query in getProductsByWebshopId ::" + e);
        } finally {
            try {
                if (ps != null) {
                    ps.close();
                }
            } catch (Exception e) {
                LOG.error("Error occurred while closing Prepared Statement in getProductsByWebshopId ::" + e);
            }
            try {
                if (rs != null) {
                    rs.close();
                }
            } catch (Exception e) {
                LOG.error("Error occurred while closing ResultSet in getProductsByWebshopId ::" + e);
            }
        }
        if (con != null) {
            DbConnectionPool.closeConnection(con);
        }
        return al;
    }
}
