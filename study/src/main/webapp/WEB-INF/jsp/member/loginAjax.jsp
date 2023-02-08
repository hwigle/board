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
   div{
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
	<div class="border">
			<h1>로그인</h1>
			<input type="text" name="id" id="id" placeholder="아이디를 입력해주세요."><br>
			<input type="password" name="pw" id="pw" placeholder="비밀번호를 입력해주세요."><br><br>
			
			<input type="button" onclick="loginBtn(); return false;" class="loginBtn" value="로그인"> 
			<input type="button" value="홈으로" onclick="location='/boardList.do'">
		</div>
</body>
<script>
function loginBtn() {
	
	var data = {
			id:$("#id").val(),
			pw:$("#pw").val(),
	}
	$.ajax({
		type:"post",
		url:"/loginA.do",
		data:JSON.stringify(data), // data 객체를 JSON 문자열로 변환
		dataType:"json",
		contentType:"application/json;",
		success:function(rt){
			if(rt =="1"){
				alert("로그인 성공");
				location="boardList.do";
			} else {
				alert("로그인 실패")
			}
		},
		error : function() { // 시스템적으로 장애 발생
			alert("오류발생");
		}
	})
	
}
</script>
</html>