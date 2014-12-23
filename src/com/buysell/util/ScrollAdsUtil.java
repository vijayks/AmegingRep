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
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import org.apache.log4j.Logger;

/**
 *
 * @author bbsadmin
 */
public class ScrollAdsUtil {

    public static List scrollAds;
    private String qry;
    Connection con;
    PreparedStatement ps;
    Statement sto;
    ResultSet rs;
    private static final Logger LOG = Logger.getLogger(ScrollAdsUtil.class);
    public static boolean threadRun = true;
    long sleepTime = Long.parseLong(BuySellProperties.getProperty("scrollAds.thread.sleepTime"));

    public ScrollAdsUtil() {
//        ScrollAdsThread sct = new ScrollAdsThread();
//        sct.setDaemon(true);
//        sct.start();
    }

    public List getScrollAds(String city) {
        scrollAds = new ArrayList();
        populateScrollAds(city);
        return scrollAds;
    }

    public void setScrollAds(List scrollAds) {
        ScrollAdsUtil.scrollAds = scrollAds;
    }

    private void populateScrollAds(String city) {
        LOG.debug("Calling Scroll ads....");
        long st = System.currentTimeMillis();
        try {
            con = DbConnectionPool.getConnection();
            if (city != null && city.equals("All India")) {
                qry = "SELECT S_ID,SCR_TITLE,THUMB_IMG,URL FROM SCROLL_ADS_T WHERE OFFER_TYPE='special' AND STATUS=1";

                sto = con.createStatement();
                rs = sto.executeQuery(qry);

            } else {
                // the above line is uncommented when we dealing with city...
                // qry = "SELECT S_ID,SCR_TITLE,THUMB_IMG,URL FROM SCROLL_ADS_T WHERE OFFER_TYPE='special' AND STATUS=1 AND OFFER_CITY='"+city+"'";

                qry = "SELECT S_ID,SCR_TITLE,THUMB_IMG,URL FROM SCROLL_ADS_T WHERE OFFER_TYPE='special' AND STATUS=1";
                sto = con.createStatement();
                rs = sto.executeQuery(qry);
            }
            if (rs != null) {
                while (rs.next()) {
                    ScrAdsBean sab = new ScrAdsBean();
                    sab.setSid(rs.getInt(1));
                    sab.setScrTitle(rs.getString(2));
                    sab.setThumbImg(rs.getString(3));
                    sab.setUrl(rs.getString(4));
                    scrollAds.add(sab);
                }
            }
        } catch (Exception e) {
            LOG.error("== Error occured ==" + e);
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (sto != null) {
                    sto.close();
                }
                if (con != null) {
                    DbConnectionPool.closeConnection(con);
                }
                long et = System.currentTimeMillis();
                LOG.debug("= Time taken to complete db operation for getting all scroll ads:: =" + (et - st) + " Milli Seconds");

            } catch (Exception e) {
                LOG.error("= Exception Occured in closing db connections ::=" + e);
            }
        }
    }
//    private class ScrollAdsThread extends Thread {
//
//        @Override
//        public void run() {
//            while (threadRun) {
//                if (scrollAds != null) {
//                    synchronized (scrollAds) {
//                        scrollAds.clear();
//                        // populateScrollAds();
//                    }
//                }
//                try {
//                    sleep(sleepTime);
//                } catch (InterruptedException ie) {
//                    LOG.error(" Exception while sleeping " + ie);
//                }
//            }
//
//
//        }
//    }
}

