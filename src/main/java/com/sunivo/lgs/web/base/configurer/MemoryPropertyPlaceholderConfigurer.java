package com.sunivo.lgs.web.base.configurer;

import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

import org.springframework.beans.BeansException;
import org.springframework.beans.factory.config.ConfigurableListableBeanFactory;
import org.springframework.beans.factory.config.PropertyPlaceholderConfigurer;

public class MemoryPropertyPlaceholderConfigurer extends
        PropertyPlaceholderConfigurer {

    private static final Map<String, String> CTX_PROPERTIES = new HashMap<String, String>();

    @Override
    protected void processProperties(
            ConfigurableListableBeanFactory beanFactoryToProcess,
            Properties props) throws BeansException {
        super.processProperties(beanFactoryToProcess, props);
        for (Object key : props.keySet()) {
            String keyStr = key.toString();
            String value = props.getProperty(keyStr);
            CTX_PROPERTIES.put(keyStr, value);
        }
    }

    public static String getContextProperty(String name) {
        return CTX_PROPERTIES.get(name);
    }

    public static Map<String, String> getContextProperty() {
        return CTX_PROPERTIES;
    }
}