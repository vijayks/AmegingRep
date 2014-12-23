/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.buysell.util;

import com.buysell.db.DbConnectionPool;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.HashMap;
import org.apache.log4j.Logger;

/**
 *
 * @author bbsadmin
 */
public class UrlPointsUtil {

    static HashMap<String, Integer> hm = new HashMap();
    private static Logger LOG = Logger.getLogger(UrlPointsUtil.class);
    private static final String qry = "select URL,BBS_POINTS from URL_POINTS_T";

    public UrlPointsUtil() {
        if(hm.isEmpty())
            populateUrlPoints();
    }

    public static HashMap getUrlPoints() {
        return hm;
    }

    public void populateUrlPoints() {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        hm = new HashMap();
        try {
            con = DbConnectionPool.getConnection();
            ps = con.prepareStatement(qry);
            rs = ps.executeQuery();
            if (rs != null) {
                while (rs.next()) {
                    hm.put(rs.getString(1), rs.getInt(2));
                }
            }
        } catch (Exception e) {
            LOG.error("An error occurred while executing Query:" + e);
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (Exception e) {
                    LOG.debug("Exception is occured at Closing ResultSet in populateUrlPoints Method" + e);
                }
            }
            if (ps != null) {
                try {
                    ps.close();
                } catch (Exception e) {
                    LOG.debug("Exception is occured at Closing PreparedStatement in populateUrlPoints Method" + e);
                }
            }
            if (con != null) {
                DbConnectionPool.closeConnection(con);
            }
        }//eof finally

    }
}
