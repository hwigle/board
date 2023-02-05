<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="${pageContext.request.contextPath}/js/jquery-3.6.3.min.js"></script>
</head>
<style>
.pageInfo {
	list-style: none;
	display: inline-block;
}

.pageInfo li {
	float: left;
	padding: 7px;
	font-weight: 500;
}

a:link {
	color: black;
	text-decoration: none;
}

a:visited {
	color: black;
	text-decoration: none;
}

a:hover {
	color: black;
	text-decoration: underline;
}

.active {
	background-color: #cdd5ec;
}

</style>
<body>
<%@ include file="/fix/header.jsp" %>
<div>
	<h1>게시글 목록</h1>
	<!-- <button style="margin: 0 0 10px 277px;"type="button" onclick="location='join.do'">가입하기</button> -->
	<table border="1px">
		<tr>
			<th>글번호</th>
			<th>글제목</th>
			<th>작성자</th>
			<th>작성일</th>
			<th>조회수</th>
		</tr>
		<c:forEach var="list" items="${list}" varStatus="status">
			<tr>
				<td>${list.bno}</td>
				<td><a href="boardDetail.do?bno=${list.bno}">${list.title}</a></td>
				<td>${list.writer}</td>
				<td>${list.regDate}</td>
				<td>${list.hit}</td>
			</tr>
		</c:forEach>
	</table>
	<button style="margin:10px 291px;" type="button" onclick="location='boardWrite.do'">글쓰기</button>
	
	<!-- 페이징[S] -->
	<div class="pageInfo_wrap">
		<div class="pageInfo_area">
			<ul id="pageInfo" class="pageInfo">

				<!-- 이전페이지 버튼 -->
				<c:if test="${pageMaker.prev}">
					<li class="pageInfo_btn previous"><a href="${pageMaker.startPage-1}">이전</a></li>
				</c:if>

				<!-- 각 번호 페이지 버튼 -->
				<c:forEach var="num" begin="${pageMaker.startPage}"
					end="${pageMaker.endPage}">
					<li class="pageInfo_btn ${pageMaker.cri.pageNum == num ? "active":"" }"><a href="${num}">${num}</a></li>
				</c:forEach>

				<!-- 다음페이지 버튼 -->
				<c:if test="${pageMaker.next}">
					<li class="pageInfo_btn next"><a href="${pageMaker.endPage + 1 }">다음</a></li>
				</c:if>
			</ul>
		</div>
	</div>
</div>
	<!-- 페이징[E] -->
	
	<form id="moveForm" method="get">
		<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
		<input type="hidden" name="amount" value="${pageMaker.cri.amount}">
	</form>
</body>
<script type="text/javascript">
	
	let moveForm = $("#moveForm");	
	
	// 페이지 이동
	$(".pageInfo a").on("click", function(e) {
		e.preventDefault();
		moveForm.find("input[name='pageNum']").val($(this).attr("href"));
		moveForm.attr("action", "/boardList.do");
		moveForm.submit();
	});
</script>
</html>