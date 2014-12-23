/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.buysell.actionclass;

import com.buysell.beans.UserBean;
import com.buysell.beans.UserProfileBean;
import com.buysell.db.DbConnection;
import com.buysell.servlets.AdsService;
import com.buysell.util.CategoryUtil;
import com.buysell.util.CityUtil;
import com.buysell.util.City;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.ActionForward;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

/**
 *
 * @author bbsadmin
 */
public class MyAccountEditMyProfileAction extends org.apache.struts.action.Action {

    /* forward name="success" path="" */
    private final static String SUCCESS = "success";
    private final static Logger LOG = Logger.getLogger(MyAccountEditMyProfileAction.class);
    CityUtil cityUtil = new CityUtil();

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

        LOG.info("MyAccountEditMyProfileAction execute() method started");
        request.setAttribute("categoryList", CategoryUtil.getCategories());

        UserBean ub = (UserBean) request.getSession().getAttribute("userBean");
        if (ub != null) {
            AdsService as = new AdsService(); // this object for to populate user profile bean .

            UserProfileBean upb = as.populateUserProfileBean(ub);

            if (upb != null) {

                List locationClassesList = new ArrayList();


                String city = null;
                city = upb.getCity();

                if (city != null && city.trim().length() > 0) {
                    City c = cityUtil.getCityByName(city);
                    if (c != null) {
                        locationClassesList = c.getLoc();
                    }
                }

                request.setAttribute("locationClasses", locationClassesList);
                request.setAttribute("userProfileBean", upb);
                request.setAttribute("m", "ma");
                return mapping.findForward(SUCCESS);
            } else {
                return mapping.findForward("notLogin");
            }
        } else {
            return mapping.findForward("notLogin");
        }


    }
}
