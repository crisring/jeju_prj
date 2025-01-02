package kr.co.sist.admin.config;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class InterceptorConfig implements WebMvcConfigurer {

	@Autowired(required = false)
	private AdminInterceptor adminInterceptor;

	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		
		List<String> addPaths=new ArrayList<>();
		addPaths.add("/admin/**");
		List<String> excludePaths=new ArrayList<>();
		excludePaths.add("/admin/loginFrm");
		excludePaths.add("/admin/loginProcess");
		
		registry.addInterceptor(adminInterceptor)
		.addPathPatterns(addPaths)
		.excludePathPatterns(excludePaths);
		
	}
	
		
	
}
