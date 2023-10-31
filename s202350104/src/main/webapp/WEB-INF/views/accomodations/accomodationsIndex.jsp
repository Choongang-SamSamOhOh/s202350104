<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/components/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Restaurant Index</title>
<style type="text/css">
	.card-text {
		overflow : hidden;
		/* text-overflow: ellipsis; */
	}
</style>
</head>
<body>
	<!-- Top bar -->
	<%@ include file="/WEB-INF/components/TobBar.jsp" %>
	
	<h1>Restaurant List</h1>
		<c:forEach var="accomodations" items="${listAccomodations}">
			<div class="card" style="width: 18rem;">
  				<img src="${accomodations.img1}" class="card-img-top" alt="${accomodations.title}이미지" style="height: 190px;">
  				<div class="card-body">
    				<p class="card-text" style="height: 240px;">
    					숙소명 : ${accomodations.title} <br>
    					숙소위치 : ${accomodations.address}<br>
    					숙소소개  : ${accomodations.content}
    				</p>
    				<a href="accomodations/detail?content_id=${accomodations.content_id}" class="btn btn-primary">더보기</a>
 				 </div>	
			</div>
		</c:forEach>
	
	<!-- Footer -->
	<%@ include file="/WEB-INF/components/Footer.jsp" %>
</body>
</html>