/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.buysell.bids;

import com.buysell.beans.UserBean;
import com.buysell.db.DbConnection;
import com.buysell.servlets.MessageTemplateServlet;
import com.buysell.util.BuySellProperties;
import com.buysell.util.SendMail;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;

/**
 *
 * @author bbsadmin
 */
public class BidServlet extends HttpServlet {

    private static Logger LOG = Logger.getLogger(BidServlet.class);
    DbConnection dbc = new DbConnection();
    MessageTemplateServlet mst = new MessageTemplateServlet();

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/xml;charset=UTF-8");
        PrintWriter out = response.getWriter();
        StringBuffer sb = new StringBuffer("<response>");

        String bId = request.getParameter("bidId");
        String price = request.getParameter("pr");
        String fm = request.getParameter("frm");
        try {
            if (bId != null && price != null && fm!=null) {
                long bidId = Long.parseLong(bId);
                float bidPrice = Float.parseFloat(price);
                UserBean ub = (UserBean) request.getSession().getAttribute("userBean");
                if(ub!=null){
                BidItemBean bb = BidListsAction.bidmap.get(bidId);
                if (bb != null && bb.getStatus() == 2 && fm.equals("bid")) {
                    if (bb.getBidderId() != ub.getUserId()) {
                        if (bb.getCurrentPrice() < bidPrice) {
                            if(bb.getBidEnd().getTime()>=new java.util.Date().getTime()) {
                            boolean chk = false;
                            float llp=0;
                            float ulp=0;
                            if (bb.getBidLimit() == 1) {
                                llp = (bb.getCurrentPrice()) + ((bb.getInitialPrice() * bb.getLowerLimit()) / 100);
                                ulp = (bb.getCurrentPrice()) + ((bb.getInitialPrice() * bb.getUpperLimit()) / 100);
                                if (!(Math.floor(llp) > bidPrice || Math.floor(ulp) < bidPrice)) {
                                    chk = true;
                                }
                            } else {
                                chk = true;
                            }
                            if (chk) {
                                if(BuySellProperties.getProperty("auctionAlert")!=null && BuySellProperties.getProperty("auctionAlert").equals("1")) {
                                    if(bb.getBidderEmail()!=null && bb.getBidderEmail().trim().length()>0 && bb.getBidderEmail().contains("@")) {
                                    try{
                                        SendMail sm = new SendMail();
                                        String sub = "Auction Alert on "+bb.getProdName();
                                        String link = BuySellProperties.getProperty("auctionDetailsLink")!=null ? BuySellProperties.getProperty("auctionDetailsLink") : "http://bharatbuysell.com/auctions.do";
                                        String msg = mst.getAuctionAlertTemplate(bb.getBidderName(), bb.getProdName(), bb.getCurrentPrice(), bidPrice, bb.getProdImg() ,link+bb.getId());
                                        boolean res = sm.send(bb.getBidderEmail(), sub, msg);
                                    } catch (Exception e) {
                                        LOG.error("error while sending auction alert mail :" + e);
                                    }
                                    }
                                }
                                bb.setBidDetails(ub.getUserId(), ub.getFirstName(), bidPrice, ub.getLoginName(), ub.getMobile());
                                long dt = bb.getBiddingTime().getTime();
                                dbc.callInsertBid(bidId, ub.getFirstName(), ub.getUserId(), new Timestamp(dt), bidPrice);
                                sb.append("<check bidid=\"" + bidId + "\" status=\"ok\" value=\"").append(bidPrice + "\" name=\"" + ub.getFirstName()).append("\" ");
                                if(bb.getBidLimit()==1){
                                    llp = (bb.getCurrentPrice()) + ((bb.getInitialPrice() * bb.getLowerLimit()) / 100);
                                    ulp = (bb.getCurrentPrice()) + ((bb.getInitialPrice() * bb.getUpperLimit()) / 100);
                                    sb.append("bidrange=\""+Math.floor(llp)+" - "+Math.floor(ulp)+"\"");
                                }
                                sb.append(" />");
                            } else {
                                sb.append("<check bidid=\"" + bidId + "\" status=\"wrong Bid\" value=\"Please bid in the given range\" />");
                            }
                            } else {
                                sb.append("<check bidid=\"" + bidId + "\" status=\"wrong Bid\" value=\"Auction Closed\" />");
                            }
                        } else {
                            sb.append("<check bidid=\"" + bidId + "\" status=\"wrong Bid\" value=\"Please bid more than current Price\" />");
                        }
                    } else {
                        sb.append("<check bidid=\"" + bidId + "\" status=\"wrong Bid\" value=\"You are highest Bidder\" />");
                    }
                } else if(bb != null && bb.getStatus() == 2 && fm.equals("bidWL")){
                    int res=0;
                    res=dbc.executeQuery("INSERT INTO BID_WATCHLIST_T (USER_ID,BID_ID,ADDED_ON)  SELECT "+ub.getUserId()+","+bidId+",now() from BID_WATCHLIST_T WHERE USER_ID="+ub.getUserId()+" AND BID_ID="+bidId+" HAVING COUNT(*)=0");
                    if(res==1){
                        sb.append("<check bidid=\"" + bidId + "\" status=\"ok\" value=\"Added Successfully\" />");
                    } else {
                        sb.append("<check bidid=\"" + bidId + "\" status=\"wrong Bid\" value=\"Already Exists\" />");
                    }
                }
                } else {
                    sb.append("<check bidid=\"" + bidId + "\" status=\"wrong Bid\" value=\"Please login to bid\" />");
                }
            }
            sb.append("</response>");
            LOG.debug("response - " + sb.toString());
            out.print(sb);
        } finally {
            out.close();
        }

    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}
