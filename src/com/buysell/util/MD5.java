/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.buysell.util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

/**
 *
 * @author bbsadmin
 */
public class MD5 {

    private MessageDigest md = null;
    static private MD5 md5 = null;
    private static final char[] hexChars = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F'};

    private MD5() throws NoSuchAlgorithmException {
        md = MessageDigest.getInstance("MD5");
    }

    public static MD5 getInstance() throws NoSuchAlgorithmException {

        if (md5 == null) {
            md5 = new MD5();
        }
        return (md5);
    }

    public String hashData(byte[] dataToHash) {

        return hexStringFromBytes((calculateHash(dataToHash)));
    }

    private byte[] calculateHash(byte[] dataToHash) {
        md.update(dataToHash, 0, dataToHash.length);

        return (md.digest());
    }

    public String hexStringFromBytes(byte[] b) {
        String hex = "";
        int msb;
        int lsb = 0;
        int i;
        // MSB maps to idx 0
        for (i = 0; i < b.length; i++) {
            msb = ((int) b[i] & 0x000000FF) / 16;
            lsb = ((int) b[i] & 0x000000FF) % 16;
            hex = hex + hexChars[msb] + hexChars[lsb];
        }
        return (hex);
    }
}
