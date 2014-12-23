/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.buysell.servlets;

import com.buysell.db.DbConnection;
import com.buysell.db.DbConnectionPool;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;

/**
 *
 * @author bbsadmin
 */
public class UserCheck extends HttpServlet {

    private static Logger LOG = Logger.getLogger(UserCheck.class);
    Connection con;
    PreparedStatement ps;
    ResultSet rs;

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        LOG.info("UserCheck service() started");

        response.setContentType("text/xml;charset=UTF-8");
        PrintWriter out = response.getWriter();


        String userName = request.getParameter("un");

        StringBuffer sb = new StringBuffer("<response>");

        String qry = "select USER_ID FROM USER_LOGIN_T where LOGIN_NAME=?";



        if (userName != null) {

            try {
                con = DbConnectionPool.getConnection();
                ps = con.prepareStatement(qry);
                ps.setString(1, userName);
                rs = ps.executeQuery();
                if (rs != null && rs.next()) {
                    // this blocl executes when the given user name exixts in the data base...
                    sb.append("<check value=\"").append("NO").append("\" />");
                    sb.append("</response>");
                    out.print(sb);
                } else {

                    sb.append("<check value=\"").append("YES").append("\" />");
                    sb.append("</response>");
                    out.print(sb);
                }
                LOG.info("Xml format ::" + sb);

            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                try {
                    if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (con != null) {
                    DbConnectionPool.closeConnection(con);
                }
                    out.flush();
                    out.close();
                } catch (Exception e) {
                    LOG.error("= Exception Occured in closing db connections ::=" + e);
                }
            }

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
