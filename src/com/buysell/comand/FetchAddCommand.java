/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.buysell.comand;

import com.buysell.util.AddCountUtil;
import java.util.StringTokenizer;
import org.apache.log4j.Logger;

/**
 *
 * @author bbsadmin
 * Command is
 * NAD$categoryID$AddID
 */
public class FetchAddCommand implements CommandIntr{
private static Logger LOG = Logger.getLogger(FetchAddCommand.class);
    public void execute(String str){
        StringTokenizer strt = new StringTokenizer(str,"$");
        String comm = strt.nextToken();
        String catId = strt.nextToken();
        String addId = strt.nextToken();
        String cityName =strt.nextToken();
        int inc =Integer.parseInt(strt.nextToken());
    LOG.info("HI this is for fetching add command for city "+cityName);
    LOG.debug("Incrementing the count for cat id "+catId);
    AddCountUtil.incAddCountByCatId(catId, inc, cityName);
    LOG.info("After incrementign countis "+AddCountUtil.getAddCountByCatID(catId,cityName));
    }
}
