/**
 * Description: 优势航线设置配置控制器
 * Copyright:   Copyright (c)2013
 * Company:     SUNIVO
 * @author:     // TODO 请使用自己姓名代替
 * @version:    1.0
 * Create at:   2013-11-06 下午 17:05:32
 *  
 * Modification History:
 * Date         Author      Version     Description
 * ------------------------------------------------------------------
 * 2012-12-21   // TODO 请使用自己姓名代替   1.0         Initial
 */
package com.sunivo.lgs.web.controller.lgs;

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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springside.modules.web.Servlets;

import com.sunivo.base.Page;
import com.sunivo.lgs.beans.entity.LgsAdvantageRouteSetEntity;
import com.sunivo.lgs.beans.vo.LgsAdvantageRouteSetVo;
import com.sunivo.lgs.web.base.controller.BaseController;
import com.sunivo.ws.Constants;
import com.sunivo.ws.beans.request.lgs.DeleteLgsAdvantageRouteSetRequest;
import com.sunivo.ws.beans.request.lgs.GetLgsAdvantageRouteSetByIdRequest;
import com.sunivo.ws.beans.request.lgs.ListLgsAdvantageRouteSetRequest;
import com.sunivo.ws.beans.request.lgs.SaveLgsAdvantageRouteSetRequest;
import com.sunivo.ws.beans.request.lgs.UpdateLgsAdvantageRouteSetRequest;
import com.sunivo.ws.beans.response.lgs.DeleteLgsAdvantageRouteSetResponse;
import com.sunivo.ws.beans.response.lgs.GetLgsAdvantageRouteSetByIdResponse;
import com.sunivo.ws.beans.response.lgs.ListLgsAdvantageRouteSetResponse;
import com.sunivo.ws.beans.response.lgs.SaveLgsAdvantageRouteSetResponse;
import com.sunivo.ws.beans.response.lgs.UpdateLgsAdvantageRouteSetResponse;
import com.sunivo.ws.interfaces.server.lgs.ILgsAdvantageRouteSet;

/**
 * 优势航线设置配置控制器<br>
 * 
 * @author wanglei
 * @version 1.0, 2013-11-06
 * @see
 * @since 1.0
 */
@Controller
@RequestMapping("/lgsadvantagerouteset")
public class LgsAdvantageRouteSetController extends BaseController {

	/**
	 * 自动注入优势航线设置配置WS实现
	 */
	@Autowired
	private ILgsAdvantageRouteSet lgsAdvantageRouteSet;

	/**
	 * 去新增优势航线设置配置
	 * 
	 * @return 结果视图
	 */
	@RequestMapping(value = "", params = "action=create")
	public String advantageRouteSetAdd(Model model) {
		return getAutoUrl();
	}

	/**
	 * 新增优势航线设置配置
	 * 
	 * @param lgsAdvantageRouteSet
	 *            优势航线设置配置页面表单对象
	 * @param result
	 *            表单验证数据
	 * @param page
	 *            分页配置
	 * @param request
	 *            请求对象
	 * @return 结果视图
	 */
	@RequestMapping(value = "", method = { RequestMethod.POST })
	public String createLgsAdvantageRouteSet(LgsAdvantageRouteSetVo vo,
			BindingResult result, RedirectAttributes redirectAttributes,
			Model model) {
		LgsAdvantageRouteSetEntity entity = vo.getEntity();
		model.addAttribute("entity", entity);
		// 表单验证无误,进行提交
		if (result.hasErrors()) {
			addErrorMessage(model, result.getAllErrors().toString());
			return getAutoUrl("advantageRouteSetAdd");
		} else {
			SaveLgsAdvantageRouteSetRequest request = new SaveLgsAdvantageRouteSetRequest();
			request.setEntity(entity);
			SaveLgsAdvantageRouteSetResponse response = lgsAdvantageRouteSet
					.saveLgsAdvantageRouteSetAfterCheck(request);
			// 优势航线已经存在
			if (StringUtils.equals(response.getResultCode(),
					Constants.ADVANTAGE_ROUTE_EXIST_CODE)) {
				model.addAttribute("entity", entity);
				addErrorMessage(model, Constants.ADVANTAGE_ROUTE_EXIST_MESSAGE);
				return getAutoUrl("advantageRouteSetAdd");
			}
			// 返回其他错误
			if (!StringUtils.equals(response.getResultCode(),
					Constants.SUCCESS_CODE)) {
				model.addAttribute("entity", entity);
				addErrorMessage(model, Constants.FAIL_MESSAGE);
				return getAutoUrl("advantageRouteSetAdd");
			}
			addSuccessMessage(model, Constants.CREATE_SUCESS_MESSAGE);
			// 重新查出刚插入的entity（这里是为了获取创建人创建时间，修改人修改时间）
			model.addAttribute("entity", getDetailById(response.getId()));
			return getAutoUrl("advantageRouteSetDetail");
		}
	}

	/**
	 * 删除优势航线设置配置
	 * 
	 * @param id
	 *            优势航线设置配置页面表单对象唯一标识
	 * @param page
	 *            分页配置
	 * @param request
	 *            请求对象
	 * @return 结果视图
	 */
	@RequestMapping(value = "/{id}", method = { RequestMethod.DELETE })
	@ResponseStatus(HttpStatus.OK)
	@ResponseBody
	public String delete(@PathVariable Integer id) {

		DeleteLgsAdvantageRouteSetRequest request = new DeleteLgsAdvantageRouteSetRequest();
		request.setId(id);
		DeleteLgsAdvantageRouteSetResponse response = lgsAdvantageRouteSet
				.deleteLgsAdvantageRouteSet(request);
		return response.getResultCode();
	}

	/**
	 * 去查看优势航线设置配置
	 * 
	 * @param id
	 *            优势航线设置配置页面表单对象唯一标识
	 * @param request
	 *            请求对象
	 * @return 结果视图
	 */
	@RequestMapping(value = "/{id}", method = { RequestMethod.GET })
	public String advantageRouteSetDetail(
			@PathVariable(value = "id") Integer id, Model model) {
		model.addAttribute("entity", getDetailById(id));
		return getAutoUrl();
	}

	/*
	 * 根据id获取entity
	 */
	private LgsAdvantageRouteSetEntity getDetailById(Integer id) {
		GetLgsAdvantageRouteSetByIdRequest request = new GetLgsAdvantageRouteSetByIdRequest();
		request.setId(id);
		GetLgsAdvantageRouteSetByIdResponse response = lgsAdvantageRouteSet
				.getLgsAdvantageRouteSetById(request);
		return response.getEntity();
	}

	/**
	 * 去修改优势航线设置配置
	 * 
	 * @param id
	 *            优势航线设置配置页面表单对象唯一标识
	 * @param request
	 *            请求对象
	 * @return 结果视图
	 */
	@RequestMapping(value = "/{id}", method = { RequestMethod.GET }, params = "action=edit")
	public String advantageRouteSetEdit(@PathVariable(value = "id") Integer id,
			Model model) {
		model.addAttribute("entity", getDetailById(id));
		return getAutoUrl();
	}

	/**
	 * 修改优势航线设置配置
	 * 
	 * @param lgsAdvantageRouteSet
	 *            优势航线设置配置页面表单对象
	 * @param result
	 *            表单验证数据
	 * @param page
	 *            分页配置
	 * @param request
	 *            请求对象
	 * @return 结果视图
	 */
	@RequestMapping(value = "/{id}", method = { RequestMethod.POST })
	public String updateLgsAdvantageRouteSet(LgsAdvantageRouteSetVo vo,
			BindingResult result, @PathVariable Integer id,
			RedirectAttributes redirectAttributes, Model model) {
		LgsAdvantageRouteSetEntity entity = vo.getEntity();
		model.addAttribute("entity", entity);
		// 表单验证无误,进行提交
		if (result.hasErrors()) {
			addErrorMessage(model, result.getAllErrors().toString());
			return getAutoUrl("advantageRouteSetEdit");
		} else {
			UpdateLgsAdvantageRouteSetRequest request = new UpdateLgsAdvantageRouteSetRequest();
			request.setEntity(entity);
			UpdateLgsAdvantageRouteSetResponse response = lgsAdvantageRouteSet
					.updateLgsAdvantageRouteSet(request);
			// 业务操作返回错误处理
			if (!StringUtils.equals(response.getResultCode(),
					Constants.SUCCESS_CODE)) {
				addErrorMessage(model, Constants.FAIL_MESSAGE);
				return getAutoUrl("advantageRouteSetEdit");
			}
			addSuccessMessage(model, Constants.EDIT_SUCESS_MESSAGE);
			// 重新查出刚编辑的entity（这里是为了获取修改人修改时间）
			model.addAttribute("entity", getDetailById(id));
			return getAutoUrl("advantageRouteSetDetail");

		}
	}

	/**
	 * 去修改优势航线设置配置
	 * 
	 * @param id
	 *            优势航线设置配置页面表单对象唯一标识
	 * @param statue
	 *            控制disabled字段 （0启用、1删除、2、禁用，disabled字段本来是用来控制逻辑删除的，
	 *            但是这里同时用来控制失效和有效所以多加了一个状态）
	 * @param request
	 *            请求对象
	 * @return 结果视图
	 */
	@RequestMapping(value = "/{id}/{statue}", method = { RequestMethod.POST }, params = "action=edit")
	@ResponseBody
	public String updateDisabledById(@PathVariable(value = "id") Integer id,
			@PathVariable(value = "statue") Integer statue, Model model) {
		GetLgsAdvantageRouteSetByIdResponse response = new GetLgsAdvantageRouteSetByIdResponse();
		response = lgsAdvantageRouteSet.updateDisabledById(id, statue);
		return response.getResultCode();
	}

	/**
	 * 查询优势航线设置配置
	 * 
	 * @param lgsAdvantageRouteSet
	 *            优势航线设置配置页面表单对象
	 * @param page
	 *            分页配置
	 * @param request
	 *            请求对象
	 * @return 结果视图
	 */
	@RequestMapping(value = "", method = RequestMethod.GET)
	public String advantageRouteSetList(Integer number, Model model,
			HttpServletRequest request) {
		// 获取查询条件
		Map<String, Object> searchParams = Servlets.getParametersStartingWith(
				request, "search_");
		Page page = new Page();
		if (null != number) {
			page.setCurrentPage(number);
		}
		ListLgsAdvantageRouteSetRequest listRequest = new ListLgsAdvantageRouteSetRequest();
		/**
		 * 默认情况就是createDatetime desc排序，如果想通过其他字段排序，可在这儿设置
		 */
		listRequest.setOrderColumn("createDatetime");
		listRequest.setOrderMode("desc");

		listRequest.setPaging(page);
		listRequest.setSearchParams(searchParams);
		ListLgsAdvantageRouteSetResponse response = lgsAdvantageRouteSet
				.listLgsAdvantageRouteSet(listRequest);
		if (!StringUtils.equals(response.getResultCode(),
				Constants.SUCCESS_CODE)) {
			addErrorMessage(model,
					Constants.FAIL_MESSAGE + response.getResultMessage());
			return getAutoUrl("advantageRouteSetEdit");
		}
		model.addAttribute("page", response.getPaging());
		model.addAttribute("lgsAddationQuoteInfos", response.getObjectList());
		model.addAttribute("searchParams", Servlets
				.encodeParameterStringWithPrefix(searchParams, "search_"));
		return getAutoUrl();
	}
}
