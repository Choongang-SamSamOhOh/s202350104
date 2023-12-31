<%@page import="com.google.gson.Gson"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="org.springframework.context.ApplicationContext"%>
<%@page import="com.oracle.s202350104.service.map.MapService"%>
<%@page import="com.oracle.s202350104.service.map.KakaoMapSerivce"%>
<%@ include file="/WEB-INF/components/header.jsp" %>
<!-- Top bar -->
<%@ include file="/WEB-INF/components/TobBar.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CourseDetail</title>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

<!-- 카카오 MAP -->
<% ApplicationContext context=WebApplicationContextUtils.getRequiredWebApplicationContext(getServletContext());
   MapService map=context.getBean("kakaoMapSerivce", MapService.class); String apiKey=map.getApiKey(); %>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=<%=apiKey%>&libraries=clusterer"></script>

<!-- 지역 코드 넣는 코드  -->
<script src="/js/updateArea.js"></script>

<!-- script 영역 -->
<script>
	let markers = [];
	let map = null;
	let clusterer = null;
	let bounds = new kakao.maps.LatLngBounds()
	function initKakaoMap() {
		if ("geolocation" in navigator) {
			navigator.geolocation.getCurrentPosition(function (position) {
				const courseDetail = JSON.parse('${courseDetailJson}'.replace(/\n/g, ''))
				console.log("courseDetail",courseDetail);
				let latitude = 0;
				let longitude = 0;
				for(let i = 0 ; i < courseDetail.length ; i++){
 	 				latitude = courseDetail[i].mapy ;
					longitude = courseDetail[i].mapx ;
					const placePosition = new kakao.maps.LatLng(latitude, longitude);
					addMarker(placePosition,0,'haha')
					bounds.extend(placePosition);
				}
				map = getKakaoMap(latitude, longitude);
				
				clusterer = new kakao.maps.MarkerClusterer({
					map: map, // 마커들을 클러스터로 관리하고 표시할 지도 객체
					averageCenter: true, // 클러스터에 포함된 마커들의 평균 위치를 클러스터 마커 위치로 설정
					minLevel: 10,
					// 클러스터 할 최소 지도 레벨
				});
				clusterer.addMarkers(markers);
				map.setBounds(bounds);
			});
		}
		else {
			console.log("Geolocation을 지원하지 않는 브라우저입니다.");
		}
	}			
	
	function setCenter(lat, lng) {
		// 이동할 위도 경도 위치를 생성합니다
		var moveLatLon = new kakao.maps.LatLng(lat, lng);
	
		// 지도 중심을 이동 시킵니다
		map.setCenter(moveLatLon);
	}
	
	function getKakaoMap(latitude, longitude) {
		const container = document.getElementById("map");
		const options = {
			center: new kakao.maps.LatLng(latitude, longitude),
			level: 3,
		};
	
		return new kakao.maps.Map(container, options);
	}

	// 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
	function addMarker(position, idx, title) {
		var imageSrc =
			"https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png", // 마커 이미지 url, 스프라이트 이미지를 씁니다
			imageSize = new kakao.maps.Size(36, 37), // 마커 이미지의 크기
			imgOptions = {
				spriteSize: new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
				spriteOrigin: new kakao.maps.Point(0, idx * 46 + 10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
				offset: new kakao.maps.Point(13, 37),
				// 마커 좌표에 일치시킬 이미지 내에서의 좌표
			},
			markerImage = new kakao.maps.MarkerImage(
				imageSrc,
				imageSize,
				imgOptions
			),
			marker = new kakao.maps.Marker({
				position: position, // 마커의 위치
				image: markerImage,
			});
		marker.setMap(map); // 지도 위에 마커를 표출합니다
	
		markers.push(marker); // 배열에 생성된 마커를 추가합니다
	
		return marker;
	}

	/* function getLocation() {
		if ("geolocation" in navigator) {
			navigator.geolocation.getCurrentPosition(function (position) {
				const latitude = position.coords.latitude;
				const longitude = position.coords.longitude;
				setCenter(latitude, longitude);
			});
		} else {
			console.log("Geolocation을 지원하지 않는 브라우저입니다.");
		}
	}	 */


	/* 대분류, 소분류 기능 js */
	document.addEventListener("DOMContentLoaded", function() {
		initKakaoMap();
		updateAreaOptions();
		$(".area-dropdown").change(
				function() {
					const selectedArea = $(this).val();
					if (selectedArea) {
						updateSigunguOptions(selectedArea);
					} else {
						$(".sigungu-dropdown").empty().append(
								"<option value='0'>전체</option>");
					}
				});
	});
	
	/* 신고 기능 js */
	function report(boardId) {
	    window.open("../reportBoardFoam?boardId=" + boardId, "_blank", "width=600, height=400, top=100, left=100");
	}
	
	/* review 생성 기능 js */
	function showPopUp(userId, bigCode, smallCode, currentPage, contentId, commonCode) {
	    console.log("showPopUp 함수가 호출되었습니다.");		
		//창 크기 지정
		var width = 700;
		var height = 600;
		
		//pc화면기준 가운데 정렬
		var left = (window.screen.width / 2) - (width/2);
		var top = (window.screen.height / 4);
		
	    //윈도우 속성 지정
		var windowStatus = 'width='+width+', height='+height+', left='+left+', top='+top+', scrollbars=yes, status=yes, resizable=yes, titlebar=yes';
		
	    //연결하고싶은url
	    const url = "../reviewBoardInsertForm?userId="+ userId + "&commonCode=" + commonCode + "&bigCode=" + bigCode + "&smallCode=" + smallCode + "&currentPage=" + currentPage + "&contentId=" + contentId;
	
		//등록된 url 및 window 속성 기준으로 팝업창을 연다.
		window.open(url, "hello popup", windowStatus);
	}
	
	/* review card carousel js */
    $(document).ready(function () {
        $(".custom-carousel").owlCarousel({
            autoWidth: true,
            loop: true
        });
/*         $(".custom-carousel .card").click(function () {
            $(".custom-carousel .card").not($(this)).removeClass("card");
            $(this).toggleClass("card");
        }); */
    });
	
    /* 클릭한 사진 보여주기 */
	function clickPhoto(event){
		console.log("실행");
		
		var clickedImg = event.target;
		
		var chooseImg = document.getElementById("photo");
		chooseImg.setAttribute("src", clickedImg.getAttribute("src"));
	}
	
	/* URL Link Share */
	function clip() {
	    var textarea = document.createElement("textarea");
	    document.body.appendChild(textarea);
	    
	    var url = window.document.location.href;
	    textarea.value = url;
	    textarea.select();
	    
	    document.execCommand("copy");
	    document.body.removeChild(textarea);
	    
	    swal({
	        title: "URL이 복사되었습니다!!",
	        text: url,
	        icon: "success",
	    })
	}
	
</script>
<style type="text/css">
.course-card {
	width: 100%; 
	height: 100%; 
	background: #F4F4F4; 
	border-radius: 10px
}
.card-image-size {
	width: 405px;
	height: 270px; 
	background: #D9D9D9;
}
.ellipsis-text {
    overflow: hidden;
    text-overflow: ellipsis;
    display: -webkit-box;
    -webkit-line-clamp: 5; /* 표시할 줄 수 */
    -webkit-box-orient: vertical;
}

</style>

</head>
<body>

	<!-- 임시, 여백용-->
	<div id="content_title" class="container homeDetail-whiteSpace-custom"></div>
	
	<!-- 상단 분홍색 title 출력-->
	<div class="homeDetail-topTitle-custom" style="height: 120px;">
		<div class="container homeDetail-topTitle-custom">
			<div class="row row-cols-3">
				<c:forEach var="courseDetail" items="${courseDetail }">
					<c:if test="${courseDetail.order_num == 1}">
						<div class="col title-custom">
							<p>${courseDetail.course_title}</p>
						</div>
					</c:if>
				</c:forEach>
				<div class="col image-custom">
					<img alt="share_icon.png" src="../image/share_icon.png" onclick="clip(); return false;">
				</div>
			</div>
		</div>
	</div>
	
	<!-- content tag 출력-->
	<div class="container homeDetail-topTags-custom">
		<div class="row row-cols-6">
			<c:if test="${listTags != null }">
				<c:forEach var="tags" items="${listTags }">
					<div class="col-sm-1 hashTag-custom">
						<button value="&{tags.tag_id }">#${tags.name }</button>
					</div>
				</c:forEach>
			</c:if>
			<c:if test="${fn:length(listTags) == 0}">
				<div class="col-sm-1 hashTag-custom">
					<button>#해시태그</button>
				</div>
			</c:if>
		</div>
	</div>
	
	<!-- content tag 출력-->
	<%-- <div class="container homeDetail-topTags-custom">
		<div class="row row-cols-6">
			<c:forEach var="tags" items="${listTags }">
				<div class="col-sm-1 hashTag-custom">
					<c:choose>
						<c:when test="${tags.tag_id > 0}">
							<button value="&{tags.tag_id }">#${tags.name }</button>		
						</c:when>
						<c:otherwise>
							<button>#해시태그</button>	
						</c:otherwise>
					</c:choose>	
				</div>		
			</c:forEach>
		</div>
	</div> --%>
	
	<!-- 이미지, 기본 정보 출력 -->
	<div class="container homeDetail-basic-custom">
		<div class="row row-cols-3">
			<!-- 첫번째 큰 이미지 -->
			<c:forEach var="courseDetail" items="${courseDetail }">
				<c:if test="${courseDetail.order_num == 1}">
					<div class="col homeDetail-basic-img-custom">
						<img id="photo" alt="${courseDetail.img1}" src="${courseDetail.img1}">
					</div>
					
					<!-- 두번째 작은 이미지 -->
					<div class="col homeDetail-basic-sideImg-custom">
						<div class="row row-cols-1">
							<c:choose>
								<c:when test="${courseDetail.img1 != null}">
									<div class="col sideImg-custom">
										<img alt="${courseDetail.img1}" src="${courseDetail.img1}" onclick="clickPhoto(event)">		
									</div>			
								</c:when>
								<c:otherwise>
									<div class="col sideImg-custom"></div>							
								</c:otherwise>
							</c:choose>
							<c:choose>
								<c:when test="${courseDetail.img2 != null}">
									<div class="col sideImg-custom">
										<img alt="${courseDetail.img2}" src="${courseDetail.img2}" onclick="clickPhoto(event)">	
									</div>			
								</c:when>
								<c:otherwise>
									<div class="col sideImg-custom"></div>							
								</c:otherwise>
							</c:choose>
							<c:choose>
								<c:when test="${courseDetail.img3 != null}">
									<div class="col sideImg-custom">
										<img alt="${courseDetail.img3}" src="${courseDetail.img3}" onclick="clickPhoto(event)">		
									</div>			
								</c:when>
								<c:otherwise>
									<div class="col sideImg-custom"></div>							
								</c:otherwise>
							</c:choose>
							<!-- 추가 이미지 확장용 -->
							<div class="col sideImg-custom"></div>
							<div class="col sideImg-custom"></div>
						</div>
					</div>
				</c:if>
			</c:forEach>
			
					
			<!-- 세번째 요약 content -->
			<div class="col homeDetail-basic-text-custom">
				<div class="row row-cols-1" style="display: flex; flex-direction: column; align-items: flex-start;">
					<c:forEach var="courseDetail" items="${courseDetail }">
						<c:if test="${courseDetail.order_num == 1}">
							<div class="col text-custom">
								<img alt="icon.jpg" src="../image/boardStatus1.png">
								<p class="text-md-custom">코 스 명</p>
								<p>${courseDetail.course_title }</p>
							</div>
						</c:if>
					</c:forEach>
					<c:forEach var="courseDetail" items="${courseDetail }">
						<c:if test="${courseDetail.order_num == 1}">
							<div class="col text-custom">
								<img alt="icon.jpg" src="../image/boardStatus1.png">
								<p class="text-md-custom">코스거리</p>
								<p>${courseDetail.distance }</p>
							</div>
						</c:if>
					</c:forEach>
					<c:forEach var="courseDetail" items="${courseDetail }">
						<c:if test="${courseDetail.order_num == 1}">
							<div class="col text-custom">
								<img alt="icon.jpg" src="../image/boardStatus1.png">
								<p class="text-md-custom">소요시간</p>
								<p>${courseDetail.time }</p>
							</div>
						</c:if>
					</c:forEach>
					<%-- <c:forEach var="courseDetail" items="${courseDetail }">
						<c:if test="${courseDetail.order_num == 1}">
							<div class="col text-custom">
								<img alt="icon.jpg" src="../image/boardStatus1.png">
								<p class="text-md-custom">위치</p>
								<p>#</p>
							</div>
						</c:if>
					</c:forEach> --%>
					<c:forEach var="courseDetail" items="${courseDetail }">
						<c:if test="${courseDetail.order_num == 1}">
							<div class="col text-custom">
								<img alt="icon.jpg" src="../image/boardStatus1.png">
								<p class="text-md-custom">코스내용</p>
								<p>${courseDetail.course_info }</p>
							</div>
						</c:if>
					</c:forEach>
					<div class="col text-custom"></div>
					<c:forEach var="courseDetail" items="${courseDetail }">
					    <div class="col text-custom">
					        <p class="text-md-custom" style="padding-left: 30px;">- 코스이름 : </p>
					        <p>${courseDetail.title}</p>
					    </div>
					</c:forEach>
					<div class="col text-icon-custom"></div>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 경계선 표현 -->
	<hr class="container homeCommon-top-custom">
	
	<!-- 상세정보 출력 -->
	<div class="container homeDetail-mdTitle-custom">
		<h2><strong>코스 리스트</strong></h2>
	</div>
	
	<div class="container homeDetail-basic-custom">
		<div class="row row-cols-12">
			<div>
				<c:forEach var="courseDetail" items="${courseDetail }">
				<div class="card course-card col-md-6" style="height: 306px; margin: 20px; padding: 18px;">
					<div class="container homeDetail-basic-custom">
						<div class="row">
							<div class="col-md-5">
								<a href='../${courseDetail.cd_content.toLowerCase() }/detail?contentId=${courseDetail.content_id}' style="padding: 0px;">
									<img class="card-image-size" alt="${courseDetail.course_title }" src="${courseDetail.img1 }">
								</a>
							</div>
						
							<div class="col-md-6">
								<ul>
									<li>코스이름 : ${courseDetail.title }
									<li>주소 : ${courseDetail.address }
									<li>개요 : <div class="ellipsis-text">
												 ${courseDetail.content }
											 </div>
									<li>전화번호 : ${courseDetail.phone }
									<li>홈페이지 : <a href="${courseDetail.homepage }" style="color: blue;">${courseDetail.homepage }</a>
								</ul>
							</div>
						</div>
					</div>
				</div>
				</c:forEach>
			</div>
		</div>
	</div>
	
	<!-- 경계선 표현 -->
	<hr class="container homeCommon-top-custom">
	
	<!-- 찾아가기 출력 -->
	<div class="container homeDetail-mdTitle-custom">
		<h2><strong>찾아가기</strong></h2>
	</div>
	
	<div class="container homeDetail-map-custom">
		<div id="map" class="homeDetail-map-detail">
		
		</div>	
	</div>
	
	<!-- 경계선 표현 -->
	<hr class="container homeCommon-top-custom">
	
	<!-- 비슷한 축제 출력 -->
	<div class="container homeDetail-mdTitle-custom">
		<h2><strong>비슷한 축제</strong></h2>
	</div>	

	<div class="container homeList-menu-custom">
		<div class="row row-cols-3 g-6 homeList-mdMenu-custom">
			<div class="col d-flex justify-content-center">
				<div class="card homeList-card-custom">
					<div class="homeList-tag-custom">
						<div class="homeList-tag-custom2">
							<p class="tag-p">#지역태그</p>
						</div>
						<a href="">
							<img src="../photos/aquarium1.png" class="card-img-top"
							alt="image.jpg">
						</a>
					</div>

					<div class="card-body">
						<p class="card-text title-p">축제 제목</p>
						<p class="card-text period-p">2023.00.00&nbsp;~&nbsp;00.00</p>
						<p class="card-text contet-p">content영역</p>
					</div>
				</div>
			</div>
			
			<div class="col d-flex justify-content-center">
				<div class="card homeList-card-custom">
					<div class="homeList-tag-custom">
						<div class="homeList-tag-custom2">
							<p class="tag-p">#지역태그</p>
						</div>
						<a href="">
							<img src="../photos/aquarium1.png" class="card-img-top" alt="image.jpg">
						</a>
					</div>

					<div class="card-body">
						<p class="card-text title-p">축제 제목</p>
						<p class="card-text period-p">2023.00.00&nbsp;~&nbsp;00.00</p>
						<p class="card-text contet-p">content영역</p>
					</div>
				</div>
			</div>
			
			<div class="col d-flex justify-content-center">
				<div class="card homeList-card-custom">
					<div class="homeList-tag-custom">
						<div class="homeList-tag-custom2">
							<p class="tag-p">#지역태그</p>
						</div>
						<a href="">
							<img src="../photos/aquarium1.png" class="card-img-top" alt="image.jpg">
						</a>
					</div>

					<div class="card-body">
						<p class="card-text title-p">축제 제목</p>
						<p class="card-text period-p">2023.00.00&nbsp;~&nbsp;00.00</p>
						<p class="card-text contet-p">content영역</p>
					</div>
				</div>
			</div>						
		</div>
	</div>

	<!-- Footer -->
	<%@ include file="/WEB-INF/components/Footer.jsp"%>
	
</body>
</html>