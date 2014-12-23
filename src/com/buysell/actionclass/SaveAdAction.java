/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.buysell.actionclass;

import com.buysell.beans.UserBean;
import com.buysell.db.DbConnection;
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
public class SaveAdAction extends org.apache.struts.action.Action {

    /* forward name="success" path="" */
    private final static String SUCCESS = "success";
    private final static Logger LOG = Logger.getLogger(SaveAdAction.class);

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

        LOG.info("SaveAdAction execute() method started");

        int adId = Integer.parseInt(request.getParameter("adId"));
        int userId = Integer.parseInt(request.getParameter("userId"));

        UserBean ub = (UserBean) request.getSession().getAttribute("userBean");
        LOG.info("adId, userId are captured adId=" + adId + "  userId=" + ub.getUserId());
        if (userId != ub.getUserId()) {

            String res = null;
            DbConnection db = new DbConnection();
            res = db.callSaveAdPro(adId, ub.getUserId());
            if (res.equalsIgnoreCase("success")) {
                request.setAttribute("saveAdResult", "Ad saved successfully in your account");
            } else if (res.equalsIgnoreCase("over")) {
                request.setAttribute("saveAdResult", "Save Ad limit is reached (10)");
            } else if (res.equalsIgnoreCase("exist")) {
                request.setAttribute("saveAdResult", "This Ad was already saved");
            }

        } else {
            request.setAttribute("saveAdResult", "Sorry, You can't save your own Ad");
        }


        //    db.executeQuery("INSERT INTO SAVED_ADS_T (AD_ID,USER_ID,SAVED_DATE) VALUES("+adId+","+ub.getUserId()+",NOW())");
        //   LOG.info(" Ad is successfully saved into database");

        //  request.setAttribute("saveSucess", "Ad saved successfully in your account");

        return mapping.findForward(SUCCESS);
    }
}
