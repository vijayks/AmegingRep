/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.buysell.actionclass;

import com.buysell.beans.ScrollOffersFormBean;
import com.buysell.beans.UserBean;
import com.buysell.db.DbConnectionPool;
import com.buysell.servlets.DealerService;
import com.buysell.util.ImagePathUtil;
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
public class UpdateOfferAction extends org.apache.struts.action.Action {
    
    /* forward name="success" path="" */
    private static final String SUCCESS = "success";
    private static Logger LOG = Logger.getLogger(UpdateOfferAction.class);
    Connection con;
    PreparedStatement ps;
    ImagePathUtil iputh = new ImagePathUtil("/Buy-Sell");
    ImagePathUtil ipu1 = new ImagePathUtil("/Buy-Sell");
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

        ScrollOffersFormBean sofb = (ScrollOffersFormBean) form;
        UserBean ub = (UserBean) request.getSession().getAttribute("userBean");
        DealerService ds = new DealerService();
        int dealerId = ds.getDealerId(ub.getUserId());
        int sid = Integer.parseInt(request.getParameter("id"));
        FormFile f1 = sofb.getImg1();
        FormFile thImg = sofb.getThumbImg();

        String img1 = null;
        String tImg = null;



        if (thImg != null && thImg.getFileName().length() > 0) {
                byte[] th = thImg.getFileData();
                tImg = iputh.saveImage(th, "offer", thImg.getFileName());
        }
        else if(request.getParameter("prevThumbImg")!=null && request.getParameter("prevThumbImg").trim().length()>0) {
            tImg=request.getParameter("prevThumbImg").toString();
        }

        if (f1 != null && f1.getFileName().length() > 0) {
                byte[] b1 = f1.getFileData();
                img1 = ipu1.saveImage(b1, "offer", f1.getFileName());
        }
        else if(request.getParameter("prevImg1")!=null && request.getParameter("prevImg1").trim().length()>0) {
            tImg=request.getParameter("prevImg1").toString();
        }

        try {
                String query = "UPDATE SCROLL_ADS_T SET SCR_TITLE='"+sofb.getTitle()+"',IMG1='"+img1+"',THUMB_IMG='"+tImg+"',DESCRIPTION='"+sofb.getDescription()+"',DEALER_ID="+dealerId+",STATUS=2,S_DATE='"+sofb.getDateS()+"',E_DATE='"+sofb.getDateE()+"',OFFER_CITY='"+sofb.getOffCity()+"',LIST_PRICE='"+sofb.getLprice()+"',OFFER_PRICE='"+sofb.getOprice()+"',CATEGORY_ID='"+sofb.getCategory()+"',MODIFIED_DATE = now() WHERE S_ID=?;";
                con = DbConnectionPool.getConnection();
                ps = con.prepareStatement(query);
                ps.setInt(1, sid);
                ps.executeUpdate();

            } catch (Exception e) {
                LOG.debug("Error occured ::" + e);
            } finally {
                if(ps!=null) {
                    ps.close();
                }
                if(con!=null) {
                    DbConnectionPool.closeConnection(con);
                }
            }

        return mapping.findForward(SUCCESS);
    }
}
