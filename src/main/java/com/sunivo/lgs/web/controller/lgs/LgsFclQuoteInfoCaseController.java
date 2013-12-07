/**
 * Description: 海运整箱实盘报价信息控制器
 * Copyright:   Copyright (c)2013
 * Company:     SUNIVO
 * @author:     bpoCoder
 * @version:    1.0
 * Create at:   2013-06-14 下午 16:44:11
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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.sunivo.base.Page;
import com.sunivo.lgs.web.base.controller.BaseController;
import com.sunivo.ws.SunivoRequest;
import com.sunivo.ws.SunivoResponse;
import com.sunivo.ws.interfaces.server.lgs.ILgsFclQuoteInfoCaseServiceWS;
/**
 * 海运整箱实盘报价信息控制器<br>
 * 
 * @author bpoCoder
 * @version 1.0, 2013-06-14
 * @see
 * @since 1.0
 */
// @NeedLogin如果需要登录请添加
@Controller
@RequestMapping("/lgsfclquoteinfocase")
public class LgsFclQuoteInfoCaseController extends BaseController {

	/**
	 * 自动注入海运整箱实盘报价信息业务层实现
	 */
	@Autowired
	private ILgsFclQuoteInfoCaseServiceWS lgsFclQuoteInfoCaseServiceWS;


	/**
	 * 去新增海运整箱实盘报价信息
	 * 
	 * @return 结果视图
	 */
	@RequestMapping(value = "toAdd", method = { RequestMethod.GET})
	public String add(){
		return getAutoUrl();
	}

	/**
	 * 新增海运整箱实盘报价信息
	 * 
	 * @param lgsFclQuoteInfoCaseVo
	 *            海运整箱实盘报价信息页面表单对象
	 * @param result
	 *            表单验证数据
	 * @param page
	 *            分页配置
	 * @param request
	 *            请求对象
	 * @return 结果视图
	 */
	/*
	@RequestMapping(value = "add", method = { RequestMethod.POST})
	public String addLgsFclQuoteInfoCase(@Valid LgsFclQuoteInfoCaseVo lgsFclQuoteInfoCaseVo, BindingResult result, Page page, HttpServletRequest request){
		subValidation(result, lgsFclQuoteInfoCaseVo.getEntity());
		// 表单验证无误,进行提交
		if (result.hasErrors()) {
			return add();
		} else {
			try{
				// 返回保存对象的自增ID,这里不做处理
				lgsFclQuoteInfoCaseService.save(lgsFclQuoteInfoCaseVo.getEntity());
			}
			catch(Exception ex){
				// 如果是业务异常直接抛出
				logger.error(ex);
				logger.error("增加海整报价出错！");
			}
		}
		return selectSection(null, page, request);
	}*/

	/**
	 * 删除海运整箱实盘报价信息
	 * 
	 * @param id
	 *            海运整箱实盘报价信息页面表单对象唯一标识
	 * @param page
	 *            分页配置
	 * @param request
	 *            请求对象
	 * @return 结果视图
	 */
	/*
	@RequestMapping(value = "delete", method = { RequestMethod.GET })
	public String deleteLgsFclQuoteInfoCase(Integer id, Page page, HttpServletRequest request){
		try{
			if(null != id){
			    lgsFclQuoteInfoCaseService.delete(id);
			}
		}
		catch(Exception ex){
			// 如果是业务异常直接抛出
			logger.error(ex);
			logger.error("删除海整报价出错！");
		}
		return selectSection(null, page, request);
	}
	*/

	/**
	 * 去修改海运整箱实盘报价信息
	 * 
	 * @param id
	 *            海运整箱实盘报价信息页面表单对象唯一标识
	 * @param request
	 *            请求对象
	 * @return 结果视图
	 */
	/*
	@RequestMapping(value = "toUpdate", method = { RequestMethod.GET})
	public String update(Integer id, HttpServletRequest request){
		try{
			if(null != id){
				LgsFclQuoteInfoCaseEntity lgsFclQuoteInfoCaseEntity = lgsFclQuoteInfoCaseService.getById(id);
				request.setAttribute("lgsFclQuoteInfoCaseEntity", lgsFclQuoteInfoCaseEntity);
			}
		}
		catch(Exception ex){
			// 如果是业务异常直接抛出
			logger.error(ex);
			logger.error("修改海整报价出错！");
		}
		return getAutoUrl();
	}
	*/

	/**
	 * 修改海运整箱实盘报价信息
	 * 
	 * @param lgsFclQuoteInfoCaseVo
	 *            海运整箱实盘报价信息页面表单对象
	 * @param result
	 *            表单验证数据
	 * @param page
	 *            分页配置
	 * @param request
	 *            请求对象
	 * @return 结果视图
	 */
	/*
	@RequestMapping(value = "update", method = {
			RequestMethod.POST })
	public String updateLgsFclQuoteInfoCase(@Valid LgsFclQuoteInfoCaseVo lgsFclQuoteInfoCaseVo, BindingResult result, Page page, HttpServletRequest request){
		subValidation(result, lgsFclQuoteInfoCaseVo.getEntity());
		// 表单验证无误,进行提交
		if (result.hasErrors()) {
			return update(lgsFclQuoteInfoCaseVo.getEntity().getId(), request);
		} else {
			try{
				lgsFclQuoteInfoCaseService.update(lgsFclQuoteInfoCaseVo.getEntity());
			}
			catch(Exception ex){
				// 如果是业务异常直接抛出
				logger.error(ex);
				logger.error("修改海整报价出错！");
			}
		}
		return selectSection(null, page, request);
	}
	*/

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
	@RequestMapping(value = "selectSection", method = { RequestMethod.POST })
	/*@BusinessDesc(ModuleDesc = MODULE_DES, MethodDesc = LGSFCLQUOTEINFOCASE_SELECT)*/
	public String selectSection(Integer inquiryId,
			Page page, HttpServletRequest request) {
		try {
			SunivoRequest sunivoRequest = new SunivoRequest();
			Map<String, Object> paramMap = sunivoRequest.getParamMap();
			//paramMap.put("inquiryStatusStr", inquiryStatusStr);
			paramMap.put("inquiryId", inquiryId);
			SunivoResponse sunivoResponse = lgsFclQuoteInfoCaseServiceWS.selectSection(sunivoRequest);
			Map<String,Object> resultMap = sunivoResponse.getResultMap();
			
			request.setAttribute("inquiryStatus",resultMap.get("inquiryStatus"));
			request.setAttribute("inquiryId", resultMap.get("inquiryId"));
			request.setAttribute("fclQuoteInfoCaseVoList",resultMap.get("fclQuoteInfoCaseVoList"));
			
		} catch (Exception ex) {
			// 如果是业务异常直接抛出
			logger.error(ex);
			logger.error("海整报价列表出错！");
		}
		return getAutoUrl();
	}

	/**
	 * 根据询单ID查询海运整箱实盘报价信息
	 * 
	 * @param lgsFclQuoteInfoCaseVo
	 *            海运整箱实盘报价信息页面表单对象
	 * @param page
	 *            分页配置
	 * @param request
	 *            请求对象
	 * @return 结果视图
	 */
	/*
	@RequestMapping(value = "getbyinquiryid", method = { RequestMethod.POST })
	public String getQuoteInfoByInquiryId(Integer inquiryId,
			HttpServletRequest request) {

		try {
			// 如果请求的inquiryID不为空
			List<LgsFclQuoteInfoCaseEntity> lgsFclQuoteInfoCaseEntities = new ArrayList<LgsFclQuoteInfoCaseEntity>();
			if (null != inquiryId) {
				lgsFclQuoteInfoCaseEntities = lgsFclQuoteInfoCaseService
						.getByInquiryId(inquiryId);

			}

			// 设置返回值
			List<FclQuoteInfoCaseVo> fclQuoteInfoCaseVoList = new ArrayList<FclQuoteInfoCaseVo>();
			// 根据取得信息，关联报价详情表
			if (lgsFclQuoteInfoCaseEntities != null
					&& lgsFclQuoteInfoCaseEntities.size() > 0) {
				FclQuoteInfoCaseVo fclQuoteInfoCaseVo = new FclQuoteInfoCaseVo();
				for (int i = 0; i < lgsFclQuoteInfoCaseEntities.size(); i++) {
					List<LgsFclQsurchargeCaseEntity> fclQsurchargeCaseList = lgsFclQsurchargeCaseService
							.getByQuoteId(lgsFclQuoteInfoCaseEntities.get(i)
									.getId());
					if (fclQsurchargeCaseList != null) {
						for (LgsFclQsurchargeCaseEntity fclQsurchargeCase : fclQsurchargeCaseList) {
							// 报价为海运整箱
							if (fclQsurchargeCase.getCostId() == 37) {
								fclQuoteInfoCaseVo
										.setSurchargeEntity(fclQsurchargeCase);
							}
						}
					}
					fclQuoteInfoCaseVo.setEntity(lgsFclQuoteInfoCaseEntities
							.get(i));
					fclQuoteInfoCaseVoList.add(fclQuoteInfoCaseVo);
				}
			}
			request.setAttribute("fclQuoteInfoCaseVoList",
					fclQuoteInfoCaseVoList);
		} catch (Exception ex) {
			// 如果是业务异常直接抛出
			if (ex instanceof BusinessException) {
				throw (BusinessException) ex;
			}
			// 如果不是业务异常则构造业务异常

			else {
				throw new BusinessException("业务异常:", new Throwable(
						ex.getMessage()));
			}
		}
		return AutoGetURL();
	}
	*/

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
	/*
	@RequestMapping(value = "surcharge", method = { RequestMethod.GET })
	public String surcharge(LgsFclQuoteInfoCaseVo lgsFclQuoteInfoCaseVo,
			HttpServletRequest request) {
		try{

			QueryParams<LgsFclQuoteInfoCaseEntity> queryParams = new QueryParams<LgsFclQuoteInfoCaseEntity>();
			LgsFclQuoteInfoCaseEntity entity = null;
			// 如果VO存在
			if(null != lgsFclQuoteInfoCaseVo){
				entity = lgsFclQuoteInfoCaseVo.getEntity();
				request.setAttribute("entity", entity);
			}
			// 如果entity为null,则创建
			if (null != entity) {
				queryParams.setEntity(entity);
			}
			List<LgsFclQuoteInfoCaseEntity> lgsFclQuoteInfoCaseEntities = lgsFclQuoteInfoCaseService.queryByPage(queryParams);
			// 设置返回值
			List<FclQuoteInfoCaseVo> fclQuoteInfoCaseVoList = new ArrayList<FclQuoteInfoCaseVo>();
			// 根据取得信息，关联报价详情表
			if (lgsFclQuoteInfoCaseEntities != null
					&& lgsFclQuoteInfoCaseEntities.size() > 0) {
				FclQuoteInfoCaseVo fclQuoteInfoCaseVo = new FclQuoteInfoCaseVo();
				for (int i = 0; i < lgsFclQuoteInfoCaseEntities.size(); i++) {
					List<LgsFclQsurchargeCaseEntity> fclQsurchargeCaseList = lgsFclQsurchargeCaseService
							.getByQuoteId(lgsFclQuoteInfoCaseEntities.get(i)
									.getId());
					if (fclQsurchargeCaseList != null) {
						for (LgsFclQsurchargeCaseEntity fclQsurchargeCase : fclQsurchargeCaseList) {
							// 报价为海运整箱
							if (fclQsurchargeCase.getCostId() == 37) {
								fclQuoteInfoCaseVo
										.setSurchargeEntity(fclQsurchargeCase);
							}
						}
					}
					fclQuoteInfoCaseVo.setEntity(lgsFclQuoteInfoCaseEntities
							.get(i));
					fclQuoteInfoCaseVoList.add(fclQuoteInfoCaseVo);
				}
			}
			// request.setAttribute("lgsFclQuoteInfoCaseEntities",
			// lgsFclQuoteInfoCaseEntities);
			request.setAttribute("fclQuoteInfoCaseVoList",
					fclQuoteInfoCaseVoList);
		}
		catch(Exception ex) {
			// 如果是业务异常直接抛出
			logger.error(ex);
			logger.error("海整实盘报价出错！");
		}
		return AutoGetURL();
	}
	*/
}
