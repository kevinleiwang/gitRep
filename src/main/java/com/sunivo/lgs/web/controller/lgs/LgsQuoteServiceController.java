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
 * 2013-11-13   caoyongxiang  1.0         add
 */
package com.sunivo.lgs.web.controller.lgs;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sunivo.crm.beans.entity.CusCustomerEntity;
import com.sunivo.lgs.beans.entity.LgsAddationQuote4ExcelInfoEntity;
import com.sunivo.lgs.beans.entity.LgsAddationQuoteInfoEntity;
import com.sunivo.lgs.beans.entity.LgsFclQsurchargeEntity;
import com.sunivo.lgs.beans.entity.LgsFclQsurchargeEntity.QuoteType;
import com.sunivo.lgs.beans.entity.LgsFclQuote4ExcelInfoEntity;
import com.sunivo.lgs.beans.entity.LgsFclQuoteInfoEntity;
import com.sunivo.lgs.beans.entity.LgsPortEntity;
import com.sunivo.lgs.beans.entity.LgsPortQuote4ExcelInfoEntity;
import com.sunivo.lgs.beans.entity.LgsRouteAdditionQuoteEntity;
import com.sunivo.lgs.beans.vo.LgsAddationQuoteInfoVo;
import com.sunivo.lgs.web.base.controller.BaseController;
import com.sunivo.lgs.web.util.SunivoStringUtils;
import com.sunivo.uim.beans.entity.PrdQuoteEntity;
import com.sunivo.uim.beans.entity.ShippinglineEntity;
import com.sunivo.ws.beans.request.crm.GetCustomerByNameRequest;
import com.sunivo.ws.beans.request.crm.GetLogisticCampanyByTypeRequest;
import com.sunivo.ws.beans.request.lgs.DeleteLgsFclQsurchargeRequest;
import com.sunivo.ws.beans.request.lgs.GetLgsRouteAdditionQuoteByEntityRequest;
import com.sunivo.ws.beans.request.lgs.LgsPortRequest;
import com.sunivo.ws.beans.request.lgs.LgsQuoteRequest;
import com.sunivo.ws.beans.request.uim.GetShippinglineByNameRequest;
import com.sunivo.ws.beans.request.uim.PrdQuoteRequest;
import com.sunivo.ws.beans.response.crm.GetLogisticCampanyByTypeResponse;
import com.sunivo.ws.beans.response.lgs.GetLgsRouteAdditionQuoteByEntityResponse;
import com.sunivo.ws.beans.response.lgs.LgsPortResponse;
import com.sunivo.ws.beans.response.lgs.ListLgsAddationQuoteInfoResponse;
import com.sunivo.ws.beans.response.lgs.ListLgsFclQsurchargeResponse;
import com.sunivo.ws.beans.response.uim.GetShippinglineByNameResponse;
import com.sunivo.ws.beans.response.uim.PrdQuoteResponse;
import com.sunivo.ws.interfaces.server.crm.ICustomer;
import com.sunivo.ws.interfaces.server.lgs.ILgsAddationQuoteInfo;
import com.sunivo.ws.interfaces.server.lgs.ILgsFclQsurchargeServiceWS;
import com.sunivo.ws.interfaces.server.lgs.ILgsFclQuoteInfoServiceWS;
import com.sunivo.ws.interfaces.server.lgs.ILgsPortServiceWS;
import com.sunivo.ws.interfaces.server.lgs.ILgsQuoteImportServiceWS;
import com.sunivo.ws.interfaces.server.lgs.ILgsRouteAdditionQuote;
import com.sunivo.ws.interfaces.server.uim.IPortcodeServiceWS;
import com.sunivo.ws.interfaces.server.uim.IPrdQuoteServiceWS;
import com.sunivo.ws.interfaces.server.uim.IShippingline;
import com.sunivo.ws.util.ReflexUtil;

@Controller
@RequestMapping("/lgsquoteservice")
public class LgsQuoteServiceController extends BaseController {

    /**
     * 记录日志
     */
    private static final Logger LOGGER = Logger
            .getLogger(LgsQuoteImportController.class);
    /**
     * 本地费WS服务接口
     */
    @Autowired
    private ILgsPortServiceWS lgsPortServiceWS;
    /**
     * 报价导入服务
     */
    @Autowired
    private ILgsQuoteImportServiceWS lgsQuoteImportServiceWS;
    /**
     * 海运费WS服务接口
     */
    @Autowired
    private ILgsFclQuoteInfoServiceWS lgsFclQuoteInfoServiceWS;
    /**
     * 报价WS服务接口
     */
    @Autowired
    private ILgsFclQsurchargeServiceWS lgsFclQsurchargeServiceWS;
    /**
     * 附加费WS服务接口
     */
    @Autowired
    private ILgsAddationQuoteInfo lgsAddationQuoteInfoWS;
    /**
     * 报价加成WS服务接口
     */
    @Autowired
    private ILgsRouteAdditionQuote lgsRouteAdditionQuoteWS;
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
     * 第二步：将excel内容存储在dataMap中
     * 
     * @param quote_type
     *            类型：1、海运费，2、本地费，3、附加费
     * @param is
     *            输入流
     * @param dataMap
     *            存储excel文件内容，用于存放解析后的信息，key为行号，value为存放key为标题，value为所填值
     * @param headMap
     *            标题行内容
     * @param errorMap
     *            错误信息
     * @param fileType
     *            文件类型
     * @throws Exception
     *             文件读写异常
     */
    public void dealExcel(Integer quote_type, InputStream is,
            Map<Integer, Map<String, String>> dataMap,
            Map<Integer, String> headMap, Map<Integer, String> errorMap,
            String fileType) throws Exception {

        // 获取整个excel流
        Workbook workbook = null;
        Sheet sheet = null;
        Row row = null;
        Cell cell = null;
        Map<String, String> tempMap = null;

        // 2003的excel处理
        if ("xls".equals(fileType)) {
            workbook = new HSSFWorkbook(is);
        }
        // 2007之后的excel处理
        if ("xlsx".equals(fileType)) {
            workbook = new XSSFWorkbook(is);
        }
        if (null != workbook) {
            // 根据sheet名获取sheet
            String sheetName = "海运运价导入";// 海运费导入
            if (isPortQuote(quote_type)) {
                sheetName = "海运本地费";// 本地费导入
            }
            if (isAddationQuote(quote_type)) {
                sheetName = "海运附加费";// 附加费导入
            }
            sheet = workbook.getSheet(sheetName);
            if (null != sheet) {
                // 对每次上传的条数做限制
                if (sheet.getLastRowNum() > 1000) {
                    errorMap.put(0, "导入数据条数超过上限");
                    // throw new BusinessException("导入数据条数超过上限");
                }

                // 只有一行时，是表头，没有数据
                if (sheet.getLastRowNum() == 0) {
                    errorMap.put(0, "导入数据条数为空");
                    // throw new BusinessException("导入数据为空");
                }
                if (sheet.getLastRowNum() > 0 && sheet.getLastRowNum() <= 1000) {
                    // 获取表头行
                    row = sheet.getRow(0);
                    int columnNumberSum = row.getLastCellNum();// 总列数
                    // 获取表头字段信息
                    for (int headCellNum = 0; headCellNum < row
                            .getLastCellNum(); headCellNum++) {
                        cell = row.getCell(headCellNum);
                        // 此处默认excel中所有列的数据类型为string的，如果支持其他类型需完善
                        headMap.put(headCellNum, cell.getStringCellValue());
                    }
                    if (sheet.getLastRowNum() > 0) {
                        for (int rowNum = 1; rowNum <= sheet.getLastRowNum(); rowNum++) {
                            row = sheet.getRow(rowNum);
                            if (null == row) {
                                continue;
                            }
                            tempMap = new HashMap<String, String>();
                            // for (int dataCellNum = 0; dataCellNum <
                            // row.getLastCellNum(); dataCellNum++)
                            for (int dataCellNum = 0; dataCellNum < columnNumberSum; dataCellNum++) {
                                cell = row.getCell(dataCellNum);
                                if (null == cell) {
                                    tempMap.put(headMap.get(dataCellNum), null);

                                    continue;
                                }
                                cell.setCellType(Cell.CELL_TYPE_STRING);
                                // 此处默认excel中所有列的数据类型为string的，如果支持其他类型需完善
                                tempMap.put(headMap.get(dataCellNum),
                                        cell.getStringCellValue());
                            }
                            dataMap.put(rowNum, tempMap);
                        }
                    }
                }

            }
        }
    }

    /**
     * 第三步：将dataMap中的数据存在在LgsFclQuote4ExcelInfoEntity中
     * 
     * @param dataMap
     *            Map<Integer, Map<String, String>>
     *            key:行号，map内容（key:标题（eg:起运港），value:标题对应的内容（eg:上海））
     * @param uploadDataErrorMap
     *            存储错误的内容
     * @return
     */
    public List<LgsFclQuote4ExcelInfoEntity> dataMapConvertToLgsFclQuote4ExcelInfo(
            Map<Integer, Map<String, String>> dataMap,
            Map<Integer, String> uploadDataErrorMap) {
        LOGGER.debug("将dataMap中的数据存在在LgsFclQuote4ExcelInfoEntity中,dataMapConvertToLgsFclQuote4ExcelInfo方法调用开始...");

        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        List<LgsFclQuote4ExcelInfoEntity> lgsFclQuote4ExcelInfoEntityList = new ArrayList<LgsFclQuote4ExcelInfoEntity>();

        LgsFclQuote4ExcelInfoEntity lgsFclQuote4ExcelInfoEntity = null;
        Calendar calendar = Calendar.getInstance();
        calendar.set(Calendar.HOUR_OF_DAY, 0);
        calendar.set(Calendar.MINUTE, 0);
        calendar.set(Calendar.SECOND, 0);
        calendar.set(Calendar.MILLISECOND, 0);
        Date nowDate = calendar.getTime();
        for (Map.Entry<Integer, Map<String, String>> entryMaps : dataMap
                .entrySet()) {
            if (null == entryMaps) {
                continue;
            }
            // 行号
            Integer rowNum = entryMaps.getKey();
            // 报价excel中的列（列名称转成ID）对应的entity
            lgsFclQuote4ExcelInfoEntity = new LgsFclQuote4ExcelInfoEntity();

            StringBuffer retErrStr = new StringBuffer();
            Date execDate = null;
            Date expiryDate = null;

            // 遍历内容
            for (Map.Entry<String, String> entryMap : entryMaps.getValue()
                    .entrySet()) {
                if (null == entryMap) {
                    continue;
                }

                // 进出口
                if (IMPORTEXPORTFLAG.equals(entryMap.getKey().trim())) {
                    if (StringUtils.isEmpty(entryMap.getValue())) {
                        retErrStr.append("进出口错误;");
                    } else {
                        try {
                            if (null != entryMap.getValue()
                                    && ("出口".equals(entryMap.getValue()) || "E"
                                            .equals(entryMap.getValue()))) {
                                lgsFclQuote4ExcelInfoEntity
                                        .setImportExportFlag(1);// 出口
								lgsFclQuote4ExcelInfoEntity.setPrdQuoteId(31);
                            } else if (null != entryMap.getValue()
                                    && ("进口".equals(entryMap.getValue()) || "I"
                                            .equals(entryMap.getValue()))) {
                                lgsFclQuote4ExcelInfoEntity
                                        .setImportExportFlag(2);// 进口
								lgsFclQuote4ExcelInfoEntity.setPrdQuoteId(94);
                            } else {
                                retErrStr.append("进出口错误;");
                            }
                        } catch (Exception e) {
                            retErrStr.append("进出口错误;");
                            e.printStackTrace();
                        }
                    }
                }

                // 货代公司
                else if (SHIPCOMPANY.equals(entryMap.getKey().trim())) {
                    if (StringUtils.isEmpty(entryMap.getValue())) {
                        retErrStr.append("货代公司错误;");
                    } else {
                        try {
                            CusCustomerEntity cusCustomerEntity = null;

                            GetCustomerByNameRequest request = new GetCustomerByNameRequest();
                            request.setName(entryMap.getValue());
                            // 货代公司查询范围缩小
                            // GetCustomerByIdResponse getCustomerByIdResponse =
                            // customerWS.getByCompanyName(request);
                            // cusCustomerEntity =
                            // getCustomerByIdResponse.getCustomerEntity();

                            GetLogisticCampanyByTypeRequest req = new GetLogisticCampanyByTypeRequest();
                            HashMap<String, String> param = new HashMap<String, String>();
                            param.put("cusLogisticType", "03");// 01船公司，03货代公司
                            param.put("cusName", entryMap.getValue());// 中文名称
                            req.setPara(param);
                            GetLogisticCampanyByTypeResponse getLogisticCampanyByTypeResponse = customerWS
                                    .getLogisticCampanyByTypeAndName(req);
                            List<CusCustomerEntity> customerEntityList = getLogisticCampanyByTypeResponse
                                    .getCustomerEntityList();

                            if (null != customerEntityList
                                    && customerEntityList.size() > 0) {
                                cusCustomerEntity = customerEntityList.get(0);
                                lgsFclQuote4ExcelInfoEntity
                                        .setCarrierId(cusCustomerEntity.getId());
                            } else {
                                retErrStr.append("货代公司错误;");
                            }
                        } catch (Exception e) {
                            retErrStr.append("货代公司错误;");
                            e.printStackTrace();
                        }
                    }
                }
                // 起运港
                else if (SHIPMENTPORTID.equals(entryMap.getKey().trim())) {
                    if (StringUtils.isEmpty(entryMap.getValue())) {
                        retErrStr.append("起运港错误;");
                    } else {
                        try {
                            // 港口英文名称->港口ID
                            Integer shipmentPortId = portcodeServiceWS
                                    .getPortIdByPortNameEn(entryMap.getValue());
                            if (null != shipmentPortId) {
                                lgsFclQuote4ExcelInfoEntity
                                        .setShipmentPortId(shipmentPortId);
                            } else {
                                retErrStr.append("起运港错误;");
                            }
                        } catch (Exception e) {
                            retErrStr.append("起运港错误;");
                        }
                    }
                }
                // 目的港
                else if (DESTINATIONPORTID.equals(entryMap.getKey().trim())) {
                    if (StringUtils.isEmpty(entryMap.getValue())) {
                        retErrStr.append("目的港错误;");
                    } else {
                        try {
                            // 港口英文名称->港口ID
                            Integer shipmentPortId = portcodeServiceWS
                                    .getPortIdByPortNameEn(entryMap.getValue());
                            if (null != shipmentPortId) {
                                lgsFclQuote4ExcelInfoEntity
                                        .setDestinationPortId(shipmentPortId);
                            } else {
                                retErrStr.append("目的港错误;");
                            }
                        } catch (Exception e) {
                            retErrStr.append("目的港错误;");
                        }
                    }
                }
                // 航线名称
                else if (LINENAME.equals(entryMap.getKey().trim())) {
                    if (StringUtils.isEmpty(entryMap.getValue())) {
                        retErrStr.append("航线名称错误;");
                    } else {
                        try {
                            ShippinglineEntity shippinglineEntity = null;
                            // 根据航线名称获取航线ID
                            GetShippinglineByNameRequest request = new GetShippinglineByNameRequest();
                            request.setShippinglineName(entryMap.getValue());
                            GetShippinglineByNameResponse response = shippinglineServiceWS
                                    .getShippinglineByName(request);
                            List<ShippinglineEntity> entitys = response
                                    .getEntitys();
                            if (null != entitys && entitys.size() > 0) {
                                shippinglineEntity = entitys.get(0);
                            }
                            if (null != shippinglineEntity) {
                                lgsFclQuote4ExcelInfoEntity
                                        .setRouteTypeId(shippinglineEntity
                                                .getId());
                            } else {
                                retErrStr.append("航线名称错误;");
                            }
                        } catch (Exception e) {
                            retErrStr.append("航线名称错误;");
                        }
                    }
                }
                // 船公司(英文)
                else if (AGENT.equals(entryMap.getKey().trim())) {
                    if (StringUtils.isEmpty(entryMap.getValue())) {
                        retErrStr.append("船公司错误;");
                    } else {
                        try {
                            CusCustomerEntity cusCustomerEntity = null;

                            GetCustomerByNameRequest request = new GetCustomerByNameRequest();
                            request.setName(entryMap.getValue());
                            // 缩小查询范围
                            // GetCustomerByIdResponse getCustomerByIdResponse =
                            // customerWS.getByCompanyNameEn(request);
                            // cusCustomerEntity =
                            // getCustomerByIdResponse.getCustomerEntity();

                            GetLogisticCampanyByTypeRequest req = new GetLogisticCampanyByTypeRequest();
                            HashMap<String, String> param = new HashMap<String, String>();
                            param.put("cusLogisticType", "01");// 01船公司，03货代公司
                            param.put("cusNameEn", entryMap.getValue());// 英文名称
                            req.setPara(param);
                            GetLogisticCampanyByTypeResponse getLogisticCampanyByTypeResponse = customerWS
                                    .getLogisticCampanyByTypeAndName(req);
                            List<CusCustomerEntity> customerEntityList = getLogisticCampanyByTypeResponse
                                    .getCustomerEntityList();

                            if (null != customerEntityList
                                    && customerEntityList.size() > 0) {
                                cusCustomerEntity = customerEntityList.get(0);
                                lgsFclQuote4ExcelInfoEntity
                                        .setAgentId(cusCustomerEntity.getId());
                            } else {
                                retErrStr.append("船公司错误;");
                            }
                        } catch (Exception e) {
                            retErrStr.append("船公司错误;");
                        }
                    }
                }
                // 费用名称
                else if (QUOTENAME.equals(entryMap.getKey().trim())) {
                    if (StringUtils.isEmpty(entryMap.getValue())) {
                        retErrStr.append("费用名称错误;");
                    } else {
                        try {
                            // prd_quote
							/*
							 * PrdQuoteRequest request = new PrdQuoteRequest();
							 * request.setName(entryMap.getValue());
							 * 
							 * PrdQuoteResponse prdQuoteResponse =
							 * prdQuoteServiceWS .getPrdQuoteByName(request);
							 * List<PrdQuoteEntity> prdQuoteEntitys =
							 * prdQuoteResponse .getPrdQuoteEntitys(); if (null
							 * != prdQuoteEntitys && prdQuoteEntitys.size() > 0)
							 * { // 对进出口进行匹配 如果符合直接塞入报价项 Integer prdQuoteId =
							 * null; for (PrdQuoteEntity prdQuoteEntity :
							 * prdQuoteEntitys) { if
							 * (prdQuoteEntity.getTradeId().equals(
							 * lgsFclQuote4ExcelInfoEntity
							 * .getImportExportFlag())) { prdQuoteId =
							 * prdQuoteEntity.getId(); } } if (prdQuoteId ==
							 * null || prdQuoteId == 0) {
							 * retErrStr.append("费用名称错误;"); } else {
							 * lgsFclQuote4ExcelInfoEntity
							 * .setPrdQuoteId(prdQuoteId); } } else {
							 * retErrStr.append("费用名称错误;"); }
							 */
                        } catch (Exception e) {
                            retErrStr.append("费用名称错误;");
                            e.printStackTrace();
                        }
                    }
                }

                else if (COST20GP.equals(entryMap.getKey().trim())) {
                    if (null != entryMap.getValue()) {
                        try {
                            lgsFclQuote4ExcelInfoEntity
                                    .setCost20gp(BigDecimal.valueOf(Double
                                            .valueOf(entryMap.getValue())));
                        } catch (Exception e) {
                            retErrStr.append("20GP价格错误;");
                            e.printStackTrace();
                        }
                    }
                } else if (COST40GP.equals(entryMap.getKey().trim())) {
                    if (null != entryMap.getValue()) {
                        try {
                            lgsFclQuote4ExcelInfoEntity
                                    .setCost40gp(BigDecimal.valueOf(Double
                                            .valueOf(entryMap.getValue())));
                        } catch (Exception e) {
                            retErrStr.append("40GP价格错误;");
                            e.printStackTrace();
                        }
                    }
                } else if (COST40HQ.equals(entryMap.getKey().trim())) {
                    if (null != entryMap.getValue()) {
                        try {
                            lgsFclQuote4ExcelInfoEntity
                                    .setCost40hq(BigDecimal.valueOf(Double
                                            .valueOf(entryMap.getValue())));
                        } catch (Exception e) {
                            retErrStr.append("40HQ价格错误;");
                            e.printStackTrace();
                        }
                    }
                }

                // 币种
                else if (CURRENCYNAME.equals(entryMap.getKey().trim())) {
                    // 抛弃，不存数据库
                }
                // 航程
                else if (ESTIMATEDRANGE.equals(entryMap.getKey().trim())) {
                    lgsFclQuote4ExcelInfoEntity.setEstimatedRange(entryMap
                            .getValue());
                }
                // 班期
                else if (ESTIMATEDSALINGDATE.equals(entryMap.getKey().trim())) {
                    lgsFclQuote4ExcelInfoEntity.setEstimatedSalingdate(entryMap
                            .getValue());
                    if(entryMap.getValue()!=null){
                    	 String salingDate = entryMap.getValue().trim();
                         if(salingDate!=null){
                         	String[] Dates = salingDate.split(",");
                         	if(Dates!=null && Dates.length>0){
                         		for(String date : Dates){
                         			if("星期一".equals(date) || "星期二".equals(date) || "星期三".equals(date) || "星期四".equals(date) || "星期五".equals(date) || "星期六".equals(date) || "星期日".equals(date)){
                         				
                         			}else{
                         				//不满足条件就失败了，并且退出循环
                         				retErrStr.append("班期数据有误："+salingDate);
                         				break;
                         			}
                         		}
                         	}
                         }
                    }
                }
                // 是否中转
                else if (ISENTERPORT.equals(entryMap.getKey().trim())) {
                    // transp_properties
                    lgsFclQuote4ExcelInfoEntity.setTranspProperties(entryMap
                            .getValue());
                }
                // 中转港
                else if (ENTERPORTID.equals(entryMap.getKey().trim())) {
                    if (StringUtils.isNotEmpty(entryMap.getValue())) {
                        try {
                            // 港口英文名称->港口ID
                            Integer shipmentPortId = portcodeServiceWS
                                    .getPortIdByPortNameEn(entryMap.getValue());
                            if (null != shipmentPortId) {
                                lgsFclQuote4ExcelInfoEntity
                                        .setEnterportId(shipmentPortId);
                            } else {
                                retErrStr.append("中转港错误;");
                            }
                        } catch (Exception e) {
                            retErrStr.append("中转港错误;");
                        }
                    }
                }
                // 生效日期
                else if (EXECDATE.equals(entryMap.getKey().trim())) {
                    if (null == entryMap.getValue()
                            || "".equals(entryMap.getValue().trim())) {
                        retErrStr.append("生效时间必填;");
                    } else {
                        try {
                            execDate = format.parse(entryMap.getValue());
                        } catch (ParseException e) {
                            retErrStr.append("生效时间格式错误;");
                            e.printStackTrace();
                        }
                        if (null != execDate) {
                            if (nowDate.after(execDate)) {
                                retErrStr.append("生效时间小于当前时间;");
                            } else {
                                lgsFclQuote4ExcelInfoEntity
                                        .setExecDate(execDate);
                            }
                            if (null != expiryDate) {
                                if (execDate.after(expiryDate)) {
                                    retErrStr.append("生效时间大于失效时间;");
                                }
                            }
                        }
                    }
                }
                // 失效日期
                else if (EXPIRYDATE.equals(entryMap.getKey().trim())) {
                    if (null == entryMap.getValue()
                            || "".equals(entryMap.getValue().trim())) {
                        retErrStr.append("失效时间必填;");
                    } else {
                        try {
                            expiryDate = format.parse(entryMap.getValue());
                        } catch (ParseException e) {
                            retErrStr.append("失效时间格式错误;");
                            e.printStackTrace();
                        }
                        if (null != expiryDate) {
                            lgsFclQuote4ExcelInfoEntity
                                    .setExpiryDate(expiryDate);
                            if (null != execDate && execDate.after(expiryDate)) {
                                retErrStr.append("生效时间大于失效时间;");
                            }
                        }
                    }
                }
                // 是否All-in
                else if (ALLIN.equals(entryMap.getKey().trim())) {
                    if (StringUtils.isNotEmpty(entryMap.getValue())) {
                        if ("是".equals(entryMap.getValue())) {
                            lgsFclQuote4ExcelInfoEntity.setIfAllIn(1);//
                        } else if ("否".equals(entryMap.getValue())) {
                            lgsFclQuote4ExcelInfoEntity.setIfAllIn(0);
                        } else {
                            retErrStr.append("是否All-in错误;");
                        }
                    } else {
                        retErrStr.append("是否All-in错误;");
                    }
                }
                // 备注
                else if (REMARKINFO.equals(entryMap.getKey().trim())) {
                    lgsFclQuote4ExcelInfoEntity.setRemark(entryMap.getValue());
                } else {
                    uploadDataErrorMap.put(0, "系统错误");
                }

            }
            if (SunivoStringUtils.isEmpty(retErrStr.toString())) {

                // 对数据表头进行判重
                // 记录已经存在
                LgsFclQuoteInfoEntity lgsFclQuoteInfoEntity = new LgsFclQuoteInfoEntity();

                lgsFclQuoteInfoEntity.setAgentId(lgsFclQuote4ExcelInfoEntity
                        .getAgentId());// 货代ID
                lgsFclQuoteInfoEntity
                        .setShipmentPortId(lgsFclQuote4ExcelInfoEntity
                                .getShipmentPortId());// 起运港ID
                lgsFclQuoteInfoEntity
                        .setDestinationPortId(lgsFclQuote4ExcelInfoEntity
                                .getDestinationPortId());// 目的港ID
                lgsFclQuoteInfoEntity
                        .setRouteTypeId(lgsFclQuote4ExcelInfoEntity
                                .getRouteTypeId());// 航线类型ID
                lgsFclQuoteInfoEntity.setCarrierId(lgsFclQuote4ExcelInfoEntity
                        .getCarrierId());// 船公司ID
                lgsFclQuoteInfoEntity
                        .setImportExportFlag(lgsFclQuote4ExcelInfoEntity
                                .getImportExportFlag());// 进出口

                LgsFclQsurchargeEntity fclQentity = new LgsFclQsurchargeEntity();
                fclQentity.setPrdQuoteId(lgsFclQuote4ExcelInfoEntity
                        .getPrdQuoteId());// 费用项

                // 根据[货代ID,起运港ID,目的港ID,航线类型ID,船公司ID,进出口，费用项]判断报价是否重复
                // Object countObj =
                // lgsFclQuoteInfoServiceWS.queryFclQuoteCountByCondition(lgsFclQuoteInfoEntity);
                // List<LgsFclQuoteInfoEntity> ls =
                // lgsFclQuoteInfoServiceWS.getUniqueFcl(lgsFclQuoteInfoEntity,
                // fclQentity);
                ListLgsFclQsurchargeResponse res = lgsFclQuoteInfoServiceWS
                        .getUniqueQuote(lgsFclQuoteInfoEntity, fclQentity);
                List<LgsFclQsurchargeEntity> quotes = res.getObjectList();

                if (quotes != null && quotes.size() > 0) {
                    LgsFclQsurchargeEntity oldQuote = quotes.get(0);

                    if (oldQuote != null) {
                        // "该条报价重复"
                        // retErrStr.append("该报价在数据库中已存在;");
                        // 将这条重复的报价设置为无效oldQuote.disabled=1，然后重新导入新的报价
                        DeleteLgsFclQsurchargeRequest request = new DeleteLgsFclQsurchargeRequest();
                        request.setId(oldQuote.getId());
                        lgsFclQsurchargeServiceWS.deleteById(request);
                    }
                }
                boolean isUnique = isUniqueFclQuoteInList(
                        lgsFclQuote4ExcelInfoEntityList,
                        lgsFclQuote4ExcelInfoEntity);
                if (!isUnique) {
                    // "该条报价重复"
                    retErrStr.append("excel中存在重复报价;");
                }

            }
            int realRowNum = rowNum + 1;
            if (!SunivoStringUtils.isEmpty(retErrStr.toString())) {
                uploadDataErrorMap.put(realRowNum, retErrStr.toString());
            }
            if (null == uploadDataErrorMap.get(realRowNum)) {
                lgsFclQuote4ExcelInfoEntityList
                        .add(lgsFclQuote4ExcelInfoEntity);
            }
        }
        LOGGER.debug("将dataMap中的数据存在在LgsFclQuote4ExcelInfoEntity中,dataMapConvertToLgsFclQuote4ExcelInfo方法调用结束...");
        return lgsFclQuote4ExcelInfoEntityList;
    }

    /**
     * 第四步：将List<LgsFclQuote4ExcelInfoEntity>内容保存到数据库
     * 
     * @param lgsFclQuote4ExcelInfoEntityList
     * @param uploadDataErrorMap
     * @return
     */
    public String dealUploadSurchargeData(
            List<LgsFclQuote4ExcelInfoEntity> lgsFclQuote4ExcelInfoEntityList,
            Map<Integer, String> uploadDataErrorMap) {
        if (lgsFclQuote4ExcelInfoEntityList != null
                && lgsFclQuote4ExcelInfoEntityList.size() > 0) {

            for (LgsFclQuote4ExcelInfoEntity lgsFclQuote4ExcelInfoEntity : lgsFclQuote4ExcelInfoEntityList) {
                // 海运费：表头
                LgsFclQuoteInfoEntity flcQuoteInfo = new LgsFclQuoteInfoEntity();
                // 报价明细
                LgsFclQsurchargeEntity surchargeCase = new LgsFclQsurchargeEntity();

                ReflexUtil
                        .copyEntity(lgsFclQuote4ExcelInfoEntity, flcQuoteInfo);
                ReflexUtil.copyEntity(lgsFclQuote4ExcelInfoEntity,
                        surchargeCase);

                // 海运费列表：表头
                List<LgsFclQuoteInfoEntity> flcQuoteInfoList = new ArrayList<LgsFclQuoteInfoEntity>();
                // 报价明细列表
                List<LgsFclQsurchargeEntity> surchargeCaseList = new ArrayList<LgsFclQsurchargeEntity>();

                // 目前:海整出口/海整进口
                if (1 == flcQuoteInfo.getImportExportFlag().intValue()) {// 出口
                    flcQuoteInfo.setProductId(1);// 出口海整=1
                } else {
                    flcQuoteInfo.setProductId(8);// 进口海整=8
                }

                LgsRouteAdditionQuoteEntity quoteAdditionEntityReq = new LgsRouteAdditionQuoteEntity();
                quoteAdditionEntityReq
                        .setRouteTypeId(lgsFclQuote4ExcelInfoEntity
                                .getRouteTypeId());
                quoteAdditionEntityReq.setImportExportFlag(flcQuoteInfo
                        .getImportExportFlag()); // 出口
                quoteAdditionEntityReq.setTransportType(1); // 海运

                // 查找是否有按航线加成的记录 有的话 则同步增加销售价
                LgsRouteAdditionQuoteEntity quoteAddition = null;
                // 加成操作
                GetLgsRouteAdditionQuoteByEntityRequest request = new GetLgsRouteAdditionQuoteByEntityRequest();
                request.setEntity(quoteAdditionEntityReq);
                GetLgsRouteAdditionQuoteByEntityResponse response = lgsRouteAdditionQuoteWS
                        .getLgsRouteAdditionQuoteByEnitty(request);

                quoteAddition = response.getEntity();

                if ((surchargeCase.getCost20gp() != null && surchargeCase
                        .getCost20gp().compareTo(new BigDecimal(0)) > 0)
                        || (surchargeCase.getCost40gp() != null && surchargeCase
                                .getCost40gp().compareTo(new BigDecimal(0)) > 0)
                        || (surchargeCase.getCost40hq() != null && surchargeCase
                                .getCost40hq().compareTo(new BigDecimal(0)) > 0)
                        || (surchargeCase.getNonContainerCost() != null && surchargeCase
                                .getNonContainerCost().compareTo(
                                        new BigDecimal(0)) > 0)) {
                    if (quoteAddition != null) {
                        // 销售价存储
                        BigDecimal addValue = quoteAddition
                                .getFclPriceAddValue();
                        BigDecimal addPercent = quoteAddition
                                .getFclPriceAddPercent();
                        BigDecimal disAddPer = quoteAddition
                                .getFclDiscountAddPercent();
                        // 加成操作
                        surchargeCase = setAddationValue(surchargeCase,
                                addValue, disAddPer, addPercent);
                    } else {
                        // 没有加成操作,设置默认的销售价，折扣价
                        surchargeCase = fullDefaultPriceAndDiscount(surchargeCase);
                    }
                    surchargeCase.setDisabled(0);// 默认为0
                    surchargeCase.setQuoteType(QuoteType.FCL);// 默认QuoteType.FCL=1海运运费
                    // 放到集合中，一并入库
                    flcQuoteInfoList.add(flcQuoteInfo);
                    surchargeCaseList.add(surchargeCase);
                }

                LgsQuoteRequest lgsQuoteRequest = new LgsQuoteRequest();

                lgsQuoteRequest.setLgsFclQuoteInfoEntityList(flcQuoteInfoList); // 海运费基本信息
                lgsQuoteRequest
                        .setLgsFclQsurchargeEntityList(surchargeCaseList); // 海运费报价详情
                // 保存到数据库
                lgsQuoteImportServiceWS.importFclQuote(lgsQuoteRequest);
            }
        }
        return null;
    }

    /**
     * 第五步：将错误结果集（错误行号，错误信息）uploadDataErrorMap写到excel中
     * 
     * @category 根据导入的处理结果 输出导出结果集（错误行号，错误信息）
     * @param errorMap
     * @param fileType
     * @param request
     * @return
     */
    public String createResultExcel(Map<Integer, String> uploadDataErrorMap,
            String fileType, HttpServletRequest request) {

        Workbook wb = null;
        Sheet sheet = null;
        Row row = null;
        Cell cell = null;
        OutputStream fileOut = null;
        String path = request.getSession().getServletContext().getRealPath("/")
                + "WEB-INF/views/lgs/uploadsurchargefile/";
        String fileName = "";
        String realpath = "";
        int rowNum = 0;
        try {
            wb = new XSSFWorkbook();
            fileName = "workbook" + new Date().getTime() + ".xlsx";
            realpath = path + fileName;
            fileOut = new FileOutputStream(realpath);
            sheet = wb.createSheet("uplooad result");
            row = sheet.createRow(rowNum);
            cell = row.createCell(0);
            cell.setCellValue("错误行号");

            cell = row.createCell(1);
            cell.setCellValue("错误信息");
            for (Map.Entry<Integer, String> entryMap : uploadDataErrorMap
                    .entrySet()) {
                row = sheet.createRow(++rowNum);
                cell = row.createCell(0);
                cell.setCellValue(String.valueOf(entryMap.getKey()));
                cell = row.createCell(1);
                cell.setCellValue(entryMap.getValue());
            }
            wb.write(fileOut);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                fileOut.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }

        return fileName.substring(0, fileName.lastIndexOf("."));
    }

    // ===================== 本地费 ==============================

    /**
     * 本地费
     * 
     * @param dataMap
     * @param uploadDataErrorMap
     * @return
     */
    public List<LgsPortQuote4ExcelInfoEntity> dataMapConvertToLgsPortQuote4ExcelInfo(
            Map<Integer, Map<String, String>> dataMap,
            Map<Integer, String> uploadDataErrorMap) {

        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        List<LgsPortQuote4ExcelInfoEntity> lgsPortQuote4ExcelInfoEntityList = new ArrayList<LgsPortQuote4ExcelInfoEntity>();

        LgsPortQuote4ExcelInfoEntity lgsPortQuote4ExcelInfoEntity = null;
        Calendar calendar = Calendar.getInstance();
        calendar.set(Calendar.HOUR_OF_DAY, 0);
        calendar.set(Calendar.MINUTE, 0);
        calendar.set(Calendar.SECOND, 0);
        calendar.set(Calendar.MILLISECOND, 0);
        Date nowDate = calendar.getTime();
        // 遍历行
        for (Map.Entry<Integer, Map<String, String>> entryMaps : dataMap
                .entrySet()) {
            if (null == entryMaps) {
                continue;
            }
            // 行号
            Integer rowNum = entryMaps.getKey();
            // 报价excel中的列（列名称转成ID）对应的entity
            lgsPortQuote4ExcelInfoEntity = new LgsPortQuote4ExcelInfoEntity();

            StringBuffer retErrStr = new StringBuffer();
            Date execDate = null;
            Date expiryDate = null;

            String jjdw = "";// 计价单位
            String nonContainerCost = "";// 每票单价
            String cost20gp = "";// 20'GP单价
            String cost40gp = "";// 40'GP单价
            String cost40hq = "";// 40'HQ单价

            // 遍历列
            Set<Map.Entry<String, String>> s = entryMaps.getValue().entrySet();
            for (Map.Entry<String, String> entryMap : s) {
                if (null == entryMap) {
                    continue;
                }

                // 进出口
                if (IMPORTEXPORTFLAG.equals(entryMap.getKey().trim())) {
                    if (StringUtils.isEmpty(entryMap.getValue())) {
                        retErrStr.append("进出口错误;");
                    } else {
                        try {
                            if (null != entryMap.getValue()
                                    && ("出口".equals(entryMap.getValue()) || "E"
                                            .equals(entryMap.getValue()))) {
                                lgsPortQuote4ExcelInfoEntity
                                        .setImportExportFlag(1);// 出口
                            } else if (null != entryMap.getValue()
                                    && ("进口".equals(entryMap.getValue()) || "I"
                                            .equals(entryMap.getValue()))) {
                                lgsPortQuote4ExcelInfoEntity
                                        .setImportExportFlag(2);// 进口
                            } else {
                                retErrStr.append("进出口错误;");
                            }
                        } catch (Exception e) {
                            retErrStr.append("进出口错误;");
                            e.printStackTrace();
                        }
                    }
                }

                // 起运港
                else if (SHIPMENTPORTID.equals(entryMap.getKey().trim())) {
                    if (StringUtils.isEmpty(entryMap.getValue())) {
                        retErrStr.append("起运港错误;");
                    } else {
                        try {
                            // 港口英文名称->港口ID
                            Integer shipmentPortId = portcodeServiceWS
                                    .getPortIdByPortNameEn(entryMap.getValue());
                            if (null != shipmentPortId) {
                                lgsPortQuote4ExcelInfoEntity
                                        .setShipmentPortId(shipmentPortId);
                            } else {
                                retErrStr.append("起运港错误;");
                            }
                        } catch (Exception e) {
                            retErrStr.append("起运港错误;");
                        }
                    }
                }
                // 航线名称
                else if (LINENAME.equals(entryMap.getKey().trim())) {
                    if (StringUtils.isEmpty(entryMap.getValue())) {
                        retErrStr.append("航线名称错误;");
                    } else {
                        try {
                            ShippinglineEntity shippinglineEntity = null;
                            // 根据航线名称获取航线ID
                            GetShippinglineByNameRequest request = new GetShippinglineByNameRequest();
                            request.setShippinglineName(entryMap.getValue());
                            GetShippinglineByNameResponse response = shippinglineServiceWS
                                    .getShippinglineByName(request);
                            List<ShippinglineEntity> entitys = response
                                    .getEntitys();
                            if (null != entitys && entitys.size() > 0) {
                                shippinglineEntity = entitys.get(0);
                            }
                            if (null != shippinglineEntity) {
                                lgsPortQuote4ExcelInfoEntity
                                        .setRouteTypeId(shippinglineEntity
                                                .getId());
                            } else {
                                retErrStr.append("航线名称错误;");
                            }
                        } catch (Exception e) {
                            retErrStr.append("航线名称错误;");
                        }
                    }
                }
                // 船公司(英文)
                else if (AGENT.equals(entryMap.getKey().trim())) {
                    if (StringUtils.isEmpty(entryMap.getValue())) {
                        retErrStr.append("船公司错误;");
                    } else {
                        try {
                            CusCustomerEntity cusCustomerEntity = null;

                            GetCustomerByNameRequest request = new GetCustomerByNameRequest();
                            request.setName(entryMap.getValue());

                            // GetCustomerByIdResponse getCustomerByIdResponse =
                            // customerWS.getByCompanyNameEn(request);
                            // cusCustomerEntity =
                            // getCustomerByIdResponse.getCustomerEntity();

                            GetLogisticCampanyByTypeRequest req = new GetLogisticCampanyByTypeRequest();
                            HashMap<String, String> param = new HashMap<String, String>();
                            param.put("cusLogisticType", "01");// 01船公司，03货代公司
                            param.put("cusNameEn", entryMap.getValue());// 英文名称
                            req.setPara(param);
                            GetLogisticCampanyByTypeResponse getLogisticCampanyByTypeResponse = customerWS
                                    .getLogisticCampanyByTypeAndName(req);
                            List<CusCustomerEntity> customerEntityList = getLogisticCampanyByTypeResponse
                                    .getCustomerEntityList();

                            if (null != customerEntityList
                                    && customerEntityList.size() > 0) {
                                cusCustomerEntity = customerEntityList.get(0);
                                lgsPortQuote4ExcelInfoEntity
                                        .setAgentId(cusCustomerEntity.getId());
                            } else {
                                retErrStr.append("船公司错误;");
                            }
                        } catch (Exception e) {
                            retErrStr.append("船公司错误;");
                        }
                    }
                }
                // 费用名称
                else if (QUOTENAME.equals(entryMap.getKey().trim())) {
                    if (StringUtils.isEmpty(entryMap.getValue())) {
                        retErrStr.append("费用名称错误;");
                    } else {
                        try {
                            // prd_quote

							PrdQuoteRequest request = new PrdQuoteRequest();
							request.setName(entryMap.getValue());
							request.setOriginalId(11000149);
							PrdQuoteResponse prdQuoteResponse = prdQuoteServiceWS
									.getPrdQuoteByNameAndOriginalid(request);
							List<PrdQuoteEntity> prdQuoteEntitys = prdQuoteResponse
									.getPrdQuoteEntitys();
							if (null != prdQuoteEntitys
									&& prdQuoteEntitys.size() > 0) {
								PrdQuoteEntity prdQuoteEntity = prdQuoteEntitys
										.get(0);
								Integer prdQuoteId = prdQuoteEntity.getId();
								lgsPortQuote4ExcelInfoEntity
										.setPrdQuoteId(prdQuoteId);
							} else {
								retErrStr.append("费用名称错误;");
							}

                        } catch (Exception e) {
                            retErrStr.append("费用名称错误;");
                            e.printStackTrace();
                        }
                    }
                }
                // 计价单位
                else if (COST_UNIT.equals(entryMap.getKey().trim())) {
                    if (null != entryMap.getValue()) {
                        if (!"票".equals(entryMap.getValue().trim())
                                && !"柜".equals(entryMap.getValue().trim())) {
                            retErrStr.append("计价单位错误;");
                        } else {
                            jjdw = entryMap.getValue().trim();
                        }
                    }
                }
                // 每票单价(计价单位是票是，填写‘每票单价’)
                else if (NON_CONTAINER_COST.equals(entryMap.getKey().trim())) {
                    if (null != entryMap.getValue()) {
                        nonContainerCost = entryMap.getValue();
                        lgsPortQuote4ExcelInfoEntity
                                .setNonContainerCost(BigDecimal.valueOf(Double
                                        .valueOf(entryMap.getValue())));
                    }
                } else if (COST20GP.equals(entryMap.getKey().trim())) {
                    if (null != entryMap.getValue()) {
                        try {
                            cost20gp = entryMap.getValue();
                            lgsPortQuote4ExcelInfoEntity
                                    .setCost20gp(BigDecimal.valueOf(Double
                                            .valueOf(entryMap.getValue())));
                        } catch (Exception e) {
                            retErrStr.append("20GP价格错误;");
                            e.printStackTrace();
                        }
                    }
                } else if (COST40GP.equals(entryMap.getKey().trim())) {
                    if (null != entryMap.getValue()) {
                        try {
                            cost40gp = entryMap.getValue();
                            lgsPortQuote4ExcelInfoEntity
                                    .setCost40gp(BigDecimal.valueOf(Double
                                            .valueOf(entryMap.getValue())));
                        } catch (Exception e) {
                            retErrStr.append("40GP价格错误;");
                            e.printStackTrace();
                        }
                    }
                } else if (COST40HQ.equals(entryMap.getKey().trim())) {
                    if (null != entryMap.getValue()) {
                        try {
                            cost40hq = entryMap.getValue();
                            lgsPortQuote4ExcelInfoEntity
                                    .setCost40hq(BigDecimal.valueOf(Double
                                            .valueOf(entryMap.getValue())));
                        } catch (Exception e) {
                            retErrStr.append("40HQ价格错误;");
                            e.printStackTrace();
                        }
                    }
                }

                // 币种
                else if (CURRENCYNAME.equals(entryMap.getKey().trim())) {
                    // 抛弃，不存数据库
                } else if (EXECDATE.equals(entryMap.getKey().trim())) {
                    if (null == entryMap.getValue()
                            || "".equals(entryMap.getValue().trim())) {
                        retErrStr.append("生效时间必填;");
                    } else {
                        try {
                            execDate = format.parse(entryMap.getValue());
                        } catch (ParseException e) {
                            retErrStr.append("生效时间格式错误;");
                            e.printStackTrace();
                        }
                        if (null != execDate) {
                            if (nowDate.after(execDate)) {
                                retErrStr.append("生效时间小于当前时间;");
                            } else {
                                lgsPortQuote4ExcelInfoEntity
                                        .setExecDate(execDate);
                            }
                            if (null != expiryDate) {
                                if (execDate.after(expiryDate)) {
                                    retErrStr.append("生效时间大于失效时间;");
                                }
                            }
                        }
                    }
                }
                // 失效日期
                else if (EXPIRYDATE.equals(entryMap.getKey().trim())) {
                    if (null == entryMap.getValue()
                            || "".equals(entryMap.getValue().trim())) {
                        retErrStr.append("失效时间必填;");
                    } else {
                        try {
                            expiryDate = format.parse(entryMap.getValue());
                        } catch (ParseException e) {
                            retErrStr.append("失效时间格式错误;");
                            e.printStackTrace();
                        }
                        if (null != expiryDate) {
                            lgsPortQuote4ExcelInfoEntity
                                    .setExpiryDate(expiryDate);
                            if (null != execDate && execDate.after(expiryDate)) {
                                retErrStr.append("生效时间大于失效时间;");
                            }
                        }
                    }
                }
                // 备注
                else if (REMARKINFO.equals(entryMap.getKey().trim())) {
                    lgsPortQuote4ExcelInfoEntity.setRemark(entryMap.getValue());
                } else {
                    uploadDataErrorMap.put(0, "系统错误,导入的文件标题与模板不匹配");
                }
            }
            // 如果计价单位是票， 填写'每票单价'。20GPGP、40GP、40HQ不用填写。
            // 如果计价单位是柜，不填写'每票单价',20GPGP、40GP、40HQ至少填写一项
            if ("票".equals(jjdw) && SunivoStringUtils.isEmpty(nonContainerCost)) {
                retErrStr.append("计价单位是票，每票单价必填;");
            }
            if ("柜".equals(jjdw) && SunivoStringUtils.isEmpty(cost20gp)
                    && SunivoStringUtils.isEmpty(cost40gp)
                    && SunivoStringUtils.isEmpty(cost40hq)) {
                retErrStr.append("计价单位是柜，20'GP单价,40'GP单价,40'HQ单价至少填一项;");
            }

            if (SunivoStringUtils.isEmpty(retErrStr.toString())) {

                // 对数据表头进行判重
                // 记录已经存在
                LgsPortEntity lgsPortEntity = new LgsPortEntity();

                lgsPortEntity.setAgentId(lgsPortQuote4ExcelInfoEntity
                        .getAgentId());// 船公司ID
                lgsPortEntity.setShipmentPortId(lgsPortQuote4ExcelInfoEntity
                        .getShipmentPortId());// 起运港ID
                lgsPortEntity.setRouteTypeId(lgsPortQuote4ExcelInfoEntity
                        .getRouteTypeId());// 航线类型ID
                lgsPortEntity.setImportExportFlag(lgsPortQuote4ExcelInfoEntity
                        .getImportExportFlag());// 进出口

                LgsFclQsurchargeEntity fclQentity = new LgsFclQsurchargeEntity();
                fclQentity.setPrdQuoteId(lgsPortQuote4ExcelInfoEntity
                        .getPrdQuoteId());

                // 根据[起运港ID,航线类型ID,船公司ID,进出口,费用项]判断报价是否重复
                /*
                 * Object countObj =
                 * lgsPortServiceWS.queryPortQuoteCountByCondition
                 * (lgsPortEntity,fclQentity); if(null!=countObj){ Integer count
                 * = 0; count = (Integer)countObj; if (count != null && count >
                 * 0) { // "该条报价重复" retErrStr.append("该报价在数据库中已存在;"); } }
                 */
                LgsPortRequest portRequest = new LgsPortRequest();
                portRequest.setEntity(lgsPortEntity);
                portRequest.setFclQentity(fclQentity);
                LgsPortResponse res = lgsPortServiceWS
                        .getUniquePort(portRequest);
                if (res != null) {
                    LgsFclQsurchargeEntity oldQuote = res
                            .getLgsFclQsurchargeEntity();

                    if (oldQuote != null) {
                        // "该条报价重复"
                        // retErrStr.append("该报价在数据库中已存在;");
                        // 将这条重复的报价设置为无效oldQuote.disabled=1，然后重新导入新的报价
                        DeleteLgsFclQsurchargeRequest request = new DeleteLgsFclQsurchargeRequest();
                        request.setId(oldQuote.getId());
                        lgsFclQsurchargeServiceWS.deleteById(request);
                    }
                }
                // 判断list中是否存在重复报价(根据[起运港ID,航线类型ID,船公司ID,进出口，费用项]判断报价是否重复)
                boolean isUnique = isUniquePortQuoteInList(
                        lgsPortQuote4ExcelInfoEntityList,
                        lgsPortQuote4ExcelInfoEntity);
                if (!isUnique) {
                    // "该条报价重复"
                    retErrStr.append("excel中存在重复报价;");
                }
            }
            int realRowNum = rowNum + 1;
            if (!SunivoStringUtils.isEmpty(retErrStr.toString())) {
                uploadDataErrorMap.put(realRowNum, retErrStr.toString());
            }
            if (null == uploadDataErrorMap.get(realRowNum)) {
                lgsPortQuote4ExcelInfoEntityList
                        .add(lgsPortQuote4ExcelInfoEntity);
            }
        }
        return lgsPortQuote4ExcelInfoEntityList;
    }

    /**
     * 第四步：将List<LgsPortQuote4ExcelInfoEntity>内容保存到数据库
     * 
     * @param lgsFclQuote4ExcelInfoEntityList
     * @param uploadDataErrorMap
     * @return
     */
    public String dealUploadSurchargeData4Port(
            List<LgsPortQuote4ExcelInfoEntity> lgsPortQuote4ExcelInfoEntityList,
            Map<Integer, String> uploadDataErrorMap) {
        if (lgsPortQuote4ExcelInfoEntityList != null
                && lgsPortQuote4ExcelInfoEntityList.size() > 0) {

            for (LgsPortQuote4ExcelInfoEntity lgsPortQuote4ExcelInfoEntity : lgsPortQuote4ExcelInfoEntityList) {
                // 海运费：表头
                LgsPortEntity lgsPortEntity = new LgsPortEntity();
                // 报价明细
                LgsFclQsurchargeEntity surchargeCase = new LgsFclQsurchargeEntity();

                ReflexUtil.copyEntity(lgsPortQuote4ExcelInfoEntity,
                        lgsPortEntity);
                ReflexUtil.copyEntity(lgsPortQuote4ExcelInfoEntity,
                        surchargeCase);

                // 海运费列表：表头
                List<LgsPortEntity> portQuoteInfoList = new ArrayList<LgsPortEntity>();
                // 报价明细列表
                List<LgsFclQsurchargeEntity> surchargeCaseList = new ArrayList<LgsFclQsurchargeEntity>();

                // 目前:海整出口/海整进口
                if (1 == lgsPortEntity.getImportExportFlag().intValue()) {// 出口
                    lgsPortEntity.setProductId(1);// 出口海整=1
                } else {
                    lgsPortEntity.setProductId(8);// 进口海整=8
                }

                LgsRouteAdditionQuoteEntity quoteAdditionEntityReq = new LgsRouteAdditionQuoteEntity();
                quoteAdditionEntityReq
                        .setRouteTypeId(lgsPortQuote4ExcelInfoEntity
                                .getRouteTypeId());// 航线类型ID
                quoteAdditionEntityReq.setImportExportFlag(lgsPortEntity
                        .getImportExportFlag());// 进出口标识 1-出口 2进口
                quoteAdditionEntityReq.setTransportType(1);// 1-海运整箱、2-海运拼箱、3-空运

                // 查找是否有按航线加成的记录 有的话 则同步增加销售价
                LgsRouteAdditionQuoteEntity quoteAddition = null;
                // 加成操作
                GetLgsRouteAdditionQuoteByEntityRequest request = new GetLgsRouteAdditionQuoteByEntityRequest();
                request.setEntity(quoteAdditionEntityReq);
                GetLgsRouteAdditionQuoteByEntityResponse response = lgsRouteAdditionQuoteWS
                        .getLgsRouteAdditionQuoteByEnitty(request);

                quoteAddition = response.getEntity();

                if ((surchargeCase.getCost20gp() != null && surchargeCase
                        .getCost20gp().compareTo(new BigDecimal(0)) > 0)
                        || (surchargeCase.getCost40gp() != null && surchargeCase
                                .getCost40gp().compareTo(new BigDecimal(0)) > 0)
                        || (surchargeCase.getCost40hq() != null && surchargeCase
                                .getCost40hq().compareTo(new BigDecimal(0)) > 0)
                        || (surchargeCase.getNonContainerCost() != null && surchargeCase
                                .getNonContainerCost().compareTo(
                                        new BigDecimal(0)) > 0)) {
                    if (quoteAddition != null) {
                        // 销售价存储
                        BigDecimal addValue = quoteAddition
                                .getPortPriceAddValue();
                        BigDecimal addPercent = quoteAddition
                                .getPortPriceAddPercent();
                        BigDecimal disAddPer = quoteAddition
                                .getPortDiscountAddPercent();
                        surchargeCase = setAddationValue(surchargeCase,
                                addValue, disAddPer, addPercent);
                    } else {
                        // 没有加成操作,设置默认的销售价，折扣价
                        surchargeCase = fullDefaultPriceAndDiscount(surchargeCase);
                    }
                    surchargeCase.setDisabled(0);// 默认为0
                    surchargeCase.setQuoteType(QuoteType.PORT);// 默认QuoteType.PORT=2
                                                               // 本地费
                    // 放到集合中，一并入库
                    portQuoteInfoList.add(lgsPortEntity);
                    surchargeCaseList.add(surchargeCase);

                }

                LgsQuoteRequest lgsQuoteRequest = new LgsQuoteRequest();

                lgsQuoteRequest.setLgsPortEntityList(portQuoteInfoList); // 本地费基本信息
                lgsQuoteRequest
                        .setLgsFclQsurchargeEntityList(surchargeCaseList); // 本地费报价详情
                // 保存到数据库
                lgsQuoteImportServiceWS.importPortQuote(lgsQuoteRequest);
            }
        }
        return null;
    }

    // ========================= 附加费 =======================================

    /**
     * 将List<LgsAddationQuote4ExcelInfoEntity>内容保存到数据库
     * 
     * @param lgsAddationQuote4ExcelInfoEntityList
     * @param uploadDataErrorMap
     * @return
     */
    public String dealUploadSurchargeData4Addation(
            List<LgsAddationQuote4ExcelInfoEntity> lgsAddationQuote4ExcelInfoEntityList,
            Map<Integer, String> uploadDataErrorMap) {
        if (lgsAddationQuote4ExcelInfoEntityList != null
                && lgsAddationQuote4ExcelInfoEntityList.size() > 0) {

            for (LgsAddationQuote4ExcelInfoEntity lgsAddationQuote4ExcelInfoEntity : lgsAddationQuote4ExcelInfoEntityList) {
                // 附加费：表头
                LgsAddationQuoteInfoEntity addationEntity = new LgsAddationQuoteInfoEntity();
                // 报价明细
                LgsFclQsurchargeEntity surchargeCase = new LgsFclQsurchargeEntity();

                ReflexUtil.copyEntity(lgsAddationQuote4ExcelInfoEntity,
                        addationEntity);
                ReflexUtil.copyEntity(lgsAddationQuote4ExcelInfoEntity,
                        surchargeCase);

                // 海运费列表：表头
                List<LgsAddationQuoteInfoEntity> addationEntityList = new ArrayList<LgsAddationQuoteInfoEntity>();
                // 报价明细列表
                List<LgsFclQsurchargeEntity> surchargeCaseList = new ArrayList<LgsFclQsurchargeEntity>();

                // 目前:海整出口/海整进口
                if (1 == addationEntity.getImportExportFlag().intValue()) {// 出口
                    addationEntity.setProductId(1);// 出口海整=1
                } else {
                    addationEntity.setProductId(8);// 进口海整=8
                }

                LgsRouteAdditionQuoteEntity quoteAdditionEntityReq = new LgsRouteAdditionQuoteEntity();
                quoteAdditionEntityReq
                        .setRouteTypeId(lgsAddationQuote4ExcelInfoEntity
                                .getRouteTypeId());
                quoteAdditionEntityReq.setImportExportFlag(addationEntity
                        .getImportExportFlag()); // 出口
                quoteAdditionEntityReq.setTransportType(1); // 海运

                // 加成操作
                // 查找是否有按航线加成的记录 有的话 则同步增加销售价
                LgsRouteAdditionQuoteEntity quoteAddition = null;
                GetLgsRouteAdditionQuoteByEntityRequest request = new GetLgsRouteAdditionQuoteByEntityRequest();
                request.setEntity(quoteAdditionEntityReq);
                GetLgsRouteAdditionQuoteByEntityResponse response = lgsRouteAdditionQuoteWS
                        .getLgsRouteAdditionQuoteByEnitty(request);

                quoteAddition = response.getEntity();

                if ((surchargeCase.getCost20gp() != null && surchargeCase
                        .getCost20gp().compareTo(new BigDecimal(0)) > 0)
                        || (surchargeCase.getCost40gp() != null && surchargeCase
                                .getCost40gp().compareTo(new BigDecimal(0)) > 0)
                        || (surchargeCase.getCost40hq() != null && surchargeCase
                                .getCost40hq().compareTo(new BigDecimal(0)) > 0)
                        || (surchargeCase.getNonContainerCost() != null && surchargeCase
                                .getNonContainerCost().compareTo(
                                        new BigDecimal(0)) > 0)) {
                    if (quoteAddition != null) {
                        // 销售价存储
                        BigDecimal addValue = quoteAddition
                                .getAddationPriceAddValue();// 附加费销售价加成值
                        BigDecimal addPercent = quoteAddition
                                .getAddationPriceAddPercent();// 附加费销售价加成百分比
                        BigDecimal disAddPer = quoteAddition
                                .getAddationDiscountAddPercent();// 附加费折扣价加成百分比
                        // 加成操作
                        surchargeCase = setAddationValue(surchargeCase,
                                addValue, disAddPer, addPercent);
                    } else {
                        // 没有加成操作,设置默认的销售价，折扣价
                        surchargeCase = fullDefaultPriceAndDiscount(surchargeCase);
                    }
                    surchargeCase.setDisabled(0);// 默认为0
                    surchargeCase.setQuoteType(QuoteType.ADDATION);// 默认QuoteType.ADDATION=3附加费
                    // 放到集合中，一并入库
                    addationEntityList.add(addationEntity);
                    surchargeCaseList.add(surchargeCase);

                }

                LgsQuoteRequest lgsQuoteRequest = new LgsQuoteRequest();

                lgsQuoteRequest
                        .setLgsAddationQuoteInfoEntityList(addationEntityList); // 附加费基本信息
                lgsQuoteRequest
                        .setLgsFclQsurchargeEntityList(surchargeCaseList); // 附加费报价详情
                // 保存到数据库
                lgsQuoteImportServiceWS.importAddationQuote(lgsQuoteRequest);
            }
        }
        return null;
    }

    /**
     * 附加费
     * 
     * @param dataMap
     * @param uploadDataErrorMap
     * @return
     */
    public List<LgsAddationQuote4ExcelInfoEntity> dataMapConvertToLgsAddationQuote4ExcelInfo(
            Map<Integer, Map<String, String>> dataMap,
            Map<Integer, String> uploadDataErrorMap) {

        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        List<LgsAddationQuote4ExcelInfoEntity> lgsAddationQuote4ExcelInfoEntityList = new ArrayList<LgsAddationQuote4ExcelInfoEntity>();

        LgsAddationQuote4ExcelInfoEntity lgsAddationQuote4ExcelInfoEntity = null;
        Calendar calendar = Calendar.getInstance();
        calendar.set(Calendar.HOUR_OF_DAY, 0);
        calendar.set(Calendar.MINUTE, 0);
        calendar.set(Calendar.SECOND, 0);
        calendar.set(Calendar.MILLISECOND, 0);
        Date nowDate = calendar.getTime();
        for (Map.Entry<Integer, Map<String, String>> entryMaps : dataMap
                .entrySet()) {
            if (null == entryMaps) {
                continue;
            }
            // 行号
            Integer rowNum = entryMaps.getKey();
            // 报价excel中的列（列名称转成ID）对应的entity
            lgsAddationQuote4ExcelInfoEntity = new LgsAddationQuote4ExcelInfoEntity();

            StringBuffer retErrStr = new StringBuffer();
            Date execDate = null;
            Date expiryDate = null;

            // 遍历内容
            for (Map.Entry<String, String> entryMap : entryMaps.getValue()
                    .entrySet()) {
                if (null == entryMap) {
                    continue;
                }
                // 进出口
                if (IMPORTEXPORTFLAG.equals(entryMap.getKey().trim())) {
                    if (StringUtils.isEmpty(entryMap.getValue())) {
                        retErrStr.append("进出口错误;");
                    } else {
                        try {
                            if (null != entryMap.getValue()
                                    && ("出口".equals(entryMap.getValue()) || "E"
                                            .equals(entryMap.getValue()))) {
                                lgsAddationQuote4ExcelInfoEntity
                                        .setImportExportFlag(1);// 出口
                            } else if (null != entryMap.getValue()
                                    && ("进口".equals(entryMap.getValue()) || "I"
                                            .equals(entryMap.getValue()))) {
                                lgsAddationQuote4ExcelInfoEntity
                                        .setImportExportFlag(2);// 进口
                            } else {
                                retErrStr.append("进出口错误;");
                            }
                        } catch (Exception e) {
                            retErrStr.append("进出口错误;");
                            e.printStackTrace();
                        }
                    }
                }
                // 起运港
                else if (SHIPMENTPORTID.equals(entryMap.getKey().trim())) {
                    if (StringUtils.isEmpty(entryMap.getValue())) {
                        retErrStr.append("起运港错误;");
                    } else {
                        try {
                            // 港口英文名称->港口ID
                            Integer shipmentPortId = portcodeServiceWS
                                    .getPortIdByPortNameEn(entryMap.getValue());
                            if (null != shipmentPortId) {
                                lgsAddationQuote4ExcelInfoEntity
                                        .setShipmentPortId(shipmentPortId);
                            } else {
                                retErrStr.append("起运港错误;");
                            }
                        } catch (Exception e) {
                            retErrStr.append("起运港错误;");
                        }
                    }
                }
                // 船公司(英文)
                else if (AGENT.equals(entryMap.getKey().trim())) {
                    if (StringUtils.isEmpty(entryMap.getValue())) {
                        lgsAddationQuote4ExcelInfoEntity.setAgentId(-1);
                    } else {
                        try {
                            GetLogisticCampanyByTypeRequest req = new GetLogisticCampanyByTypeRequest();
                            HashMap<String, String> param = new HashMap<String, String>();
                            param.put("cusLogisticType", "01");// 01船公司，03货代公司
                            param.put("cusNameEn", entryMap.getValue());// 英文名称
                            req.setPara(param);
                            GetLogisticCampanyByTypeResponse getLogisticCampanyByTypeResponse = customerWS
                                    .getLogisticCampanyByTypeAndName(req);
                            List<CusCustomerEntity> customerEntityList = getLogisticCampanyByTypeResponse
                                    .getCustomerEntityList();
                            if (null != customerEntityList
                                    && customerEntityList.size() > 0) {
                                CusCustomerEntity cusCustomerEntity = customerEntityList
                                        .get(0);
                                lgsAddationQuote4ExcelInfoEntity
                                        .setAgentId(cusCustomerEntity.getId());
                            } else {
                                retErrStr.append("船公司错误;");
                            }
                        } catch (Exception e) {
                            retErrStr.append("船公司错误;");
                        }
                    }
                }
                // 航线名称
                else if (LINENAME.equals(entryMap.getKey().trim())) {
                    if (StringUtils.isEmpty(entryMap.getValue())) {
                        retErrStr.append("航线名称错误;");
                    } else {
                        try {
                            ShippinglineEntity shippinglineEntity = null;
                            // 根据航线名称获取航线ID
                            GetShippinglineByNameRequest request = new GetShippinglineByNameRequest();
                            request.setShippinglineName(entryMap.getValue());
                            GetShippinglineByNameResponse response = shippinglineServiceWS
                                    .getShippinglineByName(request);
                            List<ShippinglineEntity> entitys = response
                                    .getEntitys();
                            if (null != entitys && entitys.size() > 0) {
                                shippinglineEntity = entitys.get(0);
                            }
                            if (null != shippinglineEntity) {
                                lgsAddationQuote4ExcelInfoEntity
                                        .setRouteTypeId(shippinglineEntity
                                                .getId());
                            } else {
                                retErrStr.append("航线名称错误;");
                            }
                        } catch (Exception e) {
                            retErrStr.append("航线名称错误;");
                        }
                    }
                }
                // 费用名称
                else if (QUOTENAME.equals(entryMap.getKey().trim())) {
                    if (StringUtils.isEmpty(entryMap.getValue())) {
                        retErrStr.append("费用名称错误;");
                    } else {
                        try {
                            // prd_quote
                            PrdQuoteRequest request = new PrdQuoteRequest();
                            request.setName(entryMap.getValue());
							request.setOriginalId(11000150);
                            PrdQuoteResponse prdQuoteResponse = prdQuoteServiceWS
									.getPrdQuoteByNameAndOriginalid(request);
                            List<PrdQuoteEntity> prdQuoteEntitys = prdQuoteResponse
                                    .getPrdQuoteEntitys();
                            if (null != prdQuoteEntitys
                                    && prdQuoteEntitys.size() > 0) {
                                PrdQuoteEntity prdQuoteEntity = prdQuoteEntitys
                                        .get(0);
                                Integer prdQuoteId = prdQuoteEntity.getId();
                                lgsAddationQuote4ExcelInfoEntity
                                        .setPrdQuoteId(prdQuoteId);
                            } else {
                                retErrStr.append("费用名称错误;");
                            }
                        } catch (Exception e) {
                            retErrStr.append("费用名称错误;");
                            e.printStackTrace();
                        }
                    }
                }
                // 计价单位
                else if (COST_UNIT.equals(entryMap.getKey().trim())) {
                    if (null != entryMap.getValue()) {
                        // 计价单位不处理
                    }
                }
                // 每票单价(计价单位是票是，填写‘每票单价’)
                else if (NON_CONTAINER_COST.equals(entryMap.getKey().trim())) {

                }

                else if (COST20GP.equals(entryMap.getKey().trim())) {
                    if (null != entryMap.getValue()) {
                        try {
                            lgsAddationQuote4ExcelInfoEntity
                                    .setCost20gp(BigDecimal.valueOf(Double
                                            .valueOf(entryMap.getValue())));
                        } catch (Exception e) {
                            retErrStr.append("20GP价格错误;");
                            e.printStackTrace();
                        }
                    }
                } else if (COST40GP.equals(entryMap.getKey().trim())) {
                    if (null != entryMap.getValue()) {
                        try {
                            lgsAddationQuote4ExcelInfoEntity
                                    .setCost40gp(BigDecimal.valueOf(Double
                                            .valueOf(entryMap.getValue())));
                        } catch (Exception e) {
                            retErrStr.append("40GP价格错误;");
                            e.printStackTrace();
                        }
                    }
                } else if (COST40HQ.equals(entryMap.getKey().trim())) {
                    if (null != entryMap.getValue()) {
                        try {
                            lgsAddationQuote4ExcelInfoEntity
                                    .setCost40hq(BigDecimal.valueOf(Double
                                            .valueOf(entryMap.getValue())));
                        } catch (Exception e) {
                            retErrStr.append("40HQ价格错误;");
                            e.printStackTrace();
                        }
                    }
                }

                // 币种
                else if (CURRENCYNAME.equals(entryMap.getKey().trim())) {
                    // 抛弃，不存数据库
                }
                // 生效日期
                else if (EXECDATE.equals(entryMap.getKey().trim())) {
                    if (null == entryMap.getValue()
                            || "".equals(entryMap.getValue().trim())) {
                        retErrStr.append("生效时间必填;");
                    } else {
                        try {
                            execDate = format.parse(entryMap.getValue());
                        } catch (ParseException e) {
                            retErrStr.append("生效时间格式错误;");
                            e.printStackTrace();
                        }
                        if (null != execDate) {
                            if (nowDate.after(execDate)) {
                                retErrStr.append("生效时间小于当前时间;");
                            } else {
                                lgsAddationQuote4ExcelInfoEntity
                                        .setExecDate(execDate);
                            }
                            if (null != expiryDate) {
                                if (execDate.after(expiryDate)) {
                                    retErrStr.append("生效时间大于失效时间;");
                                }
                            }
                        }
                    }
                }
                // 失效日期
                else if (EXPIRYDATE.equals(entryMap.getKey().trim())) {
                    if (null == entryMap.getValue()
                            || "".equals(entryMap.getValue().trim())) {
                        retErrStr.append("失效时间必填;");
                    } else {
                        try {
                            expiryDate = format.parse(entryMap.getValue());
                        } catch (ParseException e) {
                            retErrStr.append("失效时间格式错误;");
                            e.printStackTrace();
                        }
                        if (null != expiryDate) {
                            lgsAddationQuote4ExcelInfoEntity
                                    .setExpiryDate(expiryDate);
                            if (null != execDate && execDate.after(expiryDate)) {
                                retErrStr.append("生效时间大于失效时间;");
                            }
                        }
                    }
                }
                // 备注
                else if (REMARKINFO.equals(entryMap.getKey().trim())) {
                    lgsAddationQuote4ExcelInfoEntity.setRemark(entryMap
                            .getValue());
                } else {
                    // System.out.println("该单元格的标题是"+entryMap.getKey()+"#");
                    // System.out.println("该单元格的内容是"+entryMap.getValue()+"#");

                    uploadDataErrorMap.put(0, "系统错误,导入的文件标题与模板不匹配");
                }

            }
            if (SunivoStringUtils.isEmpty(retErrStr.toString())) {

                // 对数据表头进行判重
                // 记录已经存在
                LgsAddationQuoteInfoEntity addation = new LgsAddationQuoteInfoEntity();

                addation.setAgentId(lgsAddationQuote4ExcelInfoEntity
                        .getAgentId());// 船公司ID
                addation.setShipmentPortId(lgsAddationQuote4ExcelInfoEntity
                        .getShipmentPortId());// 起运港ID
                addation.setRouteTypeId(lgsAddationQuote4ExcelInfoEntity
                        .getRouteTypeId());// 航线类型ID
                addation.setImportExportFlag(lgsAddationQuote4ExcelInfoEntity
                        .getImportExportFlag());// 进出口

                LgsFclQsurchargeEntity fclQentity = new LgsFclQsurchargeEntity();
                fclQentity.setPrdQuoteId(lgsAddationQuote4ExcelInfoEntity
                        .getPrdQuoteId());

                // 根据[起运港ID,航线类型ID,船公司ID,进出口,费用项]判断报价是否重复(检查DB中是否重复)
                // List<LgsAddationQuoteInfoEntity> ls =
                // lgsAddationQuoteInfoWS.getUniquePort(addation, fclQentity);
                ListLgsAddationQuoteInfoResponse listLgsAddationQuoteInfoResponse = lgsAddationQuoteInfoWS
                        .getUniqueQuote(addation, fclQentity);
                List<LgsAddationQuoteInfoVo> vos = listLgsAddationQuoteInfoResponse
                        .getObjectList();

                if (vos != null && vos.size() > 0) {
                    LgsAddationQuoteInfoVo vo = vos.get(0);

                    // LgsAddationQuoteInfoEntity oldAddation =
                    // vo.getAddationQuoteInfoEntity();
                    LgsFclQsurchargeEntity oldQuote = vo
                            .getFclQsurchargeEntity();

                    if (oldQuote != null) {
                        // "该条报价重复"
                        // retErrStr.append("该报价在数据库中已存在;");
                        // 将这条重复的报价设置为无效oldQuote.disabled=1，然后重新导入新的报价
                        DeleteLgsFclQsurchargeRequest request = new DeleteLgsFclQsurchargeRequest();
                        request.setId(oldQuote.getId());
                        lgsFclQsurchargeServiceWS.deleteById(request);
                    }
                }
                // 检查lgsAddationQuote4ExcelInfoEntityList中是否重复
                boolean isUnique = isUniqueAddationQuoteInList(
                        lgsAddationQuote4ExcelInfoEntityList,
                        lgsAddationQuote4ExcelInfoEntity);
                if (!isUnique) {
                    // "该条报价重复"
                    retErrStr.append("excel中存在重复报价;");
                }
            }
            int realRowNum = rowNum + 1;
            if (!SunivoStringUtils.isEmpty(retErrStr.toString())) {
                uploadDataErrorMap.put(realRowNum, retErrStr.toString());
            }
            if (null == uploadDataErrorMap.get(realRowNum)) {
                lgsAddationQuote4ExcelInfoEntityList
                        .add(lgsAddationQuote4ExcelInfoEntity);
            }
        }
        return lgsAddationQuote4ExcelInfoEntityList;
    }

    /**
     * 报价加成操作
     * 
     * @param surchargeCase
     * @param addValue
     *            销售价加成值
     * @param disAddPer
     *            折扣价加成百分比
     * @param addPercent
     *            销售价加成百分比
     * @return
     */
    private LgsFclQsurchargeEntity setAddationValue(
            LgsFclQsurchargeEntity surchargeCase, BigDecimal addValue,
            BigDecimal disAddPer, BigDecimal addPercent) {
        if (surchargeCase.getCost20gp() != null
                && surchargeCase.getCost20gp().compareTo(new BigDecimal(0)) > 0) {
            surchargeCase.setPrice20gp(surchargeCase.getCost20gp()
                    .multiply(addPercent).divide(new BigDecimal(100))
                    .add(addValue));
            surchargeCase.setDiscount20gp(surchargeCase.getPrice20gp()
                    .multiply(disAddPer).divide(new BigDecimal(100)));
        }
        if (surchargeCase.getCost40gp() != null
                && surchargeCase.getCost40gp().compareTo(new BigDecimal(0)) > 0) {
            surchargeCase.setPrice40gp(surchargeCase.getCost40gp()
                    .multiply(addPercent).divide(new BigDecimal(100))
                    .add(addValue));
            surchargeCase.setDiscount40gp(surchargeCase.getPrice40gp()
                    .multiply(disAddPer).divide(new BigDecimal(100)));
        }
        if (surchargeCase.getCost40hq() != null
                && surchargeCase.getCost40hq().compareTo(new BigDecimal(0)) > 0) {
            surchargeCase.setPrice40hq(surchargeCase.getCost40hq()
                    .multiply(addPercent).divide(new BigDecimal(100))
                    .add(addValue));
            surchargeCase.setDiscount40hq(surchargeCase.getPrice40hq()
                    .multiply(disAddPer).divide(new BigDecimal(100)));
        }
        if (surchargeCase.getNonContainerCost() != null
                && surchargeCase.getNonContainerCost().compareTo(
                        new BigDecimal(0)) > 0) {
            surchargeCase.setNonContainerPrice(surchargeCase
                    .getNonContainerCost().multiply(addPercent)
                    .divide(new BigDecimal(100)).add(addValue));
            surchargeCase.setNonContainerDiscount(surchargeCase
                    .getNonContainerPrice().multiply(disAddPer)
                    .divide(new BigDecimal(100)));
        }
        return surchargeCase;
    }

    /**
     * 设置默认销售价，折扣价与成本价相同
     * 
     * @param fclQsurchargeEntity
     */
    private LgsFclQsurchargeEntity fullDefaultPriceAndDiscount(
            LgsFclQsurchargeEntity fclQsurchargeEntity) {
        // 销售价
        fclQsurchargeEntity.setNonContainerPrice(fclQsurchargeEntity
                .getNonContainerCost());
        fclQsurchargeEntity.setPrice20gp(fclQsurchargeEntity.getCost20gp());
        fclQsurchargeEntity.setPrice40gp(fclQsurchargeEntity.getCost40gp());
        fclQsurchargeEntity.setPrice40hq(fclQsurchargeEntity.getCost40hq());
        // 折扣价
        fclQsurchargeEntity.setNonContainerDiscount(fclQsurchargeEntity
                .getNonContainerCost());
        fclQsurchargeEntity.setDiscount20gp(fclQsurchargeEntity.getCost20gp());
        fclQsurchargeEntity.setDiscount40gp(fclQsurchargeEntity.getCost40gp());
        fclQsurchargeEntity.setDiscount40hq(fclQsurchargeEntity.getCost40hq());
        return fclQsurchargeEntity;
    }

    /**
     * 判断list中是否存在重复报价(根据[起运港ID,航线类型ID,船公司ID,进出口，费用项]判断报价是否重复)
     * 
     * @param list
     * @param entity
     * @return
     */
    private boolean isUniqueAddationQuoteInList(
            List<LgsAddationQuote4ExcelInfoEntity> list,
            LgsAddationQuote4ExcelInfoEntity entity) {

        boolean flag = true;
        if (null != list && list.size() > 0 && null != entity) {
            int len = list.size();
            for (int i = 0; i < len; i++) {
                LgsAddationQuote4ExcelInfoEntity temp = list.get(i);
                // 根据[起运港ID,航线类型ID,船公司ID,进出口，费用项]判断报价是否重复
                if (temp != null && temp.getAgentId() != null
                        && temp.getRouteTypeId() != null
                        && temp.getShipmentPortId() != null
                        && temp.getImportExportFlag() != null
                        && temp.getPrdQuoteId() != null
                        && entity.getAgentId() != null
                        && entity.getRouteTypeId() != null
                        && entity.getShipmentPortId() != null
                        && entity.getImportExportFlag() != null
                        && entity.getPrdQuoteId() != null) {
                    // [起运港ID,航线类型ID,船公司ID,进出口，费用项]重复
                    if (temp.getAgentId().intValue() == entity.getAgentId()
                            .intValue()
                            && temp.getRouteTypeId().intValue() == entity
                                    .getRouteTypeId().intValue()
                            && temp.getShipmentPortId().intValue() == entity
                                    .getShipmentPortId().intValue()
                            && temp.getImportExportFlag().intValue() == entity
                                    .getImportExportFlag().intValue()
                            && temp.getPrdQuoteId().intValue() == entity
                                    .getPrdQuoteId().intValue()) {
                        flag = false;
                        break;
                    }
                }
            }
        }
        return flag;
    }

    /**
     * 判断list中是否存在重复报价(根据[起运港ID,航线类型ID,船公司ID,进出口，费用项]判断报价是否重复)
     * 
     * @param list
     * @param entity
     * @return
     */
    private boolean isUniquePortQuoteInList(
            List<LgsPortQuote4ExcelInfoEntity> list,
            LgsPortQuote4ExcelInfoEntity entity) {

        boolean flag = true;
        if (null != list && list.size() > 0 && null != entity) {
            int len = list.size();
            for (int i = 0; i < len; i++) {
                LgsPortQuote4ExcelInfoEntity temp = list.get(i);
                // 根据[起运港ID,航线类型ID,船公司ID,进出口，费用项]判断报价是否重复
                if (temp != null && temp.getAgentId() != null
                        && temp.getRouteTypeId() != null
                        && temp.getShipmentPortId() != null
                        && temp.getImportExportFlag() != null
                        && temp.getPrdQuoteId() != null

                        && entity.getAgentId() != null
                        && entity.getRouteTypeId() != null
                        && entity.getShipmentPortId() != null
                        && entity.getImportExportFlag() != null
                        && entity.getPrdQuoteId() != null) {

                    // [起运港ID,航线类型ID,船公司ID,进出口，费用项]重复
                    if (temp.getAgentId().intValue() == entity.getAgentId()
                            .intValue()
                            && temp.getRouteTypeId().intValue() == entity
                                    .getRouteTypeId().intValue()
                            && temp.getShipmentPortId().intValue() == entity
                                    .getShipmentPortId().intValue()
                            && temp.getImportExportFlag().intValue() == entity
                                    .getImportExportFlag().intValue()
                            && temp.getPrdQuoteId().intValue() == entity
                                    .getPrdQuoteId().intValue()) {
                        flag = false;
                        break;
                    }
                }
            }
        }
        return flag;
    }

    /**
     * 判断list中是否存在重复报价(根据[货代ID,起运港ID,目的港ID,航线类型ID,船公司ID,进出口，费用项]判断报价是否重复)
     * 
     * @param list
     * @param entity
     * @return
     */
    private boolean isUniqueFclQuoteInList(
            List<LgsFclQuote4ExcelInfoEntity> list,
            LgsFclQuote4ExcelInfoEntity entity) {

        boolean flag = true;
        if (null != list && list.size() > 0 && null != entity) {
            int len = list.size();
            for (int i = 0; i < len; i++) {
                LgsFclQuote4ExcelInfoEntity temp = list.get(i);
                // 根据[货代ID,起运港ID,目的港ID,航线类型ID,船公司ID]判断报价是否重复
                if (temp != null && temp.getDestinationPortId() != null
                        && temp.getCarrierId() != null
                        && temp.getImportExportFlag() != null
                        && temp.getAgentId() != null
                        && temp.getRouteTypeId() != null
                        && temp.getShipmentPortId() != null
                        && temp.getPrdQuoteId() != null

                        && entity.getDestinationPortId() != null
                        && entity.getCarrierId() != null
                        && entity.getImportExportFlag() != null
                        && entity.getAgentId() != null
                        && entity.getRouteTypeId() != null
                        && entity.getShipmentPortId() != null
                        && entity.getPrdQuoteId() != null) {

                    // [货代ID,起运港ID,目的港ID,航线类型ID,船公司ID,进出口，费用项]重复
                    if (temp.getAgentId().intValue() == entity.getAgentId()
                            .intValue()
                            && temp.getDestinationPortId().intValue() == entity
                                    .getDestinationPortId().intValue()
                            && temp.getCarrierId().intValue() == entity
                                    .getCarrierId().intValue()
                            && temp.getRouteTypeId().intValue() == entity
                                    .getRouteTypeId().intValue()
                            && temp.getShipmentPortId().intValue() == entity
                                    .getShipmentPortId().intValue()
                            && temp.getImportExportFlag().intValue() == entity
                                    .getImportExportFlag().intValue()
                            && temp.getPrdQuoteId().intValue() == entity
                                    .getPrdQuoteId().intValue()) {
                        flag = false;
                        break;
                    }
                }
            }
        }
        return flag;
    }

    /**
     * 判断费用类型是'海运费'
     * 
     * @param quote_type
     * @return 是'海运费'true，不是'海运费'false
     */
    public boolean isFclQuote(Integer quote_type) {
        boolean flag = false;
        if (QuoteType.FCL.getId() == quote_type.intValue()) {
            flag = true;
        }
        return flag;
    }

    /**
     * 判断费用类型是'本地费'
     * 
     * @param quote_type
     * @return 是'本地费'true，不是'本地费'false
     */
    public boolean isPortQuote(Integer quote_type) {
        boolean flag = false;
        if (QuoteType.PORT.getId() == quote_type.intValue()) {
            flag = true;
        }
        return flag;
    }

    /**
     * 判断费用类型是'附加费'
     * 
     * @param quote_type
     * @return 是'附加费'true，不是'附加费'false
     */
    public boolean isAddationQuote(Integer quote_type) {
        boolean flag = false;
        if (QuoteType.ADDATION.getId() == quote_type.intValue()) {
            flag = true;
        }
        return flag;
    }

    /**
     * 报价导入的常量定义
     */
    private static final String IMPORTEXPORTFLAG = "进出口";
    private static final String AGENT = "船公司";
    private static final String SHIPMENTPORTID = "起运港";
    private static final String DESTINATIONPORTID = "目的港";
    private static final String LINENAME = "航线名称";
    private static final String SHIPCOMPANY = "货代公司";
    private static final String QUOTENAME = "费用名称";
    private static final String COST20GP = "20'GP单价";
    private static final String COST40GP = "40'GP单价";
    private static final String COST40HQ = "40HQ单价";
    private static final String CURRENCYNAME = "币种";
    private static final String ESTIMATEDRANGE = "航程";
    private static final String ESTIMATEDSALINGDATE = "班期";
    private static final String ISENTERPORT = "是否中转";
    private static final String ENTERPORTID = "中转港";
    private static final String EXECDATE = "生效日期";
    private static final String EXPIRYDATE = "失效日期";
    private static final String ALLIN = "是否All-in";
    private static final String REMARKINFO = "备注";
    // 本地费
    private static final String NON_CONTAINER_COST = "每票单价";
    private static final String COST_UNIT = "计价单位";

}
