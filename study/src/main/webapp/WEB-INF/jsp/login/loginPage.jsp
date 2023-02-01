<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<style>
   form{
       text-align: center;
       margin:0 auto;
   }

   .border{
       margin:0 auto;
       width:400px;
       height:500px;
       border:1px solid #000;
       border-radius: 10%;
   }

   img{
       margin-top:20px;
       margin-bottom:80px;
   }

   input{
       width:300px;
   }
	</style>
	</head>
	<body>
    	<form action ="/Login" method="post">
        	<div class="border">
            	<h1>로그인</h1>
            	<img src ="/images/profle.jpg"><br>
            	
                <input type="text"  name="id" id="id" placeholder="아이디를 입력해주세요."><br>
            	<input type="password" name="password" id="password" placeholder="비밀번호를 입력해주세요."><br><br>
            	<input type="submit" value="로그인">

        	</div> 
    	</form>
	</body>
</html>