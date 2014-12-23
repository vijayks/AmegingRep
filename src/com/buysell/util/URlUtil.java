/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.buysell.util;

import java.util.StringTokenizer;

/**
 *
 * @author bbsadmin
 */
public class URlUtil {

    public static String getUrlString(String description, String adId, String catId){
        if(description!=null){
        description=description.replaceAll(","," ");
        description=description.replaceAll("\\("," ");
        description=description.replaceAll("\\)"," ");
        description=description.replaceAll("#","");
        description=description.replaceAll("%","percent");
        description=description.replaceAll("&amp;"," and ");
        description=description.replaceAll("&"," and ");
        description=description.replaceAll("\"","");
        description=description.replaceAll("\\?","");
        }
        StringTokenizer stx = new StringTokenizer(description," ");
        StringBuffer sb = new StringBuffer();
        while(stx.hasMoreTokens()){
            sb.append(stx.nextToken());
            sb.append("-");
        }
        if(catId!=null&&catId.trim().length()>0){
            sb.append(catId);
        }
        if(adId!=null&&adId.trim().length()>0) {
            sb.append("s"+adId);
        }
        return sb.substring(0,sb.length())+".htm";
    }

}
