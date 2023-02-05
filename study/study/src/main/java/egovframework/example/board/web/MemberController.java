package egovframework.example.board.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.example.board.service.MemberService;
import egovframework.example.board.vo.MemberVO;

@Controller
public class MemberController {
	
	@Autowired
	private MemberService service;
	
	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);
	
	// 회원가입 페이지 이동
	@GetMapping("/join.do")
	public String join() {
		return "join/join";
	}
	
	// 회원가입
	@PostMapping("/join.do")
	public String joinIns(MemberVO vo) throws Exception {
		String rt = "";
		try {
			service.join(vo);
			rt="1";
		} catch(Exception e){
			logger.error(e.toString());
			rt="2";
		}
		return "redirect:/boardList.do";
	}
	
	// ID 중복 검사
	@PostMapping("/idChk.do")
	@ResponseBody // jsp로 메서드 결과 반환
	public String idChk(String id) throws Exception {
		
		int rt = service.idChk(id);
		
		if(rt != 0) {
			return "2"; // 중복 ID 존재
		} else {
			return "1"; // 중복 ID 없음
		}
	}
	
	// 로그인 페이지 이동
	@GetMapping("loginPage.do")
	public String loginPage() {
		return "login/loginPage";
	}
	
	// 로그인
	@PostMapping("login.do")
	public String login(HttpServletRequest request, MemberVO vo) throws Exception{
		
		HttpSession session = request.getSession();
		
		MemberVO lvo = service.login(vo);
		
		if(lvo == null) {
			int result = 0;
			return "login/loginPage";
		}
			
		session.setAttribute("member", lvo);
		
		return "redirect:/boardList.do";
	}
}
