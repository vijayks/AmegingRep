/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.buysell.util;

import com.buysell.actionclass.InviteFriends.NameEmail;
import com.buysell.beans.UserBean;
import com.xdatasystem.contactsimporter.gmail.GmailImporter;
import com.xdatasystem.contactsimporter.yahoo.YahooImporter;
import com.xdatasystem.user.Contact;
import java.io.StringWriter;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Properties;
import java.util.logging.Level;
import javax.mail.MessagingException;
import javax.mail.internet.InternetAddress;
import org.apache.log4j.Logger;
import org.apache.velocity.Template;
import org.apache.velocity.VelocityContext;
import org.apache.velocity.app.Velocity;

/**
 *
 * @author bbsadmin
 */
public class ContactImporter {

    private static Logger LOG = Logger.getLogger(ContactImporter.class);
    String gmail = "gmail";
    String yahoo = "yahoo";
    SendMail sm = new SendMail();
    String inviteSubject = BuySellProperties.getProperty("invite.mail.subject");
  
    
    public ContactImporter() {
        init();
    }

//    public void sendMailToContacts(String emailId, String passwd, String name) {
//        try {
//            List ll = new ArrayList();
//            ll = getContactList(emailId, passwd);
//            if (ll != null && ll.size() > 0) {
//                LOG.debug("Sending invite mails to the contact list of size ..." + ll.size());
//                sendInviteMails(ll, name);
//            }
//        } catch (Exception ex) {
//           LOG.error(" Error while fetching contact list"+ex);
//        }
//
//    }

    public List getContactList(String emailId, String passwd) throws Exception {
        List ll = null;
        try {

            if (emailId.indexOf(gmail) > 0) {
                GmailImporter gm = new GmailImporter(emailId, passwd);
                ll = gm.getContactList();
            }else if(emailId.indexOf(yahoo) >0 ){
                YahooImporter yi = new YahooImporter(emailId, passwd);
                ll = yi.getContactList();
            }
        } catch (Exception e) {
            LOG.error("While accessing the contact List from Email"+e);
            throw e;
        }
        return ll;
    }

//    public void sendInviteMails(List ll,String name) {
//        Iterator itr = ll.iterator();
//        InternetAddress ita[] = new InternetAddress[ll.size()];
//        int i=0;
//        while(itr.hasNext()){
//            Contact c = (Contact) itr.next();
//            try {
//                ita[i] = new InternetAddress(c.getEmailAddress());
//                i++;
//            } catch (Exception e) {
//                LOG.error("Got exception while adding email to internet address "+e);
//            }
//        }
//        Mutil mu = new Mutil();
//      String rc= "bob";
//        String message = getMessage(name,rc);
//        try {
//            sm.send(null, inviteSubject, message, name, ita);
//        } catch (MessagingException e) {
//            LOG.error("Not able to send invite mail to "+ita+" exception is "+e);
//        }
//
//    }
     public void sendInviteMailsByEmails(List ll,String name,String rco,String city) {
        Iterator itr = ll.iterator();
        InternetAddress ita[] = new InternetAddress[ll.size()];
        int i=0;
        while(itr.hasNext()){
            NameEmail c = (NameEmail) itr.next();
            try {
                
                ita[i] = new InternetAddress(c.getEmail());
                i++;
                
            } catch (Exception e) {
                LOG.error("Got exception while adding email to internet address "+e);
            }
        }
        String rc=rco;
        
        String message = getMessage(name,rc,city);
        try {
            sm.send(null, inviteSubject, message, name, ita);
            
        } catch (MessagingException e) {
            LOG.error("Not able to send invite mail to "+ita+" exception is "+e);
        }

    }

    private void init() {
        Properties p = new Properties();
        p.setProperty("resource.loader", "class");
        p.setProperty("class.resource.loader.class", "org.apache.velocity.runtime.resource.loader.ClasspathResourceLoader");
        //p.setProperty( "file.resource.loader.path", "/tmp" );
        try {
            Velocity.init(p);
        } catch (Exception ex) {
            LOG.error(" Got exception while initilizing velocity " + ex);
        }
    }

    public String getMessage(String name,String iid,String city) {
        StringWriter writer = new StringWriter();
        try {
            Template t = Velocity.getTemplate("InviteEmailTemplate.vm");
            VelocityContext context = new VelocityContext();
            context.put("name", name);
            context.put("inviteId",iid);
            context.put("city", city);
            /* now render the template into a StringWriter */
            t.merge(context, writer);
            /* show the World */
            //System.out.println(writer.toString());
        } catch (Exception ex) {
            LOG.error(" Exception is " + ex);
        }
        return writer.toString();

    }
}
