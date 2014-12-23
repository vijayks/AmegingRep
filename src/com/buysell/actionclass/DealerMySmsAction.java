/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.buysell.actionclass;

import com.buysell.beans.DealerBean;
import com.buysell.servlets.DealerService;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

/**
 *
 * @author bbsadmin
 */
public class DealerMySmsAction extends Action{
    final String SUCCESS ="success";
    final String failure = "fail";
    DealerService ds   = new DealerService();
    @Override
    public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
        DealerBean  db = (DealerBean)request.getSession().getAttribute("userBean");
        List ll = ds.getDealerLeadsByDelearId(db.getDlId());
        int usedSmsLeads = ds.getUsedSmsLeadsByDealerId(db.getDlId());
        if(usedSmsLeads == -1)
            usedSmsLeads = 0;
        request.setAttribute("leads", ll);
        request.setAttribute("used", String.valueOf(usedSmsLeads));
        return mapping.findForward(SUCCESS);
    }

}
