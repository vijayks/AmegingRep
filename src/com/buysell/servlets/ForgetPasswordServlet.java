/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.buysell.servlets;

import com.buysell.db.DbConnection;
import com.buysell.db.DbConnectionPool;
import com.buysell.util.SendMail;
import java.io.IOException;
import java.io.PrintWriter;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.util.Calendar;
import java.util.Random;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;

/**
 *
 * @author bbsadmin
 */
public class ForgetPasswordServlet extends HttpServlet {

    private final static Logger LOG = Logger.getLogger(ForgetPasswordServlet.class);
    private static String str = new String("a4wix2vb6u1jt7n0qd8plohc5kmrg7n0qd8plofea4w3zhc5ix2vb6u1jtyskmrgfe1frp");
    Connection con;
    PreparedStatement ps;
    ResultSet rs = null;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/xml;charset=UTF-8");
        PrintWriter out = response.getWriter();
        long st = System.currentTimeMillis();
        try {

            String mailId = request.getParameter("mailId");
            String divId = request.getParameter("itemId");
            String mobile = request.getParameter("mobile");
            StringBuffer sb = new StringBuffer();
            StringBuffer xstr = new StringBuffer("<response>");
            String phone = null;
            String name = null;
            Random r = new Random();
            int te = 0;
            for (int i = 1; i <= 9; i++) {
                te = r.nextInt(70);
                sb.append(str.charAt(te));
            }
            String pw = sb.toString();
            String qry1 = "SELECT LOGIN_NAME,PHONE,FIRST_NAME FROM USER_LOGIN_T,USER_T WHERE USER_LOGIN_T.USER_ID=USER_T.USER_ID AND LOGIN_NAME=?";

            con = DbConnectionPool.getConnection();
            ps = con.prepareStatement(qry1);
            ps.setString(1, mailId);
            rs = ps.executeQuery();

            if (rs != null) {
                if (rs.next()) {
                    phone = rs.getString(2);
                    name = rs.getString(3);
                    phone = phone.toString();
                    if (phone.equals(mobile)) {
                        String qry2 = "UPDATE USER_LOGIN_T SET LOGIN_PASSWORD=? WHERE LOGIN_NAME=?";
                        ps = con.prepareStatement(qry2);
                        ps.setString(1, pw);
                        ps.setString(2, mailId);
                        ps.executeUpdate();
                        xstr.append("<password value=\"").append("SUCCESS").
                                append("\"").append(" phone=\"").append(phone).append("\"").append(" divId=\"").append(divId).append("\"").append(" />");
                        SendMail sm = new SendMail();
                        MessageTemplateServlet mst = new MessageTemplateServlet();
                        String msg = mst.getPasswordTemp(name.trim(), mailId, pw);
                        boolean status = sm.send(mailId, "Password Resetting", msg);
                        LOG.info("==Message sent  ==" + status);
                    } else {
                        xstr.append("<password value=\"").append("WRONGMOBILE").append("\"").append(" divId=\"").append(divId).append("\"").append(" />");
                    }

                } else {
                    xstr.append("<password value=\"").append("NOID").append("\"").append(" divId=\"").append(divId).append("\"").append(" />");
                }
            } else {
                xstr.append("<password value=\"").append("ERROR").append("\"").append(" divId=\"").append(divId).append("\"").append(" />");
            }

            xstr.append("</response>");
            out.print(xstr);
            LOG.info("== save ad Xml ==" + xstr);
        } catch (Exception e) {
            LOG.info("== Error occured in resetting password ==" + e);
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
                out.close();
                long et = System.currentTimeMillis();
                LOG.debug("= Time taken to complete db operation :: =" + (et - st) + " Milli Seconds");

            } catch (Exception e) {
                LOG.error("= Exception Occured in closing db connections ::=" + e);
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
