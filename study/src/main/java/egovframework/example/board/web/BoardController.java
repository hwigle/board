package egovframework.example.board.web;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.example.board.service.BoardService;
import egovframework.example.board.vo.BoardVO;
import egovframework.example.board.vo.Criteria;
import egovframework.example.board.vo.PageMaker;

@Controller
public class BoardController {
		
		@Autowired
		private BoardService service;
		
		private static final Logger logger = LoggerFactory.getLogger(BoardController.class); 
				
		// 메인
		@GetMapping("/main.do")
		public String main() {
			return "/main";
		}
		
		// 게시글 목록
		@GetMapping("/boardList.do")
		public String list(Criteria cri, ModelMap model) throws Exception {
			
			try {
			List<BoardVO> list = service.selectListPaging(cri);
			
			model.addAttribute("list", list);
			
			// 게시글 총 갯수
			int total = service.getTotal(cri);
			
			PageMaker pageMaker = new PageMaker(cri, total);
			
			model.addAttribute("pageMaker", pageMaker);
			
			} catch(SQLException se){
				logger.error("SQL 예외 : " + se.toString());
			
			} catch(Exception e) {
				logger.error("예외 : " + e.toString());
			}
			
			return "board/boardList";
		}
		
		// 게시글 상세
		@GetMapping("/boardDetail.do")
		public String detail(BoardVO vo, ModelMap model) throws Exception {
			
			try {
				// 조회수 증가
				service.updateHit(vo.getBno());
					
				// 상세 조회
				BoardVO detail = service.selectDetail(vo.getBno());
				
				model.addAttribute("detail", detail);
			} catch(SQLException se){
				logger.error("SQL 예외 : " + se.toString());
			
			} catch(Exception e) {
				logger.error("예외 : " + e.toString());
			}
			return "board/boardDetail";
		}
		
		// 게시글 등록 화면 이동
		@GetMapping("/boardWrite.do")
		public String write() throws Exception {
			return "board/boardWrite";
		}
		
		// 게시글 등록
		@ResponseBody
		@PostMapping("insert.do")
		public String insertBoard(@RequestBody Map<String, Object> param) throws Exception {
		String rt="";
		
		try {
			service.insertBoard(param);
			rt= "1";
			
		} catch(SQLException se){
			logger.error("SQL 예외 : " + se.toString());
			rt = "2";
		
		} catch(Exception e) {
			logger.error("예외 : " + e.toString());
			rt = "3";
		}
		
		return rt;
	}
		
		// 게시글 수정 화면 이동
		@GetMapping("/boardModify.do")
		public String modifyBoard(BoardVO vo, ModelMap model) throws Exception {
			
			try {
				BoardVO detail = service.selectDetail(vo.getBno());
				
				model.addAttribute("detail", detail);
				
			} catch(SQLException se){
				logger.error("SQL 예외 : " + se.toString());
			
			} catch(Exception e) {
				logger.error("예외 : " + e.toString());
			}
			
			return "board/boardModify";
		}
		
		// 게시글 수정
		@PostMapping("modify.do")
		@ResponseBody
		public String modify(@RequestBody Map<String, Object> param) throws Exception {
			String rt = ""; 
			try {
				service.modifyBoard(param);
				rt = "1";
			} catch(SQLException se){
				logger.error("SQL 예외 : " + se.toString());
				rt = "2";
			
			} catch(Exception e) {
				logger.error("예외 : " + e.toString());
				rt = "3";
			}
			
			return rt;
		}
		
		// 게시글 삭제
		@GetMapping("delete.do")
		public String delete(int bno) throws Exception {
			
			service.deleteBoard(bno);
			
			return "redirect:boardList.do"; // redirect 오른쪽 주소로 URL 요청을 다시 하는 것 > 그로 인해 delete.do에서 boardList.do로 주소가 바뀌고 여기에 속한 컨트롤러의 함수가 한번 더 호출
		}
}
