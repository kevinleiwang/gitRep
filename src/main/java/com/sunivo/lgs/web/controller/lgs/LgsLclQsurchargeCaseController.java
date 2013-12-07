/**
 * Description: 海运拼箱报价费用信息控制器
 * Copyright:   Copyright (c)2013
 * Company:     SUNIVO
 * @author:     bpoCoder
 * @version:    1.0
 * Create at:   2013-06-27 下午 14:38:08
 *  
 * Modification History:
 * Date         Author      Version     Description
 * ------------------------------------------------------------------
 * 2012-12-21   bpoCoder   1.0         Initial
 */
package com.sunivo.lgs.web.controller.lgs;


import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.sunivo.base.Page;
import com.sunivo.lgs.beans.vo.LgsLclQsurchargeCaseAddVo;
import com.sunivo.lgs.web.base.annotation.bind.BusinessDesc;
import com.sunivo.lgs.web.base.controller.BaseController;
import com.sunivo.ws.SunivoRequest;
import com.sunivo.ws.SunivoResponse;
import com.sunivo.ws.SunivoSearchRequest;
import com.sunivo.ws.SunivoSearchResponse;
import com.sunivo.ws.interfaces.server.lgs.ILgsLclQsurchargeCaseServiceWS;
import com.sunivo.ws.interfaces.server.lgs.ILgsLclQuoteInfoServiceWS;


/**
 * 海运拼箱报价费用信息控制器<br>
 * 
 * @author bpoCoder
 * @version 1.0, 2013-06-27
 * @see
 * @since 1.0
 */
@Controller
@RequestMapping("/lgslclqsurchargecase")
public class LgsLclQsurchargeCaseController extends BaseController {
	/**
	 * 海运拼箱报价费用信息模块
	 */
	private final static String MODULE_DES = "海运拼箱报价费用信息模块";

	
	private static final String LGSLCLQSURCHARGECASE_SURCHARGE = "查询海运拼箱实盘报价附加费信息";

	@Autowired
	private ILgsLclQuoteInfoServiceWS lgsLclQuoteInfoServiceWS;
	
	@Autowired
	private ILgsLclQsurchargeCaseServiceWS lgsLclQsurchargeCaseServiceWS;




	/**
	 * 查询海运拼箱实盘报价信息
	 * 
	 * @param lgsFclQuoteInfoCaseVo
	 *            海运拼箱实盘报价信息页面表单对象
	 * @param page
	 *            分页配置
	 * @param request
	 *            请求对象
	 * @return 结果视图
	 */
	@RequestMapping(value = "surchargeaddSection", method = { RequestMethod.GET ,RequestMethod.POST})
	@BusinessDesc(ModuleDesc = MODULE_DES, MethodDesc = LGSLCLQSURCHARGECASE_SURCHARGE)
	public String surchargeaddSection(Integer quoteId,
			HttpServletRequest request) {
		try {
			SunivoRequest sunivoRequest = new SunivoRequest();
			sunivoRequest.getParamMap().put("quoteId", quoteId);
			SunivoResponse sunivoResponse = lgsLclQsurchargeCaseServiceWS.surchargeaddSection(sunivoRequest);
			
			request.setAttribute("quoteId",quoteId);
			request.setAttribute("prdQuoteList", sunivoResponse.getResultMap().get("prdQuoteList"));		
		} catch (Exception ex) {
			// 如果是业务异常直接抛出
			logger.error(ex);
			logger.error("拼箱添加附加费Controller报错！");
		}
		return getAutoUrl();
	}
	
	
	
	/**
	 * 查询海运拼箱实盘报价信息
	 * 
	 * @param lgsFclQuoteInfoCaseVo
	 *            海运拼箱实盘报价信息页面表单对象
	 * @param page
	 *            分页配置
	 * @param request
	 *            请求对象
	 * @return 结果视图
	 */
	@RequestMapping(value = "surchargeviewSection", method = { RequestMethod.POST })
	/*@BusinessDesc(ModuleDesc = MODULE_DES, MethodDesc = LGSFCLQSURCHARGECASE_SURCHARGE)*/
	public String surchargeviewSection(Integer quoteId,
			HttpServletRequest request) {
		try {
			
			SunivoSearchRequest sunivoSearchRequest = new SunivoSearchRequest();
			sunivoSearchRequest.getParamMap().put("quoteId", quoteId);
			SunivoSearchResponse sunivoSearchResponse = lgsLclQsurchargeCaseServiceWS.surchargeviewSection(sunivoSearchRequest);
			
			request.setAttribute("quoteInfoCaseSubVoList", sunivoSearchResponse.getResultMap().get("quoteInfoCaseSubVoList"));
		} catch (Exception ex) {
			// 如果是业务异常直接抛出
			logger.error(ex);
			logger.error("查询附加费出错！");
		}
		return getAutoUrl();
	}
	
	/**
	 * 新增LSM_海运拼箱实盘报价费用信息
	 * 
	 * @param lgsFclQsurchargeCaseVo
	 *            LSM_海运拼箱实盘报价费用信息页面表单对象
	 * @param result
	 *            表单验证数据
	 * @param page
	 *            分页配置
	 * @param request
	 *            请求对象
	 * @return 结果视图
	 */
	@RequestMapping(value = "addListSection", method = { RequestMethod.POST })
	/*@BusinessDesc(ModuleDesc = MODULE_DES, MethodDesc = LGSFCLQSURCHARGECASE_ADD)*/
	public String addListSection(
			LgsLclQsurchargeCaseAddVo lgsLclQsurchargeCaseAddVo,
			BindingResult result, Page page, HttpServletRequest request) {
		
		SunivoRequest sunivoRequest = new SunivoRequest();
		Map paramMap = sunivoRequest.getParamMap();
		
		//设置入参
		paramMap.put("LgsLclQsurchargeCaseAddVo", lgsLclQsurchargeCaseAddVo);
		paramMap.put("carrier", request.getParameter("carrier"));
		//paramMap.put("estimatedRange", request.getParameter("estimatedRange"));
		paramMap.put("expiryDate", request.getParameter("expiryDate"));
		//paramMap.put("estimatedSalingdateValues", request.getParameterValues("estimatedSalingdateValues"));
		
		SunivoResponse sunivoResponse = lgsLclQsurchargeCaseServiceWS.addListSection(sunivoRequest);
		Integer inquiryId = (Integer)sunivoResponse.getResultMap().get("inquiryId");
		
		return "redirect:/lgsinquiry/detail?id=" + inquiryId;
	}


}
