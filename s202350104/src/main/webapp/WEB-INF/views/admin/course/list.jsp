<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/components/AdminHeader.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Course Content</title>
<link href="/css/adminTable.css" rel="stylesheet" type="text/css">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="/js/updateArea.js"></script>
<script type="text/javascript">
	document.addEventListener("DOMContentLoaded", function() {
		updateAreaOptions();
		$(".area-dropdown").change(function() {
			const selectedArea = $(this).val();
			if (selectedArea) {
				updateSigunguOptions(selectedArea);
			} else {
				$(".sigungu-dropdown").empty().append("<option value='0'>전체</option>");
			}
		});
	});
</script>
</head>
<body>
	<div class="container-fluid">
		<div class="row">
			<%@ include file="/WEB-INF/components/AdminSideBar.jsp" %>
			<main class="col-10 overflow-auto p-0">
				<!-- Section1: Title -->
				<div class="admin-header-container">
					<div class="container m-4">
						<i class="title-bi bi bi-image-fill "></i>
						<label  class="admin-header-title ">코스 정보 관리 </label>					
					</div>
				</div>
		
				<!-- Section2: Search Form -->		
				<div class="container col-9 justify-content-center my-5">
				    <form action="list1" method="get" class="container justify-content-center">
				    
				    <!-- 검색어 -->
			            <div class="col-12 my-4 d-flex align-items-center">
			                <label for="searchType" class="col-form-label col-2  mx-2">검색어</label>
			                <div class="col-3">
				                <select id="searchType" name="searchType" class="form-select">
				                    <option selected value="s_title">코스명</option>
				                    <option value="s_content">코스내용</option>
				                </select>
			                </div>
			                <div class="col-6 mx-2">
				                <input type="text" name="keyword" class="form-control" value="${keyword}"
				                placeholder="검색어를 입력하세요.">
			                </div>
			            </div>
			            
			            <div class="col-12 my-4 d-flex align-items-center">
					    	<label for="searchType" class="col-form-label col-2 mx-2">지역</label>
						        <div class="col-3 d-flex align-items-center">
									<select name="area" class="area-dropdown form-select"></select>
								</div>
								<div class="col-3 mx-2 d-flex align-items-center">
									<select name="sigungu" class="sigungu-dropdown form-select"></select><p>
								</div>
						</div>
						
						<div class="container col-10 d-flex justify-content-center">
								<button type="submit" class="btn btn-primary  col-2 mx-3">검색</button>
								<button type="reset"  class="btn btn-outline-secondary col-2 mx-3">초기화</button>
						</div>
					</form>
				</div>
				
				<!-- Section3: Table -->		
				<div class="container col-9 justify-content-center align-items-center mb-2 p-3 pt-0">
					<div class="container d-flex justify-content-end p-0">
						<button id="regist-btn" onclick="location.href='courseInsertForm'" type="button" class="btn btn-primary btn-sm mb-4">등록</button>
					</div>	
					<div class="container table-container p-4">
						<div class="table-responsive">
							<table id="userTable" class="table table-md text-center p-3">
								<thead>
									<tr>
										<th scope="col">코스ID</th>
										<th scope="col">코스이름</th>
										<th scope="col">총거리</th>
										<th scope="col">소요시간</th>
										<th scope="col">등록일</th>
										<th scope="col">지역</th>
										<th scope="col">관리</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="course" items="${courseList }">
										<tr>
											<td>${course.id }</td>
											<td>${course.course_title }</td>
											<td>${course.distance }</td>
											<td>${course.time }</td>
											<td><fmt:formatDate value="${course.created_at }" type="date" pattern="YY/MM/dd"/></td>
											<td>${course.area_content } ${course.sigungu_content }</td>
											<td><a href="courseUpdateForm?id=${course.course_id}" class="detail-link">관리</a></td>
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
							<c:choose>
								<c:when test="${path == 0}">
									<li class="page-item">
										<a href="list?currentPage=${page.startPage-page.pageBlock}" class="pageblock page-link">Prev</a>
									</li>
								</c:when>
								<c:when test="${path == 1}">
									<li class="page-item">
										<a href="list1?currentPage=${page.startPage-page.pageBlock}" class="pageblock page-link">Prev</a>
									</li>
								</c:when>
							</c:choose>
							
						</c:if>
						<c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
							<c:choose>
								<c:when test="${path == 0}">
									<li class="page-item">
										<a href="list?currentPage=${i}" class="pageblock page-link ${page.currentPage == i ? 'active':'' }">${i}</a>
									</li>
								</c:when>
								<c:when test="${path == 1}">
									<li class="page-item">
										<a href="list1?currentPage=${i}&keyword=${keyword}&area=${area}&sigungu=${sigungu}" class="pageblock page-link ${page.currentPage == i ? 'active':'' }">${i}</a>
									</li>
								</c:when>
							</c:choose>
							
						</c:forEach>
						<c:if test="${page.endPage < page.totalPage}">
							<c:choose>
								<c:when test="${path == 0}">
									<li class="page-item">
										<a href="list?currentPage=${page.startPage+page.pageBlock}" class="pageblock page-link">Next</a>
									</li>
								</c:when>
								<c:when test="${path == 1}">
									<li class="page-item">
										<a href="list1?currentPage=${page.startPage+page.pageBlock}" class="pageblock page-link">Next</a>
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