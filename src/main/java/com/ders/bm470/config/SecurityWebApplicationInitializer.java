package com.ders.bm470.config;

import org.springframework.security.web.context.AbstractSecurityWebApplicationInitializer;

/**
 * Bu sınıf, springSecurityFilterChain filtresini
 * servlet container'a /* pattern'i ile kaydeder.
 */
public class SecurityWebApplicationInitializer
        extends AbstractSecurityWebApplicationInitializer {
    // Boş. super() çağrısı springSecurityFilterChain bean'ini alıp DelegatingFilterProxy olarak kaydeder.
}
