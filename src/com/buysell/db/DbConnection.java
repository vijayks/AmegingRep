/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.buysell.db;

import com.buysell.beans.UserBean;
import java.sql.*;

import javax.servlet.http.HttpServletRequest;
import org.apache.log4j.Logger;

/**
 *
 * @author root
 */
public class DbConnection {

    //static Connection con;
    private static Logger LOG = Logger.getLogger(DbConnection.class);

    public DbConnection() {
        /*try {

        if (con == null) {
        Class.forName("com.mysql.jdbc.Driver");
        String conName=BuySellProperties.getProperty("dbAddress");

        if(conName != null)
        {
        con = (Connection) DriverManager.getConnection(conName);
        st = con.createStatement();
        }
        else
        {
        LOG.info("====Error in database path address please check====");
        }
        }

        } catch (Exception e) {
        System.out.println("Unable to create Connection" + e + "\n");
        }*/
    }

    //this method is used to call the stored procedure 'PostAd' for Posting Ad
    public int callPostAd(int userId, String adTitle, String description, int catId, String additionalContent, String image1, String image2, String image3, String country, String state, String city, String area, String locality, String address, String condition, String color, float price, float max, float mini, String neg, String cfp, String brand, String material, String yearsOld, String ownership, String specialOffer, String sOFrom, String sOTo, String type, String name, String measurement, int weight, int height, String note, String model, String regNo, String insurance, int kmRun, String pet, String breed, String objects, String collectables, String qualification, String skillSet, String industary, String prefLocation, float currentSalary, float expectedSalary, int noticePeriod, String author, String language, String publication, String qualityDiamond, int rentMonth, int noBedRooms, int floorNum, int totalFloors, String facing, String furnished, String facilities, String adType, int status, String postedBy, String tags, int sponsType, String videoUrl) {
        Connection con = DbConnectionPool.getConnection();

        int adId = 0;
        try {
            LOG.info("callable post Ad statement started");
            CallableStatement pos = con.prepareCall("{ call PostAd(?,?,?,?,?,?,?,?,?,?," +
                    "?,?,?,?,?,?,?,?,?,?," +
                    "?,?,?,?,?,?,?,?,?,?," +
                    "?,?,?,?,?,?,?,?,?,?," +
                    "?,?,?,?,?,?,?,?,?,?," +
                    "?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
            LOG.info("after post Ad callable statement");
            pos.setInt(1, userId);
            pos.setString(2, adTitle);
            pos.setString(3, description);
            pos.setInt(4, catId);
            pos.setString(5, additionalContent);
            pos.setString(6, image1);
            pos.setString(7, image2);
            pos.setString(8, image3);
            pos.setString(9, country);
            pos.setString(10, state);
            pos.setString(11, city);
            pos.setString(12, area);
            pos.setString(13, locality);
            pos.setString(14, address);
            pos.setString(15, condition);
            pos.setString(16, color);
            pos.setFloat(17, price);
            pos.setFloat(18, max);
            pos.setFloat(19, mini);
            pos.setString(20, neg);
            pos.setString(21, cfp);
            pos.setString(22, brand);
            pos.setString(23, material);
            pos.setString(24, yearsOld);
            pos.setString(25, ownership);
            pos.setString(26, specialOffer);
            pos.setString(27, sOFrom);
            pos.setString(28, sOTo);
            pos.setString(29, type);
            pos.setString(30, name);
            pos.setString(31, measurement);
            pos.setInt(32, weight);
            pos.setInt(33, height);
            pos.setString(34, note);
            pos.setString(35, model);
            pos.setString(36, regNo);
            pos.setString(37, insurance);
            pos.setInt(38, kmRun);
            pos.setString(39, pet);
            pos.setString(40, breed);
            pos.setString(41, objects);
            pos.setString(42, collectables);
            pos.setString(43, qualification);
            pos.setString(44, skillSet);
            pos.setString(45, industary);
            pos.setString(46, prefLocation);
            pos.setFloat(47, currentSalary);
            pos.setFloat(48, expectedSalary);
            pos.setInt(49, noticePeriod);
            pos.setString(50, author);
            pos.setString(51, language);
            pos.setString(52, publication);
            pos.setString(53, qualityDiamond);
            pos.setInt(54, rentMonth);
            pos.setInt(55, noBedRooms);
            pos.setInt(56, floorNum);
            pos.setInt(57, totalFloors);
            pos.setString(58, facing);
            pos.setString(59, furnished);
            pos.setString(60, facilities);
            pos.setString(61, adType);
            pos.setInt(62, status);
            pos.setString(63, postedBy);
            pos.setString(64, tags);
            pos.setInt(65, sponsType);
            pos.setString(66, videoUrl);
            pos.registerOutParameter(67, Types.INTEGER);
            LOG.info("pos  Executed Before");
            pos.execute();
            adId = pos.getInt(67);
            LOG.info("==Post ad callable statement  executed end== " + adId);

        } catch (Exception e) {
            e.printStackTrace();
            LOG.error("error occured in calPostAd in DbConnection" + e);
        } finally {
            try {
                if (con != null) {
                    DbConnectionPool.closeConnection(con);
                }
            } catch (Exception e) {
                LOG.error("error occured in calPostAd in DbConnection at closing connection." + e);
            }


        }

        return adId;
    }

    public void callRedemptionPoints(int userId, String itemSelected, int qty, int itemValue, String status, String deliverTo, HttpServletRequest request) {
        String success = null;
        Connection con = DbConnectionPool.getConnection();

        try {
            LOG.info(" RedemptionPoints() method started");
            CallableStatement cs = con.prepareCall("{ call RedemptionPoints(?,?,?,?,?,?,?)}");
            LOG.info("after RedemptionPoints() call is made");

            cs.setInt(1, userId);
            cs.setString(2, itemSelected);
            cs.setInt(3, qty);
            cs.setInt(4, (qty * itemValue));
            cs.setString(5, status);

            // cs.setDate(6, deliverOn);
            cs.setString(6, deliverTo);

            cs.registerOutParameter(7, Types.VARCHAR);
            LOG.info("Ater all values are setted");

            cs.execute();
            LOG.info("After execute() method is made");

            success = cs.getString(7);
            LOG.info("***  RedemptionPoints(...) procedure returned *** " + success);
            if (success.trim().endsWith("1")) {
                request.getSession().setAttribute("ok", " Selected item will be delivered with in 48 hours.");
            } else {
                request.getSession().setAttribute("ok", " Sorry you are unable to redemn product, pls try again !");
            }

        } catch (Exception e) {
            LOG.info("Error In RedemptionPoints Procedure operations :" + e);
        } finally {

            try {
                if (con != null) {
                    DbConnectionPool.closeConnection(con);
                }
            } catch (Exception e) {
                LOG.error("error occured in callRedemptionPoints in DbConnection at closing connection." + e);
            }

        }

    }

    public String callSaveAdPro(int adId, int userId) {
        String msg = null;
        Connection con = DbConnectionPool.getConnection();
        try {
            LOG.info("== saved ads procedure called  ==");
            CallableStatement pos = con.prepareCall("{call SaveAdPro(?,?,?)}");
            pos.setInt(1, adId);
            pos.setInt(2, userId);
            pos.registerOutParameter(3, Types.VARCHAR);
            pos.execute();
            msg = pos.getString(3);
            LOG.info("***  save ad  procedure returned result *** " + msg);

        } catch (Exception e) {
            e.printStackTrace();
            LOG.error("Error occured in updateAd() procedure = " + e);
        } finally {
            try {
                if (con != null) {
                    DbConnectionPool.closeConnection(con);
                }
            } catch (Exception e) {
                LOG.error("error occured in callSaveAdPro in DbConnection at closing connection." + e);
            }
        }

        return msg;

    }

    public String callUpdateAd(int userId, int adId, String adTitle, String description, int catId, String additionalContent, String image1, String image2, String image3, String country, String state, String city, String area, String locality, String address, String condition, String color, float price, float max, float mini, String neg, String cfp, String brand, String material, String yearsOld, String ownership, String specialOffer, String sOFrom, String sOTo, String type, String name, String measurement, int weight, int height, String note, String model, String regNo, String insurance, int kmRun, String pet, String breed, String objects, String collectables, String qualification, String skillSet, String industary, String prefLocation, float currentSalary, float expectedSalary, int noticePeriod, String author, String language, String publication, String qualityDiamond, int rentMonth, int noBedRooms, int floorNum, int totalFloors, String facing, String furnished, String facilities, String adType, int statusOld, int statusNew, String tags, String approved_by, String comments, String videoUrl) {

        String success = null;
        Connection con = DbConnectionPool.getConnection();

        try {
            LOG.info(" callUPdateAd() method started");
            CallableStatement pos = con.prepareCall("{ call UpdateAd(?,?,?,?,?,?,?,?,?,?," +
                    "?,?,?,?,?,?,?,?,?,?," +
                    "?,?,?,?,?,?,?,?,?,?," +
                    "?,?,?,?,?,?,?,?,?,?," +
                    "?,?,?,?,?,?,?,?,?,?," +
                    "?,?,?,?,?,?,?,?,?,?," +
                    "?,?,?,?,?,?,?,?,?)}");
            LOG.info("after prepareCall(...) is made");
            pos.setInt(1, adId);
            pos.setString(2, adTitle);
            pos.setString(3, description);
            pos.setInt(4, catId);
            pos.setString(5, additionalContent);
            pos.setString(6, image1);
            pos.setString(7, image2);
            pos.setString(8, image3);
            pos.setString(9, country);
            pos.setString(10, state);
            pos.setString(11, city);
            pos.setString(12, area);
            pos.setString(13, locality);
            pos.setString(14, address);
            pos.setString(15, condition);
            pos.setString(16, color);
            pos.setFloat(17, price);
            pos.setFloat(18, max);
            pos.setFloat(19, mini);
            pos.setString(20, neg);
            pos.setString(21, cfp);
            pos.setString(22, brand);
            pos.setString(23, material);
            pos.setString(24, yearsOld);
            pos.setString(25, ownership);
            pos.setString(26, specialOffer);
            pos.setString(27, sOFrom);
            pos.setString(28, sOTo);
            pos.setString(29, type);
            pos.setString(30, name);
            pos.setString(31, measurement);
            pos.setInt(32, weight);
            pos.setInt(33, height);
            pos.setString(34, note);
            pos.setString(35, model);
            pos.setString(36, regNo);
            pos.setString(37, insurance);
            pos.setInt(38, kmRun);
            pos.setString(39, pet);
            pos.setString(40, breed);
            pos.setString(41, objects);
            pos.setString(42, collectables);
            pos.setString(43, qualification);
            pos.setString(44, skillSet);
            pos.setString(45, industary);
            pos.setString(46, prefLocation);
            pos.setFloat(47, currentSalary);
            pos.setFloat(48, expectedSalary);
            pos.setInt(49, noticePeriod);
            pos.setString(50, author);
            pos.setString(51, language);
            pos.setString(52, publication);
            pos.setString(53, qualityDiamond);
            pos.setInt(54, rentMonth);
            pos.setInt(55, noBedRooms);
            pos.setInt(56, floorNum);
            pos.setInt(57, totalFloors);
            pos.setString(58, facing);
            pos.setString(59, furnished);
            pos.setString(60, facilities);
            pos.setString(61, adType);
            pos.setInt(62, statusOld);
            pos.setInt(63, statusNew);
            pos.setInt(64, userId);
            pos.setString(65, tags);
            pos.setString(66, approved_by);
            pos.setString(67, comments);
            pos.setString(68, videoUrl);
            pos.registerOutParameter(69, Types.VARCHAR);
            pos.execute();
            LOG.info("exucute() is made");
            success = pos.getString(69);
            LOG.info("***  UpdateAd(...) procedure returned *** " + success);
        } catch (Exception e) {
            e.printStackTrace();
            LOG.error("Error occured in updateAd() procedure = " + e);
        } finally {
            try {
                if (con != null) {
                    DbConnectionPool.closeConnection(con);
                }
            } catch (Exception e) {
                LOG.error("error occured in callUpdateAd in DbConnection at closing connection." + e);
            }
        }



        return success;

    }

    public void callReferalPoints(int userId, int refererId, int points, String reason) {
        Connection con = DbConnectionPool.getConnection();

        try {
            LOG.info("Refereal Points execution started");
            CallableStatement pStmt = con.prepareCall("{ call ReferalPoints(?,?,?,?,?) }");
            LOG.info("after Procedure call made");
            pStmt.setInt(1, userId);
            pStmt.setInt(2, refererId);
            pStmt.setInt(3, points);
            pStmt.setString(4, reason);

            pStmt.registerOutParameter(5, Types.VARCHAR);
            LOG.info("Values are setted");

            pStmt.execute();
            LOG.info("after Procedure executed");

            String success = pStmt.getString(5);
            LOG.info("Referal Points Entered?= " + success);


        } catch (Exception e) {
            e.printStackTrace();
            LOG.error("error occured in ReferealPoints execution=" + e);
        } finally {
            try {
                if (con != null) {
                    DbConnectionPool.closeConnection(con);
                }
            } catch (Exception e) {
                LOG.error("error occured in callReferalPoints in DbConnection at closing connection." + e);
            }
        }
    }

    // This method used to call the stored procedure 'Register' for registration
    public int callRegister(String country, String state, String city, String area, String location, String address, String pinCode, String firstName, String lastName, String mobile, java.sql.Date dob, String occupation, String gender, String userName, String password, String type, String mvCode, int status) {
        Connection con = DbConnectionPool.getConnection();

        int success = 0;
        try {
            LOG.info("callable statement started");
            CallableStatement proc = con.prepareCall("{ call Register(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?) }");
            LOG.info("after callable");
            proc.setString(1, country);
            proc.setString(2, state);
            proc.setString(3, city);
            proc.setString(4, area);
            proc.setString(5, location);
            proc.setString(6, address);
            proc.setString(7, pinCode);
            proc.setString(8, firstName);
            proc.setString(9, lastName);
            proc.setString(10, mobile);
            proc.setDate(11, dob);
            proc.setString(12, occupation);
            proc.setString(13, gender);
            proc.setString(14, userName);
            proc.setString(15, password);
            proc.setString(16, type);
            proc.setString(17, mvCode);

            proc.setInt(18, status);

            proc.registerOutParameter(19, Types.INTEGER);
            LOG.info("Proc Executed Before");
            proc.execute();
            success = proc.getInt(19);

            LOG.info("callable statement proc executed end his id: " + success);

        } catch (Exception e) {
            e.printStackTrace();
            LOG.error("error occured in callable statement" + e);
        } finally {
            try {
                if (con != null) {
                    DbConnectionPool.closeConnection(con);
                }
            } catch (Exception e) {
                LOG.error("error occured in callRegister in DbConnection at closing connection." + e);
            }
        }
        return success;
    }

    public int callLeadCheck(int dealerId, String type, int catId, int userId, String src, String contact, String city) {
        Connection con = DbConnectionPool.getConnection();
        int success = 0;
        try {
            CallableStatement pro = con.prepareCall("{ call LeadCheck(?,?,?,?,?,?,?,?) }");
            pro.setInt(1, dealerId);
            pro.setString(2, type);
            pro.setInt(3, catId);
            pro.setInt(4, userId);
            pro.setString(5, src);
            pro.setString(6, contact);
            pro.setString(7, city);
            pro.registerOutParameter(8, Types.INTEGER);
            pro.execute();
            success = pro.getInt(8);
            LOG.info("callable statement for LeadCheck executed end and output is: " + success);
        } catch (Exception e) {
            e.printStackTrace();
            LOG.error("error occured in callable statement LeadCheck" + e);
        } finally {
            try {
                if (con != null) {
                    DbConnectionPool.closeConnection(con);
                }
            } catch (Exception e) {
                LOG.error("error occured in LeadCheck in DbConnection at closing connection." + e);
            }
        }
        return success;
    }

    public int callUpdateLead(int leadId, int dealerId, int status) {
        Connection con = DbConnectionPool.getConnection();
        int success = 0;
        try {
            CallableStatement pro = con.prepareCall("{ call UpdateLead(?,?,?,?) }");
            pro.setInt(1, leadId);
            pro.setInt(2, dealerId);
            pro.setInt(3, status);
            pro.registerOutParameter(4, Types.INTEGER);
            pro.execute();
            success = pro.getInt(4);
            LOG.info("callable statement for UpdateLead executed end and output is: " + success);
        } catch (Exception e) {
            e.printStackTrace();
            LOG.error("error occured in callable statement UpdateLead" + e);
        } finally {
            try {
                if (con != null) {
                    DbConnectionPool.closeConnection(con);
                }
            } catch (Exception e) {
                LOG.error("error occured in UpdateLead in DbConnection at closing connection." + e);
            }
        }
        return success;
    }
//    public ResultSet getResultSetObjectaa(String query) {
//
//        ResultSet rs = null;
//        Connection con = DbConnectionPool.getConnection();
//        Statement st = null;
//        try {
//
//            LOG.debug("Executing statement :" + query);
//            st = con.createStatement();
//            rs = st.executeQuery(query);
//        } catch (SQLException ex) {
//            LOG.error("Unable to process the given task " + ex + "\n");
//        } finally {
//            DbConnectionPool.closeConnection(con);
//            //TODO: Here we need to think how good we can handle closing st instead of giving result set
//        }
//
//
//
//        return rs;
//
//    }

    public int executeQuery(String query) {
        int ra = 0;
        Connection con = DbConnectionPool.getConnection();
        Statement st = null;
        try {
            LOG.debug("Executing statement :" + query);
            st = con.createStatement();
            ra = st.executeUpdate(query);

        } catch (SQLException ex) {
            LOG.error("Unable to process the given task " + ex + "\n");
        } finally {
            try {
                if (st != null) {
                    st.close();
                }
                if (con != null) {
                    DbConnectionPool.closeConnection(con);
                }
            } catch (Exception e) {
                LOG.error("error occured in executeQuery in DbConnection at closing connection." + e);
            }

        }
        return ra;
    }

    public int callInsertBid(long bidId, String userName, long userId, Timestamp bidTime, float price) {
        Connection con = DbConnectionPool.getConnection();
        int rs = 0;
        try {
            CallableStatement pro = con.prepareCall("{ call InsertBid(?,?,?,?,?,?) }");
            pro.setLong(1, bidId);
            pro.setString(2, userName);
            pro.setLong(3, userId);
            pro.setTimestamp(4, bidTime);
            pro.setFloat(5, price);
            pro.registerOutParameter(6, Types.INTEGER);
            pro.execute();
            rs = pro.getInt(6);
            LOG.info("callable statement for InsertBid executed end and output is: " + rs);
        } catch (Exception e) {
            e.printStackTrace();
            LOG.error("error occured in callable statement InsertBid" + e);
        } finally {
            try {
                if (con != null) {
                    DbConnectionPool.closeConnection(con);
                }
            } catch (Exception e) {
                LOG.error("error occured in InsertBid in DbConnection at closing connection." + e);
            }
        }
        return rs;
    }

    public int[] getSponsoredAdsRange(int dateRange) {
        Connection con = DbConnectionPool.getConnection();
        int i[] = new int[3];
        try {
            CallableStatement pro = con.prepareCall("{ call SponsoredAdsRange(?,?,?,?) }");
            pro.setInt(1, dateRange);
            pro.registerOutParameter(2, Types.INTEGER);
            pro.registerOutParameter(3, Types.INTEGER);
            pro.registerOutParameter(4, Types.INTEGER);
            pro.execute();
            i[0] = pro.getInt(2);
            i[1] = pro.getInt(3);
            i[2] = pro.getInt(4);
            LOG.info("callable statement for SponsoredAdsRange executed end ");
        } catch (Exception e) {
            e.printStackTrace();
            LOG.error("error occured in callable statement SponsoredAdsRange " + e);
        } finally {
            try {
                if (con != null) {
                    DbConnectionPool.closeConnection(con);
                }
            } catch (Exception e) {
                LOG.error("error occured in SponsoredAdsRange in DbConnection at closing connection. " + e);
            }
        }
        return i;
    }

    public long callStoreUserLead(String mobile, String email, String name, String desc, String city, String catId, long userId, String dealerId) {
        Connection con = DbConnectionPool.getConnection();
        long id = 0;
        try {
            CallableStatement pro = con.prepareCall("{ call StoreUserLead(?,?,?,?,?,?,?,?,?) }");
            pro.setString(1, mobile);
            pro.setString(2, email);
            pro.setString(3, name);
            pro.setString(4, desc);
            pro.setString(5, city);
            pro.setString(6, catId);
            pro.setLong(7, userId);
            pro.setString(8, dealerId);
            pro.registerOutParameter(9, Types.INTEGER);
            pro.execute();
            id = pro.getInt(9);
            LOG.info("callable statement for StoreUserLead executed end and output is: " + id);
        } catch (Exception e) {
            e.printStackTrace();
            LOG.error("error occured in callable statement StoreUserLead" + e);
        } finally {
            try {
                if (con != null) {
                    DbConnectionPool.closeConnection(con);
                }
            } catch (Exception e) {
                LOG.error("error occured in InsertBid in DbConnection at closing connection." + e);
            }
        }
        return id;
    }

////    Karteek's Modification Strats
//  public long callDeleteSpecificAds(long userId) {
//        Connection con = DbConnectionPool.getConnection();
//        long id = 0;
//        try {
//                CallableStatement del = con.prepareCall("{ call DeleteSpecificAds(?) }");
//                del.setLong(1, userId);
////                del.setString(2, active);
//                del.execute();
//                LOG.info("callable statement for DeleteSpecificAds executed end and output is: " + id);
//        } catch (Exception e) {
//            e.printStackTrace();
//            LOG.error("error occured in callable statement DeleteSpecificAds" + e);
//        } finally {
//            try {
//                if(con!=null){
//                    DbConnectionPool.closeConnection(con);
//                }
//            } catch (Exception e) {
//                 LOG.error("error occured in DeleteSpecificAds in DbConnection at closing connection." + e);
//            }
//        }
//        return id;
//    }
////    Karteek's Modification Ends
    /* public Statement getStatementObject()
    {
    try {
    st = con.createStatement();
    } catch (SQLException ex) {

    LOG.error("Unable to create Statement Object\n");
    }
    return st;
    }

    public PreparedStatement getPreparedStatementObject(String query)
    {
    PreparedStatement ps=null;
    try {
    ps = con.prepareStatement(query);
    } catch (SQLException ex) {
    LOG.error("Unable to create PreparedStatement Object\n");
    }

    return ps;
    }

    public CallableStatement getCallableStatementObject(String query)
    {
    CallableStatement cs=null;

    try {
    cs = con.prepareCall(query);
    } catch (SQLException ex) {
    LOG.error("Unable to create CallableStatement Object\n");
    }

    return cs;



    }

     */
    public static void closeDBConnection() {
        LOG.info("Trying to close DB connection/n");
        DbConnectionPool.closeAllConnection();
    }
}
