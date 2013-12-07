/**  
 * Description: <类功能描述-必填> 
 * Copyright:   Copyright (c)2012  
 * Company:     ChunYu 
 * @author:     ChenZhao  
 * @version:    1.0  
 * Create at:   2012-12-21 下午4:22:51  
 *  
 * Modification History:  
 * Date         Author      Version     Description  
 * ------------------------------------------------------------------  
 * 2012-12-21   ChenZhao      1.0       如果修改了;必填  
 */
package com.sunivo.lgs.web.base.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.ui.Model;
import org.springframework.util.Assert;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.servlet.mvc.multiaction.MultiActionController;

import com.sunivo.lgs.web.base.configurer.MemoryPropertyPlaceholderConfigurer;
import com.sunivo.tags.valueobject.beans.AlertMessageObject;
import com.sunivo.tags.valueobject.constants.enums.AlertMessageLevel;

/**
 * 素有Controllere的基础类，提供一些特殊功能
 * 
 * @author chengjianfang@sunivo.com
 * 
 *         2013-10-22 上午10:13:14
 */
public abstract class BaseController extends MultiActionController {

    /**
     * 日志记录器
     */
    private static final Logger LOGGER = LoggerFactory
            .getLogger(BaseController.class);

    // /**
    // * 验证器
    // */
    // @Autowired
    // private Validator validator;

    /**
     * 功能描述: <br>
     * 〈功能详细描述〉
     * 
     * @param binder
     */
    @InitBinder
    public void initBinder(WebDataBinder binder) {
        // 添加一个日期类型编辑器，也就是需要日期类型的时候，怎么把字符串转化为日期类型
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        dateFormat.setLenient(false);
        binder.registerCustomEditor(Date.class, new CustomDateEditor(
                dateFormat, true));
    }

    /**
     * 获得自动返回路径的地址，页面一般在模块的view的pages路径下+方法名称+.jsp<br>
     * 当返回视图和方法名一致时使用 <br>
     * 如果没有配置默认返回使用如下规则: <li>AbcController.defGhi()--&gt;abc/pages/defGhi
     * 
     * @return 指定的页面
     */
    protected String getAutoUrl() {
        try {
            final String[] controllerNameArr = StringUtils.split(
                    new Exception().getStackTrace()[1].getClassName(), ".");
            final String controllerName = controllerNameArr[controllerNameArr.length - 1];
            final String requestName = controllerName.toLowerCase().replace(
                    "controller", "");
            String moduleName = MemoryPropertyPlaceholderConfigurer
                    .getContextProperty(requestName);
            // 增加默认值配置
            if (null == moduleName) {
                moduleName = requestName.concat("/pages/");
            }
            return moduleName
                    + new Exception().getStackTrace()[1].getMethodName();
        } catch (Exception e) {
            LOGGER.error(e.getMessage(), e);
        }
        return "";
    }

    /**
     * 获得自动返回路径的地址，页面一般在模块的view的pages路径下+方法名称+.jsp<br>
     * 当返回视图和方法名不一致时使用
     * 
     * 
     * @param methodName
     *            方法名<br>
     *            当返回的视图和当前方法名不同时，通过该参数控制视图名称 <br>
     *            例如: <li>
     *            AbcController.defGhi()使用getAutoUrl("form");--&gt;abc/pages
     *            /form
     * 
     * @return 指定的页面
     */
    protected String getAutoUrl(String methodName) {
        try {
            final String[] controllerNameArr = StringUtils.split(
                    new Exception().getStackTrace()[1].getClassName(), ".");
            final String controllerName = controllerNameArr[controllerNameArr.length - 1];
            final String requestName = controllerName.toLowerCase().replace(
                    "controller", "");
            String moduleName = MemoryPropertyPlaceholderConfigurer
                    .getContextProperty(requestName);
            // 增加默认值配置
            if (null == moduleName) {
                moduleName = requestName.concat("/pages/");
            }
            return moduleName + methodName;
        } catch (Exception e) {
            LOGGER.error(e.getMessage(), e);
        }
        return "";
    }

    /**
     * 增加提示消息
     * 
     * @param model
     *            模型对象
     * @param message
     *            消息内容
     */
    protected void addMessage(Model model, String message) {
        model.addAttribute("message", message);
    }

    /**
     * 增加提示消息
     * 
     * @param model
     *            模型对象
     * @param alertMessageObjects
     *            消息对象列表
     */
    private void addMessage(Model model,
            List<AlertMessageObject> alertMessageObjects) {
        model.addAttribute("messages", alertMessageObjects);
    }

    /**
     * 增加默认级别提示消息
     * 
     * @param model
     *            模型对象
     * @param message
     *            消息内容
     */
    protected void addDefaultMessage(Model model, String... messages) {
        Assert.notNull(messages, "messages must not be null");
        List<AlertMessageObject> alertMessageObjects = new ArrayList<AlertMessageObject>();
        for (String message : messages) {
            alertMessageObjects.add(new AlertMessageObject(message,
                    AlertMessageLevel.DEFAULT));
        }
        addMessage(model, alertMessageObjects);
    }

    /**
     * 增加信息(INFO)级别提示消息
     * 
     * @param model
     *            模型对象
     * @param message
     *            消息内容
     */
    protected void addInfoMessage(Model model, String... messages) {
        Assert.notNull(messages, "messages must not be null");
        List<AlertMessageObject> alertMessageObjects = new ArrayList<AlertMessageObject>();
        for (String message : messages) {
            alertMessageObjects.add(new AlertMessageObject(message,
                    AlertMessageLevel.INFO));
        }
        addMessage(model, alertMessageObjects);
    }

    /**
     * 增加成功(SUCCESS)级别提示消息
     * 
     * @param model
     *            模型对象
     * @param message
     *            消息内容
     */
    protected void addSuccessMessage(Model model, String... messages) {
        Assert.notNull(messages, "messages must not be null");
        List<AlertMessageObject> alertMessageObjects = new ArrayList<AlertMessageObject>();
        for (String message : messages) {
            alertMessageObjects.add(new AlertMessageObject(message,
                    AlertMessageLevel.SUCCESS));
        }
        addMessage(model, alertMessageObjects);
    }

    /**
     * 增加警告(WARN)级别提示消息
     * 
     * @param model
     *            模型对象
     * @param message
     *            消息内容
     */
    protected void addWarnMessage(Model model, String... messages) {
        Assert.notNull(messages, "messages must not be null");
        List<AlertMessageObject> alertMessageObjects = new ArrayList<AlertMessageObject>();
        for (String message : messages) {
            alertMessageObjects.add(new AlertMessageObject(message,
                    AlertMessageLevel.WARN));
        }
        addMessage(model, alertMessageObjects);
    }

    /**
     * 增加错误(ERROR)级别提示消息
     * 
     * @param model
     *            模型对象
     * @param message
     *            消息内容
     */
    protected void addErrorMessage(Model model, String... messages) {
        Assert.notNull(messages, "messages must not be null");
        List<AlertMessageObject> alertMessageObjects = new ArrayList<AlertMessageObject>();
        for (String message : messages) {
            alertMessageObjects.add(new AlertMessageObject(message,
                    AlertMessageLevel.ERROR));
        }
        addMessage(model, alertMessageObjects);
    }

    /**
     * 进行子对象验证
     * 
     * @param result
     *            验证错误结果
     * @param entity
     *            待验证子对象
     */
    /*
     * protected void subValidation(BindingResult result, DomainObject entity) {
     * String objectName = result.getObjectName(); BindingResult subResult = new
     * BeanPropertyBindingResult(entity, objectName); //
     * 重新构造一个空的验证异常绑定(用于存放可用的验证信息) BindingResult newSubResult = new
     * BeanPropertyBindingResult(entity, objectName); validator.validate(entity,
     * subResult); // 获取所有验证异常 List<FieldError> fieldErrors =
     * subResult.getFieldErrors(); // 对单个验证异常进行字段修改 for (FieldError fieldError :
     * fieldErrors) { // 新的验证异常是旧验证异常的一个拷贝,由于所有字段都是final的不能修改,所以只好重建对象 //
     * 除field外全部使用原始值 // field在取值前加product[index] FieldError newFieldError = new
     * FieldError( fieldError.getObjectName(), "entity." +
     * fieldError.getField(), fieldError.getRejectedValue(),
     * fieldError.isBindingFailure(), fieldError.getCodes(),
     * fieldError.getArguments(), fieldError.getDefaultMessage()); //
     * 将验证异常放入新的验证异常绑定中 newSubResult.addError(newFieldError); } //
     * 将单个对象验证异常(字段更新后的)放入控制器自身的验证异常绑定中 result.addAllErrors(newSubResult); }
     */
}
