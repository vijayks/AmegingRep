/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.buysell.servlets;

import com.buysell.beans.UserBean;
import com.buysell.db.DbConnection;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;
import org.apache.log4j.Logger;

/**
 *
 * @author bbsadmin
 */
public class SessionListener implements HttpSessionListener {
    private static Logger LOG=Logger.getLogger(SessionListener.class);
    DbConnection dbc=new DbConnection();

    public void sessionCreated(HttpSessionEvent se){
        LOG.debug("session created "+se.getSession().getId());
    }
    public void sessionDestroyed(HttpSessionEvent se){
        UserBean ub = (UserBean) se.getSession().getAttribute("userBean");
          if(ub!=null && se.getSession().getAttribute("bbspc")!=null){
            int bbspc=(Integer)se.getSession().getAttribute("bbspc");
            dbc.executeQuery("update USER_T set USER_BID_POINTS=USER_BID_POINTS+"+bbspc+" where USER_ID="+ub.getUserId());
        }
    }

}
