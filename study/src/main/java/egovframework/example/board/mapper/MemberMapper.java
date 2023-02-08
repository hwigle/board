package egovframework.example.board.mapper;

import java.util.Map;

import org.springframework.web.bind.annotation.RequestBody;

import egovframework.example.board.vo.MemberVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("memberMapper")
public interface MemberMapper {
		
		// 회원가입
		public void join(MemberVO vo) throws Exception;
		
		// ID 중복 검사
		public int idChk(String id) throws Exception;
		
		// 로그인
		public MemberVO login(MemberVO vo) throws Exception;
		
}
