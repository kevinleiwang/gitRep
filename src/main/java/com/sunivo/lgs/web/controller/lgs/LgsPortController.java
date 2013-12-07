/**
 * Description: 海运整箱本地费用维护控制器
 * Copyright:   Copyright (c)2013
 * Company:     SUNIVO
 * @author: caoyongxiang
 * @version: 1.0
 * Create at:   2013-11-05 
 *
 * Modification History:
 * Date         Author      Version     Description
 * ------------------------------------------------------------------
 * 2013-11-05   lgs         1.0         add
 */
package com.sunivo.lgs.web.controller.lgs;

import java.util.Calendar;
import java.util.Date;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
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
import com.sunivo.lgs.beans.entity.LgsPortEntity;
import com.sunivo.lgs.beans.vo.LgsPortQuoteListEntity;
import com.sunivo.lgs.beans.vo.LgsPortVo;
import com.sunivo.lgs.web.base.controller.BaseController;
import com.sunivo.uim.beans.entity.PrdQuoteEntity;
import com.sunivo.ws.Constants;
import com.sunivo.ws.SunivoSearchRequest;
import com.sunivo.ws.SunivoSearchResponse;
import com.sunivo.ws.beans.request.lgs.DeleteLgsFclQsurchargeRequest;
import com.sunivo.ws.beans.request.lgs.GetLgsFclQsurchargeByIdRequest;
import com.sunivo.ws.beans.request.lgs.LgsPortRequest;
import com.sunivo.ws.beans.request.uim.PrdQuoteRequest;
import com.sunivo.ws.beans.response.lgs.DeleteLgsFclQsurchargeResponse;
import com.sunivo.ws.beans.response.lgs.GetLgsFclQsurchargeByIdResponse;
import com.sunivo.ws.beans.response.lgs.LgsPortResponse;
import com.sunivo.ws.beans.response.uim.PrdQuoteResponse;
import com.sunivo.ws.interfaces.server.lgs.ILgsFclQsurchargeServiceWS;
import com.sunivo.ws.interfaces.server.lgs.ILgsPortServiceWS;
import com.sunivo.ws.interfaces.server.uim.IPrdQuoteServiceWS;

@Controller
@RequestMapping("/lgsport")
public class LgsPortController extends BaseController {

    /**
     * 日志记录
     */
    private static final Logger logger = Logger
            .getLogger(LgsPortController.class);

    /**
     * 海整本地费WS接口服务
     */
    @Autowired
    private ILgsPortServiceWS lgsPortServiceWS;

    /**
     * 海整本地费报价详情WS接口服务
     */
    @Autowired
    private ILgsFclQsurchargeServiceWS lgsFclQsurchargeServiceWS;

    /**
     * 产品报价项WS接口服务
     */
    @Autowired
    private IPrdQuoteServiceWS prdQuoteServiceWS;

    /**
     * 海运整箱本地费用-列表
     * 
     * @param number
     *            当前页号（默认是0，封装在PAGE标签中）
     * @param model
     *            存放返回参数
     * @param request
     *            接收查询参数
     * @return 本地费列表页面路径
     */
    @RequestMapping(value = "", method = RequestMethod.GET)
    public String portList(Integer number, Model model,
            HttpServletRequest request) {
        logger.debug("---------go into method: portList-----------------");
        long beginTime = System.currentTimeMillis();

        try {
            // 声明检索请求对象SunivoSearchRequest
            SunivoSearchRequest sunivoSearchRequest = new SunivoSearchRequest();

            // 获取查询条件
            Map<String, Object> searchParams = Servlets
                    .getParametersStartingWith(request, "search_");
            // disabled 为0的才显示
            searchParams.put("EQ_disabled", 0);
            Page page = new Page();
            if (null != number) {
                page.setCurrentPage(number);
            }
            request.setAttribute("page", page);
            sunivoSearchRequest.setPaging(page);
            sunivoSearchRequest.setSearchParams(searchParams);
            sunivoSearchRequest.setOrderColumn("fcl.createDatetime");
            sunivoSearchRequest.setOrderMode("desc");
            // disabled=0的才展示
            // 调用hession接口
            SunivoSearchResponse<LgsPortQuoteListEntity> searchResponse = lgsPortServiceWS
                    .selectLgsPort(sunivoSearchRequest);

            request.setAttribute("page", searchResponse.getPaging());
            request.setAttribute("objectList", searchResponse.getObjectList());
            model.addAttribute("searchParams", Servlets
                    .encodeParameterStringWithPrefix(searchParams, "search_"));

        } catch (Exception e) {
            e.printStackTrace();
            logger.error("本地费列表检索系统异常!");
        }

        long endTime = System.currentTimeMillis();
        logger.debug("---------leave method: portList-----------------耗时："
                + (endTime - beginTime));

        return getAutoUrl();
    }

    /**
     * 跳转到本地费新增页面
     * 
     * @return 本地费新增页面路径
     */
    @RequestMapping(value = "/portAdd", method = RequestMethod.GET)
    public String portAdd(Model model) {
        logger.debug("---------go into method: portAdd-----------------");
        long beginTime = System.currentTimeMillis();

        LgsPortEntity entity = new LgsPortEntity();
        entity.setImportExportFlag(1);// 新增页面默认出口
        model.addAttribute("entity", entity);

        long endTime = System.currentTimeMillis();
        logger.debug("---------leave method: portAdd-----------------耗时："
                + (endTime - beginTime));
        return getAutoUrl();
    }

    /**
     * 本地费保存方法
     * 
     * @return 本地费详情页面路径
     */
    @RequestMapping(value = "/portSave", method = RequestMethod.POST)
    public String portSave(LgsPortVo vo, BindingResult result,
            RedirectAttributes redirectAttributes, Model model) {
        logger.debug("---------go into method: portSave-----------------");
        long beginTime = System.currentTimeMillis();
        LgsPortResponse lgsPortResponse = null;
        try {
            if (result.hasErrors()) {
                logger.error("本地费新增数据校验失败！");
                model.addAttribute("entity", vo.getEntity());
                model.addAttribute("fclQentity", vo.getFclQentity());
                addErrorMessage(model, result.getAllErrors().toString());
                return getAutoUrl("portAdd");
            }

            // 获取页面数据
            LgsPortEntity port = vo.getEntity();
            LgsFclQsurchargeEntity fclQentity = vo.getFclQentity();

            // 比较前需要将时，分，秒，毫秒全部修改为0，否则当天数据无法提交
            Calendar calendar = Calendar.getInstance();
            calendar.set(Calendar.HOUR_OF_DAY, 0);
            calendar.set(Calendar.MINUTE, 0);
            calendar.set(Calendar.SECOND, 0);
            calendar.set(Calendar.MILLISECOND, 0);
            Date nowdate = calendar.getTime();
            // isExecDateBeforeToday=true:校验失败，false:校验成功
            boolean isExecDateBeforeToday = fclQentity.getExecDate().before(
                    nowdate);
            // isExiryDateAfterToday=true:校验失败，false:校验成功
            boolean isExiryDateBeforeToday = fclQentity.getExpiryDate().before(
                    nowdate);
            // isExecDateAfterExiryDate=true:校验失败，false:校验成功
            boolean isExecDateAfterExiryDate = fclQentity.getExecDate().after(
                    fclQentity.getExpiryDate());

            // 如果校验出问题，保留原始数据

            LgsFclQsurchargeEntity readFclQsurchargeEntity = vo.getFclQentity();

            // SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd",
            // Locale.CHINA);
            // Date execDate = readFclQsurchargeEntity.getExecDate();
            // try {
            // execDate = sdf.parse(sdf.format(execDate));
            // readFclQsurchargeEntity.setExecDate(execDate);
            // } catch (ParseException e) {
            // e.printStackTrace();
            // }

            if (isExecDateBeforeToday) {
                // logger.error("生效日期不能早于当前日期！");
                // addErrorMessage(model, "生效日期不能早于当前日期！");
                // return getAutoUrl("portAdd");
            }
            if (isExiryDateBeforeToday) {
                logger.error("失效日期不能早于当前日期！");
                addErrorMessage(model, "失效日期不能早于当前日期！");
                readFclQsurchargeEntity.setExecDate(null);
                readFclQsurchargeEntity.setExpiryDate(null);
                return getAutoUrl("portAdd");
            }
            if (isExecDateAfterExiryDate) {
                logger.error("失效日期不能早于生效日期！");
                addErrorMessage(model, "失效日期不能早于生效日期！");
                readFclQsurchargeEntity.setExecDate(null);
                readFclQsurchargeEntity.setExpiryDate(null);
                return getAutoUrl("portAdd");
            }
            model.addAttribute("fclQentity", readFclQsurchargeEntity);
            model.addAttribute("entity", vo.getEntity());

            if (port != null && port.getImportExportFlag() == null) {
                port.setImportExportFlag(1);// 默认出口
            }

            // 折扣价，销售价要在成本价基础上做加成,放在portSave方法中处理了。
            lgsPortResponse = lgsPortServiceWS.portSave(port, fclQentity);

            if (Constants.FAIL_CODE.equals(lgsPortResponse.getResultCode())) {
                logger.error("港口，船公司，航线，费用项重复；本地费新增失败！");
                model.addAttribute("entity", vo.getEntity());
                model.addAttribute("fclQentity", vo.getFclQentity());
                addErrorMessage(model, lgsPortResponse.getResultMessage());
                return getAutoUrl("portAdd");
            }
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("本地费新增保存系统异常!");
            addErrorMessage(model, "新增保存过程中出现系统异常！");
            return getAutoUrl("portAdd");
        }

        addSuccessMessage(model, Constants.CREATE_SUCESS_MESSAGE);

        long endTime = System.currentTimeMillis();
        logger.debug("---------leave method: portSave-----------------耗时："
                + (endTime - beginTime));

        // 跳转到详情页面
        return "redirect:/lgsport/portDetail/"
                + lgsPortResponse.getFclQuoteId();
    }

    /**
     * 跳转到本地费编辑页面
     * 
     * @return 本地费编辑页面路径
     */
    @RequestMapping(value = "/portEdit/{quoteId}", method = RequestMethod.GET)
    public String portEdit(@PathVariable("quoteId") Integer quoteId, Model model) {
        logger.debug("---------go into method: portEdit-----------------");
        long beginTime = System.currentTimeMillis();
        try {
            getDetail(quoteId, model);
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("本地费编辑系统异常!");
            addErrorMessage(model, "编辑过程中出现系统异常！");
            return getAutoUrl("portEdit");
        }
        long endTime = System.currentTimeMillis();
        logger.debug("---------leave method: portEdit-----------------耗时："
                + (endTime - beginTime));
        return getAutoUrl();
    }

    /**
     * 本地费编辑
     * 
     * @return 本地费列表页面路径
     */
    @RequestMapping(value = "/portUpdate", method = RequestMethod.POST)
    public String portUpdate(LgsPortVo vo, BindingResult result,
            RedirectAttributes redirectAttributes, Model model) {
        logger.debug("---------go into method: portUpdate-----------------");
        long beginTime = System.currentTimeMillis();

        Integer fclId = 1;
        try {
            PrdQuoteRequest prdQuoteRequest = new PrdQuoteRequest();
            prdQuoteRequest.setPrdQuoteId(vo.getFclQentity().getPrdQuoteId());
            PrdQuoteResponse prdQuoteResponse = prdQuoteServiceWS
                    .getPrdQuoteById(prdQuoteRequest);
            PrdQuoteEntity prdQuoteEntity = prdQuoteResponse
                    .getPrdQuoteEntity();

            if (result.hasErrors()) {
                logger.error("本地费修改数据校验失败！");
                model.addAttribute("entity", vo.getEntity());
                model.addAttribute("fclQentity", vo.getFclQentity());
                model.addAttribute("prdQuoteEntity", prdQuoteEntity);
                addErrorMessage(model, result.getAllErrors().toString());
                return portEdit(vo.getFclQentity().getId(), model);
            }

            // 本地费的基本信息不允许修改，此处暂留，以免以后又允许修改了。
            LgsPortEntity port = vo.getEntity();
            LgsFclQsurchargeEntity fclQentity = vo.getFclQentity();

            // 比较前需要将时，分，秒，毫秒全部修改为0，否则当天数据无法提交
            Calendar calendar = Calendar.getInstance();
            calendar.set(Calendar.HOUR_OF_DAY, 0);
            calendar.set(Calendar.MINUTE, 0);
            calendar.set(Calendar.SECOND, 0);
            calendar.set(Calendar.MILLISECOND, 0);
            Date nowdate = calendar.getTime();
            // isExecDateBeforeToday=true:校验失败，false:校验成功
            boolean isExecDateBeforeToday = fclQentity.getExecDate().before(
                    nowdate);
            // isExiryDateAfterToday=true:校验失败，false:校验成功
            boolean isExiryDateBeforeToday = fclQentity.getExpiryDate().before(
                    nowdate);
            // isExecDateAfterExiryDate=true:校验失败，false:校验成功
            boolean isExecDateAfterExiryDate = fclQentity.getExecDate().after(
                    fclQentity.getExpiryDate());
            if (isExecDateBeforeToday) {
                // logger.error("生效日期不能早于当前日期！");
                // addErrorMessage(model, "生效日期不能早于当前日期！");
                // return getAutoUrl("portEdit");
            }
            if (isExiryDateBeforeToday) {
                model.addAttribute("entity", vo.getEntity());
                model.addAttribute("fclQentity", vo.getFclQentity());
                model.addAttribute("prdQuoteEntity", prdQuoteEntity);
                logger.error("失效日期不能早于当前日期！");
                addErrorMessage(model, "失效日期不能早于当前日期！");
                return portEdit(vo.getFclQentity().getId(), model);
            }
            if (isExecDateAfterExiryDate) {
                model.addAttribute("entity", vo.getEntity());
                model.addAttribute("fclQentity", vo.getFclQentity());
                model.addAttribute("prdQuoteEntity", prdQuoteEntity);
                logger.error("失效日期不能早于生效日期！");
                addErrorMessage(model, "失效日期不能早于生效日期！");
                return portEdit(vo.getFclQentity().getId(), model);
            }

            // 修改，不做加成
            //
            LgsPortRequest request = new LgsPortRequest();
            request.setEntity(port);
            request.setFclQentity(fclQentity);
            // 修改海运整箱本地费报价信息
            lgsPortServiceWS.portUpdate(request);

            fclId = fclQentity.getId();

        } catch (Exception e) {
            e.printStackTrace();
            logger.error("本地费编辑保存系统异常!");
            addErrorMessage(model, "编辑保存过程中出现系统异常！");
            return portEdit(vo.getFclQentity().getId(), model);
        }

        long endTime = System.currentTimeMillis();
        logger.debug("---------leave method: portUpdate-----------------耗时："
                + (endTime - beginTime));

        // return getAutoUrl();
        return "redirect:/lgsport/portDetail/" + fclId;
    }

    /**
     * 跳转到本地费编辑页面
     * 
     * @return 本地费编辑页面路径
     */
    @RequestMapping(value = "/portDetail/{quoteId}", method = RequestMethod.GET)
    public String portDetail(@PathVariable("quoteId") Integer quoteId,
            Model model) {
        logger.debug("---------go into method: portDetail-----------------");
        long beginTime = System.currentTimeMillis();
        try {
            getDetail(quoteId, model);
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("本地费详情查看系统异常!");
            addErrorMessage(model, "本地费详情查看出现系统异常！");
            return "redirect:/lgsport";
        }
        long endTime = System.currentTimeMillis();
        logger.debug("---------leave method: portDetail-----------------耗时："
                + (endTime - beginTime));
        return getAutoUrl();
    }

    /**
     * 获取本地费基本信息，本地费报价信息
     * 
     * @param portId
     *            本地费表ID
     * @param quoteId
     *            本地费报价ID
     * @param model
     *            返回视图
     * @return model 返回视图
     */
    private void getDetail(Integer quoteId, Model model) {

        // 本地费报价信息
        GetLgsFclQsurchargeByIdRequest getLgsFclQsurchargeByIdRequest = new GetLgsFclQsurchargeByIdRequest();
        getLgsFclQsurchargeByIdRequest.setId(quoteId);// lgs_fcl_q_surcharge表的主键
        // 读取信息
        GetLgsFclQsurchargeByIdResponse getLgsFclQuoteInfoByIdResponse = lgsFclQsurchargeServiceWS
                .getLgsFclQsurchargeById(getLgsFclQsurchargeByIdRequest);
        // 报价信息
        LgsFclQsurchargeEntity lgsFclQsurchargeEntity = getLgsFclQuoteInfoByIdResponse
                .getEntity();

        // 费用名称，费用单位，币种
        PrdQuoteRequest prdQuoteRequest = new PrdQuoteRequest();
        prdQuoteRequest.setPrdQuoteId(lgsFclQsurchargeEntity.getPrdQuoteId());
        PrdQuoteResponse prdQuoteResponse = prdQuoteServiceWS
                .getPrdQuoteById(prdQuoteRequest);
        PrdQuoteEntity prdQuoteEntity = prdQuoteResponse.getPrdQuoteEntity();

        Integer portId = lgsFclQsurchargeEntity.getQuoteId();
        // 本地费基本信息
        LgsPortRequest lgsPortRequest = new LgsPortRequest();
        lgsPortRequest.setPortId(portId);
        // 读取信息
        LgsPortResponse lgsPortResponse = null;
        LgsPortEntity lgsPortEntity = null;
        try {
            lgsPortResponse = lgsPortServiceWS.getById(lgsPortRequest);
            lgsPortEntity = lgsPortResponse.getEntity();
        } catch (Exception e) {
            e.printStackTrace();
        }
        // 本地费基本信息

        model.addAttribute("entity", lgsPortEntity);
        model.addAttribute("fclQentity", lgsFclQsurchargeEntity);
        model.addAttribute("prdQuoteEntity", prdQuoteEntity);
    }

    /**
     * 将本地费状态设置为有效/无效
     * 
     * @param status
     *            原始状态
     * @return 成功标志
     */
    @ResponseBody
    @RequestMapping(value = "/modifyPortStatus/{fclQid}/{status}", method = RequestMethod.GET)
    public String modifyPortStatus(@PathVariable("fclQid") Integer fclQid,
            @PathVariable("status") Integer status, Model model) {
        logger.debug("---------go into method: portDetail-----------------");
        long beginTime = System.currentTimeMillis();
        LgsPortResponse lgsPortResponse = new LgsPortResponse();
        try {
            lgsPortResponse = lgsPortServiceWS.modifyFclQsurchargeStatus(
                    fclQid, status);
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("本地费状态设置系统异常!");
            addErrorMessage(model, "本地费状态设置出现系统异常！");
        }
        long endTime = System.currentTimeMillis();
        logger.debug("---------leave method: portDetail-----------------耗时："
                + (endTime - beginTime));

        return lgsPortResponse.getResultCode();
    }

    @ResponseBody
    @RequestMapping(value = "/deletePort/{fclQid}", method = RequestMethod.GET)
    public String deletePort(@PathVariable("fclQid") Integer fclQid, Model model) {
        logger.debug("---------go into method: deletePort-----------------");
        long beginTime = System.currentTimeMillis();

        DeleteLgsFclQsurchargeRequest req = new DeleteLgsFclQsurchargeRequest();
        DeleteLgsFclQsurchargeResponse res = new DeleteLgsFclQsurchargeResponse();
        try {
            req.setId(fclQid);
            res = lgsFclQsurchargeServiceWS.deleteById(req);
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("本地费删除系统异常!");
            addErrorMessage(model, "本地费删除出现系统异常！");
        }
        long endTime = System.currentTimeMillis();
        logger.debug("---------leave method: deletePort-----------------耗时："
                + (endTime - beginTime));

        return res.getResultCode();
    }

}
