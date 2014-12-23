/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.buysell.actionclass;

import com.buysell.beans.DealerMoreInfo;
import com.buysell.servlets.DealerService;
import com.buysell.util.CategoryUtil;
import java.util.ArrayList;
import java.util.StringTokenizer;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import com.buysell.db.DbConnection;

/**
 *
 * @author bbsadmin
 */
public class DealerMoreDetailsAC extends org.apache.struts.action.Action {

    /* forward name="success" path="" */
     DbConnection db = new DbConnection();
    private static final String SUCCESS = "success";
    private static Logger LOG = Logger.getLogger(DealerMoreDetailsAC.class);
    DealerService ds = new DealerService();

    @Override
    public ActionForward execute(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        request.setAttribute("categoryList", CategoryUtil.getCategories());
        DealerMoreInfo dmi=new DealerMoreInfo();
        ArrayList pd= new ArrayList();
        ArrayList im= new ArrayList();
        String dId = request.getParameter("dlId");
        if (dId != null && dId.length() > 0) {
            int dIdint = Integer.parseInt(dId);
            dmi=ds.getDealerMoreInfo(dIdint);
            if(dmi.getProducts()!=null && dmi.getProducts().toString().trim().length()>0) {
                StringTokenizer str3 = new StringTokenizer(dmi.getProducts(), "|");
                 while (str3.hasMoreTokens()) {
                     pd.add((String)str3.nextToken());
                 }
                request.setAttribute("products", pd);
            }
            if(dmi.getProductImages()!=null && dmi.getProductImages().toString().trim().length()>0) {
                StringTokenizer str3 = new StringTokenizer(dmi.getProductImages(), "|");
                 while (str3.hasMoreTokens()) {
                     im.add((String)str3.nextToken());
                 }
                request.setAttribute("images", im);
            }
            request.setAttribute("dmi", dmi);
             db.executeQuery("UPDATE DEALER_INFO_T SET MICROSITE_TOTVISTORS=MICROSITE_TOTVISTORS+1 WHERE DEALER_ID=" + dId);
        }
         return mapping.findForward(SUCCESS);
    }
}
