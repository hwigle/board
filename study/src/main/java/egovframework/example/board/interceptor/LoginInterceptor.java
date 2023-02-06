package egovframework.example.board.interceptor;


import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.ui.ModelMap;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import egovframework.example.board.web.BoardController;



public class LoginInterceptor  extends HandlerInterceptorAdapter{
	
	private static final String LOGIN = "loginUser";
	
	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);

	// preHandle : 컨트롤러로 request 들어가기 전에 작동
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception { // Object handler : 핸들러 매핑이 찾은 컨트롤러 클래스 객체
		
		System.out.println("preeeeeeeee");
		
		HttpSession session = request.getSession();
		
		// 기본 로그인 정보 제거
		if(session != null) {
			session.removeAttribute(LOGIN);
		} else {
			response.sendRedirect("loginPage.do");
			return false;
		}
		
		return true;
	}
	
    
	
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
		
		HttpSession session = request.getSession();
		
		Object login = modelAndView.getModelMap().get("loginModel");

		if(login != null) {
			session.setAttribute(LOGIN, login);
		}
		
	}
}
