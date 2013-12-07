/**
 * Description: 集卡报价信息控制器
 * Copyright:   Copyright (c)2013
 * Company:     SUNIVO
 * @author:     bpoCoder
 * @version:    1.0
 * Create at:   2013-06-27 下午 14:41:45
 *  
 * Modification History:
 * Date         Author      Version     Description
 * ------------------------------------------------------------------
 * 2012-12-21   bpoCoder   1.0         Initial
 */
package com.sunivo.lgs.web.controller.lgs;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springside.modules.web.Servlets;

import com.sunivo.base.Page;
import com.sunivo.lgs.beans.entity.LgsInquiryEntity;
import com.sunivo.lgs.beans.entity.LgsStruckQuoteInfoCaseEntity;
import com.sunivo.lgs.web.base.annotation.bind.BusinessDesc;
import com.sunivo.lgs.web.base.controller.BaseController;
import com.sunivo.uim.beans.bo.DicCurrencyCostInfo;
import com.sunivo.ws.SunivoRequest;
import com.sunivo.ws.SunivoResponse;
import com.sunivo.ws.beans.request.rtq.OrderServiceParams;
import com.sunivo.ws.beans.request.rtq.QuotePriceInfo;
import com.sunivo.ws.beans.request.rtq.RTQOutParas;
import com.sunivo.ws.beans.response.rtq.RTQContext;
import com.sunivo.ws.interfaces.server.lgs.ILgsStruckQuoteInfoCaseServiceWS;

/**
 * 集卡报价信息控制器<br>
 * 
 * @author bpoCoder
 * @version 1.0, 2013-06-27
 * @see
 * @since 1.0
 */
// @NeedLogin如果需要登录请添加
@Controller
@RequestMapping("/lgsstruckquoteinfocase")
public class LgsStruckQuoteInfoCaseController extends BaseController {
	/**
	 * 集卡报价信息模块
	 */
	private final static String MODULE_DES = "集卡报价信息模块";

	/**
	 * 去新增集卡报价信息
	 */
	private final static String LGSSTRUCKQUOTEINFOCASE_TO_ADD = "去新增集卡报价信息";

	/**
	 * 新增集卡报价信息
	 */
	private final static String LGSSTRUCKQUOTEINFOCASE_ADD = "新增集卡报价信息";

	/**
	 * 删除集卡报价信息
	 */
	private final static String LGSSTRUCKQUOTEINFOCASE_DELETE = "删除集卡报价信息";

	/**
	 * 去修改集卡报价信息
	 */
	private final static String LGSSTRUCKQUOTEINFOCASE_TO_UPDATE = "去修改集卡报价信息";

	/**
	 * 修改集卡报价信息
	 */
	private final static String LGSSTRUCKQUOTEINFOCASE_UPDATE = "修改集卡报价信息";

	/**
	 * 查询集卡报价信息
	 */
	private final static String LGSSTRUCKQUOTEINFOCASE_SHOW = "查看集卡报价信息";

	/**
	 * 查询集卡报价信息
	 */
	private final static String LGSSTRUCKQUOTEINFOCASE_SELECT = "查询集卡报价信息";


	@Autowired
	private ILgsStruckQuoteInfoCaseServiceWS lgsStruckQuoteInfoCaseServiceWS;
	
	/**
	 * 去新增集卡报价信息
	 * 
	 * @return 结果视图
	 */
	@RequestMapping(value = "", params = "action=create")
	@BusinessDesc(ModuleDesc = MODULE_DES, MethodDesc = LGSSTRUCKQUOTEINFOCASE_TO_ADD)
	public String createForm(Model model){
		model.addAttribute("action", "create");
		return form();
	}

	/**
	 * 新增集卡报价信息
	 * 
	 * @param lgsStruckQuoteInfoCase
	 *            集卡报价信息页面表单对象
	 * @param result
	 *            表单验证数据
	 * @param page
	 *            分页配置
	 * @param request
	 *            请求对象
	 * @return 结果视图
	 */
	/*@RequestMapping(value = "", method = { RequestMethod.POST})
	@BusinessDesc(ModuleDesc = MODULE_DES, MethodDesc = LGSSTRUCKQUOTEINFOCASE_ADD)
	public String createLgsStruckQuoteInfoCase(LgsStruckQuoteInfoCaseVo vo, BindingResult result, RedirectAttributes redirectAttributes, Model model){
		LgsStruckQuoteInfoCaseEntity entity = vo.getEntity();
		model.addAttribute("entity", entity);
		subValidation(result, entity);
		// 表单验证无误,进行提交
		if (result.hasErrors()) {
            model.addAttribute("action", "create");
            return form();
		} else {
			try {
				Integer id = lgsStruckQuoteInfoCaseService.save(entity);
	            return "redirect:/lgsstruckquoteinfocase/" + id;
	        } catch (ServiceException se) {
	            ErrorsUtil.rejectErrors(model, se.getMessage());
	            model.addAttribute("action", "create");
	            return form();
	        }
		}
	}*/

	/**
	 * 删除集卡报价信息
	 * 
	 * @param id
	 *            集卡报价信息页面表单对象唯一标识
	 * @param page
	 *            分页配置
	 * @param request
	 *            请求对象
	 * @return 结果视图
	 */
	/*@RequestMapping(value = "/{id}", method = { RequestMethod.DELETE })
	@ResponseStatus(HttpStatus.OK)
	@BusinessDesc(ModuleDesc = MODULE_DES, MethodDesc = LGSSTRUCKQUOTEINFOCASE_DELETE)
	public void delete(@PathVariable Integer id){
		lgsStruckQuoteInfoCaseService.delete(id);
	}*/

	/**
	 * 去查看集卡报价信息
	 * 
	 * @param id
	 *            集卡报价信息页面表单对象唯一标识
	 * @param request
	 *            请求对象
	 * @return 结果视图
	 */
	/*@RequestMapping(value = "/{id}", method = { RequestMethod.GET })
	@BusinessDesc(ModuleDesc = MODULE_DES, MethodDesc = LGSSTRUCKQUOTEINFOCASE_SHOW)
	public String showForm(@PathVariable(value = "id") Integer id, Model model) {
		model.addAttribute("entity", lgsStruckQuoteInfoCaseService.getById(id));
		return form();
	}*/

	/**
	 * 去修改集卡报价信息
	 * 
	 * @param id
	 *            集卡报价信息页面表单对象唯一标识
	 * @param request
	 *            请求对象
	 * @return 结果视图
	 */
	/*@RequestMapping(value = "/{id}", method = { RequestMethod.GET}, params = "action=edit")
	@BusinessDesc(ModuleDesc = MODULE_DES, MethodDesc = LGSSTRUCKQUOTEINFOCASE_TO_UPDATE)
	public String updateForm(@PathVariable(value = "id") Integer id, Model model){
		model.addAttribute("entity", lgsStruckQuoteInfoCaseService.getById(id));
		model.addAttribute("action", "edit");
		return form();
	}*/

	/**
	 * 修改集卡报价信息
	 * 
	 * @param lgsStruckQuoteInfoCase
	 *            集卡报价信息页面表单对象
	 * @param result
	 *            表单验证数据
	 * @param page
	 *            分页配置
	 * @param request
	 *            请求对象
	 * @return 结果视图
	 */
	/*@RequestMapping(value = "/{id}", method = { RequestMethod.POST})
	@BusinessDesc(ModuleDesc = MODULE_DES, MethodDesc = LGSSTRUCKQUOTEINFOCASE_UPDATE)
	public String updateLgsStruckQuoteInfoCase(LgsStruckQuoteInfoCaseVo vo, BindingResult result, @PathVariable Integer id, RedirectAttributes redirectAttributes, Model model){
		LgsStruckQuoteInfoCaseEntity entity = vo.getEntity();
		model.addAttribute("entity", entity);
		subValidation(result, entity);
		// 表单验证无误,进行提交
		if (result.hasErrors()) {
            model.addAttribute("action", "edit");
            return form();
		} else {
			try {
				lgsStruckQuoteInfoCaseService.update(entity);
				redirectAttributes.addAttribute("message", "更新成功");
	            return "redirect:/lgsstruckquoteinfocase/" + entity.getId();
	        } catch (ServiceException se) {
	            ErrorsUtil.rejectErrors(model, se.getMessage());
	            model.addAttribute("action", "edit");
	            return form();
	        }
		}
	}*/

	/**
	 * 查询集卡报价信息
	 * 
	 * @param lgsStruckQuoteInfoCase
	 *            集卡报价信息页面表单对象
	 * @param page
	 *            分页配置
	 * @param request
	 *            请求对象
	 * @return 结果视图
	 */
	/*@RequestMapping(value = "", method = RequestMethod.GET)
	@BusinessDesc(ModuleDesc = MODULE_DES, MethodDesc = LGSSTRUCKQUOTEINFOCASE_SELECT)
	public String list (Integer number, Model model, HttpServletRequest request) {
		// 获取查询条件
		Map<String, Object> searchParams = Servlets.getParametersStartingWith(
				request, "search_");
		Page page = new Page();
		if (null != number) {
			page.setCurrentPage(number);
		}
		request.setAttribute("page", page);
		QueryParams<LgsStruckQuoteInfoCaseEntity> queryParams = new QueryParams<LgsStruckQuoteInfoCaseEntity>();
		queryParams.setPaging(page);
		queryParams.setSearchParams(searchParams);
		List<LgsStruckQuoteInfoCaseEntity> lgsStruckQuoteInfoCases = lgsStruckQuoteInfoCaseService.queryByPage(queryParams);
		request.setAttribute("lgsStruckQuoteInfoCases", lgsStruckQuoteInfoCases);
		model.addAttribute("searchParams", searchParams);
		return AutoGetURL();
	}*/
	
	/**
	 * 查询集卡实盘报价信息
	 * 
	 * @param lgsStruckQuoteInfoCaseVo
	 *            集卡实盘报价信息页面表单对象
	 * @param page
	 *            分页配置
	 * @param request
	 *            请求对象
	 * @return 结果视图
	 */
	@RequestMapping(value = "selectSection", method = { RequestMethod.POST })
	@BusinessDesc(ModuleDesc = MODULE_DES, MethodDesc = LGSSTRUCKQUOTEINFOCASE_SELECT)
	public String selectSection(Integer inquiryId, Page page,
			HttpServletRequest request) {
		try {
			SunivoRequest sunivoRequest = new SunivoRequest();
			Map<String, Object> paramMap = sunivoRequest.getParamMap();
			//paramMap.put("inquiryStatusStr", inquiryStatusStr);
			paramMap.put("inquiryId", inquiryId);
			SunivoResponse sunivoResponse = lgsStruckQuoteInfoCaseServiceWS.selectSection(sunivoRequest);
			Map<String,Object> resultMap = sunivoResponse.getResultMap();
			
			request.setAttribute("inquiryStatus",resultMap.get("inquiryStatus"));
			request.setAttribute("inquiryId", resultMap.get("inquiryId"));
			request.setAttribute("struckQuoteInfoCaseVoList",resultMap.get("struckQuoteInfoCaseVoList"));
		} catch (Exception ex) {
			// 如果是业务异常直接抛出
			logger.error(ex);
			logger.error("查询附加费WS出错！");
		}
		return getAutoUrl();
	}

	/**
	 * 获取form页面的真实路径
	 * 
	 * @return form页面的真实路径
	 */
	private String form(){
		return getAutoUrl();
	}
}
