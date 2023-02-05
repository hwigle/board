<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="${pageContext.request.contextPath}/js/jquery-3.6.3.min.js"></script>
<title>Insert title here</title>
</head>
<style>
   form{
       text-align: center;
       margin:0 auto;
       margin-top:50px;
   }

   .border{
       margin:0 auto;
       width:400px;
       height:300px;
       border:1px solid #000;
       border-radius: 10%;
   }

   input{
       width:300px;
   }
   .login_warn{
    margin-bottom: 15px;
    text-align: center;
    color : red;
}
</style>
</head>
<body>
	<form id="loginForm" action="/login.do" method="post">
		<div class="border">
			<h1>로그인</h1>
			<input type="text" name="id" id="id" placeholder="아이디를 입력해주세요."><br>
			<input type="password" name="pw" id="pw" placeholder="비밀번호를 입력해주세요."><br><br>
			<c:if test="${rt == 0 }">
				<div class="login_warn">ID 또는 비밀번호를 잘못 입력하셨습니다.</div>
			</c:if>
			<input type="submit" class="loginBtn" value="로그인"> 
			<input type="button" value="홈으로" onclick="location='/boardList.do'">
		</div>
	</form>
</body>
<script>

</script>
</html>