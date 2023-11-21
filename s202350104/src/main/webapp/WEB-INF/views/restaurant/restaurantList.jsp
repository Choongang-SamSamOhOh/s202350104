<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/components/header.jsp" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>RestaurantList</title>
			<%@ include file="/WEB-INF/components/AdminUpdateAreas.jsp"%>
			<style type="text/css">
				.pageblock {
					text-align: center;
				}
			</style>
		  	<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
		  	<script>
	    		// 이미지를 클릭할 때 폼을 제출하는 함수
	    		$(document).ready(function () {
	        		$("#searchIcon").click(function () {
	            		$("#restaurantSearch").submit();
	        		});
	    		});
			</script>
	</head>	 	
	 	
	<body>
		<!-- Top bar -->
		<%@ include file="/WEB-INF/components/TobBar.jsp" %>
				
		<main>
			<div class="position-relative overflow-hidden p-3 p-md-5 m-md-3 text-center bg-body-tertiary">
				<!-- HeaderBanner by.엄민용 -->	
				<c:forEach var="headers" items="${bannerHeader }">
					<c:choose>
						<c:when test="${headers.title == '맛집' }">
							<img alt="맛집_headerBanner" src="${headers.image }">
						</c:when>
					</c:choose> 
				</c:forEach>
				<!-- HeaderBanner end -->
			</div>
			
			
			<!-- 상단 분홍색 영역 -->
			<div class="container p-0 top_custom"></div>
		
			<!-- keyword, title 영역 -->	
			<form id="restaurantSearch" action="restaurantSearch">
			<div class="container p-0 keyword_title_custom">
			<div class="co1 title_div">
						R E S T A U R A N T!</div>
			<div class="co1 text_div">
				<h4><strong>어느 맛집에서 먹어볼까요~♫</strong></h4>
			</div>
			<input class="form-control keyword_input" type="text" name="keyword" placeholder="가고 싶은 맛집의 이름이나 키워드를 검색해보세요." style="margin-right: 15px;">
			<img class="keyword_img" src="../image/icon_search1.png" alt="icon_search1.png" id="searchIcon"/>
			</div>
	
			<!-- 경계선 표현 -->
			<hr class="container p-0 hr_custom">	
		
			<!-- select 영역 -->
			<div class="container p-0 select_custom">
				<div class="row g-2 text-center">
					<div class="col d-flex justify-content-center">
						<select name="area" id="area" class="form-select text-center border-3 select_text_custom area-dropdown" 
							aria-label="Default select example">
						</select>
					</div>
				<div class="col d-flex justify-content-center">
					<select name="sigungu" id="sigungu" class="form-select text-center border-3 select_text_custom sigungu-dropdown" 
							aria-label="Default select example">
						<option selected>시,군,구 선택</option>
					</select>
				</div>
				<div class="col d-flex justify-content-center">
					<select name="small_code" id="small_code" class="form-select text-center border-3 select_text_custom" 
							aria-label="Default select example">
							<option value="999">테마 선택</option>
							<c:forEach var="smallCode" items="${listSmallCode}">
								<option value="${smallCode.small_code}">${smallCode.content}</option>
							</c:forEach>	 	
					</select>
				</div>
				</div>		
			</div>	
			</form>
			
			<!-- 경계선 표현 -->
			<hr class="container p-0 hr_custom">	
	
			<!-- 목록 영역 -->	                           
	        <div class="container p-0 list_custom">
	        	<c:if test="${listRestaurant.size() == 0}">해당하는 식당 정보가 없습니다.</c:if>
	            <div class="row row-cols-3 g-2">
	                  <c:forEach var="restaurant" items="${listRestaurant}">
	                    <div class="col d-flex justify-content-center">
	                        <div class="card card_custom border-0">
	                           <div class="tag_custom">
									<div class="tag_custom2">
										<p class="tag_p">#지역태그</p>
								</div>
	                          	<a href="restaurant/detail?contentId=${restaurant.content_id}&currentPage=${page.currentPage}">
	                            	<img src="${restaurant.img1}" class="app-card-img-top" alt="${restaurant.title}이미지"></a>
	                          </div>
	                          
	                          
	                          <div class="card-body">
	                          <p class="card-text title_p">${restaurant.title}</p>   
	                          <p class="card-text period_p">${restaurant.first_menu}</p>
	                          <p class="card-text contet_p">${restaurant.content}</p>
	                          </div>   
	                        </div>
	                     </div>            
	                  </c:forEach>
	               </div>
	            </div>      
	         
	         
	         <!-- 페이징 처리 -->
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
     </main>         
      
	      <!-- Footer -->
	      <%@ include file="/WEB-INF/components/Footer.jsp" %>
   </body>
</html>