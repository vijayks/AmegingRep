/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.buysell.servlets;

import com.buysell.db.DbConnection;
import com.buysell.db.DbConnectionPool;
import com.buysell.util.CityUtil;
import com.buysell.util.Mutil;
import com.buysell.util.SendMail;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.methods.GetMethod;
import org.apache.log4j.Logger;

/**
 *
 * @author bbsadmin
 */
public class QuickRegServlet extends HttpServlet {

    private final static Logger LOG = Logger.getLogger(QuickRegServlet.class);
    Connection con;
    PreparedStatement ps;
    ResultSet rs = null;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/xml;charset=UTF-8");
        PrintWriter out = response.getWriter();
        StringBuffer sb = new StringBuffer("<response>");
        String action = request.getParameter("action");
        try {
            if (action.equalsIgnoreCase("register")) {


                String usName = request.getParameter("userId");
                String divId = request.getParameter("divId");

                String ucode = request.getParameter("code");

                String regCode = (String) request.getSession().getAttribute("captStr");
                LOG.debug("== System generated code enter code:: ==" + regCode + "==User Entered Capticha image code ==" + ucode);

                if (regCode != null && regCode.equals(ucode)) {

                    sb.append("<register result=\"CODEOK\" ").append(" DIVID=\"").append(divId).append("\" ").append("MID=\"").append(usName).append("\" />");


                } else {
                    sb.append("<register result=\"ERRORCODE\" ").append(" DIVID=\"").append(divId).append("\" ").append("MID=\"").append(usName).append("\" />");
                }

            }

            if (action.equalsIgnoreCase("check")) {
                String userName = request.getParameter("un");
                String divId = request.getParameter("divId");
                if (userName != null) {
                    String qry = "select USER_ID FROM USER_LOGIN_T where LOGIN_NAME=?";
                    con = DbConnectionPool.getConnection();
                    ps = con.prepareStatement(qry);
                    ps.setString(1, userName);
                    rs = ps.executeQuery();

                    if (rs != null && rs.next()) {
                        // this blocl executes when the given user name exixts in the data base...
                        sb.append("<check value=\"").append("NO\"").append(" divId=\"").append(divId).append("\" />");

                    } else {

                        sb.append("<check value=\"").append("YES\"").append(" divId=\"").append(divId).append("\" />");

                    }
                }
            }
            sb.append("</response>");
            out.print(sb);
            LOG.info("== save ad Xml ==" + sb);
        } catch (Exception e) {
            LOG.info("== Exception occured in saved ads ==" + e);

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
