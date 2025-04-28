package com.ders.bm470.config;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import org.springframework.web.servlet.support.AbstractAnnotationConfigDispatcherServletInitializer;

public class WebAppInitializer
        extends AbstractAnnotationConfigDispatcherServletInitializer {

    @Override
    public void onStartup(ServletContext servletContext) throws ServletException {
        // Hata yığını görmek istiyorsanız, bu try/catch kalabilir:
        try {
            super.onStartup(servletContext);
        } catch (Throwable ex) {
            ex.printStackTrace();
            if (ex instanceof ServletException) {
                throw (ServletException) ex;
            }
            throw new ServletException(ex);
        }
    }

    @Override
    protected Class<?>[] getRootConfigClasses() {
        // kök context yok
        return null;
    }

    @Override
    protected Class<?>[] getServletConfigClasses() {
        // tüm konfigürasyonlar DispatcherServlet context'ine
        return new Class[]{
                WebConfig.class,
                RootConfig.class,
                DataSourceConfig.class,
                SecurityConfig.class
        };
    }

    @Override
    protected String[] getServletMappings() {
        return new String[]{ "/" };
    }
}
