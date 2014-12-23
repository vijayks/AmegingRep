/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.buysell.actionclass;

import com.buysell.beans.UserBean;
import com.buysell.db.DbConnection;
import com.buysell.util.CategoryUtil;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.ActionForward;

/**
 *
 * @author bbsadmin
 */
public class PreferencesInsertAction extends org.apache.struts.action.Action {

    /* forward name="success" path="" */
    private final static String SUCCESS = "success";
    private static Logger LOG = Logger.getLogger(PreferencesInsertAction.class);
    CategoryUtil cu = new CategoryUtil();
    DbConnection db = new DbConnection();

    /**
     * This is the action called from the Struts framework.
     * @param mapping The ActionMapping used to select this instance.
     * @param form The optional ActionForm bean for this request.
     * @param request The HTTP Request we are processing.
     * @param response The HTTP Response we are processing.
     * @throws java.lang.Exception
     * @return
     */
    public ActionForward execute(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        LOG.info("PreferencesInsertAction execute() started");
        request.setAttribute("categoryList", CategoryUtil.getCategories());
        String preferedCatIds[] = request.getParameterValues("cat");
        StringBuffer sb = new StringBuffer();
        for (int i = 0; i < preferedCatIds.length; i++) {
            sb.append(preferedCatIds[i] + "|");
        }
        int maxSms = Integer.parseInt(request.getParameter("maxSms"));
        int smsTimeFrom = Integer.parseInt(request.getParameter("smsTimeFrom"));
        int smsTimeTo = Integer.parseInt(request.getParameter("smsTimeTo"));
        int share = Integer.parseInt(request.getParameter("share"));
        String havePrefs = request.getParameter("havePreps");
        String callMe1 = request.getParameter("callMe");
        int callMe;
        if (callMe1 == null) {
            callMe = 0;
        } else {
            callMe = 1;
        }

        LOG.info("ids=" + sb);
        LOG.info("maxSms=" + maxSms);
        LOG.info("smsTimeFrom=" + smsTimeFrom);
        LOG.info("smsTimeTo=" + smsTimeTo);
        LOG.info("callMe=" + callMe);
        LOG.info("share=" + share);
        LOG.info("havePrefs=" + havePrefs);


        UserBean ub = (UserBean) request.getSession().getAttribute("userBean");
        if (ub != null) {
            try {
                if (havePrefs != null) {
                    db.executeQuery(" INSERT INTO PREFERENCES_T (USER_ID,SELECTED_CATEGORIES,FROM_TIME,TO_TIME,RESPONSE_TYPE,GET_CALL,ADS_PER_DAY,MODIFIED_DATE) VALUES(" + ub.getUserId() + ",'" + sb + "'," + smsTimeFrom + "," + smsTimeTo + "," + share + "," + callMe + "," + maxSms + ",NOW());");
                } else {
                    db.executeQuery("UPDATE  PREFERENCES_T SET SELECTED_CATEGORIES='" + sb + "' ,FROM_TIME=" + smsTimeFrom + " , TO_TIME=" + smsTimeTo + ",RESPONSE_TYPE=" + share + ", GET_CALL=" + callMe + ", ADS_PER_DAY=" + maxSms + ",MODIFIED_DATE= NOW() WHERE USER_ID=" + ub.getUserId());
                }

            } catch (Exception e) {
                LOG.info("Error In Preferences Isertion:" + e);

            }

            request.getSession().setAttribute("ok", "preferences are Saved successfully");
            request.setAttribute("m", "ma");
            return mapping.findForward(SUCCESS);
        } else {
            return mapping.findForward("notLogin");
        }
    }
}
