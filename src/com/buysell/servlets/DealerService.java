/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.buysell.servlets;

import com.buysell.beans.AdsBean;
import com.buysell.beans.DealerBean;
import com.buysell.beans.DealerLeads;
import com.buysell.beans.DealerMoreInfo;
import com.buysell.beans.MyAdDetailsBean;
import com.buysell.beans.ScrAdsBean;
import com.buysell.db.DbConnection;
import com.buysell.db.DbConnectionPool;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.StringTokenizer;
import java.util.logging.Level;
import org.apache.log4j.Logger;

/**
 *
 * @author bbsadmin
 */
public class DealerService {

    
    DbConnection db = new DbConnection();
    private static Logger LOG = Logger.getLogger(DealerService.class);
    String uid = null;

    public DealerService() {
    }

    public int getDealerId(int uid) {
        Connection con = null;
        PreparedStatement ps = null;
        Statement sto = null;
        ResultSet rs = null;
        int dealerId = 0;
        String QRY = "SELECT DEALER_ID FROM DEALER_INFO_T WHERE USER_ID=?";
        try {
            con = DbConnectionPool.getConnection();
            ps = con.prepareStatement(QRY);
            ps.setInt(1, uid);
            rs = ps.executeQuery();
            if (rs != null && rs.next()) {
                dealerId = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException e) {
                    LOG.error("= Exception Occured while  closing ResultSet of getDealerId() in DealerService() ::=" + e);
                }
            }
            if (ps != null) {
                try {
                    ps.close();
                } catch (SQLException e) {
                    LOG.error("= Exception Occured while closing  Prepared statement of getDealerId() in DealerService() ::=" + e);
                }
            }
            if (con != null) {
                DbConnectionPool.closeConnection(con);
            }
            long et = System.currentTimeMillis();
            //  LOG.debug("= Time taken to complete db operation :: =" + (et - st) + " Milli Seconds");
            return dealerId;
        }
    }

    public MyAdDetailsBean setMyOfferDetails(int dealerId) {
        Connection con = null;
        long st = System.currentTimeMillis();
        PreparedStatement ps = null;
        Statement sto = null;
        ResultSet rs = null;
        String qry = "SELECT COUNT(STATUS) FROM SCROLL_ADS_T WHERE OFFER_TYPE='Normal' AND STATUS=? AND DEALER_ID=?";
        String qry2 = "SELECT AT_OFFERS FROM DEALER_INFO_T WHERE DEALER_ID=?";
        MyAdDetailsBean madb = new MyAdDetailsBean();
        try {
            con = DbConnectionPool.getConnection();
            ps = con.prepareStatement(qry);
            ps.setInt(1, 1);
            ps.setInt(2, dealerId);
            LOG.info(ps);
            rs = ps.executeQuery();
            rs.next();
            madb.setActive(rs.getInt(1));
            /*===============================================================*/
            ps.setInt(1, 2);
            ps.setInt(2, dealerId);
            rs = ps.executeQuery();
            LOG.info(ps);
            rs.next();
            madb.setOnHold(rs.getInt(1));
            /*===============================================================*/
            ps.setInt(1, 4);
            ps.setInt(2, dealerId);
            rs = ps.executeQuery();
            rs.next();
            madb.setExpired(rs.getInt(1));
            /*===============================================================*/
            ps.setInt(1, 5);
            ps.setInt(2, dealerId);
            rs = ps.executeQuery();
            rs.next();
            madb.setDeleted(rs.getInt(1));
            /*===============================================================*/
            ps.setInt(1, 6);
            ps.setInt(2, dealerId);
            rs = ps.executeQuery();
            rs.next();
            madb.setIncomplete(rs.getInt(1));
            /*===============================================================*/
            ps = con.prepareStatement(qry2);
            ps.setInt(1, dealerId);
            rs = ps.executeQuery();
            rs.next();
            madb.setBalanceAds((rs.getInt(1) - (madb.getActive() + madb.getOnHold())));
            /*===============================================================*/
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException e) {
                    LOG.error("= Exception Occured while closing  ResultSet of setMyOfferDetails() in DealerService() ::=" + e);
                }
            }
            if (ps != null) {
                try {
                    ps.close();
                } catch (SQLException e) {
                    LOG.error("= Exception Occured while closing  Prepared Statement of setMyOfferDetails() in DealerService() ::=" + e);
                }
            }
            if (con != null) {
                DbConnectionPool.closeConnection(con);
            }
            long et = System.currentTimeMillis();
            LOG.debug("= Time taken to complete db operation :: =" + (et - st) + " Milli Seconds");
        }
        return madb;
    }

    public ArrayList getRequestedOffersList(int dealerId, int status) {
        Connection con = null;
        ArrayList al = new ArrayList();
        PreparedStatement ps = null;
        Statement sto = null;
        ResultSet rs = null;
        try {
            String qry = "SELECT SCR_TITLE,IMG1,IMG2,DEALER_INFO_T.DEALER_ID,S_DATE,E_DATE,DOMAIN_NAME,DLOGO_PATH,ADDRESS_1,CITY,LIST_PRICE,OFFER_PRICE,DESCRIPTION,S_ID,STATUS FROM SCROLL_ADS_T,DEALER_INFO_T,ADDRESS_T WHERE DEALER_INFO_T.DEALER_ID=SCROLL_ADS_T.DEALER_ID AND DEALER_INFO_T.ADD_ID=ADDRESS_T.ADDRESS_ID AND OFFER_TYPE='Normal'AND SCROLL_ADS_T.DEALER_ID=? AND SCROLL_ADS_T.STATUS=?";
            con = DbConnectionPool.getConnection();
            ps = con.prepareStatement(qry);
            ps.setInt(1, dealerId);
            ps.setInt(2, status);
            rs = ps.executeQuery();
            if (rs != null) {
                while (rs.next()) {
                    ScrAdsBean sab = new ScrAdsBean();
                    sab.setScrTitle(rs.getString(1));
                    sab.setImg1(rs.getString(2));
                    sab.setImg2(rs.getString(3));
                    sab.setDealerId(rs.getInt(4));
                    sab.setsDate(rs.getString(5));
                    sab.seteDate(rs.getString(6));
                    sab.setCompanyName(rs.getString(7));
                    sab.setLogo(rs.getString(8));
                    sab.setAddress(rs.getString(9));
                    sab.setCity(rs.getString(10));
                    sab.setLprice(rs.getString(11));
                    sab.setOprice(rs.getString(12));
                    sab.setDesc(rs.getString(13));
                    sab.setSid(rs.getInt(14));
                    sab.setStatus(rs.getInt(15));
                    al.add(sab);
                }

            }
        } catch (Exception e) {
            LOG.info("== Error occured ==" + e);
        } finally {

            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException e) {
                    LOG.error("= Exception Occured while closing  ResultSet of getRequestedOffersList() in DealerService() ::=" + e);
                }
            }
            if (ps != null) {
                try {
                    ps.close();
                } catch (SQLException e) {
                    LOG.error("= Exception Occured while closing  Prepared Statement of getRequestedOffersList() in DealerService() ::=" + e);
                }
            }
            if (con != null) {
                DbConnectionPool.closeConnection(con);
            }


        }

        return al;
    }

    public ArrayList getEditorRenewOffersList(int dealerId) {
        Connection con = null;
        ArrayList al = new ArrayList();
        PreparedStatement ps = null;
        Statement sto = null;
        ResultSet rs = null;
        try {
            String qry = "SELECT SCR_TITLE,IMG1,IMG2,DEALER_INFO_T.DEALER_ID,S_DATE,E_DATE,DOMAIN_NAME,DLOGO_PATH,ADDRESS_1,CITY,LIST_PRICE,OFFER_PRICE,DESCRIPTION,S_ID,STATUS FROM SCROLL_ADS_T,DEALER_INFO_T,ADDRESS_T WHERE DEALER_INFO_T.DEALER_ID=SCROLL_ADS_T.DEALER_ID AND DEALER_INFO_T.ADD_ID=ADDRESS_T.ADDRESS_ID AND OFFER_TYPE='Normal' AND SCROLL_ADS_T.STATUS IN (1,3,4,5,6) AND SCROLL_ADS_T.DEALER_ID=?";
            con = DbConnectionPool.getConnection();
            ps = con.prepareStatement(qry);
            ps.setInt(1, dealerId);
            rs = ps.executeQuery();
            if (rs != null) {
                while (rs.next()) {
                    ScrAdsBean sab = new ScrAdsBean();
                    sab.setScrTitle(rs.getString(1));
                    sab.setImg1(rs.getString(2));
                    sab.setImg2(rs.getString(3));
                    sab.setDealerId(rs.getInt(4));
                    sab.setsDate(rs.getString(5));
                    sab.seteDate(rs.getString(6));
                    sab.setCompanyName(rs.getString(7));
                    sab.setLogo(rs.getString(8));
                    sab.setAddress(rs.getString(9));
                    sab.setCity(rs.getString(10));
                    sab.setLprice(rs.getString(11));
                    sab.setOprice(rs.getString(12));
                    sab.setDesc(rs.getString(13));
                    sab.setSid(rs.getInt(14));
                    sab.setStatus(rs.getInt(15));
                    al.add(sab);
                }
            }
        } catch (Exception e) {
            LOG.info("== Error occured ==" + e);
        } finally {

            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException e) {
                    LOG.error("= Exception Occured while closing  ResultSet of getEditorRenewOffersList() in DealerService() ::=" + e);
                }
            }
            if (ps != null) {
                try {
                    ps.close();
                } catch (SQLException e) {
                    LOG.error("= Exception Occured while closing  Prepared Statement of getEditorRenewOffersList() in DealerService() ::=" + e);
                }
            }
            if (con != null) {
                DbConnectionPool.closeConnection(con);
            }
        }

        return al;
    }

    public ArrayList getDeleteOffersList(int dealerId) {
        Connection con = null;
        ArrayList al = new ArrayList();
        PreparedStatement ps = null;
        Statement sto = null;
        ResultSet rs = null;
        try {
            String qry = "SELECT SCR_TITLE,IMG1,IMG2,DEALER_INFO_T.DEALER_ID,S_DATE,E_DATE,DOMAIN_NAME,DLOGO_PATH,ADDRESS_1,CITY,LIST_PRICE,OFFER_PRICE,DESCRIPTION,S_ID,STATUS FROM SCROLL_ADS_T,DEALER_INFO_T,ADDRESS_T WHERE DEALER_INFO_T.DEALER_ID=SCROLL_ADS_T.DEALER_ID AND DEALER_INFO_T.ADD_ID=ADDRESS_T.ADDRESS_ID AND OFFER_TYPE='Normal' AND SCROLL_ADS_T.STATUS IN (1,2,3,4,6) AND SCROLL_ADS_T.DEALER_ID=?";
            con = DbConnectionPool.getConnection();
            ps = con.prepareStatement(qry);
            ps.setInt(1, dealerId);
            rs = ps.executeQuery();
            if (rs != null) {
                while (rs.next()) {
                    ScrAdsBean sab = new ScrAdsBean();
                    sab.setScrTitle(rs.getString(1));
                    sab.setImg1(rs.getString(2));
                    sab.setImg2(rs.getString(3));
                    sab.setDealerId(rs.getInt(4));
                    sab.setsDate(rs.getString(5));
                    sab.seteDate(rs.getString(6));
                    sab.setCompanyName(rs.getString(7));
                    sab.setLogo(rs.getString(8));
                    sab.setAddress(rs.getString(9));
                    sab.setCity(rs.getString(10));
                    sab.setLprice(rs.getString(11));
                    sab.setOprice(rs.getString(12));
                    sab.setDesc(rs.getString(13));
                    sab.setSid(rs.getInt(14));
                    sab.setStatus(rs.getInt(15));
                    al.add(sab);
                }
            }
        } catch (Exception e) {
            LOG.info("== Error occured ==" + e);
        } finally {

            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException e) {
                    LOG.error("= Exception Occured while closing  ResultSet of getDeleteOffersList() in DealerService() ::=" + e);
                }
            }
            if (ps != null) {
                try {
                    ps.close();
                } catch (SQLException e) {
                    LOG.error("= Exception Occured while closing  Prepared Statement of getDeleteOffersList() in DealerService() ::=" + e);
                }
            }
            if (con != null) {
                DbConnectionPool.closeConnection(con);
            }
        }
        return al;
    }

    public ArrayList getDealersList(String query) {
        Connection con = null;
        ArrayList al = new ArrayList();
        PreparedStatement ps = null;
        Statement sto = null;
        ResultSet rs = null;
        try {
            con = DbConnectionPool.getConnection();
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            if (rs != null) {
                while (rs.next()) {
                    DealerBean dlb = new DealerBean();
                    dlb.setComp_name(rs.getString(1));
                    dlb.setLogoPath(rs.getString(2));
                    dlb.setDescription(rs.getString(3));
                    dlb.setCity(rs.getString(4));
                    dlb.setLocality(rs.getString(5));
                    dlb.setDlId(rs.getInt(6));
                    dlb.setMobile(rs.getString(7));
                    dlb.setPhone1(rs.getString(8));
                    dlb.setDlrType(rs.getString(9));
                    dlb.setUserStatus(rs.getInt(10));
                    al.add(dlb);
                }
            }
        } catch (Exception e) {
            LOG.error("= Exception Occured in  ::=" + e);
        } finally {

            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException e) {
                    LOG.error("= Exception Occured while closing  ResultSet of getDealersList() in DealerService() ::=" + e);
                }
            }
            if (ps != null) {
                try {
                    ps.close();
                } catch (SQLException e) {
                    LOG.error("= Exception Occured while closing  Prepared Statement of getDealersList() in DealerService() ::=" + e);
                }
            }
            if (con != null) {
                DbConnectionPool.closeConnection(con);
            }

        }
        return al;
    }

    public String getUserId(String dealerId) {
        Connection con = null;
        PreparedStatement ps = null;
        Statement sto = null;
        ResultSet rs = null;
        try {
            String qry1 = "SELECT USER_ID FROM DEALER_INFO_T WHERE DEALER_ID=?";
            con = DbConnectionPool.getConnection();
            ps = con.prepareStatement(qry1);
            ps.setString(1, dealerId);
            rs = ps.executeQuery();
            if (rs != null && rs.next()) {
                do {
                    LOG.debug("userid ::" + rs.getString(1));
                    uid = rs.getString(1);
                } while (rs != null && rs.next());
            }
        } catch (Exception e) {
            LOG.error("= Exception Occured in  ::=" + e);
        } finally {

            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException e) {
                    LOG.error("= Exception Occured while closing  ResultSet of getUserId() in DealerService() ::=" + e);
                }
            }
            if (ps != null) {
                try {
                    ps.close();
                } catch (SQLException e) {
                    LOG.error("= Exception Occured while closing  Prepared Statement of getUserId() in DealerService() ::=" + e);
                }
            }
            if (con != null) {
                DbConnectionPool.closeConnection(con);
            }
        }
        return uid;
    }//end of method

    public ArrayList getDealerAllAds(String userid) {
        Connection con = null;
//        al = new ArrayList();
        PreparedStatement ps = null;
        Statement sto = null;
        ResultSet rs = null;
        ArrayList al = new ArrayList();
        try {
//            String qry2 = "SELECT TITLE,DESCRIPTION,IMAGE1,AD_ID,CREATION_DATE,POSTED_BY FROM AD_T WHERE USER_ID=?";
            String qry2 = " SELECT AD_T.TITLE,AD_T.DESCRIPTION,AD_T.POSTED_BY,AD_T.IMAGE1 ,AD_T.CREATION_DATE,AD_T.AD_ID,ADDRESS_T.CITY,ADDRESS_T.LOCALITY,AD_T.CATEGORY_ID,AD_FIELDS.MAX,AD_FIELDS.MINI,AD_FIELDS.PRICE,AD_FIELDS.NEGOTIABLE,AD_FIELDS.CONTACT_PRICE,AD_FIELDS.RENT_MONTH,AD_T.TAGS,USER_T.PHONE FROM  USER_T,DEALER_INFO_T,AD_T,ADDRESS_T,AD_FIELDS where USER_T.USER_ID=DEALER_INFO_T.USER_ID AND ADDRESS_T.ADDRESS_ID=DEALER_INFO_T.ADD_ID AND DEALER_INFO_T.USER_ID=AD_T.USER_ID AND AD_FIELDS.AD_ID=AD_T.AD_ID AND AD_T.USER_ID=? AND AD_T.STATUS=1";
            con = DbConnectionPool.getConnection();
            ps = con.prepareStatement(qry2);
            ps.setString(1, userid);
            LOG.debug(ps);
            rs = ps.executeQuery();
            if (rs != null && rs.next()) {
                al = new ArrayList();
                do {
                    AdsBean adb = new AdsBean();
                    // ArrayList al=new ArrayList();
                    adb.setTitle(rs.getString(1));
                    adb.setDescription(rs.getString(2));
                    adb.setImage1(rs.getString(4));
                    adb.setAdId(rs.getInt(6));
                    adb.setPostedDate(new java.text.SimpleDateFormat("dd/MM/yyyy").format(rs.getTimestamp(5)));
                    adb.setFirstName(rs.getString(3));
                    adb.setCity(rs.getString(7));
                    adb.setLocality(rs.getString(8));
                    adb.setCatId(rs.getInt(9));
                    adb.setMax(rs.getInt(10));
                    adb.setMin(rs.getInt(11));
                    adb.setNeg(rs.getString(13));
                    adb.setPrice(rs.getInt(12));
                    adb.setCfp(rs.getString(14));
                    adb.setRentMonth(rs.getInt(15));
                    if (rs.getString(16) != null) {
                        StringTokenizer str1 = new StringTokenizer(rs.getString(16), "|");
                        if (str1.countTokens() >= 5) {
                            try {
                                str1.nextElement();
                                adb.setCatName((String) str1.nextElement());
                                adb.setParentCatName((String) str1.nextElement());
                                adb.setSuperParentName((String) str1.nextElement());
                                str1.nextElement();
                            } catch (Exception e) {
                                LOG.error("Error :" + e);
                            }
                        }
                    }
                    adb.setMobile(rs.getString(17));
                    al.add(adb);
                } while (rs != null && rs.next());
            }
        } catch (Exception e) {
            LOG.error("= Exception Occured in  ::=" + e);
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException e) {
                    LOG.error("= Exception Occured while closing  ResultSet of getDealerAllAds() in DealerService() ::=" + e);
                }
            }
            if (ps != null) {
                try {
                    ps.close();
                } catch (SQLException e) {
                    LOG.error("= Exception Occured while closing  Prepared Statement of getDealerAllAds() in DealerService() ::=" + e);
                }
            }
            if (con != null) {
                DbConnectionPool.closeConnection(con);
            }
        }
        return al;
    }

    public DealerMoreInfo getDealerMoreInfo(long id) {
        Connection con = null;
        DealerMoreInfo dmi = new DealerMoreInfo();
        PreparedStatement ps = null;
        Statement sto = null;
        ResultSet rs = null;
        String qry = "SELECT DEALER_INFO_T.DEALER_ID,DOMAIN_NAME,DLOGO_PATH,CITY,DEALER_COMP_T.DESCRIPTION,PRODUCTS,IMAGES,BUSINESS_DETAILS,ADDRESS_1,LANDMARK,PHONE,PHONE1,DEALER_COMP_T.EMAIL_ID,WS_URL,DTYPE_ID,LOCALITY,GMAP,WEBSITE,PATH,DISPLAY_NAME FROM DEALER_INFO_T,USER_T,ADDRESS_T,DEALER_COMP_T,DEALER_CATEGORY_T WHERE DEALER_COMP_T.DEALER_ID=DEALER_INFO_T.DEALER_ID AND ADDRESS_T.ADDRESS_ID=DEALER_INFO_T.ADD_ID AND DEALER_INFO_T.USER_ID=USER_T.USER_ID AND DEALER_COMP_T.DEALER_ID=DEALER_CATEGORY_T.DEALER_ID AND DEALER_INFO_T.DEALER_ID=?";
        try {
            con = DbConnectionPool.getConnection();
            ps = con.prepareCall(qry);
            ps.setLong(1, id);
            rs = ps.executeQuery();
            if (rs != null && rs.next()) {
                dmi.setdId(rs.getInt(1));
                dmi.setCompName(rs.getString(2));
                dmi.setLogo(rs.getString(3));
                dmi.setCity(rs.getString(4));
                dmi.setAddInfo(rs.getString(5));
                dmi.setProducts(rs.getString(6));
                dmi.setProductImages(rs.getString(7));
                dmi.setBusinessDetails(rs.getString(8));
                dmi.setAddress(rs.getString(9));
                dmi.setLandMark(rs.getString(10));
                dmi.setMobile(rs.getString(11));
                dmi.setPhone(rs.getString(12));
                dmi.setEmailId(rs.getString(13));
                dmi.setWebUrl(rs.getString(14));
                dmi.setDtypeId(rs.getInt(15));
                dmi.setLocality(rs.getString(16));
                dmi.setGoogleMap(rs.getString(17));
                dmi.setWebsite(rs.getString(18));
                dmi.setPath(rs.getString(19));
                dmi.setDisplayName(rs.getString(20));
            }
        } catch (Exception e) {
            LOG.error("= Exception Occured in  ::=" + e);
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException e) {
                    LOG.error("= Exception Occured while closing  ResultSet of getDealerMoreInfo() in DealerService() ::=" + e);
                }
            }
            if (ps != null) {
                try {
                    ps.close();
                } catch (SQLException e) {
                    LOG.error("= Exception Occured while closing  Prepared Statement of getDealerMoreInfo() in DealerService() ::=" + e);
                }
            }
            if (con != null) {

                DbConnectionPool.closeConnection(con);
            }
        }
        return dmi;
    }
    /*DEALER_LEADS_T
    +---------------+--------------+------+-----+---------+----------------+
    | Field         | Type         | Null | Key | Default | Extra          |
    +---------------+--------------+------+-----+---------+----------------+
    | LEAD_ID       | int(11)      | NO   | PRI | NULL    | auto_increment |
    | TYPE          | varchar(20)  | YES  |     | NULL    |                |
    | DELIVERY_DATE | datetime     | YES  |     | NULL    |                |
    | CATEGORY_ID   | int(11)      | YES  |     | NULL    |                |
    | LEAD_USER_ID  | int(11)      | YES  |     | NULL    |                |
    | SOURCE        | varchar(10)  | YES  |     | NULL    |                |
    | STATUS        | int(11)      | YES  |     | NULL    |                |
    | COMMENTS      | varchar(250) | YES  |     | NULL    |                |
    | DEALER_ID     | int(11)      | NO   |     |         |                |
    | USER_CONTACT  | varchar(50)  | YES  |     | NULL    |                |
    | LAST_MOD_DATE | datetime     | YES  |     | NULL    |                |
    | CITY          | varchar(50)  | YES  |     | NULL    |                |
    +---------------+--------------+------+-----+---------+----------------+

     */

    public List getDealerLeadsByDelearId(long dlId) {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        List ll = new ArrayList();
        String qry = "SELECT DEALER_ID,LEAD_ID,DELIVERY_DATE,CATEGORY_ID,LEAD_USER_ID,USER_CONTACT,LAST_MOD_DATE,CITY,SOURCE,STATUS,COMMENTS FROM DEALER_LEADS_T WHERE DEALER_ID=?";
        try {
            long st = System.currentTimeMillis();
            con = DbConnectionPool.getConnection();
            ps = con.prepareCall(qry);
            ps.setLong(1, dlId);
            rs = ps.executeQuery();
            long et = System.currentTimeMillis();
            while (rs != null && rs.next()) {
//                  DealerLeads(long id, String type, Date deliveryDate, int catID, String userId, String source, String status, String comments, long delearId, String uContact, Date lMDate, String city)
                DealerLeads dl = new DealerLeads(rs.getLong(2), "SMS", rs.getString(3), rs.getInt(4), rs.getString(5), rs.getString(9), rs.getString(10), rs.getString(11), rs.getLong(1), rs.getString(6), rs.getDate(7), rs.getString(8));
                ll.add(dl);
            }
            LOG.info(" Loading " + ll.size() + " leads for dealer " + dlId + ". Total time taken to load is " + (et - st) + " ms");
        } catch (Exception e) {
            LOG.error(" exception while getting the leads for the dealer " + dlId + "\n" + e);
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException ex) {
                    LOG.error(" exception while closing resultset " + ex);
                }
            }
            if (ps != null) {
                try {
                    ps.close();
                } catch (SQLException ex) {
                    LOG.error(" exception while closing prepared statement " + ex);
                }
            }
            DbConnectionPool.closeConnection(con);
        }
        return ll;
    }
    /*
    DEALER_LEAD_COUNT_T;
    +---------------+---------+------+-----+---------+----------------+
    | Field         | Type    | Null | Key | Default | Extra          |
    +---------------+---------+------+-----+---------+----------------+
    | ID            | int(11) | NO   | PRI | NULL    | auto_increment |
    | DEALER_ID     | int(11) | NO   |     |         |                |
    | START_DATE    | date    | YES  |     | NULL    |                |
    | END_DATE      | date    | YES  |     | NULL    |                |
    | SMS_COUNT     | int(11) | YES  |     | NULL    |                |
    | EMAIL_COUNT   | int(11) | YES  |     | NULL    |                |
    | LAST_MOD_DATE | date    | YES  |     | NULL    |                |
    | STATUS        | int(11) | YES  |     | NULL    |                |
    +---------------+---------+------+-----+---------+----------------+
     */

    public int getUsedSmsLeadsByDealerId(long dlId) {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        int used = -1;
        String qry = "SELECT SMS_COUNT FROM DEALER_LEAD_COUNT_T WHERE NOW() >= START_DATE AND NOW() <= END_DATE AND STATUS = 1 AND  DEALER_ID=?";
        try {
            con = DbConnectionPool.getConnection();
            long st = System.currentTimeMillis();
            ps = con.prepareCall(qry);
            ps.setLong(1, dlId);
            rs = ps.executeQuery();
            if (rs.next()) {
                used = rs.getInt(1);
            }
            LOG.info((System.currentTimeMillis() - st) + " ms taken to get " + used + " used leads for dealer " + dlId);
        } catch (Exception e) {
            LOG.error(" exception while getting the leads used for the dealer " + dlId + "\n" + e);
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException ex) {
                    LOG.error(" exception while closing resultset " + ex);
                }
            }
            if (ps != null) {
                try {
                    ps.close();
                } catch (SQLException ex) {
                    LOG.error(" exception while closing prepared statement " + ex);
                }
            }
            DbConnectionPool.closeConnection(con);
        }
        return used;
    }

    public DealerMoreInfo getDealerMoreInfoByWebsite(String website) {
        Connection con = null;
        DealerMoreInfo dmi = new DealerMoreInfo();
        PreparedStatement ps = null;
        Statement sto = null;
        ResultSet rs = null;
        String qry = "SELECT DEALER_INFO_T.DEALER_ID,DOMAIN_NAME,DLOGO_PATH,CITY,DEALER_COMP_T.DESCRIPTION,PRODUCTS,IMAGES,BUSINESS_DETAILS,ADDRESS_1,LANDMARK,PHONE,PHONE1,DEALER_COMP_T.EMAIL_ID,WS_URL,DTYPE_ID,LOCALITY,GMAP,WEBSITE,PATH,WEBSHOP_T.ID FROM DEALER_INFO_T,USER_T,ADDRESS_T,DEALER_COMP_T,WEBSHOP_T WHERE DEALER_COMP_T.DEALER_ID=DEALER_INFO_T.DEALER_ID AND ADDRESS_T.ADDRESS_ID=DEALER_INFO_T.ADD_ID AND DEALER_INFO_T.USER_ID=USER_T.USER_ID AND DEALER_INFO_T.DEALER_ID=WEBSHOP_T.DEALER_ID AND WEBSHOP_T.STATUS=5 AND DEALER_INFO_T.WEBSITE=?";
        try {
            con = DbConnectionPool.getConnection();
            ps = con.prepareCall(qry);
            ps.setString(1, website);
            rs = ps.executeQuery();
            if (rs != null && rs.next()) {
                dmi.setdId(rs.getInt(1));
                dmi.setCompName(rs.getString(2));
                dmi.setLogo(rs.getString(3));
                dmi.setCity(rs.getString(4));
                dmi.setAddInfo(rs.getString(5));
                dmi.setProducts(rs.getString(6));
                dmi.setProductImages(rs.getString(7));
                dmi.setBusinessDetails(rs.getString(8));
                dmi.setAddress(rs.getString(9));
                dmi.setLandMark(rs.getString(10));
                dmi.setMobile(rs.getString(11));
                dmi.setPhone(rs.getString(12));
                dmi.setEmailId(rs.getString(13));
                dmi.setWebUrl(rs.getString(14));
                dmi.setDtypeId(rs.getInt(15));
                dmi.setLocality(rs.getString(16));
                dmi.setGoogleMap(rs.getString(17));
                dmi.setWebsite(rs.getString(18));
                dmi.setPath(rs.getString(19));
                dmi.setActiveWsId(rs.getLong(20));
                dmi.setDt(new Date());
            }

        } catch (Exception e) {
            LOG.error("= Exception Occured in  ::=" + e);
        } finally {

            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException e) {
                    LOG.error("= Exception Occured while closing  ResultSet of getDealerMoreInfo() in DealerService() ::=" + e);
                }
            }
            if (ps != null) {
                try {
                    ps.close();
                } catch (SQLException e) {
                    LOG.error("= Exception Occured while closing  Prepared Statement of getDealerMoreInfo() in DealerService() ::=" + e);
                }
            }
            if (con != null) {

                DbConnectionPool.closeConnection(con);
            }
        }
        return dmi;
    }

//   Karteek Starts
    public int getDealerMicrositeCountDeatils(long dlId) {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        int totalMsVisitorsCount = 0;
        String QRY = "SELECT MICROSITE_TOTVISTORS FROM DEALER_INFO_T WHERE DEALER_ID=?";
        try {
            con = DbConnectionPool.getConnection();
            ps = con.prepareStatement(QRY);
            ps.setLong(1, dlId);
            rs = ps.executeQuery();
            if (rs != null && rs.next()) {
                totalMsVisitorsCount = rs.getInt(1);
                LOG.info("Total Microsite visitors Count is " + totalMsVisitorsCount);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException e) {
                    LOG.error("= Exception Occured while  closing ResultSet of getDealerMicrositeCountDeatils() in DealerService() ::=" + e);
                }
            }
            if (ps != null) {
                try {
                    ps.close();
                } catch (SQLException e) {
                    LOG.error("= Exception Occured while closing  Prepared statement of getDealerMicrositeCountDeatils() in DealerService() ::=" + e);
                }
            }
            if (con != null) {
                DbConnectionPool.closeConnection(con);
            }
            return totalMsVisitorsCount;
        }
    }
    //   Karteek Ends
}
