package com.sunivo.lgs.web.event;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationListener;
import org.springframework.security.core.session.SessionCreationEvent;

public class ServletSessionCreationEvent implements
        ApplicationListener<SessionCreationEvent> {

    /**
     * 定义日志类
     */
    private static final Logger LOGGER = LoggerFactory
            .getLogger(ServletSessionCreationEvent.class);

    /**
     * {方法的功能/动作描述}
     * 
     * @param event
     * @exception {说明在某情况下,将发生什么异常}
     * @Author ChenZhao
     */
    public void onApplicationEvent(SessionCreationEvent event) {
        System.out.println(event.toString());
        LOGGER.info(event.toString());
    }
}
