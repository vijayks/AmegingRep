/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.buysell.webshop.actionclasses;

import com.buysell.beans.DealerBean;
import com.buysell.webshop.beans.createCategoryFormbean;
import com.buysell.webshop.db.CategoryDBManager;
import com.buysell.webshop.util.DealerImagePathUtil;
import java.sql.Connection;
import java.util.ArrayList;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.upload.FormFile;

/**
 *
 * @author bbsadmin
 */
public class CreateCategoryAction extends org.apache.struts.action.Action {

    /* forward name="success" path="" */
    private static final String SUCCESS = "success";
    private static final String NOTLOGIN = "notLogin";
    private static Logger LOG = Logger.getLogger(CreateCategoryAction.class);
    DealerImagePathUtil iputh = new DealerImagePathUtil("/Buy-Sell");
    Connection con;
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

        LOG.debug("============createCategoryAction execute() started============");

        createCategoryFormbean ccfb = (createCategoryFormbean) form;
        DealerBean db = (DealerBean) request.getSession().getAttribute("userBean");
        if (db != null) {
            long dId = db.getDlId();

            String chkDisp = request.getParameter("f");
            if (ccfb != null && chkDisp != null && (chkDisp.equals("cr"))) {
                String catName = ccfb.getCatNM();
                FormFile catImg = ccfb.getCatImg();
                String catShrtDesc = ccfb.getCatShrtDesc();
                String cImg = null;

                //for SubCat
                long pId = ccfb.getParentId();
                LOG.debug("parentid::" + pId);
                if (catImg != null && catImg.getFileName().length() > 0) {
                    byte[] catByteImg = catImg.getFileData();
                    cImg = iputh.saveImage(catByteImg, db.getPath());
                }
//+------------------------+--------------+------+-----+---------+----------------+
//| Field                  | Type         | Null | Key | Default | Extra          |
//+------------------------+--------------+------+-----+---------+----------------+
//| DEALER_ID              | int(11)      | NO   |     |         |                |
//| CATEGORY_ID            | int(11)      | NO   | PRI | NULL    | auto_increment |
//| PARENT_CATEGORY_ID     | int(11)      | NO   |     |         |                |
//| CREATION_DATE          | datetime     | YES  |     | NULL    |                |
//| DESCRIPTION            | varchar(250) | YES  |     | NULL    |                |
//| TITLE                  | varchar(50)  | YES  |     | NULL    |                |
//| NAME                   | varchar(50)  | NO   |     |         |                |
//| SHORT_DESCRIPTION      | varchar(100) | YES  |     | NULL    |                |
//| STATUS                 | int(11)      | YES  |     | NULL    |                |
//| LAST_MODIFICATION_DATE | datetime     | YES  |     | NULL    |                |
//| END_DATE               | datetime     | YES  |     | NULL    |   
//| CATEGORY_IMG_PATH      | varchar(50)  | YES  |     | NULL    |    |
//+------------------------+--------------+------+-----+---------+----------------+
//             String pId=request.getParameter("pId");
//             LOG.debug("parent ID :: "+pId);

                CategoryDBManager cm = new CategoryDBManager();
                int catId;
                catId = cm.createWSCategory(catName, cImg, catShrtDesc, pId, dId);
                if (catId == 0) {
                    request.setAttribute("exists", catName + "  already exists");
                    LOG.debug(catName + "  already exists");
                } else {
                    request.setAttribute("noEx", catName + " is created Successfully ");
                    LOG.debug(catName + " is created successfully ");
                }
                ccfb.reset();
            }
            ArrayList catList = new ArrayList();
            catList = cdm.getCategoriesByDid(dId);
            request.setAttribute("catInfo", catList);
            return mapping.findForward(SUCCESS);
        } else {
            return mapping.findForward(NOTLOGIN);
        }
    }
}
