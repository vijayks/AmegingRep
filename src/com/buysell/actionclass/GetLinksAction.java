/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.buysell.actionclass;

import com.buysell.beans.DealerMoreInfo;
import com.buysell.db.DbConnection;
import com.buysell.db.DbConnectionPool;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
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
public class GetLinksAction extends Action {

    /* forward name="success" path="" */
    private static final String SUCCESS = "success";
    private static final Logger LOG = Logger.getLogger(GetLinksAction.class);
    Connection con = null;

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
        LOG.debug("==  Execute() started==");
        String query = null;
        ArrayList al = null;
        ResultSet rs = null;
        PreparedStatement ps = null;
        String catId = request.getParameter("catId");
        if ((catId != null) && !(catId.equals("0"))) {
            query = "SELECT ID,TITLE,WS_URL,DESCRIPTION,CATEGORY_ID,STATUS FROM LINKS_T WHERE CATEGORY_ID='" + catId + "' AND STATUS='1'";
        } else if(((catId != null) && (catId.equals("0"))) ||(catId==null)) {
            query = "SELECT ID,TITLE,WS_URL,DESCRIPTION,CATEGORY_ID,STATUS FROM LINKS_T WHERE  STATUS='1'";
        }
        try{
        con = DbConnectionPool.getConnection();
        ps = con.prepareStatement(query);
        rs = ps.executeQuery();

        if (rs != null) {
            al = new ArrayList();
            while (rs.next()) {
                DealerMoreInfo dmi = new DealerMoreInfo();
                dmi.setdId(rs.getInt(1));
                dmi.setCompName(rs.getString(2));
                dmi.setWebUrl(rs.getString(3));
                dmi.setAddress(rs.getString(4));
                dmi.setDtypeId(rs.getInt(5));
                dmi.setActiveWsId(rs.getInt(6));
                al.add(dmi);
            }
            request.setAttribute("ll", al);
        }
        }catch(Exception e){
            LOG.error("= Exception Occured while executing query ::=" + e);
        }finally{
            if(ps!=null){
            try {
             ps.close();
            } catch (Exception e) {
                LOG.error("= Exception Occured in closing ps:=" + e);
            }
            }
         if(rs!=null){
            try {
             rs.close();
            } catch (Exception e) {
                LOG.error("= Exception Occured in closing rs:=" + e);
            }
            }
             if(con!=null){
            try {
              DbConnectionPool.closeConnection(con);
            } catch (Exception e) {
                LOG.error("= Exception Occured in closing connection :=" + e);
            }
            }
        }
        return mapping.findForward(SUCCESS);
    }
}
