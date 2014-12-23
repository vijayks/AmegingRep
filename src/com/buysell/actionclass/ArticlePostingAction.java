/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.buysell.actionclass;

import com.buysell.beans.Article;
import com.buysell.beans.UserBean;
import com.buysell.util.AtricleManagerUtil;
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
public class ArticlePostingAction extends org.apache.struts.action.Action {

    /* forward name="success" path="" */
    private final static String SUCCESS = "success";
    private final static Logger LOG = Logger.getLogger(ArticlePostingAction.class);

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
        LOG.info("ArticalPostingAction execute() stareted");

        request.setAttribute("categoryList", CategoryUtil.getCategories());
        String title = request.getParameter("title");
        String article = request.getParameter("article");
        UserBean ub = (UserBean) request.getSession().getAttribute("userBean");
        if (ub != null) {
            Article a = new Article();
            a.setUserId(String.valueOf(ub.getUserId()));
            a.setTitle(title);
            a.setMessage(article);
            a.setStatus("pending");
            a.setComents("-NA-");
            a.setPoints("0");
            AtricleManagerUtil.createArticle(a);
        } else {
            return mapping.findForward("notLogin");
        }
        LOG.info("title=" + title);
        LOG.info("artical=" + article);
        request.setAttribute("output", "You Successfully Posted Artical.");
        request.setAttribute("m", "ma");
        return mapping.findForward(SUCCESS);
    }
}
