<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<% pageContext.setAttribute("replaceChar", "\n"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="${pageContext.request.contextPath}/js/jquery-3.6.3.min.js"></script>
</head>
<script type="text/javascript">
	
	function fn_modify() {
 	
		var data = {
				bno:$('#bno').val(),
				title:$("#title").val(),
				writer:$("#writer").val(),
				contents:$("#contents").val()
		}
		
		$.ajax({  
			/* 전송 전 세팅 */
			type:"POST",
			data:JSON.stringify(data),
			url:"modify.do",
			dataType:"json",    
			contentType: "application/json; charset=UTF-8",
			/* 전송 후 세팅  */
			success: function(rt) {  
				if(rt == "1") {
					alert("수정 완료");
					location="boardList.do";
				} else if(rt == "2") {
					alert("SQL 에러");
				} else {
					alert("에러!");
				}
			},
			error: function() {  // 장애발생
				alert("오류발생");
			}
		});
	}
</script>
<body>
<%@ include file="/fix/header.jsp" %>
<div>
<h1>글수정</h1>

		<input type="hidden" id="bno" name="bno" value="${detail.bno}">
		<table>
			<tr>
				<th width="20%"><label for="title">글제목</label></th>
				<td width="80%"><input type="text" id="title" name="title" value="${detail.title}"></td>
			</tr>
			<tr>
				<th><label for="name">작성자</label></th>
				<td><input type="text" id="writer" name="writer" value="${detail.writer}"></td>
			</tr>
			<tr>
				<th><label for="content">글내용</label></th>
				<td><textarea rows="5" cols="30" class="textarea" id="contents" name="contents">${detail.contents}</textarea></td>
			</tr>
			<tr>
				<th colspan="2">
					<button type="button" onclick="fn_modify();return false;">수정</button>
					<button type="button" onclick="location='boardDetail.do?bno=${detail.bno}'">취소</button>
				</th>
			</tr>
		</table>
		</div>
</body>
</html>