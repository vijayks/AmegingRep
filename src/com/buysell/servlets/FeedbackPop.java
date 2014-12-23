/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.buysell.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.buysell.db.DbConnection;
import org.apache.log4j.Logger;

/**
 *
 * @author Karteek
 */
public class FeedbackPop extends HttpServlet {

    private final static Logger LOG = Logger.getLogger(FeedbackPop.class);

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {

        DbConnection db;
        String Name = request.getParameter("name");
        String MailId = request.getParameter("email");
        String MblNo = request.getParameter("mobileNumber");
        String Comment = request.getParameter("desc");
        db = new DbConnection();

        int res=db.executeQuery("INSERT INTO FEEDBACK_T (QNO,NAME,EMAIL_ID,TELEPHONE,COMMENT,STATUS,CREATION_DATE) VALUES ( 9, '" + Name + "', '" + MailId + "', '" + MblNo + "', '" + Comment + "',2,NOW())");
        if(res==1)
        {
            LOG.info("Pop Up FEED BACK INFO INSERTED INTO DATABASE SUCCESSFULLY");
            out.print("Success");
        }
        else
        {
            out.print("Error");
        }
        

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
