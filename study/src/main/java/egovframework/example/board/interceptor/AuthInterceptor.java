package egovframework.example.board.interceptor;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import egovframework.example.board.web.BoardController;


public class AuthInterceptor extends HandlerInterceptorAdapter {
	
	private static final String LOGIN = "loginUser";
	
	private static final String ATTEMPTED = "attemptedLocation";
	
	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		
		HttpSession session = request.getSession();
		
		if (session.getAttribute(LOGIN) == null) {
			String uri = request.getRequestURI();
			String query = request.getQueryString();
			if(StringUtils.isNotEmpty(query)) 
				uri +="?"+query;
			
			session.setAttribute(ATTEMPTED, uri);
			
			response.sendRedirect("/loginPage.do");
			return false;
		}

		return true;
	}
	
}
