/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.buysell.actionclass;

import com.buysell.beans.AdsBean;
import com.buysell.beans.UserBean;
import com.buysell.servlets.AdsService;
import com.buysell.util.CategoryUtil;
import com.buysell.util.City;
import com.buysell.util.CityUtil;
import com.buysell.util.TemplateTiles;
import java.util.ArrayList;
import java.util.List;
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
public class EditAdForUpdateAction extends org.apache.struts.action.Action {

    /* forward name="success" path="" */
    private final static String SUCCESS = "success";
    private static Logger LOG = Logger.getLogger(EditAdForUpdateAction.class);

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

        LOG.debug("EditAdForUpdateAction execute() started");

        request.setAttribute("categoryList", CategoryUtil.getCategories());

        UserBean ub = (UserBean) request.getSession().getAttribute("userBean");
        if (ub != null) {

            int adId = Integer.parseInt(request.getParameter("adId"));
            LOG.debug("catId=" + request.getParameter("catId"));
            int catId = Integer.parseInt(request.getParameter("catId"));
            LOG.debug("status=" + request.getParameter("status"));
            String type = (request.getParameter("type"));
            LOG.debug("type=" + type);
            request.setAttribute("type", type);
            List ll = new ArrayList();
            TemplateTiles tt = new TemplateTiles(catId);
            ll = tt.getTileList(catId);
            request.setAttribute("tileList", ll);
            AdsService as = new AdsService();
            AdsBean ab = as.getAdDetailsForEdit(adId);
            if(ab!=null && ab.getUserId()==ub.getUserId()) {
                if (ab != null) {
                    CityUtil cityUtil = new CityUtil();
                    String city = null;
                    city = ab.getCity();
                    List locationClassesList = new ArrayList();
                    if (city != null && city.trim().length() > 0) {
                        City c = cityUtil.getCityByName(city);
                        if (c != null) {
                            locationClassesList = c.getLoc();
                        }
                    }
                    request.setAttribute("locationClasses", locationClassesList);
                }
                request.setAttribute("editAdForUpdateBean", ab);
                request.setAttribute("m", "ma");
                LOG.debug("EditAdForUpdateAction bean put in request scope ");
            }
            else {
                return mapping.findForward("failure");
            }

            return mapping.findForward(SUCCESS);
        } else {
            return mapping.findForward("notLogin");
        }

    }
}
