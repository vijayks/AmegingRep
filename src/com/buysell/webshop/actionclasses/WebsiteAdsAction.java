/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.buysell.webshop.actionclasses;

import com.buysell.beans.DealerBean;
import com.buysell.db.DbConnectionPool;
import com.buysell.webshop.beans.ProductCreationActionForm;
import com.buysell.webshop.util.DealerImagePathUtil;
import java.sql.Connection;
import java.sql.PreparedStatement;
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
public class WebsiteAdsAction extends Action {

    /* forward name="success" path="" */
    private static final String SUCCESS = "success";
    private static final String NOTLOGIN = "notLogin";
    private static Logger LOG = Logger.getLogger(WebsiteAdsAction.class);
    Connection con = null;
    PreparedStatement ps = null;
    DealerImagePathUtil dipu = new DealerImagePathUtil("/Buy-Sell");

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
        LOG.debug("== EXECUTE() started ==");
        DealerBean db = (DealerBean) request.getSession().getAttribute("userBean");
        ProductCreationActionForm pcaf = (ProductCreationActionForm) form;
        if (db != null) {
            if (pcaf != null) {
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
                    byte[] imgByte1 = f1.getFileData();
                    img1 = dipu.saveImage(imgByte1, db.getPath());
                }
                if (f2 != null && f2.getFileName().length() > 0) {
                    byte[] imgByte2 = f2.getFileData();
                    img2 = dipu.saveImage(imgByte2, db.getPath());
                }
                if (f3 != null && f3.getFileName().length() > 0) {
                    byte[] imgByte3 = f3.getFileData();
                    img3 = dipu.saveImage(imgByte3, db.getPath());
                }
                if (f4 != null && f4.getFileName().length() > 0) {
                    byte[] imgByte4 = f4.getFileData();
                    img4 = dipu.saveImage(imgByte4, db.getPath());
                }
                if (f5 != null && f5.getFileName().length() > 0) {
                    byte[] imgByte5 = f5.getFileData();
                    img5 = dipu.saveImage(imgByte5, db.getPath());
                }

                try {
                    String query1 = "INSERT INTO DEALER_ADS_IMAGES (DEALER_ID,IMG_1,IMG_2,IMG_3,IMG_4,IMG_5,STATUS,CREATION_DATE) VALUES(?,?,?,?,?,?,'1',NOW())";
                    con = DbConnectionPool.getConnection();
                    ps = con.prepareStatement(query1);
                    ps.setLong(1, db.getDlId());
                    ps.setString(2, img1);
                    ps.setString(3, img2);
                    ps.setString(4, img3);
                    ps.setString(5, img4);
                    ps.setString(6, img5);
                    int rs=ps.executeUpdate();
                    LOG.debug("==  result =="+rs);
                    if(rs==1){
                    request.setAttribute("okS","Ad Image submitted successfully!!");
                    LOG.debug("==Ad Images Inserted successfully! ==");
                    }else if(!(rs==1)){
                    request.setAttribute("okF","Ad Image submission failed!!");
                    LOG.debug("==Ad Images Insertion failed! ==");
                    }
                } catch (Exception e) {
                    LOG.error("= Exception Occured while executing select query ::=" + e);
                } finally {
                    if (ps != null) {
                        try {
                            ps.close();
                        } catch (Exception e) {
                            LOG.error("Exception occurred while closing Prepared Statement :: " + e);
                        }
                    }
                    if (con != null) {
                        DbConnectionPool.closeConnection(con);
                    }
                }
           


            }
            return mapping.findForward(SUCCESS);
        }
        return mapping.findForward(NOTLOGIN);
    }
}
