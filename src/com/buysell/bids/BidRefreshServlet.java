/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.buysell.bids;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Iterator;
import java.util.Set;
import java.util.Vector;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;

/**
 *
 * @author bbsadmin
 */
public class BidRefreshServlet extends HttpServlet {
   
    private static Logger LOG = Logger.getLogger(BidRefreshServlet.class);
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
        long bidId = 0;
        if(bId!=null && bId.trim().length()>0)
            bidId = Long.parseLong(bId);
        try {
           if(BidListsAction.bidmap!=null){
               if(bidId==0) {
           Set ks=BidListsAction.bidmap.keySet();
               for (Iterator it = ks.iterator(); it.hasNext();) {
           BidItemBean bib=BidListsAction.bidmap.get((Long) it.next());
            sb.append("<bid bidid=\""+bib.getId()+"\" bidderName=\""+bib.getBidderName()+"\" bidPrice=\""+bib.getCurrentPrice()+"\" ");
//            sb.append(bidId+":"+bib.getBidderName()+":"+bib.getCurrentPrice()+":");
            if (bib.getBidLimit() == 1) {
                float llp = (bib.getCurrentPrice()) + ((bib.getInitialPrice() * bib.getLowerLimit()) / 100);
                float ulp = (bib.getCurrentPrice()) + ((bib.getInitialPrice() * bib.getUpperLimit()) / 100);
                sb.append("bidRange=\""+Math.floor(llp)+" - "+Math.floor(ulp)+"\"");
//                sb.append(Math.floor(llp)+" - "+Math.floor(ulp)+":");
            }
            sb.append(" />");
               }
               } else {
                   BidItemBean bib=BidListsAction.bidmap.get(bidId);
                   if(bib!=null) {
                    sb.append("<bid bidid=\""+bib.getId()+"\" bidderName=\""+bib.getBidderName()+"\" bidPrice=\""+bib.getCurrentPrice()+"\" bidderSize=\""+bib.getBidderSize()+"\" ");
                    if (bib.getBidLimit() == 1) {
                        float llp = (bib.getCurrentPrice()) + ((bib.getInitialPrice() * bib.getLowerLimit()) / 100);
                        float ulp = (bib.getCurrentPrice()) + ((bib.getInitialPrice() * bib.getUpperLimit()) / 100);
                        sb.append("bidRange=\""+Math.floor(llp)+" - "+Math.floor(ulp)+"\"");
                    }
                    sb.append(" />");
                    if(bib.getBidDetails().size()>0){
                        for(int bd=0;bd<bib.getBidDetails().size();bd++) {
                            Vector v=bib.getBidDetails();
                            BidBean bb = (BidBean) v.get(bd);
                            if(bb.getCurrentPrice()!=0)
                                sb.append("<bidDetails userName=\""+bb.getBidderName()+"\" price=\""+bb.getCurrentPrice()+"\" time=\""+bb.getBiddingTime()+"\" />");
                        }
                    }
                   }
               }
           }
           sb.append("</response>");
            out.print(sb.toString());
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
