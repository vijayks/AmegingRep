/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.buysell.actionclass;

import com.buysell.beans.PostAdFormBean;
import com.buysell.beans.UserBean;
import com.buysell.db.DbConnection;
import com.buysell.util.CategoryUtil;
import java.sql.ResultSet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.ActionForward;

/**
 *
 * @author bbsadmin
 */
public class RenewAdAction extends org.apache.struts.action.Action {

    /* forward name="success" path="" */
    private final static String SUCCESS = "success";
    private static Logger LOG = Logger.getLogger(RenewAdAction.class);
     DbConnection db = new DbConnection();
      CategoryUtil.CatIDName catIDName;

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

        LOG.info("RenewAdAction class execute() started");
        int adId = 0, catId = 0, status = 0, userId = 0, resAdId = 0;
        try {
            adId = Integer.parseInt((String) request.getAttribute("adId"));
        } catch (Exception e) {
            LOG.error("error :" + e);
        }

        try {
            catId = Integer.parseInt((String) request.getAttribute("catId"));
        } catch (Exception e) {
            LOG.error("error :" + e);
        }

        try {
            status = Integer.parseInt((String) request.getAttribute("status"));

        } catch (Exception e) {
            LOG.error("error :" + e);
        }
        try {
            userId = Integer.parseInt((String) request.getAttribute("userId"));

        } catch (Exception e) {
            LOG.error("error :" + e);
        }

       
        PostAdFormBean pfb = (PostAdFormBean) form;
        String tags=null;
        catIDName=CategoryUtil.getCINForCatId(""+pfb.getCatId());
        tags=pfb.getPrice()+" | "+catIDName.getName()+" | "+catIDName.getParent()+" | "+catIDName.getSuperParent()+" | "+pfb.getFname();

        UserBean ub = (UserBean) request.getSession().getAttribute("userBean");
        if(ub != null)
        {
        String image1 = (String) request.getAttribute("image1");
        String image2 = (String) request.getAttribute("image2");
        String image3 = (String) request.getAttribute("image3");
        String videoUrl = (String) request.getAttribute("videoUrl");

        if (image1 == null || image1.trim().length() < 0) {
            String EImage = (String) request.getAttribute("EImage1");
            if (EImage != null) {
                image1 = EImage;
            }
        }
        if (image2 == null || image2.trim().length() < 0) {
            String EImage = (String) request.getAttribute("EImage2");
            if (EImage != null) {
                image2 = EImage;
            }
        }
        if (image3 == null || image3.trim().length() < 0) {
            String EImage = (String) request.getAttribute("EImage3");
            if (EImage != null) {
                image3 = EImage;
            }
        }
        if (status == 1) {
            int res=db.executeQuery("UPDATE AD_T SET STATUS=4 WHERE STATUS=1 AND AD_ID=" + adId);
            if(res==1)
                db.executeQuery(" UPDATE USER_T SET BALANCE_ADS = BALANCE_ADS + 1 WHERE USER_ID=" + ub.getUserId());
        }
       resAdId = db.callPostAd(
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
                2,"self",tags,pfb.getSponsType(),videoUrl);
        if (resAdId != 0) {
            db.executeQuery("INSERT INTO MAIL_HISTORY_T(AD_ID,USER_ID,EMAIL_ID,ACTION,ACTION_DT) VALUES (" + adId + "," + ub.getUserId() + ",'" + ub.getLoginName() + "','AD RENEWED BY USER. NEW AD ID IS "+resAdId+"',NOW())");
            request.getSession().setAttribute("ok", "Ad Renewed successfully");
        } else {
            if (status == 1) {
                int res=db.executeQuery("UPDATE AD_T SET STATUS=1 WHERE STATUS<>1 AND AD_ID=" + adId);
                if(res==1)
                    db.executeQuery(" UPDATE USER_T SET BALANCE_ADS = BALANCE_ADS - 1 WHERE USER_ID=" + ub.getUserId());
            }
            request.getSession().setAttribute("ok", "Max Ad limit is reached (3 ads)");
        }
        request.setAttribute("m", "ma");
        return mapping.findForward(SUCCESS);
        }
        else
        {
            return mapping.findForward("notLogin");
        }
    }
}
