/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.buysell.bids;

import com.buysell.db.DbConnectionPool;
import com.buysell.util.BuySellProperties;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Set;
import java.util.StringTokenizer;
import java.util.Vector;
import org.apache.log4j.Logger;

/**
 *
 * @author bbsadmin
 */
public class BidAnnouncer extends Thread {

    private static Logger LOG = Logger.getLogger(BidAnnouncer.class);
    public static boolean flag=true;
    public static Vector<BidAnnouncerObject> bidAnn = new Vector();
    String completedBidsQry = "SELECT A.ID,A.BID_START_TIME,A.BID_END_TIME,A.INITIAL_PRICE,A.STATUS,A.SUPER_BID,B.PRODUCT_NAME,B.PRODUCT_IMGS,C.USER_ID,C.USER_NAME,C.BID_PRICE,C.BID_TIME,B.PRODUCT_PRICE FROM BID_T A,BID_PRODUCTS_T B,BID_USERDETAILS_T C WHERE A.BID_PRODUCT_ID=B.BID_PRODUCT_ID AND A.ID=C.BID_ID AND C.STATUS=1 AND A.STATUS=1 AND A.BID_END_TIME>DATE_ADD(NOW(),INTERVAL -14 DAY)";
    int sleept = BuySellProperties.getProperty("bid.announcer.sleep")==null ? 840000:Integer.parseInt(BuySellProperties.getProperty("bid.announcer.sleep").trim());
    int showt = BuySellProperties.getProperty("bid.announcer.showtime")==null ? 3600000:Integer.parseInt(BuySellProperties.getProperty("bid.announcer.showtime").trim());

    public void run() {
        LOG.info("Starting BidAnnounce thread ........");
        while(flag){
        LOG.debug("Runnning BidAnnounce thread ........");
            List<BidItemBean> ll = new ArrayList();
            LOG.debug("Checking Status ......");
            synchronized (BidListsAction.bidmap) {
                Set ks = BidListsAction.bidmap.keySet();
                for (Iterator itr = ks.iterator(); itr.hasNext();) {
                    BidItemBean bb = (BidItemBean) BidListsAction.bidmap.get((Long) itr.next());
                    if (bb != null && bb.getStatus() == 1) {
                        ll.add(bb);
                    }
                }
            }
            LOG.debug("Removing from current bids ......");
            synchronized (BidListsAction.bidmap) {
                for(BidItemBean bb : ll){
                    BidListsAction.bidmap.remove(bb.getId());
                }
            }
            LOG.debug("Removing old closed bids ......");
            synchronized(BidAnnouncer.bidAnn){
            for(int i=0;i<BidAnnouncer.bidAnn.size();i++){
                BidAnnouncerObject bao = BidAnnouncer.bidAnn.get(i);
                if(bao != null){
                    Date t = new Date();
                    if((t.getTime()-bao.getInsertedTime().getTime()) >= showt){
                        BidAnnouncer.bidAnn.remove(bao);
                    }
                }
            }
            }
            LOG.debug("Adding new closed bids ......");
            synchronized(BidAnnouncer.bidAnn){
            for (BidItemBean bb : ll) {
                if (bb != null) {
                    //TODO add obj intoo bidannmap and remove in bidmap
                    BidAnnouncerObject bao = new BidAnnouncerObject();
                    bao.setInitialPrice(bb.getInitialPrice());
                    bao.setProdName(bb.getProdName());
                    bao.setProdImg(bb.getProdImg());
                    bao.setWonUserId(bb.getBidderId());
                    bao.setWonUserName(bb.getBidderName());
                    bao.setWonPrice(bb.getCurrentPrice());
                    bao.setWonDt(bb.getBiddingTime());
                    bao.setProductPrice(bb.getProductPrice());
                    bao.setBidId(bb.getId());
                    bao.setBidEndDt(bb.getBidEnd());
                    BidAnnouncer.bidAnn.add(0,bao);
                }
            }
            }
             try {
                    sleep(sleept);
                } catch (InterruptedException e) {
                    LOG.error("Error while sleeping BidAnnouncer Thread " + e);
                }
         
    }
       
        LOG.info("Stopping BidAnnounce thread ........");
    }

    public BidAnnouncer() {
        if(BidAnnouncer.bidAnn.isEmpty())
            getCompletedBids();
    }

    private void getCompletedBids() {
        Connection con = DbConnectionPool.getConnection();
        PreparedStatement ps = null;
        ResultSet rs = null;
        BidAnnouncerObject bao = null;
        try {
            ps = con.prepareStatement(completedBidsQry);
            rs = ps.executeQuery();
            if (rs != null) {
                while (rs.next()) {
                    bao=new BidAnnouncerObject();
                    bao.setBidId(rs.getLong(1));
                    bao.setBidEndDt(rs.getTimestamp(3));
                    bao.setInitialPrice(rs.getFloat(4));
                    bao.setProdName(rs.getString(7));
                    StringTokenizer stz = new StringTokenizer(rs.getString(8), "^^^");
                    if(stz.countTokens()>0)
                        bao.setProdImg(stz.nextToken());
                    bao.setWonUserId(rs.getLong(9));
                    bao.setWonUserName(rs.getString(10));
                    bao.setWonPrice(rs.getFloat(11));
                    bao.setWonDt(rs.getTimestamp(12));
                    bao.setProductPrice(rs.getFloat(13));
                    bao.setInsertedTime(rs.getTimestamp(3));
                    BidAnnouncer.bidAnn.add(0, bao);
                    LOG.debug(bao.getBidId()+"  ");
                }
            }
        } catch (Exception e) {
            LOG.error("Error Occurred while retrieving completed bids " + e);
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (Exception e) {
                    LOG.error("Error occured while closing Resultset in getCompletedBids " + e);
                }
            }
            if (ps != null) {
                try {
                    ps.close();
                } catch (Exception e) {
                    LOG.error("Error occured while closing Prepared Statement in getCompletedBids " + e);
                }
            }
            if (con != null) {
                DbConnectionPool.closeConnection(con);
            }
        }
    }

}
