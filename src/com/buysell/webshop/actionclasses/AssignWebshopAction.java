/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.buysell.webshop.actionclasses;

import com.buysell.beans.DealerBean;
import com.buysell.db.DbConnectionPool;
import com.buysell.webshop.db.CategoryDBManager;
import java.sql.Connection;
import java.sql.PreparedStatement;
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
 * @author madhuri
 */
public class AssignWebshopAction extends Action {

    /* forward name="success" path="" */
    private static final String SUCCESS = "success";
    private static Logger LOG = Logger.getLogger(AssignWebshopAction.class);
    Connection con = null;
    PreparedStatement ps = null;
    CategoryDBManager cdm = new CategoryDBManager();

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
        LOG.debug("== EXECUTE() started ==");
        String webID = request.getParameter("wId");
        long wId = Integer.parseInt(webID);

        DealerBean db = (DealerBean) request.getSession().getAttribute("userBean");
        long dId = db.getDlId();
        String query = null;
        try {
            String query1 = "UPDATE WEBSHOP_T SET STATUS=1 WHERE STATUS=5 AND DEALER_ID='" + dId + "'";
            con = DbConnectionPool.getConnection();
            ps = con.prepareStatement(query1);
            ps.executeUpdate();
        } catch (Exception e) {
            LOG.error("= Exception Occured in Executing query1 ::=" + e);
        } finally {
            try {
                if (ps != null) {
                    ps.close();
                }
            } catch (Exception e) {
                LOG.error("= Exception Occured in closing Prepared Statement connections ::=" + e);
            }
            DbConnectionPool.closeConnection(con);
        }
        try {
            query = "UPDATE WEBSHOP_T SET STATUS='5' WHERE ID='" + wId + "'";
            con = DbConnectionPool.getConnection();
            ps = con.prepareStatement(query);
            ps.executeUpdate();
        } catch (Exception e) {
            LOG.error("= Exception Occured in Executing query ::=" + e);
        } finally {
            try {
                if (ps != null) {
                    ps.close();
                }
            } catch (Exception e) {
                LOG.error("= Exception Occured in closing Prepared Statement connections ::=" + e);
            }
            DbConnectionPool.closeConnection(con);
        }
        ArrayList al = new ArrayList();
        al = cdm.getWebshopsBydId(dId);
        request.setAttribute("webshopList", al);
        request.setAttribute("ws", "Webshop Assigned Successfully");
        return mapping.findForward(SUCCESS);
    }
}
