/**
 * Description: 海运整箱海运费报价信息控制器
 * Copyright:   Copyright (c)2013
 * Company:     SUNIVO
 * @author:     yinfulei
 * @version:    1.0
 * Create at:   2013-11-06 上午 09:26:29
 *  
 * Modification History:
 * Date         Author      Version     Description
 * ------------------------------------------------------------------
 * 2012-12-21   yinfulei   1.0         Initial
 */
package com.sunivo.lgs.web.controller.lgs;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
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
import com.sunivo.lgs.beans.entity.LgsFclQuoteInfoEntity;
import com.sunivo.lgs.beans.vo.LgsFclQsurchargeVo;
import com.sunivo.lgs.beans.vo.LgsFclQuoteInfoAddVo;
import com.sunivo.lgs.web.base.controller.BaseController;
import com.sunivo.lgs.web.util.SunivoStringUtils;
import com.sunivo.ws.Constants;
import com.sunivo.ws.beans.request.lgs.GetLgsFclQuoteInfoByIdRequest;
import com.sunivo.ws.beans.request.lgs.ListLgsFclQuoteInfoRequest;
import com.sunivo.ws.beans.request.lgs.SaveLgsFclQuoteInfoRequest;
import com.sunivo.ws.beans.request.lgs.UpdateLgsFclQsurchargeRequest;
import com.sunivo.ws.beans.request.lgs.UpdateLgsFclQuoteInfoRequest;
import com.sunivo.ws.beans.response.lgs.GetLgsFclQuoteInfoByIdResponse;
import com.sunivo.ws.beans.response.lgs.ListLgsFclQuoteInfoResponse;
import com.sunivo.ws.beans.response.lgs.UpdateLgsFclQsurchargeResponse;
import com.sunivo.ws.beans.response.lgs.UpdateLgsFclQuoteInfoResponse;
import com.sunivo.ws.interfaces.server.lgs.ILgsFclQsurchargeServiceWS;
import com.sunivo.ws.interfaces.server.lgs.ILgsFclQuoteInfoServiceWS;

/**
 * 海运整箱海运费报价信息控制器<br>
 * 
 * @author yinfulei
 * @version 1.0, 2013-11-06
 * @see
 * @since 1.0
 */
@Controller
@RequestMapping("/lgsfclquoteinfo")
public class LgsFclQuoteInfoController extends BaseController {
    /**
     * 日志记录器
     */
    private static final Logger LOGGER = LoggerFactory
            .getLogger(LgsFclQuoteInfoController.class);
    /**
     * 自动注入海运整箱海运费报价信息WS实现
     */
    @Autowired
    private ILgsFclQuoteInfoServiceWS lgsFclQuoteInfo;
    /**
     * 自动注入海整详情信息WS实现
     */
    @Autowired
    private ILgsFclQsurchargeServiceWS fclQsurchargeServiceWS;

    /**
     * 去新增海运整箱海运费报价信息
     * 
     * @return 结果视图
     */
    @RequestMapping(value = "", params = "action=create")
    public String createForm(Model model) {
        model.addAttribute("action", "create");
        return getAutoUrl("form");
    }

    /**
     * 去新增海运整箱报价信息
     * 
     * @return 结果视图
     */
    @RequestMapping(value = "toAdd", method = { RequestMethod.GET })
    public String add(Integer addNum, HttpServletRequest request) {
        List<Integer> addList = new ArrayList<Integer>();
        if (addNum != null) {
            for (int i = 0; i < addNum; i++) {
                addList.add(i);
            }
        } else {
            for (int i = 0; i < 5; i++) {
                addList.add(i);
            }
        }
        request.setAttribute("addList", addList);
        request.setAttribute("nowDate", (new java.text.SimpleDateFormat(
                "yyyy-MM-dd hh:mm:ss")).format(new Date()));
        return getAutoUrl("add");
    }

    /**
     * 去新增海运整箱报价信息
     * 
     * @return 结果视图
     */
    @RequestMapping(value = "addList", method = { RequestMethod.POST }, produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public String addList(SaveLgsFclQuoteInfoRequest saveLgsFclQuoteInfo,
            BindingResult result, Page page, HttpServletRequest request) {
        if (saveLgsFclQuoteInfo != null
                && !SunivoStringUtils.isEmpty(saveLgsFclQuoteInfo
                        .getShipmentPortId())
                && !SunivoStringUtils.isEmpty(saveLgsFclQuoteInfo
                        .getCarrierId())
                && !SunivoStringUtils.isEmpty(saveLgsFclQuoteInfo
                        .getRouteTypeId())) {
            List<LgsFclQuoteInfoAddVo> entityList = saveLgsFclQuoteInfo
                    .getFclEntities();
            if (entityList != null && !entityList.isEmpty()) {
                for (int i = 0; i < entityList.size(); i++) {
                    try {
                        LgsFclQuoteInfoEntity flcQuoteInfo = entityList.get(i)
                                .getFclQuoteEntity();
                        if (flcQuoteInfo != null
                                && !SunivoStringUtils.isEmpty(flcQuoteInfo
                                        .getDestinationPortId())
                                && !SunivoStringUtils.isEmpty(flcQuoteInfo
                                        .getAgentId())) {
                            // TODO:根据起运港 货代公司 航线类型 目的港 船公司 唯一确定一条记录 如果
                            ListLgsFclQuoteInfoRequest unionCheckRequest = new ListLgsFclQuoteInfoRequest();
                            // 记录已经存在
                            LgsFclQuoteInfoEntity flcQuoteInfoQry = new LgsFclQuoteInfoEntity();
                            flcQuoteInfoQry.setCarrierId(saveLgsFclQuoteInfo
                                    .getCarrierId());
                            flcQuoteInfoQry
                                    .setShipmentPortId(saveLgsFclQuoteInfo
                                            .getShipmentPortId());
                            flcQuoteInfoQry.setRouteTypeId(saveLgsFclQuoteInfo
                                    .getRouteTypeId());
                            flcQuoteInfoQry.setAgentId(flcQuoteInfo
                                    .getAgentId());
                            flcQuoteInfoQry.setDestinationPortId(flcQuoteInfo
                                    .getDestinationPortId());
                            unionCheckRequest.setEntity(flcQuoteInfoQry);
                            ListLgsFclQuoteInfoResponse lgsFclQuoteInfoEntityList = lgsFclQuoteInfo
                                    .listLgsFclQuoteInfo(unionCheckRequest);
                            if (lgsFclQuoteInfoEntityList != null
                                    && lgsFclQuoteInfoEntityList
                                            .getObjectList() != null
                                    && lgsFclQuoteInfoEntityList
                                            .getObjectList().size() > 0) {
                                return "isReapet";
                            }
                        } else {
                            entityList.remove(i);
                        }
                    } catch (Exception ex) {
                        LOGGER.error(ex.getMessage(), ex);
                    }
                }
            }
            saveLgsFclQuoteInfo.setFclEntities(entityList);
            lgsFclQuoteInfo.saveLgsFclQuoteInfo(saveLgsFclQuoteInfo);
        }
        return getAutoUrl("list");
    }

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
     * 去查看海运整箱海运费报价信息
     * 
     * @param id
     *            海运整箱海运费报价信息页面表单对象唯一标识
     * @param request
     *            请求对象
     * @return 结果视图
     */
    @RequestMapping(value = "/detail/{id}", method = { RequestMethod.GET })
    public String showForm(@PathVariable(value = "id") Integer id, Model model) {
        GetLgsFclQuoteInfoByIdRequest request = new GetLgsFclQuoteInfoByIdRequest();
        request.setId(id);
        GetLgsFclQuoteInfoByIdResponse response = lgsFclQuoteInfo
                .getLgsFclQuoteInfoById(request);
        model.addAttribute("entity", response.getEntity());
        model.addAttribute("surchargeEntitys", response.getSurchargeEntitys());
        model.addAttribute("lgsQuoteViewVo", response.getLgsQuoteViewVo());
        return getAutoUrl("detail");
    }

    /**
     * 去修改海运整箱海运费报价信息
     * 
     * @param id
     *            <font color="red">明细ID</font>
     * @param request
     *            请求对象
     * @return 结果视图
     */
    @RequestMapping(value = "/{id}", method = { RequestMethod.GET }, params = "action=edit")
    public String updateForm(@PathVariable(value = "id") Integer id, Model model) {
        GetLgsFclQuoteInfoByIdRequest request = new GetLgsFclQuoteInfoByIdRequest();
        request.setId(id);
        GetLgsFclQuoteInfoByIdResponse response = lgsFclQuoteInfo
                .getLgsFclQuoteInfoById(request);

        if (null != response) {
            LgsFclQuoteInfoEntity fclQuoteEntity = response.getEntity();
            if (null != fclQuoteEntity) {
                String estimatedSalingdate = fclQuoteEntity
                        .getEstimatedSalingdate();
                if (SunivoStringUtils.isNotEmpty(estimatedSalingdate)) {
                    fclQuoteEntity.setEstimatedSalingdateValues(StringUtils
                            .split(estimatedSalingdate, ","));
                }
            }
            model.addAttribute("entity", fclQuoteEntity);
            if (null != response.getSurchargeEntitys()
                    && !response.getSurchargeEntitys().isEmpty()) {
                for (LgsFclQsurchargeVo fclQsurchargeVo : response
                        .getSurchargeEntitys()) {
                    if (null != fclQsurchargeVo) {
                        LgsFclQsurchargeEntity surchargeEntity = fclQsurchargeVo
                                .getEntity();
                        if (surchargeEntity.getQuoteType().getId() == 1) {
                            model.addAttribute("surchargeEntity",
                                    surchargeEntity);
                        }

                    }
                }
            }
            model.addAttribute("lgsQuoteViewVo", response.getLgsQuoteViewVo());
        }
        model.addAttribute("action", "edit");
        return getAutoUrl("form");
    }

    /**
     * 修改海运整箱海运费报价信息
     * 
     * @param lgsFclQuoteInfo
     *            海运整箱海运费报价信息页面表单对象
     * @param result
     *            表单验证数据
     * @param page
     *            分页配置
     * @param request
     *            请求对象
     * @return 结果视图
     */
    @RequestMapping(value = "/{id}", method = { RequestMethod.POST })
    public String updateLgsFclQuoteInfo(LgsFclQuoteInfoAddVo vo,
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
                UpdateLgsFclQuoteInfoRequest request = new UpdateLgsFclQuoteInfoRequest();
                request.setUpdateVo(vo);
                @SuppressWarnings("unused")
                UpdateLgsFclQuoteInfoResponse rersponse = lgsFclQuoteInfo
                        .updateLgsFclQuoteInfo(request);
                redirectAttributes.addAttribute("message", "更新成功");
                return "redirect:/lgsfclquoteinfo/detail/" + id;
            } catch (Exception ex) {
                addErrorMessage(model, ex.getMessage());
                model.addAttribute("action", "edit");
                return getAutoUrl("form");
            }
        }
    }

    /**
     * 查询海运整箱海运费报价信息
     * 
     * @param lgsFclQuoteInfo
     *            海运整箱海运费报价信息页面表单对象
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
        ListLgsFclQuoteInfoRequest listRequest = new ListLgsFclQuoteInfoRequest();
        listRequest.setPaging(page);
        listRequest.setSearchParams(searchParams);
        ListLgsFclQuoteInfoResponse response = lgsFclQuoteInfo
                .listLgsFclQuoteInfo(listRequest);
        request.setAttribute("page", response.getPaging());
        request.setAttribute("lgsAddationQuoteInfos", response.getObjectList());
        model.addAttribute("searchParams", Servlets
                .encodeParameterStringWithPrefix(searchParams, "search_"));
        return getAutoUrl();
    }
}
