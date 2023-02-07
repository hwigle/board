package egovframework.example.board.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.example.board.mapper.BoardMapper;
import egovframework.example.board.service.BoardService;
import egovframework.example.board.vo.BoardVO;
import egovframework.example.board.vo.Criteria;

@Service
public class BoardServiceImpl implements BoardService{
	
	@Resource(name = "boardMapper")
	private BoardMapper mapper;
	
	// 게시글 목록
	@Override
	public List<BoardVO> selectList() throws Exception {
		return mapper.selectList();
	}

	// 게시글 상세
	@Override
	public BoardVO selectDetail(int bno) throws Exception {
		return mapper.selectDetail(bno);
	}
	
	// 조회수 증가
	@Override
	public int updateHit(int bno) throws Exception {
		return mapper.updateHit(bno);
	}
	
	// 게시글 등록
	@Override
	public void insertBoard(Map<String, Object> param) throws Exception {
		mapper.insertBoard(param);
	}
	
	// 게시글 수정
	@Override
	public void modifyBoard(Map<String, Object> param) throws Exception {
		mapper.modifyBoard(param);
	}
	
	// 게시글 삭제
	@Override
	public void deleteBoard(int bno) throws Exception {
		mapper.deleteBoard(bno);
	}

	@Override
	public List<BoardVO> selectListPaging(Criteria cri) throws Exception {
		return mapper.selectListPaging(cri);
	}

	@Override
	public int getTotal(Criteria cri) throws Exception {
		return mapper.getTotal(cri);
	}
}
