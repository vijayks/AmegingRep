/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.buysell.webshop.actionclasses;

import com.buysell.beans.DealerBean;
import com.buysell.webshop.db.CategoryDBManager;
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
public class DefineWebshopAction extends org.apache.struts.action.Action {

    /* forward name="success" path="" */
    private static final String SUCCESS = "success";
    private static final String NOTLOGIN = "notLogin";
    private static Logger LOG = Logger.getLogger(DefineWebshopAction.class);
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
        LOG.debug("==  EXECUTE() started  ==");
        DealerBean db = (DealerBean) request.getSession().getAttribute("userBean");
        if (db != null) {
            String[] catg = request.getParameterValues("catgs");
            String wsis = request.getParameter("wsst");
            String[] prois = request.getParameterValues("pdcts");
            int cl = 0;
            int pl = 0;
            if (catg != null) {
                cl = catg.length;
            }
            if (prois != null) {
                pl = prois.length;
            }
            StringBuffer sb1 = new StringBuffer();
            StringBuffer sb2 = new StringBuffer();

            String[] ws = wsis.split("\\^");
            long webId = Long.parseLong(ws[0]);
            int webStatus = Integer.parseInt(ws[1]);

            for (int i = 0; i < cl; i++) {
                String[] cat = catg[i].split("\\^");
                sb1.append(cat[0] + '|');
                sb2.append(cat[1] + '|');
            }
            String catId = sb1.toString();
            String catStatus = sb2.toString();

            sb1 = new StringBuffer();
            sb2 = new StringBuffer();
            for (int i = 0; i < pl; i++) {
                String[] pro = prois[i].split("\\^");
                sb1.append(pro[0] + '|');
                sb2.append(pro[1] + '|');
            }
            String prodId = sb1.toString();
            String prodStatus = sb2.toString();

            String msg = cdm.defineWebshop(db.getDlId(), webId, webStatus, catId, catStatus, cl, prodId, prodStatus, pl);
            if (msg != null && msg.equals("fully updated")) {
                request.setAttribute("wsMsg", "Webshop Defined Successfully!!");
            } else if (msg != null && msg.equals("partially updated")) {
                request.setAttribute("wsMsg", "Webshop Defined Partially !! ");
            } else {
                request.setAttribute("wsMsgF", "Webshop Definition Failure!!");
            }
            ArrayList al = new ArrayList();
            al = cdm.getCategoriesByDid(db.getDlId());
            request.setAttribute("webshopList", al);

            return mapping.findForward(SUCCESS);
        } else {
            return mapping.findForward(NOTLOGIN);
        }
    }
}
