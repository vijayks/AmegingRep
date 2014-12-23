/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.buysell.beans;

import java.io.Serializable;

/**
 *
 * @author bbsadmin
 */
public class MyAdDetailsBean implements Serializable {

    int active;
    int onHold;
    int expired;
    int incomplete;
    int deleted;
    int balanceAds;
    int perffBal;
    int preffactive;
    int preffonHold;
    int preffexpired;
    int preffincomplete;
    int preffdeleted;

    public int getActive() {
        return active;
    }

    public int getIncomplete() {
        return incomplete;
    }

    public void setIncomplete(int incomplete) {
        this.incomplete = incomplete;
    }

    public void setActive(int active) {
        this.active = active;
    }

    public int getBalanceAds() {
        return balanceAds;
    }

    public void setBalanceAds(int balanceAds) {
        this.balanceAds = balanceAds;
    }

    public int getDeleted() {
        return deleted;
    }

    public void setDeleted(int deleted) {
        this.deleted = deleted;
    }

    public int getExpired() {
        return expired;
    }

    public void setExpired(int expired) {
        this.expired = expired;
    }

    public int getOnHold() {
        return onHold;
    }

    public void setOnHold(int onHold) {
        this.onHold = onHold;
    }

    public int getPreffBal() {
        return perffBal;
    }                                                             //Karteek

    public void setPreffBal(int perffBal) {
        this.perffBal = perffBal;
    }

    public int getPreffActive() {
        return preffactive;
    }

    public void setPreffActive(int preffactive) {
        this.preffactive = preffactive;
    }


    public int getPreffIncomplete() {
        return preffincomplete;
    }                                                                 //Karteek

    public void setPreffIncomplete(int preffincomplete) {
        this.preffincomplete = preffincomplete;
    }

       public int getPreffDeleted() {
        return preffdeleted;
    }

    public void setPreffDeleted(int preffdeleted) {
        this.preffdeleted = preffdeleted;
    }

    public int getPreffExpired() {
        return preffexpired;
    }                                                                  //Karteek

    public void setPreffExpired(int preffexpired) {
        this.preffexpired = preffexpired;
    }

    public int getPreffOnHold() {
        return preffonHold;
    }

    public void setPreffOnHold(int preffonHold) {
        this.preffonHold = preffonHold;
    }
}