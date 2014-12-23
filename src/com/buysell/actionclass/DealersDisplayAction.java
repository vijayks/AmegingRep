/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.buysell.actionclass;

import com.buysell.servlets.DealerService;
import com.buysell.util.BuySellProperties;
import com.buysell.util.CategoryUtil;
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
public class DealersDisplayAction extends Action {
    
    /* forward name="success" path="" */
    private final static String SUCCESS = "success";
    private final static String FAILURE = "failure";
    private static Logger LOG = Logger.getLogger(DealersDisplayAction.class);
    CategoryUtil cu = new CategoryUtil();
    DealerService ds = new DealerService();    
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
        
        String subCatId1 =(String) request.getParameter("subCatId");
        int subCatId;
        if (subCatId1 != null && subCatId1.trim().length() >0) {
            subCatId = Integer.parseInt(subCatId1);
            request.setAttribute("subCatId", subCatId + "");
        } else {
            return mapping.findForward(FAILURE);
        }
        StringBuffer sb1 = new StringBuffer("SELECT DOMAIN_NAME,DLOGO_PATH,DEALER_COMP_T.DESCRIPTION,CITY,LOCALITY,DEALER_INFO_T.DEALER_ID,USER_T.PHONE,DEALER_COMP_T.PHONE1,DEALER_INFO_T.DTYPE_ID,USER_LOGIN_T.STATUS from DEALER_INFO_T,DEALER_COMP_T,ADDRESS_T,USER_T,DEALER_CATEGORY_T,USER_LOGIN_T WHERE USER_LOGIN_T.USER_ID=USER_T.USER_ID AND ADDRESS_T.ADDRESS_ID=DEALER_INFO_T.ADD_ID AND USER_T.USER_ID=DEALER_INFO_T.USER_ID AND DEALER_INFO_T.DEALER_ID=DEALER_COMP_T.DEALER_ID AND DEALER_INFO_T.DEALER_ID=DEALER_CATEGORY_T.DEALER_ID AND DEALER_CATEGORY_T.CATEGORY_ID ");
        StringBuffer sb2 = new StringBuffer(sb1.toString());
        request.setAttribute("categoryList", cu.getCategories());
        //LOG.info("CategoryList object is stored in the request scope");
        request.setAttribute("subCatId", subCatId);
        String catName = cu.getCategoryNameWithId(subCatId);
        request.setAttribute("catName", catName);
        String urlstr = request.getRequestURI();

       

        int start = 0;
        int range = Integer.parseInt(BuySellProperties.getProperty("middle"));


            try {
                String s=request.getParameter("start");
                if (s != null && s.trim().length()>0) {
                    start = Integer.parseInt(s);
                } 
                String r=request.getParameter("range");
                if (r != null && r.trim().length()>0) {
                    range = Integer.parseInt(r);
                } 
            } catch (Exception e) {
                LOG.error("range:" + e);
            }


         String  city = (String) request.getSession().getAttribute("city");
        LOG.debug("User Selected City>>>>>>>>" + city);

        String locals = "*";
        String[] localities = request.getParameterValues("lcs");

        if (localities != null && localities.length > 0) {
            List localsSelected = new ArrayList();
            StringBuffer sb = new StringBuffer();
            for (int i = 0; i < localities.length; i++) {

                sb.append("'" + localities[i] + "' ,");
                localsSelected.add(localities[i]);
            }
            locals = sb.substring(0, sb.length() - 1);
            request.setAttribute("localsSelected", localsSelected);
        }

        LOG.debug("DealerService is instantiated");
        String qry1 = null;
        String qry2 = null;
        if (city.trim().equals("All India")) {
            sb1.append(" LIKE '%|"+subCatId1+"|%'  LIMIT " + start + "," + range );
            sb2.append(" LIKE '%|"+subCatId1+"|%'");

        } else {
            if(locals.toString().trim().length()>1) {
                sb1.append(" LIKE '%|"+subCatId1+"|%' AND ADDRESS_T.CITY='" + city + "' AND ADDRESS_T.LOCALITY IN (" +locals + ") LIMIT " + start + "," + range);
                sb2.append(" LIKE '%|"+subCatId1+"|%' AND ADDRESS_T.CITY='" + city +"' AND ADDRESS_T.LOCALITY IN (" +locals + ")");
            }
            else {
                sb1.append(" LIKE '%|"+subCatId1+"|%' AND ADDRESS_T.CITY='" + city + "' LIMIT " + start + "," + range  );                
                sb2.append(" LIKE '%|"+subCatId1+"|%' AND ADDRESS_T.CITY='" + city +"'");
            }
        }
        qry1 =sb1.toString();
        qry2 =sb2.toString();

        ArrayList al = ds.getDealersList(qry1);        
        request.setAttribute("bestDealersBean", al);

        request.setAttribute("pageTitle", cu.getCategoryNameWithId(subCatId));       

        ArrayList al2 = ds.getDealersList(qry2);
        request.setAttribute("c", al2.size());
        return mapping.findForward(SUCCESS);
    }
}
