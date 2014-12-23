/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.buysell.servlets;

import java.io.StringWriter;

import java.util.Properties;

import org.apache.log4j.Logger;
import org.apache.velocity.Template;
import org.apache.velocity.VelocityContext;
import org.apache.velocity.app.Velocity;

/**
 *
 * @author bbsadmin
 */
public class MessageTemplateServlet {

    public MessageTemplateServlet() {
        init();
    }
    private static final Logger LOG = Logger.getLogger(MessageTemplateServlet.class);

    public String getMessage() {
        StringWriter writer = new StringWriter();
        try {
            //String temp= BuySellProperties.getProperty("template");
            Template t = Velocity.getTemplate("helloworld.vm");
            VelocityContext context = new VelocityContext();
            context.put("name", "World");
            t.merge(context, writer);
        } catch (Exception ex) {
            LOG.error(" Exception is " + ex);
        }
        return writer.toString();

    }

    public String getRegistrationTemp(String name, String usName, String pwd, String link) {
        StringWriter sw = new StringWriter();
        try {
            Template t = Velocity.getTemplate("regConfirmation.vm");
            VelocityContext context = new VelocityContext();
            context.put("name", name);
            context.put("usName", usName);
            context.put("pwd", pwd);
            context.put("link", link);
            t.merge(context, sw);


        } catch (Exception ex) {
            LOG.error("Exception occured " + ex);
        }

        return sw.toString();
    }

    public String getResendEmailVerificationCode(String name, String link) {
        StringWriter sw = new StringWriter();
        try {
            Template t = Velocity.getTemplate("resendEmailCode.vm");
            VelocityContext context = new VelocityContext();
            context.put("name", name);
            context.put("link", link);
            t.merge(context, sw);
        } catch (Exception ex) {
            LOG.error("Exception occured " + ex);
        }
        return sw.toString();
    }

    public String getPasswordTemp(String name, String usName, String pwd) {
        StringWriter writer = new StringWriter();
        try {
            Template t = Velocity.getTemplate("resetPassword.vm");
            VelocityContext context = new VelocityContext();
            context.put("name", name);
            context.put("usName", usName);
            context.put("pwd", pwd);

            t.merge(context, writer);

        } catch (Exception e) {
            LOG.error("Exception occured " + e);
        }
        return writer.toString();
    }

    public String postingAdTemp(String adTitle, String fName) {
        StringWriter writer = new StringWriter();
        try {
            Template t = Velocity.getTemplate("postingAd.vm");
            VelocityContext context = new VelocityContext();
            context.put("adTitle", adTitle);
            context.put("fName", fName);

            t.merge(context, writer);

        } catch (Exception e) {
            LOG.error("Exception occured " + e);
        }
        return writer.toString();
    }

    private void init() {
        Properties p = new Properties();

        p.setProperty("resource.loader", "class");
        p.setProperty("class.resource.loader.class", "org.apache.velocity.runtime.resource.loader.ClasspathResourceLoader");
        //p.setProperty( "file.resource.loader.path", "/tmp/vm/" );
        LOG.info("+++++++++++++inside +++++++");

        try {
            Velocity.init(p);
        } catch (Exception ex) {


            LOG.error(" Got exception while initilizing velocity " + ex);
        }
    }

    public String getSmsTemplate(String name, String adTitle, String phno) {
        StringWriter writer = new StringWriter();

        try {
            Template t = Velocity.getTemplate("sms.vm");
            VelocityContext context = new VelocityContext();
            context.put("name", name);
            context.put("adtitle", adTitle);
            context.put("mbn", phno);

            t.merge(context, writer);

        } catch (Exception e) {
            LOG.error("Exception occured " + e);
        }
        return writer.toString();


    }

    public String getSmsCodeTemplate(String code)
    {
          StringWriter writer = new StringWriter();

        try {
            Template t = Velocity.getTemplate("smsCodeTemp.vm");
            VelocityContext context = new VelocityContext();
            context.put("code", code);
                       t.merge(context, writer);

        } catch (Exception e) {
            LOG.error("Exception occured " + e);
        }
        return writer.toString();


    }

    public String getEmailToFriendTemplate(String name, String fname, String title, String link) {
        StringWriter writer = new StringWriter();

        try {
            Template t = Velocity.getTemplate("sendToFriend.vm");
            VelocityContext context = new VelocityContext();
            context.put("name", name);
            context.put("title", title);
            context.put("fname", fname);
            context.put("link", link);

            t.merge(context, writer);

        } catch (Exception e) {
            LOG.error("Exception occured " + e);
        }
        return writer.toString();


    }

    public String getDealerInfoSmsTemplate(String domainName, String city, String locality, String phno) {
            StringWriter writer = new StringWriter();

            try {
                Template t = Velocity.getTemplate("smsDealerInfo.vm");
                VelocityContext context = new VelocityContext();
                context.put("companyName", domainName);
                context.put("city", city);
                context.put("locality", locality);
                context.put("mbn", phno);

                t.merge(context, writer);

            } catch (Exception e) {
                LOG.error("Exception occured " + e);
            }
            return writer.toString();
    }

    public String getDealerSmsTemplate(String name, String domainName, String phno) {
            StringWriter writer = new StringWriter();

            try {
                Template t = Velocity.getTemplate("smsToDealer.vm");
                VelocityContext context = new VelocityContext();
                context.put("name", name);
                context.put("companyName", domainName);
                context.put("mbn", phno);

                t.merge(context, writer);

            } catch (Exception e) {
                LOG.error("Exception occured " + e);
            }
            return writer.toString();
    }

    public String getEmailToFriendDealerInfoTemplate(String name, String fname, String domainName, String link) {
        StringWriter writer = new StringWriter();

        try {
            Template t = Velocity.getTemplate("sendDealerInfoToFriend.vm");
            VelocityContext context = new VelocityContext();
            context.put("name", name);
            context.put("companyName", domainName);
            context.put("fname", fname);
            context.put("link", link);

            t.merge(context, writer);

        } catch (Exception e) {
            LOG.error("Exception occured " + e);
        }
        return writer.toString();


    }

    public String getSelfAdReminderTemplate(long adId, String adTitle) {
        StringWriter writer = new StringWriter();
        try {
            Template t = Velocity.getTemplate("selfAdReminder.vm");
            VelocityContext context = new VelocityContext();
            if(adTitle!=null&&adTitle.length()>50)
                adTitle=adTitle.substring(0, 49);
            context.put("adId", adId);
            context.put("adTitle", adTitle);
            t.merge(context, writer);
        } catch (Exception e) {
            LOG.error("Exception occured " + e);
        }
        return writer.toString();
    }

    public String getAuctionAlertTemplate(String bidderName, String prodName, float oldPrice, float newPrice, String prodImg, String link) {
        StringWriter writer = new StringWriter();
        try {
            Template t = Velocity.getTemplate("auctionAlert.vm");
            VelocityContext context = new VelocityContext();
            context.put("bdName", bidderName);
            context.put("pdName", prodName);
            context.put("opr", oldPrice);
            context.put("npr", newPrice);
            context.put("prodImg", prodImg);
            context.put("link", link);
            t.merge(context, writer);
        } catch (Exception e) {
            LOG.error("Exception occured " + e);
        }
        return writer.toString();
    }

    public String getAuctionWonTemplate(String bidderName, String prodName, float bidPrice, String prodImg, String link) {
        StringWriter writer = new StringWriter();
        try {
            Template t = Velocity.getTemplate("auctionWon.vm");
            VelocityContext context = new VelocityContext();
            context.put("bdName", bidderName);
            context.put("pdName", prodName);
            context.put("bdpr", bidPrice);
            context.put("prodImg", prodImg);
            context.put("link", link);
            t.merge(context, writer);
        } catch (Exception e) {
            LOG.error("Exception occured " + e);
        }
        return writer.toString();
    }

    public String getAuctionWonSmsTemplate(String bidderName, String prodName, float bidPrice) {
        StringWriter writer = new StringWriter();
        try {
            Template t = Velocity.getTemplate("auctionWonSms.vm");
            VelocityContext context = new VelocityContext();
            context.put("bdName", bidderName);
            context.put("pdName", prodName);
            context.put("bdpr", bidPrice);
            t.merge(context, writer);
        } catch (Exception e) {
            LOG.error("Exception occured " + e);
        }
        return writer.toString();
    }

    public String getUserLeadVerCodeSmsTemplate(String code) {
        StringWriter writer = new StringWriter();
        try {
            Template t = Velocity.getTemplate("userLeadVerSms.vm");
            VelocityContext context = new VelocityContext();
            context.put("verCode", code);
            t.merge(context, writer);
        } catch (Exception e) {
            LOG.error("Exception occured " + e);
        }
        return writer.toString();
    }

}