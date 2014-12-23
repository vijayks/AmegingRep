/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.buysell.webshop.actionclasses;

import com.buysell.db.DbConnectionPool;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
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
public class DeleteAssignProducts extends org.apache.struts.action.Action {
    
    /* forward name="success" path="" */
    private static final String NSUCCESS = "nSuccess";
    private static final String SSUCCESS = "sSuccess";
    private static final String TSUCCESS = "tSuccess";
    private static final String SUCCESS = "success";


    private static Logger LOG=Logger.getLogger(DeleteAssignProducts.class);
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

            LOG.debug("----Execute() in DeleteAssignProducts Started-----");
       
            String idVal=request.getParameter("id");
            LOG.debug("id new:: "+idVal);

            String linkTyp = request.getParameter("lT");
            LOG.debug("Link Type ::" + linkTyp);
            int st = 0;
            if ((linkTyp.equals("new"))) {
                st = 1;
            } else if ((linkTyp.equals("spl"))) {
                st = 2;
            } else if ((linkTyp.equals("tnl"))) {
                st = 3;
            }
            String query;
            PreparedStatement ps=null;

            try {
                query="DELETE FROM DEALER_WCT_T WHERE ID='"+idVal+"'";
                con=DbConnectionPool.getConnection();
                ps=con.prepareStatement(query);
                ps.executeUpdate();
                request.setAttribute("ok","Deleted Successfully!!");
                LOG.debug("Product with Id :: '"+idVal+"' is Deleted Successfully");

            } catch (Exception e) {
                LOG.error("Error occurred while executing Delete query ::"+e);
             }finally{
                try {
                    if(ps!=null){
                      ps.close();
                    }
                } catch (Exception e) {
                    LOG.error("Error occurred while closing Prepared Statement ::"+e);
                }
                  DbConnectionPool.closeConnection(con);
             }
             if ((linkTyp.equals("new"))) {
               return mapping.findForward(NSUCCESS);
            } else if ((linkTyp.equals("spl"))) {
               return mapping.findForward(SSUCCESS);
            } else if ((linkTyp.equals("tnl"))) {
              return mapping.findForward(TSUCCESS);
            }
        return mapping.findForward(SUCCESS);
    }
}
