/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.buysell.siteAdds;

import com.buysell.db.DbConnectionPool;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import org.apache.log4j.Logger;

/**
 *
 * @author bbsadmin
 */
public class SiteAdsList {

    private static Logger LOG = Logger.getLogger(SiteAdsList.class);

    public List AdsList() {
        Connection con = DbConnectionPool.getConnection();
        Statement stmt = null;
        ResultSet rs = null;
        List ads = new ArrayList();
        try {
            if (con != null) {
                stmt = con.createStatement();
                rs = stmt.executeQuery("SELECT S_AD_TYPE,S_AD_ID,S_PLACE,S_DURATION,S_IMAGE,S_URL,S_PAGE,S_CITIES FROM SITE_ADS_T");
                while (rs.next()) {
                    SiteAdd sa = new SiteAdd();
                    sa.setId(rs.getLong("S_AD_ID"));
                    sa.setCities(rs.getString("S_CITIES"));
                    sa.setDuration(rs.getInt("S_DURATION"));
                    sa.setImg(rs.getString("S_IMAGE"));
                    sa.setPage(rs.getInt("S_PAGE"));
                    sa.setSPlace(rs.getInt("S_PLACE"));
                    sa.setUrl(rs.getString("S_URL"));
                    sa.setType(rs.getInt("S_AD_TYPE"));
                    ads.add(sa);
                }
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
                    LOG.error("= Exception Occured in SiteAdsList closing db connections ::=" + e);
                }
            }
        
           LOG.info("== Ads list method completed ==");
            return ads;
    }
}
