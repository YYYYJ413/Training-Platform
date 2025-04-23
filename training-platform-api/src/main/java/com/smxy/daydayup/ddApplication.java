package com.smxy.daydayup;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.cloud.openfeign.EnableFeignClients;
import org.springframework.data.jpa.repository.config.EnableJpaAuditing;
import springfox.documentation.oas.annotations.EnableOpenApi;

@EnableFeignClients
@SpringBootApplication
@EnableOpenApi
@EnableJpaAuditing
@MapperScan(basePackages = {"com.smxy.daydayup.mapper"})
public class ddApplication {

    public static void main(String[] args) {
        SpringApplication.run(ddApplication.class, args);
    }

}
