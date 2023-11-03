<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/components/AdminHeader.jsp" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>축제 상세 정보</title>
	</head>
	<body>
	<div class="container-fluid">
		<div class="row">
			<%@ include file="/WEB-INF/components/AdminSideBar.jsp" %>
			<main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
			
				<!-- Section1: Title -->
				<div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
					<h1 class="border">축제 상세 정보</h1>
				</div>
				
				<!-- Section2: Table -->		
				<div class="border p-3 m-3">
					<table class="table table-striped table-sm">
						<tr>
							<th>컨텐츠 ID</th>
							<td>${festival.content_id}</td>
						</tr>
						<tr>
							<th>분류</th>
							<td>[${festival.bcode_content}] ${festival.scode_content}</td>
						</tr>
						<tr>
							<th>축제명</th>
							<td>${festival.title}</td>
						</tr>
						<tr>
							<th>시작일</th>
							<td>${festival.start_date}</td>
						</tr>
						<tr>
							<th>종료일</th>
							<td>${festival.end_date }</td>
						</tr>
						<tr>
							<th>진행시간</th>
							<td>${festival.hours}</td>
						</tr>
						<tr>
							<th>주최자</th>
							<td>${festival.sponsor}</td>
						</tr>
						<tr>
							<th>전화번호</th>
							<td>${festival.phone}</td>
						</tr>
						<tr>
							<th>이메일</th>
							<td>${festival.email}</td>
						</tr>
						<tr>
							<th>장소명</th>
							<td>${festival.eventplace}</td>
						</tr>
						<tr>
							<th>주소</th>
							<td>${festival.postcode}<br>${festival.address}</td>
						</tr>
						<tr>
							<th>개요</th>
							<td>${festival.content}</td>
						</tr>
						<tr>
							<th>내용</th>
							<td>${festival.content}</td>
						</tr>
						<tr>
							<th>이용요금</th>
							<td>${festival.cost}</td>
						</tr>
						<tr>
							<th>홈페이지</th>
							<td>${festival.homepage}</td>
						</tr>
						<tr>
							<th>이미지</th>
							<td>${festival.img1}<br>${festival.img2}<br>${festival.img3}</td>
						</tr>
						<tr>
							<th>태그</th>
							<td><!-- 전체 태그 보여주기 --></td>
						</tr>
						<tr>
							<th>가능 여부</th>
							<td>
								<ul>
									<li>주차시설 : 
										<c:choose>
											<c:when test="${festival.is_parking == 0}">N</c:when>
											<c:when test="${festival.is_parking == 1}">Y</c:when>
										</c:choose>
									<li>유모차대여 : 
										<c:choose>
											<c:when test="${festival.is_stroller == 0}">N</c:when>
											<c:when test="${festival.is_stroller == 1}">Y</c:when>
										</c:choose>
									<li>휠체어대여 : 
										<c:choose>
											<c:when test="${festival.is_wheelchair == 0}">N</c:when>
											<c:when test="${festival.is_wheelchair == 1}">Y</c:when>
										</c:choose>
									<li>장애인화장실 : 
										<c:choose>
											<c:when test="${festival.is_restroom == 0}">N</c:when>
											<c:when test="${festival.is_restroom == 1}">Y</c:when>
										</c:choose>
								</ul>
							</td>
						</tr>
						<tr>
							<th>등록자 ID</th>
							<td>${festival.user_id}</td>
						</tr>
						<tr>
							<th>등록일</th>
							<td><fmt:formatDate value="${festival.created_at}" type="date" pattern="YY/MM/dd"/></td>
						</tr>
					</table>
					<div align="center">
						<c:if test="${festival.status == 0}">
							<button type="button" class="btn btn-outline-secondary">목록</button>
							<button type="button" class="btn btn-outline-secondary">승인</button>
							<button type="button" class="btn btn-outline-secondary">반려</button>
						</c:if>
						<c:if test="${festival.status == 1}">
							<button type="button" class="btn btn-outline-secondary">목록</button>
							<button type="button" class="btn btn-outline-secondary">수정</button>
							<button type="button" class="btn btn-outline-secondary">삭제</button>
						</c:if>
					</div>
				</div>		
			</main>
		</div>
		</div>
	</body>
</html>