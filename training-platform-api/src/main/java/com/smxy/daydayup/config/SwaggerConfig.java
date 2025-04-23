package com.smxy.daydayup.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.env.Environment;
import org.springframework.core.env.Profiles;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import springfox.documentation.builders.RequestHandlerSelectors;
import springfox.documentation.oas.annotations.EnableOpenApi;
import springfox.documentation.service.ApiInfo;
import springfox.documentation.service.Contact;
import springfox.documentation.spi.DocumentationType;
import springfox.documentation.spring.web.plugins.Docket;

import java.util.ArrayList;

/**
 * @team daydayup
 * @time 2021-12-06 21:54
 */

/**
 * Swagger配置文件
 */
@Configuration
@EnableOpenApi
@EnableWebMvc
public class SwaggerConfig {
    @Bean
    public Docket docket(Environment environment) {

        //设置要显示的Swagger环境
        Profiles profiles = Profiles.of("dev","test");
        //获取项目的环境
        boolean flag = environment.acceptsProfiles(profiles);

        return new Docket(DocumentationType.OAS_30) // v2 不同
                .apiInfo(apiInfo())
                .groupName("管理员")
                .enable(true)  //问题？Swagger只在生产环境中使用，在发布的时候不使用
                .select()
                .apis(RequestHandlerSelectors.basePackage("com.smxy.daydayup.controller")) // 设置扫描路径
                .build();
    }
    //配置多个分组
//    @Bean
//    public Docket docket1(){
//        return new Docket(DocumentationType.OAS_30).groupName("小A");
//    }
//    @Bean
//    public Docket docket2(){
//        return new Docket(DocumentationType.OAS_30).groupName("小B");
//    }

    private ApiInfo apiInfo(){
        //作者信息
        Contact contact = new Contact("管理员","https://scau.edu.cn/gongbulan/linxue/index.psp","123456789@qq.com");

        return new ApiInfo(
                "基层卫生人员培训平台",
                "华南农业大学",
                "v1.0",
                "https://scau.edu.cn/gongbulan/linxue/index.psp",
                contact,
                "Apache 2.0",
                "https://scau.edu.cn/gongbulan/linxue/index.psp",
                new ArrayList()
        );
    }
}

//package com.smxy.daydayup.config;
//
//import org.springframework.context.annotation.Bean;
//import org.springframework.context.annotation.Configuration;
//import org.springframework.core.env.Environment;
//import org.springframework.core.env.Profiles;
//import org.springframework.web.servlet.config.annotation.EnableWebMvc;
//import springfox.documentation.builders.RequestHandlerSelectors;
//import springfox.documentation.builders.PathSelectors;
//import springfox.documentation.service.ApiInfo;
//import springfox.documentation.service.Contact;
//import springfox.documentation.spi.DocumentationType;
//import springfox.documentation.spring.web.plugins.Docket;
//import springfox.documentation.swagger2.annotations.EnableSwagger2;
//
//import java.util.ArrayList;
//
///**
// * @team daydayup
// * @time 2021-12-06 21:54
// */
//
///**
// * Swagger配置文件
// */
//@Configuration
//@EnableSwagger2
//@EnableWebMvc
//public class SwaggerConfig {
//    @Bean
//    public Docket docket(Environment environment) {
//
//        //设置要显示的Swagger环境
//        Profiles profiles = Profiles.of("dev", "test");
//        //获取项目的环境
//        boolean flag = environment.acceptsProfiles(profiles);
//
//        return new Docket(DocumentationType.SWAGGER_2) // 使用 Swagger 2
//                .apiInfo(apiInfo())
//                .groupName("管理员")
//                .enable(flag)  // 根据环境决定是否启用Swagger
//                .select()
//                .apis(RequestHandlerSelectors.basePackage("com.smxy.daydayup.controller")) // 设置扫描路径
//                .paths(PathSelectors.any()) // 可以选择具体的路径
//                .build();
//    }
//
//    private ApiInfo apiInfo() {
//        //作者信息
//        Contact contact = new Contact("管理员", "https://www.cnblogs.com/mySMU/", "2435298907@qq.com");
//
//        return new ApiInfo(
//                "学习通极速版",
//                "即使再小的帆也能远航！！！",
//                "v1.0",
//                "https://www.cnblogs.com/mySMU/",
//                contact,
//                "Apache 2.0",
//                "http://www.apache.org/licenses/LICENSE-2.0",
//                new ArrayList<>()
//        );
//    }
//}
