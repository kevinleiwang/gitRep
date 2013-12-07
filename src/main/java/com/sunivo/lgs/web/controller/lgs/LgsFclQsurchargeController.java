/**
 * Description: 海运整箱报价费用信息  包含本地费 附加费 海运费 三种费用详情信息控制器
 * Copyright:   Copyright (c)2013
 * Company:     SUNIVO
 * @author:     // TODO 请使用自己姓名代替
 * @version:    1.0
 * Create at:   2013-11-06 上午 09:26:28
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
import com.sunivo.lgs.beans.entity.LgsFclQsurchargeEntity;
import com.sunivo.lgs.beans.vo.LgsFclQsurchargeVo;
import com.sunivo.lgs.web.base.controller.BaseController;
import com.sunivo.ws.beans.request.lgs.DeleteLgsFclQsurchargeRequest;
import com.sunivo.ws.beans.request.lgs.GetLgsFclQsurchargeByIdRequest;
import com.sunivo.ws.beans.request.lgs.ListLgsFclQsurchargeRequest;
import com.sunivo.ws.beans.request.lgs.SaveLgsFclQsurchargeRequest;
import com.sunivo.ws.beans.request.lgs.UpdateLgsFclQsurchargeRequest;
import com.sunivo.ws.beans.response.lgs.DeleteLgsFclQsurchargeResponse;
import com.sunivo.ws.beans.response.lgs.GetLgsFclQsurchargeByIdResponse;
import com.sunivo.ws.beans.response.lgs.ListLgsFclQsurchargeResponse;
import com.sunivo.ws.beans.response.lgs.SaveLgsFclQsurchargeResponse;
import com.sunivo.ws.beans.response.lgs.UpdateLgsFclQsurchargeResponse;
import com.sunivo.ws.interfaces.server.lgs.ILgsFclQsurchargeServiceWS;

/**
 * 海运整箱报价费用信息  包含本地费 附加费 海运费 三种费用详情信息控制器<br>
 * 
 * @author // TODO 请使用自己姓名代替
 * @version 1.0, 2013-11-06
 * @see
 * @since 1.0
 */
@Controller
@RequestMapping("/lgsfclqsurcharge")
public class LgsFclQsurchargeController extends BaseController {

	/**
	 * 自动注入海运整箱报价费用信息  包含本地费 附加费 海运费 三种费用详情信息WS实现
	 */
	@Autowired
	private ILgsFclQsurchargeServiceWS lgsFclQsurcharge;

	/**
	 * 去新增海运整箱报价费用信息  包含本地费 附加费 海运费 三种费用详情信息
	 * 
	 * @return 结果视图
	 */
	@RequestMapping(value = "", params = "action=create")
	public String createForm(Model model){
		model.addAttribute("action", "create");
		return getAutoUrl("form");
	}

	/**
	 * 新增海运整箱报价费用信息  包含本地费 附加费 海运费 三种费用详情信息
	 * 
	 * @param lgsFclQsurcharge 海运整箱报价费用信息  包含本地费 附加费 海运费 三种费用详情信息页面表单对象
	 * @param result 表单验证数据
	 * @param page 分页配置
	 * @param request 请求对象
	 * @return 结果视图
	 */
	@RequestMapping(value = "", method = { RequestMethod.POST})
	public String createLgsFclQsurcharge(LgsFclQsurchargeVo vo, BindingResult result, RedirectAttributes redirectAttributes, Model model){
		LgsFclQsurchargeEntity entity = vo.getEntity();
		model.addAttribute("entity", entity);
		// subValidation(result, entity);
		// 表单验证无误,进行提交
		if (result.hasErrors()) {
            model.addAttribute("action", "create");
            return getAutoUrl("form");
		} else {
		    try {
                SaveLgsFclQsurchargeRequest request = new SaveLgsFclQsurchargeRequest();
                request.setEntity(entity);
                SaveLgsFclQsurchargeResponse response = lgsFclQsurcharge
                        .saveLgsFclQsurcharge(request);
                Integer id = response.getId();
                return "redirect:/classNameAllLower/" + id;
            } catch (Exception ex) {
                addErrorMessage(model, ex.getMessage());
                model.addAttribute("action", "create");
                return getAutoUrl("form");
            }
		}
	}

	/**
	 * 删除海运整箱报价费用信息  包含本地费 附加费 海运费 三种费用详情信息
	 * 
	 * @param id 海运整箱报价费用信息  包含本地费 附加费 海运费 三种费用详情信息页面表单对象唯一标识
	 * @param page 分页配置
	 * @param request 请求对象
	 * @return 结果视图
	 */
	@RequestMapping(value = "/{id}", method = { RequestMethod.DELETE })
	@ResponseStatus(HttpStatus.OK)
	public void delete(@PathVariable Integer id){
	    DeleteLgsFclQsurchargeRequest request = new DeleteLgsFclQsurchargeRequest();
        request.setId(id);
        @SuppressWarnings("unused")
        DeleteLgsFclQsurchargeResponse response = lgsFclQsurcharge
                .deleteLgsFclQsurcharge(request);
	}

	/**
	 * 去查看海运整箱报价费用信息  包含本地费 附加费 海运费 三种费用详情信息
	 * 
	 * @param id
	 *            海运整箱报价费用信息  包含本地费 附加费 海运费 三种费用详情信息页面表单对象唯一标识
	 * @param request
	 *            请求对象
	 * @return 结果视图
	 */
	@RequestMapping(value = "/{id}", method = { RequestMethod.GET })
	public String showForm(@PathVariable(value = "id") Integer id, Model model) {
        GetLgsFclQsurchargeByIdRequest request = new GetLgsFclQsurchargeByIdRequest();
        request.setId(id);
        GetLgsFclQsurchargeByIdResponse response = lgsFclQsurcharge
                .getLgsFclQsurchargeById(request);
        model.addAttribute("entity", response.getEntity());
        return getAutoUrl("form");
	}

	/**
	 * 去修改海运整箱报价费用信息  包含本地费 附加费 海运费 三种费用详情信息
	 * 
	 * @param id 海运整箱报价费用信息  包含本地费 附加费 海运费 三种费用详情信息页面表单对象唯一标识
	 * @param request 请求对象
	 * @return 结果视图
	 */
	@RequestMapping(value = "/{id}", method = { RequestMethod.GET}, params = "action=edit")
	public String updateForm(@PathVariable(value = "id") Integer id, Model model){
        GetLgsFclQsurchargeByIdRequest request = new GetLgsFclQsurchargeByIdRequest();
        request.setId(id);
        GetLgsFclQsurchargeByIdResponse response = lgsFclQsurcharge
                .getLgsFclQsurchargeById(request);
        model.addAttribute("entity", response.getEntity());
		model.addAttribute("action", "edit");
		return getAutoUrl("form");
	}

	/**
	 * 修改海运整箱报价费用信息  包含本地费 附加费 海运费 三种费用详情信息
	 * 
	 * @param lgsFclQsurcharge 海运整箱报价费用信息  包含本地费 附加费 海运费 三种费用详情信息页面表单对象
	 * @param result 表单验证数据
	 * @param page 分页配置
	 * @param request 请求对象
	 * @return 结果视图
	 */
	@RequestMapping(value = "/{id}", method = { RequestMethod.POST})
	public String updateLgsFclQsurcharge(LgsFclQsurchargeVo vo, BindingResult result, @PathVariable Integer id, RedirectAttributes redirectAttributes, Model model){
		LgsFclQsurchargeEntity entity = vo.getEntity();
		model.addAttribute("entity", entity);
		// subValidation(result, entity);
		// 表单验证无误,进行提交
		if (result.hasErrors()) {
            model.addAttribute("action", "edit");
            return getAutoUrl("form");
		} else {
            try {
                UpdateLgsFclQsurchargeRequest request = new UpdateLgsFclQsurchargeRequest();
                request.setEntity(entity);
                @SuppressWarnings("unused")
                UpdateLgsFclQsurchargeResponse rersponse = lgsFclQsurcharge
                        .updateLgsFclQsurcharge(request);
                redirectAttributes.addAttribute("message", "更新成功");
                return "redirect:/lgsfclqsurcharge/" + entity.getId();
            } catch (Exception ex) {
                addErrorMessage(model, ex.getMessage());
                model.addAttribute("action", "edit");
                return getAutoUrl("form");
            }
		}
	}

	/**
	 * 查询海运整箱报价费用信息  包含本地费 附加费 海运费 三种费用详情信息
	 * 
	 * @param lgsFclQsurcharge 海运整箱报价费用信息  包含本地费 附加费 海运费 三种费用详情信息页面表单对象
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
		ListLgsFclQsurchargeRequest listRequest = new ListLgsFclQsurchargeRequest();
        listRequest.setPaging(page);
        listRequest.setSearchParams(searchParams);
        ListLgsFclQsurchargeResponse response = lgsFclQsurcharge
                .listLgsFclQsurcharge(listRequest);
        request.setAttribute("page", response.getPaging());
        request.setAttribute("lgsAddationQuoteInfos", response.getObjectList());
        model.addAttribute("searchParams", Servlets
                .encodeParameterStringWithPrefix(searchParams, "search_"));
		return getAutoUrl();
	}
}
