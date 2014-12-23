/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.buysell.util;

import com.buysell.beans.SmsAlertsPendingListBean;
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
public class SmsStoreUtil {

    private static Logger LOG = Logger.getLogger(SmsStoreUtil.class);
    Connection con;
    Statement st;

    public void storeSmsAlert(int adId, String advtMobileNum, String content, String userMobileNum, int userId) {


        String qry = "INSERT INTO STORE_PASS_T (USER_ID,AD_ID,SOURCE,DESTINATION,CONTENT,INSERT_DATE) VALUES (" + userId + "," + adId + ",'" + userMobileNum + "','" + advtMobileNum + "','" + content + "',now());";
        LOG.debug("= Ennerated query =" + qry);

        con = DbConnectionPool.getConnection();
        try {
            st = (Statement) con.createStatement();
            st.executeUpdate(qry);


        } catch (Exception e) {
            LOG.debug("= Error in storing sms alerts =" + e);
        } finally {
            try {

                if (st != null) {
                    st.close();
                }
                if (con != null) {

                    DbConnectionPool.closeConnection(con);
                }
            } catch (Exception e) {
                LOG.error("= Exception Occured in closing db connections ::=" + e);
            }
        }
    }


    /*
    +-------------+--------------+------+-----+---------+----------------+
    | Field       | Type         | Null | Key | Default | Extra          |
    +-------------+--------------+------+-----+---------+----------------+
    | ID          | int(11)      | NO   | PRI | NULL    | auto_increment |
    | SOURCE      | varchar(50)  | YES  |     | NULL    |                |
    | DESTINATION | varchar(50)  | NO   |     |         |                |
    | CONTENT     | varchar(200) | YES  |     | NULL    |                |
    | STARTMIN    | int(10)      | YES  |     | NULL    |                |
    | EXPIRE_DATE | datetime     | YES  |     | NULL    |                |
    | INSERT_DATE | datetime     | YES  |     | NULL    |                |
    | USER_ID     | int(11)      | YES  |     | NULL    |                |
    | AD_ID       | int(11)      | YES  |     | NULL    |                |
    +-------------+--------------+------+-----+---------+----------------+



     */
    public static List getPendingSMSAlertsList(int low, int max) throws SQLException {
        List smsAlertList = new ArrayList();
        SmsAlertsPendingListBean saplb;
        String qry = "SELECT ID,SOURCE,DESTINATION,CONTENT,STARTMIN,USER_ID,AD_ID FROM STORE_PASS_T WHERE ID >= " + low + " AND ID <=" + max;
        Connection con1 = null;
        Statement st1 = null;
        ResultSet rs1 = null;
        try {
            con1 = DbConnectionPool.getConnection();
            st1 = (Statement) con1.createStatement();
            rs1 = st1.executeQuery(qry);
            if (rs1 != null && rs1.next()) {
                saplb = new SmsAlertsPendingListBean();
                saplb.setId(rs1.getInt(1));
                saplb.setSource(rs1.getString(2));
                saplb.setDestination(rs1.getString(3));
                saplb.setContent(rs1.getString(4));
                saplb.setStartMin(rs1.getString(5));
                saplb.setUserId(rs1.getInt(6));
                saplb.setAdId(rs1.getInt(7));
                smsAlertList.add(saplb);
            }

        } catch (Exception e) {
            LOG.error("= Exception Occured in  ::=" + e);
        } finally {
            try {
                if (rs1 != null) {
                    rs1.close();
                }
                if (st1 != null) {
                    st1.close();
                }
                if (con1 != null) {

                    DbConnectionPool.closeConnection(con1);
                }
            } catch (Exception e) {
                LOG.error("= Exception Occured in closing db connections ::=" + e);
            }
        }




        return smsAlertList;
    }
}

