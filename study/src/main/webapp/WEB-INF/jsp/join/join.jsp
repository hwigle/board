<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="../js/jquery-3.6.3.min.js"></script>
</head>
<style>
/* 중복아이디 존재하지 않는경우 */
	.id_ok{
		color : green;
		display : none;
	}
	/* 중복아이디 존재하는 경우 */
	.id_no{
		color : red;
		display : none;
	}
	
/* 비밀번호 확인 일치 유효성검사 */
.pwck_input_re_1{
        color : green;
        display : none;    
}
.pwck_input_re_2{
        color : red;
        display : none;    
}    
</style>
<body>
<div class="wrapper">
	<form id="join_frm" action="/join.do" method="post">
	<div class="wrap">
			<div class="subjecet">
				<span>회원가입</span>
			</div>
			<div class="id_wrap">
				<div class="id_name">아이디</div>
				<div class="id_input_box">
					<input class="id_input" id="id" name="id"> 
				</div>
				<span class="id_ok">사용 가능한 아이디입니다.</span>
				<span class="id_no">아이디가 이미 존재합니다.</span>
			</div>
			<div class="pw_wrap">
				<div class="pw_name">비밀번호</div>
				<div class="pw_input_box" >
					<input class="pw_input" id="pw" name="pw">
				</div>
				<span class="final_pw_ck">비밀번호를 입력해주세요.</span>
			</div>
			<div class="pwck_wrap">
				<div class="pwck_name">비밀번호 확인</div>
				<div class="pwck_input_box" >
					<input class="pwck_input" id="pwck" name="pwck">
				</div>
				<span class="final_pwck_ck">비밀번호 확인을 입력해주세요.</span>
				<span class="pwck_input_re_1">비밀번호가 일치합니다.</span>
				<span class="pwck_input_re_2">비밀번호가 일치하지 않습니다.</span>
			</div>
			<div class="user_wrap">
				<div class="user_name">이름</div>
				<div class="user_input_box">
					<input class="user_input" id="name" name="name">
				</div>
			</div>
			<div class="mail_wrap">
				<div class="mail_name">이메일</div> 
				<div class="mail_input_box">
					<input class="mail_input" id="mail" name="mail">
				</div>
				<div class="mail_check_wrap">
					<div class="mail_check_input_box">
						<input class="mail_check_input">
					</div>
					<div class="mail_check_button">
						<span>인증번호 전송</span>
					</div>
					<div class="clearfix"></div>
				</div>
			</div>
			<div class="address_wrap">
				<div class="address_name">주소</div>
				<div class="address_input_1_wrap">
					<div class="address_input_1_box">
						<input class="address_input_1"  id="addr" name="addr">
					</div>
					<div class="address_button">
						<span>주소 찾기</span>
					</div>
					<div class="clearfix"></div>
				</div>
			</div>
			<div class="join_button_wrap">
				<button type="submit" class="joinBtn">가입하기</button>
				<button type="button" onclick="location='boardList.do'" >뒤로가기</button>
			</div>
		</div>
	</form>
</div>
</body>
<script>

	// 필수 체크
	$(".joinBtn").click(function() {
	
		if ($.trim($("#id").val()) == "") {
			alert("이름을 입력해주세요.");
			$("#id").focus();
			return false;
		}
		if ($.trim($("#pw").val()) == "") {
			alert("비밀번호를 입력해주세요.");
			$("#pw").focus();
			return false;
		}
		if ($.trim($(".pwck_input").val()) == "") {
			alert("비밀번호 확인을 입력해주세요.");
			$("#pwck").focus();
			return false;
		}
		if ($.trim($("#name").val()) == "") {
			alert("이름을 입력해주세요.");
			$("#name").focus();
			return false;
		}
		if ($.trim($("#mail").val()) == "") {
			alert("메일을 입력해주세요.");
			$("#mail").focus();
			return false;
		}
		if ($.trim($("#addr").val()) == "") {
			alert("주소를 입력해주세요.");
			$("#addr").focus();
			return false;
		}
		alert("가입완료");
	})

	// 아이디 중복검사
	$('.id_input').on("propertychange change keyup paste input", function() { // input 변화 감지

		var id = $('.id_input').val(); // .id_input에 입력되는 값
		var data = {
			id : id
		} // '컨트롤에 넘길 데이터 이름' : '데이터(.id_input에 입력되는 값)'

		$.ajax({
			type : "post",
			url : "/idChk.do",
			data : data,
			success : function(rt) {
				if (rt != '2') {
					$('.id_ok').css("display", "inline-block");
					$('.id_no').css("display", "none");
				} else {
					$('.id_no').css("display", "inline-block");
					$('.id_ok').css("display", "none");
				}
			}
		});
	})
	
	// 비밀번호 유효성 검사
	$('.pwck_input').on("propertychange change keyup paste input", function(){
	 
	    var pw = $('.pw_input').val();
	    var pwck = $('.pwck_input').val();
	    $('.final_pw_ck').css('display', 'none');
	    $('.final_pwck_ck').css('display', 'none');
	 
	    if(pw == pwck){
	        $('.pwck_input_re_1').css('display','block');
	        $('.pwck_input_re_2').css('display','none');
	        pwckcorCheck = true;
	    }else{
	        $('.pwck_input_re_1').css('display','none');
	        $('.pwck_input_re_2').css('display','block');
	        pwckcorCheck = false;
	    }        
	    
	});   
</script>
</html>