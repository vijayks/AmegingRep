/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.buysell.actionclass;

import com.buysell.beans.PostAdFormBean;
import com.buysell.db.DbConnection;
import com.buysell.db.DbConnectionPool;
import com.buysell.util.CategoryUtil;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;
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
public class UpdateAdAction extends org.apache.struts.action.Action {

    /* forward name="success" path="" */
    private final static String SUCCESS = "success";
    private static Logger LOG = Logger.getLogger(UpdateAdAction.class);
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

        LOG.info("UpdateAdAction class execute() started");
        int adId = 0, catId = 0, status = 0, userId = 0;
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
//        LOG.info("adId=" + adId);
//        LOG.info("catId=" + catId);
//        LOG.info("status=" + status);
//        LOG.info("userId=" + userId);

        PostAdFormBean pfb = (PostAdFormBean) form;


        String image1 = (String) request.getAttribute("image1");
        String image2 = (String) request.getAttribute("image2");
        String image3 = (String) request.getAttribute("image3");

        if (image1 == null || image1.trim().length() <= 0) {

            String EImage = (String) request.getAttribute("EImage1");
            if (EImage != null && EImage.trim().length() > 0) {
                image1 = EImage;
            }
        }




        if (image2 == null || image2.trim().length() <= 0) {
            String EImage = (String) request.getAttribute("EImage2");
            if (EImage != null && EImage.trim().length() > 0) {
                image2 = EImage;
            }
        }



        if (image3 == null || image3.trim().length() <= 0) {
            String EImage = (String) request.getAttribute("EImage3");
            if (EImage != null && EImage.trim().length() > 0) {
                image3 = EImage;
            }
        }
        String tags = null;
        catIDName = CategoryUtil.getCINForCatId("" + pfb.getCatId());
        tags = pfb.getPrice() + " | " + catIDName.getName() + " | " + catIDName.getParent() + " | " + catIDName.getSuperParent() + " | " + pfb.getFname();

        String success = db.callUpdateAd(userId,
                adId,
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
                status,
                2, tags, "", "", pfb.getVideoUrl());

        if (success == null) {
            request.getSession().setAttribute("ok", "Ad updation is failed !");
        } else {
            if (success.equals("1")) {
                Connection con = DbConnectionPool.getConnection();
                try {
                    Statement st = con.createStatement();
                    st.executeUpdate("UPDATE  ADDRESS_T SET MODIFICATION_DATE = NOW() ,COUNTRY= '" + pfb.getCountry() + "' ,STATE= '" + pfb.getState() + "' ,CITY = '" + pfb.getCity() + "' ,AREA = area ,LOCALITY = '" + pfb.getLocality() + "' ,ADDRESS_1 = '" + pfb.getAddress() + "' WHERE ADDRESS_ID = (SELECT ADD_ID FROM AD_FIELDS WHERE AD_ID=" + adId + ")");
                } catch (SQLException ex) {
                    LOG.info("error in updating address of the ad" + ex);
                } finally {
                    try {
                        if (con != null) {
                            DbConnectionPool.closeConnection(con);
                        }
                    } catch (Exception e) {
                        LOG.info("error in updating address of the ad at closing connections" + e);
                    }

                }

                request.getSession().setAttribute("ok", "Ur Ad sucessfully Updated");
            } else {
                request.getSession().setAttribute("ok", "Max Ad limit is reached ( Only 3 ads per month)");
            }
        }

//            LOG.debug("Ad details are successfully updated in the database\n");

        request.setAttribute("m", "ma");
        return mapping.findForward(SUCCESS);
    }
}
