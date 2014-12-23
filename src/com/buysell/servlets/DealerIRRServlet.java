/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.buysell.servlets;

import com.buysell.actionclass.UserAction;
import com.buysell.beans.UserBean;
import com.buysell.db.DbConnection;
import com.buysell.util.BuySellProperties;
import com.buysell.util.SendMail;
import com.buysell.util.SendSMS;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.sql.ResultSet;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;

/**
 *
 * @author bbsadmin
 */
public class DealerIRRServlet extends HttpServlet {

    private final static Logger LOG = Logger.getLogger(DealerIRRServlet.class);
    ResultSet rs = null;
    DbConnection db = new DbConnection();
    String from = "NOTLOG";
    String maxCountString = BuySellProperties.getProperty("maxCount");
    int maxCount = 0;
    MessageTemplateServlet mst = new MessageTemplateServlet();
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        StringBuffer sb = new StringBuffer("<response>");
        int userId = 0;
        response.setContentType("text/xml;charset=UTF-8");
        PrintWriter out = response.getWriter();
        LOG.debug("== Action ==" + request.getParameter("act"));

        String action = request.getParameter("act");
        if (action == null) {
            action = "save";
        }
        UserBean ub = (UserBean) request.getSession().getAttribute("userBean");
        String sCity = (String) request.getSession().getAttribute("city");
        if (ub != null) {

            from = "LOG";
            userId = ub.getUserId();

        } else if (ub == null) {

            from = "NOTLOG";
            String pwd = request.getParameter("pwd");
            String loginName = request.getParameter("loginName");

            if (loginName != null && pwd != null && loginName.trim().length()>0 && pwd.trim().length()>0) {

                UserAction ua = new UserAction();
                if (ua != null) {
                    ub = ua.createUserBean(pwd, loginName);
                }

                if (ub != null) {
                    request.getSession().setAttribute("userBean", ub);
                    userId = ub.getUserId();
                }

            }

        }
        try {
           if (userId == 0) {
                LOG.debug("login fail");
                sb.append("<login value=\"").append("LOGINERROR").append("\"").append(" />");

            } else if (action.equals("save")) {
                LOG.debug("save");
                LOG.debug("  mv=" + ub.getMvStatus());

                if (ub.getMvStatus().startsWith("V")) {
                    LOG.debug("verified");
                    LOG.debug("mobile=" + request.getParameter("mobile"));
                    String moblie = request.getParameter("mobile");
                    String dn = request.getParameter("domainName");
                    String city = request.getParameter("city");
                    String locality =request.getParameter("locality");
                    String res = setSaveToMobileTagToXML(moblie, locality, city, dn, ub.getMobile());
                    LOG.debug("Sms Sent response ::" + res);
                    if (res.contains("SMS Sent Successfully")) {
                        setSMSTagToXML(request, sb, ub);
                    }
                    //else if (res.contains("LIMIT REACHED")) {
                      //  setSaveToMobileTagToXMLLimitReached(sb, ub);
                    //}
                    else {
                        setSMSTagToXMLFail(request, sb, ub);
                    }

                } else {
                    LOG.debug("Not-verified");
                    sb.append("<sms value=\"").append("NV").append("\"").append(" from=\"").append(from + "\"").append(" name=\"").append(ub.getFirstName() + " " + ub.getLastName()).append("\"").append(" />");
                }

            } else if (action.equals("email")) {
                LOG.debug("email");
                LOG.debug("ev=" + ub.getEvStatus() + "  mv=" + ub.getMvStatus());

                if (ub.getEvStatus().startsWith("V") || ub.getMvStatus().startsWith("V")) {
                    LOG.debug("verified");
                    setEmailTagToXML(request, sb, ub);
                } else {
                    LOG.debug("Not-verified");
                    sb.append("<email value=\"").append("NV").append("\"").append(" from=\"").append(from + "\"").append(" name=\"").append(ub.getFirstName() + " " + ub.getLastName()).append("\"").append(" />");
                }

            } else if (action.equals("contact")) {

                LOG.debug("contact");
                LOG.debug("ev=" + ub.getEvStatus() + "  mv=" + ub.getMvStatus());

                if (ub.getMvStatus().startsWith("V")) {
                    LOG.debug("verified");
                    LOG.debug("mobile=" + request.getParameter("mobile"));
                    String moblie = request.getParameter("mobile");
                    String dn = request.getParameter("domainName");
                    int dealerId = Integer.parseInt(request.getParameter("dlId"));
                    int catId = Integer.parseInt(request.getParameter("subCatId"));
                    String res = contactDlr(moblie, ub.getFirstName(), ub.getMobile(), dn, userId, sCity, dealerId, catId);
                    LOG.debug("Sms Sent response ::" + res);
                    if (res.contains("SMS Sent Successfully")) {
                        setSMSTagToXML(request, sb, ub);
                    } else if (res.contains("LIMIT REACHED")) {
                        setSMSTagToXMLLimitReached(sb, ub);
                    } else {
                        setSMSTagToXMLFail(request, sb, ub);
                    }

                } else {
                    LOG.debug("Not-verified");
                    sb.append("<sms value=\"").append("NV").append("\"").append(" from=\"").append(from + "\"").append(" name=\"").append(ub.getFirstName() + " " + ub.getLastName()).append("\"").append(" />");
                }



            }  else {
                LOG.debug("improper request");
                sb.append("<saveAd value=\"").append("ERROR").append("\"").append(" from=\"").append(from + "\"").append(" name=\"").append(ub.getFirstName() + " " + ub.getLastName()).append("\"").append(" />");
            }




        } catch (Exception e) {
            LOG.error("== Exception occured in saved ads ==" + e);

        } finally {
            sb.append("</response>");
            out.print(sb);
            LOG.debug("== save ad Xml ==" + sb);
            out.flush();
            out.close();
        }
    }

    private String setSaveToMobileTagToXML(String mob, String locality, String city, String domainName, String usMob) {

        String res = null;
        try {
            StringBuffer sbt = new StringBuffer();

            if (domainName.length() >= 36 && domainName != null) {
                sbt.append(domainName.substring(0, 32));
                sbt.append("...");
            } else {
                sbt.append(domainName);
            }
            mst = new MessageTemplateServlet();
            String urlQry = mst.getDealerInfoSmsTemplate(sbt.toString(), city, locality, mob);
            String encodedurl = null;
            try {
                encodedurl = URLEncoder.encode(urlQry.toString(), "UTF-8");

            } catch (UnsupportedEncodingException uee) {
                LOG.error(" unsupported usrl exception :: " + uee);
            }
            LOG.debug("send string:::::::::::::::::" + urlQry);
            if(SendSMS.callSendSMS(usMob, encodedurl)){
                res="SMS Sent Successfully";
            }
            else {
                res="Error while sending SMS";
            }
        } catch (Exception ex) {
            LOG.error("Error while sending the command :" + res + " for " + usMob + " \n ERROR is " + ex);
        }

        return res;
    }

    private void setEmailTagToXML(HttpServletRequest request, StringBuffer sb, UserBean ub) {

        boolean res = false;
        String fName = request.getParameter("fName");
        String fEmail = request.getParameter("fEmail");
        String name=ub.getFirstName();
        String domainName=request.getParameter("domainName");
        String dlId=request.getParameter("dlId");
        String link="http://bharatbuysell.com/dealerMoreDetails.do?dlId="+dlId;

        try {
            SendMail sm = new SendMail();
            String sub = "Hi, " +fName+" your friend " + ub.getFirstName() + " suggested this Information";

            String msg =mst.getEmailToFriendDealerInfoTemplate(name,fName,domainName,link);
            res = sm.send(fEmail, sub, msg);
        } catch (Exception e) {
            LOG.error("error while sending mail:" + e);
            sb.append("<email value=\"").append("NO").append("\"").append(" from=\"").append(from + "\"").append(" name=\"").append(ub.getFirstName() + " " + ub.getLastName()).append("\"").append(" />");
        }

        LOG.debug("== Message sent ==" + res);

        if (res) {
            sb.append("<email value=\"").append("YES").append("\"").append(" from=\"").append(from + "\"").append(" name=\"").append(ub.getFirstName() + " " + ub.getLastName()).append("\"").append(" />");
        } else {
            sb.append("<email value=\"").append("NO").append("\"").append(" from=\"").append(from + "\"").append(" name=\"").append(ub.getFirstName() + " " + ub.getLastName()).append("\"").append(" />");
        }



    }

    private void setSMSTagToXML(HttpServletRequest request, StringBuffer sb, UserBean ub) {

        sb.append("<sms value=\"").append("YES").append("\"").append(" from=\"").append(from + "\"").append(" name=\"").append(ub.getFirstName() + " " + ub.getLastName()).append("\"").append(" />");
    }

    private void setSMSTagToXMLFail(HttpServletRequest request, StringBuffer sb, UserBean ub) {

        sb.append("<sms value=\"").append("NO").append("\"").append(" from=\"").append(from + "\"").append(" name=\"").append(ub.getFirstName() + " " + ub.getLastName()).append("\"").append(" />");
    }
    
    private void setSMSTagToXMLLimitReached(StringBuffer sb, UserBean ub) {
        sb.append("<sms value=\"").append("LIMIT REACHED FOR DEALER").append("\"").append(" from=\"").append(from + "\"").append(" name=\"").append(ub.getFirstName() + " " + ub.getLastName()).append("\"").append(" />");
    }

    private String contactDlr(String mob, String fn, String usMob, String domainName, int userId, String city, int dealerId, int catId) {
        String res = null;
        int chk=0;

        try {
            StringBuffer sbt = new StringBuffer();
            StringBuffer sbn = new StringBuffer();

            if (domainName.length() >= 36 && domainName != null) {
                sbt.append(domainName.substring(0, 32));
                sbt.append("...");
            } else {
                sbt.append(domainName);
            }
            if (fn.length() > 14 && fn != null) {
                sbn.append(fn.substring(0, 13));
            } else {
                sbn.append(fn);
            }
            mst = new MessageTemplateServlet();
            String urlQry = mst.getDealerSmsTemplate(sbn.toString(), sbt.toString(), usMob);
            String encodedurl = null;
            try {
                encodedurl = URLEncoder.encode(urlQry.toString(), "UTF-8");

            } catch (UnsupportedEncodingException uee) {
                LOG.error(" unsupported usrl exception :: " + uee);
            }
            LOG.debug("send string:::::::::::::::::" + urlQry);

               long startTime = System.currentTimeMillis();
                chk = db.callLeadCheck(dealerId, "SMS", catId, userId, "1", usMob, city);
               long endTime = System.currentTimeMillis();
               LOG.debug("Time taken to call LeadCheck is "+(endTime-startTime));
               if(chk!=0){
                    if(SendSMS.callSendSMS(mob, encodedurl))
                        res="SMS Sent Successfully";
                   int st=0;
                    if (res.contains("SMS Sent Successfully")) {
                        st=1;
                    }
                    else {
                        st=2;
                    }
                    startTime = System.currentTimeMillis();
                    db.callUpdateLead(chk, dealerId, st);
                    endTime = System.currentTimeMillis();
                   LOG.debug("Time taken to call UpdateLead is "+(endTime-startTime));
               }
               else  {
                   res="LIMIT REACHED";
                   LOG.debug("Limit Reached for dealer lead count");
               }
        } catch (Exception ex) {
            LOG.error("Error while sending the command :" + res + " for " + mob + " \n ERROR is " + ex);
        }

        return res;
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
    @Override
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
         maxCount = 5;
        if (maxCountString != null) {
            try {
                maxCount = Integer.parseInt(maxCountString);
            } catch (NumberFormatException numberFormatException) {
               LOG.error("Please provide the values for maxcount");
            }
        }
    }

}
