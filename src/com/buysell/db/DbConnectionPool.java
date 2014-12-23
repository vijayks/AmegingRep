/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.buysell.db;

import com.buysell.util.BuySellProperties;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Set;
import org.apache.log4j.Logger;

/**
 *
 * @author srikanth
 */
public class DbConnectionPool {

    static List cPool = new ArrayList();
    static int maxPoolSize = Integer.parseInt(BuySellProperties.getProperty("db.connection.max.poolsize"));
    static long cTimeOut = Long.parseLong(BuySellProperties.getProperty("db.connection.timeout"));
    static HashMap<Connection,Long> hmp = new HashMap();
    public static boolean flag = true;
    static int currentConnections;
    private static Logger LOG = Logger.getLogger(DbConnectionPool.class);
    private static final Object OBJ = new Object();
    static boolean monitor = false;
    
    static {
       if (!monitor) {
           monitor = true;
            ConnectionMonitor.startMe();
            
        } 
    }

    public static synchronized Connection getConnection() {
        
        LOG.debug("Got DB connection request CUrrent in use connections are "+hmp.size()+" pooled connections are "+cPool.size());
        Connection con = null;
        
        if (cPool.size() == 0) {
            con = createConnection();
        } else {
            synchronized (cPool) {
                con = (Connection) cPool.remove(cPool.size() - 1);
            }
        }
        if (con == null) {
            con = createConnection();
        }
        if (con != null) {
            hmp.put(con, System.currentTimeMillis());
            //OBJ.notify();
        }
        LOG.debug("Giving connection "+con);
        return con;
    }

    private static synchronized Connection createConnection() {
        Connection con = null;
        LOG.debug(" Create connection request received "+currentConnections+" max allowed is "+maxPoolSize);
        LOG.debug(" CUrrent in use connections are "+hmp.size()+" pooled connections are "+cPool.size());
        
        if (currentConnections <= maxPoolSize) {
            LOG.info(" Creating new connection........." + currentConnections);
            try {

                if (con == null) {
                    Class.forName("com.mysql.jdbc.Driver");
                    String conName = BuySellProperties.getProperty("dbAddress");

                    if (conName != null) {
                        con = (Connection) DriverManager.getConnection(conName);
                        currentConnections++;
                    } else {
                        LOG.info("====Error in database path address please check====");
                    }
                }

            } catch (Exception e) {
                LOG.error("Unable to create Connection" + e);
            }
        }else{
            LOG.debug(" Not able to Create new Connection max pool size reached "+currentConnections);
            currentConnections = (cPool.size()+hmp.size()) == currentConnections ? currentConnections :cPool.size()+hmp.size();
        }
        return con;
    }

    public static synchronized void closeConnection(Connection con) {
        LOG.debug(" Before returning connection CUrrent in use connections are "+hmp.size()+" pooled connections are "+cPool.size());
        LOG.debug(" Freeing the connection, adding back to pool ");
        hmp.remove(con);
        cPool.add(0, con);
        LOG.debug(" Now total available connections are " + cPool.size());
    }

    public static void closeAllConnection() {
        LOG.info(" CLOSING ALL DB CONNECTIONS " + cPool.size());
        for (Iterator itr = cPool.iterator(); itr.hasNext();) {
            Connection con = (Connection) itr.next();
            endConnection(con);
        }

    }

    private static void endConnection(Connection con) {
        LOG.debug(" End connection called for connection "+con);
        if (cPool.contains(con)) {
            cPool.remove(con);
            LOG.info("Removed connection from List");
        }
        if (con != null) {
            try {
                con.close();
                LOG.info("Connection closed successfully");
            } catch (SQLException ex) {
                LOG.error("Error while closing connection " + ex);
                con = null;
            }
        } else {
            LOG.error(" NOT ABLE TO CLOSE NULL CONNECTION ");
        }
        LOG.debug(currentConnections+" Closed the connection "+con+"because of unresponse from long time ");
        if (currentConnections > 0) {
            
            currentConnections--;
        }
    }

    private static class ConnectionMonitor extends Thread {

        @Override
        public void destroy() {
            LOG.info("Destroying the DBConnectionPool monitor thread.\n Total available connections now are " + cPool.size());
            flag = false;
            //OBJ.notify();
            closeAllConnection();
        }

        public static void startMe() {
            ConnectionMonitor cm = new ConnectionMonitor();
            cm.setDaemon(true);
            cm.start();
        }

        @Override
        public void run() {
            LOG.info("Starting the DBConnectionPool monitor thread "+flag);
            while (flag) {
                if (hmp.isEmpty()) {
                    try {
//                        LOG.debug("Connection monitor is now waiting, no connection in use");
                        sleep(5000);
                        LOG.debug("Some one notified monitor thread .....");
                    } catch (InterruptedException ex) {
                        LOG.error(" Error while waitign for OBJ" + ex);
                    }
                } else {
                    Set ks = hmp.keySet();
                    for (Iterator itr = ks.iterator(); itr.hasNext();) {
                        Connection con = (Connection) itr.next();
                        long lastUsed = (hmp.get(con));
                        if ((System.currentTimeMillis() - lastUsed) >= cTimeOut) {
                            LOG.info(con+" Closing the connection after waitign for a long time "+hmp.get(con));
//                          con =(Connection) hmp.remove(con);

                            long tot = hmp.remove(con);
                            LOG.info("Closing the connection after waitign for a long time ::" + tot);
                            endConnection(con);

                        }
                    }
                    try {
                        sleep(2000);
                    } catch (InterruptedException ex) {
                        LOG.error(" Error while sleeping ....." + ex);
                    }
                }
            }
            LOG.info("Stoping the DBConnectionPool monitor thread");
        }
    }
}
