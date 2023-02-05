<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="${pageContext.request.contextPath}/js/jquery-3.6.3.min.js"></script>
</head>
<script type="text/javascript">

	function fn_insert() {
		
		if($.trim($("#title").val()) == "") {
			alert("제목을 입력해주세요.");
			// document.frm.title.focus();
			$("#title").focus();
			return false;
		}
		if($.trim($("#writer").val()) == "") {
			alert("작성자를 입력해주세요.");
			$("#writer").focus();
			return false;
		}
		if($.trim($("#contents").val()) == "") {
			alert("내용을 입력해주세요.");
			$("#contents").focus();
			return false;
		}

		var formData = $("#frm").serialize();
		
		var data = {
				title:$("#title").val(),
				writer:$("#writer").val(),
				contents:$("#contents").val()
		}
		
		$.ajax({
			type : "post",
			url : "insert.do",
			data : JSON.stringify(data),
			dataType : "json", // 리턴 타입,
			contentType: "application/json; charset=UTF-8",
			success : function(rt) { // controller -> "1"(리턴값)
				if(rt == "1"){
					alert("작성완료");
					location="boardList.do";
				} else if(rt == "2"){
					alert("SQL 에러");
				} else {
					alert("에러!!");
				}
			},
			error : function() { // 시스템적으로 장애 발생
				alert("오류발생");
			}
		});
	}
</script>
<body>
<%@ include file="/fix/header.jsp" %>
<div>
<h1>글쓰기</h1>
		<table>
			<tr>
				<th width="20%"><label for="title">글제목</label></th>
				<td width="80%"><input class="input1" type="text" name="title"	id="title"></td>
			</tr>
			<tr>
				<th><label for="name">작성자</label></th>
				<td><input type="text" name="writer" id="writer"></td>
			</tr>
			<tr>
				<th><label for="content">글내용</label></th>
				<td><textarea rows="5" cols="30" class="textarea" name="contents" id="contents"></textarea></td>
			</tr>
			<tr>
				<th colspan="2">
					<button type="button" onclick="fn_insert(); return false;">등록</button>
					<button type="button" onclick="location='boardList.do'">취소</button>
				</th>
			</tr>
		</table>
		</div>
</body>
</html>