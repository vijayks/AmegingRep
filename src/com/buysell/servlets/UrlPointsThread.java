/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.buysell.servlets;

import com.buysell.util.BuySellProperties;
import com.buysell.util.UrlPointsUtil;
import org.apache.log4j.Logger;

/**
 *
 * @author bbsadmin
 */
public class UrlPointsThread extends Thread {

    private static Logger LOG = Logger.getLogger(UrlPointsThread.class);
    private static final boolean flag = true;
    long slpTm = BuySellProperties.getProperty("urlPointsThreadSleep") != null ? Long.parseLong(BuySellProperties.getProperty("urlPointsThreadSleep")) : 900000;
    UrlPointsUtil upu = new UrlPointsUtil();

    @Override
    public void run() {
        LOG.info("Starting UrlPointsThread ... ");
        while (flag) {
            LOG.debug("Running UrlPointsThread ... ");
            upu.populateUrlPoints();
            try {
                sleep(slpTm);
            } catch (Exception e) {
                LOG.error("= Exception Occured in  ::=" + e);
            }
        }
    }
}
