package egovframework.example.board.web;

import java.util.Random;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.example.board.service.MemberService;
import egovframework.example.board.vo.MemberVO;

@Controller
public class MemberController {
	
	@Autowired
	private MemberService service;
	
	@Autowired
	private JavaMailSender mailSender;
	
	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);
	
	// 회원가입 페이지 이동
	@GetMapping("/join.do")
	public String join() {
		return "member/join";
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
		return "member/loginPage";
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
				return "member/loginPage";
			}
			// 로그인 성공
			model.addAttribute("login", login);
		} catch (Exception e) {
			logger.error(e.toString());
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
	
	// 이메일 인증
	@GetMapping("mailCheck.do")
	@ResponseBody
	public String mailCheck(String mail) throws Exception {
		
		// View로부터 넘어온 데이터 확인 
        logger.info("이메일 데이터 전송 확인");
        logger.info("인증번호 : " + mail);
        
        // 인증번호(난수) 생성
        Random random = new Random();
        int checkNum = random.nextInt(888888) + 111111;
        logger.info("인증번호 : " + checkNum);
        
        // 이메일 보내기 
        String setFrom = "fhaktj5wkd8wjf@naver.com";
        String toMail = mail;
        String title = "회원가입 인증 이메일 입니다.";
        String content = 
                "홈페이지를 방문해주셔서 감사합니다." +
                "<br><br>" + 
                "인증 번호는 " + checkNum + "입니다." + 
                "<br>" + 
                "해당 인증번호를 인증번호 확인란에 기입하여 주세요.";
        
        try {
            
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
            helper.setFrom(setFrom);
            helper.setTo(toMail);
            helper.setSubject(title);
            helper.setText(content,true);
            mailSender.send(message);
            
        }catch(Exception e) {
            logger.error("예외 발생 : " + e.toString());
        }
        
        String num = Integer.toString(checkNum); // ajax를 통해 뷰로 다시 반환할 때 데이터 타입은 String만 가능
        
        return num;
	}
	
}
