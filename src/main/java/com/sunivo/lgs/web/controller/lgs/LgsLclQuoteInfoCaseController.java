/**
 * Description: 海运拼箱报价信息控制器
 * Copyright:   Copyright (c)2013
 * Company:     SUNIVO
 * @author:     bpoCoder
 * @version:    1.0
 * Create at:   2013-06-27 下午 14:29:44
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
import com.sunivo.ws.interfaces.server.lgs.ILgsLclQuoteInfoCaseServiceWS;

/**
 * 海运拼箱报价信息控制器<br>
 * 
 * @author bpoCoder
 * @version 1.0, 2013-06-27
 * @see
 * @since 1.0
 */
// @NeedLogin如果需要登录请添加
@Controller
@RequestMapping("/lgslclquoteinfocase")
public class LgsLclQuoteInfoCaseController extends BaseController {
	/**
	 * 海运拼箱报价信息模块
	 */
	private final static String MODULE_DES = "海运拼箱报价信息模块";

	/**
	 * 去新增海运拼箱报价信息
	 */
	private final static String LGSLCLQUOTEINFOCASE_TO_ADD = "去新增海运拼箱报价信息";

	/**
	 * 新增海运拼箱报价信息
	 */
	private final static String LGSLCLQUOTEINFOCASE_ADD = "新增海运拼箱报价信息";

	/**
	 * 删除海运拼箱报价信息
	 */
	private final static String LGSLCLQUOTEINFOCASE_DELETE = "删除海运拼箱报价信息";

	/**
	 * 去修改海运拼箱报价信息
	 */
	private final static String LGSLCLQUOTEINFOCASE_TO_UPDATE = "去修改海运拼箱报价信息";

	/**
	 * 修改海运拼箱报价信息
	 */
	private final static String LGSLCLQUOTEINFOCASE_UPDATE = "修改海运拼箱报价信息";

	/**
	 * 查询海运拼箱报价信息
	 */
	private final static String LGSLCLQUOTEINFOCASE_SHOW = "查看海运拼箱报价信息";

	/**
	 * 查询海运拼箱报价信息
	 */
	private final static String LGSLCLQUOTEINFOCASE_SELECT = "查询海运拼箱报价信息";

	@Autowired
	private ILgsLclQuoteInfoCaseServiceWS lgsLclQuoteInfoCaseServiceWS;

	/**
	 * 去新增海运拼箱报价信息
	 * 
	 * @return 结果视图
	 */
	@RequestMapping(value = "", params = "action=create")
	@BusinessDesc(ModuleDesc = MODULE_DES, MethodDesc = LGSLCLQUOTEINFOCASE_TO_ADD)
	public String createForm(Model model){
		model.addAttribute("action", "create");
		return form();
	}

	/**
	 * 新增海运拼箱报价信息
	 * 
	 * @param lgsLclQuoteInfoCase
	 *            海运拼箱报价信息页面表单对象
	 * @param result
	 *            表单验证数据
	 * @param page
	 *            分页配置
	 * @param request
	 *            请求对象
	 * @return 结果视图
	 */
	/*@RequestMapping(value = "", method = { RequestMethod.POST})
	@BusinessDesc(ModuleDesc = MODULE_DES, MethodDesc = LGSLCLQUOTEINFOCASE_ADD)
	public String createLgsLclQuoteInfoCase(LgsLclQuoteInfoCaseVo vo, BindingResult result, RedirectAttributes redirectAttributes, Model model){
		LgsLclQuoteInfoCaseEntity entity = vo.getEntity();
		model.addAttribute("entity", entity);
		subValidation(result, entity);
		// 表单验证无误,进行提交
		if (result.hasErrors()) {
            model.addAttribute("action", "create");
            return form();
		} else {
			try {
				Integer id = lgsLclQuoteInfoCaseService.save(entity);
	            return "redirect:/lgslclquoteinfocase/" + id;
	        } catch (ServiceException se) {
	            ErrorsUtil.rejectErrors(model, se.getMessage());
	            model.addAttribute("action", "create");
	            return form();
	        }
		}
	}*/

	/**
	 * 删除海运拼箱报价信息
	 * 
	 * @param id
	 *            海运拼箱报价信息页面表单对象唯一标识
	 * @param page
	 *            分页配置
	 * @param request
	 *            请求对象
	 * @return 结果视图
	 */
	/*@RequestMapping(value = "/{id}", method = { RequestMethod.DELETE })
	@ResponseStatus(HttpStatus.OK)
	@BusinessDesc(ModuleDesc = MODULE_DES, MethodDesc = LGSLCLQUOTEINFOCASE_DELETE)
	public void delete(@PathVariable Integer id){
		lgsLclQuoteInfoCaseService.delete(id);
	}*/

	/**
	 * 去查看海运拼箱报价信息
	 * 
	 * @param id
	 *            海运拼箱报价信息页面表单对象唯一标识
	 * @param request
	 *            请求对象
	 * @return 结果视图
	 */
	/*@RequestMapping(value = "/{id}", method = { RequestMethod.GET })
	@BusinessDesc(ModuleDesc = MODULE_DES, MethodDesc = LGSLCLQUOTEINFOCASE_SHOW)
	public String showForm(@PathVariable(value = "id") Integer id, Model model) {
		model.addAttribute("entity", lgsLclQuoteInfoCaseService.getById(id));
		return form();
	}*/

	/**
	 * 去修改海运拼箱报价信息
	 * 
	 * @param id
	 *            海运拼箱报价信息页面表单对象唯一标识
	 * @param request
	 *            请求对象
	 * @return 结果视图
	 */
	/*@RequestMapping(value = "/{id}", method = { RequestMethod.GET}, params = "action=edit")
	@BusinessDesc(ModuleDesc = MODULE_DES, MethodDesc = LGSLCLQUOTEINFOCASE_TO_UPDATE)
	public String updateForm(@PathVariable(value = "id") Integer id, Model model){
		model.addAttribute("entity", lgsLclQuoteInfoCaseService.getById(id));
		model.addAttribute("action", "edit");
		return form();
	}*/

	/**
	 * 修改海运拼箱报价信息
	 * 
	 * @param lgsLclQuoteInfoCase
	 *            海运拼箱报价信息页面表单对象
	 * @param result
	 *            表单验证数据
	 * @param page
	 *            分页配置
	 * @param request
	 *            请求对象
	 * @return 结果视图
	 */
	/*@RequestMapping(value = "/{id}", method = { RequestMethod.POST})
	@BusinessDesc(ModuleDesc = MODULE_DES, MethodDesc = LGSLCLQUOTEINFOCASE_UPDATE)
	public String updateLgsLclQuoteInfoCase(LgsLclQuoteInfoCaseVo vo, BindingResult result, @PathVariable Integer id, RedirectAttributes redirectAttributes, Model model){
		LgsLclQuoteInfoCaseEntity entity = vo.getEntity();
		model.addAttribute("entity", entity);
		subValidation(result, entity);
		// 表单验证无误,进行提交
		if (result.hasErrors()) {
            model.addAttribute("action", "edit");
            return form();
		} else {
			try {
				lgsLclQuoteInfoCaseService.update(entity);
				redirectAttributes.addAttribute("message", "更新成功");
	            return "redirect:/lgslclquoteinfocase/" + entity.getId();
	        } catch (ServiceException se) {
	            ErrorsUtil.rejectErrors(model, se.getMessage());
	            model.addAttribute("action", "edit");
	            return form();
	        }
		}
	}*/

	/**
	 * 查询海运拼箱报价信息
	 * 
	 * @param lgsLclQuoteInfoCase
	 *            海运拼箱报价信息页面表单对象
	 * @param page
	 *            分页配置
	 * @param request
	 *            请求对象
	 * @return 结果视图
	 */
	/*@RequestMapping(value = "", method = RequestMethod.GET)
	@BusinessDesc(ModuleDesc = MODULE_DES, MethodDesc = LGSLCLQUOTEINFOCASE_SELECT)
	public String list (Integer number, Model model, HttpServletRequest request) {
		// 获取查询条件
		Map<String, Object> searchParams = Servlets.getParametersStartingWith(
				request, "search_");
		Page page = new Page();
		if (null != number) {
			page.setCurrentPage(number);
		}
		request.setAttribute("page", page);
		QueryParams<LgsLclQuoteInfoCaseEntity> queryParams = new QueryParams<LgsLclQuoteInfoCaseEntity>();
		queryParams.setPaging(page);
		queryParams.setSearchParams(searchParams);
		List<LgsLclQuoteInfoCaseEntity> lgsLclQuoteInfoCases = lgsLclQuoteInfoCaseService.queryByPage(queryParams);
		request.setAttribute("lgsLclQuoteInfoCases", lgsLclQuoteInfoCases);
		model.addAttribute("searchParams", searchParams);
		return AutoGetURL();
	}*/
	

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
	@RequestMapping(value = "selectSection", method = { RequestMethod.POST })
	@BusinessDesc(ModuleDesc = MODULE_DES, MethodDesc = LGSLCLQUOTEINFOCASE_SELECT)
	public String selectSection(Integer inquiryId, Page page,
			HttpServletRequest request) {
		try {
			
			SunivoRequest sunivoRequest = new SunivoRequest();
			Map<String, Object> paramMap = sunivoRequest.getParamMap();
			//paramMap.put("inquiryStatusStr", inquiryStatusStr);
			paramMap.put("inquiryId", inquiryId);
			SunivoResponse sunivoResponse = lgsLclQuoteInfoCaseServiceWS.selectSection(sunivoRequest);
			Map<String,Object> resultMap = sunivoResponse.getResultMap();
			
			request.setAttribute("inquiryStatus",resultMap.get("inquiryStatus"));
			request.setAttribute("inquiryId", resultMap.get("inquiryId"));
			request.setAttribute("lclQuoteInfoCaseVoList",resultMap.get("lclQuoteInfoCaseVoList"));
			
			//request.setAttribute("lclQuoteInfoCaseVoList",lclQuoteInfoCaseVoList);
		} catch (Exception ex) {
			// 如果是业务异常直接抛出
			logger.error(ex);
			logger.error("查询附加费出错！");
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
