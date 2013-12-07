/**
 * Description: 询价控制器
 * Copyright:   Copyright (c)2013
 * Company:     SUNIVO
 * @author: wanglei
 * @version: 1.0
 * Create at:   2013-10-29 
 *
 * Modification History:
 * Date         Author      Version     Description
 * ------------------------------------------------------------------
 * 2013-10-29   lgs         1.0         add
 */
package com.sunivo.lgs.web.controller.lgs;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springside.modules.web.Servlets;

import com.sunivo.base.Page;
import com.sunivo.crm.beans.bo.CustomerInfoExt;
import com.sunivo.lgs.beans.entity.LgsInquiryEntity;
import com.sunivo.lgs.beans.vo.LgsInquiryVo;
import com.sunivo.lgs.beans.vo.UpdateAgencyForInquiryVo;
import com.sunivo.lgs.web.base.controller.BaseController;
import com.sunivo.ws.SunivoRequest;
import com.sunivo.ws.SunivoResponse;
import com.sunivo.ws.SunivoSearchRequest;
import com.sunivo.ws.SunivoSearchResponse;
import com.sunivo.ws.beans.request.crm.QueryCustomerInfoRequest;
import com.sunivo.ws.beans.response.crm.QueryCustomerInfoResponse;
import com.sunivo.ws.interfaces.server.crm.ICustomer;
import com.sunivo.ws.interfaces.server.lgs.ILgsInquiryServiceWS;
import com.sunivo.ws.interfaces.server.som.IOrdInfoServiceWS;

@Controller
@RequestMapping("/lgsinquiry")
public class LgsInquiryController extends BaseController {
	private static final Logger logger = Logger
			.getLogger(LgsInquiryController.class);
	@Autowired
	private ILgsInquiryServiceWS lgsInquiryServiceWS;
	
	@Autowired
	private IOrdInfoServiceWS ordInfoServiceWS;
	
	@Autowired
	private ICustomer customer;

	/**
	 * @param request
	 * @return
	 */
	@RequestMapping(value = {"inquiryList","toSelect", "select", ""}, method = RequestMethod.GET)
	/* public String listSample(HttpServletRequest request) { */
	public String inquiryList(Integer number, Model model,
			HttpServletRequest request) {
		// 组装查询条件
		// 声明检索请求对象SunivoSearchRequest
		SunivoSearchRequest sunivoSearchRequest = new SunivoSearchRequest();
		String inquiryStatusStr = request.getParameter("inquiryStatusStr");
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("inquiryStatusStr", inquiryStatusStr);
		Map<String, Object> searchParams = Servlets.getParametersStartingWith(
				request, "search_");
		Page page = new Page();
		if (null != number) {
			page.setCurrentPage(number);
		}
		
		sunivoSearchRequest.setPaging(page);
		sunivoSearchRequest.setSearchParams(searchParams);
		sunivoSearchRequest.setOrderColumn("createDatetime");
		sunivoSearchRequest.setOrderMode("desc");
		sunivoSearchRequest.setParamMap(paramMap);
		
		// 调用hession接口
		SunivoSearchResponse<LgsInquiryVo> searchResponse = lgsInquiryServiceWS
				.selectLgsInquiry(sunivoSearchRequest);
		request.setAttribute("objectList", searchResponse.getObjectList());
		request.setAttribute("inquiryStatusStr", inquiryStatusStr);
		request.setAttribute("page", searchResponse.getPaging());
		request.setAttribute("searchParams", searchParams);
		
		return getAutoUrl();
	}

	/**
	 * 分配供应商页面
	 * 
	 * @author yinfulei 20130625
	 * @param inquiryIdStr
	 * @param number
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "assignAgentSection", method = { RequestMethod.POST })
	public String assignAgentSection(String inquiryIdStr, Integer number,
			Model model, HttpServletRequest request) {
		try {
			// 询单ID 分配供应商必备
			request.setAttribute("inquiryIdStr", inquiryIdStr);
		} catch (Exception ex) {
			// 如果是业务异常直接抛出
			addErrorMessage(model, "分配失败：" + ex.getMessage());
		}
		return getAutoUrl();
	}
	
	
	/**
	 * 供应商选择页面
	 * 
	 * @author nirui 2013-11-05
	 * @param inquiryIdStr
	 * @param number
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "selectAgentSection", method = { RequestMethod.POST })
	public String selectAgentSection(String inquiryIdStr, Integer number,
			Model model, HttpServletRequest request) {
		try {
			// 获取查询条件
			String cusName = request.getParameter("search_cusName");
			if (null != cusName)
			{
				cusName = java.net.URLDecoder.decode(cusName,"UTF-8");
			}
			Page page = new Page();
			if (null != number) {
				page.setCurrentPage(number);
			}
			/*
			request.setAttribute("page", page);
			QueryParams<CustomerInfoExt> queryParams = new QueryParams<CustomerInfoExt>();
			queryParams.setPaging(page);
			CustomerInfoExt customerInfo = new CustomerInfoExt();
			customerInfo.setRoleType("04");
			List<CustomerInfoExt> customerList = new ArrayList<CustomerInfoExt>();
			if(StringUtils.isNotEmpty(cusName)){
				customerInfo.setCusName(cusName);
			}
			queryParams.setEntity(customerInfo);
			customerList = cusCustomerService.queryCustomerInfo(queryParams, "04");
			request.setAttribute("customerList", customerList);*/

			// 询单ID 分配供应商必备,设置入参
			QueryCustomerInfoRequest queryRequest= new QueryCustomerInfoRequest();
			queryRequest.setPaging(page);
			CustomerInfoExt customerInfo = new CustomerInfoExt();
			customerInfo.setRoleType("04");
			if(StringUtils.isNotEmpty(cusName)){
				customerInfo.setCusName(cusName);
			}
			queryRequest.setEntity(customerInfo);
			queryRequest.setCustomerType("04");
			
			//方法调用
			QueryCustomerInfoResponse queryResponse = customer.queryCustomerInfo(queryRequest);
			
			//设置返回到页面的数据
			request.setAttribute("page", queryResponse.getPaging());
			request.setAttribute("customerList", queryResponse.getObjectList());
			request.setAttribute("search_cusName", cusName);
			request.setAttribute("inquiryIdStr", inquiryIdStr);
		} catch (Exception ex) {
			// 如果是业务异常直接抛出
			logger.error("查询供应商出错！");
		}
		return getAutoUrl();
	}
	
	
	/**
	 * 处理询单的供应商分配动作
	 * 
	 * @param lgsInquiryVo
	 *            询价页面表单对象
	 * @param page
	 *            分页配置
	 * @param request
	 *            请求对象
	 * @return 结果视图
	 */
	@RequestMapping(value = "updateagency", method = { RequestMethod.POST })
	public String updateAgencyForinquiry(
			UpdateAgencyForInquiryVo updateAgencyVo,
			BindingResult result, Page page, HttpServletRequest request) {
		/*subValidation(result, updateAgencyVo);*/
		try {

			// 分配完供应商之后，询单即进入询价中的状态
			updateAgencyVo.setInquiryStatus(2);
			//lgsInquiryService.updateAgencyForInquiry(updateAgencyVo);
			SunivoRequest sunivoRequest = new SunivoRequest();
			sunivoRequest.getParamMap().put("updateAgencyVo", updateAgencyVo);
			lgsInquiryServiceWS.updateAgencyForInquiry(sunivoRequest);
			
			//这边的返回值貌似没什么作用
			//SunivoResponse sunivoResponse
			
		} catch (Exception ex) {
			// 如果是业务异常直接抛出
			logger.error("查询供应商出错！");
		}
		return "redirect:/lgsinquiry/";
	}
	
	
	/**
	 * 询单详情
	 * 
	 * @param lgsInquiryVo
	 *            询价页面表单对象
	 * @param page
	 *            分页配置
	 * @param request
	 *            请求对象
	 * @return 结果视图
	 */
	@RequestMapping(value = "detail", method = { RequestMethod.GET })
	public String detail(Integer id, HttpServletRequest request) {
		try{
			//LgsInquiryEntity entity = new LgsInquiryEntity();
			// 如果VO存在
			if(null != id){
				SunivoRequest sunivoRequest = new SunivoRequest();
				sunivoRequest.getParamMap().put("id", id);
				SunivoResponse SunivoResponse = lgsInquiryServiceWS.getById(sunivoRequest);
				LgsInquiryEntity entity = (LgsInquiryEntity)SunivoResponse.getResultMap().get("entity");
				request.setAttribute("lgsInquiryEntity", entity);
			}
		}
		catch(Exception ex) {
			logger.error(ex);
			logger.error("查询供应商出错！");
		}
		return getAutoUrl();
	}
	
	
	/**
	 * 询单详情
	 * 
	 * @param lgsInquiryVo
	 *            询价页面表单对象
	 * @param page
	 *            分页配置
	 * @param request
	 *            请求对象
	 * @return 结果视图
	 */
	@RequestMapping(value = "ordDetailViewSection", method = { RequestMethod.POST })
	public String ordDetailViewSection(Integer id, Model model,
			HttpServletRequest request) {
		
		try {
			String inquiryIdStr = request.getParameter("inquiryId");
			SunivoRequest sunivoRequest = new SunivoRequest();
			sunivoRequest.getParamMap().put("id", id);
			sunivoRequest.getParamMap().put("inquiryId", inquiryIdStr);
			SunivoResponse SunivoResponse = lgsInquiryServiceWS.ordDetailViewSection(sunivoRequest);
			request.setAttribute("resultMap", SunivoResponse.getResultMap());
			
			/*Map map =SunivoResponse.getResultMap();
			List<OrdFclBoxQuantityEntity> ordFclBoxQuantityEntity = (List<OrdFclBoxQuantityEntity>)map.get("fclTSED01LO0120130604I001");
			Map map1 = null;*/
		} 
		catch(Exception ex) {
			logger.error(ex);
			logger.error("询单详情-订单模块处！");
		}
		return getAutoUrl();
	}
	
	
	/**
	 * 处理选定供应商报价单的动作 选定报价后 要将信息同步到订单
	 * 
	 * @param lgsInquiry
	 *            询价实体对象
	 * @param page
	 *            分页配置
	 * @param request
	 *            请求对象
	 * @return 结果视图
	 * 
	 */
	@RequestMapping(value = "selectQuoteSection", method = {
			RequestMethod.POST })
	public String selectQuoteSection(LgsInquiryEntity lgsInquiry,
			BindingResult result, Page page, HttpServletRequest request) {
		try {
			String quoteIdStr = request.getParameter("id");
			String inquiryStatusStr = request.getParameter("inquiryStatus");
			String inquiryIdStr = request.getParameter("inquiryId");
			
			SunivoRequest sunivoRequest = new SunivoRequest();
			sunivoRequest.getParamMap().put("id", quoteIdStr);
			sunivoRequest.getParamMap().put("inquiryStatus", inquiryStatusStr);
			sunivoRequest.getParamMap().put("inquiryId", inquiryIdStr);
			sunivoRequest.getParamMap().put("lgsInquiry", lgsInquiry);
			
			SunivoResponse SunivoResponse = lgsInquiryServiceWS.selectQuoteSection(sunivoRequest);
			//request.setAttribute("resultMap", SunivoResponse.getResultMap());
		} catch(Exception ex) {
			logger.error(ex);
			logger.error("选定报价controlller业务报错！");
		}
		return getAutoUrl();
	}



}
