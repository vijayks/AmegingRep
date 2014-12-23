/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.buysell.webshop.actionclasses;

import com.buysell.beans.DealerBean;
import com.buysell.webshop.beans.Product;
import com.buysell.webshop.db.CategoryDBManager;
import com.buysell.webshop.db.ProductDBManager;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.StringTokenizer;
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
public class ProductsAssigner extends Action {

    /* forward name="success" path="" */
    private static final String SUCCESS = "success";
    private static Logger LOG = Logger.getLogger(ProductsAssigner.class);
    ProductDBManager pdm = new ProductDBManager();

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
        LOG.debug("==========EXECUTE() started===========");

        DealerBean db = (DealerBean) request.getSession().getAttribute("userBean");
        long dId = db.getDlId();
        String subCat = request.getParameter("subcat");
        String sId = null;
        String name = null;
        StringTokenizer st = new StringTokenizer(subCat, "@");
        while (st.hasMoreElements()) {
            name = st.nextToken();
            sId = st.nextToken();
        }
        request.setAttribute("nm", name);
        request.setAttribute("catId", sId);

        int sCatId = Integer.parseInt(sId);
        if (sCatId != '0') {
            ArrayList assignedProdList = pdm.getAssignedProductsByCatId(sCatId);
            request.setAttribute("assignedPrd", assignedProdList);
            ArrayList prodList = pdm.getProductsByDealerId(dId);
            request.setAttribute("prodList", prodList);
        }
        return mapping.findForward(SUCCESS);
    }
}
