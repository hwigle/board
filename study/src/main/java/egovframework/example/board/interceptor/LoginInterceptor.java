package egovframework.example.board.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class LoginInterceptor  extends HandlerInterceptorAdapter{
	final String login = "login";
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		
		
		HttpSession session = request.getSession(); // 세션은 브라우저 단위로 생성
		
		if(session.getAttribute(login) != null) {
			session.removeAttribute(login);
		}
		
		return true;
	}
	
	@Override
	public void postHandle(
			HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
		
		HttpSession session = request.getSession();
		
		Object lvo = modelAndView.getModelMap().get("lvo");
		if(lvo != null) {
			session.setAttribute(login, lvo);
		}
		
	}
}
