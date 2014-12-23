/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.buysell.comand;

import org.apache.log4j.Logger;

/**
 *
 * @author bbsadmin
 */
public class PopulateCategoryCommand  implements CommandIntr{

    private static Logger LOG = Logger.getLogger(CommandIntr.class);
    public void execute(String str){
    LOG.info("Command Received for PopulateCategory");
    }

}
