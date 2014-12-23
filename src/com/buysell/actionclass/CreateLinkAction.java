/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.buysell.actionclass;

import com.buysell.beans.DealerMoreInfo;
import com.buysell.beans.ScrollOffersFormBean;
import com.buysell.db.DbConnection;
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
public class CreateLinkAction extends Action {

    /* forward name="success" path="" */
    private static final String SUCCESS = "success";
    private static final Logger LOG = Logger.getLogger(CreateLinkAction.class);
    DbConnection dbc = new DbConnection();

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
        LOG.debug("== execute method started  ==");
        ScrollOffersFormBean sf = (ScrollOffersFormBean) form;

        int id = sf.getCategory();
        String url = sf.getUrl();
        String title = sf.getTitle();
        String email = sf.getLprice();
        String desc = sf.getDescription();
        String mob = sf.getOprice();
//ID` int(11) NOT NULL auto_increment,
//  `TITLE` varchar(250) default NULL,
//  `WS_URL` varchar(50) default NULL,
//  `EMAIL_ID` varchar(50) default NULL,
//  `DESCRIPTION` varchar(1000) default NULL,
//  `CATEGORY_ID` int(11) default NULL,
//  `STATUS` int(3) default NULL,
//  `MOBILE` varchar(11) default NULL,
//  `CREATED_DT` datetime default NULL,
//  `APPROVED_BY` varchar(50) default NULL,
//  `APPROVED_DT` datetime default NULL,
//  PRIMARY KEY  (`I
        String query = null;
        try {
            query = "INSERT INTO LINKS_T (TITLE,WS_URL,EMAIL_ID,DESCRIPTION,CATEGORY_ID,STATUS,MOBILE,CREATED_DT) VALUES ('" + title + "','" + url + "','" + email + "','" + desc + "','" + id + "',2,'" + mob + "',NOW())";
            int res = dbc.executeQuery(query);
            if (res == 1) {
                request.setAttribute("okS", "Link Submitted Successfully!!");
                LOG.debug("==************ Link inserted successfully **************==");
            } else if (res == 0) {
                request.setAttribute("okF", "Link Submission Failed!!");
                LOG.debug("==************ Link Insertion Failed ******************* ==");
            }
        } catch (Exception e) {
            LOG.error("= Exception Occured while executing query ::=" + e);
        }
        return mapping.findForward(SUCCESS);
    }
}
