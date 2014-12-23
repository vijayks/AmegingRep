/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.buysell.util;

import java.awt.*;
import java.awt.geom.Rectangle2D;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import javax.imageio.ImageIO;
import javax.swing.ImageIcon;

/**
 *
 * @author bbsadmin
 */
public class ImageWatermarkingUtil {


    public static void addWaterMark(String watermark, File file, String ext, File of) {
        try {
            ImageIcon icon = new ImageIcon(file.getPath());
            BufferedImage bufferedImage = new BufferedImage(
                    icon.getIconWidth(), icon.getIconHeight(),
                    BufferedImage.TYPE_INT_RGB);
            Graphics2D g2d = (Graphics2D) bufferedImage.getGraphics();
            g2d.drawImage(icon.getImage(), 0, 0, null);
            AlphaComposite alpha = AlphaComposite.getInstance(
                    AlphaComposite.SRC_ATOP, 0.5f);   //SRC_OVER
            g2d.setComposite(alpha);
            g2d.setColor(Color.white);
            g2d.setRenderingHint(RenderingHints.KEY_TEXT_ANTIALIASING,
                    RenderingHints.VALUE_TEXT_ANTIALIAS_ON);
            int fs=icon.getIconWidth()/20;
            if(fs>54)
                fs=54;
            if(fs<8)
                fs=8;
            g2d.setFont(new Font("Arial", Font.HANGING_BASELINE, fs));
            FontMetrics fontMetrics = g2d.getFontMetrics();
            Rectangle2D rect = fontMetrics.getStringBounds(watermark, g2d);
            g2d.drawString(watermark, (icon.getIconWidth() - (int) rect.getWidth()) / 2, (icon.getIconHeight() - (int) rect.getHeight()) / 2);
//            System.out.println(icon.getIconWidth() +" , "+ rect.getWidth() +" , "+icon.getIconHeight() +" , "+ rect.getHeight());
            g2d.dispose();
            ImageIO.write(bufferedImage, ext, of);
        } catch (IOException e) {
            e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
        }
    }

}
