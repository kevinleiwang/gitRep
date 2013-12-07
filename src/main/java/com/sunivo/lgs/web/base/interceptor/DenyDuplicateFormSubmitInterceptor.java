package com.sunivo.lgs.web.base.interceptor;

import java.util.concurrent.atomic.AtomicLong;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

/**
 * 重复提交（Token）检测拦截器
 * 
 * @author chengjianfang@sunivo.com
 * 
 *         2013年12月4日 下午5:21:04
 */
public class DenyDuplicateFormSubmitInterceptor implements HandlerInterceptor {
    /**
     * 日志记录器
     */
    private static final Logger LOGGER = LoggerFactory
            .getLogger(DenyDuplicateFormSubmitInterceptor.class);

    public boolean preHandle(HttpServletRequest request,
            HttpServletResponse response, Object handler) throws Exception {
        LOGGER.debug("执行开始前拦截" + request.getRequestURI());
        try {
            // 无论什么请求，获取token值，之前只针对POST请求，可能会漏掉GET请求提交的表单数据
            String tokenString = request.getParameter("token");
            // 如果token值不存在则直接放行
            if (StringUtils.isBlank(tokenString)) {
                return true;
            }
            // 转化token值为long
            long token = Long.parseLong(tokenString);
            // 获取Session中token值
            AtomicLong tokenInSession = (AtomicLong) request.getSession()
                    .getAttribute("token");
            // 如果Session中token值为空，则直接放行
            if (null == tokenInSession) {
                return true;
            }
            // 获取并更新session中token值
            long tokenInSessionValue = tokenInSession.getAndIncrement();
            // 如果token匹配OK，放行
            if (token == tokenInSessionValue) {
                return true;
            } else {
                // 如果不匹配，写入信息不允许重复提交
                response.setContentType("text/html;charset=UTF-8");
                response.getWriter().print("请不要重复提交表单");
                return false;
            }
        } catch (Exception ex) {
            LOGGER.warn("检测令牌时发生异常，默认放行", ex);
            // 如果发生异常则放行
            return true;
        }
    }

    public void afterCompletion(HttpServletRequest request,
            HttpServletResponse response, Object handler, Exception ex)
            throws Exception {
        LOGGER.debug("执行完成后拦截" + request.getRequestURI());
        // response.setHeader ("Content-Type", "application/json");
    }

    public void postHandle(HttpServletRequest request,
            HttpServletResponse response, Object handler,
            ModelAndView modelAndView) throws Exception {
        LOGGER.debug("拦截完成" + request.getRequestURI());
    }
}