<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/components/AdminHeader.jsp" %>  

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="container-fluid">
	<div class="row">
		<%@ include file="/WEB-INF/components/AdminSideBar.jsp" %>
		<main class="col-10 overflow-auto p-0">
			<!-- Section1: Title -->
			<div class="admin-header-container">
					<div class="container m-4">
						<i class="title-bi bi bi-chat-dots-fill"></i>
				<label class="admin-header-title ">신고리스트 </label>
					</div>
			</div>
		<!-- Section3: Table -->		
			<div class="container col-9 justify-content-center mt-10 my-2 border p-2">
				<div class="border p-3 m-3">
				<h3><i class="bi bi-clipboard2-minus"></i>신고 게시글</h3>
				<table class="table mb-3">
					<tr><th style="width: 120px;">게시글ID</th><td>${boardDetail.id}</td></tr>
					<tr><th style="width: 120px;">작성자ID</th><td>${boardDetail.user_id}</td></tr>
					<tr><th style="width: 120px;">제목</th><td>${boardDetail.title}</td></tr>
					<tr><th style="width: 120px;">내용</th><td>${boardDetail.content}</td></tr>
				</table>	
				</div>
			<div class="border p-3 m-3">
				<h4><i class="bi bi-exclamation-triangle-fill ml-10"></i>신고내역</h4>
				<table class="table text-center mb-3">
					<thead>
						<tr>
							<th scope="col">번호</th>
							<th scope="col">글내용</th>
							<th scope="col">작성ID</th>
							<th scope="col">작성자</th>
							<th scope="col">작성일</th>
							<th scope="col">상태</th>
							
						</tr>
					</thead>
					
					<tbody>
						<c:forEach var="report" items="${reportDetail}">
							<tr>
								<td>${report.rn}</td>
								<td>${report.content}</td>
								<td>${report.user_id}</td>
								<td>${report.name}</td>
								<td><fmt:formatDate value="${report.created_at}" type="date" pattern="YY/MM/dd"/></td>
								<td>
								<c:choose>
									<c:when test="${report.status == 1}">신고접수</c:when>
								</c:choose>
								</td>
							</tr>
							<tr>
						</c:forEach>
					</tbody>
				</table>
				<div class="form-row d-flex justify-content-center">
					<div class="col-6 mb-3 px-2">
						<button class="form-control btn btn-primary" onclick="location.href='reportBoardUpdate?id=${boardDetail.id}'">게시글삭제</button>
					</div>
					<div class="col-2 mb-3 px-2">	
						<button class="form-control btn btn-primary" onclick="location.href='reportUpdate?id=${boardDetail.id}'">신고글반려</button>
					</div>
					<div class="col-2 mb-3 px-2">	
						<button class="form-control btn btn-primary" onclick="location.href='report'">이전</button>
					</div>
				</div>
			</div>
			</div>			
		</main>
	</div>
	</div>