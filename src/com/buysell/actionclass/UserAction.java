/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.buysell.actionclass;

import com.buysell.beans.DealerBean;
import com.buysell.beans.UserBean;
import com.buysell.db.DbConnectionPool;
import com.buysell.servlets.AdsService;
import com.buysell.util.CategoryUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.ActionForward;

public class UserAction extends org.apache.struts.action.Action {

    private final static String FAILURE = "failure";
    private final static String QUICK = "quick";
    private final static String NORMAL = "normal";
    private final static String MOBILE = "mobile";
    private final static String POSTAD = "postAd";
    private static Logger LOG = Logger.getLogger(UserAction.class);
    Connection con;
    AdsService mads = new AdsService();
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
    public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {


        request.setAttribute("categoryList", CategoryUtil.getCategories());
        UserBean ub = null;
        DealerBean dlb = null;
        String loginName = request.getParameter("loginName");
        String pwd = request.getParameter("pwd");
        boolean schk = false;
        if (pwd == null && loginName == null) {
            /* These session paramentes are come form registraion process after getting we remove the session attributes */
            pwd = (String) request.getSession().getAttribute("phpwd");
            loginName = (String) request.getSession().getAttribute("ln");
            schk = true;
        }

        if (pwd != null && loginName != null) {
            ub = createUserBean(pwd, loginName);
            if (ub != null) {

                int ubp = mads.setUserPoints(ub.getUserId());
                ub.setUserBidPoints(ubp);
                request.getSession().setAttribute("userBean", ub);

                if (schk == true) {
                    request.getSession().removeAttribute("phpwd");
                    request.getSession().removeAttribute("ln");
                }
                if (ub.getLoginType().equals("LOGIN WITH MOBILE NUMBER")) {
                    LOG.debug("= login with mobile =");
                    // this value for to identify the mobile number based login so we dont permit him to postad,sms to advt,send mail to friend.
                    request.getSession().setAttribute("ML", pwd);
                    if(ub.getUserType().startsWith("DEALER")) {
                        dlb=createDealerBean(ub.getUserId(),ub);
                        if(dlb != null) {
                            request.getSession().setAttribute("D", "D");
                            request.getSession().setAttribute("userBean", dlb);
                        }
                    }
                    return mapping.findForward(MOBILE);
                } else if (ub.getLoginType().equals("NORMAL LOGIN")) {
                    String from = request.getParameter("from");
                    if (from != null && from.equals("normalLogin")) {
                        LOG.debug("= Normal login =");
                        if(ub.getUserType().startsWith("DEALER")) {
                            dlb=createDealerBean(ub.getUserId(),ub);
                            if(dlb != null) {
                                request.getSession().setAttribute("userBean", dlb);
                            }
                        }
                        return mapping.findForward(NORMAL);
                    } else if (from != null && from.equals("postAd")) {
                        LOG.debug("= Post Ad page login =");
                        if(ub.getUserType().startsWith("DEALER")) {
                            dlb=createDealerBean(ub.getUserId(),ub);
                            if(dlb != null) {
                                request.getSession().setAttribute("userBean", dlb);
                            }
                        }
                        return mapping.findForward(POSTAD);
                    }

                } else {
                    request.setAttribute("lname", loginName);
                    request.setAttribute("res", "Invalid user name or password");
                    return mapping.findForward(FAILURE);
                }
            }
        } else {
            ub = (UserBean) request.getSession().getAttribute("userBean");
            if (ub == null) {
                request.setAttribute("lname", loginName);
                request.setAttribute("res", "Invalid user name or password");
                return mapping.findForward(FAILURE);
            }
        }
        request.setAttribute("lname", loginName);
        request.setAttribute("res", "Invalid user name or password");
        return mapping.findForward(FAILURE);
    }

    public UserBean createUserBean(String pwd, String loginName) {
        PreparedStatement ps = null;
        ResultSet rs= null;
        UserBean ub = null;
        UserBean ubok = null;
        String qry = "SELECT USER_T.USER_ID, LOGIN_NAME, LOGIN_PASSWORD, LAST_LOGIN_DATE, TYPE, FIRST_NAME, LAST_NAME, PHONE, MOBILE_CODE, STATUS, EMAIL_CODE FROM USER_LOGIN_T,USER_T  WHERE  USER_T.USER_ID=USER_LOGIN_T.USER_ID AND LOGIN_NAME=?";
        long st = System.currentTimeMillis();
        try {
            con = DbConnectionPool.getConnection();
            ps = con.prepareStatement(qry);
            ps.setString(1, loginName);
            rs = ps.executeQuery();
            if (rs != null && rs.next()) {
                ub = new UserBean();
                // quick registration to fill other details...
                if (rs.getString(5).equalsIgnoreCase("quick")) {

                    ub.setUserId(rs.getInt(1));
                    ub.setLoginName(rs.getString(2));
                    ub.setPwd(rs.getString(3));
                    ub.setLastVisited(new java.text.SimpleDateFormat("dd/MM/yyyy hh:mm aa zz").format(rs.getTimestamp(4)));
                    ub.setSavedCount(0);
                    ub.setUserType(rs.getString(5));
                    ub.setFirstName(rs.getString(6));
                    ub.setLastName(rs.getString(7));
                    ub.setMobile(rs.getString(8));
                    ub.setMvStatus(rs.getString(9));

                    ub.setUserStatus(rs.getInt(10));
                    ub.setEvStatus(rs.getString(11));


                    // request.getSession().setAttribute("userBean", ub);
                    LOG.info("--- quick  registration ---");
                    //return mapping.findForward(QUICK);
                    } else {

                    ub.setUserId(rs.getInt(1));
                    ub.setLoginName(rs.getString(2));
                    ub.setPwd(rs.getString(3));
                    ub.setLastVisited(new java.text.SimpleDateFormat("dd/MM/yyyy hh:mm aa zz").format(rs.getTimestamp(4)));
                    ub.setSavedCount(1);
                    ub.setUserType(rs.getString(5));
                    ub.setFirstName(rs.getString(6));
                    ub.setLastName(rs.getString(7));
                    ub.setMobile(rs.getString(8));
                    ub.setMvStatus(rs.getString(9));
                    ub.setUserStatus(rs.getInt(10));
                    ub.setEvStatus(rs.getString(11));
                    // request.getSession().setAttribute("userBean", ub);
                    LOG.info("UserBean created\n");
                    //return mapping.findForward(s);
                    }
                if (pwd.equals(ub.getMobile()) && ub.getUserStatus() == 2) {
                    ub.setLoginType("LOGIN WITH MOBILE NUMBER");
                    ubok = ub;
                } else if (pwd.equals(ub.getPwd()) && ub.getUserStatus() == 2) {
                    ub.setLoginType("LOGIN WITH MOBILE NUMBER");
                    ubok = ub;
                } else if (pwd.equals(ub.getPwd()) && ub.getUserStatus() == 1) {
                    ub.setLoginType("NORMAL LOGIN");
                    ubok = ub;
                } else {
                    ub.setLoginType("MISSING");
                    ubok = null;
                    LOG.debug("= here log printed to identified any missing cases in login options =");
                }


            }
        } catch (SQLException ex) {
            LOG.info("Error in DataBase operations\n");
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (con != null) {
                    DbConnectionPool.closeConnection(con);
                }
                long et = System.currentTimeMillis();
                LOG.debug("= Time taken to complete db operation :: =" + (et - st) + " Milli Seconds");

            } catch (Exception e) {
                LOG.error("= Exception Occured in closing db connections ::=" + e);
            }
        }

        return ubok;
    }

    public  DealerBean createDealerBean(int userId, UserBean ub) {
        PreparedStatement ps = null;
        ResultSet rs= null;
        DealerBean dlb = null;
        String qry = " SELECT A.DEALER_ID,A.DOMAIN_NAME,A.DLOGO_PATH,B.DESCRIPTION,A.AT_ADS,A.AT_SMS,B.EMAIL_ID,B.PHONE1,B.PHONE2,C.CITY,C.LOCALITY,C.ADDRESS_1,C.PINCODE,C.LANDMARK,A.BUSINESS_DETAILS,A.PATH,A.WEBSITE,D.CATEGORY_ID FROM DEALER_INFO_T A,DEALER_COMP_T B,ADDRESS_T C,DEALER_CATEGORY_T D WHERE D.DEALER_ID=A.DEALER_ID AND C.ADDRESS_ID=A.ADD_ID AND B.DEALER_ID=A.DEALER_ID AND A.USER_ID=?";
        long st = System.currentTimeMillis();
        try {
            con = DbConnectionPool.getConnection();
            ps = con.prepareStatement(qry);
            ps.setInt(1, userId);
            rs = ps.executeQuery();
            if (rs != null && rs.next()) {
                dlb = new DealerBean();
                dlb.setDlId(rs.getInt(1));
                dlb.setComp_name(rs.getString(2));
                dlb.setLogoPath(rs.getString(3));
                dlb.setDescription(rs.getString(4));
                dlb.setNoAds(rs.getString(5));
                dlb.setNoSms(rs.getString(6));
                dlb.setEmailId(rs.getString(7));
                dlb.setPhone1(rs.getString(8));
                dlb.setPhone2(rs.getString(9));
                dlb.setCity(rs.getString(10));
                dlb.setLocality(rs.getString(11));
                dlb.setAddress(rs.getString(12));
                dlb.setPincode(rs.getString(13));
                dlb.setLandmark(rs.getString(14));
                dlb.setDetails(rs.getString(15));
                dlb.setUserId(ub.getUserId());
                dlb.setLoginName(ub.getLoginName());
                dlb.setPwd(ub.getPwd());
                dlb.setLastVisited(ub.getLastVisited());
                dlb.setSavedCount(ub.getSavedCount());
                dlb.setUserType(ub.getUserType());
                dlb.setFirstName(ub.getFirstName());
                dlb.setMobile(ub.getMobile());
                dlb.setMvStatus(ub.getMvStatus());
                dlb.setUserStatus(ub.getUserStatus());
                dlb.setEvStatus(ub.getEvStatus());
                dlb.setLoginType(ub.getLoginType());
                dlb.setPath(rs.getString(16));
                dlb.setWebsite(rs.getString(17));
                dlb.setCategories(rs.getString(18));
            }
        } catch (SQLException ex) {
            LOG.error("Error in DataBase operations\n"+ ex);
        } finally {
            
                if (rs != null) {
                    try {
                        rs.close();
                    } catch (SQLException e) {
                        LOG.error("= Exception Occured in closing db connections ::=" + e);
                    }
                }
                if (ps != null) {
                    try {
                        ps.close();
                    } catch (SQLException e) {
                        LOG.error("= Exception Occured in closing db connections ::=" + e);
                    }
                }
                if (con != null) {
                    DbConnectionPool.closeConnection(con);
                }
                long et = System.currentTimeMillis();
                LOG.info("= Time taken to get dealer info :: =" + (et - st) + " Milli Seconds");

            
        }
        return dlb;
    }
}
