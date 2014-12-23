/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.buysell.servlets;

import com.buysell.bids.BidAnnouncer;
import com.buysell.bids.BidMonitor;
import com.buysell.db.DbConnection;
import javax.servlet.ServletException;
import org.apache.log4j.Logger;
import org.apache.struts.action.ActionServlet;

/**
 *
 * @author bbsadmin
 */
public class MyControllerServlet extends ActionServlet {

    private static Logger LOG = Logger.getLogger(MyControllerServlet.class);


    /*    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    LOG.info("Request recieved from "+req.getContextPath());
    Globals gb;

    super.service(req, resp);
    }*/
    @Override
    public void destroy() {
        LOG.info("\n\n\n\nTrying to destroy ActionServlet");
        super.destroy();
        SponsoredAdsThread.flag=false;
        DbConnection.closeDBConnection();

    }

    @Override
    public void init() throws ServletException {
        super.init();
        DbConnectionCheckThread dbrt = new DbConnectionCheckThread();
        dbrt.setDaemon(true);
        dbrt.start();

        SponsoredAdsThread sat = new SponsoredAdsThread();
        sat.start();

        LOG.info("Creating the Controler for Buysell");
    }
}
