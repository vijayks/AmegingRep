/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.buysell.servlets;

import com.buysell.actionclass.UserAction;
import com.buysell.beans.UserBean;
import com.buysell.db.DbConnection;
import com.buysell.util.SendMail;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;

/**
 *
 * @author bbsadmin
 */
public class SendToFriendServlet extends HttpServlet {

    private static Logger LOG = Logger.getLogger(SendToFriendServlet.class);

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        LOG.info("SendToFriendServlet service() started");

        response.setContentType("text/xml;charset=UTF-8");
        PrintWriter out = response.getWriter();

        String fName = request.getParameter("fName");
        String fEmail = request.getParameter("fEmail");
        LOG.info("== Friends Name  =="+fName);
        LOG.info("== Friends Mail Address : =="+fEmail);

        boolean res = false;

        StringBuffer sb = new StringBuffer("<response>");


        try {
            SendMail sm = new SendMail();
            String sub = "Hi, " + fName + " I think you are looking for this";
            String msg = " <html><body>" +
                    "\n\n    Hello " + fName + "  Welcome to Bharatbuysell.com  \n\n" +
                    "\n\n    your  friend suggested this ad to you   \n\n " +
                    "\n\n To see more ads click   http://localhost:8080/Buysell </body</html>";

            res = sm.send(fEmail, sub, msg);
            LOG.info("== Message sent ==" + res);
        } catch (Exception e) {
            e.printStackTrace();
        }


        if (res) {
            sb.append("<send value=\"").append("YES").append("\" />");
        } else {
            sb.append("<send value=\"").append("NO").append("\" />");
        }
        sb.append("</response>");
        out.print(sb);
        out.flush();
        out.close();

        LOG.info("\n\nXml format ::" + sb + "\n\n");



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
