/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.buysell.servlets;

import com.buysell.beans.UserBean;
import com.buysell.db.DbConnection;
import com.buysell.util.Mutil;
import com.buysell.util.SendSMS;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;

/**
 *
 * @author bbsadmin
 */
public class UserLeadServlet extends HttpServlet {

    private static Logger LOG = Logger.getLogger(UserLeadServlet.class);
    DbConnection db = new DbConnection();
    MessageTemplateServlet mts = new MessageTemplateServlet();

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
        String task = request.getParameter("task");
        StringBuffer sb = new StringBuffer("<response>");
        UserBean ub = (UserBean) request.getSession().getAttribute("userBean");
        try {
            int ulcount = 0;
            if (request.getSession().getAttribute("ulcount") != null) {
                ulcount = Integer.parseInt(request.getSession().getAttribute("ulcount").toString());
            }
            if (task != null && task.equals("1")) {
                if (ulcount < 5) {
                    String desc = request.getParameter("des");
                    String name = request.getParameter("nm");
                    String mob = request.getParameter("mobNum");
                    String email = request.getParameter("email");
                    String cit = request.getParameter("cit");
                    String catg = request.getParameter("catg");
                    String dlrId = request.getParameter("dlrId");
                    long userId = 0;
                    long r = 0;
                    if (ub != null) {
                        userId = ub.getUserId();
                    }
                    r = db.callStoreUserLead(mob, email, name, desc, cit, catg, userId,dlrId);
                    if (r > 0) {
                        ulcount++;
                        if (ub != null && mob.equals(ub.getMobile())) {
                            sb.append("<res resStatus=\"verSuccess\"/>");
                        } else {
                            Mutil mu = new Mutil();
                            String verCode = mu.getRandomCode(4);
                            String urlQry = mts.getUserLeadVerCodeSmsTemplate(verCode);
                            String encodedurl = null;
                            try {
                                encodedurl = URLEncoder.encode(urlQry.toString(), "UTF-8");
                            } catch (UnsupportedEncodingException uee) {
                                LOG.error(" unsupported usrl exception :: " + uee);
                            }
                            LOG.debug("= verification code for user lead :: =" + verCode);
                            request.getSession().setAttribute("ulmcode", verCode);
                            request.getSession().setAttribute("ulid", r);
                            request.getSession().setAttribute("ulcount", ulcount);
                            SendSMS.callSendSMS(mob, encodedurl);
                            sb.append("<res resStatus=\"success\"/>");
                        }
                    } else {
                        sb.append("<res resStatus=\"error\"/>");
                    }
                } else {
                    sb.append("<res resStatus=\"limitExceeded\"/>");
                }
            } else if (task != null && task.equals("2")) {
                String ulVerCode = request.getParameter("code");
                if (ulVerCode != null && ulVerCode.trim().length() > 0) {
                    if (ulVerCode.equals(request.getSession().getAttribute("ulmcode"))) {
                        db.executeQuery("UPDATE REQUESTED_LEADS_T SET STATUS=1 WHERE L_ID=" + request.getSession().getAttribute("ulid"));
                        sb.append("<res resStatus=\"success\"/>");
                    } else {
                        sb.append("<res resStatus=\"error\"/>");
                    }
                } else {
                    sb.append("<res resStatus=\"error\"/>");
                }
            }
            sb.append("</response>");
            out.print(sb.toString());
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
