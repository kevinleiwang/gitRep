package com.sunivo.lgs.web.controller.framework;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sunivo.lgs.web.base.controller.BaseController;

/**
 * 公共操作控制器
 * 
 * @author chengjianfang
 * 
 */
@Controller
@RequestMapping(value = "/commons")
public class CommonsController extends BaseController {

    /**
     * 进入用户中心
     * 
     * @param model
     *            模型
     * @return 用户中心页面
     */
    @RequestMapping(value = "userProfileSection")
    public String userProfileSection(Model model) {
        return getAutoUrl();
    }

    /**
     * 修改密码
     * 
     * @param oldPassword
     *            老密码
     * @param password
     *            新密码
     * @param confirmPasswrod
     *            确认新密码
     * @param model
     *            模型
     * @return 操作成功与否
     */
    @RequestMapping(value = "changePassword", method = { RequestMethod.POST,
            RequestMethod.GET })
    @ResponseBody
    public String changePassword(String oldPassword, String password,
            String confirmPassword, Model model) {
        // 如果老密码，新密码或确认新密码中存在一者为空，则直接失败
        if (StringUtils.isBlank(oldPassword) || StringUtils.isBlank(password)
                || StringUtils.isBlank(confirmPassword)) {
            return "{\"status\":\"1\", \"message\":\"password can't be null\"}";
        } else {
            if (oldPassword.equals(password)) {
                return "{\"status\":\"1\", \"message\":\"password can't be equlas old password\"}";
            } else {
                if (password.equals(confirmPassword)) {
                    // 获取当前登录用户ID
                    int id = 0;
                    // 获取用户信息
                    try {
                        return "{\"status\":\"0\", \"message\":\"password change success\"}";
                    } catch (Exception ex) {
                        return "{\"status\":\"1\", \"message\":\"password change failed\"}";
                    }
                } else {
                    return "{\"status\":\"1\", \"message\":\"password must be equlas confirm password\"}";
                }
            }
        }
    }
}