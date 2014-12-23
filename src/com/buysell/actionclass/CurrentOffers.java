/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.buysell.actionclass;

import com.buysell.beans.ScrAdsBean;
import com.buysell.db.DbConnectionPool;
import com.buysell.util.CategoryUtil;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
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
public class CurrentOffers extends org.apache.struts.action.Action {

    /* forward name="success" path="" */
    private static final String SUCCESS = "success";
    private final static Logger LOG = Logger.getLogger(CurrentOffers.class);
    Connection con;
    Statement st;
    ResultSet rs;
    List al;
    ScrAdsBean sab;

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
        LOG.debug("= Current offer action class =");
        request.setAttribute("categoryList", CategoryUtil.getCategories());
        String city = (String) request.getSession().getAttribute("city");
        String catId = request.getParameter("catId");
        int id=0;
        if(catId != null)
        {
            id = Integer.parseInt(catId);// this id used to find this request comes from more link
            request.setAttribute("currentCatId",catId);
        }

        /*

         SELECT SCR_TITLE,IMG1,IMG2,DEALER_T.DEALER_ID,S_DATE,E_DATE,COMPANY_NAME,LOGO,ADDRESS_1,CITY,LIST_PRICE,OFFER_PRICE,DESCRIPTION
         FROM SCROLL_ADS_T,DEALER_T,ADDRESS_T WHERE DEALER_T.DEALER_ID=SCROLL_ADS_T.DEALER_ID AND DEALER_T.ADDRESS_ID=ADDRESS_T.ADDRESS_ID AND S_ID=" + sid + ""
         */


        /*

         SELECT S_ID,SCR_TITLE,CATEGORY_ID,IMG1,DESCRIPTION,LOGO  FROM SCROLL_ADS_T,DEALER_T WHERE SCROLL_ADS_T.DEALER_ID=DEALER_T.DEALER_ID AND SCROLL_ADS_T.STATUS=1 AND  CATEGORY_ID=3
         */

        if (id != 0 && id > 0) {
            try {
                con = DbConnectionPool.getConnection();
                Statement st;
                st = con.createStatement();
                al = new ArrayList();
                if (city != null && city.equals("All India")) {
                    rs = st.executeQuery("SELECT S_ID,SCR_TITLE,CATEGORY_ID,IMG1,DESCRIPTION,LOGO  FROM SCROLL_ADS_T,DEALER_T WHERE SCROLL_ADS_T.DEALER_ID=DEALER_T.DEALER_ID AND SCROLL_ADS_T.STATUS=1 AND  CATEGORY_ID="+id);
                } else if (city != null) {
                    rs = st.executeQuery("SELECT S_ID,SCR_TITLE,CATEGORY_ID,IMG1,DESCRIPTION,LOGO  FROM SCROLL_ADS_T,DEALER_T WHERE SCROLL_ADS_T.DEALER_ID=DEALER_T.DEALER_ID AND SCROLL_ADS_T.STATUS=1 AND OFFER_CITY='" + city + "' AND CATEGORY_ID="+id);
                }
                while (rs != null && rs.next()) {
                    sab = new ScrAdsBean();
                    sab.setSid(rs.getInt(1));
                    sab.setScrTitle(rs.getString(2));
                    sab.setCategoryId(rs.getInt(3));
                    sab.setImg1(rs.getString(4));
                    sab.setDesc(rs.getString(5));
                    sab.setLogo(rs.getString(6));
                    al.add(sab);
                }
            } catch (Exception e) {
                LOG.error("Error Occured::" + e);
            } finally {
                if(rs!=null){
                    rs.close();
                }
                if(st!=null){
                    st.close();
                }
                if(con!=null){
                DbConnectionPool.closeConnection(con);
                }
            }
           
        } else {
            try {
                con = DbConnectionPool.getConnection();
                Statement st;
                st = con.createStatement();
                al = new ArrayList();
                if (city != null && city.equals("All India")) {
                    rs = st.executeQuery("SELECT S_ID,SCR_TITLE,CATEGORY_ID FROM SCROLL_ADS_T WHERE STATUS=1");
                } else if (city != null) {
                    rs = st.executeQuery("SELECT S_ID,SCR_TITLE,CATEGORY_ID FROM SCROLL_ADS_T WHERE OFFER_CITY='" + city + "' AND STATUS=1");
                }
                while (rs != null && rs.next()) {
                    sab = new ScrAdsBean();
                    sab.setSid(rs.getInt(1));
                    sab.setScrTitle(rs.getString(2));
                    sab.setCategoryId(rs.getInt(3));
                    al.add(sab);
                }
            } catch (Exception e) {
                LOG.error("Error Occured::" + e);
            } finally {
                 if(rs!=null){
                    rs.close();
                }
                if(st!=null){
                    st.close();
                }
                if(con!=null){
                DbConnectionPool.closeConnection(con);
                }
            }

        }
        request.setAttribute("offers", al);
        LOG.debug("= Getting Offers from scroll_Ads_t and set in request scope for the city =" + city);
        return mapping.findForward(SUCCESS);
    }
}
