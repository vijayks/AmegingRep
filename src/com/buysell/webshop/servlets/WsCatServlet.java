/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.buysell.webshop.servlets;

import com.buysell.util.Category;
import com.buysell.util.CategoryUtil;
import com.buysell.webshop.beans.wsCategory;
import com.buysell.webshop.db.CategoryDBManager;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;

/**
 *
 * @author bbsadmin
 */
public class WsCatServlet extends HttpServlet {

    private static final Logger LOG = Logger.getLogger(WsCatServlet.class);
    CategoryDBManager cu = new CategoryDBManager();
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
        String catId = request.getParameter("ci");
        int cid = Integer.parseInt(catId);
//        wsCategory wsc = cu.getCategoryByCatId(cid);
//        wsCategoryUtil wsu=new wsCategoryUtil();
        StringBuffer sbf = new StringBuffer();
        sbf.append("<response>");
        if(cid!= '0'){
        List sub = cu.getSubCategoryByCatId(cid);
        if( sub != null && sub.size() >0){
            for(Iterator itr= sub.iterator();itr.hasNext();){
                wsCategory c = (wsCategory) itr.next();
                sbf.append("<cat name= \""+c.getName()+"\" id=\""+c.getCatId()+"\" />");
            }
        }
        }
        sbf.append("</response>");
        try {
           out.print(sbf);
           out.flush();
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
