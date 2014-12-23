/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.buysell.util;

import com.buysell.db.DbConnectionPool;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Vector;
import org.apache.log4j.Logger;

/**
 *
 * @author bbsadmin
 */
public class SmsUtil {

    private static Logger LOG = Logger.getLogger(SmsUtil.class);
    int s = 0;
    Connection con;
    Statement stmt;
    ResultSet rs;
    static Vector v = new Vector();

    public SmsUtil() {
        try {
            s = Integer.parseInt(BuySellProperties.getProperty("pending.sms.bundle.count"));
        } catch (NumberFormatException ne) {
            LOG.error(" Error while convertign the pending.sms.bundle.count to number " + ne);
            s = 100;
        }
    }

    private void createIndexes() {

        int x, y, z;
        x = y = z = 0;
        con = DbConnectionPool.getConnection();
        try {
            stmt = con.createStatement();
            rs = stmt.executeQuery("SELECT MIN(ID), MAX(ID),COUNT(*) FROM STORE_PASS_T");
            while (rs.next()) {
                x = rs.getInt(1);
                y = rs.getInt(2);
                z = rs.getInt(3);
            }
            LOG.info(" Total pending sms available in table is start id " + x + "  max id " + y + " total available " + z);
        } catch (SQLException ex) {
            LOG.error(" Exception while getting the count details from Pending SMS" + ex);
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
                LOG.error("= Exception Occured in closing db connections ::=" + e);
            }
        }

        if (z > 0) {
            while (x <= y) {
                Boundary b = new Boundary(x, y);
                x = x + s;
                v.add(b);

            }

        }
    }

    public Boundary getBoundary() {
        if (v.size() > 0) {
            return (Boundary) v.remove(0);
        } else {
            createIndexes();
        }
        return null;
    }

    public class Boundary {

        int lower;
        int upper;

        public Boundary(int lower, int upper) {
            this.lower = lower;
            this.upper = upper;
        }
    }
}
