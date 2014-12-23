/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.buysell.webshop.actionclasses;

import com.buysell.beans.DealerBean;
import com.buysell.webshop.beans.Product;
import com.buysell.webshop.beans.ProductCreationActionForm;
import com.buysell.webshop.db.ProductDBManager;
import com.buysell.webshop.util.DealerImagePathUtil;
import java.util.ArrayList;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.upload.FormFile;

/**
 *
 * @author madhuri
 */
public class UpdateProductsAction extends Action {

    /* forward name="success" path="" */
    private static final String SUCCESS = "success";
    private static final String UPSUCCESS = "upSuccess";
    private static Logger LOG = Logger.getLogger(UpdateProductsAction.class);
    DealerImagePathUtil ipu1 = new DealerImagePathUtil("/Buy-Sell");
    ProductDBManager pdm = new ProductDBManager();

    /**
     * This is the action called from the Struts framework.
     * @param mapping The ActionMapping used to select this instance.
     * @param form The optional ActionForm bean for this request.
     * @param request The HTTP Request we are processing.
     * @param response The HTTP Response we are processing.
     * @throws java.lang.Exception
     * @return
     */
    @Override
    public ActionForward execute(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        ProductCreationActionForm pcaf = (ProductCreationActionForm) form;
        DealerBean db = (DealerBean) request.getSession().getAttribute("userBean");
        long dId = db.getDlId();
        LOG.debug("== EXECUTE() started ==");
        String prodId = request.getParameter("prodId");
        String thmPrevImg = request.getParameter("thmbPrevImg");
        String prvImg1 = request.getParameter("prevImg1");
        String prvImg2 = request.getParameter("prevImg2");
        String prvImg3 = request.getParameter("prevImg3");
        String prvImg4 = request.getParameter("prevImg4");
        String prvImg5 = request.getParameter("prevImg5");
        String prvImg6 = request.getParameter("prevImg6");
        int pId = 0;
        if (prodId != null) {
            pId = Integer.parseInt(prodId);
        }
        if (pId != '0' && request.getParameter("et") != null && request.getParameter("et").equals("et")) {

            Product p = new Product();
            p = pdm.getProductById(pId);
            request.setAttribute("prod", p);
            ArrayList al = new ArrayList();
            al = pdm.getProductsByDealerId(dId);
            request.setAttribute("prodList", al);
            return mapping.findForward(SUCCESS);
        } else if (pcaf != null && request.getParameter("up") != null && request.getParameter("up").equals("up")) {
            //  if(pcaf!=null && db!=null) {
            Product pr = new Product();
            StringBuffer sb = new StringBuffer();
            String sspcs[] = request.getParameterValues("shortspec");
            if (sspcs != null && sspcs.toString().trim().length() > 0) {
                for (int i = 0; i < sspcs.length; i++) {
                    if (sspcs[i].trim().length() > 0) {
                        sb.append(sspcs[i] + "^^");
                    }
                }
            }
            String shortSpecs = sb.toString();
            sb = new StringBuffer();
            String lspcs[] = request.getParameterValues("longspec");
            if (lspcs != null && lspcs.toString().trim().length() > 0) {
                for (int i = 0; i < lspcs.length; i++) {
                    if (lspcs[i].trim().length() > 0) {
                        sb.append(lspcs[i] + "^^");
                    }
                }
            }
            String longSpecs = sb.toString();
            sb = new StringBuffer();
            String accs[] = request.getParameterValues("acces");
            if (accs != null && accs.toString().trim().length() > 0) {
                for (int i = 0; i < accs.length; i++) {
                    if (accs[i].trim().length() > 0 && (!accs[i].equals("0"))) {
                        sb.append(accs[i] + "|");
                    }
                }
            }
            String accessories = sb.toString();
            sb = new StringBuffer();
            FormFile f1 = pcaf.getImg1();
            FormFile f2 = pcaf.getImg2();
            FormFile f3 = pcaf.getImg3();
            FormFile f4 = pcaf.getImg4();
            FormFile f5 = pcaf.getImg5();
            FormFile f6 = pcaf.getImg6();
            FormFile f7 = pcaf.getThImg();

            String img1 = null;
            String img2 = null;
            String img3 = null;
            String img4 = null;
            String img5 = null;
            String img6 = null;
            String thImg = null;

            if (f7 != null && f7.getFileName().length() > 0) {
                byte[] b7 = f7.getFileData();
                thImg = ipu1.saveImage(b7, db.getPath());
                sb.append(thImg + "|");
            } else if (thmPrevImg != null && thmPrevImg.trim().length() > 0) {
                thImg = thmPrevImg;
                sb.append(thImg + "|");
            }

            if (f1 != null && f1.getFileName().length() > 0) {
                byte[] b1 = f1.getFileData();
                img1 = ipu1.saveImage(b1, db.getPath());
                sb.append(img1 + "|");
            } else if (prvImg1 != null && prvImg1.trim().length() > 0) {
                img1 = prvImg1;
                sb.append(img1 + "|");
            }

            if (f2 != null && f2.getFileName().length() > 0) {
                byte[] b2 = f2.getFileData();
                img2 = ipu1.saveImage(b2, db.getPath());
                sb.append(img2 + "|");
            } else if (prvImg2 != null && prvImg2.trim().length() > 0) {
                img2 = prvImg2;
                sb.append(img2 + "|");
            }

            if (f3 != null && f3.getFileName().length() > 0) {
                byte[] b3 = f3.getFileData();
                img3 = ipu1.saveImage(b3, db.getPath());
                sb.append(img3 + "|");
            } else if (prvImg3 != null && prvImg3.trim().length() > 0) {
                img3 = prvImg3;
                sb.append(img3 + "|");
            }

            if (f4 != null && f4.getFileName().length() > 0) {
                byte[] b4 = f4.getFileData();
                img4 = ipu1.saveImage(b4, db.getPath());
                sb.append(img4 + "|");
            } else if (prvImg4 != null && prvImg4.trim().length() > 0) {
                img4 = prvImg4;
                sb.append(img4 + "|");
            }

            if (f5 != null && f5.getFileName().length() > 0) {
                byte[] b5 = f5.getFileData();
                img5 = ipu1.saveImage(b5, db.getPath());
                sb.append(img5 + "|");
            } else if (prvImg5 != null && prvImg5.trim().length() > 0) {
                img5 = prvImg5;
                sb.append(img5 + "|");
            }

            if (f6 != null && f6.getFileName().length() > 0) {
                byte[] b6 = f6.getFileData();
                img6 = ipu1.saveImage(b6, db.getPath());
                sb.append(img6 + "|");
            } else if (prvImg6 != null && prvImg6.trim().length() > 0) {
                img6 = prvImg6;
                sb.append(img6 + "|");
            }

            String imgLocs = sb.toString();
            pr.setName(pcaf.getName());
            pr.setShortDesc(pcaf.getShortDesc());
            pr.setDescription(pcaf.getDescription());
            pr.setModelId(pcaf.getModelId());
            pr.setShortSpecifics(shortSpecs);
            pr.setActualPrice(pcaf.getActualPrice());
            pr.setDiscount(pcaf.getDiscount());
            pr.setOfferPrice(pcaf.getOfferPrice());
            pr.setCurrency(pcaf.getCurrency());
            pr.setOfferTill(pcaf.getOfferTill());
            pr.setStockStatus(pcaf.getStockStatus());
            pr.setImageLocation(imgLocs);
            pr.setLongSpecifics(longSpecs);
            pr.setAccessories(accessories);
            pr.setDealerId(db.getDlId());
            pr.setTitle(pcaf.getTitle());
            pr.setProdId(pId);
            int rs = 0;
            rs = pdm.updateProduct(pr);
            if (rs == 0) {
                request.setAttribute("failMsg", "Error while Updating product");
            } else {
                request.setAttribute("sucMsg", "Product " + pcaf.getName() + " updated Successfully");
            }
            return mapping.findForward(UPSUCCESS);
        } else if (pId != '0' && request.getParameter("del") != null && request.getParameter("del").equals("del")) {
            int res = pdm.deleteProduct(pId, dId);
            if (res == 0) {
                request.setAttribute("fail", "Unsuccessful Deletion operation!");
            } else if (res != 0) {
                request.setAttribute("ok", "Deleted Successfully");
            }
        }
        return mapping.findForward(UPSUCCESS);
    }
}
