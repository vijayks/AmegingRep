/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.buysell.servlets;

import com.buysell.beans.AdsBean;
import com.buysell.beans.BbsBean;
import com.buysell.beans.MyAdDetailsBean;
import com.buysell.beans.PreferenceBean;
import com.buysell.beans.ScrAdsBean;
import com.buysell.beans.UserBean;
import com.buysell.beans.UserProfileBean;
import com.buysell.db.DbConnection;
import com.buysell.db.DbConnectionPool;
import com.buysell.util.CategoryUtil;
import java.util.HashMap;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.StringTokenizer;
import javax.servlet.http.HttpServletRequest;
import org.apache.log4j.Logger;

/**
 *
 * @author bbsadmin
 */
public class AdsService {

    DbConnection db = new DbConnection();
    private static Logger LOG = Logger.getLogger(AdsService.class);

    public AdsService() {
    }
// this method used in refine search to get the matched criteria ads and display that ads..

    public ArrayList getAdList(String query1, String query2, HttpServletRequest request) {

        Connection con = null;
        Statement sto = null;
        ResultSet rs = null;
        ArrayList al = new ArrayList();
        AdsBean ab = new AdsBean();
        con = DbConnectionPool.getConnection();
        long st = System.currentTimeMillis();
        try {
            sto = con.createStatement();
            rs = sto.executeQuery(query1);
            if (rs != null) {
                while (rs.next()) {

                    ab = new AdsBean();
                    ab.setTitle(rs.getString(1));
                    ab.setImage1(rs.getString(2));
                    ab.setDescription(rs.getString(3));
                    ab.setAddtionalContent(rs.getString(4));
                    ab.setAdId(rs.getInt(5));
                    ab.setPostedDate(new java.text.SimpleDateFormat("dd/MM/yyyy").format(rs.getTimestamp(6)));
                    ab.setFirstName(rs.getString(7));
                    ab.setPrice(rs.getFloat(8));
                    ab.setNeg(rs.getString(9));
                    ab.setCatId(rs.getInt(10));
                    ab.setEmail(rs.getString(11));
                    ab.setAdType(rs.getString(12));
                    ab.setAddress(rs.getString(13));
                    ab.setMobile(rs.getString(14));
                    ab.setPh2(rs.getString(15));
                    ab.setCity(rs.getString(16));
                    ab.setCfp(rs.getString(17));
                    ab.setUserId(rs.getInt(18));
                    ab.setLocality(rs.getString(19));
                    
                    al.add(ab);

                }

            }
        } catch (Exception e) {
            LOG.error("execption occured in getAdList() used to get ads list for Refine Search" + e);
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (Exception e) {
                    LOG.error("= Exception Occured in closing ResultSet ::=" + e);
                }
            }
            if (sto != null) {
                try {
                    sto.close();
                } catch (Exception e) {
                    LOG.error("= Exception Occured in closing PreparedStatement ::=" + e);
                }
            }
            if (con != null) {
                DbConnectionPool.closeConnection(con);
            }
            long et = System.currentTimeMillis();
            LOG.debug("= Time taken to complete db operation :: =" + (et - st) + " Milli Seconds");
        }

        try {
            con = DbConnectionPool.getConnection();

            sto = con.createStatement();
            rs = sto.executeQuery(query2);
            if (rs != null && rs.next()) {
                request.setAttribute("c", rs.getInt(1));
            }

        } catch (Exception e) {
            LOG.error("= Exception Occured in  count ::=" + e);
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (Exception e) {
                    LOG.error("= Exception Occured in closing ResultSet ::=" + e);
                }
            }
            if (sto != null) {
                try {
                    sto.close();
                } catch (Exception e) {
                    LOG.error("= Exception Occured in closing PreparedStatement ::=" + e);
                }
            }
            if (con != null) {
                DbConnectionPool.closeConnection(con);
            }
        }
        return al;
    }

    public ArrayList getBasicSearchResults(String qry1, String qry2, HttpServletRequest request) {
        long st = System.currentTimeMillis();
        Connection con = null;
        Statement sto = null;
        ResultSet rs = null;
        ArrayList al = new ArrayList();
        AdsBean ab = new AdsBean();
        con = DbConnectionPool.getConnection();
        try {
            sto = con.createStatement();
            rs = sto.executeQuery(qry1);
            if (rs != null) {
                while (rs.next()) {
                    ab = new AdsBean();
                    ab.setTitle(rs.getString(1));
                    ab.setImage1(rs.getString(2));
                    ab.setDescription(rs.getString(3));
                    ab.setAddtionalContent(rs.getString(4));
                    ab.setAdId(rs.getInt(5));
                    ab.setPostedDate(new java.text.SimpleDateFormat("dd/MM/yyyy").format(rs.getTimestamp(6)));
                    ab.setFirstName(rs.getString(7));
                    ab.setPrice(rs.getFloat(8));
                    ab.setNeg(rs.getString(9));
                    ab.setCatId(rs.getInt(10));
                    ab.setEmail(rs.getString(11));
                    ab.setAdType(rs.getString(12));
                    ab.setAddress(rs.getString(13));
                    ab.setMobile(rs.getString(14));
                    ab.setPh2(rs.getString(15));
                    ab.setCity(rs.getString(16));
                    ab.setCfp(rs.getString(17));
                    ab.setLocality(rs.getString(18));
                    al.add(ab);
                }
            }


        } catch (Exception e) {
            LOG.error("Error in Basic Searching Db operations=" + e);
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (Exception e) {
                    LOG.error("= Exception Occured in closing ResultSet ::=" + e);
                }
            }
            if (sto != null) {
                try {
                    sto.close();
                } catch (Exception e) {
                    LOG.error("= Exception Occured in closing PreparedStatement ::=" + e);
                }
            }
            if (con != null) {
                DbConnectionPool.closeConnection(con);
            }
            long et = System.currentTimeMillis();
            LOG.debug("= Time taken to complete db operation :: =" + (et - st) + " Milli Seconds");
        }

        try {
            con = DbConnectionPool.getConnection();
            sto = con.createStatement();
            rs = sto.executeQuery(qry2);

            if (rs != null && rs.next()) {
                request.setAttribute("c", rs.getInt(1));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (Exception e) {
                    LOG.error("= Exception Occured in closing ResultSet ::=" + e);
                }
            }
            if (sto != null) {
                try {
                    sto.close();
                } catch (Exception e) {
                    LOG.error("= Exception Occured in closing PreparedStatement ::=" + e);
                }
            }
            if (con != null) {
                DbConnectionPool.closeConnection(con);
            }
        }

        return al;
    }

    public ArrayList getBbsPoints(UserBean ub, HttpServletRequest request) {
        long st = System.currentTimeMillis();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        ArrayList al = new ArrayList();
        BbsBean bb;
        int earned = 0;
        int redemned = 0;
        con = DbConnectionPool.getConnection();
        String query = "SELECT POINTS_ON , REFERAL_POINTS ,POINTS_TYPE FROM USER_REFERAL_POINTS_T WHERE  USER_ID=?";
        try {
            ps = con.prepareStatement(query);
            ps.setInt(1, ub.getUserId());
            rs = ps.executeQuery();
            if (rs != null) {
                while (rs.next()) {
                    bb = new BbsBean();
                    bb.setPointsOn(new java.text.SimpleDateFormat("dd/MM/yyyy").format(rs.getTimestamp(1)));
                    bb.setPoints(rs.getInt(2));
                    bb.setReason(rs.getString(3));
                    al.add(bb);
                }

            }
        } catch (Exception e) {
            LOG.error("= Exception Occured in setting user points ::=" + e);
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
        /*-------------------------------------------------------------*/
        try {
            String q2 = "SELECT SUM(REFERAL_POINTS) FROM USER_REFERAL_POINTS_T WHERE USER_ID=?";
            con = DbConnectionPool.getConnection();
            ps = con.prepareStatement(q2);
            ps.setInt(1, ub.getUserId());
            rs = ps.executeQuery();
            if (rs != null && rs.next()) {
                earned = rs.getInt(1);
                request.setAttribute("earned", earned);

            }

        } catch (Exception e) {
            LOG.error("= Exception Occured in getting sum of referal points  ::=" + e);
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
        /*------------------------------------------------------------*/

        try {
            String q3 = "SELECT SUM(POINTS_REDEMN) FROM REDEMPTION_T WHERE USER_ID=?";
            con = DbConnectionPool.getConnection();
            ps = con.prepareStatement(q3);
            ps.setInt(1, ub.getUserId());
            rs = ps.executeQuery();
            if (rs != null && rs.next()) {
                redemned = rs.getInt(1);
                request.setAttribute("redemned", redemned);
                request.setAttribute("current", earned - redemned);

            }
        } catch (Exception e) {
            LOG.error("= Exception Occured in points redemption ::=" + e);
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
            long et = System.currentTimeMillis();
            LOG.debug("= Time taken to complete db operation for getting bbs points :: =" + (et - st) + " Milli Seconds");
        }
        return al;
    }
    /*

    SELECT TITLE,IMAGE1,DESCRIPTION,ADDITIONAL_CONTENT,
    AD_T.AD_ID, AD_T.CREATION_DATE, FIRST_NAME,PRICE,NEGOTIABLE,
    CATEGORY_ID,LOGIN_NAME,AD_TYPE,ADDRESS_1,MINI,
    MAX,CITY,CONTACT_PRICE,PHONE,LOCALITY
    from AD_FIELDS,AD_T,USER_T,USER_LOGIN_T,ADDRESS_T WHERE ADDRESS_T.ADDRESS_ID=AD_FIELDS.ADD_ID
    AND USER_T.USER_ID=USER_LOGIN_T.USER_ID AND AD_T.USER_ID=USER_T.USER_ID AND AD_FIELDS.AD_ID=AD_T.AD_ID
    AND AD_T.STATUS=1 AND CATEGORY_ID=" + clfId1 + adTypeQuery + " ORDER BY " + oBy0 + "  LIMIT " + start + "," + range;
     */

    public ArrayList getClfAdsList(String qry1, String qry2, HttpServletRequest request) {

        ArrayList al = new ArrayList();
        AdsBean ab = new AdsBean();
        Connection con = null;
        Statement sto = null;
        ResultSet rs = null;
        con = DbConnectionPool.getConnection();
        long st = System.currentTimeMillis();
        try {
            sto = con.createStatement();
            rs = sto.executeQuery(qry1);

            if (rs != null) {
                while (rs.next()) {
                    ab = new AdsBean();
                    ab.setTitle(rs.getString(1));
                    ab.setImage1(rs.getString(2));
                    ab.setDescription(rs.getString(3));
                    ab.setAddtionalContent(rs.getString(4));

                    ab.setAdId(rs.getInt(5));
                    ab.setPostedDate(new java.text.SimpleDateFormat("dd/MM/yyyy").format(rs.getTimestamp(6)));
                    ab.setFirstName(rs.getString(7));
                    ab.setPrice(rs.getFloat(8));
                    ab.setNeg(rs.getString(9));

                    ab.setCatId(rs.getInt(10));
                    ab.setEmail(rs.getString(11));
                    ab.setAdType(rs.getString(12));
                    ab.setAddress(rs.getString(13));
                    ab.setMin(rs.getInt(14));

                    ab.setMax(rs.getInt(15));
                    ab.setCity(rs.getString(16));
                    ab.setCfp(rs.getString(17));
                    ab.setMobile(rs.getString(18));
                    ab.setLocality(rs.getString(19));
                    if (rs.getString(20) != null) {
                        StringTokenizer str1 = new StringTokenizer(rs.getString(20), "|");
                        if (str1.countTokens() >= 5) {
                            try {

                                str1.nextElement();
                                ab.setCatName((String) str1.nextElement());
                                ab.setParentCatName((String) str1.nextElement());
                                ab.setSuperParentName((String) str1.nextElement());
                                str1.nextElement();

                            } catch (Exception e) {
                                LOG.error("Error :" + e);
                            }

                        }
                    }

                    al.add(ab);

                }

            }


        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (Exception e) {
                    LOG.error("= Exception Occured in closing ResultSet ::=" + e);
                }
            }
            if (sto != null) {
                try {
                    sto.close();
                } catch (Exception e) {
                    LOG.error("= Exception Occured in closing PreparedStatement ::=" + e);
                }
            }
            if (con != null) {
                DbConnectionPool.closeConnection(con);
            }
        }

        try {
            con = DbConnectionPool.getConnection();
            sto = con.createStatement();
            rs = sto.executeQuery(qry2);

            if (rs != null) {
                if (rs.next()) {
                    request.setAttribute("c", rs.getInt(1));
                }

            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (Exception e) {
                    LOG.error("= Exception Occured in closing ResultSet ::=" + e);
                }
            }
            if (sto != null) {
                try {
                    sto.close();
                } catch (Exception e) {
                    LOG.error("= Exception Occured in closing PreparedStatement ::=" + e);
                }
            }
            if (con != null) {
                DbConnectionPool.closeConnection(con);
            }
            long et = System.currentTimeMillis();
            LOG.debug("= Time taken to complete db operation :: =" + (et - st) + " Milli Seconds");
        }
        return al;
    }

    /* this method to get the number of ads in the category */
    public String getCountAds(int i) {
        String qry = "SELECT COUNT(*) FROM AD_T WHERE CATEGORY_ID=?";
        String count = null;
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            con = DbConnectionPool.getConnection();
            ps = con.prepareStatement(qry);
            ps.setInt(1, i);
            rs = ps.executeQuery();

            if (rs != null && rs.next()) {
                count = (String) rs.getString(1);
            }

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

        return count;
    }

    public ArrayList getLatestAdsList(String qry1, String qry2, HttpServletRequest request) {

        long st = System.currentTimeMillis();
        Connection con = null;
        Statement sto = null;
        ResultSet rs = null;
        ArrayList al = new ArrayList();
        AdsBean ab = new AdsBean();
        try {
            con = DbConnectionPool.getConnection();
            sto = con.createStatement();
            rs = sto.executeQuery(qry1);

            if (rs != null) {
                while (rs.next()) {
                    ab = new AdsBean();
                    ab.setTitle(rs.getString(1));
                    ab.setImage1(rs.getString(2));
                    ab.setDescription(rs.getString(3));
                    ab.setAddtionalContent(rs.getString(4));
                    ab.setAdId(rs.getInt(5));
                    ab.setFirstName(rs.getString(7));
                    ab.setPrice(rs.getFloat(8));
                    ab.setNeg(rs.getString(9));
                    ab.setCatId(rs.getInt(10));
                    ab.setEmail(rs.getString(11));
                    ab.setAdType(rs.getString(12));
                    ab.setAddress(rs.getString(13));
                    ab.setMin(rs.getFloat(14));
                    ab.setMax(rs.getFloat(15));
                    ab.setCity(rs.getString(16));
                    ab.setCfp(rs.getString(17));
                    ab.setUserId(rs.getInt(18));
                    ab.setMobile(rs.getString(19));
                    ab.setLocality(rs.getString(20));
                    if (rs.getString(21) != null) {
                        StringTokenizer str1 = new StringTokenizer(rs.getString(21), "|");
                        if (str1.countTokens() >= 5) {
                            try {

                                str1.nextElement();
                                ab.setCatName((String) str1.nextElement());
                                ab.setParentCatName((String) str1.nextElement());
                                ab.setSuperParentName((String) str1.nextElement());
                                str1.nextElement();

                            } catch (Exception e) {
                                LOG.error("Error :" + e);
                            }

                        }
                    }
                    ab.setPostedDate(new java.text.SimpleDateFormat("dd/MM/yyyy").format(rs.getTimestamp(6)));
                    ab.setRentMonth(rs.getInt(22));
                    ab.setDlrLogo(rs.getString(23));
                    ab.setSponsType(rs.getInt(24));
                    //ab.setDlrName(rs.getString(25));
                    al.add(ab);
                }

            }
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
            if (sto != null) {
                try {
                    sto.close();
                } catch (Exception e) {
                    LOG.error("= Exception Occured in closing PreparedStatement ::=" + e);
                }
            }
            if (con != null) {
                DbConnectionPool.closeConnection(con);
            }
        }

        try {
            con = DbConnectionPool.getConnection();
            sto = con.createStatement();
            rs = sto.executeQuery(qry2);
            if (rs != null) {
                if (rs.next()) {
                    request.setAttribute("c", rs.getInt(1));
                }

            }
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
            if (sto != null) {
                try {
                    sto.close();
                } catch (Exception e) {
                    LOG.error("= Exception Occured in closing PreparedStatement ::=" + e);
                }
            }
            if (con != null) {
                DbConnectionPool.closeConnection(con);
            }
            long et = System.currentTimeMillis();
            LOG.debug("= Time taken to complete db operation :: =" + (et - st) + " Milli Seconds");
        }

        return al;
    }

    public ArrayList getRejectedAdsList(UserBean ub) {
        ArrayList al = new ArrayList();
        AdsBean ab = new AdsBean();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        long st = System.currentTimeMillis();
        String qry = "SELECT TITLE,IMAGE1,DESCRIPTION,ADDITIONAL_CONTENT, AD_T.AD_ID, AD_T.CREATION_DATE, FIRST_NAME,PRICE,NEGOTIABLE,CATEGORY_ID,LOGIN_NAME,AD_TYPE,ADDRESS_1,MINI,MAX,CITY,CONTACT_PRICE,AD_T.USER_ID,PHONE,AD_T.STATUS,LOCALITY from AD_FIELDS,AD_T,USER_T,USER_LOGIN_T,ADDRESS_T WHERE ADDRESS_T.ADDRESS_ID=AD_FIELDS.ADD_ID AND USER_T.USER_ID=USER_LOGIN_T.USER_ID AND AD_T.USER_ID=USER_T.USER_ID AND AD_FIELDS.AD_ID=AD_T.AD_ID  AND AD_T.STATUS =7 AND USER_T.USER_ID=? ORDER BY AD_T.AD_ID";
        try {
            con = DbConnectionPool.getConnection();
            ps = con.prepareStatement(qry);
            ps.setInt(1, ub.getUserId());
            rs = ps.executeQuery();

            if (rs != null) {
                while (rs.next()) {
                    ab = new AdsBean();
                    ab.setTitle(rs.getString(1));
                    ab.setImage1(rs.getString(2));
                    ab.setDescription(rs.getString(3));
                    ab.setAddtionalContent(rs.getString(4));
                    ab.setAdId(rs.getInt(5));

                    ab.setFirstName(rs.getString(7));
                    ab.setPrice(rs.getFloat(8));
                    ab.setNeg(rs.getString(9));
                    ab.setCatId(rs.getInt(10));
                    ab.setEmail(rs.getString(11));
                    ab.setAdType(rs.getString(12));
                    ab.setAddress(rs.getString(13));
                    ab.setMin(rs.getFloat(14));
                    ab.setMax(rs.getFloat(15));
                    ab.setCity(rs.getString(16));
                    ab.setCfp(rs.getString(17));
                    ab.setUserId(rs.getInt(18));
                    ab.setMobile(rs.getString(19));
                    ab.setStatus(rs.getInt(20));
                    ab.setLocality(rs.getString(21));

                    ab.setPostedDate(new java.text.SimpleDateFormat("dd/MM/yyyy").format(rs.getTimestamp(6)));

                    al.add(ab);
                }

            }
        } catch (Exception e) {
            e.printStackTrace();
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
            long et = System.currentTimeMillis();
            LOG.debug("= Time taken to complete db operation :: =" + (et - st) + " Milli Seconds");
        }
        return al;
    }

    public ArrayList getEditOrRenewAdsList(int start, int range, String oBy, UserBean ub, HttpServletRequest request) {

        long st = System.currentTimeMillis();
        String qry = "SELECT TITLE,IMAGE1,DESCRIPTION,ADDITIONAL_CONTENT, AD_T.AD_ID, AD_T.CREATION_DATE, FIRST_NAME,PRICE,NEGOTIABLE,CATEGORY_ID,LOGIN_NAME,AD_TYPE,ADDRESS_1,MINI,MAX,CITY,CONTACT_PRICE,AD_T.USER_ID,PHONE,AD_T.STATUS,LOCALITY from AD_FIELDS,AD_T,USER_T,USER_LOGIN_T,ADDRESS_T WHERE ADDRESS_T.ADDRESS_ID=AD_FIELDS.ADD_ID AND USER_T.USER_ID=USER_LOGIN_T.USER_ID AND AD_T.USER_ID=USER_T.USER_ID AND AD_FIELDS.AD_ID=AD_T.AD_ID  AND AD_T.STATUS IN (1,3,4,5,6) AND USER_T.USER_ID=? ORDER BY ?  LIMIT ?,?";
        ArrayList al = new ArrayList();
        AdsBean ab = new AdsBean();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = DbConnectionPool.getConnection();
            ps = con.prepareStatement(qry);
            ps.setInt(1, ub.getUserId());
            ps.setString(2, oBy);
            ps.setInt(3, start);
            ps.setInt(4, range);
            rs = ps.executeQuery();

            if (rs != null) {
                while (rs.next()) {
                    ab = new AdsBean();
                    ab.setTitle(rs.getString(1));
                    ab.setImage1(rs.getString(2));
                    ab.setDescription(rs.getString(3));
                    ab.setAddtionalContent(rs.getString(4));
                    ab.setAdId(rs.getInt(5));
                    ab.setPostedDate(new java.text.SimpleDateFormat("dd/MM/yyyy").format(rs.getTimestamp(6)));

                    ab.setFirstName(rs.getString(7));
                    ab.setPrice(rs.getFloat(8));
                    ab.setNeg(rs.getString(9));
                    ab.setCatId(rs.getInt(10));
                    ab.setEmail(rs.getString(11));
                    ab.setAdType(rs.getString(12));
                    ab.setAddress(rs.getString(13));
                    ab.setMin(rs.getFloat(14));
                    ab.setMax(rs.getFloat(15));
                    ab.setCity(rs.getString(16));
                    ab.setCfp(rs.getString(17));
                    ab.setUserId(rs.getInt(18));
                    ab.setMobile(rs.getString(19));
                    ab.setStatus(rs.getInt(20));
                    ab.setLocality(rs.getString(21));
                    al.add(ab);
                }

            }
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

        try {
            String q2 = "SELECT COUNT(*) FROM AD_FIELDS,AD_T,USER_T,USER_LOGIN_T,ADDRESS_T WHERE ADDRESS_T.ADDRESS_ID=AD_FIELDS.ADD_ID AND USER_T.USER_ID=USER_LOGIN_T.USER_ID AND AD_T.USER_ID=USER_T.USER_ID AND AD_FIELDS.AD_ID=AD_T.AD_ID  AND AD_T.STATUS IN (1,3,4,5,6) AND AD_T.USER_ID=?";
            con = DbConnectionPool.getConnection();
            ps = con.prepareStatement(q2);
            ps.setInt(1, ub.getUserId());
            rs = ps.executeQuery();
            if (rs != null && rs.next()) {
                request.setAttribute("c", rs.getInt(1));
            }

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
            long et = System.currentTimeMillis();
            LOG.debug("= Time taken to complete db operation  :: =" + (et - st) + " Milli Seconds");
        }

        return al;
    }

    public ArrayList getDeleteAdsList(int start, int range, String oBy, UserBean ub, HttpServletRequest request) {
        long st = System.currentTimeMillis();
        String qry = "SELECT TITLE,IMAGE1,DESCRIPTION,ADDITIONAL_CONTENT, AD_T.AD_ID, AD_T.CREATION_DATE, FIRST_NAME,PRICE,NEGOTIABLE,CATEGORY_ID,LOGIN_NAME,AD_TYPE,ADDRESS_1,MINI,MAX,CITY,CONTACT_PRICE,AD_T.USER_ID,PHONE,AD_T.STATUS,LOCALITY,AD_T.SPONSORED_TYPE from AD_FIELDS,AD_T,USER_T,USER_LOGIN_T,ADDRESS_T WHERE ADDRESS_T.ADDRESS_ID=AD_FIELDS.ADD_ID AND USER_T.USER_ID=USER_LOGIN_T.USER_ID AND AD_T.USER_ID=USER_T.USER_ID AND AD_T.STATUS IN (1,2,3,4,6) AND AD_FIELDS.AD_ID=AD_T.AD_ID  AND  AD_T.USER_ID=? ORDER BY ?  LIMIT ?,?";
        ArrayList al = new ArrayList();
        AdsBean ab = new AdsBean();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = DbConnectionPool.getConnection();
            ps = con.prepareStatement(qry);
            ps.setInt(1, ub.getUserId());
            ps.setString(2, oBy);
            ps.setInt(3, start);
            ps.setInt(4, range);
            rs = ps.executeQuery();

            if (rs != null) {
                while (rs.next()) {
                    ab = new AdsBean();
                    ab.setTitle(rs.getString(1));
                    ab.setImage1(rs.getString(2));
                    ab.setDescription(rs.getString(3));
                    ab.setAddtionalContent(rs.getString(4));
                    ab.setAdId(rs.getInt(5));
                    ab.setPostedDate(new java.text.SimpleDateFormat("dd/MM/yyyy").format(rs.getTimestamp(6)));

                    ab.setFirstName(rs.getString(7));
                    ab.setPrice(rs.getFloat(8));
                    ab.setNeg(rs.getString(9));
                    ab.setCatId(rs.getInt(10));
                    ab.setEmail(rs.getString(11));
                    ab.setAdType(rs.getString(12));
                    ab.setAddress(rs.getString(13));
                    ab.setMax(rs.getFloat(15));
                    ab.setCity(rs.getString(16));
                    ab.setCfp(rs.getString(17));
                    ab.setUserId(rs.getInt(18));
                    ab.setMobile(rs.getString(19));
                    ab.setStatus(rs.getInt(20));
                    ab.setLocality(rs.getString(21));
                    ab.setSponsType(rs.getInt(22));

                    al.add(ab);
                }

            }

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

        try {
            String q = "SELECT COUNT(*) from AD_T WHERE STATUS IN (1,2,3,4,6) AND USER_ID=?";
            con = DbConnectionPool.getConnection();
            ps = con.prepareStatement(q);
            ps.setInt(1, ub.getUserId());
            rs = ps.executeQuery();
            if (rs != null) {
                if (rs.next()) {
                    request.setAttribute("c", rs.getInt(1));
                }

            }
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
            long et = System.currentTimeMillis();
            LOG.debug("= Time taken to complete db operation  for delete ads list:: =" + (et - st) + " Milli Seconds");
        }

        return al;
    }

    public ArrayList getMySavedAdsList(UserBean ub, HttpServletRequest request) {
        long st = System.currentTimeMillis();
        String qry = "SELECT TITLE,IMAGE1,DESCRIPTION,ADDITIONAL_CONTENT, AD_T.AD_ID, SAVED_ADS_T.SAVED_DATE, FIRST_NAME,PRICE,NEGOTIABLE,CATEGORY_ID,LOGIN_NAME,AD_TYPE,ADDRESS_1,MINI,MAX,CITY,CONTACT_PRICE,AD_T.USER_ID,PHONE, AD_T.STATUS, SAVED_ADS_T.ID, LOCALITY from AD_FIELDS,AD_T,USER_T,USER_LOGIN_T,ADDRESS_T,SAVED_ADS_T WHERE AD_T.AD_ID=SAVED_ADS_T.AD_ID AND  ADDRESS_T.ADDRESS_ID=AD_FIELDS.ADD_ID AND USER_T.USER_ID=USER_LOGIN_T.USER_ID AND AD_T.USER_ID=USER_T.USER_ID AND  AD_FIELDS.AD_ID=AD_T.AD_ID  AND SAVED_ADS_T.USER_ID=? ORDER BY SAVED_ADS_T.ID ";
        ArrayList al = new ArrayList();
        AdsBean ab = new AdsBean();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = DbConnectionPool.getConnection();
            ps = con.prepareStatement(qry);
            ps.setInt(1, ub.getUserId());
            rs = ps.executeQuery();
            if (rs != null) {
                while (rs.next()) {
                    ab = new AdsBean();
                    ab.setTitle(rs.getString(1));
                    ab.setImage1(rs.getString(2));
                    ab.setDescription(rs.getString(3));
                    ab.setAddtionalContent(rs.getString(4));
                    ab.setAdId(rs.getInt(5));
                    ab.setPostedDate(new java.text.SimpleDateFormat("dd/MM/yyyy").format(rs.getTimestamp(6)));

                    ab.setFirstName(rs.getString(7));
                    ab.setPrice(rs.getFloat(8));
                    ab.setNeg(rs.getString(9));
                    ab.setCatId(rs.getInt(10));
                    ab.setEmail(rs.getString(11));
                    ab.setAdType(rs.getString(12));
                    ab.setAddress(rs.getString(13));
                    ab.setMin(rs.getFloat(14));
                    ab.setMax(rs.getFloat(15));
                    ab.setCity(rs.getString(16));
                    ab.setCfp(rs.getString(17));
                    ab.setUserId(rs.getInt(18));
                    ab.setMobile(rs.getString(19));
                    ab.setStatus(rs.getInt(20));
                    ab.setSavedId(rs.getInt(21));
                    ab.setLocality(rs.getString(22));


                    al.add(ab);
                }

            }
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

        try {
            String qc = "SELECT COUNT(*) FROM AD_T,SAVED_ADS_T WHERE AD_T.AD_ID=SAVED_ADS_T.AD_ID AND SAVED_ADS_T.USER_ID=?";
            con = DbConnectionPool.getConnection();
            ps = con.prepareStatement(qc);
            ps.setInt(1, ub.getUserId());
            rs = ps.executeQuery();
            if (rs != null) {
                if (rs.next()) {
                    request.setAttribute("c", rs.getInt(1));
                }
            }
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
            long et = System.currentTimeMillis();
            LOG.debug("= Time taken to complete db operation for my saved ads list:: =" + (et - st) + " Milli Seconds");
        }

        return al;
    }

    public ArrayList getMySavedAlertss(UserBean ub, CategoryUtil cu) {
        long st = System.currentTimeMillis();
        String qry = "SELECT ALERT_ID,ALERT_CREATION_DATE,ALERT_FROM,ALERT_TO,ALERT_PATTERN FROM ALERT_T WHERE USER_ID=? ORDER BY ALERT_ID DESC";
        ArrayList al = new ArrayList();
        BbsBean bb = null;
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {

            con = DbConnectionPool.getConnection();
            ps = con.prepareStatement(qry);
            ps.setInt(1, ub.getUserId());
            rs = ps.executeQuery();
            if (rs != null) {
                while (rs.next()) {
                    bb = new BbsBean();
                    bb.setAlertId(rs.getInt(1));
                    bb.setAlertOn(new java.text.SimpleDateFormat("dd/MM/yyyy").format(rs.getTimestamp(2)));
                    bb.setAlertFrom(new java.text.SimpleDateFormat("dd/MM/yyyy").format(rs.getTimestamp(3)));
                    bb.setAlertTo(new java.text.SimpleDateFormat("dd/MM/yyyy").format(rs.getTimestamp(4)));

                    bb.setPropertiesFromAlertPattern(rs.getString(5));


                    if (bb.getCategoryId() != 0) {
                        bb.setCatName(cu.getCategoryNameWithId(bb.getCategoryId()));
                    } else {
                        bb.setCatName(" ");
                    }

                    LOG.debug("catName=" + bb.getCatName());
                    al.add(bb);
                }

            }
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
            long et = System.currentTimeMillis();
            LOG.debug("= Time taken to complete db operation my saved alerts :: =" + (et - st) + " Milli Seconds");
        }
        return al;
    }

    public ArrayList getMySavedSearches(UserBean ub, CategoryUtil cu) {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        ArrayList al = new ArrayList();
        String qry = "SELECT  SEARCH_DATE, SEARCH_URL, SEARCH_PATTERN ,SEARCH_ID FROM SAVED_SEARCH_T WHERE USER_ID=? ORDER BY SEARCH_ID DESC";
        try {
            con = DbConnectionPool.getConnection();
            ps = con.prepareStatement(qry);
            ps.setInt(1, ub.getUserId());
            rs = ps.executeQuery();

            if (rs != null) {
                BbsBean bb = null;
                while (rs.next()) {
                    bb = new BbsBean();
                    bb.setSearchOn(rs.getString(1));
                    bb.setSearchUrl(rs.getString(2));
                    bb.setPropertiesFromSearchPattern(rs.getString(3));
                    bb.setSearchId(rs.getInt(4));
                    al.add(bb);
                }
            }
        } catch (Exception e) {
            LOG.debug("error in MysavedSearches db operations:" + e);
            LOG.error(e);
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
        return al;
    }

    public PreferenceBean getPreferencesList(int userId) {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        PreferenceBean pb = new PreferenceBean();
        String qry = " SELECT PREFERENCE_ID,USER_ID,SELECTED_CATEGORIES,FROM_TIME,TO_TIME, RESPONSE_TYPE,GET_CALL,ADS_PER_DAY,MODIFIED_DATE FROM PREFERENCES_T WHERE USER_ID=?";
        try {
            con = DbConnectionPool.getConnection();
            ps = con.prepareStatement(qry);
            ps.setInt(1, userId);
            rs = ps.executeQuery();

            if (rs != null && rs.next()) {
                pb.setPreferenceId(rs.getInt(1));
                pb.setUserId(rs.getInt(2));
                pb.setcatIdsWithDbString(rs.getString(3));
                LOG.debug("inside Preference Bean");
                pb.setSmsTimeFrom(rs.getInt(4));
                pb.setSmsTimeTo(rs.getInt(5));
                pb.setRespType(rs.getInt(6));
                pb.setCallMe(rs.getInt(7));
                pb.setMaxSms(rs.getInt(8));
                LOG.debug("PrefId=" + rs.getInt(1));
                LOG.debug("userId=" + rs.getInt(2));
                LOG.debug("catIds=" + rs.getString(3));
                LOG.debug("smsTimeFrom=" + rs.getInt(4));
                LOG.debug("smsTimeTo=" + rs.getInt(5));
                LOG.debug("respType=" + rs.getInt(6));
                LOG.debug(("callMe=" + rs.getInt(7)));
                LOG.debug("adsPerDay=" + rs.getInt(8));
                LOG.debug("modifiedDate=" + new java.text.SimpleDateFormat("dd/MM/yyyy").format(rs.getTimestamp(9)));
                pb.setModifiedDate(new java.text.SimpleDateFormat("dd/MM/yyyy").format(rs.getTimestamp(9)));

            } else {
                LOG.debug("User preferences are not exits");
                pb = null;
            }

        } catch (Exception e) {
            LOG.error("Error in Preferences Retrival :" + e);
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

        return pb;
    }

    public ArrayList getRedemptionPointsList(UserBean ub, HttpServletRequest request) {
        BbsBean bb;
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        int earned = 0;
        int redemned = 0;
        ArrayList al = new ArrayList();

        try {
            String qry = "SELECT REDEMN_ON, POINTS_REDEMN, ITEM_TAKEN, QTY, STATUS,DELIVER_DATE,DELIVER_ADDRESS FROM REDEMPTION_T WHERE USER_ID=?";
            con = DbConnectionPool.getConnection();
            ps = con.prepareStatement(qry);
            ps.setInt(1, ub.getUserId());
            rs = ps.executeQuery();

            if (rs != null) {
                while (rs.next()) {
                    bb = new BbsBean();
                    LOG.debug("1");
                    bb.setPointsOn(new java.text.SimpleDateFormat("dd/MM/yyyy").format(rs.getTimestamp(1)));
                    LOG.debug(rs.getTimestamp(1));
                    bb.setPoints(rs.getInt(2));
                    LOG.debug(rs.getInt(2));
                    bb.setReason(rs.getString(3));
                    LOG.debug(rs.getString(3));
                    bb.setQty(rs.getInt(4));
                    LOG.debug(rs.getInt(4));
                    bb.setStatus(rs.getString(5));
                    LOG.debug(rs.getString(5));
                    bb.setDeliverOn(new java.text.SimpleDateFormat("dd/MM/yyyy").format(rs.getTimestamp(6)));
                    LOG.debug(rs.getTimestamp(6));
                    bb.setDeliverTo(rs.getString(7));
                    LOG.debug(rs.getString(7));
                    bb.setPropertiesFromString(rs.getString(7));
                    LOG.debug("after values are setted");
                    LOG.debug("on:" + new java.text.SimpleDateFormat("dd/MM/yyyy").format(rs.getTimestamp(1)));
                    LOG.debug("Points:" + rs.getInt(2));
                    LOG.debug("Reason:" + rs.getString(3));
                    al.add(bb);
                }

            }
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

        /*-----------------------------------------------------------------*/
        try {
            String qry2 = "SELECT SUM(REFERAL_POINTS) FROM USER_REFERAL_POINTS_T WHERE USER_ID=?";
            con = DbConnectionPool.getConnection();
            ps = con.prepareStatement(qry2);
            ps.setInt(1, ub.getUserId());
            rs = ps.executeQuery();

            if (rs != null && rs.next()) {
                earned = rs.getInt(1);
                request.setAttribute("earned", earned);

            }
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

        /*-----------------------------------------------------------------*/

        try {
            String qry3 = "SELECT SUM(POINTS_REDEMN) FROM REDEMPTION_T WHERE USER_ID=?";
            con = DbConnectionPool.getConnection();
            ps = con.prepareStatement(qry3);
            ps.setInt(1, ub.getUserId());
            rs = ps.executeQuery();
            if (rs != null && rs.next()) {
                redemned = rs.getInt(1);
                request.setAttribute("redemned", redemned);
                request.setAttribute("current", earned - redemned);

            }
        } catch (Exception e) {
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

        return al;
    }

    public ArrayList getSpecificAdsList(UserBean ub, int status) {
        String qry = "SELECT TITLE,IMAGE1,DESCRIPTION,ADDITIONAL_CONTENT, AD_T.AD_ID, AD_T.CREATION_DATE, FIRST_NAME,PRICE,NEGOTIABLE,CATEGORY_ID,LOGIN_NAME,AD_TYPE,ADDRESS_1,PHONE,MOBILE_CODE,CITY,CONTACT_PRICE,AD_T.STATUS,LOCALITY from AD_FIELDS,AD_T,USER_T,USER_LOGIN_T,ADDRESS_T WHERE ADDRESS_T.ADDRESS_ID=AD_FIELDS.ADD_ID AND USER_T.USER_ID=USER_LOGIN_T.USER_ID AND AD_T.USER_ID=USER_T.USER_ID AND AD_T.STATUS=? AND AD_FIELDS.AD_ID=AD_T.AD_ID  AND AD_T.USER_ID=? AND SPONSORED_TYPE=1 ORDER BY AD_ID DESC";
        ArrayList al = new ArrayList();
        AdsBean ab = new AdsBean();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = DbConnectionPool.getConnection();
            ps = con.prepareStatement(qry);
            ps.setInt(1, status);
            ps.setInt(2, ub.getUserId());
            rs = ps.executeQuery();

            if (rs != null) {
                while (rs.next()) {
                    ab = new AdsBean();
                    ab.setTitle(rs.getString(1));
                    ab.setImage1(rs.getString(2));
                    ab.setDescription(rs.getString(3));
                    ab.setAddtionalContent(rs.getString(4));
                    ab.setAdId(rs.getInt(5));
                    ab.setPostedDate(new java.text.SimpleDateFormat("dd/MM/yyyy").format(rs.getTimestamp(6)));

                    ab.setFirstName(rs.getString(7));
                    ab.setPrice(rs.getFloat(8));
                    ab.setNeg(rs.getString(9));
                    ab.setCatId(rs.getInt(10));
                    ab.setEmail(rs.getString(11));
                    ab.setAdType(rs.getString(12));
                    ab.setAddress(rs.getString(13));
                    ab.setMobile(rs.getString(14));
                    //ab.setPh2(rs.getString(15));
                    ab.setCity(rs.getString(16));
                    ab.setCfp(rs.getString(17));
                    ab.setStatus(rs.getInt(18));
                    ab.setLocality(rs.getString(19));

                    al.add(ab);
                }

            }


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

        return al;
    }

    public MyAdDetailsBean setMyAdDetails(UserBean ub) {
        long st = System.currentTimeMillis();
        String qry = "SELECT COUNT(STATUS) FROM AD_T WHERE STATUS=? AND USER_ID=? AND SPONSORED_TYPE=1";
        String qry2 = "SELECT BALANCE_ADS FROM USER_T WHERE USER_ID=?";
        String qry3 = "SELECT AT_PREFF FROM DEALER_INFO_T WHERE DEALER_INFO_T.USER_ID=?";
        String qry4 = "SELECT COUNT(STATUS) FROM AD_T WHERE STATUS=? AND USER_ID=? AND SPONSORED_TYPE=2";
        MyAdDetailsBean madb = new MyAdDetailsBean();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = DbConnectionPool.getConnection();
            ps = con.prepareStatement(qry);
            ps.setInt(1, 1);
            ps.setInt(2, ub.getUserId());
            rs = ps.executeQuery();
            rs.next();
            madb.setActive(rs.getInt(1));
            /*===============================================================*/

            ps.setInt(1, 2);
            ps.setInt(2, ub.getUserId());
            rs = ps.executeQuery();
            rs.next();
            madb.setOnHold(rs.getInt(1));
            /*===============================================================*/
            ps.setInt(1, 4);
            ps.setInt(2, ub.getUserId());
            rs = ps.executeQuery();
            rs.next();
            madb.setExpired(rs.getInt(1));
            /*===============================================================*/
            ps.setInt(1, 5);
            ps.setInt(2, ub.getUserId());
            rs = ps.executeQuery();
            rs.next();
            madb.setDeleted(rs.getInt(1));
            /*===============================================================*/
            ps.setInt(1, 6);
            ps.setInt(2, ub.getUserId());
            rs = ps.executeQuery();
            rs.next();
            madb.setIncomplete(rs.getInt(1));
            /*===============================================================*/

            ps = con.prepareStatement(qry2);
            ps.setInt(1, ub.getUserId());
            rs = ps.executeQuery();
            rs.next();
            madb.setBalanceAds(rs.getInt(1));
            /*====================Karteek's Modfication Start===========================================*/

            ps = con.prepareStatement(qry3);
            ps.setInt(1, ub.getUserId());
            rs = ps.executeQuery();
            rs.next();
            madb.setPreffBal(rs.getInt(1));
            /*===============================================================*/


//            con = DbConnectionPool.getConnection();
            ps = con.prepareStatement(qry4);
            ps.setInt(1, 1);
            ps.setInt(2, ub.getUserId());
            rs = ps.executeQuery();
            rs.next();
            madb.setPreffActive(rs.getInt(1));
            /*===============================================================*/

            ps.setInt(1, 2);
            ps.setInt(2, ub.getUserId());
            rs = ps.executeQuery();
            rs.next();
            madb.setPreffOnHold(rs.getInt(1));
            /*===============================================================*/
            ps.setInt(1, 4);
            ps.setInt(2, ub.getUserId());
            rs = ps.executeQuery();
            rs.next();
            madb.setPreffExpired(rs.getInt(1));
            /*===============================================================*/
            ps.setInt(1, 5);
            ps.setInt(2, ub.getUserId());
            rs = ps.executeQuery();
            rs.next();
            madb.setPreffDeleted(rs.getInt(1));
            /*===============================================================*/
            ps.setInt(1, 6);
            ps.setInt(2, ub.getUserId());
            rs = ps.executeQuery();
            rs.next();
            madb.setPreffIncomplete(rs.getInt(1));
            /*======================Karteek's Modfication End=========================================*/


        } catch (Exception e) {
            e.printStackTrace();
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
            long et = System.currentTimeMillis();
            LOG.debug("= Time taken to complete db operation :: =" + (et - st) + " Milli Seconds");
        }

        return madb;

    }

    public AdsBean getMoreDetails(int adId) {
        long st = System.currentTimeMillis();
        AdsBean ab = new AdsBean();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        String qry = "SELECT TITLE, DESCRIPTION, IMAGE1, ADDITIONAL_CONTENT,COND, " +
                "COLOR, PRICE, MAX, MINI, NEGOTIABLE," +
                "CONTACT_PRICE, BRAND,MATERIAL, YEARS, OWNERSHIP," +
                "SP_OFFER,OFFER_FROM_DATE, OFFER_TO_DATE, AD_FIELDS.TYPE, NAME," +
                "MEASUREMENT, WEIGHT ,HEIGHT,NOTE, MODEL," +
                "REGNO,INSURANCE,KM_RUN , PET, BREED," +
                "OBJECTS, COLLECTABLES,QUALIFICATION,SKILL_SET ,  INDUSTARY," +
                "PREF_LOCATION,CURRENT_SALARY,EXPECTED_SALARY ,NOTICE_PERIOD ,AUTHOR," +
                "LANGUAGE, PUBLICATION, QUALITY_DIAMOND,RENT_MONTH,NO_BEDROOMS ," +
                "FLOOR_NUM ,TOTAL_NO_FLOORS,FACING, FURNISHED ,FACILITIES," +
                "AD_TYPE, COUNTRY, STATE,CITY, AREA," +
                "LOCALITY,ADDRESS_1,PINCODE, CATEGORY_ID, AD_T.STATUS , IMAGE2, IMAGE3 ,FIRST_NAME,LAST_NAME,PHONE,LOGIN_NAME,TOTAL_VISITORS,AD_T.VIDEO_URL,AD_T.SPONSORED_TYPE,AD_T.DEALER_LOGO,AD_T.CREATION_DATE,AD_T.USER_ID " +
                "FROM AD_T,AD_FIELDS,ADDRESS_T,USER_T,USER_LOGIN_T  " +
                "WHERE AD_T.AD_ID=AD_FIELDS.AD_ID  AND AD_FIELDS.ADD_ID=ADDRESS_T.ADDRESS_ID AND AD_T.USER_ID=USER_T.USER_ID AND AD_T.USER_ID=USER_LOGIN_T.USER_ID  AND AD_T.AD_ID=?";

        try {
            con = DbConnectionPool.getConnection();
            ps = con.prepareStatement(qry);
            ps.setInt(1, adId);
            rs = ps.executeQuery();


            if (rs != null && rs.next()) {

                ab.setAdId(adId);

                ab.setTitle(rs.getString(1));
                ab.setDescription(rs.getString(2));
                ab.setImage1(rs.getString(3));
                ab.setAddtionalContent(rs.getString(4));
                ab.setCondition(rs.getString(5));


                ab.setColor(rs.getString(6));
                ab.setPrice(rs.getFloat(7));
                ab.setMax(rs.getFloat(8));
                ab.setMin(rs.getFloat(9));
                ab.setNeg(rs.getString(10));

                ab.setCfp(rs.getString(11));
                ab.setBrand(rs.getString(12));
                ab.setMaterial(rs.getString(13));
                ab.setYearsOld(rs.getString(14));
                ab.setOwnership(rs.getString(15));

                ab.setSpecialOffer(rs.getString(16));
                ab.setSOFrom(rs.getString(17));
                ab.setSOTo(rs.getString(18));
                ab.setType(rs.getString(19));
                ab.setName(rs.getString(20));

                //"MEASUREMENT, WEIGHT ,HEIGHT,NOTE, MODEL,//REGNO,INSURANCE,KM_RUN , PET, BREED,OBJECTS, COLLECTABLES,QUALIFICATION,SKILL_SET ,  INDUSTARY,PREF_LOCATION,CURRENT_SALARY,EXPECTED_SALARY ,NOTICE_PERIOD ,AUTHOR, LANGUAGE, PUBLICATION, QUALITY_DIAMOND,RENT_MONTH,NO_BEDROOMS , FLOOR_NUM ,TOTAL_NO_FLOORS,FACING, FURNISHED ,FACILITIES,AD_TYPE, COUNTRY, STATE,CITY, AREA,LOCALITY,ADDRESS_1,PINCODE       " +

                ab.setMeasurement(rs.getString(21));
                ab.setWeight(rs.getInt(22));
                ab.setHeight(rs.getInt(23));
                ab.setNote(rs.getString(24));
                ab.setModel(rs.getString(25));

                //REGNO,INSURANCE,KM_RUN , PET, BREED,//OBJECTS, COLLECTABLES,QUALIFICATION,SKILL_SET ,  INDUSTARY,PREF_LOCATION,CURRENT_SALARY,EXPECTED_SALARY ,NOTICE_PERIOD ,AUTHOR, LANGUAGE, PUBLICATION, QUALITY_DIAMOND,RENT_MONTH,NO_BEDROOMS , FLOOR_NUM ,TOTAL_NO_FLOORS,FACING, FURNISHED ,FACILITIES,AD_TYPE, COUNTRY, STATE,CITY, AREA,LOCALITY,ADDRESS_1,PINCODE       " +

                ab.setRegNo(rs.getString(26));
                ab.setInsurance(rs.getString(27));
                ab.setKmRun(rs.getInt(28));
                ab.setPet(rs.getString(29));
                ab.setBreed(rs.getString(30));

                //OBJECTS, COLLECTABLES,QUALIFICATION,SKILL_SET ,  INDUSTARY,//PREF_LOCATION,CURRENT_SALARY,EXPECTED_SALARY ,NOTICE_PERIOD ,AUTHOR, LANGUAGE, PUBLICATION, QUALITY_DIAMOND,RENT_MONTH,NO_BEDROOMS , FLOOR_NUM ,TOTAL_NO_FLOORS,FACING, FURNISHED ,FACILITIES,AD_TYPE, COUNTRY, STATE,CITY, AREA,LOCALITY,ADDRESS_1,PINCODE       " +

                ab.setObjects(rs.getString(31));
                ab.setCollectables(rs.getString(32));
                ab.setQualification(rs.getString(33));
                ab.setSkillSet(rs.getString(34));
                ab.setIndustary(rs.getString(35));

                //PREF_LOCATION,CURRENT_SALARY,EXPECTED_SALARY ,NOTICE_PERIOD ,AUTHOR, //LANGUAGE, PUBLICATION, QUALITY_DIAMOND,RENT_MONTH,NO_BEDROOMS , FLOOR_NUM ,TOTAL_NO_FLOORS,FACING, FURNISHED ,FACILITIES,AD_TYPE, COUNTRY, STATE,CITY, AREA,LOCALITY,ADDRESS_1,PINCODE       " +

                ab.setPrefLocation(rs.getString(36));
                ab.setCurrentSalary(rs.getFloat(37));
                ab.setExpectedSalary(rs.getFloat(38));
                ab.setNoticePeriod(rs.getInt(39));
                ab.setAuthor(rs.getString(40));

                //LANGUAGE, PUBLICATION, QUALITY_DIAMOND,RENT_MONTH,NO_BEDROOMS ,// FLOOR_NUM ,TOTAL_NO_FLOORS,FACING, FURNISHED ,FACILITIES,AD_TYPE, COUNTRY, STATE,CITY, AREA,LOCALITY,ADDRESS_1,PINCODE       " +

                ab.setLanguage(rs.getString(41));
                ab.setPublication(rs.getString(42));
                ab.setQualityDiamond(rs.getString(43));
                ab.setRentMonth(rs.getInt(44));
                ab.setNoBedRooms(rs.getInt(45));

                // FLOOR_NUM ,TOTAL_NO_FLOORS,FACING, FURNISHED ,FACILITIES,//AD_TYPE, COUNTRY, STATE,CITY, AREA,LOCALITY,ADDRESS_1,PINCODE       " +

                ab.setFloorNum(rs.getInt(46));
                ab.setTotalFloors(rs.getInt(47));
                ab.setFacing(rs.getString(48));
                ab.setFurnished(rs.getString(49));
                ab.setFacilities(rs.getString(50));

                //AD_TYPE, COUNTRY, STATE,CITY, AREA,LOCALITY,ADDRESS_1,PINCODE       " +
                ab.setAdType(rs.getString(51));
                ab.setCountry(rs.getString(52));
                ab.setState(rs.getString(53));
                ab.setCity(rs.getString(54));
                ab.setArea(rs.getString(55));

                ab.setLocality(rs.getString(56));
                ab.setAddress(rs.getString(57));
                ab.setPinCode(rs.getString(58));
                ab.setCatId(rs.getInt(59));
                ab.setStatus(rs.getInt(60));
                ab.setImage2(rs.getString(61));
                ab.setImage3(rs.getString(62));
                //Footer Info from user_t, user_login_t
                ab.setFirstName(rs.getString(63));
                ab.setLastName(rs.getString(64));
                ab.setMobile(rs.getString(65));
                ab.setEmail(rs.getString(66));
                ab.setTotalVisitors(rs.getInt(67));
                ab.setVideoUrl(rs.getString(68));
                ab.setSponsType(rs.getInt(69));
                ab.setDlrLogo(rs.getString(70));
                ab.setPostedDate(new java.text.SimpleDateFormat("dd/MM/yyyy").format(rs.getTimestamp(71)));
                ab.setUserId(rs.getInt(72));

            }
            db.executeQuery("UPDATE AD_T SET TOTAL_VISITORS=TOTAL_VISITORS+1 WHERE AD_ID=" + adId);
            } catch (Exception e) {
            e.printStackTrace();
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
            long et = System.currentTimeMillis();
            LOG.debug("= Time taken to complete db operation for more details:: =" + (et - st) + " Milli Seconds");
        }

        return ab;

    }

    public AdsBean getAdDetailsForEdit(int adId) {
        long st = System.currentTimeMillis();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        AdsBean ab = new AdsBean();
        String qry = "SELECT TITLE, DESCRIPTION, IMAGE1, ADDITIONAL_CONTENT,COND, " +
                "COLOR, PRICE, MAX, MINI, NEGOTIABLE," +
                "CONTACT_PRICE, BRAND,MATERIAL, YEARS, OWNERSHIP," +
                "SP_OFFER,OFFER_FROM_DATE, OFFER_TO_DATE, TYPE, NAME," +
                "MEASUREMENT, WEIGHT ,HEIGHT,NOTE, MODEL," +
                "REGNO,INSURANCE,KM_RUN , PET, BREED," +
                "OBJECTS, COLLECTABLES,QUALIFICATION,SKILL_SET ,  INDUSTARY," +
                "PREF_LOCATION,CURRENT_SALARY,EXPECTED_SALARY ,NOTICE_PERIOD ,AUTHOR," +
                "LANGUAGE, PUBLICATION, QUALITY_DIAMOND,RENT_MONTH,NO_BEDROOMS ," +
                "FLOOR_NUM ,TOTAL_NO_FLOORS,FACING, FURNISHED ,FACILITIES," +
                "AD_TYPE, COUNTRY, STATE,CITY, AREA," +
                "LOCALITY,ADDRESS_1,PINCODE, CATEGORY_ID, STATUS , IMAGE2, IMAGE3,AD_T.USER_ID      " +
                "FROM AD_T,AD_FIELDS,ADDRESS_T  " +
                "WHERE AD_T.AD_ID=AD_FIELDS.AD_ID  AND AD_FIELDS.ADD_ID=ADDRESS_T.ADDRESS_ID AND AD_T.AD_ID=?";

        try {
            con = DbConnectionPool.getConnection();
            ps = con.prepareStatement(qry);
            ps.setInt(1, adId);
            rs = ps.executeQuery();

            if (rs != null && rs.next()) {
                ab.setAdId(adId);
                ab.setTitle(rs.getString(1));
                ab.setDescription(rs.getString(2));
                ab.setImage1(rs.getString(3));
                ab.setAddtionalContent(rs.getString(4));
                ab.setCondition(rs.getString(5));


                ab.setColor(rs.getString(6));
                ab.setPrice(rs.getFloat(7));
                ab.setMax(rs.getFloat(8));
                ab.setMin(rs.getFloat(9));
                ab.setNeg(rs.getString(10));

                ab.setCfp(rs.getString(11));
                ab.setBrand(rs.getString(12));
                ab.setMaterial(rs.getString(13));
                ab.setYearsOld(rs.getString(14));
                ab.setOwnership(rs.getString(15));

                ab.setSpecialOffer(rs.getString(16));
                ab.setSOFrom(rs.getString(17));
                ab.setSOTo(rs.getString(18));
                ab.setType(rs.getString(19));
                ab.setName(rs.getString(20));

                //"MEASUREMENT, WEIGHT ,HEIGHT,NOTE, MODEL,//REGNO,INSURANCE,KM_RUN , PET, BREED,OBJECTS, COLLECTABLES,QUALIFICATION,SKILL_SET ,  INDUSTARY,PREF_LOCATION,CURRENT_SALARY,EXPECTED_SALARY ,NOTICE_PERIOD ,AUTHOR, LANGUAGE, PUBLICATION, QUALITY_DIAMOND,RENT_MONTH,NO_BEDROOMS , FLOOR_NUM ,TOTAL_NO_FLOORS,FACING, FURNISHED ,FACILITIES,AD_TYPE, COUNTRY, STATE,CITY, AREA,LOCALITY,ADDRESS_1,PINCODE       " +

                ab.setMeasurement(rs.getString(21));
                ab.setWeight(rs.getInt(22));
                ab.setHeight(rs.getInt(23));
                ab.setNote(rs.getString(24));
                ab.setModel(rs.getString(25));

                //REGNO,INSURANCE,KM_RUN , PET, BREED,//OBJECTS, COLLECTABLES,QUALIFICATION,SKILL_SET ,  INDUSTARY,PREF_LOCATION,CURRENT_SALARY,EXPECTED_SALARY ,NOTICE_PERIOD ,AUTHOR, LANGUAGE, PUBLICATION, QUALITY_DIAMOND,RENT_MONTH,NO_BEDROOMS , FLOOR_NUM ,TOTAL_NO_FLOORS,FACING, FURNISHED ,FACILITIES,AD_TYPE, COUNTRY, STATE,CITY, AREA,LOCALITY,ADDRESS_1,PINCODE       " +

                ab.setRegNo(rs.getString(26));
                ab.setInsurance(rs.getString(27));
                ab.setKmRun(rs.getInt(28));
                ab.setPet(rs.getString(29));
                ab.setBreed(rs.getString(30));

                //OBJECTS, COLLECTABLES,QUALIFICATION,SKILL_SET ,  INDUSTARY,//PREF_LOCATION,CURRENT_SALARY,EXPECTED_SALARY ,NOTICE_PERIOD ,AUTHOR, LANGUAGE, PUBLICATION, QUALITY_DIAMOND,RENT_MONTH,NO_BEDROOMS , FLOOR_NUM ,TOTAL_NO_FLOORS,FACING, FURNISHED ,FACILITIES,AD_TYPE, COUNTRY, STATE,CITY, AREA,LOCALITY,ADDRESS_1,PINCODE       " +

                ab.setObjects(rs.getString(31));
                ab.setCollectables(rs.getString(32));
                ab.setQualification(rs.getString(33));
                ab.setSkillSet(rs.getString(34));
                ab.setIndustary(rs.getString(35));

                //PREF_LOCATION,CURRENT_SALARY,EXPECTED_SALARY ,NOTICE_PERIOD ,AUTHOR, //LANGUAGE, PUBLICATION, QUALITY_DIAMOND,RENT_MONTH,NO_BEDROOMS , FLOOR_NUM ,TOTAL_NO_FLOORS,FACING, FURNISHED ,FACILITIES,AD_TYPE, COUNTRY, STATE,CITY, AREA,LOCALITY,ADDRESS_1,PINCODE       " +

                ab.setPrefLocation(rs.getString(36));
                ab.setCurrentSalary(rs.getFloat(37));
                ab.setExpectedSalary(rs.getFloat(38));
                ab.setNoticePeriod(rs.getInt(39));
                ab.setAuthor(rs.getString(40));

                //LANGUAGE, PUBLICATION, QUALITY_DIAMOND,RENT_MONTH,NO_BEDROOMS ,// FLOOR_NUM ,TOTAL_NO_FLOORS,FACING, FURNISHED ,FACILITIES,AD_TYPE, COUNTRY, STATE,CITY, AREA,LOCALITY,ADDRESS_1,PINCODE       " +

                ab.setLanguage(rs.getString(41));
                ab.setPublication(rs.getString(42));
                ab.setQualityDiamond(rs.getString(43));
                ab.setRentMonth(rs.getInt(44));
                ab.setNoBedRooms(rs.getInt(45));

                // FLOOR_NUM ,TOTAL_NO_FLOORS,FACING, FURNISHED ,FACILITIES,//AD_TYPE, COUNTRY, STATE,CITY, AREA,LOCALITY,ADDRESS_1,PINCODE       " +

                ab.setFloorNum(rs.getInt(46));
                ab.setTotalFloors(rs.getInt(47));
                ab.setFacing(rs.getString(48));
                ab.setFurnished(rs.getString(49));
                ab.setFacilities(rs.getString(50));

                //AD_TYPE, COUNTRY, STATE,CITY, AREA,LOCALITY,ADDRESS_1,PINCODE       " +
                ab.setAdType(rs.getString(51));
                ab.setCountry(rs.getString(52));
                ab.setState(rs.getString(53));
                ab.setCity(rs.getString(54));
                ab.setArea(rs.getString(55));

                ab.setLocality(rs.getString(56));
                ab.setAddress(rs.getString(57));
                ab.setPinCode(rs.getString(58));
                ab.setCatId(rs.getInt(59));
                ab.setStatus(rs.getInt(60));
                ab.setImage2(rs.getString(61));
                ab.setImage3(rs.getString(62));

                ab.setUserId(rs.getInt(63));


            }

        } catch (Exception e) {
            e.printStackTrace();
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
            long et = System.currentTimeMillis();
            LOG.debug("= Time taken to complete db operation geting ads for edit:: =" + (et - st) + " Milli Seconds");
        }

        return ab;

    }

    public UserProfileBean populateUserProfileBean(UserBean ub) {
        String qry = "select DATE_OF_BIRTH,FIRST_NAME,LAST_NAME,COUNTRY,STATE,CITY,AREA,LOCALITY,ADDRESS_1,PHONE,PINCODE,OCCUPATION,GENDER  from USER_LOGIN_T, USER_T, ADDRESS_T  WHERE USER_LOGIN_T.USER_ID=USER_T.USER_ID AND USER_T.ADDRESS_ID =ADDRESS_T.ADDRESS_ID AND USER_T.USER_ID=?";
        UserProfileBean upb = new UserProfileBean();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = DbConnectionPool.getConnection();
            ps = con.prepareStatement(qry);
            ps.setInt(1, ub.getUserId());
            rs = ps.executeQuery();

            if (rs != null && rs.next()) {
                upb.setFirstName(rs.getString(2));
                upb.setLastName(rs.getString(3));
                upb.setCountry(rs.getString(4));
                upb.setState(rs.getString(5));
                upb.setCity(rs.getString(6));
                upb.setArea(rs.getString(7));
                upb.setLocation(rs.getString(8));
                upb.setAddress(rs.getString(9));
                upb.setMobile(rs.getString(10));
                upb.setPinCode(rs.getString(11));
                upb.setOccupation(rs.getString(12));
                upb.setGender(rs.getString(13));

                java.sql.Timestamp mysqlTimestamp = rs.getTimestamp(1);
                upb.setDate(new java.text.SimpleDateFormat("dd").format(mysqlTimestamp));
                upb.setMonth(new java.text.SimpleDateFormat("MM").format(mysqlTimestamp));
                upb.setYear(new java.text.SimpleDateFormat("yyyy").format(mysqlTimestamp));
            }

        } catch (Exception e) {
            e.printStackTrace();

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

        return upb;
    }

// this method used to get the scoll ads list
  /* DESC SCROLL_ADS_T;

     * +-------------+--------------+------+-----+---------+----------------+
    | Field       | Type         | Null | Key | Default | Extra          |
    +-------------+--------------+------+-----+---------+----------------+
    | S_ID        | int(4)       | NO   | PRI | NULL    | auto_increment |
    | SCR_TITLE   | varchar(100) | YES  |     | NULL    |                |
    | IMG1        | varchar(20)  | YES  |     | NULL    |                |
    | IMG2        | varchar(20)  | YES  |     | NULL    |                |
    | 1MG3        | varchar(20)  | YES  |     | NULL    |                |
    | DESCRIPTION | varchar(250) | YES  |     | NULL    |                |
    | DEALER_ID   | int(11)      | YES  |     | NULL    |                |
    | STATUS      | int(11)      | YES  |     | NULL    |                |
    | S_DATE      | datetime     | YES  |     | NULL    |                |
    | E_DATE      | datetime     | YES  |     | NULL    |                |
    +-------------+--------------+------+-----+---------+----------------+
     *
     */
    public List getCurrentOffers(int sid) {
        long st = System.currentTimeMillis();
        ArrayList al = new ArrayList();
        ScrAdsBean sab = new ScrAdsBean();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            String qry = "SELECT SCR_TITLE,THUMB_IMG,IMG1,DEALER_INFO_T.DEALER_ID,S_DATE,E_DATE,DOMAIN_NAME,DLOGO_PATH,ADDRESS_1,OFFER_CITY,LIST_PRICE,OFFER_PRICE,DESCRIPTION,CATEGORY_ID  FROM SCROLL_ADS_T,DEALER_INFO_T,ADDRESS_T WHERE DEALER_INFO_T.DEALER_ID=SCROLL_ADS_T.DEALER_ID AND DEALER_INFO_T.ADD_ID=ADDRESS_T.ADDRESS_ID AND S_ID=?";
            con = DbConnectionPool.getConnection();
            ps = con.prepareStatement(qry);
            ps.setInt(1, sid);
            rs = ps.executeQuery();
            if (rs != null) {
                if (rs.next()) {

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
                    sab.setCategoryId(rs.getInt(14));
                    al.add(sab);
                }

            }
        } catch (Exception e) {
            LOG.error("== Error occured ==" + e);
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
            long et = System.currentTimeMillis();
            LOG.debug("= Time taken to complete db operation  scroll ads:: =" + (et - st) + " Milli Seconds");
        }

        return al;
    }

    public List getScrollfferImg(int sid) {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        ArrayList al = new ArrayList();
        ScrAdsBean sab = new ScrAdsBean();
        String qry = "SELECT IMG1,IMG2,IMG3,IMG4,IMG5,IMG6,IMG7,IMG8,IMG9,URL FROM SCROLL_ADS_T WHERE S_ID=?";
        try {
            con = DbConnectionPool.getConnection();
            ps = con.prepareStatement(qry);
            ps.setInt(1, sid);
            rs = ps.executeQuery();
            if (rs != null) {
                if (rs.next()) {
                    sab.setImg1(rs.getString(1));
                    sab.setImg2(rs.getString(2));
                    sab.setImg3(rs.getString(3));
                    sab.setImg4(rs.getString(4));
                    sab.setImg5(rs.getString(5));
                    sab.setImg6(rs.getString(6));
                    sab.setImg7(rs.getString(7));
                    sab.setImg8(rs.getString(8));
                    sab.setImg9(rs.getString(9));
                    sab.setUrl(rs.getString(10));
                    al.add(sab);
                }
            }
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

        return al;
    }

    // this for getting all scroll ads
//    public ArrayList getScrollAdsList(HttpServletRequest request) {
//        long st = System.currentTimeMillis();
//        alr = new ArrayList();
//
//        try {
//            String qry = "SELECT S_ID,SCR_TITLE,IMG1 FROM SCROLL_ADS_T";
//            con = DbConnectionPool.getConnection();
//            ps = con.prepareStatement(qry);
//
//            rs = ps.executeQuery();
//            if (rs != null) {
//
//                while (rs.next()) {
//                    ScrAdsBean sab = new ScrAdsBean();
//                    sab.setSid(rs.getInt(1));
//                    sab.setScrTitle(rs.getString(2));
//                    sab.setImg1(rs.getString(3));
//                    alr.add(sab);
//                }
//
//            }
//        } catch (Exception e) {
//            LOG.info("== Error occured ==" + e);
//        } finally {
//            try {
//                rs.close();
//                ps.close();
//                DbConnectionPool.closeConnection(con);
//                long et = System.currentTimeMillis();
//                LOG.debug("= Time taken to complete db operation for getting all scroll ads:: =" + (et - st) + " Milli Seconds");
//
//            } catch (Exception e) {
//                LOG.error("= Exception Occured in closing db connections ::=" + e);
//            }
//        }
//
//        return alr;
//    }
    public int getSaveSearchCount(String string) {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        int msg = 0;
        try {
            con = DbConnectionPool.getConnection();
            ps = con.prepareStatement(string);
            rs = ps.executeQuery();
            if (rs != null) {
                if (rs.next()) {
                    msg = rs.getInt(1);
                }
            }

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

        return msg;

    }

    public int setUserPoints(int uid) {
        String qry = "SELECT USER_BID_POINTS FROM USER_T WHERE USER_ID=?";
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        int msg = 0;
        try {
            con = DbConnectionPool.getConnection();
            ps = con.prepareStatement(qry);
            ps.setInt(1, uid);
            rs = ps.executeQuery();
            if (rs != null) {
                if (rs.next()) {
                    msg = rs.getInt(1);
                }
            }
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

        return msg;

    }

    //Karteek Starts
    public HashMap getUserAdsCountDeatils(int uid) {

        HashMap hm = new HashMap();
        int totalVisitorsCount = 0;

        StringBuffer sb = new StringBuffer("SELECT STATUS,SUM(TOTAL_VISITORS) FROM AD_T WHERE USER_ID=? GROUP BY STATUS");
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = DbConnectionPool.getConnection();
            ps = con.prepareStatement(sb.toString());
            ps.setInt(1, uid);
            rs = ps.executeQuery();
            if (rs != null) {
                while (rs.next()) {
                    hm.put(rs.getInt(1), rs.getInt(2));
                    totalVisitorsCount += rs.getInt(2);
                }
                hm.put("All", totalVisitorsCount);
            }
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
        return hm;
    }




       public ArrayList getSpecificPreffAdsList(UserBean ub, int status) {
        String qry = "SELECT TITLE,IMAGE1,DESCRIPTION,ADDITIONAL_CONTENT, AD_T.AD_ID, AD_T.CREATION_DATE, FIRST_NAME,PRICE,NEGOTIABLE,CATEGORY_ID,LOGIN_NAME,AD_TYPE,ADDRESS_1,PHONE,MOBILE_CODE,CITY,CONTACT_PRICE,AD_T.STATUS,LOCALITY from AD_FIELDS,AD_T,USER_T,USER_LOGIN_T,ADDRESS_T WHERE ADDRESS_T.ADDRESS_ID=AD_FIELDS.ADD_ID AND USER_T.USER_ID=USER_LOGIN_T.USER_ID AND AD_T.USER_ID=USER_T.USER_ID AND AD_T.STATUS=? AND AD_FIELDS.AD_ID=AD_T.AD_ID  AND AD_T.USER_ID=? AND SPONSORED_TYPE=2 ORDER BY AD_ID DESC";
        ArrayList al = new ArrayList();
        AdsBean ab = new AdsBean();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = DbConnectionPool.getConnection();
            ps = con.prepareStatement(qry);
            ps.setInt(1, status);
            ps.setInt(2, ub.getUserId());
            rs = ps.executeQuery();

            if (rs != null) {
                while (rs.next()) {
                    ab = new AdsBean();
                    ab.setTitle(rs.getString(1));
                    ab.setImage1(rs.getString(2));
                    ab.setDescription(rs.getString(3));
                    ab.setAddtionalContent(rs.getString(4));
                    ab.setAdId(rs.getInt(5));
                    ab.setPostedDate(new java.text.SimpleDateFormat("dd/MM/yyyy").format(rs.getTimestamp(6)));

                    ab.setFirstName(rs.getString(7));
                    ab.setPrice(rs.getFloat(8));
                    ab.setNeg(rs.getString(9));
                    ab.setCatId(rs.getInt(10));
                    ab.setEmail(rs.getString(11));
                    ab.setAdType(rs.getString(12));
                    ab.setAddress(rs.getString(13));
                    ab.setMobile(rs.getString(14));
                    //ab.setPh2(rs.getString(15));
                    ab.setCity(rs.getString(16));
                    ab.setCfp(rs.getString(17));
                    ab.setStatus(rs.getInt(18));
                    ab.setLocality(rs.getString(19));

                    al.add(ab);
                }

            }


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

        return al;
    }

//    Karteek ENDS
}


