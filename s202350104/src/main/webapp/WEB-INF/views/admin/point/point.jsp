<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/components/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>포인트관리</title>
</head>
<body>
	<!-- Top bar -->
	<%@ include file="/WEB-INF/components/TobBar.jsp" %>
	<h1>포인트관리</h1>
	<div class="border p-3 m-3">
				<button type="button" class="btn btn-outline-secondary" 
				onclick="location.href='writeFormPoint?Id=${point.id}'">등록</button>
								
				<table class="table table-striped table-sm">
					<thead>
						<tr>
							<th scope="col">포인트번호</th>
							<th scope="col">생성날짜</th>
							<th scope="col">포인트이름</th>
							<th scope="col">포인트내용</th>
							<th scope="col">포인트점수</th>
							<th scope="col">수정</th>
						</tr>
					</thead>
		<c:forEach var="point" items="${listPoint}">
		<tr>
		<td>${point.id }</td>
		<td>${point.create_at }</td>
		<td>${point.title }</td>
		<td>${point.content }</td>
		<td>${point.point }</td>
		<td><a href="/admin/point/updateFormPoint?id=${point.id}">수정</a></td>
		</tr>
		</c:forEach>
	</table>
	</div>

</body>
</html>