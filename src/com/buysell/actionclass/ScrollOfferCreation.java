/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.buysell.actionclass;

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */



import com.buysell.beans.ScrollOffersFormBean;
import com.buysell.beans.UserBean;
import com.buysell.db.DbConnection;
import com.buysell.db.DbConnectionPool;
import com.buysell.servlets.AdsService;
import com.buysell.servlets.DealerService;
import com.buysell.util.CategoryUtil;
import com.buysell.util.City;
import com.buysell.util.CityUtil;
import java.io.File;
import java.io.FileOutputStream;
import java.sql.Connection;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.ActionForward;
import org.apache.struts.upload.FormFile;
import com.buysell.util.ImagePathUtil;

/**
 *
 * @author bbsadmin
 */
public class ScrollOfferCreation extends org.apache.struts.action.Action {

    /* forward name="success" path="" */
    private final static String SUCCESS = "success";
    private final static String ERROR = "error";
    private static Logger LOG = Logger.getLogger(ScrollOfferCreation.class);
    DbConnection db = new DbConnection();
    CityUtil cityUtil = new CityUtil();
    ImagePathUtil ipu1 = new ImagePathUtil("/Buy-Sell");
    ImagePathUtil ipu2 = new ImagePathUtil("/Buy-Sell");
    ImagePathUtil ipu3 = new ImagePathUtil("/Buy-Sell");
    ImagePathUtil ipu4 = new ImagePathUtil("/Buy-Sell");
    ImagePathUtil ipu5 = new ImagePathUtil("/Buy-Sell");
    ImagePathUtil ipu6 = new ImagePathUtil("/Buy-Sell");
    ImagePathUtil ipu7 = new ImagePathUtil("/Buy-Sell");
    ImagePathUtil ipu8 = new ImagePathUtil("/Buy-Sell");
    ImagePathUtil ipu9 = new ImagePathUtil("/Buy-Sell");
    ImagePathUtil iputh = new ImagePathUtil("/Buy-Sell");

    @Override
    public ActionForward execute(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {


        ScrollOffersFormBean sofb = (ScrollOffersFormBean) form;
        UserBean ub = (UserBean) request.getSession().getAttribute("userBean");
        DealerService ds = new DealerService();
        int dealerId = ds.getDealerId(ub.getUserId());
        String from = request.getParameter("from");
        LOG.info("Getting 'from' Value::" + from);
        if (from != null && from.equals("createOfferPage")) {
            request.setAttribute("categoryList", CategoryUtil.getCategories());
            request.setAttribute("cities", cityUtil.viewAllCities());

            return mapping.findForward(SUCCESS);
        } else {

            FormFile f1 = sofb.getImg1();
            FormFile f2 = sofb.getImg2();
            FormFile f3 = sofb.getImg3();
            FormFile f4 = sofb.getImg4();
            FormFile f5 = sofb.getImg5();
            FormFile f6 = sofb.getImg6();
            FormFile f7 = sofb.getImg7();
            FormFile f8 = sofb.getImg8();
            FormFile f9 = sofb.getImg9();
            FormFile thImg = sofb.getThumbImg();

            String img1 = null;
            String img2 = null;
            String img3 = null;
            String img4 = null;
            String img5 = null;
            String img6 = null;
            String img7 = null;
            String img8 = null;
            String img9 = null;
            String tImg = null;



            if (thImg != null && thImg.getFileName().length() > 0) {
                byte[] th = thImg.getFileData();
                tImg = iputh.saveImage(th, "offer", thImg.getFileName());
            }
            if (f1 != null && f1.getFileName().length() > 0) {
                byte[] b1 = f1.getFileData();
                img1 = ipu1.saveImage(b1, "offer", f1.getFileName());

            }
            if (f2 != null && f2.getFileName().length() > 0) {
                byte[] b2 = f2.getFileData();
                img2 = ipu2.saveImage(b2, "offer", f2.getFileName());

            }
            if (f3 != null && f3.getFileName().length() > 0) {
                byte[] b3 = f3.getFileData();
                img3 = ipu3.saveImage(b3, "offer", f3.getFileName());

            }
            if (f4 != null && f4.getFileName().length() > 0) {
                byte[] b4 = f4.getFileData();
                img4 = ipu4.saveImage(b4, "offer", f4.getFileName());

            }
            if (f5 != null && f5.getFileName().length() > 0) {
                byte[] b5 = f5.getFileData();
                img5 = ipu5.saveImage(b5, "offer", f5.getFileName());

            }
            if (f6 != null && f6.getFileName().length() > 0) {
                byte[] b6 = f6.getFileData();
                img6 = ipu6.saveImage(b6, "offer", f6.getFileName());

            }
            if (f7 != null && f7.getFileName().length() > 0) {
                byte[] b7 = f7.getFileData();
                img7 = ipu7.saveImage(b7, "offer", f7.getFileName());

            }
            if (f8 != null && f8.getFileName().length() > 0) {
                byte[] b8 = f8.getFileData();
                img8 = ipu8.saveImage(b8, "offer", f8.getFileName());

            }
            if (f9 != null && f9.getFileName().length() > 0) {
                byte[] b9 = f9.getFileData();
                img9 = ipu9.saveImage(b9, "offer", f9.getFileName());

            }





            /*
            DESC SCROLL_ADS_T;
            +---------------+---------------+------+-----+---------+----------------+
            | Field         | Type          | Null | Key | Default | Extra          |
            +---------------+---------------+------+-----+---------+----------------+
            | S_ID          | int(4)        | NO   | PRI | NULL    | auto_increment |
            | SCR_TITLE     | varchar(250)  | YES  |     | NULL    |                |
            | IMG1          | varchar(50)   | YES  |     | NULL    |                |
            | IMG2          | varchar(50)   | YES  |     | NULL    |                |
            | IMG3          | varchar(50)   | YES  |     | NULL    |                |
            | DESCRIPTION   | varchar(1000) | YES  |     | NULL    |                |
            | DEALER_ID     | int(11)       | YES  |     | NULL    |                |
            | STATUS        | int(11)       | YES  |     | NULL    |                |
            | S_DATE        | date          | YES  |     | NULL    |                |
            | E_DATE        | date          | YES  |     | NULL    |                |
            | OFFER_CITY    | varchar(20)   | YES  |     | NULL    |                |
            | LIST_PRICE    | varchar(20)   | YES  |     | NULL    |                |
            | OFFER_PRICE   | varchar(20)   | YES  |     | NULL    |                |
            | OFFER_TYPE    | varchar(10)   | YES  |     | NULL    |                |
            | CATEGORY_ID   | int(10)       | YES  |     | NULL    |                |
            | CREATION_DATE | date          | YES  |     | NULL    |                |
            | MODIFIED_DATE | date          | YES  |     | NULL    |                |
            | url           | varchar(200)  | YES  |     | NULL    |                |
            | IMG4          | varchar(50)   | YES  |     | NULL    |                |
            | IMG5          | varchar(50)   | YES  |     | NULL    |                |
            | IMG6          | varchar(50)   | YES  |     | NULL    |                |
            | IMG7          | varchar(50)   | YES  |     | NULL    |                |
            | IMG8          | varchar(50)   | YES  |     | NULL    |                |
            | IMG9          | varchar(50)   | YES  |     | NULL    |                |
            | THUMB_IMG     | varchar(50)   | YES  |     | NULL    |                |
            +---------------+---------------+------+-----+---------+----------------+
            25 rows in set (0.00 sec)


             */

            String st_date = sofb.getDateS();
            String en_date = sofb.getDateE();
            DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
            Calendar now = Calendar.getInstance();
            int year = now.get(Calendar.YEAR);
            int month = now.get(Calendar.MONTH);
            int day = now.get(Calendar.DATE);
            now.set(year, month, day);
            Date s_dateObj = null;
            Date e_dateObj = null;
            try {
                if (st_date != null) {
                    s_dateObj = df.parse(st_date);
                } else {
                    s_dateObj = now.getTime();

                    LOG.info("Starting Date:: " + s_dateObj);
                }
                if (en_date != null) {
                    e_dateObj = df.parse(en_date);
                } else {
                    e_dateObj = now.getTime();
                }

            } catch (ParseException e) {
                LOG.error("Error in conversion of string to date ::" + e);
            }


            try {
                db.executeQuery("INSERT INTO SCROLL_ADS_T (SCR_TITLE,IMG1,IMG2,IMG3,IMG4,IMG5,IMG6,IMG7,IMG8,IMG9,THUMB_IMG,DESCRIPTION,DEALER_ID,STATUS,S_DATE,E_DATE,OFFER_CITY,LIST_PRICE,OFFER_PRICE,CATEGORY_ID,OFFER_TYPE,URL,CREATION_DATE) " +
                        "VALUES " +
                        "('" + sofb.getTitle() + "','" + img1 + "','" + img2 + "','" + img3 + "','"+img4+"','"+img5+"','"+img6+"','"+img7+"','"+img8+"','"+img9+"','"+tImg+"','" + sofb.getDescription() + "'," + dealerId + "," + 2 + ",'" +
                        df.format(s_dateObj) + "','" + df.format(e_dateObj) + "','" + sofb.getOffCity() + "','" + sofb.getLprice() + "','" + sofb.getOprice() + "','" + sofb.getCategory() + "','" + sofb.getOffType() + "','" + sofb.getUrl() + "', now() );");
                request.setAttribute("scok", "Offer successfully created.");
            } catch (Exception e) {
                LOG.debug("Error occured ::" + e);
            } finally {
            }
            request.setAttribute("categoryList", CategoryUtil.getCategories());
            request.setAttribute("cities", cityUtil.viewAllCities());
            return mapping.findForward(SUCCESS);
        }




    }
}
