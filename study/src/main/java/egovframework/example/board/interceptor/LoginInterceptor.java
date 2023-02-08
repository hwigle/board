package egovframework.example.board.interceptor;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import egovframework.example.board.web.BoardController;



public class LoginInterceptor  extends HandlerInterceptorAdapter{
	
	private static final String LOGIN = "loginUser";
	
	private static final String ATTEMPTED = "attemptedLocation";
	
	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);

	// preHandle : 컨트롤러로 request 들어가기 전에 작동
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception { // Object handler : 핸들러 매핑이 찾은 컨트롤러 클래스 객체

		HttpSession session = request.getSession();

		if (session.getAttribute(LOGIN) != null) {
			session.removeAttribute(LOGIN);
		}

		return true;
	}
	
    
	
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {

		HttpSession session = request.getSession();

		Object login = modelAndView.getModelMap().get("login");

		if (login != null) {
			session.setAttribute(LOGIN, login);

			String attempted = (String) session.getAttribute(ATTEMPTED);
			if (StringUtils.isNotEmpty(attempted)) {

				response.sendRedirect(attempted);

				session.removeAttribute(ATTEMPTED);

			}

		}

	}
}
