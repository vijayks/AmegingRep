/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.buysell.actionclass;

import com.buysell.db.DbConnection;
import com.buysell.servlets.AdsService;
import com.buysell.servlets.MessageTemplateServlet;
import com.buysell.util.Mutil;
import com.buysell.util.SendMail;
import com.buysell.util.SendSMS;
import com.buysell.util.SmsStoreUtil;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.sql.Date;
import java.util.HashMap;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

/**
 *
 * @author bbsadmin
 */
public class QuickRegistrationAction extends Action {

    /* forward name="success" path="" */
    private static final String SUCCESS = "success";
    private static final String QRNSAVE = "qrnsave";
    private static final String QRNSMS = "qrnsms";
    private static final String QRNEMAIL = "qrnemail";
    private static final String QRNALERT = "qrnalert";
    private static final String QRNSEARCH = "qrnsearch";
    private static Logger LOG = Logger.getLogger(QuickRegistrationAction.class);
    DbConnection db = new DbConnection();
    SmsStoreUtil ssu = new SmsStoreUtil();
    MessageTemplateServlet mst=new MessageTemplateServlet();

    /**
     * This is the action called from the Struts framework.
     * @param mapping The ActionMapping used to select this instance.
     * @param form The optional ActionForm bean for this request.
     * @param request The HTTP Request we are processing.
     * @param response The HTTP Response we are processing.
     * @throws java.lang.Exception
     * @return
     */
    @Override
    public ActionForward execute(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        String adId = request.getParameter("adId");
        String userName = request.getParameter("userName");
        String fname = request.getParameter("firstName");
        String city = request.getParameter("city");
        String phoneNum = request.getParameter("mobile");
        String purpose = request.getParameter(adId + "purpose");
//        String smsurl = BuySellProperties.getProperty("smsurl");
        Date dob = null;
        int uId = 0;
        Mutil mu = new Mutil();
        String ran = mu.getRandomCode(10);// this code for to append email confirmation code

        Mutil mu2 = new Mutil();
        String mc = mu2.getRandomCode(4);

        LOG.debug("=  =" + adId);
        LOG.debug("=  =" + userName);
        LOG.debug("=  =" + fname);
        LOG.debug("=  =" + city);
        LOG.debug("=  =" + phoneNum);
        LOG.debug("=  =" + purpose);


        if (purpose != null && purpose.equals("save")) {
            String sid = adId.substring(2);
            int saveadId = Integer.parseInt(sid);
            uId = db.callRegister("", "", city, "", "", "", "", fname, "", phoneNum, dob, "", "", userName, phoneNum, "quick", mc, 2);
            String code = uId + ran;
            if (uId != 0) {
                if (phoneNum != null) {
//                    HttpClient hc = new HttpClient();
                    String urlQry = mst.getSmsCodeTemplate(mc);
                    String encodedurl = null;
                    try {
                        encodedurl = URLEncoder.encode(urlQry.toString(), "UTF-8");
//                        GetMethod gm = new GetMethod(smsurl + "&mobile=" + phoneNum + "&message=" + encodedurl);
//                        hc.executeMethod(gm);
//                        String res1 = gm.getResponseBodyAsString();
//                        LOG.info(" response from mobile perfectsmsc.com message api is::" + res1);
//                        gm.releaseConnection();
                        SendSMS.callSendSMS(phoneNum, encodedurl);
                        request.getSession().setAttribute("mvcode", code);
                        LOG.debug("= Mobile verification code sent to user is:: =" + mc);
                    } catch (UnsupportedEncodingException uee) {
                        LOG.error(" unsupported url exception :: " + uee);
//                      
                    }
                    db.executeQuery("UPDATE USER_T SET EMAIL_CODE='" + code + "' WHERE USER_ID=" + uId);
                    request.getSession().setAttribute("ln", userName);
                    request.getSession().setAttribute("phpwd", phoneNum);
                    SendMail sm = new SendMail();
                    String sub = "Registration Confirmation";
                    MessageTemplateServlet mst = new MessageTemplateServlet();
                    String msg = mst.getRegistrationTemp(fname, userName, phoneNum, "http://bharatbuysell.com/regChk.do?ec=" + code + "&city=" + city);
                    boolean res2 = sm.send(userName, sub, msg);
                    LOG.debug(" =Email confirmation code is:: " + code);
                    LOG.info("==Registration confirmation mail response:: ==" + res2);
                    request.getSession().removeAttribute("captStr");
                    LOG.info("== quick registration process completed succssfully and his id is:: ==" + uId);

                    db.callSaveAdPro(saveadId, uId);// here save the ad
                    request.getSession().setAttribute("quickRegSave", "Some Message");
                    return mapping.findForward(QRNSAVE);
                }
            }

        } else if (purpose != null && purpose.equals("save search")) {
            uId = db.callRegister("", "", city, "", "", "", "", fname, "", phoneNum, dob, "", "", userName, phoneNum, "quick", mc, 2);
            String code = uId + ran;
            if (uId != 0) {
                if (phoneNum != null) {
//                    HttpClient hc = new HttpClient();
                    String urlQry = "Your mobile verification code=" + mc;
                    String encodedurl = null;
                    try {
                        encodedurl = URLEncoder.encode(urlQry.toString(), "UTF-8");
//                        GetMethod gm = new GetMethod(smsurl + "&mobile=" + phoneNum + "&message=" + encodedurl);
//                        hc.executeMethod(gm);
//                        String res1 = gm.getResponseBodyAsString();
//                        LOG.info(" response from mobile perfectsmsc.com message api is::" + res1);
//                        gm.releaseConnection();
                        SendSMS.callSendSMS(phoneNum, encodedurl);
                        request.getSession().setAttribute("mvcode", code);
                        LOG.debug("= Mobile verification code sent to user is:: =" + mc);
                    } catch (UnsupportedEncodingException uee) {
                        LOG.error(" unsupported url exception :: " + uee);
//
                    }
                    db.executeQuery("UPDATE USER_T SET EMAIL_CODE='" + code + "' WHERE USER_ID=" + uId);
                    request.getSession().setAttribute("ln", userName);
                    request.getSession().setAttribute("phpwd", phoneNum);
                    SendMail sm = new SendMail();
                    String sub = "Registration Confirmation";
                    MessageTemplateServlet mst = new MessageTemplateServlet();
                    String msg = mst.getRegistrationTemp(fname, userName, phoneNum, "http://bharatbuysell.com/regChk.do?ec=" + code + "&city=" + city);
                    boolean res2 = sm.send(userName, sub, msg);
                    LOG.debug(" =Email confirmation code is:: " + code);
                    LOG.info("==Registration confirmation mail response:: ==" + res2);
                    request.getSession().removeAttribute("captStr");
                    LOG.info("== quick registration process completed succssfully and his id is:: ==" + uId);


                    //Save search login written here
                    String keyword = (String) request.getParameter("keyword");
                    String subCatId = (String) request.getParameter("subCatId");
                    String searchUrl = (String) request.getParameter("searchUrl");


                    LOG.info("subCatId=" + subCatId);
                    LOG.info("keyword=" + keyword);
                    LOG.info("searchUrl=" + searchUrl);
                    LOG.info("city=" + city);
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
                            LOG.info("pattern=" + finalSearchPattern);
                            finalSearchPattern = "";
                        }
                    }
                    LOG.info("final=" + finalSearchPattern);
                    LOG.info("finalurl=" + finalSearchUrl);
                    int searchCount = 0;
                    AdsService as = new AdsService();

                    searchCount = as.getSaveSearchCount("SELECT COUNT(*) FROM SAVED_SEARCH_T WHERE USER_ID=" + uId);
                    int res = 0;
                    res = db.executeQuery(" INSERT INTO SAVED_SEARCH_T (SEARCH_DATE, TYPE, SEARCH_URL, SEARCH_PATTERN, USER_ID) VALUES (now(),1,'" + finalSearchUrl + "','" + finalSearchPattern + "'," + uId + ")");
                    if (res == 1) {
                    } else {
                    }
                    request.getSession().setAttribute("quickRegSaveSearch", "Some Message");
                    return mapping.findForward(QRNSEARCH);
                }
            }


        } else if (purpose != null && purpose.equals("save alert")) {

           
          
            uId = db.callRegister("", "", city, "", "", "", "", fname, "", phoneNum, dob, "", "", userName, phoneNum, "quick", mc, 2);
            String code = uId + ran;
            if (uId != 0) {
                if (phoneNum != null) {
//                    HttpClient hc = new HttpClient();
                    String urlQry = "Your mobile verification code=" + mc;
                    String encodedurl = null;
                    try {
                        encodedurl = URLEncoder.encode(urlQry.toString(), "UTF-8");
//                        GetMethod gm = new GetMethod(smsurl + "&mobile=" + phoneNum + "&message=" + encodedurl);
//                        hc.executeMethod(gm);
//                        String res1 = gm.getResponseBodyAsString();
//                        LOG.info(" response from mobile perfectsmsc.com message api is::" + res1);
//                        gm.releaseConnection();
                        SendSMS.callSendSMS(phoneNum, encodedurl);
                        request.getSession().setAttribute("mvcode", code);
                        LOG.debug("= Mobile verification code sent to user is:: =" + mc);
                    } catch (UnsupportedEncodingException uee) {
                        LOG.error(" unsupported url exception :: " + uee);
//
                    }
                    db.executeQuery("UPDATE USER_T SET EMAIL_CODE='" + code + "' WHERE USER_ID=" + uId);
                    request.getSession().setAttribute("ln", userName);
                    request.getSession().setAttribute("phpwd", phoneNum);
                    SendMail sm = new SendMail();
                    String sub = "Registration Confirmation";
                    MessageTemplateServlet mst = new MessageTemplateServlet();
                    String msg = mst.getRegistrationTemp(fname, userName, phoneNum, "http://bharatbuysell.com/regChk.do?ec=" + code + "&city=" + city);
                    boolean res2 = sm.send(userName, sub, msg);
                    LOG.debug(" =Email confirmation code is:: " + code);
                    LOG.info("==Registration confirmation mail response:: ==" + res2);
                    request.getSession().removeAttribute("captStr");
                    LOG.info("== quick registration process completed succssfully and his id is:: ==" + uId);

                    request.getSession().setAttribute("quickRegSaveAlert", "Some Message");
                    return mapping.findForward(QRNALERT);
                }
            }

        } else if (purpose != null && purpose.equals("emailFriend")) {
                   
            uId = db.callRegister("", "", city, "", "", "", "", fname, "", phoneNum, dob, "", "", userName, phoneNum, "quick", mc, 2);
            String code = uId + ran;
            if (uId != 0) {
                if (phoneNum != null) {
//                    HttpClient hc = new HttpClient();
                    String urlQry = "Your mobile verification code=" + mc;
                    String encodedurl = null;
                    try {
                        encodedurl = URLEncoder.encode(urlQry.toString(), "UTF-8");
//                        GetMethod gm = new GetMethod(smsurl + "&mobile=" + phoneNum + "&message=" + encodedurl);
//                        hc.executeMethod(gm);
//                        String res1 = gm.getResponseBodyAsString();
//                        LOG.info(" response from mobile perfectsmsc.com message api is::" + res1);
//                        gm.releaseConnection();
                        SendSMS.callSendSMS(phoneNum, encodedurl);
                        request.getSession().setAttribute("mvcode", code);
                        LOG.debug("= Mobile verification code sent to user is:: =" + mc);
                    } catch (UnsupportedEncodingException uee) {
                        LOG.error(" unsupported url exception :: " + uee);
//
                    }
                    db.executeQuery("UPDATE USER_T SET EMAIL_CODE='" + code + "' WHERE USER_ID=" + uId);
                    request.getSession().setAttribute("ln", userName);
                    request.getSession().setAttribute("phpwd", phoneNum);
                    SendMail sm = new SendMail();
                    String sub = "Registration Confirmation";
                    MessageTemplateServlet mst = new MessageTemplateServlet();
                    String msg = mst.getRegistrationTemp(fname, userName, phoneNum, "http://bharatbuysell.com/regChk.do?ec=" + code + "&city=" + city);
                    boolean res2 = sm.send(userName, sub, msg);
                    LOG.debug(" =Email confirmation code is:: " + code);
                    LOG.info("==Registration confirmation mail response:: ==" + res2);
                    request.getSession().removeAttribute("captStr");
                    LOG.info("== quick registration process completed succssfully and his id is:: ==" + uId);

                    request.getSession().setAttribute("quickRegEmail", "Some Message");
                    return mapping.findForward(QRNEMAIL);
                }
            }



        } else if (purpose != null && purpose.equals("smsadvt")) {
            String sid = adId.substring(2);
            int smsSendAdId = Integer.parseInt(sid);
            uId = db.callRegister("", "", city, "", "", "", "", fname, "", phoneNum, dob, "", "", userName, phoneNum, "quick", mc, 2);
            String code = uId + ran;
            if (uId != 0) {
                if (phoneNum != null) {
//                    HttpClient hc = new HttpClient();
                    String urlQry = "Your mobile verification code=" + mc;
                    String encodedurl = null;
                    try {
                        encodedurl = URLEncoder.encode(urlQry.toString(), "UTF-8");
//                        GetMethod gm = new GetMethod(smsurl + "&mobile=" + phoneNum + "&message=" + encodedurl);
//                        hc.executeMethod(gm);
//                        String res1 = gm.getResponseBodyAsString();
//                        LOG.info(" response from mobile perfectsmsc.com message api is::" + res1);
//                        gm.releaseConnection();
                        SendSMS.callSendSMS(phoneNum, encodedurl);
                        request.getSession().setAttribute("mvcode", code);
                        LOG.debug("= Mobile verification code sent to user is:: =" + mc);
                    } catch (UnsupportedEncodingException uee) {
                        LOG.error(" unsupported url exception :: " + uee);
//
                    }
                    db.executeQuery("UPDATE USER_T SET EMAIL_CODE='" + code + "' WHERE USER_ID=" + uId);
                    request.getSession().setAttribute("ln", userName);
                    request.getSession().setAttribute("phpwd", phoneNum);
                    SendMail sm = new SendMail();
                    String sub = "Registration Confirmation";
                    MessageTemplateServlet mst = new MessageTemplateServlet();
                    String msg = mst.getRegistrationTemp(fname, userName, phoneNum, "http://bharatbuysell.com/regChk.do?ec=" + code + "&city=" + city);
                    boolean res2 = sm.send(userName, sub, msg);
                    LOG.debug(" =Email confirmation code is:: " + code);
                    LOG.info("==Registration confirmation mail response:: ==" + res2);
                    request.getSession().removeAttribute("captStr");
                    LOG.info("== quick registration process completed succssfully and his id is:: ==" + uId);

                    // here we have ad id we need to save that in send "saveadId"

                    String advtMobilenum = request.getParameter("advtMobile");
                    String adTitle = request.getParameter("adTitle");

                    ssu.storeSmsAlert(smsSendAdId, advtMobilenum, adTitle, phoneNum, uId);


                    request.getSession().setAttribute("quickRegSendSms", "Some Message");
                    return mapping.findForward(QRNSMS);
                }
            }


        }
        

        return mapping.findForward("notLogin");


    }
}


