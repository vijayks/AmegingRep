/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.buysell.webshop.util;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import org.apache.log4j.Logger;

/**
 *
 * @author bbsadmin
 */
public class DealerImagePathUtil {
    
    String path;
    private static Logger LOG = Logger.getLogger(DealerImagePathUtil.class);

    public DealerImagePathUtil(String path) {
        this.path = path;
    }

    public String saveImage(byte fileData[], String dirPath) {
        String fileName=Long.toString(System.nanoTime())+".jpg";
         File dp = new File(path+dirPath);
         if (dp.exists()) {
             String pat = path+dirPath + fileName;
             File f = new File(pat);
             FileOutputStream of;
            try {
                of = new FileOutputStream(f);
                of.write(fileData);
                of.close();
            } catch (IOException ex) {
                LOG.error(" Exception while writing the file to " + pat + " Exception is " + ex.getStackTrace());
                return null;
            }
         }
         else {
             dp.mkdirs();
             String pat = path+dirPath + fileName;
             File f = new File(pat);
             FileOutputStream of;
            try {
                of = new FileOutputStream(f);
                of.write(fileData);
                of.close();
            } catch (IOException ex) {
                LOG.error(" Exception while writing the file to " + pat + " Exception is " + ex.getStackTrace());
                return null;
            }
         }
         LOG.debug("File name is "+fileName);
                 return fileName;
     }

    public String getImagePath(String imageName) {
        String imgPath = null;
        if (imageName != null && imageName.length() > 0) {
//            String spl[] = imageName.split(":-:");
//            if (spl.length > 0) {
//                String fName = spl[1];
//                String fString = spl[0];
//                int len = fString.length();
//                if (fString.length() > 8) {
//                    String y = fString.substring(0, 4);
//                    String m = fString.substring(4, 6);
//                    String d = fString.substring(6, 8);
//                    String uId = fString.substring(8, len);
//                    imgPath = path + "/" + y + "/" + m + "/" + "/" + d + "/" + uId + "/" + fName;
//                }
//            }
            imgPath = path+imageName;
        }

        return imgPath;
    }
}
