package com.ders.bm470.config;

import com.mchange.v2.c3p0.ComboPooledDataSource;
import jakarta.persistence.EntityManagerFactory;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.transaction.annotation.EnableTransactionManagement;
import org.springframework.orm.jpa.LocalContainerEntityManagerFactoryBean;
import org.springframework.orm.jpa.JpaTransactionManager;
import org.springframework.orm.jpa.vendor.HibernateJpaVendorAdapter;

import javax.sql.DataSource;
import java.beans.PropertyVetoException;
import java.util.Properties;

@Configuration
@EnableTransactionManagement
public class DataSourceConfig {

    @Bean
    public DataSource dataSource() throws PropertyVetoException {
        var ds = new ComboPooledDataSource();
        ds.setDriverClass("com.mysql.cj.jdbc.Driver");
        ds.setJdbcUrl(
                "jdbc:mysql://127.0.0.1:3306/testdb"
                        + "?useSSL=false"
                        + "&allowPublicKeyRetrieval=true"
                        + "&serverTimezone=Europe/Istanbul"
        );
        ds.setUser("testuser");
        ds.setPassword("testpassword");
        return ds;
    }

    @Bean
    public LocalContainerEntityManagerFactoryBean entityManagerFactory(DataSource ds) {
        var em = new LocalContainerEntityManagerFactoryBean();
        em.setDataSource(ds);
        em.setPackagesToScan("com.ders.bm470.model");
        em.setJpaVendorAdapter(new HibernateJpaVendorAdapter());
        var p = new Properties();
        p.put("hibernate.hbm2ddl.auto","update");
        p.put("hibernate.dialect","org.hibernate.dialect.MySQL8Dialect");
        p.put("hibernate.show_sql","true");
        em.setJpaProperties(p);
        return em;
    }

    @Bean
    public JpaTransactionManager transactionManager(EntityManagerFactory emf) {
        return new JpaTransactionManager(emf);
    }
}
