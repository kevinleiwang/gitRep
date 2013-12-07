/**
 * Description: 海运整箱附加费报价信息控制器
 * Copyright:   Copyright (c)2013
 * Company:     SUNIVO
 * @author:     chengjianfang@sunivo.com
 * @version:    1.0
 * Create at:   2013-11-06 上午 09:26:19
 *  
 * Modification History:
 * Date         Author      Version     Description
 * ------------------------------------------------------------------
 * 2012-12-21   chengjianfang@sunivo.com   1.0         Initial
 */
package com.sunivo.lgs.web.controller.lgs;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springside.modules.web.Servlets;

import com.sunivo.base.Page;
import com.sunivo.lgs.beans.entity.LgsFclQsurchargeEntity;
import com.sunivo.lgs.beans.vo.LgsAddationQuoteInfoVo;
import com.sunivo.lgs.web.base.controller.BaseController;
import com.sunivo.uim.beans.entity.PrdQuoteEntity;
import com.sunivo.ws.Constants;
import com.sunivo.ws.beans.request.lgs.DeleteLgsFclQsurchargeRequest;
import com.sunivo.ws.beans.request.lgs.GetLgsAddationQuoteInfoByIdRequest;
import com.sunivo.ws.beans.request.lgs.ListLgsAddationQuoteInfoRequest;
import com.sunivo.ws.beans.request.lgs.SaveLgsAddationQuoteInfoRequest;
import com.sunivo.ws.beans.request.lgs.UpdateLgsAddationQuoteInfoRequest;
import com.sunivo.ws.beans.request.lgs.UpdateLgsFclQsurchargeRequest;
import com.sunivo.ws.beans.request.uim.GetCurrencyByIdRequest;
import com.sunivo.ws.beans.request.uim.PrdQuoteRequest;
import com.sunivo.ws.beans.request.uim.UnitRequest;
import com.sunivo.ws.beans.response.lgs.DeleteLgsFclQsurchargeResponse;
import com.sunivo.ws.beans.response.lgs.GetLgsAddationQuoteInfoByIdResponse;
import com.sunivo.ws.beans.response.lgs.ListLgsAddationQuoteInfoResponse;
import com.sunivo.ws.beans.response.lgs.SaveLgsAddationQuoteInfoResponse;
import com.sunivo.ws.beans.response.lgs.UpdateLgsAddationQuoteInfoResponse;
import com.sunivo.ws.beans.response.lgs.UpdateLgsFclQsurchargeResponse;
import com.sunivo.ws.beans.response.uim.GetCurrencyByIdResponse;
import com.sunivo.ws.beans.response.uim.PrdQuoteResponse;
import com.sunivo.ws.beans.response.uim.UnitResponse;
import com.sunivo.ws.interfaces.server.lgs.ILgsAddationQuoteInfo;
import com.sunivo.ws.interfaces.server.lgs.ILgsFclQsurchargeServiceWS;
import com.sunivo.ws.interfaces.server.uim.ICurrency;
import com.sunivo.ws.interfaces.server.uim.IPrdQuoteServiceWS;
import com.sunivo.ws.interfaces.server.uim.IUnitServiceWS;

/**
 * 海运整箱附加费报价信息控制器<br>
 * 
 * @author chengjianfang@sunivo.com
 * @version 1.0, 2013-11-06
 * @see
 * @since 1.0
 */
@Controller
@RequestMapping("/lgsaddationquoteinfo")
public class LgsAddationQuoteInfoController extends BaseController {

    /**
     * 自动注入海运整箱附加费报价信息WS实现
     */
    @Autowired
    private ILgsAddationQuoteInfo lgsAddationQuoteInfo;

    /**
     * 自动注入海整详情信息WS实现
     */
    @Autowired
    private ILgsFclQsurchargeServiceWS fclQsurchargeServiceWS;

    @Autowired
    private IPrdQuoteServiceWS quoteService;

    @Autowired
    private ICurrency currency;

    @Autowired
    private IUnitServiceWS unit;

    /**
     * 启用/禁用记录
     * 
     * @return 结果视图
     */
    @RequestMapping(value = "changeStatus", method = { RequestMethod.POST })
    @ResponseBody
    public String changeStatus(Integer id, Integer status, Model model) {
        UpdateLgsFclQsurchargeRequest request = new UpdateLgsFclQsurchargeRequest();
        LgsFclQsurchargeEntity entity = new LgsFclQsurchargeEntity();
        entity.setId(id);
        entity.setStatus(status);
        request.setEntity(entity);
        UpdateLgsFclQsurchargeResponse response = fclQsurchargeServiceWS
                .changeStatus(request);
        if (Constants.EDIT_SUCESS_CODE.equals(response.getResultCode())) {
            return "{\"status\": \"OK\", \"message\": \"状态更新成功\"}";
        } else {
            return "{\"status\": \"FAIL\", \"message\": \"状态更新失败\"}";
        }
    }

    /**
     * 去新增海运整箱附加费报价信息
     * 
     * @return 结果视图
     */
    @RequestMapping(value = "", params = "action=create")
    public String createForm(Model model) {
        model.addAttribute("action", "create");
        return getAutoUrl("form");
    }

    /**
     * 新增海运整箱附加费报价信息
     * 
     * @param lgsAddationQuoteInfo
     *            海运整箱附加费报价信息页面表单对象
     * @param result
     *            表单验证数据
     * @param page
     *            分页配置
     * @param request
     *            请求对象
     * @return 结果视图
     */
    @RequestMapping(value = "", method = { RequestMethod.POST })
    public String createLgsAddationQuoteInfo(LgsAddationQuoteInfoVo vo,
            BindingResult result, RedirectAttributes redirectAttributes,
            Model model) {
        model.addAttribute("vo", vo);
        // subValidation(result, entity);
        // 表单验证无误,进行提交
        if (result.hasErrors()) {
            model.addAttribute("action", "create");
            return getAutoUrl("form");
        } else {
            try {
                SaveLgsAddationQuoteInfoRequest request = new SaveLgsAddationQuoteInfoRequest();
                request.setVo(vo);
                SaveLgsAddationQuoteInfoResponse response = lgsAddationQuoteInfo
                        .saveLgsAddationQuoteInfo(request);
                // 获取结果码
                String resultCode = response.getResultCode();
                if (Constants.CREATE_SUCESS_CODE.equals(resultCode)) {
                    Integer id = response.getId();
                    addSuccessMessage(model, response.getResultMessage());
                    return showForm(id, model);
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
     * 删除海运整箱附加费报价信息
     * 
     * @param id
     *            <font color="red">明细ID</font>
     * @param page
     *            分页配置
     * @param request
     *            请求对象
     * @return 结果视图
     */
    @RequestMapping(value = "/{id}", method = { RequestMethod.GET }, params = "action=delete")
    public String delete(@PathVariable Integer id, Model model,
            HttpServletRequest httpRequest) {
        DeleteLgsFclQsurchargeRequest request = new DeleteLgsFclQsurchargeRequest();
        request.setId(id);
        DeleteLgsFclQsurchargeResponse response = fclQsurchargeServiceWS
                .deleteById(request);
        if (Constants.DELETE_SUCESS_CODE.equals(response.getResultCode())) {
            addSuccessMessage(model, response.getResultMessage());
        } else {
            addErrorMessage(model, response.getResultMessage());
        }
        return list(null, model, httpRequest);
    }

    /**
     * 去查看海运整箱附加费报价信息
     * 
     * @param id
     *            <font color="red">明细ID</font>
     * @param request
     *            请求对象
     * @return 结果视图
     */
    @RequestMapping(value = "/{id}", method = { RequestMethod.GET })
    public String showForm(@PathVariable(value = "id") Integer id, Model model) {
        GetLgsAddationQuoteInfoByIdRequest request = new GetLgsAddationQuoteInfoByIdRequest();
        request.setId(id);
        GetLgsAddationQuoteInfoByIdResponse response = lgsAddationQuoteInfo
                .getLgsAddationQuoteInfoById(request);
        model.addAttribute("vo", response.getVo());
        return getAutoUrl("form");
    }

    /**
     * 去修改海运整箱附加费报价信息
     * 
     * @param id
     *            <font color="red">明细ID</font>
     * @param request
     *            请求对象
     * @return 结果视图
     */
    @RequestMapping(value = "/{id}", method = { RequestMethod.GET }, params = "action=edit")
    public String updateForm(@PathVariable(value = "id") Integer id, Model model) {
        GetLgsAddationQuoteInfoByIdRequest request = new GetLgsAddationQuoteInfoByIdRequest();
        request.setId(id);
        GetLgsAddationQuoteInfoByIdResponse response = lgsAddationQuoteInfo
                .getLgsAddationQuoteInfoById(request);
        model.addAttribute("vo", response.getVo());
        model.addAttribute("action", "edit");
        return getAutoUrl("form");
    }

    /**
     * 修改海运整箱附加费报价信息
     * 
     * @param lgsAddationQuoteInfo
     *            海运整箱附加费报价信息页面表单对象
     * @param result
     *            表单验证数据
     * @param page
     *            分页配置
     * @param request
     *            请求对象
     * @return 结果视图
     */
    @RequestMapping(value = "/{id}", method = { RequestMethod.POST })
    public String updateLgsAddationQuoteInfo(LgsAddationQuoteInfoVo vo,
            BindingResult result, @PathVariable Integer id,
            RedirectAttributes redirectAttributes, Model model) {
        model.addAttribute("vo", vo);
        // subValidation(result, entity);
        // 表单验证无误,进行提交
        if (result.hasErrors()) {
            model.addAttribute("action", "edit");
            return getAutoUrl("form");
        } else {
            try {
                UpdateLgsAddationQuoteInfoRequest request = new UpdateLgsAddationQuoteInfoRequest();
                request.setVo(vo);
                UpdateLgsAddationQuoteInfoResponse response = lgsAddationQuoteInfo
                        .updateLgsAddationQuoteInfo(request);
                if (Constants.EDIT_SUCESS_CODE.equals(response.getResultCode())) {
                    addSuccessMessage(model, response.getResultMessage());
                    return showForm(id, model);
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
     * 查询海运整箱附加费报价信息
     * 
     * @param lgsAddationQuoteInfo
     *            海运整箱附加费报价信息页面表单对象
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
        ListLgsAddationQuoteInfoRequest listRequest = new ListLgsAddationQuoteInfoRequest();
        listRequest.setPaging(page);
        listRequest.setSearchParams(searchParams);
        ListLgsAddationQuoteInfoResponse response = lgsAddationQuoteInfo
                .listLgsAddationQuoteInfo(listRequest);
        model.addAttribute("page", response.getPaging());
        model.addAttribute("vos", response.getObjectList());
        model.addAttribute("searchParams", Servlets
                .encodeParameterStringWithPrefix(searchParams, "search_"));
        return getAutoUrl();
    }

    /**
     * 
     * @param model
     * @return
     */
    @RequestMapping(value = "listFeeName", method = { RequestMethod.GET,
            RequestMethod.POST })
    public @ResponseBody()
    String listFeeName(int importExportFlag, int originalId, Model model,
            HttpServletResponse httpResponse) {
        httpResponse.setCharacterEncoding("UTF-8");
        List<HashMap<String, Object>> result = new ArrayList<HashMap<String, Object>>();
        PrdQuoteRequest request = new PrdQuoteRequest();
        int serviceId = 1;
        // 服务产品ID :进口=8，出口=1
        if (2 == importExportFlag) {
            serviceId = 8;
        }
        request.setServiceId(serviceId);
        request.setOriginalId(originalId);
        PrdQuoteResponse response = quoteService
                .getPrdQuoteByServiceAndOriginal(request);
        List<PrdQuoteEntity> quoteEntities = response.getPrdQuoteEntitys();
        for (PrdQuoteEntity prdQuoteEntity : quoteEntities) {
            HashMap<String, Object> item = new HashMap<String, Object>();
            item.put("id", prdQuoteEntity.getId());
            item.put("name", prdQuoteEntity.getName());
            GetCurrencyByIdRequest getCurrencyByIdRequest = new GetCurrencyByIdRequest();
            getCurrencyByIdRequest.setId(prdQuoteEntity.getCurrencyId());
            GetCurrencyByIdResponse getCurrencyByIdResponse = currency
                    .getCurrencyById(getCurrencyByIdRequest);
            UnitRequest unitRequest = new UnitRequest();
            unitRequest.setId(prdQuoteEntity.getUnitId());
            UnitResponse unitResponse = unit.getById(unitRequest);
            item.put("unitName", unitResponse.getUnitEntity().getCnName());
            item.put("currencyName", getCurrencyByIdResponse
                    .getCurrencyEntity().getCnName());
            result.add(item);
        }
        JSONArray jsonArray = JSONArray.fromObject(result);
        return jsonArray.toString();
    }
}
