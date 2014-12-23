/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.buysell.util;

import com.buysell.beans.SmsAlertsPendingListBean;
import com.buysell.util.SmsUtil.Boundary;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import org.apache.log4j.Logger;

/**
 *
 * @author bbsadmin
 */
public class DelayWorker extends Thread {

    static boolean flag = true;
    long smsAlertDelayWorkerDelayTime = Long.getLong(BuySellProperties.getProperty("smsAlertDelayWorkerDelayTime"));
    List pendingList;
    private static Logger LOG = Logger.getLogger(DelayWorker.class);

    @Override
    public void destroy() {
    }

    @Override
    public void run() {
        SmsUtil su = new SmsUtil();
        while (flag) {
            pendingList = new ArrayList();
            SmsAlertsPendingListBean saplb;


            try {
                Boundary b = su.getBoundary();
                if(b != null){
                pendingList = SmsStoreUtil.getPendingSMSAlertsList(b.lower,b.upper);
                if (pendingList != null) {
                    for (Iterator it = pendingList.iterator(); it.hasNext();) {
                        saplb =  (SmsAlertsPendingListBean) it.next();


                    }
                }
                }

                sleep(smsAlertDelayWorkerDelayTime);
            } catch (Exception ex) {
                LOG.error("= Error Occured =");
            }

        }

    }
}
