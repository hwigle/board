<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/css/member/join.css">
<script src="${pageContext.request.contextPath}/js/jquery-3.6.3.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
</head>

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
					<input class="id_input" type="text" id="id" name="id">
				</div>
				<span class="id_input_re_1">사용 가능한 아이디입니다.</span>
				<span class="id_input_re_2">아이디가 이미 존재합니다.</span>
			</div>
			<div class="pw_wrap">
				<div class="pw_name">비밀번호</div>
				<div class="pw_input_box" >
					<input class="pw_input" type="password" id="pw" name="pw">
				</div>
			</div>
			<div class="pwck_wrap">
				<div class="pwck_name">비밀번호 확인</div>
				<div class="pwck_input_box" >
					<input class="pwck_input" type="password" id="pwck" name="pwck">
				</div>
				<span class="pwck_input_re_1">비밀번호가 일치합니다.</span>
				<span class="pwck_input_re_2">비밀번호가 일치하지 않습니다.</span>
			</div>
			<div class="user_wrap">
				<div class="user_name">닉네임</div>
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
						<input class="address_input_1"  id="addr1" name="addr1" readonly="readonly">
					</div>
					<div class="address_button" onclick="daum_address();">
						<span>주소 찾기</span>
					</div>
					<div class="clearfix"></div>
				</div>
				<div class="address_input_2_wrap">
					<div class="address_input_2_box">
						<input class="address_input_2" id="addr2" name="addr2" readonly="readonly">
					</div>
				</div>
				<div class="address_input_3_wrap">
					<div class="address_input_3_box">
						<input class="address_input_3" id="addr3" name="addr3" readonly="readonly">
					</div>
				</div>
			</div>
			<div class="join_button_wrap">
				<button type="submit" class="joinBtn">가입하기</button>
				<button type="button" class="back" onclick="location='boardList.do'" >뒤로가기</button>
			</div>
		</div>
	</form>
</div>
</body>
<script>

	// 필수 체크
	$(".joinBtn").click(function() {
		if ($.trim($("#id").val()) == "") {
			alert("아이디를 입력해주세요.");
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
		if ($.trim($("#addr1").val()) == "") {
			alert("주소를 입력해주세요.");
			$("#addr1").focus();
			return false;
		}
		if($("#pw").val() != $("#pwck").val()){
			alert("비밀번호와 비밀번호 확인이 일치하지 않습니다.");
			$("#pwck").focus();
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
					$('.id_input_re_1').css("display", "inline-block");
					$('.id_input_re_2').css("display", "none");
				} else {
					$('.id_input_re_2').css("display", "inline-block");
					$('.id_input_re_1').css("display", "none");
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
	    }else{
	        $('.pwck_input_re_1').css('display','none');
	        $('.pwck_input_re_2').css('display','block');
	    }        
	    
	});   
	
	// 다음 주소 검색
	function daum_address(){
		new daum.Postcode({
	        oncomplete: function(data) {
	            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분입니다.
	        	// 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 주소변수 문자열과 참고항목 문자열 합치기
                    addr += extraAddr;
                
                } else {
                    addr += ' ';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                $(".address_input_1").val(data.zonecode);
	            $(".address_input_2").val(addr);
                // 상세주소 입력란 disabled 속성 변경 및 커서를 상세주소 필드로 이동한다.
	            $(".address_input_3").attr("readonly",false);
	            $(".address_input_3").focus();
            }
	    }).open();
	}
	
	
	
	
	
	
</script>
</html>