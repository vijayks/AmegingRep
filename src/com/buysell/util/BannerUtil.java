/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.buysell.util;

import com.buysell.beans.ScrAdsBean;
import com.buysell.db.DbConnectionPool;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import org.apache.log4j.Logger;

/**
 *
 * @author bbsadmin
 */
public class BannerUtil {

    private static Logger LOG = Logger.getLogger(BannerUtil.class);
    CategoryUtil cu = new CategoryUtil();

    public ArrayList getBanners(int catid, String city, int location) {
        long st = System.currentTimeMillis();
        ArrayList al = new ArrayList();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            String qry = "SELECT A.THUMB_IMG,A.IMG1,A.DEALER_ID,A.CATEGORY_ID,A.OFFER_CITY,A.URL,A.STATUS,A.BANNER_POSITION,B.DOMAIN_NAME,A.SCR_TITLE  FROM SCROLL_ADS_T A  LEFT JOIN DEALER_INFO_T B ON A.DEALER_ID=  B.DEALER_ID WHERE A.STATUS=1 AND A.OFFER_TYPE='BANNER' AND A.OFFER_CITY=? ";
            if (catid > 0) {
                if (cu.getRootCatId(catid) != 0) {
                    catid = cu.getRootCatId(catid);
                    if (cu.getRootCatId(catid) != 0) {
                        catid = cu.getRootCatId(catid);
                    }
                }
            }
            qry += " AND CATEGORY_ID = " + catid;
            if (location > 0) {
                qry += " AND BANNER_POSITION = " + location;
            }
            con = DbConnectionPool.getConnection();
            ps = con.prepareStatement(qry);
            ps.setString(1, city);
            rs = ps.executeQuery();
            if (rs != null) {
                while (rs.next()) {
                    ScrAdsBean sab = new ScrAdsBean();
                    sab.setImg1(rs.getString(1));
                    sab.setImg2(rs.getString(2));
                    sab.setDealerId(rs.getInt(3));
                    sab.setCategoryId(rs.getInt(4));
                    sab.setCity(rs.getString(5));
                    sab.setUrl(rs.getString(6));
                    sab.setStatus(rs.getInt(7));
                    sab.setSid(rs.getInt(8));
                    String na = rs.getString(9);
                    if (na!=null){
                    na.replaceAll(" ", "-") ;
                    na.replaceAll("/", "-") ;
                    }
                    else {na =na;}
                        sab.setDlrName(na);
                    sab.setScrTitle(rs.getString(10));
                    al.add(sab);
                }

            }
        } catch (Exception e) {
            LOG.error("== Error occured == " + e);
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (Exception e) {
                    LOG.error("= Exception Occured in closing ResultSet ::= " + e);
                }
            }
            if (ps != null) {
                try {
                    ps.close();
                } catch (Exception e) {
                    LOG.error("= Exception Occured in closing PreparedStatement ::= " + e);
                }
            }
            if (con != null) {
                DbConnectionPool.closeConnection(con);
            }
            long et = System.currentTimeMillis();
            LOG.debug("= Time taken to complete db operation  of banners :: = " + (et - st) + " Milli Seconds");
        }
        LOG.debug("BannersList size is " + al.size());
        return al;
    }

    public ArrayList getVideoBanners(int catid, String city, int location) {
        long st = System.currentTimeMillis();
        ArrayList al2 = new ArrayList();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            String qry = "SELECT A.DEALER_ID,A.CATEGORY_ID,A.OFFER_CITY,A.URL,A.STATUS,A.BANNER_POSITION,B.DOMAIN_NAME FROM SCROLL_ADS_T A  LEFT JOIN DEALER_INFO_T B ON A.STATUS=1 AND A.DEALER_ID=B.DEALER_ID WHERE  A.OFFER_TYPE='VIDEO'AND A.OFFER_CITY=? ";
            if (catid > 0) {
                if (cu.getRootCatId(catid) != 0) {
                    catid = cu.getRootCatId(catid);
                    if (cu.getRootCatId(catid) != 0) {
                        catid = cu.getRootCatId(catid);
                    }
                }
            }
            qry += " AND CATEGORY_ID = " + catid;
            if (location > 0) {
                qry += " AND BANNER_POSITION = " + location;
            }
            con = DbConnectionPool.getConnection();
            ps = con.prepareStatement(qry);
            ps.setString(1, city);
            rs = ps.executeQuery();
            if (rs != null) {
                while (rs.next()) {
                    ScrAdsBean sab = new ScrAdsBean();
                    sab.setDealerId(rs.getInt(1));
                    sab.setCategoryId(rs.getInt(2));
                    sab.setCity(rs.getString(3));
                    sab.setUrl(rs.getString(4));
                    sab.setStatus(rs.getInt(5));
                    sab.setSid(rs.getInt(6));
                    String na = rs.getString(7);
                    na = na != null ? na.replaceAll(" ", "-") : na;
                    sab.setDlrName(na);
                    al2.add(sab);
                }
            }
        } catch (Exception e) {
            LOG.error("== Error occured == " + e);
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (Exception e) {
                    LOG.error("= Exception Occured in closing ResultSet ::= " + e);
                }
            }
            if (ps != null) {
                try {
                    ps.close();
                } catch (Exception e) {
                    LOG.error("= Exception Occured in closing PreparedStatement ::= " + e);
                }
            }
            if (con != null) {
                DbConnectionPool.closeConnection(con);
            }
            long et = System.currentTimeMillis();
            LOG.debug("= Time taken to complete db operation  of  Video banners :: = " + (et - st) + " Milli Seconds");
        }
        LOG.debug(" Video BannersList size is " + al2.size());
        return al2;
    }
}
