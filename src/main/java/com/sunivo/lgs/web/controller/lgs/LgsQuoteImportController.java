/**
 * Description: 海运整箱海运费、本地费、附加费excel导入控制器
 * Copyright:   Copyright (c)2013
 * Company:     SUNIVO
 * @author: 	caoyongxiang
 * @version: 	1.0
 * Create at:   2013-11-13 
 *
 * Modification History:
 * Date         Author      Version     Description
 * ------------------------------------------------------------------
 * 2013-11-13   caoyongxiang   1.0         add
 */
package com.sunivo.lgs.web.controller.lgs;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.sunivo.lgs.beans.entity.LgsAddationQuote4ExcelInfoEntity;
import com.sunivo.lgs.beans.entity.LgsFclQuote4ExcelInfoEntity;
import com.sunivo.lgs.beans.entity.LgsPortQuote4ExcelInfoEntity;
import com.sunivo.lgs.web.base.controller.BaseController;
import com.sunivo.ws.interfaces.server.crm.ICustomer;
import com.sunivo.ws.interfaces.server.lgs.ILgsQuoteImportServiceWS;
import com.sunivo.ws.interfaces.server.uim.IPortcodeServiceWS;
import com.sunivo.ws.interfaces.server.uim.IPrdQuoteServiceWS;
import com.sunivo.ws.interfaces.server.uim.IShippingline;

@Controller
@RequestMapping("/lgsquoteimport")
public class LgsQuoteImportController extends BaseController {

    /**
     * 记录日志
     */
    private static final Logger LOGGER = Logger
            .getLogger(LgsQuoteImportController.class);

    /**
     * 报价导入WS服务接口
     */
    @Autowired
    private ILgsQuoteImportServiceWS lgsQuoteImportServiceWS;
    /**
     * 海运整箱海运费WS服务接口
     */
    /**
     * 客户WS服务接口
     */
    @Autowired
    private ICustomer customerWS;
    /**
     * 港口WS服务接口
     */
    @Autowired
    private IPortcodeServiceWS portcodeServiceWS;
    /**
     * 产品报价WS服务接口
     */
    @Autowired
    private IPrdQuoteServiceWS prdQuoteServiceWS;
    /**
     * 航线WS服务接口
     */
    @Autowired
    private IShippingline shippinglineServiceWS;
    /**
     * 报价导入服务
     */
    @Autowired
    private LgsQuoteServiceController quoteServiceController;

    /**
     * 第一步：上传文件进入
     * 
     * @param request
     * @param response
     */
    @ResponseBody
    @RequestMapping(value = "fclSurchargeUploadDealSection/{quote_type}", method = {
            RequestMethod.POST, RequestMethod.GET })
    public String fclSurchargeUploadDealSection(
            @PathVariable("quote_type") Integer quote_type,
            MultipartHttpServletRequest request, HttpServletResponse response,
            Model model) {

        LOGGER.debug("=======fclSurchargeUploadDealSection==================");

        response.setContentType("text/html;charset=UTF-8");
        String jsonResult = null;
        // 用于存放解析后的信息，key为行号，value为存放key为标题，value为所填值
        Map<Integer, Map<String, String>> dataMap = new HashMap<Integer, Map<String, String>>();
        // 用于存放头信息，key为列号，value为标题
        Map<Integer, String> headMap = new HashMap<Integer, String>();
        // 用于存放失败的文件级错误数据
        Map<Integer, String> sysErrorMap = new HashMap<Integer, String>();
        // 获取文件后缀名
        String fileType = "";
        if (null == request.getFile("file")
                || request.getFile("file").getSize() <= 0) {
            sysErrorMap.put(0, "文件为空");
        } else {
            MultipartFile file = request.getFile("file");
            // 获取文件后缀名
            fileType = file.getOriginalFilename().substring(
                    file.getOriginalFilename().lastIndexOf(".") + 1);

            if (!"xls".equals(fileType) && !"xlsx".equals(fileType)) {
                sysErrorMap.put(0, "文件类型错误");
            }
            if (sysErrorMap.isEmpty()) {
                InputStream is = null;
                try {
                    is = file.getInputStream();

                    // 将excel内容存储在dataMap中
                    quoteServiceController.dealExcel(quote_type, is, dataMap,
                            headMap, sysErrorMap, fileType);
                    // 如果无可用数据，直接退出处理
                    if (dataMap.isEmpty()) {
                        sysErrorMap.put(0, "上传文件中不包含可用数据");
                    }
                } catch (Exception e) {
                    sysErrorMap.put(0, "系统错误");
                    e.printStackTrace();
                } finally {
                    try {
                        is.close();
                    } catch (Exception ex) {
                        sysErrorMap.put(0, "文件流关闭错误");
                        ex.printStackTrace();
                    }
                }
            }
        }

        // 文件解析正确，对解析的数据进行转换
        if (sysErrorMap.isEmpty()) {
            List<LgsFclQuote4ExcelInfoEntity> lgsFclQuote4ExcelInfoEntityList = null;
            List<LgsPortQuote4ExcelInfoEntity> lgsPortQuote4ExcelInfoEntityList = null;
            List<LgsAddationQuote4ExcelInfoEntity> lgsAddationQuote4ExcelInfoEntity = null;
            // 用于存放失败的文件级错误数据
            Map<Integer, String> uploadDataErrorMap = new HashMap<Integer, String>();// key:行号，value:错误信息
            // 将dataMap中的内容封装到是实体列表中lgsFclQuote4ExcelInfoEntityList
            if (quoteServiceController.isFclQuote(quote_type)) {
                // 海运费
                // 将dataMap中的数据存在在对应的实体集合中
                lgsFclQuote4ExcelInfoEntityList = quoteServiceController
                        .dataMapConvertToLgsFclQuote4ExcelInfo(dataMap,
                                uploadDataErrorMap);
                // 将List<LgsFclQuote4ExcelInfoEntity>内容保存到数据库
                quoteServiceController.dealUploadSurchargeData(
                        lgsFclQuote4ExcelInfoEntityList, uploadDataErrorMap);

            } else if (quoteServiceController.isPortQuote(quote_type)) {
                // 本地费
                // 将dataMap中的数据存在在对应的实体集合中
                lgsPortQuote4ExcelInfoEntityList = quoteServiceController
                        .dataMapConvertToLgsPortQuote4ExcelInfo(dataMap,
                                uploadDataErrorMap);
                // 将List<LgsPortQuote4ExcelInfoEntity>内容保存到数据库
                quoteServiceController.dealUploadSurchargeData4Port(
                        lgsPortQuote4ExcelInfoEntityList, uploadDataErrorMap);

            } else if (quoteServiceController.isAddationQuote(quote_type)) {
                // 附加费
                // 将dataMap中的数据存在在对应的实体集合中
                lgsAddationQuote4ExcelInfoEntity = quoteServiceController
                        .dataMapConvertToLgsAddationQuote4ExcelInfo(dataMap,
                                uploadDataErrorMap);
                // 将List<LgsAddationQuote4ExcelInfoEntity>内容保存到数据库
                quoteServiceController.dealUploadSurchargeData4Addation(
                        lgsAddationQuote4ExcelInfoEntity, uploadDataErrorMap);
            }
            // 如果存在：未被导入到数据库中的报价
            if (!uploadDataErrorMap.isEmpty()) {
                String excelPath = null;
                // 未被导入到数据库中的报价结果写到新的excel中
                excelPath = quoteServiceController.createResultExcel(
                        uploadDataErrorMap, fileType, request);
                jsonResult = new Gson().toJson(excelPath,
                        new TypeToken<String>() {
                        }.getType());
            }
        } else {
            String excelPath = null;
            // 未被导入到数据库中的报价结果写到新的excel中
            excelPath = quoteServiceController.createResultExcel(sysErrorMap,
                    fileType, request);
            jsonResult = new Gson().toJson(excelPath, new TypeToken<String>() {
            }.getType());
        }

        if (null == jsonResult) {
            jsonResult = new Gson().toJson("批量报价成功", new TypeToken<String>() {
            }.getType());
        }

        try {
            jsonResult = jsonResult.replaceAll("\"", "");// 文件名的双引号去掉
            response.getWriter().write(jsonResult);
        } catch (Exception e) {
            e.printStackTrace();
        }

        // return "redirect:/lgsquoteimport/quoteImportResult";
        return jsonResult;
    }

    /**
     * 下载excel文件(导入报价的结果文件，下载报价模板)
     * 
     * @param fileName
     *            待下载的excel文件名
     * @param request
     *            封装请求参数
     * @param response
     *            输出文件信息
     */
    @RequestMapping(value = "download/{fileName}", method = { RequestMethod.GET })
    public void downLoadExcel(@PathVariable("fileName") String fileName,
            HttpServletRequest request, HttpServletResponse response) {
        BufferedInputStream bufferedInputStream = null;
        BufferedOutputStream bufferedOutputStream = null;
        try {
            response.setContentType("text/html;charset=utf-8");
            request.setCharacterEncoding("UTF-8");

            String path = request.getSession().getServletContext()
                    .getRealPath("/")
                    + "WEB-INF/views/lgs/uploadsurchargefile/"
                    + fileName
                    + ".xlsx";
            File file = new File(path);
            if (!file.exists()) {
                throw new Exception("文件不存在");
            }

            long fileLength = file.length();
            response.setContentType("application/x-msdownload;");
            // response.setContentType("multipart/form-data");
            response.setHeader("Content-disposition", "attachment; filename="
                    + new String(file.getName().getBytes(), "UTF-8"));
            response.setHeader("Content-Length", String.valueOf(fileLength));

            bufferedInputStream = new BufferedInputStream(new FileInputStream(
                    file));
            bufferedOutputStream = new BufferedOutputStream(
                    response.getOutputStream());
            byte[] buff = new byte[1024];
            int bytesRead = -1;
            while (-1 != (bytesRead = bufferedInputStream.read(buff))) {
                bufferedOutputStream.write(buff, 0, bytesRead);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (null != bufferedInputStream) {
                    bufferedInputStream.close();
                }
                if (null != bufferedOutputStream) {
                    bufferedOutputStream.close();
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    /**
     * 跳转到上传附件的页面
     * 
     * @param quote_type
     * @return
     */
    @RequestMapping(value = "/surchargeUploadSection/{quote_type}", method = {
            RequestMethod.GET, RequestMethod.POST })
    public String surchargeUploadSection(
            @PathVariable("quote_type") Integer quote_type, Model model) {

        logger.debug("---------go into method: popSurchargeUploadSection-----------------");
        long beginTime = System.currentTimeMillis();

        model.addAttribute(
                "action",
                "lgsquoteimport/fclSurchargeUploadDealSection/"
                        + quote_type.intValue());

        long endTime = System.currentTimeMillis();
        logger.debug("---------leave method: popSurchargeUploadSection-----------------耗时："
                + (endTime - beginTime));

        return "lgs/lgsport/pages/surchargeUploadSection";
    }

    /**
     * 跳转到导入后的结果页面，form表单提交附件使用，暂时废弃，原因：采用ajax上传附件
     * 
     * @param request
     * @param model
     * @deprecated
     * @return
     */
    @RequestMapping(value = "/quoteImportResult", method = { RequestMethod.GET,
            RequestMethod.POST })
    public String quoteImportResult(HttpServletRequest request, Model model) {
        String fileName = request.getParameter("fileName");
        String success = request.getParameter("success");
        model.addAttribute("fileName", fileName);
        model.addAttribute("success", success);
        return getAutoUrl();
    }

}
