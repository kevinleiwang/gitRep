/**
 * Description: 空运报价信息控制器
 * Copyright:   Copyright (c)2013
 * Company:     SUNIVO
 * @author:     bpoCoder
 * @version:    1.0
 * Create at:   2013-06-28 下午 16:07:19
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
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.sunivo.base.Page;
import com.sunivo.lgs.web.base.annotation.bind.BusinessDesc;
import com.sunivo.lgs.web.base.controller.BaseController;
import com.sunivo.ws.SunivoRequest;
import com.sunivo.ws.SunivoResponse;
import com.sunivo.ws.interfaces.server.lgs.ILgsAirQuoteInfoCaseServiceWS;

/**
 * 空运报价信息控制器<br>
 * 
 * @author bpoCoder
 * @version 1.0, 2013-06-28
 * @see
 * @since 1.0
 */
// @NeedLogin如果需要登录请添加
@Controller
@RequestMapping("/lgsairquoteinfocase")
public class LgsAirQuoteInfoCaseController extends BaseController {
	/**
	 * 空运报价信息模块
	 */
	private final static String MODULE_DES = "空运报价信息模块";

	/**
	 * 去新增空运报价信息
	 */
	private final static String LGSAIRQUOTEINFOCASE_TO_ADD = "去新增空运报价信息";

	/**
	 * 新增空运报价信息
	 */
	private final static String LGSAIRQUOTEINFOCASE_ADD = "新增空运报价信息";

	/**
	 * 删除空运报价信息
	 */
	private final static String LGSAIRQUOTEINFOCASE_DELETE = "删除空运报价信息";

	/**
	 * 去修改空运报价信息
	 */
	private final static String LGSAIRQUOTEINFOCASE_TO_UPDATE = "去修改空运报价信息";

	/**
	 * 修改空运报价信息
	 */
	private final static String LGSAIRQUOTEINFOCASE_UPDATE = "修改空运报价信息";

	/**
	 * 查询空运报价信息
	 */
	private final static String LGSAIRQUOTEINFOCASE_SHOW = "查看空运报价信息";

	/**
	 * 查询空运报价信息
	 */
	private final static String LGSAIRQUOTEINFOCASE_SELECT = "查询空运报价信息";

	@Autowired
	private ILgsAirQuoteInfoCaseServiceWS lgsAirQuoteInfoCaseServiceWS;

	/**
	 * 去新增空运报价信息
	 * 
	 * @return 结果视图
	 */
	@RequestMapping(value = "", params = "action=create")
	@BusinessDesc(ModuleDesc = MODULE_DES, MethodDesc = LGSAIRQUOTEINFOCASE_TO_ADD)
	public String createForm(Model model){
		model.addAttribute("action", "create");
		return form();
	}

	/**
	 * 新增空运报价信息
	 * 
	 * @param lgsAirQuoteInfoCase
	 *            空运报价信息页面表单对象
	 * @param result
	 *            表单验证数据
	 * @param page
	 *            分页配置
	 * @param request
	 *            请求对象
	 * @return 结果视图
	 */
	/*@RequestMapping(value = "", method = { RequestMethod.POST})
	@BusinessDesc(ModuleDesc = MODULE_DES, MethodDesc = LGSAIRQUOTEINFOCASE_ADD)
	public String createLgsAirQuoteInfoCase(LgsAirQuoteInfoCaseVo vo, BindingResult result, RedirectAttributes redirectAttributes, Model model){
		LgsAirQuoteInfoCaseEntity entity = vo.getEntity();
		model.addAttribute("entity", entity);
		subValidation(result, entity);
		// 表单验证无误,进行提交
		if (result.hasErrors()) {
            model.addAttribute("action", "create");
            return form();
		} else {
			try {
				Integer id = lgsAirQuoteInfoCaseService.save(entity);
	            return "redirect:/lgsairquoteinfocase/" + id;
	        } catch (ServiceException se) {
	            ErrorsUtil.rejectErrors(model, se.getMessage());
	            model.addAttribute("action", "create");
	            return form();
	        }
		}
	}*/

	/**
	 * 删除空运报价信息
	 * 
	 * @param id
	 *            空运报价信息页面表单对象唯一标识
	 * @param page
	 *            分页配置
	 * @param request
	 *            请求对象
	 * @return 结果视图
	 */
	/*@RequestMapping(value = "/{id}", method = { RequestMethod.DELETE })
	@ResponseStatus(HttpStatus.OK)
	@BusinessDesc(ModuleDesc = MODULE_DES, MethodDesc = LGSAIRQUOTEINFOCASE_DELETE)
	public void delete(@PathVariable Integer id){
		lgsAirQuoteInfoCaseService.delete(id);
	}*/

	/**
	 * 去查看空运报价信息
	 * 
	 * @param id
	 *            空运报价信息页面表单对象唯一标识
	 * @param request
	 *            请求对象
	 * @return 结果视图
	 */
	/*@RequestMapping(value = "/{id}", method = { RequestMethod.GET })
	@BusinessDesc(ModuleDesc = MODULE_DES, MethodDesc = LGSAIRQUOTEINFOCASE_SHOW)
	public String showForm(@PathVariable(value = "id") Integer id, Model model) {
		model.addAttribute("entity", lgsAirQuoteInfoCaseService.getById(id));
		return form();
	}*/

	/**
	 * 去修改空运报价信息
	 * 
	 * @param id
	 *            空运报价信息页面表单对象唯一标识
	 * @param request
	 *            请求对象
	 * @return 结果视图
	 */
	/*@RequestMapping(value = "/{id}", method = { RequestMethod.GET}, params = "action=edit")
	@BusinessDesc(ModuleDesc = MODULE_DES, MethodDesc = LGSAIRQUOTEINFOCASE_TO_UPDATE)
	public String updateForm(@PathVariable(value = "id") Integer id, Model model){
		model.addAttribute("entity", lgsAirQuoteInfoCaseService.getById(id));
		model.addAttribute("action", "edit");
		return form();
	}*/

	/**
	 * 修改空运报价信息
	 * 
	 * @param lgsAirQuoteInfoCase
	 *            空运报价信息页面表单对象
	 * @param result
	 *            表单验证数据
	 * @param page
	 *            分页配置
	 * @param request
	 *            请求对象
	 * @return 结果视图
	 */
	/*@RequestMapping(value = "/{id}", method = { RequestMethod.POST})
	@BusinessDesc(ModuleDesc = MODULE_DES, MethodDesc = LGSAIRQUOTEINFOCASE_UPDATE)
	public String updateLgsAirQuoteInfoCase(LgsAirQuoteInfoCaseVo vo, BindingResult result, @PathVariable Integer id, RedirectAttributes redirectAttributes, Model model){
		LgsAirQuoteInfoCaseEntity entity = vo.getEntity();
		model.addAttribute("entity", entity);
		subValidation(result, entity);
		// 表单验证无误,进行提交
		if (result.hasErrors()) {
            model.addAttribute("action", "edit");
            return form();
		} else {
			try {
				lgsAirQuoteInfoCaseService.update(entity);
				redirectAttributes.addAttribute("message", "更新成功");
	            return "redirect:/lgsairquoteinfocase/" + entity.getId();
	        } catch (ServiceException se) {
	            ErrorsUtil.rejectErrors(model, se.getMessage());
	            model.addAttribute("action", "edit");
	            return form();
	        }
		}
	}
*/
	/**
	 * 查询空运报价信息
	 * 
	 * @param lgsAirQuoteInfoCase
	 *            空运报价信息页面表单对象
	 * @param page
	 *            分页配置
	 * @param request
	 *            请求对象
	 * @return 结果视图
	 */
	/*@RequestMapping(value = "", method = RequestMethod.GET)
	@BusinessDesc(ModuleDesc = MODULE_DES, MethodDesc = LGSAIRQUOTEINFOCASE_SELECT)
	public String list (Integer number, Model model, HttpServletRequest request) {
		// 获取查询条件
		Map<String, Object> searchParams = Servlets.getParametersStartingWith(
				request, "search_");
		Page page = new Page();
		if (null != number) {
			page.setCurrentPage(number);
		}
		request.setAttribute("page", page);
		QueryParams<LgsAirQuoteInfoCaseEntity> queryParams = new QueryParams<LgsAirQuoteInfoCaseEntity>();
		queryParams.setPaging(page);
		queryParams.setSearchParams(searchParams);
		List<LgsAirQuoteInfoCaseEntity> lgsAirQuoteInfoCases = lgsAirQuoteInfoCaseService.queryByPage(queryParams);
		request.setAttribute("lgsAirQuoteInfoCases", lgsAirQuoteInfoCases);
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
	 * 查询空运实盘报价信息
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
	@BusinessDesc(ModuleDesc = MODULE_DES, MethodDesc = LGSAIRQUOTEINFOCASE_SELECT)
	public String selectSection(Integer inquiryId, Page page,
			HttpServletRequest request) {
		try {
			SunivoRequest sunivoRequest = new SunivoRequest();
			Map<String, Object> paramMap = sunivoRequest.getParamMap();
			//paramMap.put("inquiryStatusStr", inquiryStatusStr);
			paramMap.put("inquiryId", inquiryId);
			SunivoResponse sunivoResponse = lgsAirQuoteInfoCaseServiceWS.selectSection(sunivoRequest);
			Map<String,Object> resultMap = sunivoResponse.getResultMap();
			
			request.setAttribute("inquiryStatus",resultMap.get("inquiryStatus"));
			request.setAttribute("inquiryId", resultMap.get("inquiryId"));
			request.setAttribute("airQuoteInfoCaseVoList",resultMap.get("airQuoteInfoCaseVoList"));
		} catch (Exception ex) {
			// 如果是业务异常直接抛出
			logger.error(ex);
			logger.error("查询附加费WS出错！");
		}
		return getAutoUrl();
	}
}
