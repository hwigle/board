package egovframework.example.board.web;

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
		service.join(vo);
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
}
