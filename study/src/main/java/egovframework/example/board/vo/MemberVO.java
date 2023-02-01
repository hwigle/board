package egovframework.example.board.vo;

import java.sql.Date;

public class MemberVO {
	
	private String id;			// 아이디
	private String pw;			// 비밀번호
	private String name;		// 이름
	private String mail;		// 메일
	private String addr;		// 주소
	private Date regDate;		// 등록일
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getMail() {
		return mail;
	}
	public void setMail(String mail) {
		this.mail = mail;
	}
	public String getAddr() {
		return addr;
	}
	public void setAddr(String addr) {
		this.addr = addr;
	}
	public Date getRegDate() {
		return regDate;
	}
	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}
	
	
}
