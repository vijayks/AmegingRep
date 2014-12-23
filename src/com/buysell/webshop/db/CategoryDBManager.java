/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.buysell.webshop.db;

import com.buysell.db.DbConnectionPool;
import com.buysell.webshop.beans.wsCategory;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Types;
import java.util.ArrayList;
import org.apache.log4j.Logger;

/**
 *
 * @author Madhuri
 */
public class CategoryDBManager {

    private static Logger LOG = Logger.getLogger(CategoryDBManager.class);
    Connection con = null;
    String updCatQry = "UPDATE WEBSHOP_CATEGORY_T SET NAME=?,CATEGORY_IMG_PATH=?,PARENT_CATEGORY_ID=?,LAST_MODIFICATION_DATE=NOW() WHERE DEALER_ID=? AND CATEGORY_ID=?";
    String delCatQry = "DELETE FROM WEBSHOP_CATEGORY_T WHERE (PARENT_CATEGORY_ID=? OR CATEGORY_ID=?) AND DEALER_ID=?";

    public ArrayList getCategoriesByDid(long dealerId) {
        ArrayList al = null;
        String query;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            query = "SELECT NAME,CATEGORY_IMG_PATH,SHORT_DESCRIPTION,CATEGORY_ID,PARENT_CATEGORY_ID from WEBSHOP_CATEGORY_T WHERE DEALER_ID='" + dealerId + "'";
            con = DbConnectionPool.getConnection();
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();

            if (rs != null && rs.next()) {
                al = new ArrayList();
                do {
                    wsCategory wsc = new wsCategory();
                    wsc.setName(rs.getString(1));
                    wsc.setcImg(rs.getString(2));
                    wsc.setShrtDesc(rs.getString(3));
                    wsc.setCatId(rs.getLong(4));
                    wsc.setParentId(rs.getLong(5));
                    al.add(wsc);
                } while (rs != null && rs.next());
            }
        } catch (Exception e) {
            LOG.debug("Error:::" + e);
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (Exception e) {
                    LOG.error("Exception occurred while closing ResultSet in getCategoriesByDId :: " + e);
                }
            }
            if (ps != null) {
                try {
                    ps.close();
                } catch (Exception e) {
                    LOG.error("Exception occurred while closing Prepared Statement in getCategoriesByDId  :: " + e);
                }
            }
            if (con != null) {
                DbConnectionPool.closeConnection(con);
            }
        }
        return al;
    }

//    public wsCategory getCategoryByCatId(int cId) {
//        String query1 = null;
//        PreparedStatement ps = null;
//        ResultSet rs = null;
//        wsCategory wsc = new wsCategory();
//        try {
//            query1 = "SELECT NAME,CATEGORY_IMG_PATH,SHORT_DESCRIPTION,CATEGORY_ID,PARENT_CATEGORY_ID from WEBSHOP_CATEGORY_T WHERE STATUS=1 AND CATEGORY_ID='" + cId + "'";
//            con = DbConnectionPool.getConnection();
//            ps = con.prepareStatement(query1);
//            rs = ps.executeQuery();
//
//            if (rs != null && rs.next()) {
//                wsc.setName(rs.getString(1));
//                wsc.setcImg(rs.getString(2));
//                wsc.setShrtDesc(rs.getString(3));
//                wsc.setCatId(rs.getLong(4));
//                wsc.setParentId(rs.getLong(5));
//            }
//
//        } catch (Exception e) {
//            LOG.error("Error occurred while executing query" + e);
//        } finally {
//            try {
//                if (rs != null) {
//                    rs.close();
//                }
//            } catch (Exception e) {
//                LOG.error("Error occurred while closing ResultSet  in getCategoryByCatId " + e);
//            }
//            try {
//                if (ps != null) {
//                    ps.close();
//                }
//            } catch (Exception e) {
//                LOG.error("Error occurred while closing Prepared Statement in getCategoryByCatId " + e);
//            }
//            if (con != null) {
//                DbConnectionPool.closeConnection(con);
//            }
//        }
//        return wsc;
//    }
    public int createWSCategory(String name, String catImg, String shrtDesc, long parentId, long dealerId) {
        con = DbConnectionPool.getConnection();
        int catId = 0;
        try {
            CallableStatement pos = con.prepareCall("{call CreateWebshopCategory(?,?,?,?,?,?)}");
            pos.setString(1, name);
            pos.setString(2, catImg);
            pos.setString(3, shrtDesc);
            pos.setLong(4, dealerId);
            pos.setLong(5, parentId);
            pos.registerOutParameter(6, Types.INTEGER);
            pos.execute();
            catId = pos.getInt(6);
        } catch (Exception e) {
            LOG.error("Error occurred while executing CreateWebshopCategory procedure ::" + e);
        } finally {
            if (con != null) {
                DbConnectionPool.closeConnection(con);
            }
        }
        return catId;
    }

    public ArrayList getSubCategoryByCatId(int catId) {
        ArrayList al = null;
        String query = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            query = "SELECT NAME,PARENT_CATEGORY_ID,CATEGORY_ID FROM WEBSHOP_CATEGORY_T WHERE PARENT_CATEGORY_ID='" + catId + "' AND STATUS='1'";
            con = DbConnectionPool.getConnection();
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            if (rs != null) {
                al = new ArrayList();
                while (rs.next()) {
                    wsCategory wsc = new wsCategory();
                    wsc.setName(rs.getString(1));
                    wsc.setParentId(rs.getLong(2));
                    wsc.setCatId(rs.getLong(3));
                    al.add(wsc);
                }
            }
        } catch (Exception e) {
            LOG.error("Exception occurred while executing query::" + e);
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
            } catch (Exception e) {
                LOG.error("Error ocurred while closing Resultset in getSubCategoriesByCatId ::" + e);
            }
            try {
                if (ps != null) {
                    ps.close();
                }
            } catch (Exception e) {
                LOG.error("Error ocurred while closing PreparedStatement in getSubCategoriesBycatId ::" + e);
            }
            if (con != null) {
                DbConnectionPool.closeConnection(con);
            }
        }
        return al;
    }

    public int updateWSCategory(String name, String image, long catId, long parentId, long dealerId) {
        int res = 0;
        PreparedStatement ps = null;
        con = DbConnectionPool.getConnection();
        try {
            ps = con.prepareStatement(updCatQry);
            ps.setString(1, name);
            ps.setString(2, image);
            ps.setLong(3, parentId);
            ps.setLong(4, dealerId);
            ps.setLong(5, catId);
            res = ps.executeUpdate();
        } catch (Exception e) {
            LOG.error("Exception occured while updating WS Category " + e);
        } finally {
            if (ps != null) {
                try {
                    ps.close();
                } catch (Exception e) {
                    LOG.error("Error while closing Prepared Statement in updateWsCategory " + e);
                }
            }
            if (con != null) {
                DbConnectionPool.closeConnection(con);
            }
        }
        return res;
    }

    public int deleteWSCategory(long catId, long dealerId) {

        int res = 0;
        PreparedStatement ps = null;
        con = DbConnectionPool.getConnection();
        try {
            ps = con.prepareStatement(delCatQry);
            ps.setLong(1, catId);
            ps.setLong(2, catId);
            ps.setLong(3, dealerId);
            res = ps.executeUpdate();
        } catch (Exception e) {
            LOG.error("Error occured while deleting WS Category " + e);
        } finally {
            if (ps != null) {
                try {
                    ps.close();
                } catch (Exception e) {
                    LOG.error("Error while closing Prepared Statement in deleteWSCategory " + e);
                }
            }
            if (con != null) {
                DbConnectionPool.closeConnection(con);
            }
        }
        return res;
    }

    public String createWebshop(long dlrId, String name, String catList, int catListsize) {
        String res = null;
        try {
            con = DbConnectionPool.getConnection();
            CallableStatement pos = con.prepareCall("{ call CreateWebshop(?,?,?,?,?)}");
            pos.setLong(1, dlrId);
            pos.setString(2, name);
            pos.setString(3, catList);
            pos.setInt(4, catListsize);
            pos.registerOutParameter(5, Types.VARCHAR);
            pos.execute();
            res = pos.getString(5);
            LOG.info("CreateWebshop stored routine returned result " + res);
        } catch (Exception e) {
            e.printStackTrace();
            LOG.error("Error occurred while calling CreateWebshop " + e);
        } finally {
            if (con != null) {
                try {
                    DbConnectionPool.closeConnection(con);
                } catch (Exception e) {
                    LOG.error("Error occurred while closing DbConnection in createWebshop method " + e);
                }
            }
        }
        return res;
    }

    public String updateWebshop(long dlrId, String name, String catList, int catListsize, long wsId) {
        String res = null;
        try {
            con = DbConnectionPool.getConnection();
            CallableStatement pos = con.prepareCall("{ call UpdateWebshop(?,?,?,?,?,?)}");
            pos.setLong(1, dlrId);
            pos.setString(2, name);
            pos.setString(3, catList);
            pos.setInt(4, catListsize);
            pos.setLong(5, wsId);
            pos.registerOutParameter(6, Types.VARCHAR);
            pos.execute();
            res = pos.getString(6);
            LOG.info("UpdateWebshop stored routine returned result " + res);
        } catch (Exception e) {
            e.printStackTrace();
            LOG.error("Error occurred while calling UpdateWebshop " + e);
        } finally {
            if (con != null) {
                try {
                    DbConnectionPool.closeConnection(con);
                } catch (Exception e) {
                    LOG.error("Error occurred while closing DbConnection in updateWebshop method " + e);
                }
            }
        }
        return res;
    }

    public ArrayList getWebshopsBydId(long dId) {
        ArrayList al = null;
        PreparedStatement ps = null;
        String query = null;
        ResultSet rs = null;

        try {
            query = "SELECT NAME,ID,STATUS from WEBSHOP_T where DEALER_ID='" + dId + "'";
            con = DbConnectionPool.getConnection();
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            if (rs != null) {
                al = new ArrayList();
                while (rs.next()) {
                    wsCategory wsc = new wsCategory();
                    wsc.setName(rs.getString(1));
                    wsc.setId(rs.getLong(2));
                    wsc.setStatus(rs.getInt(3));
                    al.add(wsc);
                }
            }
        } catch (Exception e) {
            LOG.error("Error occurred while executing query::" + e);
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
            } catch (Exception e) {
                LOG.error("Error ocurred while closing Resultset in getWebshopsBydId ::" + e);
            }
            try {
                if (ps != null) {
                    ps.close();
                }
            } catch (Exception e) {
                LOG.error("Error ocurred while closing PreparedStatement in getWebshopsBydId ::" + e);
            }
            if (con != null) {
                DbConnectionPool.closeConnection(con);
            }
        }
        return al;
    }

    public ArrayList getWebshopDetailsByWebId(long webId) {
        ArrayList al = null;
        String query = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            query = " SELECT A.ID,A.CATEGORY_ID,A.STATUS,NAME,CATEGORY_IMG_PATH,SHORT_DESCRIPTION,PARENT_CATEGORY_ID FROM WEBSHOP_DETAILS_T A,WEBSHOP_CATEGORY_T B WHERE (A.STATUS=1 OR A.STATUS=0) AND A.CATEGORY_ID=B.CATEGORY_ID AND WEBSHOP_ID='" + webId + "'";
            con = DbConnectionPool.getConnection();
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            if (rs != null) {
                al = new ArrayList();
                while (rs.next()) {
                    wsCategory wsc = new wsCategory();
                    wsc.setId(rs.getLong(1));
                    wsc.setCatId(rs.getLong(2));
                    wsc.setStatus(rs.getInt(3));
                    wsc.setName(rs.getString(4));
                    wsc.setcImg(rs.getString(5));
                    wsc.setShrtDesc(rs.getString(6));
                    wsc.setParentId(rs.getLong(7));
                    al.add(wsc);
                }
            }
        } catch (Exception e) {
            LOG.error("Error ocurred while executing query in getWebshopDetailsByWebId :: " + e);
        } finally {
            if (ps != null) {
                try {
                    ps.close();
                } catch (Exception e) {
                    LOG.error("Error ocurred while closing ps in getWebshopDetailsByWebId" + e);
                }
            }
            if (rs != null) {
                try {
                    rs.close();
                } catch (Exception e) {
                    LOG.error("Error ocurred while closing rs in getWebshopDetailsByWebId" + e);
                }
            }
            if (con != null) {
                DbConnectionPool.closeConnection(con);
            }
        }
        return al;
    }

    public String defineWebshop(long dlrId, long wsId, int wsSt, String catIdList, String catStList, int catListsize, String prdIdList, String prdStList, int prdListsize) {
        String res = null;
        try {
            con = DbConnectionPool.getConnection();
            CallableStatement pos = con.prepareCall("{ call DefineWebshop(?,?,?,?,?,?,?,?,?,?)}");
            pos.setLong(1, dlrId);
            pos.setLong(2, wsId);
            pos.setInt(3, wsSt);
            pos.setString(4, catIdList);
            pos.setString(5, catStList);
            pos.setInt(6, catListsize);
            pos.setString(7, prdIdList);
            pos.setString(8, prdStList);
            pos.setInt(9, prdListsize);
            pos.registerOutParameter(10, Types.VARCHAR);
            pos.execute();
            res = pos.getString(10);
            LOG.info("DefineWebshop stored routine returned result " + res);
        } catch (Exception e) {
            e.printStackTrace();
            LOG.error("Error occurred while calling DefineWebshop " + e);
        } finally {
            if (con != null) {
                try {
                    DbConnectionPool.closeConnection(con);
                } catch (Exception e) {
                    LOG.error("Error occurred while closing DbConnection in defineWebshop method " + e);
                }
            }
        }
        return res;
    }

    public String deleteWebshop(long dlrId, long wsId) {
        String res = null;
        try {
            con = DbConnectionPool.getConnection();
            CallableStatement pos = con.prepareCall("{ call DeleteWebshop(?,?,?)}");
            pos.setLong(1, dlrId);
            pos.setLong(2, wsId);
            pos.registerOutParameter(3, Types.VARCHAR);
            pos.execute();
            res = pos.getString(3);
            LOG.info("DeleteWebshop stored routine returned result " + res);
        } catch (Exception e) {
            e.printStackTrace();
            LOG.error("Error occurred while calling DeleteWebshop " + e);
        } finally {
            if (con != null) {
                try {
                    DbConnectionPool.closeConnection(con);
                } catch (Exception e) {
                    LOG.error("Error occurred while closing DbConnection in DeleteWebshop method " + e);
                }
            }
        }
        return res;
    }

    public long getActiveWebshopIdByDlrId(long dlrId) {
        long awsId = 0;
        PreparedStatement ps = null;
        ResultSet rs = null;
        String acWsQry = "SELECT ID FROM WEBSHOP_T WHERE STATUS=5 AND DEALER_ID=?";
        try {
            con = DbConnectionPool.getConnection();
            ps = con.prepareStatement(acWsQry);
            ps.setLong(1, dlrId);
            rs = ps.executeQuery();
            if (rs != null && rs.next()) {
                awsId = rs.getLong(1);
            }
        } catch (Exception e) {
            LOG.error("Error ocurred while executing query in getActiveWebshopIdByDlrId :: " + e);
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (Exception e) {
                    LOG.error("Error ocurred while closing ResultSet in getActiveWebshopIdByDlrId " + e);
                }
            }
            if (ps != null) {
                try {
                    ps.close();
                } catch (Exception e) {
                    LOG.error("Error ocurred while closing PreparedStatement in getActiveWebshopIdByDlrId " + e);
                }
            }
            if (con != null) {
                DbConnectionPool.closeConnection(con);
            }
        }
        return awsId;
    }

    public ArrayList getWebsiteAdImages(long dId) {
        ArrayList al = null;
        PreparedStatement ps = null;
        String query = null;
        ResultSet rs = null;
        try {
            String query1 = "SELECT IMG_1,IMG_2,IMG_3,IMG_4,IMG_5,STATUS FROM DEALER_ADS_IMAGES WHERE DEALER_ID='" + dId + "'";
            con = DbConnectionPool.getConnection();
            ps = con.prepareStatement(query1);
            rs = ps.executeQuery();
            if (rs != null&& rs.next()) {
                al = new ArrayList();
                al.add(rs.getString(1));
                al.add(rs.getString(2));
                al.add(rs.getString(3));
                al.add(rs.getString(4));
                al.add(rs.getString(5));
            }

        } catch (Exception e) {
            LOG.error("= Exception Occured while executing select query ::=" + e);
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (Exception e) {
                    LOG.error("Exception occurred while closing ResultSet :: " + e);
                }
            }
            if (ps != null) {
                try {
                    ps.close();
                } catch (Exception e) {
                    LOG.error("Exception occurred while closing Prepared Statement :: " + e);
                }
            }
            if (con != null) {
                DbConnectionPool.closeConnection(con);
            }
        }
        return al;
    }
}
