/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.buysell.servlets;

import com.buysell.db.DbConnectionPool;
import com.buysell.util.BuySellProperties;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import org.apache.log4j.Logger;

/**
 *
 * @author bbsadmin
 */
public class DbConnectionCheckThread extends Thread{
private static final boolean  flag=true;
private static Logger LOG = Logger.getLogger(DbConnectionCheckThread.class);
long DbConnectionCheck = Long.parseLong(BuySellProperties.getProperty("DbConnectionCheck"));
Connection con;
ResultSet rs;
Statement st;
String test=null;

    public void run()
    {
        while(flag)
        {
            LOG.debug("*********************************** DbConnection testing thread started..... ******************************************");
            con=DbConnectionPool.getConnection();
            try {
                st=con.createStatement();
                rs=st.executeQuery("SELECT * FROM DBC_CHECK_T");
                if( rs!= null && rs.next())
                {
                    test=rs.getString(1);
                }
            } catch (Exception e) {
                LOG.error("= Exception Occured in  ::=" + e);
            }finally {
                try {
                    if (rs != null) {
                    rs.close();
                }
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

            try {
                sleep(DbConnectionCheck);
            } catch (Exception e) {
                LOG.error("= Exception Occured in  ::=" + e);
                
            }
        }
    }

}
