/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.buysell.util;

import com.buysell.beans.AlertAdsBean;
import com.buysell.db.DbConnectionPool;
import com.mysql.jdbc.Statement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import org.apache.log4j.Logger;

/**
 *
 * @author BlueIgnite
 */
public class AdAlertsUtil {

    private static Logger LOG = Logger.getLogger(AdAlertsUtil.class);
    List adAlertsList = new ArrayList();
    String query = "SELECT ALERT_ID, USER_ID , ALERT_CREATION_DATE , ALERT_FROM, ALERT_TO, ALERT_PATTERN ALERT_T  FROM ALERT_T ";
    AlertAdsBean aab;

    public List getMeAlerts() {
        Connection con = DbConnectionPool.getConnection();
        try {

            Statement st = (Statement) con.createStatement();
            ResultSet rs = st.executeQuery(query);

            if (rs != null) {
                while (rs.next()) {
                    aab = new AlertAdsBean();

                    aab.setAlertId(rs.getInt(1));
                    LOG.info("alertId=" + aab.getAlertId());
                    aab.setUserId(rs.getInt(2));
                    LOG.info("userId=" + aab.getUserId());

                    aab.setAlertOn(rs.getDate(3));
                    LOG.info("alerOn=" + aab.getAlertOn());
                    aab.setAlertFrom(rs.getDate(4));
                    LOG.info("alertFrom=" + aab.getAlertFrom());
                    aab.setAlertTo(rs.getDate(5));
                    LOG.info("alerTo=" + aab.getAlertTo());
                    aab.setPropertiesFromSearchPattern(rs.getString(6));


                }
            }

        } catch (Exception e) {
            LOG.info("Error:" + e);
        } finally {
            if (con != null) {
                DbConnectionPool.closeConnection(con);
            }
        }
        return adAlertsList;
    }
/* this method used to store sms alert to the advertiser in  quick registration process. */

   
}
