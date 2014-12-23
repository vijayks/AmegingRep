/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.buysell.actionclass;

import com.buysell.beans.DealerBean;
import com.buysell.beans.UserBean;
import com.buysell.db.DbConnectionPool;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

/**
 *
 * @author bbsadmin
 */
public class MyACDetails extends org.apache.struts.action.Action {

    /* forward name="success" path="" */
    private static final String SUCCESS = "success";
    private final static Logger LOG = Logger.getLogger(MyACDetails.class);
    Connection con;

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

        PreparedStatement ps=null;
        ResultSet rs=null;

        LOG.debug("MyACDetails execute() method started");
        UserBean ub = (UserBean) request.getSession().getAttribute("userBean");
        int alSMS = 0, alAds = 0, balAds = 0, usedAds = 0;



        if (ub != null) {
//            String qry="SELECT AT_SMS,AT_ADS,BALANCE_ADS FROM DEALER_INFO_T,USER_T WHERE DEALER_INFO_T.USER_ID=USER_T.USER_ID AND USER_T.USER_ID=?";
//String qry=" SELECT A.DOMAIN_NAME,A.DLOGO_PATH,B.TYPE,A.AT_ADS,A.AT_SMS,A.AT_OFFERS FROM DEALER_INFO_T A, DEALER_TYPE_T B WHERE B.DTYPE_ID=A.DTYPE_ID AND A.USER_ID=?";
            String qry = "SELECT A.DOMAIN_NAME,A.DLOGO_PATH,B.TYPE,A.AT_ADS,A.AT_SMS,A.AT_OFFERS,C.FIRST_NAME,C.LAST_NAME,C.PHONE,C.MOBILE_CODE,C.OCCUPATION,C.GENDER,C.ADDRESS_ID,D.LOCALITY,D.ADDRESS_1,D.CITY,D.STATE,D.COUNTRY,E.WS_URL  FROM DEALER_INFO_T A, DEALER_TYPE_T B ,USER_T C, ADDRESS_T D,DEALER_COMP_T E  WHERE B.DTYPE_ID=A.DTYPE_ID AND A.USER_ID=? AND C.USER_ID=? AND D.ADDRESS_ID=C.ADDRESS_ID AND A.DEALER_ID=E.DEALER_ID";
            try {
                con = DbConnectionPool.getConnection();
                ps = con.prepareStatement(qry);
                ps.setInt(1, ub.getUserId());
                ps.setInt(2, ub.getUserId());
                LOG.info(ps);
                rs = ps.executeQuery();

//                if (rs != null && rs.next()) {
//                    alSMS=rs.getInt(1);
//                    alAds=rs.getInt(2);
//                    balAds=rs.getInt(3);
//                    usedAds=alAds-balAds;
//                 }
//                request.setAttribute("alSMS", alSMS);
//                request.setAttribute("alAds", alAds);
//                request.setAttribute("usedAds", usedAds);

                if (rs != null && rs.next()) {

                    DealerBean deal = new DealerBean();
                    ArrayList al = new ArrayList();

                    do {
                        deal.setComp_name(rs.getString(1));
                        deal.setLogoPath(rs.getString(2));
                        deal.setDlrType(rs.getString(3));
                        deal.setNoAds(rs.getString(4));
                        deal.setNoOffers(rs.getString(6));
                        deal.setNoSms(rs.getString(5));
                        deal.setFirstName(rs.getString(7));
                        deal.setLastName(rs.getString(8));
                        deal.setMobile(rs.getString(9));
                        deal.setMvStatus(rs.getString(10));
                        deal.setOccupation(rs.getString(11));
                        deal.setGender(rs.getString(12));
                        deal.setLocality(rs.getString(14));
                        deal.setAddress(rs.getString(15));
                        deal.setCity(rs.getString(16));
                        deal.setState(rs.getString(17));
                        deal.setCountry(rs.getString(18));
                        deal.setWsUrl(rs.getString(19));



                        al.add(deal);

                    } while (rs != null && rs.next());

                    request.setAttribute("dealBean", deal);


                }


            } catch (Exception e) {
                LOG.error("= Exception Occured in  ::=" + e);
            } finally {
          
                    if (rs != null) {
                    try {
                        rs.close();
                    } catch (SQLException e) {
                        LOG.error("= Exception Occured in ResultSet of MyAcDetails execute () ::=" + e);
                    }
                }
                     if (ps != null) {
                    try {
                        ps.close();
                    } catch (SQLException e) {
                        LOG.error("= Exception Occured in PreparedStatement of MyAcDetails execute () ::=" + e);
                    }
                }
                    if (con != null) {
                        DbConnectionPool.closeConnection(con);
                    }
                
            }
        }
        return mapping.findForward(SUCCESS);
    }
}
