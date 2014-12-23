/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.buysell.servlets;

import com.buysell.util.BuySellProperties;
import com.buysell.util.City;
import com.buysell.util.CityUtil;
import com.buysell.util.Location;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Iterator;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;

/**
 *
 * @author srikanth
 */
public class GetStatesServlet extends HttpServlet {

    private static Logger LOG = Logger.getLogger(GetStatesServlet.class);
    CityUtil cu = new CityUtil();

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        LOG.debug("Inside GetStatesServlet");
        response.setContentType("text/xml;charset=UTF-8");
        PrintWriter out = response.getWriter();
        String sel = request.getParameter("xx");
        StringBuffer sb = new StringBuffer("<response>");
//        String con = request.getParameter("cn");
//        String stt = request.getParameter("st");
        String ct = request.getParameter("ct");

//        if (sel != null && sel.equalsIgnoreCase("state")) {
//            if (con != null && con.trim().length() > 0) {
//                File countryRootDir = new File(BuySellProperties.getProperty("countryLocation") + con);
//                String countries[] = countryRootDir.list();
//                for (int i = 0; i < countries.length; i++) {
//                    String st = countries[i];
//                    sb.append("<state value=\"").append(st).append("\" />");
//                }
//            }
//        } else if (sel != null && sel.equalsIgnoreCase("city")) {
//            if (con != null && stt != null && con.trim().length() > 0 && stt.trim().length() > 0) {
//                List lcs = cu.viewAllCities(con, stt);
//                for (Iterator itr = lcs.iterator(); itr.hasNext();) {
//                    City c = (City) itr.next();
//                    sb.append("<city value=\"").append(c.getName()).append("\" />");
//                }
//            }
//        } else
        if (sel != null && sel.equalsIgnoreCase("loc")) {

            if (ct != null && ct.trim().length() > 0) {
                City c = cu.getCityByName(ct);
                if (c != null) {
                    List lcs = c.getLoc();
                    if (lcs != null) {
                        Iterator itr = lcs.iterator();
                        if (itr != null) {
                            while (itr.hasNext()) {
                                Location loc = (Location) itr.next();
                                if (loc != null) {
                                    sb.append("<locality value=\"").append(loc.getName()).append("\" />");
                                }
                            }
                        }
                    }
                }
            }
        }
        sb.append("</response>");
        try {
            out.print(sb);

        } catch (Exception e) {
            LOG.error(e);
        } finally {
            out.flush();
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
