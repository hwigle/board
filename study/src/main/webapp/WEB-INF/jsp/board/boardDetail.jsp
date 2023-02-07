<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="${pageContext.request.contextPath}/js/jquery-3.6.3.min.js"></script>
</head>
<body>
<%@ include file="/fix/header.jsp" %>
<div>
<h1> 게시글 상세</h1>
<form name="frm" method="get">
<table border="2">
	<tr>
		<td>번호</td>
		<td>${detail.bno}</td>
	</tr>
	<tr>
		<th>작성자</th>
		<td>${detail.writer}</td>	
	</tr>
	<tr>
		<th>제목</th>
		<td >${detail.title} </td>
	</tr>
	<tr>
		<th>글내용</th>
		<td><textarea rows="5" cols="30" class="textarea" name="contents" id="contents" readonly="readonly"><c:out value="${detail.contents}"/></textarea></td>
	</tr>
	<tr>
		<th>작성일</th>
		<td>${detail.regDate}</td>
	</tr>
	<tr>
		<th>조회수</th>
		<td>${detail.hit}</td>
	</tr>
		<tr>
		<td>
		<input type="button" value="목록" onclick="location.href='boardList.do'">
		<c:if test="${loginUser.name == detail.writer }">
			<input type="button" value="수정" onclick="location.href='boardModify.do?bno=${detail.bno}'">
			<input type="button" id="delBtn" value="삭제">
		</c:if>
		</td>
	</tr>
</table>
</form>
</div>
</body>
<script type="text/javascript">

// 게시글 삭제
$(function(){
	$("#delBtn").click(function(){
		if(confirm("정말 삭제하시겠습니까?")){
			location.replace("delete.do?bno=${detail.bno}");
		}
	}) 
});   

</script>
</html>