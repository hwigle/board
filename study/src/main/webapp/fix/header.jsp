<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="${pageContext.request.contextPath}/js/jquery-3.6.3.min.js"></script>
<title>Insert title here</title>
<style>
@charset "UTF-8";
*{
	margin: 0;
	padding:0;
}
/* 화면 전체 렙 */
.wrapper{
	width: 1000px;
}

/* 홈페이지 기능 네비 */ 
.top_gnb_area{
	width: 100%;
    height: 50px;
    background-color: #a2a2ea;
}
/* 로고, 검색, 로그인 */
.top_area{
	width: 100%;
    height: 150px;
    margin-left:30px;
    /* background-color: #f7f0b9; */
}
/* 로고 영역 */
.logo_area{
	width: 25%;
	height: 100%;
	background-color: red;
	float:left;
}

/* 로그인 버튼 영역 */
.login_area{
	width: 25%;
	height: 100%;
	display: inline-block;	
	text-align: center;		
}
.login_button{
	height: 50%;
    background-color: #D4DFE6;
    margin-top: 30px;
    line-height: 77px;
    font-size: 40px;
    font-weight: 900;
    border-radius: 10px;
    cursor: pointer;	
}
.login_area>span{
	margin-top: 10px;
    font-weight: 900;
    display: inline-block;
}
.logout_button{
	height: 50%;
    background-color: #D4DFE6;
    margin-top: 30px;
    line-height: 77px;
    font-size: 40px;
    font-weight: 900;
    border-radius: 10px;
    cursor: pointer;	
}
.logout_button{
	height : 50%;
	background-color: #D4DFE6;
	margin-top:30px;
}


/* 제품 목록 네비 */
.navi_bar_area{
	width: 100%;
    height: 70px;
    background-color: #7696fd;
}

/* 홈페이지 메인 제품 목록  */
.content_area{
	width: 100%;
    background-color: #97ef97;
    height: 1000px;
}

/* float 속성 해제 */
.clearfix{
	clear: both;
}
</style>
</head>
<body>
<div class="wrapper">
	<div class="wrap">
	<h1><a href="main.do">Wini</a></h1>
		<div class="top_area">
				<div class="login_area">
					<c:if test="${loginUser == null }">
						<div class="login_button"><a href="/loginPage.do">로그인</a></div>
						<span><a href="/join.do">회원가입</a></span>
					</c:if>
					<c:if test="${loginUser != null }">
						<span>${loginUser.name }님 환영합니다.</span><br>
						<div class="logout_button">
							<a id="logoutBtn">로그아웃</a>
						</div>
					</c:if>
				</div>
				<div class="clearfix"></div>			
		</div>
		<!-- <div class="navi_bar_area">
			<h1>navi area</h1>
		</div> -->
	</div>
</div>
</body>
<script>
$("#logoutBtn").click(function(){
	$.ajax({
		type:"post",
		url:"logout.do",
		success:function(data){
			console.log(data);
			document.location.reload();
		}
	})	
})
</script>
</html>