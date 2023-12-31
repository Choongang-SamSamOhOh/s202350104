<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/components/AdminHeader.jsp"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<%@ include file="/WEB-INF/components/AdminUpdateAreas.jsp"%>
	<script>
    function confirmDelete(userId, contentId) {
        var result = confirm('정말로 삭제하시겠습니까?');
        if (result) {
            // 확인을 누르면 삭제 동작 수행
            location.href = 'favoriteDelete?user_id=' + userId + '&content_id=' + contentId;
        }
    }
	</script>
<link href="/css/adminTable.css" rel="stylesheet" type="text/css">
</head>
<body>
	<div class="container-fluid">
		<div class="row">
			<%@ include file="/WEB-INF/components/AdminSideBar.jsp"%>
			<main class="col-10 overflow-auto p-0">
				<!-- Section1: Title -->
				<div class="admin-header-container">
					<div class="container m-4">
						<i class="title-bi bi bi-people-fill "></i>
					<label  class="admin-header-title ">찜 목록 리스트</label>
					</div>
				</div>
				
				<!-- Section2: Search Form -->
				<div class="container col-9 justify-content-center my-5">
					<form action="favoriteSearch" method="GET" class="container justify-content-center">	
						<div class="col-12 my-4 d-flex align-items-center">
							<label for="searchType" class="form-label col-2  mx-2">검색어</label>
							<div class="col-4">
								<select name="search" class="form-select">
									<option value="s_id">ID조회</option>
									<option value="s_name">이름조회</option>
								</select> 
							</div>	
							<div class="col-5 mx-2 d-flex justify-content-center">	
								<input type="text" name="keyword" class="form-control" placeholder="keyword를 입력하세요">
								<button type="submit" class="btn btn-primary  col-2 mx-3">검색</button>
							</div>
						</div>
						<input type="hidden" name="currentPage" value="${page.currentPage}">	
					</form>
				</div>
									
				<!-- Section3: Table -->
				<div class="container col-9 justify-content-center align-items-center mb-2 p-3 pt-0">
				<div class="container table-container p-4 align-items-center">
				<div class="table-responsive">
					<table id="userTable" class="container">
						<thead>
							<tr class="text-center">
								<th scope="col">순번</th>
								<th scope="col">회원ID</th>
								<th scope="col">이름</th>
								<th scope="col">컨텐츠이름</th>
								<th scope="col">찜한 날짜</th>
								<th scope="col">삭제</th>
							</tr>
						</thead>
						<tbody>
							<c:set var="num" value="${page.start}"/>
							<c:forEach var="favorite" items="${listFavorite}">
								<tr>
									<td>${num}</td>
									<td>${favorite.user_id}</td>
									<td>${favorite.name}</td>
									<td>${favorite.title}</td>
									<td><fmt:formatDate value="${favorite.create_at}" type="date" pattern="YY/MM/dd"/></td>
									<td><input class="btn btn-outline-secondary" type="button" value="삭제" onclick="confirmDelete(${favorite.user_id}, ${favorite.content_id})"></td>
								</tr>
							<c:set var="num" value="${num + 1}"/>	
							</c:forEach>
						</tbody>
					</table>
				</div>
				</div>
				</div>
				
				<nav aria-label="Page navigation example ">
				<ul class="pagination">
					<c:if test="${page.startPage > page.pageBlock}">
    					<c:choose>
    						<c:when test="${path==0}">
		    					<li class="page-item">
		        					<a href="favoriteList?currentPage=${page.startPage-page.pageBlock}" class="pageblock page-link">Prev</a>
		    					</li>
		    				</c:when>
		    				<c:when test="${path==1}">
		    					<li class="page-item">
		        					<a href="favoriteSearch?search=${search}&keyword=${keyword}&currentPage=${page.startPage-page.pageBlock}" class="pageblock page-link">Prev</a>
		    					</li>
		    				</c:when>	
    					</c:choose>
    				</c:if>
					<c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
    					<c:choose>
    						<c:when test="${path==0}">
		    					<li class="page-item">
		        					<a href="favoriteList?currentPage=${i}" class="pageblock page-link ${page.currentPage == i ? 'active':'' }">${i}</a>
		    					</li>
							</c:when>
							<c:when test="${path==1}">
		    					<li class="page-item">
		        					<a href="favoriteSearch?search=${search}&keyword=${keyword}&currentPage=${i}" class="pageblock page-link ${page.currentPage == i ? 'active':'' }">${i}</a>
		    					</li>
							</c:when>
						</c:choose>			    			
					</c:forEach>
					<c:if test="${page.endPage < page.totalPage}">
    					<c:choose>
    						<c:when test="${path==0}">
				    			<li class="page-item">
		        					<a href="favoriteList?currentPage=${page.startPage+page.pageBlock}" class="pageblock page-link">Next</a>
		    					</li>
							</c:when>
							<c:when test="${path==1}">
				    			<li class="page-item">
		        					<a href="favoriteSearch?search=${search}&keyword=${keyword}&currentPage=${page.startPage+page.pageBlock}" class="pageblock page-link">Next</a>
		    					</li>
							</c:when>
						</c:choose>	
					</c:if>
				</ul>
			</nav>
			</main>
		</div>
	</div>
</body>
</html>