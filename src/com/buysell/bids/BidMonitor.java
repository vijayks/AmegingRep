/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.buysell.bids;

import com.buysell.db.DbConnection;
import com.buysell.db.DbConnectionPool;
import com.buysell.servlets.MessageTemplateServlet;
import com.buysell.util.BuySellProperties;
import com.buysell.util.SendMail;
import com.buysell.util.SendSMS;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Date;
import java.util.Iterator;
import java.util.Set;
import java.util.StringTokenizer;
import org.apache.log4j.Logger;

/**
 *
 * @author bbsadmin
 */
public class BidMonitor extends Thread {

    private static Logger LOG = Logger.getLogger(BidMonitor.class);
    public static final boolean flag = true;
    String currentBidsQry = "SELECT ID,A.BID_PRODUCT_ID,BID_START_TIME,BID_END_TIME,INITIAL_PRICE,A.STATUS,BIDDER_SIZE,LOWER_LIMIT,UPPER_LIMIT,BID_LIMIT,SUPER_BID,B.PRODUCT_NAME,B.PRODUCT_IMGS,B.PRODUCT_PRICE,B.DESCRIPTION,B.PRODUCT_MODEL,B.SHORT_SPECS,B.LONG_SPECS,B.PRODUCT_OWNER FROM BID_T A,BID_PRODUCTS_T B WHERE A.BID_PRODUCT_ID=B.BID_PRODUCT_ID AND A.STATUS=2";
    String currentBidDetailsQry = "SELECT A.USER_ID,USER_NAME,BID_PRICE,BID_TIME,LOGIN_NAME,PHONE FROM BID_USERDETAILS_T A,USER_LOGIN_T B,USER_T C WHERE A.USER_ID=B.USER_ID AND A.USER_ID=C.USER_ID AND BID_ID=? ORDER BY BID_TIME DESC LIMIT 0,?";
    DbConnection dbc = new DbConnection();
    MessageTemplateServlet mst = new MessageTemplateServlet();
    int sleept = BuySellProperties.getProperty("bid.monitor.sleep")==null ? 900000:Integer.parseInt(BuySellProperties.getProperty("bid.monitor.sleep").trim());
    private void getCurrentBids() {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            con = DbConnectionPool.getConnection();
            ps = con.prepareStatement(currentBidsQry);
            rs = ps.executeQuery();
            if (rs != null) {
                while (rs.next()) {
                    BidItemBean bib = new BidItemBean();
                    bib.setId(rs.getLong(1));
                    Date temp = new Date();
                    Date bidSt = new Date(rs.getTimestamp(3).getTime());
                    if (!(BidListsAction.bidmap.get(bib.getId()) == null && BidListsAction.futurebid.get(bib.getId()) == null)) {
                        if(BidListsAction.bidmap.get(bib.getId()) == null && (bidSt.equals(temp)||bidSt.before(temp))){
                            BidItemBean tb = BidListsAction.futurebid.get(bib.getId());
                            BidListsAction.bidmap.put(bib.getId(), tb);
                            BidListsAction.futurebid.remove(bib.getId());
                        }
                        continue;
                    }
                    bib.setBidProdId(rs.getLong(2));
                    bib.setBidStart(rs.getTimestamp(3));
                    bib.setBidEnd(rs.getTimestamp(4));
                    bib.setInitialPrice(rs.getFloat(5));
                    bib.setStatus(rs.getInt(6));
                    bib.setBidderSize(rs.getInt(7));
                    bib.setLowerLimit(rs.getFloat(8));
                    bib.setUpperLimit(rs.getFloat(9));
                    bib.setBidLimit(rs.getInt(10));
                    bib.setSuperBid(rs.getInt(11));
                    bib.setProdName(rs.getString(12));
                    bib.setImages(rs.getString(13));
                    StringTokenizer stz = new StringTokenizer(rs.getString(13), "^^^");
                    if(stz.countTokens()>0){
                        bib.setProdImg(stz.nextToken());
                    }
                    bib.setProductPrice(rs.getFloat(14));
                    bib.setDescription(rs.getString(15));
                    bib.setProdModel(rs.getString(16));
                    bib.setShortSpecs(rs.getString(17));
                    bib.setLongSpecs(rs.getString(18));
                    bib.setProdOwner(rs.getString(19));
                    updateCurrentBidDetails(bib);
                    if(bidSt.equals(temp) || bidSt.before(temp))
                        BidListsAction.bidmap.put(bib.getId(), bib);
                    else
                        BidListsAction.futurebid.put(bib.getId(), bib);
                }
            }
        } catch (Exception e) {
            LOG.error("Error Occurred while retrieving current bids " + e);
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (Exception e) {
                    LOG.error("Error occured while closing Resultset in getCurrentBids " + e);
                }
            }
            if (ps != null) {
                try {
                    ps.close();
                } catch (Exception e) {
                    LOG.error("Error occured while closing Prepared Statement in getCurrentBids " + e);
                }
            }
            if (con != null) {
                DbConnectionPool.closeConnection(con);
            }
        }
    }


    public void run() {
        LOG.info(" Starting Bid Monitor Thread ... ");
        while (flag) {
            try {
               LOG.debug(" Running Bid Monitor Thread ... ");
                getCurrentBids();
               LOG.debug(" Before modifying bid status ... ");
                modifyBidStatus();
                sleep(sleept);
            } catch (InterruptedException e) {
                LOG.error("Error while sleeping BidMonitor Thread " + e);
            }
        }
    }

    private void modifyBidStatus() {

        synchronized (BidListsAction.bidmap) {
            Set ks = BidListsAction.bidmap.keySet();
            for (Iterator itr = ks.iterator(); itr.hasNext();) {
                BidItemBean bb = (BidItemBean) BidListsAction.bidmap.get((Long) itr.next());
                Date dt = new Date();
                Date bidDt = new Date(bb.getBidEnd().getTime());
                if (bidDt.equals(dt) || bidDt.before(dt)) {
                    bb.setStatus(1);
                    dbc.executeQuery("UPDATE BID_T SET STATUS=1 WHERE ID="+bb.getId());
                    dbc.executeQuery("UPDATE BID_USERDETAILS_T SET STATUS=1 WHERE BID_ID="+bb.getId()+" ORDER BY BID_TIME DESC LIMIT 1");

                    if(bb.getBidderEmail()!=null && bb.getBidderEmail().trim().length()>0 && bb.getBidderEmail().contains("@")) {
                    try{
                        SendMail sm = new SendMail();
                        String sub = "Congratulations, You have won "+bb.getProdName();
                        String link = BuySellProperties.getProperty("auctionDetailsLink")!=null ? BuySellProperties.getProperty("auctionDetailsLink") : "http://bharatbuysell.com/auctions.do";
                        String msg = mst.getAuctionWonTemplate(bb.getBidderName(), bb.getProdName(), bb.getCurrentPrice(), bb.getProdImg() ,link+bb.getId());
                        boolean res = sm.send(bb.getBidderEmail(), sub, msg);
                    } catch (Exception e) {
                        LOG.error("error while sending auction alert mail :" + e);
                    }
                    }
                    String urlQry = mst.getAuctionWonSmsTemplate(bb.getBidderName(), bb.getProdName(), bb.getCurrentPrice());
                    String encodedurl = null;
                    try {
                        encodedurl = URLEncoder.encode(urlQry.toString(), "UTF-8");
                    } catch (UnsupportedEncodingException uee) {
                        LOG.error(" unsupported usrl exception :: " + uee);
                    }
                    LOG.debug("send string:::::::::::::::::" + urlQry);
                    if(SendSMS.callSendSMS(bb.getBidderMobile(), encodedurl))
                        LOG.debug("SMS sent to auction winner "+bb.getBidderName()+" for auction "+bb.getId());
                }
            }
        }
    }

    private void updateCurrentBidDetails(BidItemBean bib) {

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        if(bib!=null){
            try {
                con=DbConnectionPool.getConnection();
                ps = con.prepareStatement(currentBidDetailsQry);
                ps.setLong(1, bib.getId());
                ps.setInt(2, bib.getBidderSize()+1);
                rs=ps.executeQuery();

                bib.setBidDetails(0, "Admin", bib.getInitialPrice(), "", "");
                if(rs!=null){
                    rs.afterLast();
                    while(rs.previous()){
                        bib.setBidDetails(rs.getLong(1), rs.getString(2), rs.getFloat(3), rs.getTimestamp(4), rs.getString(5), rs.getString(6));
                    }
                }

            } catch (Exception e) {
                   LOG.error("Error Occurred while updateCurrentBidDetails " + e);
            } finally {
                if (rs != null) {
                    try {
                        rs.close();
                    } catch (Exception e) {
                        LOG.error("Error occured while closing Resultset in updateCurrentBidDetails " + e);
                    }
                }
                if (ps != null) {
                    try {
                        ps.close();
                    } catch (Exception e) {
                        LOG.error("Error occured while closing Prepared Statement in updateCurrentBidDetails " + e);
                    }
                }
                if (con != null) {
                    DbConnectionPool.closeConnection(con);
                }
            }
        }
    }
}
