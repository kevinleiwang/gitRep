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

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.sunivo.lgs.web.base.controller.BaseController;

/**
 * 〈一句话功能简述〉<br>
 * 〈功能详细描述〉
 * 
 * @author chenzhao
 * @version [版本号, 2012-12-17]
 */
@Controller
@RequestMapping("/error/cas")
public class CasErrorController extends BaseController {
    /**
     * 功能描述: <br>
     * 〈功能详细描述〉
     * 
     * @return
     */
    @RequestMapping(method = { RequestMethod.GET })
    public String error(HttpServletRequest request, Model model) {
        return getAutoUrl();
    }

    /**
     * 功能描述: <br>
     * 〈功能详细描述〉
     * 
     * @return
     */
    @RequestMapping(value = "/{errorCode}", method = { RequestMethod.GET })
    public String cas(@PathVariable(value = "errorCode") String errorCode,
            Model model) {
        model.addAttribute("errorCode", errorCode);
        return getAutoUrl();
    }
}
