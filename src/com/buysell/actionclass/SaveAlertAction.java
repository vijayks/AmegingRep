/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.buysell.actionclass;

import com.buysell.beans.UserBean;
import com.buysell.db.DbConnection;
import com.buysell.servlets.AdsService;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
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
public class SaveAlertAction extends org.apache.struts.action.Action {

    /* forward name="success" path="" */
    private final static String SUCCESS = "success";
    private static Logger LOG = Logger.getLogger(SaveAlertAction.class);

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

        LOG.info("SaveAlertAction execute() started");

        UserBean ub = (UserBean) request.getSession().getAttribute("userBean");

        DbConnection db = new DbConnection();

        String keyword = request.getParameter("keyword");
        String subCatId = request.getParameter("subCatId");
        String city = request.getParameter("city");


        String day1 = request.getParameter("day1");
        String month1 = request.getParameter("month1");
        String year1 = request.getParameter("year1");
        String day2 = request.getParameter("day2");
        String month2 = request.getParameter("month2");
        String year2 = request.getParameter("year2");

        LOG.info("keyword=" + keyword);
        LOG.info("category=" + subCatId);
        LOG.info("city=" + city);
        LOG.info("date1" + day1 + "-" + month1 + "-" + year1);
        LOG.info("date1" + day2 + "-" + month2 + "-" + year2);

        if (keyword == null || keyword.trim().equalsIgnoreCase("")) {
            keyword = " ";
        }
        if (subCatId == null || subCatId.trim().equalsIgnoreCase("")) {
            subCatId = " ";
        }


        Calendar cal1 = Calendar.getInstance();
        LOG.info("121");
        cal1.set(Integer.parseInt(year1), Integer.parseInt(month1), Integer.parseInt(day1));
        LOG.info("131");
        Date date1 = cal1.getTime();
        LOG.info("141");

        Calendar cal2 = Calendar.getInstance();
        cal2.set(Integer.parseInt(year2), Integer.parseInt(month2), Integer.parseInt(day2));
        Date date2 = cal2.getTime();
        java.sql.Date date11 = new java.sql.Date(date1.getTime());
        java.sql.Date date22 = new java.sql.Date(date2.getTime());

        StringBuffer finalAlertPattern = new StringBuffer(keyword + "|" + subCatId + "|" + city);
        HashMap alertPatternMap = (HashMap) request.getSession().getAttribute("smap");
        if (alertPatternMap != null) {
            String pattern = (String) alertPatternMap.get(keyword);
            if (pattern != null) {

                finalAlertPattern.append(pattern);
                LOG.debug("pattern=" + pattern);
                LOG.info("final=" + finalAlertPattern);
            }
        }

        int alertCount = 0;
        AdsService ads = new AdsService();

        // already save search count written so use that method so dont confuse....
        alertCount = ads.getSaveSearchCount("SELECT COUNT(*) FROM ALERT_T WHERE USER_ID=" + ub.getUserId());
        if (alertCount >= 10) {
            request.setAttribute("AlertNotSave", "AlertNotSave");
        } else {
            try {
                db.executeQuery("INSERT INTO ALERT_T (ALERT_CREATION_DATE,ALERT_FROM,ALERT_TO,ALERT_PATTERN,USER_ID) VALUES(NOW(),'" + date11 + "','" + date22 + "','" + finalAlertPattern.toString() + "'," + ub.getUserId() + ")");
            } catch (Exception e) {
                LOG.error("Error while saving alert db operation:" + e);
            }
        }
        return mapping.findForward(SUCCESS);
    }
}
