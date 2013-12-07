/**
 * Description: 基础代理报价费用信息控制器
 * Copyright:   Copyright (c)2013
 * Company:     SUNIVO
 * @author:     // TODO 请使用自己姓名代替
 * @version:    1.0
 * Create at:   2013-11-08 上午 10:48:05
 *  
 * Modification History:
 * Date         Author      Version     Description
 * ------------------------------------------------------------------
 * 2012-12-21   // TODO 请使用自己姓名代替   1.0         Initial
 */
package com.sunivo.lgs.web.controller.lgs;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

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
import com.sunivo.lgs.beans.entity.LgsProxySurchargeEntity;
import com.sunivo.lgs.beans.vo.LgsProxySurchargeVo;
import com.sunivo.lgs.web.base.controller.BaseController;
import com.sunivo.ws.beans.request.lgs.DeleteLgsProxySurchargeRequest;
import com.sunivo.ws.beans.request.lgs.GetLgsProxySurchargeByIdRequest;
import com.sunivo.ws.beans.request.lgs.ListLgsProxySurchargeRequest;
import com.sunivo.ws.beans.request.lgs.SaveLgsProxySurchargeRequest;
import com.sunivo.ws.beans.request.lgs.UpdateLgsProxySurchargeRequest;
import com.sunivo.ws.beans.response.lgs.DeleteLgsProxySurchargeResponse;
import com.sunivo.ws.beans.response.lgs.GetLgsProxySurchargeByIdResponse;
import com.sunivo.ws.beans.response.lgs.ListLgsProxySurchargeResponse;
import com.sunivo.ws.beans.response.lgs.SaveLgsProxySurchargeResponse;
import com.sunivo.ws.beans.response.lgs.UpdateLgsProxySurchargeResponse;
import com.sunivo.ws.interfaces.server.lgs.ILgsProxySurchargeServiceWS;

/**
 * 基础代理报价费用信息控制器<br>
 * 
 * @author // TODO 请使用自己姓名代替
 * @version 1.0, 2013-11-08
 * @see
 * @since 1.0
 */
@Controller
@RequestMapping("/lgsproxysurcharge")
public class LgsProxySurchargeController extends BaseController {

	/**
	 * 自动注入基础代理报价费用信息WS实现
	 */
	@Autowired
	private ILgsProxySurchargeServiceWS lgsProxySurcharge;

	/**
	 * 去新增基础代理报价费用信息
	 * 
	 * @return 结果视图
	 */
	@RequestMapping(value = "", params = "action=create")
	public String createForm(Model model){
		model.addAttribute("action", "create");
		return getAutoUrl("form");
	}

	/**
	 * 新增基础代理报价费用信息
	 * 
	 * @param lgsProxySurcharge 基础代理报价费用信息页面表单对象
	 * @param result 表单验证数据
	 * @param page 分页配置
	 * @param request 请求对象
	 * @return 结果视图
	 */
	@RequestMapping(value = "", method = { RequestMethod.POST})
	public String createLgsProxySurcharge(LgsProxySurchargeVo vo, BindingResult result, RedirectAttributes redirectAttributes, Model model){
		LgsProxySurchargeEntity entity = vo.getEntity();
		model.addAttribute("entity", entity);
		// subValidation(result, entity);
		// 表单验证无误,进行提交
		if (result.hasErrors()) {
            model.addAttribute("action", "create");
            return getAutoUrl("form");
		} else {
		    try {
                SaveLgsProxySurchargeRequest request = new SaveLgsProxySurchargeRequest();
                request.setEntity(entity);
                SaveLgsProxySurchargeResponse response = lgsProxySurcharge
                        .saveLgsProxySurcharge(request);
                Integer id = response.getId();
                return "redirect:/lgsproxysurcharge/" + id;
            } catch (Exception ex) {
                addErrorMessage(model, ex.getMessage());
                model.addAttribute("action", "create");
                return getAutoUrl("form");
            }
		}
	}

	/**
	 * 删除基础代理报价费用信息
	 * 
	 * @param id 基础代理报价费用信息页面表单对象唯一标识
	 * @param page 分页配置
	 * @param request 请求对象
	 * @return 结果视图
	 */
	@RequestMapping(value = "/{id}", method = { RequestMethod.DELETE })
	@ResponseStatus(HttpStatus.OK)
	public void delete(@PathVariable Integer id){
	    DeleteLgsProxySurchargeRequest request = new DeleteLgsProxySurchargeRequest();
        request.setId(id);
        @SuppressWarnings("unused")
        DeleteLgsProxySurchargeResponse response = lgsProxySurcharge
                .deleteLgsProxySurcharge(request);
	}

	/**
	 * 去查看基础代理报价费用信息
	 * 
	 * @param id
	 *            基础代理报价费用信息页面表单对象唯一标识
	 * @param request
	 *            请求对象
	 * @return 结果视图
	 */
	@RequestMapping(value = "/showSection/{id}", method = { RequestMethod.GET })
	public String showSection(@PathVariable(value = "id") Integer id,
			Model model) {
        GetLgsProxySurchargeByIdRequest request = new GetLgsProxySurchargeByIdRequest();
        request.setId(id);
        GetLgsProxySurchargeByIdResponse response = lgsProxySurcharge
                .getLgsProxySurchargeById(request);
        model.addAttribute("entity", response.getEntity());
        return getAutoUrl("form");
	}

	/**
	 * 去修改基础代理报价费用信息
	 * 
	 * @param id 基础代理报价费用信息页面表单对象唯一标识
	 * @param request 请求对象
	 * @return 结果视图
	 */
	@RequestMapping(value = "/editSection/{id}", method = { RequestMethod.GET }, params = "action=edit")
	public String editSection(@PathVariable(value = "id") Integer id,
			Model model) {
        GetLgsProxySurchargeByIdRequest request = new GetLgsProxySurchargeByIdRequest();
        request.setId(id);
        GetLgsProxySurchargeByIdResponse response = lgsProxySurcharge
                .getLgsProxySurchargeById(request);
        model.addAttribute("entity", response.getEntity());
		model.addAttribute("action", "edit");
		return getAutoUrl("form");
	}

	/**
	 * 修改基础代理报价费用信息
	 * 
	 * @param lgsProxySurcharge 基础代理报价费用信息页面表单对象
	 * @param result 表单验证数据
	 * @param page 分页配置
	 * @param request 请求对象
	 * @return 结果视图
	 */
	@RequestMapping(value = "/updateLgsProxySurchargeSection/{id}", method = { RequestMethod.POST })
	public String updateLgsProxySurchargeSection(LgsProxySurchargeVo vo,
			BindingResult result, @PathVariable Integer id,
			RedirectAttributes redirectAttributes, Model model) {
		LgsProxySurchargeEntity entity = vo.getEntity();
		model.addAttribute("entity", entity);
		// subValidation(result, entity);
		// 表单验证无误,进行提交
		if (result.hasErrors()) {
            model.addAttribute("action", "edit");
            return getAutoUrl("form");
		} else {
            try {
                UpdateLgsProxySurchargeRequest request = new UpdateLgsProxySurchargeRequest();
                request.setEntity(entity);
                @SuppressWarnings("unused")
                UpdateLgsProxySurchargeResponse rersponse = lgsProxySurcharge
                        .updateLgsProxySurcharge(request);
                redirectAttributes.addAttribute("message", "更新成功");
                return "redirect:/lgsproxysurcharge/" + entity.getId();
            } catch (Exception ex) {
                addErrorMessage(model, ex.getMessage());
                model.addAttribute("action", "edit");
                return getAutoUrl("form");
            }
		}
	}

	/**
	 * 查询基础代理报价费用信息
	 * 
	 * @param lgsProxySurcharge 基础代理报价费用信息页面表单对象
	 * @param page 分页配置
	 * @param request 请求对象
	 * @return 结果视图
	 */
	@RequestMapping(value = "", method = RequestMethod.GET)
	public String list (Integer number, Model model, HttpServletRequest request) {
		// 获取查询条件
		Map<String, Object> searchParams = Servlets.getParametersStartingWith(
				request, "search_");
		Page page = new Page();
		if (null != number) {
			page.setCurrentPage(number);
		}
		ListLgsProxySurchargeRequest listRequest = new ListLgsProxySurchargeRequest();
        listRequest.setPaging(page);
        listRequest.setSearchParams(searchParams);
        ListLgsProxySurchargeResponse response = lgsProxySurcharge
                .listLgsProxySurcharge(listRequest);
        model.addAttribute("page", response.getPaging());
        model.addAttribute("lgsProxySurcharges", response.getObjectList());
        model.addAttribute("searchParams", Servlets
                .encodeParameterStringWithPrefix(searchParams, "search_"));
		return getAutoUrl();
	}
}
