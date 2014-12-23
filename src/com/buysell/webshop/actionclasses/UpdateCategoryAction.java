/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.buysell.webshop.actionclasses;

import com.buysell.beans.DealerBean;
import com.buysell.util.ImagePathUtil;
import com.buysell.webshop.beans.createCategoryFormbean;
import com.buysell.webshop.db.CategoryDBManager;
import com.buysell.webshop.util.DealerImagePathUtil;
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
public class UpdateCategoryAction extends Action {

    /* forward name="success" path="" */
    private static final String SUCCESS = "success";
    private static final String NOTLOGIN = "notLogin";
    private static Logger LOG = Logger.getLogger(UpdateCategoryAction.class);
    DealerImagePathUtil iputh = new DealerImagePathUtil("/Buy-Sell");
    CategoryDBManager cdbm = new CategoryDBManager();

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

        DealerBean db = (DealerBean) request.getSession().getAttribute("userBean");
        createCategoryFormbean ccfb = (createCategoryFormbean) form;
        if (db != null) {

            String frm = request.getParameter("f");
            if (frm != null && frm.trim().length() > 0) {
                int rs = 0;
                if (frm.equals("e")) {
                    String nm = ccfb.getCatNM();
                    FormFile cImg = ccfb.getCatImg();
                    String preImg = request.getParameter("prevImg");
                    String img = null;
                    if (cImg != null && cImg.getFileName().length() > 0) {
                        byte[] byteImg = cImg.getFileData();
                        img = iputh.saveImage(byteImg, db.getPath());
                    } else if (preImg != null && preImg.trim().length() > 0) {
                        img = preImg;
                    }
                    long cId = 0;
                    cId = Long.parseLong(request.getParameter("catId"));
                    long pId = ccfb.getParentId();
                    if (cId != 0) {
                        rs = cdbm.updateWSCategory(nm, img, cId, pId, db.getDlId());
                        if (rs != 0) {
                            LOG.debug("Category updated Successfully");
                            request.setAttribute("sucMsg", "Updated Successfully");
                        } else {
                            LOG.debug("Error occured while updating Category");
                            request.setAttribute("errMsg", "Error occured while updating Category");
                        }
                    }
                } else if (frm.equals("d")) {
                    long cId = 0;
                    cId = Long.parseLong(request.getParameter("catId"));
                    if (cId != 0) {
                        rs = cdbm.deleteWSCategory(cId, db.getDlId());
                        if (rs != 0) {
                            LOG.debug("Category deleted Successfully");
                            request.setAttribute("sucMsg", "Deleted Successfully");
                        } else {
                            LOG.debug("Error occured while deleting Category");
                            request.setAttribute("errMsg", "Error occured while deleting Category");
                        }
                    }
                }
            }
            return mapping.findForward(SUCCESS);
        }
        return mapping.findForward(NOTLOGIN);
    }
}
