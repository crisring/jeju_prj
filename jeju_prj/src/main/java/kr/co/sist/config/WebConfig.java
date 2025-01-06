package kr.co.sist.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebConfig implements WebMvcConfigurer{
	
	@Value("${file.upload.admin-dir}")
    private String adminUploadDir;
    
    @Value("${file.upload.review-dir}")
    private String reviewUploadDir;
    
    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        // admin 이미지용 (/images/**로 접근)
        registry.addResourceHandler("/images/**")
               .addResourceLocations("file:" + adminUploadDir + "/");
               
        // review 이미지용 (기존 경로 유지)
        registry.addResourceHandler("/common/user/review_Img/**")
               .addResourceLocations("file:" + reviewUploadDir + "/");
    }
	
}
