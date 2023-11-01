<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>	
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BoardDetail</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9"
	crossorigin="anonymous" />
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm"
	crossorigin="anonymous">
	
</script>
<!-- jQuery 라이브러리 불러오기 -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<script>
	function closeAndRedirect(smallCode) {
	    $.ajax({
	        url: '/',
	        method: 'GET',
	        success: function () {
	            // 취소 버튼 실행 시 이전페이지 이동 + 새로고침
	           	if (smallCode === 1) {
	                // 공지사항 게시판으로 리디렉션
	                location.href = '/noticBoardList';
	            } else if(smallCode === 2) {
	            	// 이달의 소식 게시판으로 리디렉션
	                location.href = '/magazinBoardList';
	            } else if(smallCode === 3){
	            	// 자유게시판으로 리디렉션
	                location.href = '/freeBoardList';
	            } else if(smallCode === 4){
	            	// 자유게시판으로 리디렉션
	                location.href = '/photoBoardList';
	            } else if(smallCode === 5){
	            	// 자유게시판으로 리디렉션
	                location.href = '/eventBoardList';
	            } else{
	            	// 기본 & 오류 처리
	            	//location.href = '/';
	            	window.history.back();
	            }
	        }
	    });
	}
</script>
</head>
<body>
	<!-- Top bar -->
	<%@ include file="/WEB-INF/components/TobBar.jsp"%>

	<div class="container mt-4">
		<h1 class="text-center">게시판 상세정보</h1>
	</div>
	<div class="container border p-4 mb-4">
		<table class="table table-bordered">
			<tr class="table-primary">
				<th scope="col">제목</th>
				<td>${board.title }</td>
				<th scope="col">작성자</th>
				<td>${board.name }</td>
				<th scope="col">작성일</th>
				<td><fmt:formatDate value="${board.created_at }" type="date"
									pattern="yyyy/MM/dd"/>
				</td>
				<c:if test="${board.updated_at != null}">
        			<th scope="col">수정일</th>
       		   		<td><fmt:formatDate value="${board.updated_at}" type="date" 
       		   							pattern="yyyy/MM/dd" />
       		   		</td>
    			</c:if>
			</tr>
			<tr class="table-primary">
				<th scope="col">내용</th>
				<td>${board.content }</td>
			</tr>
		</table>
	</div>
	<div class="text-center">
		<button class="btn btn-primary" onclick="location.href='boardUpdateForm?id=${board.id}'">수정</button>
		<button class="btn btn-danger" onclick="location.href='boardDelete?id=${board.id}&smallCode=${board.small_code }'">삭제</button>
		<button class="btn btn-secondary" onclick="closeAndRedirect(${board.small_code })">취소</button>
	</div>
</body>
</html>