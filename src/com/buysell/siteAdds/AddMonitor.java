/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.buysell.siteAdds;

import com.buysell.db.DbConnectionPool;
import com.buysell.util.BuySellProperties;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Vector;
import org.apache.log4j.Logger;

/**
 *
 * @author bbsadmin
 */
public class AddMonitor {

    static AddMonitor am = null;
    static boolean running = false;
    static Vector imm = new Vector();
    static Vector cu = new Vector();
    static Vector ad = new Vector();
    String sleepTime = BuySellProperties.getProperty("add-loader-sleep-time");
    String loadAdds = BuySellProperties.getProperty("add-monitor-populate-number");
    int num;
    int sleep;
    private static Logger LOG = Logger.getLogger(AddMonitor.class);

    public static Vector getAdds() {
        LOG.info("== GetAds method called size is ==" + ad.size());
        return new Vector(ad.subList(0, ad.size()));

    }

    public static Vector getCurrAdds() {
        LOG.info("==Get currentads method called size is :: ==" + cu.size());

        return new Vector(cu.subList(0, cu.size()));
    }

    public static Vector getImmidAdds() {
        LOG.info("==Get getImmidAdds method called size is :: ==" + imm.size());
        return new Vector(imm.subList(0, imm.size()));
    }

    public static void startMonitor() {
        if (am == null) {
            am = new AddMonitor();
        }
    }

    private AddMonitor() {
        try {
            sleep = Integer.parseInt(sleepTime);
        } catch (NumberFormatException n) {
            LOG.error("Please configure proper number to add-loader-sleep-time" + n);
            sleep = 45000;
        }
        try {
            num = Integer.parseInt(loadAdds);
        } catch (NumberFormatException n) {
            LOG.error("Please configure proper number to add-monitor-populate-number" + n);
            num = 25;
        }
        running = true;
        AddLoader al = new AddLoader();
        al.setDaemon(true);
        al.start();
    }

    private void loadAdds() {
        Connection con = DbConnectionPool.getConnection();
        Statement stmt = null;
        ResultSet rs = null;
        List lm = new ArrayList();
        List la = new ArrayList();
        List lc = new ArrayList();
        try {
            if (con != null) {
                stmt = con.createStatement();
                rs = stmt.executeQuery("SELECT S_AD_TYPE,S_AD_ID,S_PLACE,S_DURATION,S_IMAGE,S_URL,S_PAGE,S_CITIES FROM SITE_ADS_T");
                LOG.info("==Excute query ==");

                while (rs.next()) {
                    LOG.info("== Inside while loop ==");

                    SiteAdd sa = new SiteAdd();
                    sa.setId(rs.getLong("S_AD_ID"));
                    sa.setCities(rs.getString("S_CITIES"));
                    sa.setDuration(rs.getInt("S_DURATION"));
                    sa.setImg(rs.getString("S_IMAGE"));
                    sa.setPage(rs.getInt("S_PAGE"));
                    sa.setSPlace(rs.getInt("S_PLACE"));
                    sa.setUrl(rs.getString("S_URL"));
                    sa.setType(rs.getInt("S_AD_TYPE"));
                    la.add(sa);

                }
                LOG.info("==lenght ==" + la.size());

            }
        } catch (SQLException sq) {
            LOG.error("Exception while populating adds " + sq);
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (stmt != null) {
                    stmt.close();
                }
                if (con != null) {
                    DbConnectionPool.closeConnection(con);
                }
            } catch (Exception e) {
                LOG.error("Exception while populating adds closing connection" + e);
            }
        }
        imm.clear();
        imm.addAll(la);
        cu.clear();
        cu.addAll(la);
        ad.clear();
        ad.addAll(la);
        LOG.info("Refreshed all adds");
    }

    private class AddLoader extends Thread {

        @Override
        public void run() {
            LOG.info(" Starting AddLoader Thread ....");
            while (running) {
                LOG.info("Loading the adds from DB ...");
                loadAdds();
                try {
                    sleep(sleep);
                } catch (InterruptedException inte) {
                    LOG.error("Exception while sleeping " + inte);
                }

            }
            LOG.info("Stoping AddLoader Thread ");
        }
    }

    public static void stopAll() {
        running = false;
    }
}
