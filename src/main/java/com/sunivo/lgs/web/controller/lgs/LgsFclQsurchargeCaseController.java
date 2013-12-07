/**
 * Description: LSM_海运整箱实盘报价费用信息控制器
 * Copyright:   Copyright (c)2013
 * Company:     SUNIVO
 * @author:     bpoCoder
 * @version:    1.0
 * Create at:   2013-06-14 下午 15:02:44
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
import com.sunivo.lgs.beans.vo.LgsFclQsurchargeCaseAddVo;
import com.sunivo.lgs.web.base.annotation.bind.BusinessDesc;
import com.sunivo.lgs.web.base.controller.BaseController;
import com.sunivo.ws.SunivoRequest;
import com.sunivo.ws.SunivoResponse;
import com.sunivo.ws.SunivoSearchRequest;
import com.sunivo.ws.SunivoSearchResponse;
import com.sunivo.ws.interfaces.server.lgs.ILgsFclQsurchargeCaseServiceWS;

/**
 * LSM_海运整箱实盘报价费用信息控制器<br>
 * 
 * @author bpoCoder
 * @version 1.0, 2013-06-14
 * @see
 * @since 1.0
 */
// @NeedLogin如果需要登录请添加
@Controller
@RequestMapping("/lgsfclqsurchargecase")
public class LgsFclQsurchargeCaseController extends BaseController {
	/**
	 * LSM_海运整箱实盘报价费用信息模块
	 */
	private final static String MODULE_DES = "LSM_海运整箱实盘报价费用信息模块";

	/**
	 * 去新增LSM_海运整箱实盘报价费用信息
	 */
	private final static String LGSFCLQSURCHARGECASE_TO_ADD = "去新增LSM_海运整箱实盘报价费用信息";

	/**
	 * 新增LSM_海运整箱实盘报价费用信息
	 */
	private final static String LGSFCLQSURCHARGECASE_ADD = "新增LSM_海运整箱实盘报价费用信息";

	/**
	 * 删除LSM_海运整箱实盘报价费用信息
	 */
	private final static String LGSFCLQSURCHARGECASE_DELETE = "删除LSM_海运整箱实盘报价费用信息";

	/**
	 * 去修改LSM_海运整箱实盘报价费用信息
	 */
	private final static String LGSFCLQSURCHARGECASE_TO_UPDATE = "去修改LSM_海运整箱实盘报价费用信息";

	/**
	 * 修改LSM_海运整箱实盘报价费用信息
	 */
	private final static String LGSFCLQSURCHARGECASE_UPDATE = "修改LSM_海运整箱实盘报价费用信息";

	/**
	 * 查询LSM_海运整箱实盘报价费用信息
	 */
	private final static String LGSFCLQSURCHARGECASE_SELECT = "查询LSM_海运整箱实盘报价费用信息";

	private static final String LGSFCLQSURCHARGECASE_SURCHARGE = "查询海运整箱实盘报价附加费信息";

	/**
	 * 自动注入LSM_海运整箱实盘报价费用信息业务层实现
	 */
	@Autowired
	private ILgsFclQsurchargeCaseServiceWS lgsFclQsurchargeCaseServiceWS;


	/**
	 * 去新增LSM_海运整箱实盘报价费用信息
	 * 
	 * @return 结果视图
	 */
	@RequestMapping(value = "toAdd", method = { RequestMethod.GET})
	@BusinessDesc(ModuleDesc = MODULE_DES, MethodDesc = LGSFCLQSURCHARGECASE_TO_ADD)
	public String add(){
		return getAutoUrl();
	}

	/**
	 * 新增LSM_海运整箱实盘报价费用信息
	 * 
	 * @param lgsFclQsurchargeCaseVo
	 *            LSM_海运整箱实盘报价费用信息页面表单对象
	 * @param result
	 *            表单验证数据
	 * @param page
	 *            分页配置
	 * @param request
	 *            请求对象
	 * @return 结果视图
	 */
	/*@RequestMapping(value = "add", method = { RequestMethod.POST})
	@BusinessDesc(ModuleDesc = MODULE_DES, MethodDesc = LGSFCLQSURCHARGECASE_ADD)
	public String addLgsFclQsurchargeCase(
			LgsFclQsurchargeCaseAddVo lgsFclQsurchargeCaseAddVo,
			BindingResult result, Page page, HttpServletRequest request) {
		if (lgsFclQsurchargeCaseAddVo != null) {
			List<LgsFclQsurchargeCaseEntity> entityList = lgsFclQsurchargeCaseAddVo
					.getEntities();
			if(entityList != null && entityList.size()>0) {
				for (int i = 0; i < entityList.size(); i++) {

				// subValidation(result, lgsFclQsurchargeCaseVo.getEntity());
					// 表单验证无误,进行提交
				if (result.hasErrors()) {
					return add();
				} else {
					try {
							// 返回保存对象的自增ID,这里不做处理
							lgsFclQsurchargeCaseService.save(entityList.get(i));
					} catch (Exception ex) {
							// 如果是业务异常直接抛出
						if (ex instanceof BusinessException) {
							throw (BusinessException) ex;
						}
							// 如果不是业务异常则构造业务异常
						else {
								throw new BusinessException("业务异常:",
										new Throwable(
									ex.getMessage()));
						}
					}
				}
			}
			}
		}
		return getAutoUrl();
	}*/

	/**
	 * 新增LSM_海运整箱实盘报价费用信息
	 * 
	 * @param lgsFclQsurchargeCaseVo
	 *            LSM_海运整箱实盘报价费用信息页面表单对象
	 * @param result
	 *            表单验证数据
	 * @param page
	 *            分页配置
	 * @param request
	 *            请求对象
	 * @return 结果视图
	 */
	@RequestMapping(value = "addListSection", method = { RequestMethod.POST })
	@BusinessDesc(ModuleDesc = MODULE_DES, MethodDesc = LGSFCLQSURCHARGECASE_ADD)
	public String addListSection(
			LgsFclQsurchargeCaseAddVo lgsFclQsurchargeCaseAddVo,
			 Page page, HttpServletRequest request) {
		
		SunivoRequest sunivoRequest = new SunivoRequest();
		Map paramMap = sunivoRequest.getParamMap();
		
		//设置入参
		paramMap.put("lgsFclQsurchargeCaseAddVo", lgsFclQsurchargeCaseAddVo);
		paramMap.put("carrier", request.getParameter("carrier"));
		paramMap.put("estimatedRange", request.getParameter("estimatedRange"));
		paramMap.put("expiryDate", request.getParameter("expiryDate"));
		paramMap.put("estimatedSalingdateValues", request.getParameterValues("estimatedSalingdateValues"));
		paramMap.put("lineTypeId", request.getParameter("lineTypeId"));
		
		
		SunivoResponse sunivoResponse = lgsFclQsurchargeCaseServiceWS.addListSection(sunivoRequest);
		Integer inquiryId = (Integer)sunivoResponse.getResultMap().get("inquiryId");
		
		return "redirect:/lgsinquiry/detail?id=" + inquiryId;
		//return "redirect:/lgsinquiry/detail?id=47";
	}
	

	/**
	 * 删除LSM_海运整箱实盘报价费用信息
	 * 
	 * @param id
	 *            LSM_海运整箱实盘报价费用信息页面表单对象唯一标识
	 * @param page
	 *            分页配置
	 * @param request
	 *            请求对象
	 * @return 结果视图
	 */
	/*@RequestMapping(value = "delete", method = { RequestMethod.GET })
	@BusinessDesc(ModuleDesc = MODULE_DES, MethodDesc = LGSFCLQSURCHARGECASE_DELETE)
	public String deleteLgsFclQsurchargeCase(Integer id, Page page, HttpServletRequest request){
		try{
			if(null != id){
			    lgsFclQsurchargeCaseService.delete(id);
			}
		}
		catch(Exception ex){
			// 如果是业务异常直接抛出
			if(ex instanceof BusinessException){
				throw (BusinessException) ex;
			}
			// 如果不是业务异常则构造业务异常
			else{
				throw new BusinessException("业务异常:", new Throwable(
						ex.getMessage()));
			}
		}
		return select(null, page, request);
	}*/

	/**
	 * 去修改LSM_海运整箱实盘报价费用信息
	 * 
	 * @param id
	 *            LSM_海运整箱实盘报价费用信息页面表单对象唯一标识
	 * @param request
	 *            请求对象
	 * @return 结果视图
	 */
	/*@RequestMapping(value = "toUpdate", method = { RequestMethod.GET})
	@BusinessDesc(ModuleDesc = MODULE_DES, MethodDesc = LGSFCLQSURCHARGECASE_TO_UPDATE)
	public String update(Integer id, HttpServletRequest request){
		try{
			if(null != id){
				LgsFclQsurchargeCaseEntity lgsFclQsurchargeCaseEntity = lgsFclQsurchargeCaseService.getById(id);
				request.setAttribute("lgsFclQsurchargeCaseEntity", lgsFclQsurchargeCaseEntity);
			}
		}
		catch(Exception ex){
			// 如果是业务异常直接抛出
			if(ex instanceof BusinessException){
				throw (BusinessException) ex;
			}
			// 如果不是业务异常则构造业务异常
			else{
				throw new BusinessException("业务异常:", new Throwable(
						ex.getMessage()));
			}
		}
		return getAutoUrl();
	}*/

	/**
	 * 修改LSM_海运整箱实盘报价费用信息
	 * 
	 * @param lgsFclQsurchargeCaseVo
	 *            LSM_海运整箱实盘报价费用信息页面表单对象
	 * @param result
	 *            表单验证数据
	 * @param page
	 *            分页配置
	 * @param request
	 *            请求对象
	 * @return 结果视图
	 */
	/*@RequestMapping(value = "update", method = {
			RequestMethod.POST })
	@BusinessDesc(ModuleDesc = MODULE_DES, MethodDesc = LGSFCLQSURCHARGECASE_UPDATE)
	public String updateLgsFclQsurchargeCase(@Valid LgsFclQsurchargeCaseVo lgsFclQsurchargeCaseVo, BindingResult result, Page page, HttpServletRequest request){
		subValidation(result, lgsFclQsurchargeCaseVo.getEntity());
		// 表单验证无误,进行提交
		if (result.hasErrors()) {
			return update(lgsFclQsurchargeCaseVo.getEntity().getId(), request);
		} else {
			try{
				lgsFclQsurchargeCaseService.update(lgsFclQsurchargeCaseVo.getEntity());
			}
			catch(Exception ex){
				// 如果是业务异常直接抛出
				if(ex instanceof BusinessException){
					throw (BusinessException) ex;
				}
				// 如果不是业务异常则构造业务异常
				else{
					throw new BusinessException("业务异常:", new Throwable(
							ex.getMessage()));
				}
			}
		}
		return select(null, page, request);
	}*/

	/**
	 * 查询LSM_海运整箱实盘报价费用信息
	 * 
	 * @param lgsFclQsurchargeCaseVo
	 *            LSM_海运整箱实盘报价费用信息页面表单对象
	 * @param page
	 *            分页配置
	 * @param request
	 *            请求对象
	 * @return 结果视图
	 */
	/*@RequestMapping(value = {"toSelect", "select", ""})
	@BusinessDesc(ModuleDesc = MODULE_DES, MethodDesc = LGSFCLQSURCHARGECASE_SELECT)
	public String select(LgsFclQsurchargeCaseVo lgsFclQsurchargeCaseVo, Page page, HttpServletRequest request) {
		try{
			request.setAttribute("page", page);
			QueryParams<LgsFclQsurchargeCaseEntity> queryParams = new QueryParams<LgsFclQsurchargeCaseEntity>();
			queryParams.setPaging(page);
			LgsFclQsurchargeCaseEntity entity = null;
			// 如果VO存在
			if(null != lgsFclQsurchargeCaseVo){
				entity = lgsFclQsurchargeCaseVo.getEntity();
				request.setAttribute("entity", entity);
			}
			// 如果entity为null,则创建
			if(null != entity){
				queryParams.setEntity(entity);
			}
			List<LgsFclQsurchargeCaseEntity> lgsFclQsurchargeCaseEntities = lgsFclQsurchargeCaseService.queryByPage(queryParams);
			request.setAttribute("lgsFclQsurchargeCaseEntities", lgsFclQsurchargeCaseEntities);
		}
		catch(Exception ex){
			// 如果是业务异常直接抛出
			if(ex instanceof BusinessException){
				throw (BusinessException) ex;
			}
			// 如果不是业务异常则构造业务异常
			else{
				throw new BusinessException("业务异常:", new Throwable(
						ex.getMessage()));
			}
		}
		return AutoGetURL();
	}*/

	/**
	 * 查询海运整箱实盘报价信息
	 * 
	 * @param lgsFclQuoteInfoCaseVo
	 *            海运整箱实盘报价信息页面表单对象
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
			SunivoSearchResponse sunivoSearchResponse = lgsFclQsurchargeCaseServiceWS.surchargeviewSection(sunivoSearchRequest);
			
			request.setAttribute("quoteInfoCaseSubVoList", sunivoSearchResponse.getResultMap().get("quoteInfoCaseSubVoList"));
			request.setAttribute("portQsurchargeList",sunivoSearchResponse.getResultMap().get("portQsurchargeList"));
			
		} catch (Exception ex) {
			// 如果是业务异常直接抛出
			logger.error(ex);
			logger.error("查询附加费出错！");
		}
		return getAutoUrl();
	}

	/**
	 * 查询海运整箱实盘报价信息
	 * 
	 * @param lgsFclQuoteInfoCaseVo
	 *            海运整箱实盘报价信息页面表单对象
	 * @param page
	 *            分页配置
	 * @param request
	 *            请求对象
	 * @return 结果视图
	 */
	@RequestMapping(value = "surchargeaddSection", method = { RequestMethod.POST })
	/*@BusinessDesc(ModuleDesc = MODULE_DES, MethodDesc = LGSFCLQSURCHARGECASE_SURCHARGE)*/
	public String surchargeaddSection(Integer quoteId,
			HttpServletRequest request) {
		try {
			SunivoRequest sunivoRequest = new SunivoRequest();
			sunivoRequest.getParamMap().put("quoteId", quoteId);
			SunivoResponse sunivoResponse = lgsFclQsurchargeCaseServiceWS.surchargeaddSection(sunivoRequest);
			
			request.setAttribute("quoteId",quoteId);
			request.setAttribute("prdQuoteList", sunivoResponse.getResultMap().get("prdQuoteList"));		
		} catch (Exception ex) {
			// 如果是业务异常直接抛出
			logger.error(ex);
			logger.error("添加附加费报错！");
		}
		return getAutoUrl();
	}
}
