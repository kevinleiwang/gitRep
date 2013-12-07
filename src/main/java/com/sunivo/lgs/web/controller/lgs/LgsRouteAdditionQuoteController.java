/**
 * Description: 报价按航线加成控制器
 * Copyright:   Copyright (c)2013
 * Company:     SUNIVO
 * @author:     chengjianfang@sunivo.com
 * @version:    1.0
 * Create at:   2013-11-06 下午 13:30:08
 *  
 * Modification History:
 * Date         Author      Version     Description
 * ------------------------------------------------------------------
 * 2012-12-21   chengjianfang@sunivo.com   1.0         Initial
 */
package com.sunivo.lgs.web.controller.lgs;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springside.modules.web.Servlets;

import com.sunivo.base.Page;
import com.sunivo.lgs.beans.entity.LgsRouteAdditionQuoteEntity;
import com.sunivo.lgs.beans.vo.LgsRouteAdditionQuoteVo;
import com.sunivo.lgs.web.base.controller.BaseController;
import com.sunivo.ws.Constants;
import com.sunivo.ws.beans.request.lgs.DeleteLgsRouteAdditionQuoteRequest;
import com.sunivo.ws.beans.request.lgs.GetLgsRouteAdditionQuoteByIdRequest;
import com.sunivo.ws.beans.request.lgs.ListLgsRouteAdditionQuoteRequest;
import com.sunivo.ws.beans.request.lgs.SaveLgsRouteAdditionQuoteRequest;
import com.sunivo.ws.beans.request.lgs.UpdateLgsRouteAdditionQuoteRequest;
import com.sunivo.ws.beans.response.lgs.DeleteLgsRouteAdditionQuoteResponse;
import com.sunivo.ws.beans.response.lgs.GetLgsRouteAdditionQuoteByIdResponse;
import com.sunivo.ws.beans.response.lgs.ListLgsRouteAdditionQuoteResponse;
import com.sunivo.ws.beans.response.lgs.SaveLgsRouteAdditionQuoteResponse;
import com.sunivo.ws.beans.response.lgs.UpdateLgsRouteAdditionQuoteResponse;
import com.sunivo.ws.interfaces.server.lgs.ILgsRouteAdditionQuote;

/**
 * 报价按航线加成控制器<br>
 * 
 * @author chengjianfang@sunivo.com
 * @version 1.0, 2013-11-06
 * @see
 * @since 1.0
 */
@Controller
@RequestMapping("/lgsrouteadditionquote")
public class LgsRouteAdditionQuoteController extends BaseController {

    /**
     * 自动注入报价按航线加成WS实现
     */
    @Autowired
    private ILgsRouteAdditionQuote lgsRouteAdditionQuote;

    /**
     * 去新增报价按航线加成
     * 
     * @return 结果视图
     */
    @RequestMapping(value = "", params = "action=create")
    public String createForm(Model model) {
        model.addAttribute("action", "create");
        return getAutoUrl("form");
    }

    /**
     * 新增报价按航线加成
     * 
     * @param lgsRouteAdditionQuote
     *            报价按航线加成页面表单对象
     * @param result
     *            表单验证数据
     * @param page
     *            分页配置
     * @param request
     *            请求对象
     * @return 结果视图
     */
    @RequestMapping(value = "", method = { RequestMethod.POST })
    public String createLgsRouteAdditionQuote(LgsRouteAdditionQuoteVo vo,
            BindingResult result, RedirectAttributes redirectAttributes,
            Model model) {
        LgsRouteAdditionQuoteEntity entity = vo.getEntity();
        model.addAttribute("entity", entity);
        // subValidation(result, entity);
        // 表单验证无误,进行提交
        if (result.hasErrors()) {
            model.addAttribute("action", "create");
            return getAutoUrl("form");
        } else {
            try {
                SaveLgsRouteAdditionQuoteRequest request = new SaveLgsRouteAdditionQuoteRequest();
                request.setEntity(entity);
                SaveLgsRouteAdditionQuoteResponse response = lgsRouteAdditionQuote
                        .saveLgsRouteAdditionQuote(request);
                String resultCode = response.getResultCode();
                if (Constants.CREATE_SUCESS_CODE.equals(resultCode)) {
                    Integer id = response.getId();
                    return "redirect:/lgsrouteadditionquote/" + id;
                } else {
                    addErrorMessage(model, response.getResultMessage());
                    model.addAttribute("action", "create");
                    return getAutoUrl("form");
                }
            } catch (Exception ex) {
                addErrorMessage(model, ex.getMessage());
                model.addAttribute("action", "create");
                return getAutoUrl("form");
            }
        }
    }

    /**
     * 删除报价按航线加成
     * 
     * @param id
     *            报价按航线加成页面表单对象唯一标识
     * @param page
     *            分页配置
     * @param request
     *            请求对象
     * @return 结果视图
     */
    @RequestMapping(value = "/{id}", method = { RequestMethod.GET }, params = "action=delete")
    public String delete(@PathVariable Integer id, Model model,
            HttpServletRequest httpRequest) {
        DeleteLgsRouteAdditionQuoteRequest request = new DeleteLgsRouteAdditionQuoteRequest();
        request.setId(id);
        DeleteLgsRouteAdditionQuoteResponse response = lgsRouteAdditionQuote
                .deleteLgsRouteAdditionQuote(request);
        if (Constants.DELETE_SUCESS_CODE.equals(response.getResultCode())) {
            addSuccessMessage(model, response.getResultMessage());
        } else {
            addErrorMessage(model, response.getResultMessage());
        }
        return list(null, model, httpRequest);
    }

    /**
     * 去查看报价按航线加成
     * 
     * @param id
     *            报价按航线加成页面表单对象唯一标识
     * @param request
     *            请求对象
     * @return 结果视图
     */
    @RequestMapping(value = "/{id}", method = { RequestMethod.GET })
    public String showForm(@PathVariable(value = "id") Integer id, Model model) {
        GetLgsRouteAdditionQuoteByIdRequest request = new GetLgsRouteAdditionQuoteByIdRequest();
        request.setId(id);
        GetLgsRouteAdditionQuoteByIdResponse response = lgsRouteAdditionQuote
                .getLgsRouteAdditionQuoteById(request);
        model.addAttribute("entity", response.getEntity());
        return getAutoUrl("form");
    }

    /**
     * 去修改报价按航线加成
     * 
     * @param id
     *            报价按航线加成页面表单对象唯一标识
     * @param request
     *            请求对象
     * @return 结果视图
     */
    @RequestMapping(value = "/{id}", method = { RequestMethod.GET }, params = "action=edit")
    public String updateForm(@PathVariable(value = "id") Integer id, Model model) {
        GetLgsRouteAdditionQuoteByIdRequest request = new GetLgsRouteAdditionQuoteByIdRequest();
        request.setId(id);
        GetLgsRouteAdditionQuoteByIdResponse response = lgsRouteAdditionQuote
                .getLgsRouteAdditionQuoteById(request);
        model.addAttribute("entity", response.getEntity());
        model.addAttribute("action", "edit");
        return getAutoUrl("form");
    }

    /**
     * 修改报价按航线加成
     * 
     * @param lgsRouteAdditionQuote
     *            报价按航线加成页面表单对象
     * @param result
     *            表单验证数据
     * @param page
     *            分页配置
     * @param request
     *            请求对象
     * @return 结果视图
     */
    @RequestMapping(value = "/{id}", method = { RequestMethod.POST })
    public String updateLgsRouteAdditionQuote(LgsRouteAdditionQuoteVo vo,
            BindingResult result, @PathVariable Integer id,
            RedirectAttributes redirectAttributes, Model model) {
        LgsRouteAdditionQuoteEntity entity = vo.getEntity();
        model.addAttribute("entity", entity);
        // subValidation(result, entity);
        // 表单验证无误,进行提交
        if (result.hasErrors()) {
            model.addAttribute("action", "edit");
            return getAutoUrl("form");
        } else {
            try {
                UpdateLgsRouteAdditionQuoteRequest request = new UpdateLgsRouteAdditionQuoteRequest();
                request.setEntity(entity);
                UpdateLgsRouteAdditionQuoteResponse response = lgsRouteAdditionQuote
                        .updateLgsRouteAdditionQuote(request);
                String resultCode = response.getResultCode();
                if (Constants.EDIT_SUCESS_CODE.equals(resultCode)) {
                    addSuccessMessage(model, "更新成功");
                    return "redirect:/lgsrouteadditionquote/" + entity.getId();
                } else {
                    addErrorMessage(model, response.getResultMessage());
                    model.addAttribute("action", "edit");
                    return getAutoUrl("form");
                }
            } catch (Exception ex) {
                addErrorMessage(model, ex.getMessage());
                model.addAttribute("action", "edit");
                return getAutoUrl("form");
            }
        }
    }

    /**
     * 查询报价按航线加成
     * 
     * @param lgsRouteAdditionQuote
     *            报价按航线加成页面表单对象
     * @param page
     *            分页配置
     * @param request
     *            请求对象
     * @return 结果视图
     */
    @RequestMapping(value = "", method = RequestMethod.GET)
    public String list(Integer number, Model model, HttpServletRequest request) {
        // 获取查询条件
        Map<String, Object> searchParams = Servlets.getParametersStartingWith(
                request, "search_");
        Page page = new Page();
        if (null != number) {
            page.setCurrentPage(number);
        }
        ListLgsRouteAdditionQuoteRequest listRequest = new ListLgsRouteAdditionQuoteRequest();
        listRequest.setPaging(page);
        listRequest.setSearchParams(searchParams);
        ListLgsRouteAdditionQuoteResponse response = lgsRouteAdditionQuote
                .listLgsRouteAdditionQuote(listRequest);
        model.addAttribute("page", response.getPaging());
        model.addAttribute("lgsRouteAdditionQuotes", response.getObjectList());
        model.addAttribute("searchParams", Servlets
                .encodeParameterStringWithPrefix(searchParams, "search_"));
        return getAutoUrl();
    }
}
