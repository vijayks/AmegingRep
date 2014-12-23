/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.buysell.actionclass;


import com.buysell.util.CategoryUtil;

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
public class CategoryAction extends org.apache.struts.action.Action {
    
    /* forward name="success" path="" */
    private final static String SUCCESS = "success";
    private static Logger LOG=Logger.getLogger(CategoryAction.class);
    
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
        LOG.info("CategoryAction execute() started");
    	CategoryUtil cu = new CategoryUtil();
        LOG.info("size of the category list is "+cu.getCategories().size());
        LOG.info(" Categories in util are "+cu.getCategories());
     //    CategoryService cs=new CategoryService();
       // LOG.info("CategoryService is instantiated");

    //    ArrayList results=(ArrayList)cs.getCategoryList();
        LOG.info("Result is captured form CategoryService [cs.getCategoryList()]");

    //    CategoryFormBean cfb=new CategoryFormBean();
     //   cfb.setResults(results);
     //Category cat;
  //   ((Category)cat.getSubCategories().get(1)).
        request.setAttribute("cList", cu.getCategories()) ;
     //   request.setAttribute("categoryFormBean",cfb);
        LOG.info("CategoryBean is Stored in 'request' Object \n");
         
        return mapping.findForward(SUCCESS);
    }
}
