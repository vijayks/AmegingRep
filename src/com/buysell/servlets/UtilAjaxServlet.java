/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.buysell.servlets;

import com.buysell.beans.RegisterFormBean;
import com.buysell.beans.UserBean;
import com.buysell.db.DbConnection;
import com.buysell.db.DbConnectionPool;
import com.buysell.util.BuySellProperties;
import com.buysell.util.Mutil;
import com.buysell.util.SendMail;
import com.buysell.util.SendSMS;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
//import org.apache.commons.httpclient.HttpClient;
//import org.apache.commons.httpclient.methods.GetMethod;
import org.apache.log4j.Logger;

/**
 *
 * @author bbsadmin
 */
public class UtilAjaxServlet extends HttpServlet {

    private static final Logger LOG = Logger.getLogger(UtilAjaxServlet.class);
    private static String str = new String("abcdefghijklmnopqrstuvwxyz0123456789");
    DbConnection db = new DbConnection();

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
//        DbConnectionPool dbp;
        StringBuffer sb = new StringBuffer();
        StringBuffer sbf = new StringBuffer("<response>");
        String act = request.getParameter("action");
        UserBean ub = (UserBean) request.getSession().getAttribute("userBean");
        LOG.info("==Request For  ==" + act);
        try {
//            HttpClient hc = new HttpClient();
            
            if(act.equalsIgnoreCase("mobileChange")){
                String mobile = request.getParameter("mobId");
                if(mobile != null){
                String val = request.getParameter("value");
                Mutil mu = new Mutil();
                sb.append(mu.getRandomCode(4));
                String code = sb.toString();
                String urlQry = "Your mobile verification code is : " + code;
                request.getSession().setAttribute("mobChVCode", code);
                String encodedurl = null;
                        try {
                            encodedurl = URLEncoder.encode(urlQry.toString(), "UTF-8");

                        } catch (UnsupportedEncodingException uee) {
                            LOG.error(" unsupported usrl exception :: " + uee);
                        }
                        
                          boolean sms = SendSMS.callSendSMS(mobile,encodedurl);
                          sbf.append("<util value=\""+sms+"\" number=\""+val+"\"").append(" />");
                }
            }
                if(act.equalsIgnoreCase("codeVer")){
                    String mobCod = request.getParameter("mobCode");
                    String mobile = request.getParameter("mobId");
                    String mobChVCod = (String) request.getSession().getAttribute("mobChVCode");
                    if(mobCod != null && mobChVCod != null && mobCod.equalsIgnoreCase(mobChVCod)){
                        int exeCode = db.executeQuery("UPDATE USER_T SET PHONE='" + mobile + "',MOBILE_CODE='V" + mobChVCod + "' WHERE USER_ID=" + ub.getUserId());
                        if(exeCode == 1){
                        ub.setMobile(mobile);
                        ub.setMvStatus("V" + mobChVCod);
                        request.getSession().setAttribute("userBean", ub);
                        sbf.append("<util value=\"true\"/>");
                        }else {
                            sbf.append("<util value=\"error\"/>");
                        }
                    }else {
                        sbf.append("<util value=\"false\"/>");
                    }
                }
            if (act.equalsIgnoreCase("recentSearch")) {
                request.getSession().removeAttribute("recentSearches");
                sbf.append("<util value=\"OK\"").append(" />");
            }
            if (act.equalsIgnoreCase("mvCode")) {
                Mutil mu = new Mutil();
                sb.append(mu.getRandomCode(4));
                String mob = request.getParameter("mn");
                String code = sb.toString();
//                String smsurl=BuySellProperties.getProperty("smsurl");
                String urlQry = "Your resend mobile Vervifcation code=" + code;
                String encodedurl = null;
                try {
                    encodedurl = URLEncoder.encode(urlQry.toString(), "UTF-8");

                } catch (UnsupportedEncodingException uee) {
                    LOG.error(" unsupported usrl exception :: " + uee);
                }
                LOG.debug("= resend verification code:: =" + code);
                request.getSession().setAttribute("mvcode", code);
//                GetMethod gm = new GetMethod(smsurl+"&mobile=" + mob + "&message=" + encodedurl);
//                hc.executeMethod(gm);
//                String res = gm.getResponseBodyAsString();
//                LOG.info(" Got response for " + urlQry + " is " + res);
//                gm.releaseConnection();
                SendSMS.callSendSMS(mob, encodedurl);
                LOG.debug("= SMS verification code::: =" + code);
                db.executeQuery("UPDATE USER_T SET MOBILE_CODE='" + code + "' WHERE USER_ID=" + ub.getUserId());
                ub.setMvStatus(code);
                sbf.append("<util value=\"CODESENT\"").append(" />");
            }
            if (act.equalsIgnoreCase("mvCodeCheck")) {
                String cde = request.getParameter("entercode");
                String sessionCode = null;
                String fdb = (String) ub.getMvStatus();
                if (fdb != null && fdb.length() > 0) {
                    sessionCode = fdb;
                }
                if (cde != null && sessionCode != null && cde.equals(sessionCode)) {
                    try {
                        if (ub != null) {
                            db.executeQuery("UPDATE USER_T SET MOBILE_CODE='V" + cde + "' WHERE USER_ID=" + ub.getUserId());
                            db.executeQuery("UPDATE USER_LOGIN_T SET STATUS=1 WHERE USER_ID=" + ub.getUserId());
                            ub.setMvStatus("V" + cde);
                            ub.setLoginType("NORMAL LOGIN");
                            ub.setUserStatus(1);
                        }
                    } catch (Exception e) {
                        LOG.debug("= Error ocured in updating mobile verification code =");
                    }
                    sbf.append("<util value=\"CODECORRET\"").append(" />");
                } else {
                    sbf.append("<util value=\"CODEWRONG\"").append(" />");
                }
            }
            if (act.equalsIgnoreCase("emailVerification")) {
                Mutil mu = new Mutil();
                String code = ub.getUserId() + mu.getRandomCode(10);
                String city = (String) request.getSession().getAttribute("city");
                if (ub != null && city != null) {
                    try {
                        db.executeQuery("UPDATE USER_T SET EMAIL_CODE='" + code + "' WHERE USER_ID=" + ub.getUserId());
                        SendMail sm = new SendMail();
                        String sub = "Resend Email Confirmation Code";
                        MessageTemplateServlet mst = new MessageTemplateServlet();
                        String msg = mst.getResendEmailVerificationCode(ub.getFirstName(), "http://bharatbuysell.com/regChk.do?ec=" + code + "&city=" + city);
                        boolean res = sm.send(ub.getLoginName(), sub, msg);
                        if (res == true) {
                            sbf.append("<util value=\"EMAILSENT\"").append(" />");
                        } else {
                            sbf.append("<util value=\"EMAILSENTWRONG\"").append(" />");
                        }

                    } catch (Exception e) {
                        LOG.debug("= error occured in resending email verification code =");
                    }
                } else {
                    sbf.append("<util value=\"EMAILSENTWRONG\"").append(" />");
                }

            }
            sbf.append("</response>");
            out.print(sbf);
            LOG.debug("== save ad Xml ==" + sbf);
        } catch (Exception e) {
            LOG.info("== Exception In UtilAjax servlet ==" + e);
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
