/**
 * Description: <类功能描述-必填> 
 * Copyright:   Copyright (c)2012  
 * Company:     ChunYu 
 * @author: ChenZhao
 * @version: 1.0
 * Create at:   2012-12-21 下午4:22:51  
 *
 * Modification History:  
 * Date         Author      Version     Description  
 * ------------------------------------------------------------------  
 * 2012-12-21   ChenZhao      1.0       如果修改了;必填  
 */
package com.sunivo.lgs.web.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.sunivo.lgs.web.base.controller.BaseController;

/**
 * 〈一句话功能简述〉<br>
 * 〈功能详细描述〉
 * 
 * @author chenzhao
 * @version [版本号, 2012-12-17]
 */
@Controller
@RequestMapping("/")
public class IndexController extends BaseController {

    @Value("#{shiro['sso.url']}")
    private String ssoUrl;

    @Value("#{shiro['sso.callback.url']}")
    private String callbackUrl;

    /**
     * 功能描述: <br>
     * 〈功能详细描述〉
     * 
     * @param response
     * @param request
     * @return
     */
    @SuppressWarnings("all")
    @RequestMapping(value = "/", method = { RequestMethod.GET })
    public String index(HttpServletResponse response, HttpServletRequest request) {

        return getAutoUrl();
    }

    /**
     * {方法的功能/动作描述}
     * 
     * @param request
     * @param response
     * @return
     * @throws Exception
     * @throws {说明在某情况下,将发生什么异常}
     * @Author ChenZhao
     */
    public ModelAndView handleRequest(HttpServletRequest request,
            HttpServletResponse response) throws Exception {
        response.sendRedirect(request.getRequestURL() + "/index");
        return null;
    }

    /**
     * 
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/logout", method = { RequestMethod.GET,
            RequestMethod.POST })
    public String logout() throws Exception {
        return "redirect:" + ssoUrl + "/logout?service=" + this.callbackUrl;
    }
}
