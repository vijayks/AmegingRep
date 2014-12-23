package com.buysell.util;

import com.buysell.db.DbConnection;
import com.buysell.db.DbConnectionPool;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.StringTokenizer;
import org.apache.log4j.Logger;

/**
 *
 * @author bbsadmin
 */
public class AdvancedTiles {

    private static Logger LOG = Logger.getLogger(AdvancedTiles.class);
    DbConnection db = new DbConnection();
    private static final String query = "SELECT * FROM SEARCH_TILES_T WHERE CATEGORY_ID= ?";
    Connection con;
    PreparedStatement ps;
    ResultSet rs;

    public AdvancedTiles(int categoryId) {
    }

    public List getTileList(int categoryId) {
        if (categoryId >= 0) {
            List ll = getTileListByCategoryId(categoryId);
            return ll;
        }
        return null;
    }

    // this method used for to get the SEARCH_FIELDS COLUMN FROM THE TABLE
    public String getSearchFields(int categoryId) {
        String qr = null;
        long st = System.currentTimeMillis();
        con = DbConnectionPool.getConnection();
        try {
            ps = con.prepareStatement(query);
            ps.setInt(1, categoryId);
            rs = ps.executeQuery();
            if (rs != null) {
                rs.next();
                qr = rs.getString(3);
            }

        } catch (Exception e) {
        } finally {
            try {
                 if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (con != null) {
                    DbConnectionPool.closeConnection(con);
                }
                long et = System.currentTimeMillis();
                LOG.debug("= Time taken to complete db operation :: =" + (et - st) + " Milli Seconds");
            } catch (Exception e) {
                LOG.error("= Exception Occured in closing dbconnections ::=" + e);
            }
        }


        return qr;
    }

    /* This method is used to get the tiles list from db based on the given category. It is used in display search tiles*/
    private List getTileListByCategoryId(int categoryId) {
        long st = System.currentTimeMillis();
        List ll = null;
        con = DbConnectionPool.getConnection();
        try {
            ps = con.prepareStatement(query);
            ps.setInt(1, categoryId);
            rs = ps.executeQuery();
            if (rs != null) {
                rs.next();
                String tiles = rs.getString(2);
                ll = populateTileList(tiles);
            }
        } catch (Exception ex) {
            LOG.error("Eror while getting the tile list for category " + categoryId + "..." + ex);
        } finally {
            try {
                 if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (con != null) {
                    DbConnectionPool.closeConnection(con);
                }
                long et = System.currentTimeMillis();
                LOG.debug("= Time taken to complete db operation :: =" + (et - st) + " Milli Seconds");
            } catch (Exception e) {
                LOG.error("= Exception Occured in Closing dbconnections ::=" + e);
            }
        }
        return ll;
    }

    private List populateTileList(String tiles) {
        StringTokenizer stz = new StringTokenizer(tiles, "|");
        List ll = new ArrayList();
        if (stz != null) {
            while (stz.hasMoreTokens()) {
                ll.add(stz.nextToken());

            }
        }
        return ll;
    }
}
