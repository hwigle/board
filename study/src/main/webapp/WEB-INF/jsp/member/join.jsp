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
					<input class="id_input" type="text" id="id" name="id" maxlength="16" placeholder="영문자로 시작하는 영문자 또는 숫자(16자 이내)">
				</div>
				<span class="id_input_re_1">사용 가능한 아이디입니다.</span>
				<span class="id_input_re_2">아이디가 이미 존재합니다.</span>
			</div>
			<div class="pw_wrap">
				<div class="pw_name">비밀번호</div>
				<div class="pw_input_box" >
					<input class="pw_input" type="password" id="pw" name="pw" maxlength="25">
				</div>
			</div>
			<div class="pwck_wrap">
				<div class="pwck_name">비밀번호 확인</div>
				<div class="pwck_input_box" >
					<input class="pwck_input" type="password" id="pwck" name="pwck" maxlength="25">
				</div>
				<span class="pwck_input_re_1">비밀번호가 일치합니다.</span>
				<span class="pwck_input_re_2">비밀번호가 일치하지 않습니다.</span>
			</div>
			<div class="user_wrap">
				<div class="user_name">닉네임</div>
				<div class="user_input_box">
					<input class="user_input" id="name" name="name" maxlength="10" placeholder="10글자 이내">
				</div>
			</div>
			<div class="mail_wrap">
				<div class="mail_name">메일</div> 
				<div class="mail_input_box">
					<input class="mail_input" id="mail" name="mail" maxlength="50" placeholder="ex) abc@gmail.com">
				</div>
				<sapn class="mail_input_box_warn"></sapn>
				<div class="mail_check_wrap">
					<div class="mail_check_input_box" id="mail_check_input_box_false">
						<input class="mail_check_input" disabled="disabled">
					</div>
					<div class="mail_check_button">
						<span>인증번호 전송</span>
					</div>
					<div class="clearfix"></div>
					<span id="mail_check_input_box_warn"></span>
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
						<input class="address_input_3" id="addr3" name="addr3" readonly="readonly" maxlength="50">
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

	var code = "";     //메일전송 인증번호 저장위한 코드

	// 필수 체크
	$(".joinBtn").click(function() {
		if ($.trim($("#id").val()) == "") {
			alert("아이디를 입력해주세요.");
			$("#id").focus();
			return false;
		}
		if(!idCheck(id)) {
			alert("아이디 형식을 확인해주세요.");
			$(id).focus();
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
		if ($.trim($("#addr3").val()) == "") {
			alert("상세 주소를 입력해주세요.");
			$("#addr3").focus();
			return false;
		}
		if($("#pw").val() != $("#pwck").val()){
			alert("비밀번호와 비밀번호 확인이 일치하지 않습니다.");
			$("#pwck").focus();
			return false;
		}
		if($(".mail_check_input").val() =="") {
			alert("인증번호를 입력해주세요.");
			$(".mail_check_input").focus();
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
		if (id) {

		}

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

	function idCheck(id) {
		var regExp = /^[a-z]+[a-z0-9]{5,19}$/g;

		return regExp.test(id);
	}

	// 비밀번호 유효성 검사
	$('.pwck_input').on("propertychange change keyup paste input", function() {

		var pw = $('.pw_input').val();
		var pwck = $('.pwck_input').val();
		$('.final_pw_ck').css('display', 'none');
		$('.final_pwck_ck').css('display', 'none');

		if (pw == pwck) {
			$('.pwck_input_re_1').css('display', 'block');
			$('.pwck_input_re_2').css('display', 'none');
		} else {
			$('.pwck_input_re_1').css('display', 'none');
			$('.pwck_input_re_2').css('display', 'block');
		}

	});

	// 메일 인증번호 전송
	$(".mail_check_button").click(function() {

		var mail = $(".mail_input").val(); // 입력한 메일
		var checkBox = $(".mail_check_input"); // 인증번호 입력란
		var boxWrap = $(".mail_check_input_box"); // 인증번호 입력란 박스

		if ($.trim(mail) == "") {
			alert("메일을 입력해주세요.")
			$(mail).focus();
			return false;
		} else if (mail) {
			if (!mailFormCheck(mail)) {
				alert("이메일 형식을 확인해주세요.");
				$(mail).focus();
				return false;
			} else
				$.ajax({
					type : "GET",
					url : "mailCheck.do?mail=" + mail,
					success : function(data) {
						checkBox.attr("disabled", false);
						boxWrap.attr("id", "mail_check_input_box_true");
						code = data;
						alert("인증번호가 입력한 메일로 전송되었습니다.");
					}
				});
		}
	});

	// 메일 인증번호 비교
	$(".mail_check_input").blur(function() {

		var inputCode = $(".mail_check_input").val(); // 입력코드    
		var checkResult = $("#mail_check_input_box_warn"); // 비교 결과 

		if (inputCode == code) { // 일치할 경우
			checkResult.html("인증번호가 일치합니다.");
			checkResult.attr("class", "correct");
		} else { // 일치하지 않을 경우
			checkResult.html("인증번호를 다시 확인해주세요.");
			checkResult.attr("class", "incorrect");
		}

	});

	// 메일 형식 유효성 검사
	function mailFormCheck(mail) {

		var form = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i;
		return form.test(mail);
	}

	// 다음 주소 검색(사용자가 선택한 값)
	/*  1. 외부 스크립트 파일 연결 코드 추가
		2. 주소 검색 기능 메서드 메서드 추가
		3. 다음 주소 팝업창 코드 추가
		4. [주소찾기]버튼과 메서드 연결 
		5. 주소 입력 예제 코드 추가
		6. 주소 필드, 참고 항목 필드 합치기(참고항목 필드 따로 없음)
		7. 우편번호와 주소 정보를 해당 필드에 넣어주는 코드 수정 */
	function daum_address() {
		new daum.Postcode({
			oncomplete : function(data) {
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
				if (data.userSelectedType === 'R') {
					// 법정동명이 있을 경우 추가한다. (법정리는 제외)
					// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
					if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
						extraAddr += data.bname;
					}
					// 건물명이 있고, 공동주택일 경우 추가한다.
					if (data.buildingName !== '' && data.apartment === 'Y') {
						extraAddr += (extraAddr !== '' ? ', '
								+ data.buildingName : data.buildingName);
					}
					// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
					if (extraAddr !== '') {
						extraAddr = ' (' + extraAddr + ')';
					}
					// 주소변수 문자열과 참고항목 문자열 합치기
					addr += extraAddr;
				// 기존 추가 항목 필드에 아무것도 입력되지 않게 하기 위한 코드
				} else {
					addr += ' ';
				}

				// 우편번호와 주소 정보를 해당 필드에 넣는다.
				$(".address_input_1").val(data.zonecode);
				$(".address_input_2").val(addr);
				// 상세주소 입력란 disabled 속성 변경 및 커서를 상세주소 필드로 이동한다.
				$(".address_input_3").attr("readonly", false);
				$(".address_input_3").focus();
			}
		}).open();
	}
</script>
</html>