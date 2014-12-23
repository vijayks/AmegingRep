/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.buysell.util;

import java.util.Random;

/**
 *
 * @author bbsadmin
 */
public class Mutil {
   
    private static String ns=new String("0123456789abcdefghijklmnopqrstuvwxyz");
    private static String strData=new String("abcd efghij klmn opqrst uvwaei");
    private static String num=new String("3456789");
   
    Random r = new Random();
    StringBuffer sb=new StringBuffer();
    public String getRandomCode(int len)
    {
           
           int te=0;
           for(int i=1;i<=len;i++){
           te=r.nextInt(36);
 	    sb.append(ns.charAt(te));
            }
            String pw=sb.toString();
            return pw;
    }

   public String getStringData(int len)
   {

           int te=0;
           for(int i=1;i<=len;i++){
           te=r.nextInt(30);
 	    sb.append(strData.charAt(te));
            }
            String pw=sb.toString();
            return pw;
   }

    public int getCatIdNum(int len) {
           int te=0;
           for(int i=1;i<=len;i++){
           te=r.nextInt(7);
 	    sb.append(num.charAt(te));
            }
            String pw=sb.toString();
            int x=Integer.parseInt(pw);
            return x;
    }

  
}
