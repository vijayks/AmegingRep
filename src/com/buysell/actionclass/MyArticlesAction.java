/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.buysell.actionclass;

import com.buysell.beans.Article;
import com.buysell.beans.UserBean;
import com.buysell.util.AtricleManagerUtil;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.ActionForward;

/**
 *
 * @author BlueIgnite
 */
public class MyArticlesAction extends Action {

    /* forward name="success" path="" */
    private final static String SUCCESS = "success";
    private static final Logger LOG = Logger.getLogger(MyArticlesAction.class);

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
        LOG.info("MyArticlesAction execute started");
        List articles = null;
        List articleTitles = new ArrayList();
        UserBean ub = (UserBean) request.getSession().getAttribute("userBean");
        if (ub != null && ub.getUserId() != 0) {
            articles = AtricleManagerUtil.getAllArticlesByUser("" + ub.getUserId());
            for (Iterator itr = articles.iterator(); itr.hasNext();) {
                Article article = (Article) itr.next();
                articleTitles.add(article.getTitle());
                LOG.info(article.getTitle());
            }
            request.setAttribute("articleTitles", articleTitles);
            request.setAttribute("articles", articles);
            request.setAttribute("m", "ma");
            return mapping.findForward(SUCCESS);
        } else {
            return mapping.findForward("notLogin");
        }


    }
}
