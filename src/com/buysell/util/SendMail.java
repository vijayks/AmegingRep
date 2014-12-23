/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.buysell.util;

import java.util.Date;
import java.util.Properties;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import org.apache.log4j.Logger;

/**
 *
 * @author bbsadmin
 */
public class SendMail {

    public static Session session = null;
    private static Logger LOG = Logger.getLogger(SendMail.class);
    String from = BuySellProperties.getProperty("mail.from");

    public void init() {
        if (session == null) {
            LOG.info("Strting initilizing SendMail service .....");
            String host = BuySellProperties.getProperty("mail.server.host");
            // Create properties, get Session
            Properties props = new Properties();
            // If using static Transport.send(),
            // need to specify which host to send it to
            props.put("mail.smtp.host", host);
            // To see what is going on behind the scene
            props.put("mail.debug", "true");
            props.put("mail.smtp.auth", "true");
            LOG.info(" SendMail properties are \n Host: " + host + "\n User :" + BuySellProperties.getProperty("mail.server.username") + "\n Password : " + BuySellProperties.getProperty("mail.server.user.password"));
            Authenticator aut = new SMTPAuthenticator();
            session = Session.getDefaultInstance(props, aut);
        }
    }

    public boolean send(String to, String subjuct, String message) throws MessagingException {
        return send(to, subjuct, message, null,null);
    }

     public boolean send(String to, String subjuct, String message, String name,InternetAddress[] ita) throws MessagingException {

         
        try {
            Message msg = new MimeMessage(session);
            msg.setFrom(new InternetAddress(from));
            if (ita == null) {
                InternetAddress[] address = {new InternetAddress(to)};
                msg.setRecipients(Message.RecipientType.TO, address);
            }else{
                 msg.setRecipients(Message.RecipientType.BCC, ita);
            }
            msg.setSubject(subjuct);
            msg.setSentDate(new Date());
            msg.setText(message);
            msg.setContent(message, "text/html");
            Transport.send(msg);
            LOG.info("Mail sent successfully to " + to + " from: " + from + " Subject : " + subjuct + " Body " + message);
        } catch (MessagingException mex) {
            LOG.error(" Not able to send Mail to " + to + " from: " + from + " Subject : " + subjuct + " Body " + message);
            LOG.error("Exception is " + mex);
            return false;
        }
        return true;
    }

    private class SMTPAuthenticator extends Authenticator {

        public PasswordAuthentication getPasswordAuthentication() {
            String username = BuySellProperties.getProperty("mail.server.username");
            String password = BuySellProperties.getProperty("mail.server.user.password");
            return new PasswordAuthentication(username, password);
        }
    }

    public SendMail() {
        init();
    }
}
