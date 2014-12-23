/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.buysell.util;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Calendar;
import org.apache.log4j.Logger;

/**
 *
 * @author sri
 */
public class SMSCountUtil {

    int maxCount;
    int maxPerAdd;
    String path;
    private static Logger LOG = Logger.getLogger(SMSCountUtil.class);

    public SMSCountUtil(String path, int maxCount, int maxPerAdd) {
        this.maxCount = maxCount;
        this.maxPerAdd = maxPerAdd;
        this.path = path;

        LOG.debug("Max count value= "+maxCount);
        LOG.debug("Max per Add="+maxPerAdd);
        
    }

    public boolean isAbleToSendSMS(String uId, String adId) {
        return isAbleToSend(uId, adId, false);
    }

    private boolean isAbleToSend(String uId, String adId, boolean writeFile) {
        boolean flag = false;
        Calendar cal = Calendar.getInstance();
        int d = cal.get(Calendar.DAY_OF_MONTH);
        int m = cal.get(Calendar.MONTH);
        int y = cal.get(Calendar.YEAR);
        String pat = path + "/" + uId + "/" + y + "/" + m + "/" + d + "/";
        File dir = new File(pat);
        if (dir.exists()) {
            String list[] = dir.list();
            if (list != null && list.length < maxCount) {
                int c = 0;
                for (int i = 0; i < list.length; i++) {
                    String fileName = list[i];
                    if (fileName != null && (fileName.equals(adId) || fileName.startsWith(adId + "-"))) {
                        c++;
                    }
                }
                if (c < maxPerAdd) {
                    flag = true;
                    if (writeFile) {
                        String name = pat + adId;
                        if (c >= 1) {
                            name = name + "-" + c;
                        }
                        writeSMSFile(name);
                    }
                } else {
                    LOG.info(" User " + uId + " is already reached quota for " + adId + " count is  " + c);
                }

            }
        } else {
            flag = true;
            if (writeFile) {
                try {
                    File f = new File(pat);
                    if (f.mkdirs()) {
                       flag = writeSMSFile(pat + "/" + adId);
                    }
                } catch (Exception e) {
                    LOG.error("Exception while creating the SMS coutn dir " + e);
                }

            }
        }
        LOG.debug(" User " + uId + " can send SMS for add Id " + adId + " ? " + flag);
        return flag;

    }

    public boolean updateSmsCountForUserNAdd(String uId, String addId) {
        return isAbleToSend(uId, addId, true);
    }

    private boolean writeSMSFile(String fName) {
        FileOutputStream fo = null;
        try {
            File f = new File(fName);
            fo = new FileOutputStream(f);
            try {
                fo.write(1);
            } catch (IOException ex) {
                LOG.error(" Unable to write file to disk "+f.getName()+" Exception is "+ex);
                return false;
            }
           
        } catch (FileNotFoundException ex) {
            LOG.error(" Unable to write file to disk  Exception is "+ex);
            return false;
        } finally {
            try {
                fo.close();
            } catch (IOException ex) {
                LOG.error(" Problem while closing output stream. Exception is "+ex);
            }
        }
        return true;
    }
}
