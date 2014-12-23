/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.buysell.actionclass;

import com.buysell.beans.UserBean;
import com.buysell.db.DbConnection;
import com.buysell.db.DbConnectionPool;
import com.buysell.util.CityUtil;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;
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
public class RegistrationCheck extends org.apache.struts.action.Action {

    /* forward name="success" path="" */
    private static final String SUCCESS = "success";
    private static final String ERROR = "error";
    private final static Logger LOG = Logger.getLogger(RegistrationCheck.class);
     CityUtil cUtil = new CityUtil();
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
        UserBean ub=(UserBean) request.getSession().getAttribute("userBean");

        String cityName=request.getParameter("city");
        List cityClassList = new ArrayList();
        cityClassList = cUtil.viewAllCities();
        request.getSession(true).setAttribute("cities", cityClassList);
        request.getSession(true).setAttribute("city", cityName);

        Connection con = DbConnectionPool.getConnection();
        int uid = 0;
        int res = 0;
        try {
            String ec = request.getParameter("ec");
            if (ec != null) {
                String id = ec.substring(0,ec.length() - 10);
                uid = Integer.parseInt(id);
            }

            CallableStatement proc = con.prepareCall("{ call RegisterCheck(?,?,?) }");
            proc.setInt(1, uid);
            proc.setString(2, ec);
            proc.registerOutParameter(3, Types.INTEGER);
            proc.execute();
            res = proc.getInt(3);

        } catch (Exception e) {
            LOG.error("= Execption occured in reg check  ="+e);
        } finally {
            try {
                if(con!=null){
                     DbConnectionPool.closeConnection(con);
                }
            } catch (Exception e) {
                LOG.error("= Execption occured in reg check at Closing Connection ="+e);
            }
          
        }

        if (res == 1) {
            request.getSession().setAttribute("logout","Your E-mail verification completed sucessfully.");
            LOG.debug("= Registration confirmation successful =");
            if(ub != null)
            {
               String cde=ub.getEvStatus();
               ub.setEvStatus("V" + cde);
               ub.setLoginType("NORMAL LOGIN");
               ub.setUserStatus(1);
            }
            
            return mapping.findForward(SUCCESS);
        } else if(res == 2){
          
            request.getSession().setAttribute("logout","Your account is in inactive please contact customer care.");
            return mapping.findForward(SUCCESS);
        }
        else if(res == 3)
        {
           
            request.getSession().setAttribute("logout","Your Email verification code wrong.");
            return mapping.findForward(SUCCESS);
        } else
        {
            LOG.debug("= Error occured in procedure =");
            request.getSession().setAttribute("logout","Error occured in activation");
            return mapping.findForward(SUCCESS);

        }
    }
}
