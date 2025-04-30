package com.ders.bm470.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.context.annotation.Bean;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.provisioning.InMemoryUserDetailsManager;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.servlet.handler.HandlerMappingIntrospector;

@Configuration
@EnableWebSecurity
public class SecurityConfig {

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http
                .csrf(csrf -> csrf.disable())
                .authorizeHttpRequests(auth -> auth
                        // Sadece CSS/JS izinli, login/logout işlemleri permitAll()’ta açılacak:
                        .requestMatchers("/WEB-INF/**", "/login", "/perform_login", "/css/**").permitAll()
                        .anyRequest().authenticated()
                )
                .formLogin(form -> form
                        .loginPage("/login")                  // GET /login
                        .loginProcessingUrl("/perform_login") // POST /perform_login
                        .defaultSuccessUrl("/home", true)     // girişten sonra /home
                        .failureUrl("/login?error")           // hata varsa yine /login
                        .permitAll()                          // login sayfası ve işlemleri izinli
                )
                .logout(logout -> logout
                        .logoutUrl("/logout")
                        .logoutSuccessUrl("/login?logout")
                        .permitAll()                          // logout da izinli
                );

        return http.build();
    }

    @Bean
    public InMemoryUserDetailsManager userDetailsService() {
        UserDetails u1 = User.withUsername("admin").password("{noop}1234").roles("ADMIN").build();
        UserDetails u2 = User.withUsername("user") .password("{noop}1234").roles("USER") .build();
        return new InMemoryUserDetailsManager(u1, u2);
    }

    @Bean
    public HandlerMappingIntrospector mvcHandlerMappingIntrospector() {
        return new HandlerMappingIntrospector();
    }
}
