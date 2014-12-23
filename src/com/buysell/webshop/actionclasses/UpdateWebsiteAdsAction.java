/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.buysell.webshop.actionclasses;

import com.buysell.beans.DealerBean;
import com.buysell.db.DbConnectionPool;
import com.buysell.webshop.beans.ProductCreationActionForm;
import com.buysell.webshop.db.CategoryDBManager;
import com.buysell.webshop.util.DealerImagePathUtil;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.upload.FormFile;

/**
 *
 * @author bbsadmin
 */
public class UpdateWebsiteAdsAction extends Action {

    /* forward name="success" path="" */
    private static final String SUCCESS = "success";
    private static final String NOTLOGIN = "notLogin";
    private static Logger LOG = Logger.getLogger(UpdateWebsiteAdsAction.class);
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    DealerImagePathUtil dipu = new DealerImagePathUtil("/Buy-Sell");
    CategoryDBManager cdm = new CategoryDBManager();

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
        LOG.debug("== EXECUTE() started==");
        DealerBean db = (DealerBean) request.getSession().getAttribute("userBean");
        long dId = db.getDlId();
        ProductCreationActionForm pcaf = (ProductCreationActionForm) form;

        if (db != null) {
            String task = request.getParameter("ts");

            if (task != null && task.equals("ud")) {

                String prvImg1 = request.getParameter("pvImg1");
                String prvImg2 = request.getParameter("pvImg2");
                String prvImg3 = request.getParameter("pvImg3");
                String prvImg4 = request.getParameter("pvImg4");
                String prvImg5 = request.getParameter("pvImg5");

                FormFile f1 = pcaf.getImg1();
                FormFile f2 = pcaf.getImg2();
                FormFile f3 = pcaf.getImg3();
                FormFile f4 = pcaf.getImg4();
                FormFile f5 = pcaf.getImg5();

                String img1 = null;
                String img2 = null;
                String img3 = null;
                String img4 = null;
                String img5 = null;


                if (f1 != null && f1.getFileName().length() > 0) {
                    byte[] byteImg1 = f1.getFileData();
                    img1 = dipu.saveImage(byteImg1, db.getPath());
                } else if (prvImg1 != null) {
                    img1 = prvImg1;
                }
                if (f2 != null && f2.getFileName().length() > 0) {
                    byte[] byteImg2 = f2.getFileData();
                    img2 = dipu.saveImage(byteImg2, db.getPath());
                } else if (prvImg2 != null) {
                    img2 = prvImg2;
                }
                if (f3 != null && f3.getFileName().length() > 0) {
                    byte[] byteImg3 = f3.getFileData();
                    img3 = dipu.saveImage(byteImg3, db.getPath());
                } else if (prvImg3 != null) {
                    img3 = prvImg3;
                }

                if (f4 != null && f4.getFileName().length() > 0) {
                    byte[] byteImg4 = f4.getFileData();
                    img4 = dipu.saveImage(byteImg4, db.getPath());
                } else if (prvImg4 != null) {
                    img4 = prvImg4;
                }

                if (f5 != null && f5.getFileName().length() > 0) {
                    byte[] byteImg5 = f5.getFileData();
                    img5 = dipu.saveImage(byteImg5, db.getPath());
                } else if (prvImg5 != null) {
                    img5 = prvImg5;
                }

                try {
                    String query2 = "UPDATE DEALER_ADS_IMAGES SET IMG_1=?,IMG_2=?,IMG_3=?,IMG_4=?,IMG_5=?,STATUS='1',LAST_MODIFICATION_DATE=NOW()";
                    con = DbConnectionPool.getConnection();
                    ps = con.prepareStatement(query2);
                    ps.setString(1, img1);
                    ps.setString(2, img2);
                    ps.setString(3, img3);
                    ps.setString(4, img4);
                    ps.setString(5, img5);
                    ps.executeUpdate();
                    LOG.debug("== Images updated successfully==");
                    request.setAttribute("msg", "Ad Image uploaded successfully");
                } catch (Exception e) {
                    LOG.error("= Exception Occured while executing Upodate query::=" + e);
                } finally {

                    if (ps != null) {
                        try {
                            ps.close();
                        } catch (Exception e) {
                            LOG.error("Exception occurred while closing Prepared Statement in getCategoriesByDId  :: " + e);
                        }
                    }
                    if (con != null) {
                        DbConnectionPool.closeConnection(con);
                    }
                }
            }
            ArrayList imgList = cdm.getWebsiteAdImages(dId);
            request.setAttribute("imgList", imgList);
            return mapping.findForward(SUCCESS);
        }
        return mapping.findForward(NOTLOGIN);
    }
}
