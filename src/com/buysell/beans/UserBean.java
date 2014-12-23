/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.buysell.beans;

/**
 *
 * @author root
 */

public class UserBean  implements java.io.Serializable{



    private int userId;
    private String loginName;
    private String pwd;
    private String firstName;
    private String lastName;
    private String lastVisited;
    private int savedCount;
    private String mobile;
    private String mvStatus;
    private String loginType;
    private String evStatus;
    private int userStatus;
    private String userType;
    private int userBidPoints;

    public String getUserType() {
        return userType;
    }

    public void setUserType(String userType) {
        this.userType = userType;
    }

    
    public int getUserStatus() {
        return userStatus;
    }

    public void setUserStatus(int userStatus) {
        this.userStatus = userStatus;
    }
    

    public String getEvStatus() {
        return evStatus;
    }

    public void setEvStatus(String evStatus) {
        this.evStatus = evStatus;
    }
    

    public String getLoginType() {
        return loginType;
    }

    public void setLoginType(String loginType) {
        this.loginType = loginType;
    }
    

    public String getMvStatus() {
        return mvStatus;
    }

    public void setMvStatus(String mvStatus) {
        this.mvStatus = mvStatus;
    }
    

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }


    
    public String getLastVisited() {
        return lastVisited;
    }

    public void setLastVisited(String lastVisited) {
        this.lastVisited = lastVisited;
    }

    public UserBean()
    {
    }

    public String getLoginName() {
        return loginName;
    }

    public void setLoginName(String loginName) {
        this.loginName = loginName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }
    
   
   

    public void setPwd(String pwd)
    {
        this.pwd=pwd;

    }

    public String getPwd()
    {
        return this.pwd;
    }

    public int getSavedCount() {
        return savedCount;
    }

    public void setSavedCount(int savedCount) {
        this.savedCount = savedCount;
    }

    public int getUserBidPoints() {
        return userBidPoints;
    }

    public void setUserBidPoints(int userBidPoints) {
        this.userBidPoints = userBidPoints;
    }

    





}