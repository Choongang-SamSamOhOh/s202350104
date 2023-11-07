<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/WEB-INF/components/AdminHeader.jsp" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Restaurant content</title>
		<%@ include file="/WEB-INF/components/AdminUpdateAreas.jsp"%>
	</head>
	<body>
		<div class="container-fluid">
			<div class="row">
				<%@ include file="/WEB-INF/components/AdminSideBar.jsp"%>
				<main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
					<!-- Section1: Title -->
					<div
						class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
						<h1 class="border">일반 회원 리스트</h1>
					</div>
	
					<!-- Section2: Search Form -->
					<div class="border p-3 m-3">
						<form action="restaurantSearch">
							<h1 class="border">검색폼</h1>
							<select name="area" id="area">
								<option value="">전체</option>
							</select> <select name="sigungu" id="sigungu">
								<option value="">---</option>
							</select>
							<button type="submit" class="btn btn-outline-secondary">검색</button>
							<button type="button" class="btn btn-outline-secondary">초기화</button>
						</form>
					</div>

				
				<!-- Section3: Table -->		
				<div class="border p-3 m-3">
					<button type="button" class="btn btn-outline-secondary ">등록</button>
					<table class="table table-striped table-sm">
						<thead>
							<tr>
								<th scope="col">순번</th>
								<th scope="col">지역</th>
								<th scope="col">음식점명</th>
								<th scope="col">메뉴</th>
								<th scope="col">신청일</th>
								<th scope="col">승인여부</th>
								<th scope="col">수정</th>
								<th scope="col">삭제</th>
							</tr>
						</thead>
						<tbody>
							<c:set var="num" value="${page.start}"/>
							<c:forEach var="restaurant" items="${listRestaurant}">
								<tr>
									<td>${num}</td>
									<td>${restaurant.area_content} ${restaurant.sigungu_content}</td>
									<td>${restaurant.title}</td>
						 			<td>${restaurant.menu}</td>
						 			<td><fmt:formatDate value="${restaurant.created_at}" type="date" pattern="YY/MM/dd"/></td>
						 			<td>
						 				<c:if test="${restaurant.status == 0 }">승인대기</c:if>
										<c:if test="${restaurant.status == 1 }">승인완료</c:if>
									</td>
									<td><input type="button" value="수정"></td>
									<td><input type="button" value="삭제"></td>					
								 </tr>
								 <c:set var="num" value="${num + 1}"/>
							</c:forEach>
						</tbody>
					</table>
				</div>		
			</main>
		</div>
		</div>
		
		<div align="center">
		<c:if test="${page.startPage > page.pageBlock}">
			<c:choose>
				<c:when test="${path==0}">
					<a href="restaurant?currentPage=${page.startPage-page.pageBlock}" class="pageblock">[이전]</a>
				</c:when>
				<c:when test="${path==1}">
					<a href="restaurantSearch?area=${area}?sigungu=${sigungu}?currentPage=${page.startPage-page.pageBlock}" class="pageblock">[이전]</a>	
				</c:when>
			</c:choose>	
		</c:if>
		<c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
			<c:choose>
				<c:when test="${path==0}">
					<a href="restaurant?currentPage=${i}" class="pageblock">[${i}]</a>
				</c:when>
				<c:when test="${path==1}">
					<a href="restaurantSearch?area=${area}?sigungu=${sigungu}?currentPage=${i}" class="pageblock">[${i}]</a>
				</c:when>
			</c:choose>	
		</c:forEach>
		<c:if test="${page.endPage < page.totalPage}">
			<c:choose>
				<c:when test="${path==0}">
					<a href="restaurant?currentPage=${page.startPage+page.pageBlock}" class="pageblock">[다음]</a>
				</c:when>
				<c:when test="${path==1}">
					<a href="restaurantSearch?area=${area}?sigungu=${sigungu}?currentPage=${page.startPage+page.pageBlock}" class="pageblock">[다음]</a>
				</c:when>
			</c:choose>	
		</c:if>
		</div>
		
	</body>
</html>