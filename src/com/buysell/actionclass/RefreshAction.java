/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.buysell.actionclass;

import com.buysell.util.CategoryUtil;
import com.buysell.util.City;
import com.buysell.util.CityUtil;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

/**
 *
 * @author bbsadmin
 */
public class RefreshAction extends org.apache.struts.action.Action {

    /* forward name="success" path="" */
    private static final String SUCCESS = "success";
     CityUtil cUtil = new CityUtil();
    CategoryUtil cu = new CategoryUtil();
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

        request.setAttribute("categoryList", CategoryUtil.getCategories());

        String urlstr = request.getRequestURI();

        if (urlstr.contains("/Buysell")) {
            request.setAttribute("reqURI", request.getRequestURI().substring(9));
        } else {
            request.setAttribute("reqURI", request.getRequestURI().substring(1));

        }

        City cityObj = (City) request.getSession().getAttribute("cityObj");

        String city = request.getParameter("city");

        if (city != null) {
            if (city.equals("All India")) {
                cityObj = new City();
                cityObj.setName("All India");
                String country = request.getParameter("country");
                String state = request.getParameter("state");

                if (state == null || country == null || state.trim().length() == 0 || country.trim().length() == 0) {
                    cityObj = (City) request.getSession().getAttribute("cityObj");
                    if (cityObj != null) {
                        country = cityObj.getCountry();
                        state = cityObj.getState();
                    }
                }
                if (state != null || country != null) {
                    request.getSession().setAttribute("state", state);
                    request.getSession().setAttribute("country", country);
//To do check this condition again
                    cityObj = cUtil.readCity(city, country, state);
                    if (cityObj != null) {
                        cityObj.setCountry(country);
                        cityObj.setState(state);
                        request.getSession().setAttribute("cityObj", cityObj);
                    }
                }
                request.getSession().setAttribute("city", city);
            }
        } else {

            city = (String) request.getSession().getAttribute("city");
            if(city == null)
            {
                city="All India";
            }
        }
        if (cityObj == null) {
            cityObj = cUtil.getCityByName(city);
        }
        String cityName = (String) request.getSession().getAttribute("city");
        List cityClassList = new ArrayList();
        cityClassList = cUtil.viewAllCities();
        request.getSession().setAttribute("cities", cityClassList);
        request.getSession(true).setAttribute("city", cityName);
        request.getSession().setAttribute("cityObj", cityObj);

        return mapping.findForward(SUCCESS);
    }
}
