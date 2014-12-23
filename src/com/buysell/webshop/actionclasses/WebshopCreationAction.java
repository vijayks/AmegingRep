/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.buysell.webshop.actionclasses;

import com.buysell.beans.DealerBean;
import com.buysell.webshop.db.CategoryDBManager;
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
public class WebshopCreationAction extends Action {
    
    /* forward name="success" path="" */
    private static final String SUCCESS = "success";
     private static final String NOTLOGIN = "notLogin";
    private static Logger LOG=Logger.getLogger(WebshopCreationAction.class);
    CategoryDBManager cdm=new CategoryDBManager(); 

    
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
        LOG.debug("====EXECUTE() started====");
        DealerBean db=(DealerBean)request.getSession().getAttribute("userBean");
        if(db!=null){
            long dId=db.getDlId();
            int catSz=0;
            String wsName=request.getParameter("wbNM");
        String[] prefCatIds=request.getParameterValues("cat");

        StringBuffer sb=new StringBuffer();
        for(int i=0;i<prefCatIds.length;i++){
          sb.append(prefCatIds[i]+'|');
          catSz=i;
        }
          //long dlrId,String name,String catList,int catListsize
          cdm.createWebshop(dId,wsName,sb.toString(),catSz);
        
        return mapping.findForward(SUCCESS);
        }else{
        return mapping.findForward(NOTLOGIN);
        }
    }
}
