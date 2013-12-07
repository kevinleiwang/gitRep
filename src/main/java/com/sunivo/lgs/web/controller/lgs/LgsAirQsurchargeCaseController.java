/**
 * Description: 空运报价费用信息控制器
 * Copyright:   Copyright (c)2013
 * Company:     SUNIVO
 * @author:     bpoCoder
 * @version:    1.0
 * Create at:   2013-06-28 下午 16:36:13
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
import com.sunivo.lgs.beans.vo.LgsAirQsurchargeCaseAddVo;
import com.sunivo.lgs.web.base.annotation.bind.BusinessDesc;
import com.sunivo.lgs.web.base.controller.BaseController;
import com.sunivo.ws.SunivoRequest;
import com.sunivo.ws.SunivoResponse;
import com.sunivo.ws.interfaces.server.lgs.ILgsAirQsurchargeCaseServiceWS;

/**
 * 空运报价费用信息控制器<br>
 * 
 * @author bpoCoder
 * @version 1.0, 2013-06-28
 * @see
 * @since 1.0
 */
// @NeedLogin如果需要登录请添加
@Controller
@RequestMapping("/lgsairqsurchargecase")
public class LgsAirQsurchargeCaseController extends BaseController {
	/**
	 * 空运报价费用信息模块
	 */
	private final static String MODULE_DES = "空运报价费用信息模块";

	/**
	 * 去新增空运报价费用信息
	 */
	private final static String LGSAIRQSURCHARGECASE_TO_ADD = "去新增空运报价费用信息";

	/**
	 * 新增空运报价费用信息
	 */
	private final static String LGSAIRQSURCHARGECASE_ADD = "新增空运报价费用信息";

	/**
	 * 删除空运报价费用信息
	 */
	private final static String LGSAIRQSURCHARGECASE_DELETE = "删除空运报价费用信息";

	/**
	 * 去修改空运报价费用信息
	 */
	private final static String LGSAIRQSURCHARGECASE_TO_UPDATE = "去修改空运报价费用信息";

	/**
	 * 修改空运报价费用信息
	 */
	private final static String LGSAIRQSURCHARGECASE_UPDATE = "修改空运报价费用信息";

	/**
	 * 查询空运报价费用信息
	 */
	private final static String LGSAIRQSURCHARGECASE_SHOW = "查看空运报价费用信息";

	/**
	 * 查询空运报价费用信息
	 */
	private final static String LGSAIRQSURCHARGECASE_SELECT = "查询空运报价费用信息";

	@Autowired
	private ILgsAirQsurchargeCaseServiceWS lgsAirQsurchargeCaseServiceWS;
	
	/**
	 * 去新增空运报价费用信息
	 * 
	 * @return 结果视图
	 */
	/*@RequestMapping(value = "", params = "action=create")
	@BusinessDesc(ModuleDesc = MODULE_DES, MethodDesc = LGSAIRQSURCHARGECASE_TO_ADD)
	public String createForm(Model model){
		model.addAttribute("action", "create");
		return form();
	}*/

	/**
	 * 新增空运报价费用信息
	 * 
	 * @param lgsAirQsurchargeCase
	 *            空运报价费用信息页面表单对象
	 * @param result
	 *            表单验证数据
	 * @param page
	 *            分页配置
	 * @param request
	 *            请求对象
	 * @return 结果视图
	 */
	/*@RequestMapping(value = "", method = { RequestMethod.POST})
	@BusinessDesc(ModuleDesc = MODULE_DES, MethodDesc = LGSAIRQSURCHARGECASE_ADD)
	public String createLgsAirQsurchargeCase(LgsAirQsurchargeCaseVo vo, BindingResult result, RedirectAttributes redirectAttributes, Model model){
		LgsAirQsurchargeCaseEntity entity = vo.getEntity();
		model.addAttribute("entity", entity);
		subValidation(result, entity);
		// 表单验证无误,进行提交
		if (result.hasErrors()) {
            model.addAttribute("action", "create");
            return form();
		} else {
			try {
				Integer id = lgsAirQsurchargeCaseService.save(entity);
	            return "redirect:/lgsairqsurchargecase/" + id;
	        } catch (ServiceException se) {
	            ErrorsUtil.rejectErrors(model, se.getMessage());
	            model.addAttribute("action", "create");
	            return form();
	        }
		}
	}
*/
	/**
	 * 删除空运报价费用信息
	 * 
	 * @param id
	 *            空运报价费用信息页面表单对象唯一标识
	 * @param page
	 *            分页配置
	 * @param request
	 *            请求对象
	 * @return 结果视图
	 */
	/*@RequestMapping(value = "/{id}", method = { RequestMethod.DELETE })
	@ResponseStatus(HttpStatus.OK)
	@BusinessDesc(ModuleDesc = MODULE_DES, MethodDesc = LGSAIRQSURCHARGECASE_DELETE)
	public void delete(@PathVariable Integer id){
		lgsAirQsurchargeCaseService.delete(id);
	}*/

	/**
	 * 去查看空运报价费用信息
	 * 
	 * @param id
	 *            空运报价费用信息页面表单对象唯一标识
	 * @param request
	 *            请求对象
	 * @return 结果视图
	 */
	/*@RequestMapping(value = "/{id}", method = { RequestMethod.GET })
	@BusinessDesc(ModuleDesc = MODULE_DES, MethodDesc = LGSAIRQSURCHARGECASE_SHOW)
	public String showForm(@PathVariable(value = "id") Integer id, Model model) {
		model.addAttribute("entity", lgsAirQsurchargeCaseService.getById(id));
		return form();
	}*/

	/**
	 * 去修改空运报价费用信息
	 * 
	 * @param id
	 *            空运报价费用信息页面表单对象唯一标识
	 * @param request
	 *            请求对象
	 * @return 结果视图
	 */
	/*@RequestMapping(value = "/{id}", method = { RequestMethod.GET}, params = "action=edit")
	@BusinessDesc(ModuleDesc = MODULE_DES, MethodDesc = LGSAIRQSURCHARGECASE_TO_UPDATE)
	public String updateForm(@PathVariable(value = "id") Integer id, Model model){
		model.addAttribute("entity", lgsAirQsurchargeCaseService.getById(id));
		model.addAttribute("action", "edit");
		return form();
	}*/

	/**
	 * 修改空运报价费用信息
	 * 
	 * @param lgsAirQsurchargeCase
	 *            空运报价费用信息页面表单对象
	 * @param result
	 *            表单验证数据
	 * @param page
	 *            分页配置
	 * @param request
	 *            请求对象
	 * @return 结果视图
	 */
	/*@RequestMapping(value = "/{id}", method = { RequestMethod.POST})
	@BusinessDesc(ModuleDesc = MODULE_DES, MethodDesc = LGSAIRQSURCHARGECASE_UPDATE)
	public String updateLgsAirQsurchargeCase(LgsAirQsurchargeCaseVo vo, BindingResult result, @PathVariable Integer id, RedirectAttributes redirectAttributes, Model model){
		LgsAirQsurchargeCaseEntity entity = vo.getEntity();
		model.addAttribute("entity", entity);
		subValidation(result, entity);
		// 表单验证无误,进行提交
		if (result.hasErrors()) {
            model.addAttribute("action", "edit");
            return form();
		} else {
			try {
				lgsAirQsurchargeCaseService.update(entity);
				redirectAttributes.addAttribute("message", "更新成功");
	            return "redirect:/lgsairqsurchargecase/" + entity.getId();
	        } catch (ServiceException se) {
	            ErrorsUtil.rejectErrors(model, se.getMessage());
	            model.addAttribute("action", "edit");
	            return form();
	        }
		}
	}*/

	/**
	 * 查询空运报价费用信息
	 * 
	 * @param lgsAirQsurchargeCase
	 *            空运报价费用信息页面表单对象
	 * @param page
	 *            分页配置
	 * @param request
	 *            请求对象
	 * @return 结果视图
	 */
	/*@RequestMapping(value = "", method = RequestMethod.GET)
	@BusinessDesc(ModuleDesc = MODULE_DES, MethodDesc = LGSAIRQSURCHARGECASE_SELECT)
	public String list (Integer number, Model model, HttpServletRequest request) {
		// 获取查询条件
		Map<String, Object> searchParams = Servlets.getParametersStartingWith(
				request, "search_");
		Page page = new Page();
		if (null != number) {
			page.setCurrentPage(number);
		}
		request.setAttribute("page", page);
		QueryParams<LgsAirQsurchargeCaseEntity> queryParams = new QueryParams<LgsAirQsurchargeCaseEntity>();
		queryParams.setPaging(page);
		queryParams.setSearchParams(searchParams);
		List<LgsAirQsurchargeCaseEntity> lgsAirQsurchargeCases = lgsAirQsurchargeCaseService.queryByPage(queryParams);
		request.setAttribute("lgsAirQsurchargeCases", lgsAirQsurchargeCases);
		model.addAttribute("searchParams", searchParams);
		return AutoGetURL();
	}*/
	
	/**
	 * 获取form页面的真实路径
	 * 
	 * @return form页面的真实路径
	 */
	private String form(){
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
	@RequestMapping(value = "addListSection", method = { RequestMethod.POST })
	@BusinessDesc(ModuleDesc = MODULE_DES, MethodDesc = LGSAIRQSURCHARGECASE_ADD)
	public String addListSection(
			LgsAirQsurchargeCaseAddVo lgsAirQsurchargeCaseAddVo,
			BindingResult result, Page page, HttpServletRequest request) {
		SunivoRequest sunivoRequest = new SunivoRequest();
		Map paramMap = sunivoRequest.getParamMap();
		
		//设置入参
		paramMap.put("lgsAirQsurchargeCaseAddVo", lgsAirQsurchargeCaseAddVo);
		paramMap.put("carrier", request.getParameter("carrier"));
		//paramMap.put("estimatedRange", request.getParameter("estimatedRange"));
		paramMap.put("expiryDate", request.getParameter("expiryDate"));
		//paramMap.put("estimatedSalingdateValues", request.getParameterValues("estimatedSalingdateValues"));
		
		SunivoResponse sunivoResponse = lgsAirQsurchargeCaseServiceWS.addListSection(sunivoRequest);
		Integer inquiryId = (Integer)sunivoResponse.getResultMap().get("inquiryId");
		
		return "redirect:/lgsinquiry/detail?id=" + inquiryId;
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
	@BusinessDesc(ModuleDesc = MODULE_DES, MethodDesc = LGSAIRQSURCHARGECASE_SELECT)
	public String surchargeaddSection(Integer quoteId,
			HttpServletRequest request) {
		try {
			SunivoRequest sunivoRequest = new SunivoRequest();
			sunivoRequest.getParamMap().put("quoteId", quoteId);
			SunivoResponse sunivoResponse = lgsAirQsurchargeCaseServiceWS.surchargeaddSection(sunivoRequest);
			
			request.setAttribute("quoteId",quoteId);
			request.setAttribute("prdQuoteList", sunivoResponse.getResultMap().get("prdQuoteList"));		
		} catch (Exception ex) {
			// 如果是业务异常直接抛出
			logger.error(ex);
			logger.error("拼箱添加附加费Controller报错！");
		}
		return getAutoUrl();
	}
}
