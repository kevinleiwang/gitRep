/**
 * Description: 审计日志控制器
 * Copyright:   Copyright (c)2013
 * Company:     SUNIVO
 * @author:     tradx
 * @version:    1.0
 * Create at:   2013-08-20 下午 14:17:08
 *  
 * Modification History:
 * Date         Author      Version     Description
 * ------------------------------------------------------------------
 * 2012-12-21   tradx   1.0         Initial
 */
package com.sunivo.lgs.web.controller.framework;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sunivo.lgs.web.base.controller.BaseController;

/**
 * 审计日志控制器<br>
 * 
 * @author tradx
 * @version 1.0, 2013-08-20
 * @see
 * @since 1.0
 */
// @NeedLogin如果需要登录请添加
@Controller
@RequestMapping("/basauditlog")
public class BasAuditLogController extends BaseController {

    // /**
    // * 自动注入审计日志业务层实现
    // */
    // @Autowired
    // private IBasAuditLogService basAuditLogService;
    //
    // /**
    // * 去查看审计日志
    // *
    // * @param id
    // * 审计日志页面表单对象唯一标识
    // * @param request
    // * 请求对象
    // * @return 结果视图
    // */
    // @RequestMapping(value = "/{id}", method = { RequestMethod.GET })
    // public String showForm(@PathVariable(value = "id") Integer id, Model
    // model) {
    // model.addAttribute("entity", basAuditLogService.getById(id));
    // return form();
    // }
    //
    // /**
    // * 查询审计日志
    // *
    // * @param basAuditLog
    // * 审计日志页面表单对象
    // * @param page
    // * 分页配置
    // * @param request
    // * 请求对象
    // * @return 结果视图
    // */
    // @RequestMapping(value = "", method = RequestMethod.GET)
    // public String list(Integer number, Model model, HttpServletRequest
    // request) {
    // // 获取查询条件
    // Map<String, Object> searchParams = Servlets.getParametersStartingWith(
    // request, "search_");
    // Page page = new Page();
    // if (null != number) {
    // page.setCurrentPage(number);
    // }
    // request.setAttribute("page", page);
    // QueryParams<BasAuditLogEntity> queryParams = new
    // QueryParams<BasAuditLogEntity>();
    // queryParams.setPaging(page);
    // queryParams.setSearchParams(searchParams);
    // List<BasAuditLogEntity> basAuditLogs = basAuditLogService
    // .queryByPage(queryParams);
    // request.setAttribute("basAuditLogs", basAuditLogs);
    // model.addAttribute("searchParams", searchParams);
    // return AutoGetURL();
    // }
    //
    // /**
    // * 获取form页面的真实路径
    // *
    // * @return form页面的真实路径
    // */
    // private String form() {
    // return AutoGetURL();
    // }
}
