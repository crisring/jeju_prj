package kr.co.sist.admin.config;

import java.io.PrintWriter;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.util.WebUtils;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Component
public class AdminInterceptor implements HandlerInterceptor {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		boolean flag=false;
		System.out.println("요청 URI : "+request.getRequestURI());
		System.out.println("1. preHandle");
		//세션의 값 받기
		Object admin_id=WebUtils.getSessionAttribute(request, "admin_id");
		System.out.println("얻어진 세션 : " + admin_id);
		flag=admin_id != null; // 세션에 아이디가 존재하는 경우
		
		if(!flag) {
	        // 세션이 없을 때 처리
	        response.setContentType("text/html; charset=UTF-8");
	        PrintWriter out = response.getWriter();
	        out.println("<script>");
	        out.println("alert('세션이 만료되었습니다. 다시 로그인해주세요.');");
	        out.println("location.href='/admin/login';");  // 로그인 페이지 경로
	        out.println("</script>");
	        out.flush();
	        return false;
	    }
		return flag; //false가 실행되면 뒤로 Controller > Interceptor > ViewResolver 실행x
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		System.out.println("2. postHandle");
	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		System.out.println("3. afterCompletion");
		System.out.println(response.getStatus());
	}

}
