package com.ders.bm470.config;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;
import java.util.Enumeration;
import java.util.Map;


public class LoggingInterceptor implements HandlerInterceptor {

    private static final Logger logger = LoggerFactory.getLogger(LoggingInterceptor.class);

    @Override
    public boolean preHandle(HttpServletRequest request,
                             HttpServletResponse response,
                             Object handler) {

        logger.info("İSTEK: {} {}", request.getMethod(), request.getRequestURI());

        Enumeration<String> paramNames = request.getParameterNames();
        while (paramNames.hasMoreElements()) {
            String name = paramNames.nextElement();
            String value = request.getParameter(name);
            logger.info("Parametre: {} = {}", name, value);
        }

        return true;
    }

    @Override
    public void postHandle(HttpServletRequest request,
                           HttpServletResponse response,
                           Object handler,
                           ModelAndView modelAndView) {

        if (modelAndView != null) {
            // 1. View adı (JSP path gibi): örnek => "home", "tests/list", vs.
            String viewName = modelAndView.getViewName();
            logger.info("Dönülen View: {}", viewName);

            // 2. Model içeriğini logla
            Map<String, Object> modelMap = modelAndView.getModel();
            for (Map.Entry<String, Object> entry : modelMap.entrySet()) {
                logger.info("Model verisi: {} = {}", entry.getKey(), entry.getValue());
            }
        }
    }

    @Override
    public void afterCompletion(HttpServletRequest request,
                                HttpServletResponse response,
                                Object handler,
                                Exception ex) {
        logger.info("YANIT DURUMU: {} {}", response.getStatus(), request.getRequestURI());
    }
}
