 /*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.buysell.actionclass;

import com.buysell.beans.MyAdDetailsBean;
import com.buysell.beans.PostAdFormBean;
import com.buysell.beans.RegisterFormBean;
import com.buysell.servlets.MessageTemplateServlet;
import com.buysell.beans.UserBean;
import com.buysell.db.DbConnection;
import com.buysell.db.DbConnectionPool;
import com.buysell.util.BuySellProperties;
import com.buysell.util.CategoryUtil;
import com.buysell.util.SendMail;
import com.buysell.util.SendSMS;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.ActionForward;
import org.apache.log4j.Logger;

/**
 *
 * @author bbsadmin
 */
public class PostAdAction extends org.apache.struts.action.Action {

    /* forward name="success" path="" */
    private final static String REGPOSTAD = "regpostad";
    private final static String POSTADNORMAL = "postadnormal";
    private final static String ERROR = "failure";
    private static Logger LOG = Logger.getLogger(PostAdAction.class);
    CategoryUtil.CatIDName catIDName;
    DbConnection db = new DbConnection();

    /**
     * This is the action called from the Struts framework.
     *
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
        LOG.debug("PostAdAction class execute() started");

        PostAdFormBean pfb = (PostAdFormBean) form;
        String tags = null;

        String image1 = (String) request.getAttribute("image1");
        String image2 = (String) request.getAttribute("image2");
        String image3 = (String) request.getAttribute("image3");

        LOG.debug("Image path is " + image1);
        LOG.debug("Image path is " + image2);
        LOG.debug("Image path is " + image3);
        // used for postad -> registration process
        PostAdFormBean fb = (PostAdFormBean) request.getSession().getAttribute("pfb");
        String VideoUrl = pfb.getVideoUrl();
        LOG.debug("Video Url path is " + VideoUrl);
        if (fb != null) {

            pfb = fb;
            catIDName = CategoryUtil.getCINForCatId("" + pfb.getCatId());
            tags = pfb.getPrice() + " | " + catIDName.getName() + " | " + catIDName.getParent() + " | " + catIDName.getSuperParent() + " | " + pfb.getFname();

            String x = (String) request.getSession().getAttribute("userId");

            LOG.debug("= Sessin value in  =" + x);


            int userId = Integer.parseInt(x);
            LOG.debug("= User Id  =" + userId);

            // code for stored procedure...
            if (userId != 0) {
                int resAdId = db.callPostAd(
                        userId,
                        pfb.getAdTitle(),
                        pfb.getDescription(),
                        pfb.getCatId(),
                        pfb.getAdditionalContent(),
                        image1,
                        image2,
                        image3,
                        pfb.getCountry(),
                        pfb.getState(),
                        pfb.getCity(),
                        pfb.getArea(),
                        pfb.getLocality(),
                        pfb.getAddress(),
                        pfb.getCondition(),
                        pfb.getColor(),
                        pfb.getPrice(),
                        pfb.getMax(),
                        pfb.getMin(),
                        pfb.getNeg(),
                        pfb.getCfp(),
                        pfb.getBrand(),
                        pfb.getMaterial(),
                        pfb.getYearsOld(),
                        pfb.getOwnership(),
                        pfb.getSpecialOffer(),
                        pfb.getSOFrom(),
                        pfb.getSOTo(),
                        pfb.getType(),
                        pfb.getName(),
                        pfb.getMeasurement(),
                        pfb.getWeight(),
                        pfb.getHeight(),
                        pfb.getNote(),
                        pfb.getModel(),
                        pfb.getRegNo(),
                        pfb.getInsurance(),
                        pfb.getKmRun(),
                        pfb.getPet(),
                        pfb.getBreed(),
                        pfb.getObjects(),
                        pfb.getCollectables(),
                        pfb.getQualification(),
                        pfb.getSkillSet(),
                        pfb.getIndustary(),
                        pfb.getPrefLocation(),
                        pfb.getCurrentSalary(),
                        pfb.getExpectedSalary(),
                        pfb.getNoticePeriod(),
                        pfb.getAuthor(),
                        pfb.getLanguage(),
                        pfb.getPublication(),
                        pfb.getQualityDiamond(),
                        pfb.getRentMonth(),
                        pfb.getNoBedRooms(),
                        pfb.getFloorNum(),
                        pfb.getTotalFloors(),
                        pfb.getFacing(),
                        pfb.getFurnished(),
                        pfb.getFacilities(),
                        pfb.getAdType(),
                        2, "self", tags, pfb.getSponsType(), pfb.getVideoUrl());//oldstatus, newstatus, oldadid.
                if (resAdId != 0) {
                    request.getSession().setAttribute("ok", "Ad Posted successfully");
                    SendMail sm = new SendMail();
                    String sub = "Posting ad confirmation Mail";
                    MessageTemplateServlet mst = new MessageTemplateServlet();
                    String msg = mst.postingAdTemp(pfb.getAdTitle(), pfb.getFname());
                    boolean res = sm.send(pfb.getEmail(), sub, msg);
                    LOG.info("Email Address ::==" + pfb.getEmail());
                    LOG.info("==Posting Ad Confirmatin Mail when with registration:::: ==" + res);
                    msg = mst.getSelfAdReminderTemplate(resAdId, pfb.getAdTitle());
                    String encodedurl = null;
                    try {
                        encodedurl = URLEncoder.encode(msg.toString(), "UTF-8");

                    } catch (UnsupportedEncodingException uee) {
                        LOG.error(" unsupported usrl exception :: " + uee);
                    }
                    SendSMS.callSendSMS(BuySellProperties.getProperty("selfAdReminderMobile") != null ? BuySellProperties.getProperty("selfAdReminderMobile") : "9731033533", encodedurl);
                } else {
                    request.getSession().setAttribute("ok", "Max Ad limit is reached");
                }
                request.getSession().removeAttribute("pfb");
                request.getSession().setAttribute("postAdComplete", "Ur Registration will be successful and ur ad will be posted");
                LOG.debug("Post Ad Completed & Post ad form bean session closed in PostAd -> registration flow");
                request.getSession().removeAttribute("userId");
                return mapping.findForward(REGPOSTAD);
            } else {
                request.getSession().removeAttribute("pfb");
                request.getSession().removeAttribute("userId");
                request.setAttribute("err", "Error occured in Post Ad registration process..");
                return mapping.findForward(ERROR);
            }

        } else {
            UserBean ub = (UserBean) request.getSession().getAttribute("userBean");
            String fp = (String) request.getAttribute("imgPath");
            LOG.debug("Image path is " + fp);
            String userType = ub.getUserType();
            LOG.debug("User Type ::: " + userType);


            if (userType.startsWith("DEALER") == true) {
                LOG.info(" DEALER User Type ::: ");
                Connection con = null;
                PreparedStatement ps = null;
                ResultSet rs = null;
                long st = System.currentTimeMillis();
                String qry = "SELECT AT_PREFF FROM DEALER_INFO_T WHERE DEALER_INFO_T.USER_ID=?";
                MyAdDetailsBean madb = new MyAdDetailsBean();
                try {
                   // con = DbConnectionPool.getConnection();
                    ps = con.prepareStatement(qry);
                    ps.setInt(1, ub.getUserId());
                    rs = ps.executeQuery();
                    madb.setPreffBal(rs.getInt(1));
                    LOG.debug("Preff Ads Count ::: " + rs.getInt(1));
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    if (rs != null) {
                        try {
                            rs.close();
                        } catch (Exception e) {
                            LOG.error("= Exception Occured in closing ResultSet ::=" + e);
                        }
                    }
                    if (ps != null) {
                        try {
                            ps.close();
                        } catch (Exception e) {
                            LOG.error("= Exception Occured in closing PreparedStatement ::=" + e);
                        }
                    }
                    if (con != null) {
                        DbConnectionPool.closeConnection(con);
                    }
                    long et = System.currentTimeMillis();
                    LOG.debug("= Time taken to complete db operation :: =" + (et - st) + " Milli Seconds");
                }



            } else if (userType.startsWith("DEALER") == false) {
                LOG.info("User User Type ::: ");
            }











            catIDName = CategoryUtil.getCINForCatId("" + pfb.getCatId());
            tags = pfb.getPrice() + " | " + catIDName.getName() + " | " + catIDName.getParent() + " | " + catIDName.getSuperParent() + " | " + pfb.getFname();

            int resAdId = db.callPostAd(
                    ub.getUserId(),
                    pfb.getAdTitle(),
                    pfb.getDescription(),
                    pfb.getCatId(),
                    pfb.getAdditionalContent(),
                    image1,
                    image2,
                    image3,
                    pfb.getCountry(),
                    pfb.getState(),
                    pfb.getCity(),
                    pfb.getArea(),
                    pfb.getLocality(),
                    pfb.getAddress(),
                    pfb.getCondition(),
                    pfb.getColor(),
                    pfb.getPrice(),
                    pfb.getMax(),
                    pfb.getMin(),
                    pfb.getNeg(),
                    pfb.getCfp(),
                    pfb.getBrand(),
                    pfb.getMaterial(),
                    pfb.getYearsOld(),
                    pfb.getOwnership(),
                    pfb.getSpecialOffer(),
                    pfb.getSOFrom(),
                    pfb.getSOTo(),
                    pfb.getType(),
                    pfb.getName(),
                    pfb.getMeasurement(),
                    pfb.getWeight(),
                    pfb.getHeight(),
                    pfb.getNote(),
                    pfb.getModel(),
                    pfb.getRegNo(),
                    pfb.getInsurance(),
                    pfb.getKmRun(),
                    pfb.getPet(),
                    pfb.getBreed(),
                    pfb.getObjects(),
                    pfb.getCollectables(),
                    pfb.getQualification(),
                    pfb.getSkillSet(),
                    pfb.getIndustary(),
                    pfb.getPrefLocation(),
                    pfb.getCurrentSalary(),
                    pfb.getExpectedSalary(),
                    pfb.getNoticePeriod(),
                    pfb.getAuthor(),
                    pfb.getLanguage(),
                    pfb.getPublication(),
                    pfb.getQualityDiamond(),
                    pfb.getRentMonth(),
                    pfb.getNoBedRooms(),
                    pfb.getFloorNum(),
                    pfb.getTotalFloors(),
                    pfb.getFacing(),
                    pfb.getFurnished(),
                    pfb.getFacilities(),
                    pfb.getAdType(),
                    2, "self", tags, pfb.getSponsType(), pfb.getVideoUrl());
            if (resAdId != 0) {
                request.getSession().setAttribute("ok", "Ad Posted successfully");

                SendMail sm = new SendMail();
                String sub = "Posting ad confirmation Mail";
                MessageTemplateServlet mst = new MessageTemplateServlet();
                String msg = mst.postingAdTemp(pfb.getAdTitle(), ub.getFirstName());
                boolean res = sm.send(ub.getLoginName(), sub, msg);
                LOG.info("==Posting Ad Confirmatin Mail when loged in:::: ==" + res);
                msg = mst.getSelfAdReminderTemplate(resAdId, pfb.getAdTitle());
                String encodedurl = null;
                try {
                    encodedurl = URLEncoder.encode(msg.toString(), "UTF-8");

                } catch (UnsupportedEncodingException uee) {
                    LOG.error(" unsupported usrl exception :: " + uee);
                }
                SendSMS.callSendSMS(BuySellProperties.getProperty("selfAdReminderMobile") != null ? BuySellProperties.getProperty("selfAdReminderMobile") : "9731033533", encodedurl);
            } else {
                request.getSession().setAttribute("ok", "Max Ad limit is reached ");
            }
            LOG.debug("Ad details are successfully entered into database");
            return mapping.findForward(POSTADNORMAL);
        }
    }
}
