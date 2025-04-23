package com.smxy.daydayup.config;

import com.alibaba.druid.pool.DruidDataSource;
import com.alibaba.druid.support.http.StatViewServlet;
import com.alibaba.druid.support.http.WebStatFilter;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.boot.web.servlet.ServletRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import javax.sql.DataSource;
import java.util.HashMap;
import java.util.Map;

/**
 * @team daydayup
 * @time 2021-12-06 21:54
 */

/**
 * Druid配置文件
 * 开启Druid数据监控
 */
@Configuration
public class DruidConfig {

    @ConfigurationProperties(prefix = "spring.datasource")
    @Bean
    public DataSource druidDataSource(){
        return new DruidDataSource();
    }

    //后台监控
    @Bean
    public ServletRegistrationBean statViewServlet(){
        ServletRegistrationBean<StatViewServlet> bean = new ServletRegistrationBean<>(new StatViewServlet(),"/druid/*");
        //后台登录需要配置账号密码
        HashMap<String,String> initParameters = new HashMap<>();
        //账号密码配置
        initParameters.put("loginUsername","admin");
        initParameters.put("loginPassword","123456");

        //允许谁可以访问
//        initParameters.put("allow","");
        //禁止谁能访问

        //设置初始化参数
        bean.setInitParameters(initParameters);
        return bean;
    }

    // filter
    public FilterRegistrationBean webStatFilter(){
        FilterRegistrationBean bean = new FilterRegistrationBean();
        bean.setFilter(new WebStatFilter());

        Map<String,String> initParameters = new HashMap<>();
        // 这些东西不进行统计
        initParameters.put("exclusions","*.js,*.css,/druid/*");


        bean.setInitParameters(initParameters);
        return bean;
    }
}

