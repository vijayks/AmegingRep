/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.buysell.actionclass;

import com.buysell.beans.PostAdFormBean;
import com.buysell.db.DbConnection;
import com.buysell.beans.RegisterFormBean;
import com.buysell.servlets.MessageTemplateServlet;
import com.buysell.util.BuySellProperties;
import com.buysell.util.CategoryUtil;
import com.buysell.util.Mutil;
import com.buysell.util.SendMail;
import com.buysell.util.SendSMS;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.sql.ResultSet;
import java.util.Calendar;
import java.util.Date;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.ActionForward;

/**
 *
 * @author praveen
 * This class is used to make registraion of the user.
 */
public class RegisterAction extends org.apache.struts.action.Action {

    private final static String NORMAL = "normal";
    private final static String POSTAD = "postad";
    private final static String QUICK = "quick";
    private final static String REGERROR = "regError";
    private static Logger LOG = Logger.getLogger(RegisterAction.class);
    MessageTemplateServlet mst = new MessageTemplateServlet();

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

        LOG.info("RegisterAction execute() strarted");
        String name = null;
        request.setAttribute("categoryList", CategoryUtil.getCategories());

        DbConnection db = new DbConnection();
        RegisterFormBean rfb = (RegisterFormBean) form;
//        String smsurl = BuySellProperties.getProperty("smsurl");

        Calendar cal = Calendar.getInstance();
        cal.set(rfb.getYear(), rfb.getMonth()-1, rfb.getDate());
        Date d = cal.getTime();
        LOG.debug("date=" + rfb.getDate());
        LOG.debug("month=" + rfb.getMonth());
        LOG.debug("year=" + rfb.getYear());
        int userId = 0;
        int uId = 0;
        String code = null;
        ResultSet rs;

        Mutil mu = new Mutil();
        String ran = mu.getRandomCode(10);// this code for to append email confirmation code

        Mutil mu2 = new Mutil();
        String mc = mu2.getRandomCode(4);// This for mobile verification code

        // Getting hidden parameter from  register.jsp and check for differentiate two registration process

        String reg = (String) request.getParameter("regFrom");
        String regCode = (String) request.getSession().getAttribute("captStr");
        LOG.debug("== System generated code enter code:: ==" + regCode + "==User Entered Capticha image code ==" + rfb.getRegCode());
        String regCodefromRequest = request.getParameter("regCode");


        if (regCode != null && regCode.equals(regCodefromRequest)) {

            if (reg != null && reg.equals("normalRegistration")) {
                LOG.info("= Normal registraton process before calling callRegister Strored procdeure =");
                uId = db.callRegister(rfb.getCountry(), rfb.getState(), rfb.getCity(), rfb.getArea(), rfb.getLocation(), rfb.getAddress(), rfb.getPinCode(), rfb.getFirstName(), rfb.getLastName(), rfb.getMobile(), new java.sql.Date(d.getTime()), rfb.getOccupation(), rfb.getGender(), rfb.getUserName(), rfb.getMobile(), rfb.getType(), mc, 2);
                code = uId + ran;
                if (uId != 0) {
                    if (rfb.getMobile() != null) {
//                        HttpClient hc = new HttpClient();
                        String urlQry = mst.getSmsCodeTemplate(mc);
                        String encodedurl = null;
                        try {
                            encodedurl = URLEncoder.encode(urlQry.toString(), "UTF-8");

                        } catch (UnsupportedEncodingException uee) {
                            LOG.error(" unsupported usrl exception :: " + uee);
                        }
                        request.getSession().setAttribute("mvcode", code);
//                        GetMethod gm = new GetMethod(smsurl + "&mobile=" + rfb.getMobile() + "&message=" + encodedurl);
//                        hc.executeMethod(gm);
//                        String res = gm.getResponseBodyAsString();
//                        LOG.info(" response from mobile perfectsmsc.com message api is::" + res);
//                        gm.releaseConnection();
                          SendSMS.callSendSMS(rfb.getMobile(), encodedurl);
                        LOG.debug("= Mobile verification code sent to user is:: =" + mc);
                    }
                    db.executeQuery("UPDATE USER_T SET EMAIL_CODE='" + code + "' WHERE USER_ID=" + uId);
                    SendMail sm = new SendMail();
                    String sub = "Registration Confirmation";
                    MessageTemplateServlet mst = new MessageTemplateServlet();
                    String msg = mst.getRegistrationTemp(rfb.getFirstName(), rfb.getUserName(), rfb.getMobile(), "http://bharatbuysell.com/regChk.do?ec=" + code + "&city=" + rfb.getCity());
                    boolean res = sm.send(rfb.getUserName(), sub, msg);
                    LOG.debug(" =Email confirmation code is:: " + code);
                    LOG.info("==Registration confirmation mail response:: ==" + res);
                    request.getSession().setAttribute("ln", rfb.getUserName());
                    request.getSession().setAttribute("phpwd", rfb.getMobile());
                    String rId0 = (String) request.getSession().getAttribute("rId");

                    if (rId0 != null && rId0.length() > 10) {
                        String id = rId0.substring(0, rId0.length() - 10);
                        rId0 = id;
                    }
                    LOG.debug("Refer Friend id::=" + rId0);
                    if (rId0 != null) {
                        if (rId0.compareTo("rp") == 0) {
                            String rpmsg = BuySellProperties.getProperty("rupeeMailReg");
                            db.callReferalPoints(uId, uId, 10, rpmsg);
                            db.executeQuery("UPDATE USER_T SET USER_POINTS=USER_POINTS+10 WHERE USER_ID=" + uId);
                            LOG.info(rpmsg + " --" + uId);
                        } else {
                            int rId = Integer.parseInt(rId0);
                            db.callReferalPoints(uId, rId, 5, "For " + rfb.getFirstName() + " Registration");
                            db.executeQuery("UPDATE USER_T SET USER_POINTS=USER_POINTS+5 WHERE USER_ID=" + rId);
                            LOG.info("Referal points added to the user whose id is::" + rId);
                        }
                        request.getSession().removeAttribute("rId");

                    }
                    rfb.reset1();
                    request.getSession().removeAttribute("captStr");
                    LOG.info("== Normal registration process completed succssfully and his id is:: ==" + uId);
                    return mapping.findForward(NORMAL);
                } else {
                    return mapping.findForward(REGERROR);
                }
            } else if (reg != null && reg.equals("postAdRegistration")) {
                /// this else block executed to make registration of user.
                //but this process invokes when post ad then registration process flow'


                PostAdFormBean pfb = (PostAdFormBean) form;
                LOG.info("= Post Ad registraton process before calling callRegister Strored procdeure =");
                uId = db.callRegister(pfb.getCountry(), pfb.getState(), pfb.getCity(), pfb.getArea(), pfb.getLocality(), pfb.getAddress(), "", pfb.getFname(), pfb.getLname(), pfb.getPh1(), new java.sql.Date(d.getTime()), "", "", pfb.getEmail(), pfb.getPh1(), "user", mc, 2);
                code = uId + ran;
                if (uId != 0) {
                    if (pfb.getPh1() != null) {
//                        HttpClient hc = new HttpClient();
                        String urlQry = "Your mobile verification code=" + mc;
                        String encodedurl = null;
                        try {
                            encodedurl = URLEncoder.encode(urlQry.toString(), "UTF-8");

                        } catch (UnsupportedEncodingException uee) {
                            LOG.error(" unsupported usrl exception :: " + uee);
                        }
                        request.getSession().setAttribute("mvcode", code);
//                        GetMethod gm = new GetMethod(smsurl + "&mobile=" + pfb.getPh1() + "&message=" + encodedurl);
//                        hc.executeMethod(gm);
//                        String res = gm.getResponseBodyAsString();
//                        LOG.info(" response from mobile perfectsmsc.com message api is::" + res);
//                        gm.releaseConnection();
                        SendSMS.callSendSMS(pfb.getPh1(), encodedurl);
                        LOG.debug("= Mobile verification code sent to user is:: =" + mc);
                    }
                    db.executeQuery("UPDATE USER_T SET EMAIL_CODE='" + code + "' WHERE USER_ID=" + uId);
                    SendMail sm = new SendMail();
                    String sub = "Registration Confirmation";
                    MessageTemplateServlet mst = new MessageTemplateServlet();
                    String msg = mst.getRegistrationTemp(pfb.getFname(), pfb.getEmail(), pfb.getPh1(), "http://bharatbuysell.com/regChk.do?ec=" + code + "&city=" + pfb.getCity());
                    boolean res = sm.send(pfb.getEmail(), sub, msg);
                    LOG.debug(" =Email confirmation code is:: " + code);
                    LOG.info("==Registration confirmation mail response:: ==" + res);
                    request.getSession().setAttribute("ln", pfb.getEmail());
                    request.getSession().setAttribute("phpwd", pfb.getPh1());

                    request.getSession().removeAttribute("captStr");
                    LOG.info("== Post ad  registration process completed succssfully and his id is:: ==" + uId);
                    String xx = uId + "";
                    request.getSession().setAttribute("userId", xx);
                    request.getSession().setAttribute("pfb", pfb);

                    return mapping.findForward(POSTAD);
                } else {
                    request.setAttribute("errorreg", "Error occured in regitration");
                    return mapping.findForward(REGERROR);
                }
            }

        }
        request.setAttribute("errorreg", "Image Code not valid");
        return mapping.findForward(REGERROR);
    }
}

