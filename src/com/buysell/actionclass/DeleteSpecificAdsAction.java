/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.buysell.actionclass;

import com.buysell.beans.UserBean;
import com.buysell.db.DbConnection;
import com.buysell.util.CategoryUtil;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.ActionForward;
import com.buysell.beans.AdsBean;
import java.util.ArrayList;
import java.util.List;
import java.util.StringTokenizer;
import org.apache.commons.lang.text.StrTokenizer;

/**
 *
 * @author bbsadmin
 */
public class DeleteSpecificAdsAction extends org.apache.struts.action.Action {

    /* forward name="success" path="" */
    private final static String SUCCESS = "success";
    private static Logger LOG = Logger.getLogger(DeleteSpecificAdsAction.class);
    private final static String NOTLOGIN = "notLogin";

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

        LOG.info("DeleteSpecificAdsAction execute() is started");
        String active[] = request.getParameterValues("active");
        String hold[] = request.getParameterValues("hold");
        String expired[] = request.getParameterValues("expired");
        String reposted[] = request.getParameterValues("reposted");
        String incomplete[] = request.getParameterValues("incomplete");
        UserBean ub = (UserBean) request.getSession().getAttribute("userBean");

        DbConnection db = new DbConnection();
        CategoryUtil cu = new CategoryUtil();
        if (ub != null) {
            int i = 0;
            int res = 0;
            if (active != null) {
                for (i = 0; i < active.length; i++) {
                    if (!active[i].trim().equals("on")) {
                        List al = getTokens(active[i], "|");
                        res = db.executeQuery("UPDATE AD_T SET STATUS=5,LAST_MODIFICATION_DATE=NOW() WHERE AD_ID=" + al.get(0) + " AND USER_ID=" + ub.getUserId() + " AND STATUS=1");
                        if (res == 1) {
                            db.executeQuery("INSERT INTO MAIL_HISTORY_T(AD_ID,USER_ID,EMAIL_ID,ACTION,ACTION_DT) VALUES (" + al.get(0) + "," + ub.getUserId() + ",'" + ub.getLoginName() + "','AD DELETED BY USER.',NOW())");
                            if("1".equals(al.get(1)))
                                db.executeQuery("UPDATE USER_T SET BALANCE_ADS=BALANCE_ADS+1 WHERE USER_ID=" + ub.getUserId() );
                        }
                    }
                }

            }


            if (hold != null) {
                for (i = 0; i < hold.length; i++) {
                    if (!hold[i].trim().equals("on")) {
                        List al = getTokens(hold[i], "|");
                        res = db.executeQuery("UPDATE AD_T SET STATUS=5,LAST_MODIFICATION_DATE=NOW() WHERE AD_ID=" + al.get(0) + " AND USER_ID=" + ub.getUserId() + " AND STATUS=2");
                        if (res == 1 && "1".equals(al.get(1))) {
                            db.executeQuery("UPDATE USER_T SET BALANCE_ADS=BALANCE_ADS+1 WHERE USER_ID=" + ub.getUserId() + "");
                        }
                    }
                }

            }


            if (expired != null) {
                for (i = 0; i < expired.length; i++) {
                    if (!expired[i].trim().equals("on")) {
                        db.executeQuery("UPDATE AD_T SET STATUS=5,LAST_MODIFICATION_DATE=NOW() WHERE AD_ID=" + expired[i] + " AND USER_ID=" + ub.getUserId());
                    }
                }

            }


            if (reposted != null) {
                for (i = 0; i < reposted.length; i++) {
                    if (!reposted[i].trim().equals("on")) {
                        db.executeQuery("UPDATE AD_T SET STATUS=5,LAST_MODIFICATION_DATE=NOW() WHERE AD_ID=" + reposted[i] + " AND USER_ID=" + ub.getUserId());
                    }
                }

            }


            if (incomplete != null) {

                for (i = 0; i < incomplete.length; i++) {
                    if (!incomplete[i].trim().equals("on")) {
                        db.executeQuery("UPDATE AD_T SET STATUS=5,LAST_MODIFICATION_DATE=NOW() WHERE AD_ID=" + incomplete[i] + " AND USER_ID=" + ub.getUserId());
                    }
                }

            }
            request.setAttribute("m", "ma");
            request.setAttribute("suc", "Ad(s) Deleted Successfully");
            cu.forcePopulate();
            return mapping.findForward(SUCCESS);
        } else {
            return mapping.findForward(NOTLOGIN);
        }

    }

    private List getTokens(String val, String sep) {
        List ll = new ArrayList();
        StringTokenizer st = new StringTokenizer(val, sep);
        while (st.hasMoreTokens()) {
            String vl = st.nextToken();
            ll.add(vl);
        }
        return ll;

    }

}
