/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.buysell.servlets;

import com.buysell.db.DbConnection;
import com.buysell.util.Category;
import com.buysell.util.CategorySearch;
import com.buysell.util.CategoryUtil;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Set;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;

/**
 *
 * @author bbsadmin
 */
public class Suggest extends HttpServlet {

    private static Logger LOG = Logger.getLogger(Suggest.class);
    CategoryUtil cu = new CategoryUtil();

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        LOG.debug(" inside Suggest ");
        response.setContentType("text/xml;charset=UTF-8");
        PrintWriter out = response.getWriter();

        String it = request.getParameter("it");
        StringBuffer sb = new StringBuffer("<response>");
        CategorySearch cs = new CategorySearch();
        HashMap hm = cs.getSuggStrings(it);
        Set s = hm.keySet();
        for (Iterator itr = s.iterator(); itr.hasNext();) {
            try {
                Integer i = (Integer) itr.next();
                ;
                String str = String.valueOf(i.intValue());
                sb.append("<search value=\"").append((String) hm.get(i)).append("\" ").append(" id=\"").append(str).append("\" />");
            } catch (Exception e) {
                LOG.error(" Exception is " + e);
            }
        }
        sb.append("</response>");
        out.print(sb);

        out.flush();
        out.close();
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
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
    }
}
