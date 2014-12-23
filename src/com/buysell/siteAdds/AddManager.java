/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.buysell.siteAdds;

import com.buysell.util.BuySellProperties;
import java.util.ArrayList;
import java.util.List;
import java.util.Vector;
import org.apache.log4j.Logger;

/**
 *
 * @author bbsadmin
 */
public class AddManager {

    Vector immidiateQue = new Vector();
    Vector currentQue = new Vector();
    Vector addQue = new Vector();
    boolean running = false;
    String sleep = BuySellProperties.getProperty("site-add-sleep-time");
    int sTime;
    private static Logger LOG = Logger.getLogger(AddManager.class);

    public AddManager() {
        AddMonitor.startMonitor();
        running = true;
        CurrentAddsMonitor caM = new CurrentAddsMonitor();
        ImmidiateAddsMonitor imM = new ImmidiateAddsMonitor();
        AddQMonitor addM = new AddQMonitor();
        caM.setDaemon(true);
        imM.setDaemon(true);
        addM.setDaemon(true);
        caM.start();
        imM.start();
        addM.start();
        try {
            sTime = Integer.parseInt(sleep);
        } catch (NumberFormatException x) {
            LOG.error("Please configure site-add-sleep-time property "+x);
            sTime = 60000;
        }
        LOG.debug(" All monitore are started");
    }

    public class CurrentAddsMonitor extends Thread {

        @Override
        public void run() {
          //  LOG.debug("Started CurrentAddsMonitor .......");
            while (running) {
          //      LOG.debug("fetching current adds............");
                Vector v =(Vector) (AddMonitor.getCurrAdds());
                currentQue.clear();
                currentQue.addAll(v);
                try {
             //      LOG.debug("SLEEPINMG FOR CurrentAddsMonitor"+sTime);
                    sleep(sTime);
             //        LOG.debug("out side sleep CurrentAddsMonitor"+sTime);
                } catch (InterruptedException ex) {
             //       LOG.error("Error while sleeping " + ex);
                }
            }
          //  LOG.debug("CAME OUT OF CURRENT ADD Q ............");
        }
    }

    public class ImmidiateAddsMonitor extends Thread {

        @Override
        public void run() {
           
            while (running) {
                
                Vector v = (Vector)AddMonitor.getImmidAdds();
                immidiateQue.clear();
              //  LOG.debug("Clearing immidiate adds");
                immidiateQue.addAll(v);
                try {
                     sleep(sTime);
                   } catch (InterruptedException ex) {
                   // LOG.error("Error while sleeping " + ex);
                }
            }
           
        }
    }
    public class AddQMonitor extends Thread {

        @Override
        public void run() {
          //  LOG.debug("Started AddQMonitor .......");
            while (running) {
                
                Vector v = (Vector)AddMonitor.getAdds();
                addQue.clear();
                addQue.addAll(v);
             //   LOG.debug("==  =="+v);
                try {
                   
                    sleep(sTime);
                    
                } catch (InterruptedException ex) {
                //    LOG.error("Error while sleeping " + ex);
                }
            }
            
        }
    }

    public List getImmidiateAdds(int number) {
        List ll = new ArrayList();
     //   LOG.debug ("Immidiate adds are:: "+immidiateQue.size()+"--  Entered number is ::"+number);
        if (immidiateQue.size() >= number) {
            ll = immidiateQue.subList(0, number);
         //   LOG.debug("inside >=");
        } else if (immidiateQue.size() > 0) {
            ll = immidiateQue.subList(0, immidiateQue.size() - 1);
         //   LOG.debug("else >=");
        }
       // LOG.debug("Ads retrun are "+ll);
        return ll;
    }

    public List getCurrentAdds(int number) {
        List ll = new ArrayList();
        if (currentQue.size() >= number) {
            ll = currentQue.subList(0, number);
        } else if (currentQue.size() > 0) {
            ll = currentQue.subList(0, currentQue.size() - 1);
        }
        return ll;
    }

    public List getAdds(int number) {
       // LOG.debug("== get ads method  ==");

        List ll = new ArrayList();
        if (addQue.size() >= number) {
            ll = addQue.subList(0, number);
        } else if (addQue.size() > 0) {
            ll = addQue.subList(0, addQue.size() - 1);
        }
      //  LOG.debug("== Before returning get adds()=="+ll.size());


        return ll;
    }

    public void stopAll(){
        running = false;
        AddMonitor.stopAll();
    }
}

