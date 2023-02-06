package egovframework.example.board.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.ws.rs.POST;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
	public String login(MemberVO vo, ModelMap model) throws Exception {

		try {
			// 로그인 성공시 vo 반환
			MemberVO login = service.login(vo);

			if (login == null) { // 로그인 실패
				int result = 0;
				model.addAttribute("result", result);
				return "login/loginPage";
			}
			// 로그인 성공
			model.addAttribute("login", login);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:/boardList.do";
	}
	
	// 로그아웃
	@PostMapping("logout.do")
	@ResponseBody
	public String logout(HttpServletRequest request) throws Exception {
		
		HttpSession session = request.getSession();
		session.invalidate(); // 세션 전체 무효화
		//session.removeAttribute("loginUser"); //특정 이름으로 네이밍한 session 객체를 삭제
		return "redirect:/board/boardList";
	}

}
