/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.buysell.util;

import com.buysell.db.DbConnectionPool;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.StringTokenizer;
import org.apache.log4j.Logger;

/**
 *
 * @author bbsadmin
 */
public class TemplateTiles {

    private static Logger LOG = Logger.getLogger(TemplateTiles.class);
    Connection con;
    PreparedStatement ps;
    ResultSet rs;
    private static final String query = "SELECT * FROM CATEGORY_TEMPLATE_T WHERE CATEGORY_ID=?";

    public TemplateTiles(int categoryId) {
    }

    public List getTileList(int categoryId) {
        if (categoryId > 0) {
            List ll = getTileListByCategoryId(categoryId);
            return ll;
        }

        return null;
    }

    private List getTileListByCategoryId(int categoryId) {
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
        } catch (SQLException ex) {
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

            } catch (Exception e) {
                LOG.error("= Exception Occured in closing db connections ::=" + e);
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
