/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.buysell.servlets;

import com.buysell.actionclass.UserAction;
import com.buysell.beans.UserBean;
import com.buysell.db.DbConnection;
import com.buysell.util.BuySellProperties;
import com.buysell.util.Mutil;
import com.buysell.util.SMSCountUtil;
import com.buysell.util.SendMail;
import com.buysell.util.SendSMS;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.sql.ResultSet;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
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
public class InlineRequestResolveServlet extends HttpServlet {

    private final static Logger LOG = Logger.getLogger(InlineRequestResolveServlet.class);
    DbConnection db = new DbConnection();
    ResultSet rs = null;
    String from = "NOTLOG";
    String smsurl = BuySellProperties.getProperty("smsurl");
    String maxCountString = BuySellProperties.getProperty("maxCount");
    String maxPerAdString = BuySellProperties.getProperty("maxPerAd");
    int maxCount = 0;
    int maxPerAd = 0;
    MessageTemplateServlet mst = new MessageTemplateServlet();
    
    SMSCountUtil scu;

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


        //weather user login or not?



        UserBean ub = (UserBean) request.getSession().getAttribute("userBean");
        if (ub != null) {

            from = "LOG";
            userId = ub.getUserId();

        } else if (ub == null) {

            from = "NOTLOG";
            String pwd = request.getParameter("pwd");
            String loginName = request.getParameter("loginName");

            if (loginName != null && pwd != null) {

                UserAction ua = new UserAction();
                if (ua != null) {
                    ub = ua.createUserBean(pwd, loginName);
                }

                if (ub != null) {
                    request.getSession().setAttribute("userBean", ub);
                    userId = ub.getUserId();
                }

            } else {
                String userName = request.getParameter("userName");
                String fname = request.getParameter("firstName");
                String city = request.getParameter("city");
                String phoneNum = request.getParameter("mobile");
                java.sql.Date dob = null;
                int uId = 0;
                Mutil mu = new Mutil();
                String ran = mu.getRandomCode(10);// this code for to append email confirmation code

                Mutil mu2 = new Mutil();
                String mc = mu2.getRandomCode(4);
                if(userName!=null && userName.trim().length()>0 && phoneNum!=null && phoneNum.trim().length()>0) {
                uId = db.callRegister("", "", city, "", "", "", "", fname, "", phoneNum, dob, "", "", userName, phoneNum, "quick", mc, 2);
                String code = uId + ran;
                if (uId != 0) {
                    if (phoneNum != null) {
                        String urlQry = mst.getSmsCodeTemplate(mc);
                        String encodedurl = null;
                        try {
                            encodedurl = URLEncoder.encode(urlQry.toString(), "UTF-8");
                            SendSMS.callSendSMS(phoneNum, encodedurl);
                            request.getSession().setAttribute("mvcode", code);
                            LOG.debug("= Mobile verification code sent to user is:: =" + mc);
                        } catch (UnsupportedEncodingException uee) {
                            LOG.error(" unsupported url exception :: " + uee);
                        }
                        db.executeQuery("UPDATE USER_T SET EMAIL_CODE='" + code + "' WHERE USER_ID=" + uId);
                        request.getSession().setAttribute("ln", userName);
                        request.getSession().setAttribute("phpwd", phoneNum);
                        SendMail sm = new SendMail();
                        String sub = "Registration Confirmation";
                        MessageTemplateServlet mst = new MessageTemplateServlet();
                        String msg = mst.getRegistrationTemp(fname, userName, phoneNum, "http://bharatbuysell.com/regChk.do?ec=" + code + "&city=" + city);
                        try {
                        boolean res2 = sm.send(userName, sub, msg);
                        LOG.debug(" =Email confirmation code is:: " + code);
                        LOG.info("==Registration confirmation mail response:: ==" + res2);
                        } catch(Exception e) {

                        }
                        request.getSession().removeAttribute("captStr");
                        LOG.info("== quick registration process completed succssfully and his id is:: ==" + uId);

                        request.getSession().setAttribute("quickRegSave", "Some Message");
                    }
                    from = "REG";
                    UserAction ua = new UserAction();
                    if (ua != null) {
                        ub = ua.createUserBean(phoneNum, userName);
                    }
                    if (ub != null) {
                        request.getSession().setAttribute("userBean", ub);
                        userId = ub.getUserId();
                    }
                }
                }

            }

        }




        try {

            if (userId == 0) {
                LOG.debug("login fail");
                sb.append("<login value=\"").append("LOGINERROR").append("\"").append(" />");

            } else if (action.equals("save")) {
                LOG.debug("save");
                setSaveAdTagToXML(request, sb, ub);

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

            } else if (action.equals("sms")) {

                LOG.debug("sms");
                LOG.debug("ev=" + ub.getEvStatus() + "  mv=" + ub.getMvStatus());

                if (ub.getMvStatus().startsWith("V")) {
                    LOG.debug("verified");
                    LOG.debug("mobile=" + request.getParameter("mobile"));
                    String moblie = request.getParameter("mobile");
                    String adt = request.getParameter("adTitle");
                    String adId = request.getParameter("adId");
                    String uid = "" + ub.getUserId();
                    String res = sendSMS2Advt(moblie, ub.getFirstName(), ub.getMobile(), adt, adId, uid);
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



            } else if (action.equals("search")) {
                LOG.debug("search");

                setSearchTagToXML(request, sb, ub);

            } else if (action.equals("alert")) {
                LOG.debug("alert");
                setAlertTagToXML(request, sb, ub);
            } else if (action.equals("view")) {
                LOG.debug("view");
                setViewTagToXML(request, sb, ub);
            } else {
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

    private void setSaveAdTagToXML(HttpServletRequest request, StringBuffer sb, UserBean ub) {

        int adId = 0;
        String a = (String) request.getParameter("adId");
        LOG.debug("== Ad Id: ==" + a);
        try {
            adId = Integer.parseInt(a);
        } catch (Exception e) {
            LOG.error("adId is not a number:" + e);
        }

        String res = null;
        res = db.callSaveAdPro(adId, ub.getUserId());
        LOG.debug("== Result from Procedure ==" + res);
        if (res != null) {
            if (res.equalsIgnoreCase("success")) {
                sb.append("<saveAd value=\"").append("YES").append("\"").append(" from=\"").append(from + "\"").append(" name=\"").append(ub.getFirstName() + " " + ub.getLastName()).append("\"").append(" />");

            } else if (res.equalsIgnoreCase("over")) {
                sb.append("<saveAd value=\"").append("OVER").append("\"").append(" from=\"").append(from + "\"").append(" name=\"").append(ub.getFirstName() + " " + ub.getLastName()).append("\"").append(" />");

            } else if (res.equalsIgnoreCase("exist")) {
                sb.append("<saveAd value=\"").append("EXIST").append("\"").append(" from=\"").append(from + "\"").append(" name=\"").append(ub.getFirstName() + " " + ub.getLastName()).append("\"").append(" />");

            } else if (res.equalsIgnoreCase("ownad")) {
                sb.append("<saveAd value=\"").append("OWNAD").append("\"").append(" from=\"").append(from + "\"").append(" name=\"").append(ub.getFirstName() + " " + ub.getLastName()).append("\"").append(" />");
            }
        } else {
            sb.append("<saveAd value=\"").append("ERROR").append("\"").append(" from=\"").append(from + "\"").append(" name=\"").append(ub.getFirstName() + " " + ub.getLastName()).append("\"").append(" />");
        }


    }

    private void setEmailTagToXML(HttpServletRequest request, StringBuffer sb, UserBean ub) {

        boolean res = false;
        String fName = request.getParameter("fName");
        String fEmail = request.getParameter("fEmail");
        String name=ub.getFirstName();
        String title=request.getParameter("title");
        String adId=request.getParameter("adId");
        String catId=request.getParameter("catId");
        String link="http://bharatbuysell.com/moreDetailsEmail.do?adId="+adId+"&catId="+catId+"&city=All India";

        try {
            SendMail sm = new SendMail();
            String sub = "Hi, " +fName+" your friend " + ub.getFirstName() + " suggested this Ad";

            String msg =mst.getEmailToFriendTemplate(name,fName,title,link);
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
        sb.append("<sms value=\"").append("LIMIT REACHED").append("\"").append(" from=\"").append(from + "\"").append(" name=\"").append(ub.getFirstName() + " " + ub.getLastName()).append("\"").append(" />");
    }

    private void setSearchTagToXML(HttpServletRequest request, StringBuffer sb, UserBean ub) {

        String searchUrl = request.getParameter("searchUrl");
        String subCatId = request.getParameter("subCatId");
        String keyword = request.getParameter("keyword");

        String city = (String) request.getSession().getAttribute("city");
        LOG.debug("subCatId=" + subCatId);
        LOG.debug("keyword=" + keyword);
        LOG.debug("searchUrl=" + searchUrl);
        LOG.debug("city=" + city);
        if (keyword == null || keyword.trim().length() == 0) {
            keyword = " ";
        }
        if (subCatId == null || subCatId.trim().length() == 0) {
            subCatId = "0";
        }


        String finalSearchPattern = null;
        String finalSearchUrl = searchUrl;
        HashMap searchPatternMap = (HashMap) request.getSession().getAttribute("smap");

        if (searchPatternMap != null) {

            finalSearchPattern = (String) searchPatternMap.get("qryStr");

            if (finalSearchPattern == null) {
                LOG.debug("pattern=" + finalSearchPattern);
                finalSearchPattern = "";

            }
        }
        LOG.debug("final=" + finalSearchPattern);
        LOG.debug("finalurl=" + finalSearchUrl);

        int searchCount = 0;
        AdsService as = new AdsService();

        searchCount = as.getSaveSearchCount("SELECT COUNT(*) FROM SAVED_SEARCH_T WHERE USER_ID=" + ub.getUserId());

        if (searchCount >= 20) {
            sb.append("<search value=\"").append("LIMIT").append("\"").append(" from=\"").append(from + "\"").append(" name=\"").append(ub.getFirstName() + " " + ub.getLastName()).append("\"").append(" />");

        } else {
            int res = 0;
            res = db.executeQuery(" INSERT INTO SAVED_SEARCH_T (SEARCH_DATE, TYPE, SEARCH_URL, SEARCH_PATTERN, USER_ID) VALUES (now(),1,'" + finalSearchUrl + "','" + finalSearchPattern + "'," + ub.getUserId() + ")");
            if (res == 1) {
                sb.append("<search value=\"").append("YES").append("\"").append(" from=\"").append(from + "\"").append(" name=\"").append(ub.getFirstName() + " " + ub.getLastName()).append("\"").append(" />");
            } else {
                sb.append("<search value=\"").append("NO").append("\"").append(" from=\"").append(from + "\"").append(" name=\"").append(ub.getFirstName() + " " + ub.getLastName()).append("\"").append(" />");
            }

        }

    }

    private void setAlertTagToXML(HttpServletRequest request, StringBuffer sb, UserBean ub) {

        String keyword = request.getParameter("keyword");
        String subCatId = request.getParameter("subCatId");
        String city = (String) request.getSession().getAttribute("city");

        String d1, d2, m1, m2, y1, y2;
        d1 = request.getParameter("day1");
        m1 = request.getParameter("month1");
        y1 = request.getParameter("year1");
        d2 = request.getParameter("day2");
        m2 = request.getParameter("month2");
        y2 = request.getParameter("year2");
        int day1 = Integer.parseInt(d1);
        int month1 = Integer.parseInt(m1);
        int year1 = Integer.parseInt(y1);
        int day2 = Integer.parseInt(d2);
        int month2 = Integer.parseInt(m2);
        int year2 = Integer.parseInt(y2);
        Calendar cal1 = Calendar.getInstance();
        cal1.set(year1, month1, day1);
        Calendar cal2 = Calendar.getInstance();
        cal2.set(year2, month2, day2);


        LOG.debug("keyword=" + keyword);
        LOG.debug("category=" + subCatId);
        LOG.debug("city=" + city);
        LOG.debug("date1=" + day1 + "-" + month1 + "-" + year1);
        LOG.debug("date2=" + day2 + "-" + month2 + "-" + year2);

        if (keyword == null || keyword.trim().length() == 0) {
            keyword = " ";
        }
        if (subCatId == null || subCatId.trim().length() == 0) {
            subCatId = "0";
        }

        boolean leapYear1;
        boolean leapYear2;
        String date1Chk = null;
        String date2Chk = null;
        String diffChk = null;
        String initalDateChk = null;
        String noDate = null;
        boolean monthValid1;
        boolean yearValid1;
        boolean dayValid1;
        boolean monthValid2;
        boolean yearValid2;
        boolean dayValid2;
        int daysInMonth1;
        int daysInMonth2;

        if (true) {
            month1++;
            month2++;
            if (day1 == 0 || month1 == 0 || year1 == 0 || day2 == 0 || month2 == 0 || year2 == 0) {
                noDate = "YES";
            } else {
                noDate = "NO";
            }
        }
        /* Alert date1 checking */
        if (month1 >= 0 && month1 <= 12) {
            monthValid1 = true;
        } else {
            monthValid1 = false;
        }

        //Check to see if year is valid
        if (year1 >= 1000 && year1 <= 2015) {
            yearValid1 = true;
        } else {
            yearValid1 = false;
        }
        //Determine whether it's a leap year
        if ((year1 % 400 == 0) || (year1 % 100 != 0 && year1 % 4 == 0)) {
            leapYear1 = true;
        } else {
            leapYear1 = false;
        }
        //Determine number of days in month
        if (month1 == 1 || month1 == 3 || month1 == 5 || month1 == 7 || month1 == 8 || month1 == 10 || month1 == 12) {
            daysInMonth1 = 31;
        } else if (month1 == 4 || month1 == 6 || month1 == 9 || month1 == 11) {
            daysInMonth1 = 30;
        } else {
            if (month1 == 2 && leapYear1 == true) {
                daysInMonth1 = 29;
            } else {
                daysInMonth1 = 28;
            }
        }
        //User number of days in month to check to see if day is valid
        if (day1 >= 1 && day1 <= daysInMonth1) {
            dayValid1 = true;
        } else {
            dayValid1 = false;
        }
        //Determine whether date is valid and print appropriate message
        if (dayValid1 == false || monthValid1 == false || yearValid1 == false) {
            date1Chk = "WRONG";
        } else {
            date1Chk = "OK";
        }



        /*****************day 2 checking *************************/
        if (month2 >= 1 && month2 <= 12) {
            monthValid2 = true;
        } else {
            monthValid2 = false;
        }

        //Check to see if year is valid
        if (year2 >= 1000 && year2 <= 2015) {
            yearValid2 = true;
        } else {
            yearValid2 = false;
        }
        //Determine whether it's a leap year
        if ((year2 % 400 == 0) || (year2 % 100 != 0 && year2 % 4 == 0)) {
            leapYear2 = true;
        } else {
            leapYear2 = false;
        }
        //Determine number of days in month
        if (month2 == 1 || month2 == 3 || month2 == 5 || month2 == 7 || month2 == 8 || month2 == 10 || month2 == 12) {
            daysInMonth2 = 31;
        } else if (month2 == 4 || month2 == 6 || month2 == 9 || month2 == 11) {
            daysInMonth2 = 30;
        } else {
            if (month2 == 2 && leapYear2 == true) {
                daysInMonth2 = 29;
            } else {
                daysInMonth2 = 28;
            }
        }
        //User number of days in month to check to see if day is valid
        if (day2 >= 1 && day2 <= daysInMonth2) {
            dayValid2 = true;
        } else {
            dayValid2 = false;
        }
        //Determine whether date is valid and print appropriate message
        if (dayValid2 == false || monthValid2 == false || yearValid2 == false) {
            date2Chk = "WRONG";
        } else {
            date2Chk = "OK";
        }

        /****************Initial date check ****************/
        Calendar current = Calendar.getInstance();
        long milis1 = current.getTimeInMillis();
        long milis2 = cal1.getTimeInMillis();
        long diff = milis2 - milis1;
        if (diff >= 0) {
            initalDateChk = "OK";
        } else {
            initalDateChk = "WRONG";
        }

        /****************end date check ****************/
        long milis3 = cal2.getTimeInMillis();
        long diff2dates = milis3 - milis2;
        if (diff2dates >= 0) {
            diffChk = "OK";
        } else {
            diffChk = "WRONG";
        }

        if (noDate.equals("YES") || !date1Chk.equals("OK") || !date2Chk.equals("OK") || !diffChk.equals("OK") || !initalDateChk.equals("OK")) {
            sb.append("<alert value=\"").append("INVALIDDATE").append("\"").append(" from=\"").append(from + "\"").append(" name=\"").append(ub.getFirstName() + " " + ub.getLastName()).append("\"").append(" />");
        } else {

            Date date1 = cal1.getTime();


            Date date2 = cal2.getTime();
            java.sql.Date date11 = new java.sql.Date(date1.getTime());
            java.sql.Date date22 = new java.sql.Date(date2.getTime());

            String finalAlertPattern = null;
            HashMap alertPatternMap = (HashMap) request.getSession().getAttribute("smap");
            if (alertPatternMap != null) {

                LOG.debug("keyword=" + alertPatternMap.get(keyword.trim()));
                LOG.debug("keyword=" + alertPatternMap.get("$NULL$"));

                if (keyword != null && keyword.trim().length() > 0) {
                    finalAlertPattern = (String) alertPatternMap.get(keyword.trim());
                } else {
                    finalAlertPattern = (String) alertPatternMap.get("$NULL$");
                }
                if (finalAlertPattern == null) {

                    finalAlertPattern = "";
                }
            }

            int alertCount = 0;
            AdsService ads = new AdsService();

            // already save search count written so use that method so dont confuse....
            alertCount = ads.getSaveSearchCount("SELECT COUNT(*) FROM ALERT_T WHERE USER_ID=" + ub.getUserId());
            if (alertCount >= 10) {

                sb.append("<alert value=\"").append("LIMIT").append("\"").append(" from=\"").append(from + "\"").append(" name=\"").append(ub.getFirstName() + " " + ub.getLastName()).append("\"").append(" />");

            } else {


                int res = 0;

                res = db.executeQuery("INSERT INTO ALERT_T (ALERT_CREATION_DATE,ALERT_FROM,ALERT_TO,ALERT_PATTERN,USER_ID) VALUES(NOW(),'" + date11 + "','" + date22 + "','" + finalAlertPattern.toString() + "'," + ub.getUserId() + ")");

                if (res == 1) {
                    sb.append("<alert value=\"").append("YES").append("\"").append(" from=\"").append(from + "\"").append(" name=\"").append(ub.getFirstName() + " " + ub.getLastName()).append("\"").append(" />");
                } else {
                    sb.append("<alert value=\"").append("NO").append("\"").append(" from=\"").append(from + "\"").append(" name=\"").append(ub.getFirstName() + " " + ub.getLastName()).append("\"").append(" />");
                }

            }

        }
    }

    private String sendSMS2Advt(String mob, String fn, String usMob, String adTitle, String adId, String userId) {
        String res = null;
        try {
//            HttpClient hc = new HttpClient();
            StringBuffer sbt = new StringBuffer();
            StringBuffer sbn = new StringBuffer();

            if (adTitle.length() >= 36 && adTitle != null) {
                sbt.append(adTitle.substring(0, 32));
                sbt.append("...");
            } else {
                sbt.append(adTitle);
            }
            if (fn.length() > 14 && fn != null) {
                sbn.append(fn.substring(0, 13));
            } else {
                sbn.append(fn);
            }
            MessageTemplateServlet mst = new MessageTemplateServlet();
            String urlQry = mst.getSmsTemplate(sbn.toString(), sbt.toString(), usMob);
            String encodedurl = null;
            try {
                encodedurl = URLEncoder.encode(urlQry.toString(), "UTF-8");

            } catch (UnsupportedEncodingException uee) {
                LOG.error(" unsupported usrl exception :: " + uee);
            }
            LOG.debug("send string:::::::::::::::::" + urlQry);

            boolean abletoSendCheck = scu.isAbleToSendSMS(userId, adId);
            LOG.debug("= able to send check response :: =" + abletoSendCheck);
            if (abletoSendCheck == true) {
//                GetMethod gm = new GetMethod(smsurl + "&mobile=" + mob + "&message=" + encodedurl);
//                hc.executeMethod(gm);
//                res = gm.getResponseBodyAsString();
//                LOG.debug(" Got response for " + urlQry + " is " + res);
//                gm.releaseConnection();
                if(SendSMS.callSendSMS(mob, encodedurl))
                    res="SMS Sent Successfully";
                boolean updateSmsCountCheck = scu.updateSmsCountForUserNAdd(userId, adId);
                LOG.debug("= Update sms count for user check =" + updateSmsCountCheck);
            } else {
                res = "LIMIT REACHED";
            }


        } catch (Exception ex) {
            LOG.error("Error while sending the command :" + res + " for " + mob + " \n ERROR is " + ex);
        }

        return res;
    }

    private void setViewTagToXML(HttpServletRequest request, StringBuffer sb, UserBean ub) {

        int adId = 0;
        String a = (String) request.getParameter("adId");
        LOG.debug("== Ad Id: ==" + a);
        try {
            adId = Integer.parseInt(a);
        } catch (Exception e) {
            LOG.error("adId is not a number:" + e);
        }
        String adPostedUserId = request.getParameter("adPostedUserId");
        int res = 0;
        String qry = "INSERT INTO RESPONSE_T (USER_ID, USER_NAME, EMAIL, CONTACT, CITY, RESPONSE_DATE, RELATED_USER_ID, RELATED_ID, RESPONSE_TYPE, STATUS) VALUES(" + ub.getUserId() + ",'" + ub.getFirstName() + " " +ub.getLastName()+"','" + ub.getLoginName() + "','" + ub.getMobile() + "','" + request.getSession().getAttribute("city") + "', NOW(),"+adPostedUserId+"," + adId + ", 'AD', 1)";
        res = db.executeQuery(qry);
        LOG.debug("== Result from Method ==" + res);
        if (res == 1) {
            sb.append("<viewCon value=\"").append("YES").append("\"").append(" from=\"").append(from + "\"").append(" name=\"").append(ub.getFirstName() + " " + ub.getLastName()).append("\"").append(" />");
        } else {
            sb.append("<viewCon value=\"").append("ERROR").append("\"").append(" from=\"").append(from + "\"").append(" name=\"").append(ub.getFirstName() + " " + ub.getLastName()).append("\"").append(" />");
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
            throws ServletException,
            IOException {
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
            throws ServletException,
            IOException {
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
         maxPerAd=1;
        if (maxCountString != null) {
            try {
                maxCount = Integer.parseInt(maxCountString);
            } catch (NumberFormatException numberFormatException) {
               LOG.error("Please provide the values for maxcount");
            }
        }
        if (maxPerAdString != null) {
            try {
                maxPerAd = Integer.parseInt(maxPerAdString);
            } catch (NumberFormatException numberFormatException) {
                LOG.error("Please provide the values for maxPerAd count");
                
            }
        }
        scu = new SMSCountUtil("/Buy-Sell/SMS", maxCount, maxPerAd);

    }
}
