package egovframework.example.board.service.impl;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import egovframework.example.board.mapper.MemberMapper;
import egovframework.example.board.service.MemberService;
import egovframework.example.board.vo.MemberVO;

@Service
public class MemberServiceImpl implements MemberService{

	@Resource(name = "memberMapper")
	private MemberMapper mapper;
	
	// 회원가입
	@Override
	public void join(MemberVO vo) throws Exception {
		mapper.join(vo);
	}
	
	// ID 중복 검사
	@Override
	public int idChk(String id) throws Exception {
		return mapper.idChk(id);
	}

	// 로그인
	@Override
	public MemberVO login(MemberVO vo) throws Exception {
		return mapper.login(vo);
	}
	

}
