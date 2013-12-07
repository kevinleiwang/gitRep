package com.sunivo.lgs.web.controller.framework;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sunivo.lgs.web.base.controller.BaseController;

/**
 * 审计日志控制器
 * 
 * @author chengjianfang
 * 
 */
@Controller
@RequestMapping(value = "/auditlog")
public class AuditLogController extends BaseController {
    // @Autowired
    // AuditLogService auditLogService;
    //
    // @RequestMapping(value = "auditLogListSection")
    // public String auditLogListSection(
    // @RequestParam(value = "resourceType") String resourceType,
    // @RequestParam(value = "resourceId") Integer resourceId,
    // @RequestParam(value = "sidx", defaultValue = "createDatetime") String
    // sidx,
    // @RequestParam(value = "sord", defaultValue = "desc") String sord,
    // @RequestParam(value = "number", defaultValue = "1") int number,
    // @RequestParam(value = "size", defaultValue = "15") int size,
    // Model model) {
    // Page page = new Page(number, size);
    // List<BasAuditLogEntity> auditLogs = auditLogService.getAuditLogs(
    // resourceId, resourceType, sidx, sord, page);
    // model.addAttribute("page", page);
    // model.addAttribute("auditLogs", auditLogs);
    // return AutoGetURL();
    // }
    //
    // @RequestMapping(value = "auditLogDetailSection")
    // public String auditLogDetailSection(
    // @RequestParam(value = "auditLogId") Integer auditLogId, Model model) {
    // BasAuditLogEntity auditLog = auditLogService.getAuditLog(auditLogId);
    // List<BasAuditLogDetailEntity> auditLogDetails = auditLogService
    // .getDetails(auditLog);
    // try {
    // auditLogService.formatAuditLogDetailValue(auditLogDetails);
    // } catch (ClassNotFoundException e) {
    // e.printStackTrace();
    // }
    // model.addAttribute("auditLog", auditLog);
    // model.addAttribute("auditLogDetails", auditLogDetails);
    // return AutoGetURL();
    // }
}