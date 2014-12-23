/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.buysell.servlets;

import com.buysell.beans.AdsBean;
import com.buysell.db.DbConnection;
import com.buysell.db.DbConnectionPool;
import com.buysell.util.BuySellProperties;
import com.buysell.util.CategoryUtil;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.StringTokenizer;
import org.apache.log4j.Logger;

/**
 *
 * @author bbsadmin
 */
public class SponsoredAdsThread extends Thread {

    private static Logger LOG = Logger.getLogger(SponsoredAdsThread.class);
    static boolean flag = true; //in our controller destry method set the flag = false
    private int tad;   // total count of sponsered adds available in db for the given condition(date range)
    private long minAdId; //minimum ad id of sponsered ads available in db for the given condition(date range)
    private long maxAdId; //maximum ad id of sponsered ads available in db for the given condition(date range)
    private static int ladsc = BuySellProperties.getProperty("sponsAdsMemMax") != null ? Integer.parseInt(BuySellProperties.getProperty("sponsAdsMemMax")) : 500; // number of adds we need to load in to memory
    private int sAdsRange = BuySellProperties.getProperty("sponsAdsRange") != null ? Integer.parseInt(BuySellProperties.getProperty("sponsAdsRange")) : 60;
    static List<HashMap> sAdsList = new ArrayList();// this list will contains all the sponsered ads from db with max size of "ladsc" value
    static HashMap<String, HashMap<Integer, HashMap>> ccm = new HashMap();
    static Object sAdsListMonitor = new Object();
    DbConnection dbc = new DbConnection();
    static CategoryUtil cu = new CategoryUtil();
    static String qry1 = "SELECT TITLE,IMAGE1,DESCRIPTION,ADDITIONAL_CONTENT, AD_T.AD_ID, AD_T.CREATION_DATE, FIRST_NAME,PRICE,NEGOTIABLE,CATEGORY_ID,LOGIN_NAME," +
            "AD_TYPE,ADDRESS_1,MINI,MAX,CITY,CONTACT_PRICE,AD_T.USER_ID,PHONE,LOCALITY,AD_T.TAGS,RENT_MONTH,AD_T.DEALER_LOGO,AD_T.SPONSORED_TYPE from AD_FIELDS,AD_T,USER_T,USER_LOGIN_T,ADDRESS_T " +
            "WHERE ADDRESS_T.ADDRESS_ID=AD_FIELDS.ADD_ID AND USER_T.USER_ID=USER_LOGIN_T.USER_ID AND AD_T.USER_ID=USER_T.USER_ID AND AD_FIELDS.AD_ID=AD_T.AD_ID  AND AD_T.STATUS=1 " +
            "AND AD_T.SPONSORED_TYPE IN(3,2) ";

    public SponsoredAdsThread() {
        populateMinMaxAdIds();
        init();
        setDaemon(true);
    }

    private void populateMinMaxAdIds() {
        int res[] = dbc.getSponsoredAdsRange(sAdsRange);
        minAdId = res[0];
        maxAdId = res[1];
        tad = res[2];
    }

    private void init() {
        long initStTm = System.currentTimeMillis();
        int salSize = sAdsList.size();
        // 1. Load sAdsList list with  (ladsc-i) number of adds from DB in adId range of minAdId and maxAdId where add is sponsered ad and adId assce order.
        // 2. update minAdId with max addid from query resultset.

        HashMap thm = new HashMap();
        ccm.put("All India", thm);
        String qry2 = " AND AD_T.AD_ID BETWEEN " + minAdId + " AND " + maxAdId + " ORDER BY AD_T.AD_ID  LIMIT 0," + ladsc + "";
        String qry = qry1 + qry2;

        populateSpAds(qry);

        long initEnTm = System.currentTimeMillis();
        LOG.debug("Time taken for loading init method and adding " + (sAdsList.size() - salSize) + " ads to sAdsList is " + (initEnTm - initStTm));
    }

    @Override
    public void run() {
        LOG.info("Starting SponsoredAds Thread ...");
        while (flag) {
            synchronized (sAdsListMonitor) {
                try {
                    sAdsListMonitor.wait();
                } catch (Exception e) {
                    LOG.error("Error occurred in waiting sAdsListMonitor " + e);
                }
            }
        }
    }

    private void reloadMethods() {
        if (minAdId >= maxAdId) {
            populateMinMaxAdIds();
        }
        init();
    }

    public static List getCitySponsoredAds(int num, String city) {
        return getCatCitySponsoredAds(num, 0, city);
    }

    public static List getCatCitySponsoredAds(int num, int ctgid, String city) {
        ArrayList sal = new ArrayList();
        if (ccm.containsKey(city)) {
            HashMap<Integer, HashMap> clfm = ccm.get(city);
            HashMap hm = new HashMap();
            if (clfm.containsKey(ctgid)) {
                hm = clfm.get(ctgid);
                List<AdsBean> l = new ArrayList<AdsBean>();
                if (hm.containsKey("adsList")) {
                    l = (List) hm.get("adsList");
                }
                if (l.size() == 0 || l.get(0) == null) {
                    long id = 0;
                    if (hm.containsKey("maxClfAdId")) {
                        id = (Long) hm.get("maxClfAdId");
                    }
                    reloadSpAds(ctgid, city, id);
                    if (hm.containsKey("adsList")) {
                        l = (List) hm.get("adsList");
                    }
                    if (l.size() == 0 || l.get(0) == null) {
                        if (hm.get("dispAdsList") != null) {
                            List disp = (List) hm.get("dispAdsList");
                            for (int i = 0; i < num; i++) {
                                if (disp.size() > 0 && disp.get(0) != null) {
                                    AdsBean ab = (AdsBean) disp.get(0);
                                    sal.add(ab);
                                    disp.remove(0);
                                }
                            }
                        }
                    }
                }
                for (int i = 0; i < num; i++) {
                    if (l.size() > 0 && l.get(0) != null) {
                        AdsBean ab = l.get(0);
                        sal.add(ab);
                        l.remove(0);
                    }
                }
                if (sal.size() > 0) {
                    List dl = new ArrayList();
                    if (hm.containsKey("dispAdsList")) {
                        dl = (List) hm.get("dispAdsList");
                    }
                    dl.addAll(sal);
                    hm.put("dispAdsList", dl);
                    clfm.put(ctgid, hm);
                    ccm.put(city, clfm);
                }
            } else {
                reloadSpAds(ctgid, city, 0);
            }
        } else {
            reloadSpAds(ctgid, city, 0);
        }
        return sal;
    }

    private static void insertCityClassifiedSpAds(int cid, String city, AdsBean ab) {
        if (ccm.containsKey(city)) {
            HashMap<Integer, HashMap> clfhm = ccm.get(city);
            HashMap hm = new HashMap();
            if (clfhm.containsKey(cid)) {
                hm = clfhm.get(cid);
                List l = new ArrayList();
                if (hm.containsKey("adsList")) {
                    l = (List) hm.get("adsList");
                }
                l.add(ab);
                hm.put("adsList", l);
            } else {
                List l = new ArrayList();
                l.add(ab);
                hm.put("adsList", l);
                hm.put("dispAdsList", new ArrayList());
            }
            hm.put("maxClfAdId", ab.getAdId());
            clfhm.put(cid, hm);
            ccm.put(city, clfhm);
        } else {
            HashMap<Integer, HashMap> clfhm = new HashMap();
            HashMap hm = new HashMap();
            List l = new ArrayList();
            l.add(ab);
            hm.put("adsList", l);
            hm.put("dispAdsList", new ArrayList());
            hm.put("maxClfAdId", ab.getAdId());
            clfhm.put(cid, hm);
            ccm.put(city, clfhm);
        }
    }

    private static void reloadSpAds(int clfid, String city, long adId) {
        StringBuffer sb = new StringBuffer();
        sb.append(qry1);
        if (clfid > 0) {
            if (cu.getRootCatId(cu.getRootCatId(clfid)) == 0) {
                sb.append(" AND AD_T.CATEGORY_ID IN (");
                ArrayList<Integer> cl = cu.getClfCatIdsWithSubCatId(clfid);
                for (int i = 0; i < cl.size(); i++) {
                    sb.append(cl.get(i) + ",");
                }
                if (cl.size() > 0) {
                    sb.deleteCharAt(sb.length() - 1);
                }
                sb.append(") ");
            } else {
                sb.append(" AND AD_T.CATEGORY_ID IN (").append(clfid).append(") ");
            }
        }
        if (city != null && city.trim().length() > 0) {
            sb.append("AND CITY = '").append(city).append("' ");
        }
        sb.append("AND AD_T.AD_ID > " + adId + " ORDER BY AD_T.AD_ID  LIMIT 0," + ladsc);
        populateSpAds(sb.toString());
        boolean fl = false;
        if (sAdsList.size() > 0) {
            for (int i = 0; i < sAdsList.size(); i++) {
                if (sAdsList.get(i).containsKey("query")) {
                    if (sb.toString().equalsIgnoreCase((String) sAdsList.get(i).get("query"))) {
                        fl = true;
                    }
                }
            }
        }
        if (!fl) {
            HashMap hm = new HashMap();
            hm.put("query", sb.toString());
            hm.put("ref", city + "^" + clfid);
            hm.put("lpt", System.currentTimeMillis());
            sAdsList.add(hm);
        }
    }

    private static void populateSpAds(String qry) {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        AdsBean ab = new AdsBean();

        try {
            con = DbConnectionPool.getConnection();
            ps = con.prepareStatement(qry);
            rs = ps.executeQuery();

            if (rs != null) {
                int rscount=0;
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
                    int cid = ab.getCatId();
                    int scid = cu.getRootCatId(cid);
                    insertCityClassifiedSpAds(cid, ab.getCity(), ab);
                    insertCityClassifiedSpAds(cid, "All India", ab);
                    insertCityClassifiedSpAds(scid, ab.getCity(), ab);
                    insertCityClassifiedSpAds(scid, "All India", ab);
                    insertCityClassifiedSpAds(0, ab.getCity(), ab);
                    insertCityClassifiedSpAds(0, "All India", ab);
                    rscount=rs.getRow();
                }
                LOG.debug(rscount+" sponsored ads are populated");
            } else {
                LOG.debug("No sponsored ads are populated");
            }
        } catch (Exception e) {
            LOG.error("= Exception Occured in  ::= " + e);
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
        }
    }
}

