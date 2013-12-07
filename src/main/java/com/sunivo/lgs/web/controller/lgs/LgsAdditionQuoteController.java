/**
 * Description: LgsAdditionQuote控制器
 * Copyright:   Copyright (c)2013
 * Company:     SUNIVO
 * @author:     // TODO 请使用自己姓名代替
 * @version:    1.0
 * Create at:   2013-11-08 上午 10:47:51
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
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springside.modules.web.Servlets;

import com.sunivo.base.Page;
import com.sunivo.lgs.beans.entity.LgsAdditionQuoteEntity;
import com.sunivo.lgs.beans.vo.LgsAdditionQuoteVo;
import com.sunivo.lgs.web.base.controller.BaseController;
import com.sunivo.ws.beans.request.lgs.GetLgsAdditionQuoteByIdRequest;
import com.sunivo.ws.beans.request.lgs.ListLgsAdditionQuoteRequest;
import com.sunivo.ws.beans.request.lgs.SaveLgsAdditionQuoteRequest;
import com.sunivo.ws.beans.request.lgs.UpdateLgsAdditionQuoteRequest;
import com.sunivo.ws.beans.request.som.GetOrdInfoByOrdCodeRequest;
import com.sunivo.ws.beans.response.lgs.GetLgsAdditionQuoteByIdResponse;
import com.sunivo.ws.beans.response.lgs.ListLgsAdditionQuoteResponse;
import com.sunivo.ws.beans.response.lgs.SaveLgsAdditionQuoteResponse;
import com.sunivo.ws.beans.response.lgs.UpdateLgsAdditionQuoteResponse;
import com.sunivo.ws.beans.response.som.ListOrdInfoResponse;
import com.sunivo.ws.interfaces.server.lgs.ILgsAdditionQuoteServiceWS;
import com.sunivo.ws.interfaces.server.lgs.ILgsInquiryServiceWS;
import com.sunivo.ws.interfaces.server.som.IOrdInfoServiceWS;

/**
 * LgsAdditionQuote控制器<br>
 * 
 * @author // TODO 请使用自己姓名代替
 * @version 1.0, 2013-11-08
 * @see
 * @since 1.0
 */
@Controller
@RequestMapping("/lgsadditionquote")
public class LgsAdditionQuoteController extends BaseController {

    /**
     * 自动注入LgsAdditionQuoteWS实现
     */
    @Autowired
    private ILgsAdditionQuoteServiceWS lgsAdditionQuote;
    @Autowired
    private IOrdInfoServiceWS ordInfoServiceWS;
    @Autowired
    private ILgsInquiryServiceWS lgsInquiryServiceWS;

    /**
     * 去新增LgsAdditionQuote
     * 
     * @return 结果视图
     */
    @RequestMapping(value = "", params = "action=create")
    public String createForm(Model model) {
        model.addAttribute("action", "create");
        return getAutoUrl("form");
    }

    /**
     * 新增LgsAdditionQuote
     * 
     * @param lgsAdditionQuote
     *            LgsAdditionQuote页面表单对象
     * @param result
     *            表单验证数据
     * @param page
     *            分页配置
     * @param request
     *            请求对象
     * @return 结果视图
     */
    @RequestMapping(value = "", method = { RequestMethod.POST })
    public String createLgsAdditionQuote(LgsAdditionQuoteVo vo,
            BindingResult result, RedirectAttributes redirectAttributes,
            Model model) {
        LgsAdditionQuoteEntity entity = vo.getEntity();
        model.addAttribute("entity", entity);
        // subValidation(result, entity);
        // 表单验证无误,进行提交
        if (result.hasErrors()) {
            model.addAttribute("action", "create");
            return getAutoUrl("form");
        } else {
            try {
                SaveLgsAdditionQuoteRequest request = new SaveLgsAdditionQuoteRequest();
                request.setEntity(entity);
                SaveLgsAdditionQuoteResponse response = lgsAdditionQuote
                        .saveLgsAdditionQuote(request);
                Integer id = response.getId();
                return "redirect:/lgsadditionquote/showSection/" + id;
            } catch (Exception ex) {
                addErrorMessage(model, ex.getMessage());
                model.addAttribute("action", "create");
                return getAutoUrl("form");
            }
        }
    }

    /**
     * 去查看LgsAdditionQuote
     * 
     * @param id
     *            LgsAdditionQuote页面表单对象唯一标识
     * @param request
     *            请求对象
     * @return 结果视图
     */
    @RequestMapping(value = "/showSection/{id}", method = { RequestMethod.POST })
    public String showSection(@PathVariable(value = "id") Integer id,
            Model model) {
        GetLgsAdditionQuoteByIdRequest request = new GetLgsAdditionQuoteByIdRequest();
        request.setId(id);
        GetLgsAdditionQuoteByIdResponse response = lgsAdditionQuote
                .getLgsAdditionQuoteById(request);
        model.addAttribute("entity", response.getEntity());
        return getAutoUrl("form");
    }

    /**
     * 去修改LgsAdditionQuote
     * 
     * @param id
     *            LgsAdditionQuote页面表单对象唯一标识
     * @param request
     *            请求对象
     * @return 结果视图
     */
    @RequestMapping(value = "/editSection/{id}", method = { RequestMethod.POST }, params = "action=edit")
    public String editSection(@PathVariable(value = "id") Integer id,
            Model model) {
        GetLgsAdditionQuoteByIdRequest request = new GetLgsAdditionQuoteByIdRequest();
        request.setId(id);
        GetLgsAdditionQuoteByIdResponse response = lgsAdditionQuote
                .getLgsAdditionQuoteById(request);
        model.addAttribute("entity", response.getEntity());
        model.addAttribute("action", "edit");
        return getAutoUrl("form");
    }

    /**
     * 修改LgsAdditionQuote
     * 
     * @param lgsAdditionQuote
     *            LgsAdditionQuote页面表单对象
     * @param result
     *            表单验证数据
     * @param page
     *            分页配置
     * @param request
     *            请求对象
     * @return 结果视图
     */
    @RequestMapping(value = "/updateLgsAdditionQuoteSection/{id}", method = { RequestMethod.POST })
    public String updateLgsAdditionQuoteSection(LgsAdditionQuoteVo vo,
            BindingResult result, @PathVariable Integer id,
            RedirectAttributes redirectAttributes, Model model) {
        LgsAdditionQuoteEntity entity = vo.getEntity();
        model.addAttribute("entity", entity);
        // subValidation(result, entity);
        // 表单验证无误,进行提交
        if (result.hasErrors()) {
            model.addAttribute("action", "edit");
            return getAutoUrl("form");
        } else {
            try {
                UpdateLgsAdditionQuoteRequest request = new UpdateLgsAdditionQuoteRequest();
                request.setEntity(entity);
                @SuppressWarnings("unused")
                UpdateLgsAdditionQuoteResponse rersponse = lgsAdditionQuote
                        .updateLgsAdditionQuote(request);
                redirectAttributes.addAttribute("message", "更新成功");
                return "redirect:/lgsadditionquote/" + entity.getId();
            } catch (Exception ex) {
                addErrorMessage(model, ex.getMessage());
                model.addAttribute("action", "edit");
                return getAutoUrl("form");
            }
        }
    }

    /**
     * 查询LgsAdditionQuote
     * 
     * @param lgsAdditionQuote
     *            LgsAdditionQuote页面表单对象
     * @param page
     *            分页配置
     * @param request
     *            请求对象
     * @return 结果视图
     */
    @RequestMapping(value = "inquiryList", method = RequestMethod.GET)
    public String inquiryList(Integer number, Model model,
            HttpServletRequest request) {
        // 获取查询条件
        Map<String, Object> searchParams = Servlets.getParametersStartingWith(
                request, "search_");
        Page page = new Page();
        if (null != number) {
            page.setCurrentPage(number);
        }
        if (StringUtils.isNotEmpty((String) searchParams
                .get("LIKE_inquiryCode"))) {
            searchParams.put("LIKE_inquiryCode",
                    ((String) searchParams.get("LIKE_inquiryCode")).trim());
        }
        String orderCode = (String) searchParams.get("LIKE_orderCode");
        ListOrdInfoResponse ordRes = new ListOrdInfoResponse();
        if (StringUtils.isNotEmpty(orderCode)) {
            GetOrdInfoByOrdCodeRequest ordRequest = new GetOrdInfoByOrdCodeRequest();
            ordRequest.setOrderCode(orderCode.trim());
            ordRes = ordInfoServiceWS.getByOrderCode(ordRequest);
            if (ordRes != null && ordRes.getObjectList().size() > 0) {
                StringBuffer orderIdStr = new StringBuffer();
                int ordInfoSize = ordRes.getObjectList().size();
                for (int i = 0; i < (ordInfoSize - 1); i++) {
                    orderIdStr.append(ordRes.getObjectList().get(i).getId());
                    orderIdStr.append(",");
                }
                orderIdStr.append(ordRes.getObjectList().get(ordInfoSize - 1)
                        .getId());
                searchParams.put("EQ_orderIds", orderIdStr.toString());
            } else {
                searchParams.put("EQ_orderIds", "0");
            }
        }

        if (StringUtils.isNotEmpty((String) searchParams.get("LIKE_orderId"))) {
            searchParams.put("LIKE_orderId",
                    ((String) searchParams.get("LIKE_orderId")).trim());
        }

        ListLgsAdditionQuoteRequest listRequest = new ListLgsAdditionQuoteRequest();
        listRequest.setPaging(page);
        listRequest.setSearchParams(searchParams);
        ListLgsAdditionQuoteResponse response = lgsAdditionQuote
                .listLgsAdditionQuote(listRequest);
        model.addAttribute("page", response.getPaging());
        model.addAttribute("lgsInquirysVo", response.getObjectList());
        model.addAttribute("searchParams", Servlets
                .encodeParameterStringWithPrefix(searchParams, "search_"));
        return getAutoUrl();
    }
}
