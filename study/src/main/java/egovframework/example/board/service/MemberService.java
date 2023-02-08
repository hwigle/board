package egovframework.example.board.service;

import java.util.Map;

import org.springframework.web.bind.annotation.RequestBody;

import egovframework.example.board.vo.MemberVO;

public interface MemberService {
	
		// 회원가입
		public void join(MemberVO vo) throws Exception;
		
		// ID 중복 검사
		public int idChk(String id) throws Exception;
		
		// 로그인
		public MemberVO login(MemberVO vo) throws Exception;
		
		// 로그인 Ajax
		public MemberVO loginA(Map<String, Object> param) throws Exception;
}
