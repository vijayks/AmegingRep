/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.buysell.util;

//import com.sun.image.codec.jpeg.ImageFormatException;
//import com.sun.image.codec.jpeg.JPEGCodec;
//import com.sun.image.codec.jpeg.JPEGImageEncoder;
import java.awt.AlphaComposite;
import java.awt.BasicStroke;
import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics2D;
import java.awt.geom.AffineTransform;
import java.awt.geom.Arc2D;
import java.awt.geom.Rectangle2D;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Random;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.HttpSession;
import javax.xml.ws.Response;
import org.omg.PortableServer.REQUEST_PROCESSING_POLICY_ID;

/**
 *
 * @author smamidala
 */
public class ImageGenerator {

    /**
     * @param color
     * @return
     */
   
    public static BufferedImage generateimage(String color, HttpSession session) {
        BufferedImage bi= null;
        try {
            bi = getBackground(210,60,color);//new BufferedImage(210, 60, BufferedImage.TYPE_INT_RGB);
            Graphics2D g2d = bi.createGraphics();
          // g2d.setBackground(java.awt.Color.GRAY);
           g2d.setColor(java.awt.Color.GRAY);
           // g2d.fillRect(0, 0, 210, 60);
            Font font = new Font("dialog", 2, 40);
            g2d.setFont(font);
            String str1;
            str1=generateStr();
            session.setAttribute("captStr", str1);
            AffineTransform affineTransform = new AffineTransform();
            Random r = new Random();
            for(int i=1; i<7 ; i++){
           double angle = 0;
            if (Math.random() * 2 > 1) {
                angle = Math.random() * 0.5;
            } else {
                angle = Math.random() * -0.5;
            }
           ImageGenerator.setRandomColor(g2d);
          
           affineTransform.rotate(angle,((180/6)*i)-10,50);
           g2d.setTransform(affineTransform);
            g2d.drawString(str1.substring(i-1,i), ((180/6)*i)-10,45);
           affineTransform.rotate(-angle,((180/6)*i)-(5+r.nextInt(12)),50);
           g2d.setTransform(affineTransform);
            }
           // drawImageMosaic(g2d);
           //File f = new File("s1.jpg");
            //JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(new FileOutputStream(f));
           // encoder.encode(bi);
//            } catch (ImageFormatException ex) {
        } catch (Exception ex) {
            Logger.getLogger(ImageGenerator.class.getName()).log(Level.SEVERE, null, ex);
        }
        return bi;
    }
private static final Color [] RANDOM_BG_COLORS = {Color.RED, Color.CYAN, Color.GREEN, Color.MAGENTA, Color.ORANGE, Color.PINK,Color.YELLOW};
 private static String str=new  String("123456789abcdefghijklmnpqrstuvwxyz");
 public static void setRandomColor(Graphics2D g2d) {
        int colorId = (int)(Math.random() * RANDOM_BG_COLORS.length);
        g2d.setColor(RANDOM_BG_COLORS[colorId]);
    }
 public static String generateStr(){

 	StringBuffer sb=new StringBuffer();
 	Random r = new Random();
 	int te=0;
 	for(int i=1;i<=6;i++){
 		te=r.nextInt(34);
 		sb.append(str.charAt(te));
 	}
        
        return sb.toString();
    }
/* private static void drawImageMosaic(Graphics2D g2) {
    int side = 36;
    int width = 210;
    int height = 60;
    for (int y = 0; y < height; y += side) {
      for (int x = 0; x < width; x += side) {
        float xBias = (float) x / (float) width;
        float yBias = (float) y / (float) height;
        float alpha = 1.0f - Math.abs(xBias - yBias);
        g2.setComposite(AlphaComposite.getInstance(
            AlphaComposite.SRC_OVER, alpha));
        int w = Math.min(side, width - x);
        int h = Math.min(side, height - y);
      }
    }
    g2.setComposite(AlphaComposite.getInstance(AlphaComposite.SRC_OVER));
  }*/

  public static BufferedImage getBackground(int width, int height,String color) {
        BufferedImage result = new BufferedImage(width, height,
                BufferedImage.TYPE_INT_RGB);
        Graphics2D graphics = result.createGraphics();

        BasicStroke bs = new BasicStroke(2.0f, BasicStroke.CAP_BUTT,
                BasicStroke.JOIN_MITER, 2.0f, new float[] { 2.0f, 2.0f }, 0.0f);
        graphics.setStroke(bs);
        AlphaComposite ac = AlphaComposite.getInstance(AlphaComposite.SRC_OVER,
                0.75f);
        graphics.setColor(Color.blue);
        graphics.setComposite(ac);

        graphics.translate(width * -1.0, 0.0);
        double delta = 5.0;
        double xt;
        double ts = 0.0;
        for (xt = 0.0; xt < (2.0 * width); xt += delta) {
            Arc2D arc = new Arc2D.Double(0, 0, width, height, 0.0, 360.0,
                    Arc2D.OPEN);
            graphics.draw(arc);
            graphics.translate(delta, 0.0);
            ts += delta;
        }
        graphics.dispose();
        return result;
    }

  public static BufferedImage get1Background(int width, int height) {
        BufferedImage img = new BufferedImage(width, height,
                BufferedImage.TYPE_INT_RGB);

        Graphics2D graphics = img.createGraphics();
        graphics.setPaint(java.awt.Color.blue);
        graphics.fill(new Rectangle2D.Double(0, 0, width, height));
        graphics.drawImage(img, 0, 0, null);
        graphics.dispose();

        return img;
    }
}
