package egovframework.example.board.vo;

import java.sql.Date;

public class BoardVO {

		private int bno;			// 글번호
		private String title;		// 글제목
		private String contents;	// 글내용
		private String writer;		// 작성자		
		private Date regDate;		// 작성일
		private int hit;			// 조회수
		
		public int getBno() {
			return bno;
		}
		public void setBno(int bno) {
			this.bno = bno;
		}
		public String getTitle() {
			return title;
		}
		public void setTitle(String title) {
			this.title = title;
		}
		public String getContents() {
			return contents;
		}
		public void setContents(String contents) {
			this.contents = contents;
		}
		public String getWriter() {
			return writer;
		}
		public void setWriter(String writer) {
			this.writer = writer;
		}
		public Date getRegDate() {
			return regDate;
		}
		public void setRegDate(Date regDate) {
			this.regDate = regDate;
		}
		public int getHit() {
			return hit;
		}
		public void setHit(int hit) {
			this.hit = hit;
		}
}
