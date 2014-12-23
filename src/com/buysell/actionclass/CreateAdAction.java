/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.buysell.actionclass;

import com.buysell.beans.UserBean;
import com.buysell.db.DbConnectionPool;
import com.buysell.util.Category;
import com.buysell.util.CategoryUtil;
import com.buysell.util.City;
import com.buysell.util.CityUtil;
import com.buysell.util.TemplateTiles;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.ActionForward;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

/**
 *
 * @author bbsadmin
 */
public class CreateAdAction extends org.apache.struts.action.Action {

    /* forward name="success" path="" */
    private final static String SUCCESS = "success";
    private final static String NOTLOGIN = "notLogin";
    private static Logger LOG = Logger.getLogger(CreateAdAction.class);
    CityUtil cityUtil = new CityUtil();
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
    public ActionForward execute(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        LOG.info("CreateAdAction execute() started");
        request.setAttribute("categoryList", CategoryUtil.getCategories());
           String urlstr = request.getRequestURI();
        if (urlstr.contains("/Buysell")) {
            request.setAttribute("reqURI", request.getRequestURI().substring(9));

        } else {
            request.setAttribute("reqURI", request.getRequestURI().substring(1));

        }


        int id = 0;
        if (request.getParameter("select3") != null) {
            id = Integer.parseInt(request.getParameter("select3"));
            request.setAttribute("select3", id);
        } else if (request.getParameter("cid") != null) {
            id = Integer.parseInt(request.getParameter("cid"));
            request.setAttribute("select3", id);
        }

        List ll = new ArrayList();
        TemplateTiles tt = new TemplateTiles(id);
        ll = tt.getTileList(id);
        request.setAttribute("tileList", ll);
        String address = null, locality = null, city = null;
        List locationClassesList = new ArrayList();
        UserBean ub = (UserBean) request.getSession().getAttribute("userBean");
        if (ub != null) {
            String qry = "SELECT ADDRESS_1,LOCALITY,CITY FROM ADDRESS_T,USER_T WHERE USER_T.ADDRESS_ID=ADDRESS_T.ADDRESS_ID AND USER_T.USER_ID=?";
            try {
                con = DbConnectionPool.getConnection();
                ps = con.prepareStatement(qry);
                ps.setInt(1, ub.getUserId());
                rs = ps.executeQuery();

                if (rs != null && rs.next()) {
                    address = rs.getString(1);
                    locality = rs.getString(2);
                    city = rs.getString(3);
                    LOG.debug("city=" + city);
                }
            } catch (Exception e) {
                LOG.error("error :" + e);
            } finally {
                try {
                    if(rs!=null){
                    rs.close();
                    }
                    if(ps!=null){
                    ps.close();
                    }
                    if(con!=null){
                    DbConnectionPool.closeConnection(con);
                    }

                } catch (Exception e) {
                    LOG.error("= Exception Occured in closing db connections ::=" + e);
                }
            }

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
        }
        String initSearch = mapping.getParameter();
        LOG.info("----------------------" + initSearch + "----------------------");
        request.setAttribute("m", initSearch);
        return mapping.findForward(SUCCESS);
    }
}
