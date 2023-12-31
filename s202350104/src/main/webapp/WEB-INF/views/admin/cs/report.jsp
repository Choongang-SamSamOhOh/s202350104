<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/components/AdminHeader.jsp" %>  

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="/css/adminTable.css" rel="stylesheet" type="text/css">
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
			<div class="container col-9 justify-content-center align-items-center mb-2 p-3 pt-3">
				<div class="container table-container p-4">
				<h3><i class="bi bi-clipboard2-minus"></i>총 신고게시글 :${totalReport}&nbsp;&nbsp;
					<i class="bi bi-exclamation-triangle-fill ml-10"></i>총 신고건수:${totalReportCount}</h3>
					<div class="table-responsive">
					<table id="userTable" class="table table-md text-center p-3">
					<thead>
						<tr>
							<th scope="col">게시판ID</th>
							<th scope="col">글제목</th>
							<th scope="col">작성자</th>
							<th scope="col">신고횟수</th>
							<th scope="col">관리</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="report" items="${listReport}">
							<tr>
								<td>${report.board_id}</td>
								<td>
								<c:if test="${report.small_code eq 3}">
									<c:choose>
										<c:when test="${report.comment_indent eq 0 }">
											[자유게시판] ${report.title}
										</c:when>
										<c:otherwise>
											[자유게시판] 리뷰글입니다 
										</c:otherwise>
									</c:choose>	
								</c:if>
								<c:if test="${report.small_code eq 4}">
									<c:choose>
										<c:when test="${report.comment_indent eq 0 }">
											[포토게시판] ${report.title}
										</c:when>
										<c:otherwise>
											[포토게시판] 리뷰글입니다 
										</c:otherwise>
									</c:choose>	
								</c:if>
								<c:if test="${report.small_code eq 5}">
									<c:choose>
										<c:when test="${report.comment_indent eq 0 }">
											[이벤트게시판] ${report.title}
										</c:when>
										<c:otherwise>
											[이벤트게시판] 댓글입니다 
										</c:otherwise>
									</c:choose>	
								</c:if>
								<c:if test="${report.small_code eq 6}">
									<c:choose>
										<c:when test="${report.comment_indent eq 0 }">
											[컨텐츠 게시글] 리뷰글입니다
										</c:when>
										<c:otherwise>
											[컨텐츠 게시글 리뷰] 댓글입니다 
										</c:otherwise>
									</c:choose>	
								</c:if>
								</td>
								<td>${report.name}</td>
								<td>${report.count}</td>
								<td><button class="btn btn-primary" onclick="location.href='reportDetail?boardId=${report.board_id}'">관리</button></td>
							</tr>
						</c:forEach>
					</tbody>
					</table>
				</div>
				</div>
			</div>
				<nav aria-label="Page navigation example ">
					<ul class="pagination">
						<c:if test="${page.startPage > page.pageBlock}">
							<li class="page-item">
								<a href="report?currentPage=${page.startPage-page.pageBlock}" class="pageblock page-link">[이전]</a>
							</li>
						</c:if>
						<c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
							<li class="page-item">	
								<a href="report?currentPage=${i}" class="pageblock page-link ${page.currentPage == i ? "active":"" }">${i}</a>
							</li>
						</c:forEach>
						<c:if test="${page.endPage < page.totalPage}">
							<li class="page-item">
								<a href="report?currentPage=${page.startPage+page.pageBlock}" class="pageblock page-link">[다음]</a>
							</li>
						</c:if>
					</ul>
				</nav>	
		</main>
	</div>
	</div>
</body>
</html>