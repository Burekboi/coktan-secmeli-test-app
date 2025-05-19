package com.ders.bm470.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.ProviderManager;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.provisioning.InMemoryUserDetailsManager;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.web.servlet.handler.HandlerMappingIntrospector;
import org.springframework.beans.factory.annotation.Autowired;
import java.util.Arrays;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;


@Configuration
@ComponentScan(basePackages = "com.ders.bm470.security")
@EnableWebSecurity
@EnableMethodSecurity(prePostEnabled = true)
public class SecurityConfig {

    private final UserDetailsService userDetailsService;

    public SecurityConfig(@Qualifier("customUserDetailsService")UserDetailsService userDetailsService) {
        this.userDetailsService = userDetailsService;
    }

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http, HandlerMappingIntrospector introspector) throws Exception {
        http
                .csrf(csrf -> csrf.disable())
                .authorizeHttpRequests(auth -> auth
                        .requestMatchers("/WEB-INF/**", "/login", "/perform_login", "/register", "/css/**").permitAll()
                        .requestMatchers("/admin/**").hasRole("ADMIN")
                        .anyRequest().authenticated()
                )
                .formLogin(form -> form
                        .loginPage("/login")
                        .loginProcessingUrl("/perform_login")
                        .defaultSuccessUrl("/home", true)
                        .failureUrl("/login?error=true")
                        .permitAll()
                )
                .logout(logout -> logout
                        .logoutUrl("/perform_logout")
                        .logoutSuccessUrl("/login?logout=true")
                        .invalidateHttpSession(true)
                        .deleteCookies("JSESSIONID")
                        .permitAll()
                )
                .authenticationManager(authenticationManager());

        return http.build();
    }

    @Bean
    public AuthenticationManager authenticationManager() {
        return new ProviderManager(Arrays.asList(
                daoAuthenticationProvider(),
                inMemoryAuthenticationProvider()
        ));
    }

    @Bean
    public DaoAuthenticationProvider daoAuthenticationProvider() {
        DaoAuthenticationProvider provider = new DaoAuthenticationProvider();
        provider.setUserDetailsService(userDetailsService); // DB'den gelen kullanıcılar
        provider.setPasswordEncoder(passwordEncoder());
        return provider;
    }

    @Bean
    public DaoAuthenticationProvider inMemoryAuthenticationProvider() {
        DaoAuthenticationProvider provider = new DaoAuthenticationProvider();
        provider.setUserDetailsService(inMemoryUserDetailsService()); // Statik kullanıcı
        provider.setPasswordEncoder(passwordEncoder());
        return provider;
    }

    @Bean(name = "inMemoryUserDetailsService")
    public UserDetailsService inMemoryUserDetailsService() {
        UserDetails admin = User.builder()
                .username("admin")
                .password(passwordEncoder().encode("1234"))
                .roles("ADMIN")
                .build();

        return new InMemoryUserDetailsManager(admin);
    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean
    public HandlerMappingIntrospector mvcHandlerMappingIntrospector() {
        return new HandlerMappingIntrospector();
    }
}
