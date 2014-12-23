/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.buysell.servlets;

import com.buysell.actionclass.UserAction;
import com.buysell.beans.UserBean;
import com.buysell.db.DbConnection;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.StringTokenizer;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;

/**
 *
 * @author bbsadmin
 */
public class SaveSearchServlet extends HttpServlet {

    private static Logger LOG = Logger.getLogger(SaveSearchServlet.class);

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

        LOG.info("Inside SaveSearchServlet service() method");
        String searchUrl = request.getParameter("searchUrl");
        String subCatId = request.getParameter("subCatId");
        String keyword = request.getParameter("keyword");
        String city = request.getParameter("city");
        String action = request.getParameter("act");
        LOG.info("action="+action);
        LOG.info("subCatId=" + subCatId);
        LOG.info("keyword=" + keyword);
        LOG.info("searchUrl=" + searchUrl);
        LOG.info("city=" + city);
        if (keyword == null || keyword.equalsIgnoreCase("")) {
            keyword = " ";
        }
        if (subCatId == null || subCatId.equalsIgnoreCase("")) {
            subCatId = " ";
        }

        StringBuffer sb = new StringBuffer("<response>");
        DbConnection db = new DbConnection();

        StringBuffer   finalSearchPattern = new StringBuffer(keyword + "|" + subCatId + "|" + city);
        StringBuffer  finalSearchUrl = new StringBuffer(searchUrl + "keyword=" + keyword + "&subCatId=" + subCatId + "&city=" + city);
        HashMap searchPatternMap = (HashMap) request.getSession().getAttribute("smap");

        if (searchPatternMap != null) {
            String pattern = (String) searchPatternMap.get(keyword.trim());
            if (pattern != null) {
                LOG.info("pattern=" + pattern);          

                finalSearchPattern.append(pattern);
                StringTokenizer stz = new StringTokenizer(pattern, "|");
                if (stz != null) {

                    while (stz.hasMoreTokens()) {
                        String temp = stz.nextToken();
                        LOG.info("temp="+temp);
                        finalSearchUrl.append("&" + temp.replace("^", "="));
                        LOG.info("tempR="+temp.replace("^", "="));
                    }
                }
            }
            LOG.info("final=" + finalSearchPattern);
            LOG.info("finalurl="+finalSearchUrl);

        }

        try {
            if (action != null && action.equalsIgnoreCase("lss")) {

                UserBean ub = (UserBean) request.getSession().getAttribute("userBean");
                LOG.info("userBean is creatd");


                int msg = 0;
                AdsService as = new AdsService();
                msg = as.getSaveSearchCount("SELECT COUNT(*) FROM SAVED_SEARCH_T WHERE USER_ID=" + ub.getUserId());

                if (msg >= 20) {
                    sb.append("<save value=\"").append("NO").append("\" />");

                } else {
                      LOG.info("b4 qry");
                    db.executeQuery(" INSERT INTO SAVED_SEARCH_T (SEARCH_DATE, TYPE, SEARCH_URL, SEARCH_PATTERN, USER_ID) VALUES (now(),1,'" + finalSearchUrl.toString() + "','" + finalSearchPattern.toString() + "'," + ub.getUserId() + ")");
                      LOG.info("after qry");
                    sb.append("<save value=\"").append("YES").append("\" />");

                }
            } else if (action != null && action.equalsIgnoreCase("nlss")) {
            LOG.info("inside nlss");
                String loginName = request.getParameter("ln");
                String pwd = request.getParameter("pwd");
                UserBean ub = new UserBean();
                UserAction ua = new UserAction();
                ub = ua.createUserBean(pwd, loginName);
                if (ub != null) {
                    request.getSession().setAttribute("userBean", ub);
                    int msg = 0;
                    AdsService as = new AdsService();
                    LOG.info("b4 qry");
                    msg = as.getSaveSearchCount("SELECT COUNT(*) FROM SAVED_SEARCH_T WHERE USER_ID=" + ub.getUserId());
                    LOG.info("after qry");
                    if (msg >= 20) {
                        sb.append("<save value=\"").append("SSNO\"").append(" uname=\"").append(ub.getFirstName() + " " + ub.getLastName() + "\"").append(" />");

                    } else {

                        db.executeQuery(" INSERT INTO SAVED_SEARCH_T (SEARCH_DATE, TYPE, SEARCH_URL, SEARCH_PATTERN, USER_ID) VALUES (now(),1,'" + finalSearchUrl.toString() + "','" + finalSearchPattern.toString() + "'," + ub.getUserId() + ")");
                        sb.append("<save value=\"").append("SSYES\"").append(" uname=\"").append(ub.getFirstName() + " " + ub.getLastName() + "\"").append(" />");

                    }
                } else {
                    sb.append("<save value=\"").append("SSERROR").append("\" />");
                }

            }
            sb.append("</response>");
            out.print(sb);
            LOG.info("Xml format ::" + sb);
        } catch (Exception e) {
            LOG.info("Error in Search table insertion is:" + e);
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
