/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.buysell.actionclass;

import com.buysell.db.DbConnection;
import com.buysell.util.CategoryUtil;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

/**
 *
 * @author praveen.ch
 */
public class FeedBackAction extends org.apache.struts.action.Action {

    private final static String SUCCESS = "success";
    private final static Logger LOG = Logger.getLogger(AdSearchTilesDisplayAction.class);
    DbConnection db;

    @Override
    public ActionForward execute(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        CategoryUtil cu = new CategoryUtil();
        request.setAttribute("categoryList", cu.getCategories());

        int qselection = 0;

        qselection = Integer.parseInt(request.getParameter("qselection"));
        db = new DbConnection();
        db.executeQuery("INSERT INTO FEEDBACK_T (QNO,NAME,EMAIL_ID,TELEPHONE,COMMENT,STATUS,CREATION_DATE) VALUES ( " + qselection + " , '" + request.getParameter("name") + "', '" + request.getParameter("email") + "', '" + request.getParameter("mobilef") + "', '" + request.getParameter("limitedtextarea") + "',2,NOW())");

        LOG.info("FEED BACK INFO INSERTED INTO DATABASE SUCCESSFULLY");

        request.getSession().setAttribute("ok", "Thank u for contacting www.bharatbuysell.com, we will respond to ur feed back shortly");

        request.setAttribute("m", "h");




        return mapping.findForward(SUCCESS);
    }
}
