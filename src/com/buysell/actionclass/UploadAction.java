/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.buysell.actionclass;

import com.buysell.beans.PostAdFormBean;
import com.buysell.beans.UserBean;
import com.buysell.util.ImagePathUtil;
import java.io.File;
import java.io.FileOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.ActionForward;
import org.apache.struts.upload.FormFile;

/**
 *
 * @author bbsadmin
 */
public class UploadAction extends org.apache.struts.action.Action {

    /* forward name="success" path="" */
    private final static String SUCCESS = "success";
    private static Logger LOG = Logger.getLogger(UploadAction.class);
    ImagePathUtil ipu1 = new ImagePathUtil("/Buy-Sell");
    ImagePathUtil ipu2 = new ImagePathUtil("/Buy-Sell");
    ImagePathUtil ipu3 = new ImagePathUtil("/Buy-Sell");

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
        LOG.info("request received for upload");
        PostAdFormBean uaf = (PostAdFormBean) form;
        UserBean ub = (UserBean) request.getSession().getAttribute("userBean");
        if (uaf == null || uaf.getCatId() == 0) {
            uaf = (PostAdFormBean) request.getSession().getAttribute("pfb");
        }
        LOG.info("status=" + request.getParameter("status"));
        LOG.info("adId=" + request.getParameter("adId"));
        LOG.info("catId=" + request.getParameter("catId"));
        LOG.info("userId=" + request.getParameter("userId"));
        request.setAttribute("adId", request.getParameter("adId"));
        request.setAttribute("catId", request.getParameter("catId"));
        request.setAttribute("status", request.getParameter("status"));
        request.setAttribute("userId", request.getParameter("userId"));
        request.setAttribute("EImage1", request.getParameter("EImage1"));
        request.setAttribute("EImage2", request.getParameter("EImage2"));
        request.setAttribute("EImage3", request.getParameter("EImage3"));
        FormFile f1 = uaf.getImage1();
        FormFile f2 = uaf.getImage2();
        FormFile f3 = uaf.getImage3();

        String userId = null;
        if (ub != null) {
            userId = "" + ub.getUserId();
        } else {
            userId = (String) request.getSession().getAttribute("userId");// this attribute put in session where postad-> registration flow....
        }
        if (userId != null) {
            if (f1.getFileName().length() > 0) {
                byte[] b1 = f1.getFileData();
                String fp1 = ipu1.saveImage(b1, userId, f1.getFileName());
                request.setAttribute("image1", fp1);
            }
            if (f2.getFileName().length() > 0) {
                byte[] b2 = f2.getFileData();
                String fp2 = ipu2.saveImage(b2, userId, f2.getFileName());
                request.setAttribute("image2", fp2);
            }
            if (f3.getFileName().length() > 0) {

                byte[] b3 = f3.getFileData();
                String fp3 = ipu3.saveImage(b3, userId, f3.getFileName());
                request.setAttribute("image3", fp3);
            }



        }
        return mapping.findForward(SUCCESS);
    }
}
