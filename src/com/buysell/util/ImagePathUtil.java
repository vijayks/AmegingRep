/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.buysell.util;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Calendar;
import org.apache.log4j.Logger;

/**
 * FileOutputStream of = new FileOutputStream(ff);
//            byte[] b = f1.getFileData();
//            of.write(b);
//            of.close();Calendar cal = Calendar.getInstance();
        String fmt = "{0,date,/yyyy/MM/dd/}";
        System.out.println(" Formatted string is "+MessageFormat.format(fmt, new Object[]{cal.getTime()}));
 * @author sri
 */
public class ImagePathUtil {

    String path;
    ImageWatermarkingUtil iwu = new ImageWatermarkingUtil();
    private static Logger LOG = Logger.getLogger(ImagePathUtil.class);

    public ImagePathUtil(String path) {
        this.path = path;
    }

    public String saveImage(byte fileData[], String userId, String fileName) {
        Calendar cal = Calendar.getInstance();
        int d = cal.get(Calendar.DAY_OF_MONTH);
        int m = cal.get(Calendar.MONTH);
        int y = cal.get(Calendar.YEAR);
        if(d < 10)
        {
            d=40+d;
        }
        if(m < 10)
        {
            m=40+m;
        }
        String pat = path + "/" + userId + "/" + y + "/" + m + "/" + d + "/" + fileName;
        String dirPath = path + "/" + userId + "/" + y + "/" + m + "/" + d;
        File dp = new File(dirPath);
        File f = new File(pat);
        if (!dp.exists())
            dp.mkdirs();
        FileOutputStream of;
        try {
            of = new FileOutputStream(f);
            of.write(fileData);
            of.close();
            iwu.addWaterMark("Bharatbuysell.com", f, f.getName().substring(f.getName().lastIndexOf(".")+1), f);
        } catch (IOException ex) {
            LOG.error(" Exception while writing the file to " + pat + " Exception is " + ex.getStackTrace());
            return null;
        }
        return userId + "" + y + "" + m + "" + d + ":-:" + fileName;
    }

    public String getImagePath(String imageName) {
        String imgPath = null;
        if (imageName != null && imageName.length() > 0) {
            String spl[] = imageName.split(":-:");
            if (spl.length > 0) {
                String fName = spl[1];
                String fString = spl[0];
                int len = fString.length();
                if (fString.length() > 8) {
                    String uId = fString.substring(0, (len - 8));
                    String y = fString.substring(len - 8, len - 4);
                    String m = fString.substring(len - 4, len - 2);
                    String d = fString.substring(len - 2, len);
                    imgPath = path + "/" + uId + "/" + y + "/" + m + "/" + "/" + d + "/" + fName;
                }
            }
        }
        
        return imgPath;
    }
}
