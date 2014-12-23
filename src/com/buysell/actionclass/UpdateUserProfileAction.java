/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.buysell.actionclass;

import com.buysell.beans.RegisterFormBean;
import com.buysell.beans.UserBean;
import com.buysell.db.DbConnection;
import com.buysell.util.CategoryUtil;
import java.util.Calendar;
import java.util.Date;
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
public class UpdateUserProfileAction extends org.apache.struts.action.Action {

    /* forward name="success" path="" */
    private final static String SUCCESS = "success";
    private static Logger LOG = Logger.getLogger(UpdateUserProfileAction.class);
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
    @Override
    public ActionForward execute(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        LOG.info("UpdateUserProfileAction execute() method started\n");

        request.setAttribute("categoryList", CategoryUtil.getCategories());
        RegisterFormBean rfb = (RegisterFormBean) form;
        UserBean ub = (UserBean) request.getSession().getAttribute("userBean");
        if (ub != null) {
            Calendar cal = Calendar.getInstance();
            cal.set(rfb.getYear(), rfb.getMonth() - 1, rfb.getDate());
            Date d = cal.getTime();
            db.executeQuery("UPDATE USER_T SET FIRST_NAME='" + rfb.getFirstName().trim() + "',LAST_NAME='" + rfb.getLastName() + "',PHONE='" + rfb.getMobile() + "',DATE_OF_BIRTH='" + new java.sql.Date(d.getTime()) + "',OCCUPATION='" + rfb.getOccupation() + "',GENDER='" + rfb.getGender() + "' WHERE USER_ID =" + ub.getUserId());
            db.executeQuery("UPDATE ADDRESS_T SET COUNTRY='" + rfb.getCountry() + "',STATE='" + rfb.getState() + "',CITY='" + rfb.getCity() + "',AREA='" + rfb.getArea() + "',LOCALITY='" + rfb.getLocation() + "',ADDRESS_1='" + rfb.getAddress() + "',PINCODE='" + rfb.getPinCode() + "' where ADDRESS_ID=(SELECT ADDRESS_ID FROM USER_T WHERE USER_ID =" + ub.getUserId() + ")");
            rfb.reset1();
            request.getSession().setAttribute("ok", " Your Profile updated successfully...");
            request.setAttribute("m", "ma");
            return mapping.findForward(SUCCESS);
        } else {
            return mapping.findForward("notLogin");
        }
    }
}
