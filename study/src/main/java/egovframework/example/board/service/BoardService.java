package egovframework.example.board.service;

import java.util.List;
import java.util.Map;

import egovframework.example.board.vo.BoardVO;
import egovframework.example.board.vo.Criteria;

public interface BoardService {
		
		// 게시글 목록
		public List<BoardVO> selectList() throws Exception;
		
		// 게시글 목록(페이징)
	    public List<BoardVO> selectListPaging(Criteria cri) throws Exception;
	    
	    // 게시글 총 갯수
	    public int getTotal() throws Exception;
	    
		// 게시글 상세
		public BoardVO selectDetail(int bno) throws Exception;
		
		// 조회수 증가
		public int updateHit(int bno) throws Exception;
		
		// 게시글 작성
		public void insertBoard(Map<String, Object> param) throws Exception;
		
		// 게시글 수정
		public void modifyBoard(Map<String, Object> param) throws Exception;
		
		// 게시글 삭제
		public void deleteBoard(int bno) throws Exception;			
}
