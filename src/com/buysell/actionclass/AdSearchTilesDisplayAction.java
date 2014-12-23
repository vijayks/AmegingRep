/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.buysell.actionclass;

import com.buysell.util.AdvancedTiles;
import com.buysell.util.CategoryUtil;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.ActionForward;

/**
 *
 * @author bbsadmin
 */
public class AdSearchTilesDisplayAction extends org.apache.struts.action.Action {

    private final static String SUCCESS = "success";
    private final static Logger LOG = Logger.getLogger(AdSearchTilesDisplayAction.class);
    CategoryUtil cu = new CategoryUtil();
    List ll = new ArrayList();

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

        LOG.info("AdSearchTilesDisplayAction execute() method started");


        String subCatId1 = request.getParameter("subCatId");
        int subCatId = 0;
        try {
            if(subCatId1!=null)
                subCatId = Integer.parseInt(subCatId1.trim());
            else {
                if(request.getParameter("clfId")!=null)
                    subCatId = cu.getRootCatId(Integer.parseInt(request.getParameter("clfId").trim()));
            }
        } catch (Exception e) {
            LOG.debug("error:" + e);
        }
        // Getting root id of the subcatId
       

        AdvancedTiles tt = new AdvancedTiles(subCatId);
        ll = tt.getTileList(subCatId);
        request.setAttribute("tilesList", ll);
        LOG.info("\n\n==========initSearch=" + request.getParameter("m") + "=============\n\n");
        String initSearch = request.getParameter("m");
        if (initSearch != null && initSearch.trim().length() > 0) {
            return mapping.findForward(initSearch);
        } else {
            return mapping.findForward(SUCCESS);
        }
    }
}
