/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.buysell.actionclass;

import com.buysell.beans.PostAdFormBean;
import com.buysell.beans.UserBean;
import com.buysell.db.DbConnectionPool;
import com.buysell.util.CategoryUtil;
import com.buysell.util.City;
import com.buysell.util.CityUtil;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

/**
 *
 * @author bbsadmin
 */
public class CategoryProviderMAAction extends org.apache.struts.action.Action {

    /* forward name="success" path="" */
    private static final String SUCCESS = "success";
    private final static String NOTLOGIN = "notLogin";
    CityUtil cityUtil = new CityUtil();
    CategoryUtil cu = new CategoryUtil();
    private static Logger LOG = Logger.getLogger(CategoryProviderMAAction.class);
    Connection con;
    PreparedStatement ps;
    ResultSet rs;

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

        LOG.info("CategoryProverAction execute() started");
        request.setAttribute("categoryList", CategoryUtil.getCategories());

        String urlstr = request.getRequestURI();

        if (urlstr.contains("/Buysell")) {
            request.setAttribute("reqURI", request.getRequestURI().substring(9));
          
        } else {
            request.setAttribute("reqURI", request.getRequestURI().substring(1));
   
        }
        PostAdFormBean pfb = (PostAdFormBean) form;
        request.setAttribute("pfb", pfb);
        String address = null, locality = null, city = null;
//                , state = null, country = null;
        List locationClassesList = new ArrayList();
        UserBean ub = (UserBean) request.getSession().getAttribute("userBean");
        if (ub != null) {
            LOG.info("loged in");
            String query = "SELECT ADDRESS_1,LOCALITY,CITY FROM ADDRESS_T,USER_T WHERE USER_T.ADDRESS_ID=ADDRESS_T.ADDRESS_ID AND USER_T.USER_ID= ?";
            long st = System.currentTimeMillis();
            try {

                con = DbConnectionPool.getConnection();
                ps = con.prepareStatement(query);
                ps.setInt(1, ub.getUserId());
                rs = ps.executeQuery();
                if (rs != null && rs.next()) {
                    address = rs.getString(1);
                    locality = rs.getString(2);
                    city = rs.getString(3);
                }
            } catch (Exception e) {
                LOG.error("= Exception Occured in getting resultset ::=" + e);
            } finally {
                try {
                    rs.close();
                    ps.close();
                    DbConnectionPool.closeConnection(con);
                    long et = System.currentTimeMillis();
                    LOG.debug("= Time taken to complete db operation :: =" + (et - st) / 1000 + "  Seconds");
                } catch (Exception e) {
                    LOG.error("= Exception Occured in closing dbconnections ::=" + e);
                }

            }
            //TODO: remove this code and keep in separate methob


            if (city != null && city.trim().length() > 0) {

                City c = cityUtil.getCityByName(city);
                if (c != null) {
                    locationClassesList = c.getLoc();
                }
            }

            request.setAttribute("locationClasses", locationClassesList);
            request.setAttribute("locality", locality);
            request.setAttribute("addressId", address);
            request.setAttribute("cityId", city);


        } else {

            LOG.info("not loged in");

            City cityObj = (City) request.getSession().getAttribute("cityObj");

            if (cityObj != null) {

                city = cityObj.getName();

                if (city == null || city.trim().length() == 0) {
                    city = "All India";
                    cityObj = new City();
                    cityObj.setName("All India");
                    request.getSession().setAttribute("cityObj", cityObj);
                }

                locationClassesList = cityObj.getLoc();
                request.setAttribute("locationClasses", locationClassesList);
                request.setAttribute("cityId", city);


            } else {

                cityObj = new City();
                cityObj.setName("All India");
                request.getSession().setAttribute("cityObj", cityObj);
                request.setAttribute("cityId", "All India");
            }

            return mapping.findForward(NOTLOGIN);


        }
        request.setAttribute("m", "ma");


        return mapping.findForward(SUCCESS);
    }
}
