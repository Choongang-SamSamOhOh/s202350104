<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BoardInsertForm</title>
<!-- 부트스트랩 4.5.2 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<link href="/assets/css/star.css" rel="stylesheet"/>
<!-- 부트스트랩 5.3.1-->
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
<style type="text/css">
#myform fieldset{
    display: inline-block;
    direction: rtl;
    border:0;
}
#myform fieldset legend{
    text-align: right;
}
#myform input[type=radio]{
    display: none;
}
#myform label{
    font-size: 3em;
    color: transparent;
    text-shadow: 0 0 0 #f0f0f0;
}
#myform label:hover{
    text-shadow: 0 0 0 rgba(250, 208, 0, 0.99);
}
#myform label:hover ~ label{
    text-shadow: 0 0 0 rgba(250, 208, 0, 0.99);
}
#myform input[type=radio]:checked ~ label{
    text-shadow: 0 0 0 rgba(250, 208, 0, 0.99);
}
#reviewContents {
    width: 100%;
    height: 150px;
    padding: 10px;
    box-sizing: border-box;
    border: solid 1.5px #D3D3D3;
    border-radius: 5px;
    font-size: 16px;
    resize: none;
}
  
</style>

<!-- jQuery 라이브러리 불러오기 -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<script>
	function closeAndRedirect(smallCode, currentPage) {
        event.preventDefault();
	    $.ajax({
	        url: '/',
	        method: 'GET',
	        success: function () {
	            // 취소 버튼 실행 시 이전페이지 이동 + 새로고침
	           	if (smallCode == 6) {
	                // 포토게시판으로 리디렉션
	                window.opener.location.href = '/festival/detail?contentId=${contentId}&currentPage=${currentPage}';
	            } else if(smallCode == 5) {
	            	// 이벤트게시판으로 리디렉션
	                window.opener.location.href = '/eventBoardList';
	            } else{
	            	// 기본 & 오류 처리
	            	window.opener.location.href = '/home';
	            }
	           	window.close();
	        }
	    });
	}
	
    function closeWindowAfterSubmit(contentId, currentPage) {
    	// 기본 제출 동작 막기
        event.preventDefault();
    	
        $.ajax({
            url: 'reviewBoardInsert', // 실제 서버 URL로 수정
            method: 'POST',
            data: $('#myform').serialize(), // 폼 데이터를 직렬화하여 전송
            success: function () {
                // 성공적으로 서버로 전송된 후에 창을 닫음
                window.close();
                
                window.opener.location.href = '/festival/detail?contentId=${contentId}&currentPage=${currentPage}';
            }
        });
    }
	
</script>

</head>
<body>  
	<div id="content_title" class="container p-5 mb-4 text-center">
	    <h2>신규 리뷰 생성</h2>
	    <c:if test="${msg!=null }">${msg }</c:if>
	</div>
    <div class="container mt-5">
        <form class="mb-3" action="#" name="myform" id="myform" 
        	  method="post" enctype="multipart/form-data" onsubmit="closeWindowAfterSubmit(${contentId },${currentPage })">
			<input type="hidden" name="user_id" value="${userId }">
			<input type="hidden" name="big_code" value="${bigCode }">
			<input type="hidden" name="small_code" value="${smallCode }">
			<input type="hidden" name="content_id" value="${contentId }">
			<input type="hidden" name="currentPage" value="${currentPage }">

				<fieldset class="form-group"> 
					<span class="text-bold">별점을 선택해주세요</span>
					<input type="radio" name="score" value="5" id="rate1">
					<label for="rate1">★</label>
					<input type="radio" name="score" value="4" id="rate2">
					<label for="rate2">★</label>
					<input type="radio" name="score" value="3" id="rate3">
					<label for="rate3">★</label>
					<input type="radio" name="score" value="2" id="rate4">
					<label for="rate4">★</label>
					<input type="radio" name="score" value="1" id="rate5">
					<label for="rate5">★</label>
				</fieldset>
				
				<div class="form-group">
					<textarea class="col-auto form-control" id="reviewContents" name="content"
							  placeholder="당신의 경험을 한줄평으로 남겨주세요!! 포인트 100p도 지급!!"></textarea>
				</div>	
 				
 				<div class="form-group">
            		<button type="submit" class="btn btn-primary">등록</button>
            		<button class="btn btn-secondary" onclick="closeAndRedirect(${smallCode}, ${currentPage})">취소</button>
        		</div>
        </form>
    </div>

</body>
</html>