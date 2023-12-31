<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/components/AdminHeader.jsp" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>숙박업소등록</title>
		<link rel="stylesheet" type="text/css" href="/css/adminContentsDetail.css">
		<script src="/js/updateArea.js"></script>
		<script src="http://code.jquery.com/jquery-latest.min.js"></script>
		<script type="text/javascript">
		document.addEventListener("DOMContentLoaded", (event) => {
			
			<!-- 지역 코드 넣는 코드  Start-->	
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
		<style type="text/css">
		
		#detail-top-container {
			position: absolute;
			width: 250px;
			height: 83px;
			border-radius: 10px;
			border: 1px solid #000;
			flex-shrink: 0;
			top: -35px; /* B의 상단에 A를 위치시키기 위해 top을 0으로 설정 */
			margin: auto; /* 수평 및 수직 가운데 정렬을 위해 margin을 auto로 설정 */
			z-index: -1; /* A를 B 뒤로 보내기 위해 z-index를 -1로 설정 */
			background-color: black;
		}
		
		#detail-top-text {
			color: white;
			font-family: Noto Sans;
			font-size: 16px;
			font-style: normal;
			font-weight: 600;
			line-height: normal;
			letter-spacing: -0.48px;
			padding-top: 5px;
		}
		
		#detail-top-id{
			color: #FF4379;
			font-family: Noto Sans;
			font-size: 16px;
			font-style: normal;
			font-weight: 600;
			line-height: normal;
			letter-spacing: -0.48px;
			padding-top: 5px;
			word-wrap: break-word;
		}	
		
		#detail-top-id2{
			color: #BDEB50;
			font-family: Noto Sans;
			font-size: 16px;
			font-style: normal;
			font-weight: 600;
			line-height: normal;
			letter-spacing: -0.48px;
			padding-top: 5px;
			word-wrap: break-word;
		}	
		
		#detail-main-container {
			position: relative;
			border: 1px solid #000;
			border-radius: 10px;
			background-color: white;
		}
		.detail-body-container {
			justify-content: center;
			padding-right: 0;
			padding-left: 0;
			margin-right: 0;
			margin-left: 0;
		}
		.form-label{
			color: #000;
			font-family: Noto Sans;
			font-size: 16px;
			font-style: normal;
			font-weight: 600;
			line-height: normal;
		}
		h1 {
			color: black;
			font-size: 32px;
			font-family: Noto Sans;
			font-weight: 600;
			word-wrap: break-word
		}
		h3 {
			color: #FF4379;
			font-size: 24px;
			font-family: Noto Sans;
			font-weight: 600;
			word-wrap: break-word
		}
		
		.btn-primary2 {
		    background-color: #9BDB04; 
		    border-color: #9BDB04; 
		    color: white;
		}
		
		.btn-primary2:hover {
		    background-color: #52525C ; 
		    border-color: #52525C; 
		    color: #9BDB04;
		}
		</style>
	</head>
	<body>
	<div class="container-fluid">
		<div class="row">
			<%@ include file="/WEB-INF/components/AdminSideBar.jsp" %>
		<main class="col-10 p-0">
			<div class="admin-header-container">
				<div class="container m-4">
					<i class="title-bi bi bi-pencil-square "></i>
				<label  class="admin-header-title ">숙박 정보 등록 </label>	
				</div>
			</div>
			
				<!-- Section1: Title -->
			<div class="container my-5" id="detail-body-container">
				<div>
				<h1>숙소 등록</h1>
				<hr class="hr" />
				</div>
				<div>
				<h3 style="color: #FF4379 ">숙소정보 등록하기</h3>
				</div>
				<div class="my-5">
				<div class="" id="detail-main-container">
				
					<div class="container p-5" id="form-container">
					<form action="accomodationInsert" method="post">
						<div class="mb-3 ">
						  <label for="title" class="form-label">숙소 이름(필수 입력)</label>
						  <input type="text" class="form-control" name="title" id="title" value="${accomodaiton.title}" required="required">
						  <input type="hidden" class="form-control" name="user_id" id="user_id" value="${userId }">
						</div>
						<div class="mb-3" id="detail-content-title">
						  <label for="small_code" class="form-label">숙소 종류(필수 선택)</label>
						  	<input type="hidden" name="big_code" value="13">
							<select class="form-select" aria-label="small_code" name="small_code" required="required">
								<c:forEach var="smallCode" items="${listCodes}">
									<c:if test="${smallCode.big_code == 13 && smallCode.small_code != 999}">
										<option value="${smallCode.small_code}" ${smallCode.small_code == accomodaiton.small_code? 'selected' : '' }>${smallCode.content}</option>
									</c:if>
							 	</c:forEach>
							</select>
						</div>			
						<div class="mb-3 ">
							<label for="content" class="form-label ">지역(필수 선택)</label>
								<div class="row">
								    <div class="col-2">
								        <select name="area" class="form-select area-dropdown" required="required"></select>
								    </div>
								    <div class="col-2">
								       <select name="sigungu"  class="form-select sigungu-dropdown" required="required"></select>
								    </div>
								    	<div class="col-6">
										    <input type="text" class="form-control" name="address" id="address" value="${accomodation.address} " required="required" >
								    	</div>
								</div>
						</div>
						<div class="mb-3 ">
						  <label for="content" class="form-label">개요</label>
						  <textarea class="form-control" name="content" id="content" rows="5" placeholder="숙소에 대한 설명을 4000자 이내로 입력해주세요 ">${accomodaiton.content}</textarea>
						</div>		
						<div class="mb-3 ">
						  <label for="email" class="form-label">email</label>
						  <input type="text" class="form-control" name="email" id="email" value="${accomodaiton.email} ">
						</div>
						<div class="mb-3 ">
						  <label for="phone" class="form-label">전화번호</label>
						  <input type="text" class="form-control" name="phone" id="phone" value="${accomodaiton.phone}" placeholder="010 - 0000 - 0000~0">
						</div>
						<div class="mb-3 ">
						  <label for="homepage" class="form-label">홈페이지</label>
						  <input type="text" class="form-control" name="homepage" id="homepage" value="${accomodaiton.homepage} ">
						</div>
						<div class="mb-3 ">
						  <label for="room_count" class="form-label">객실수(필수)</label>
						  <input type="text" class="form-control" name="room_count" id="room_count" value="${accomodaiton.room_count}" required="required" ">
						</div>
						<div class="mb-3 ">
						  <label for="reservation_url" class="form-label">예약처</label>
						  <input type="text" name="reservation_url" class="form-control" id="reservation_url" value="${accomodation.reservation_url} " >
						</div>			
						<div class="mb-3 ">
						  <label for="refund" class="form-label">환불규정</label>
						  <input type="text" name="refund" class="form-control" id="refund" value="${accomodation.refund} " >
						</div>
						<div class="mb-3 ">
						   <label for="check_in" class="form-label">입실시간</label>
						  <input type="text" name="check_in" class="form-control" id="check_in" value="${accomodation.check_in} " >
						</div>
						<div class="mb-3 ">
						  <label for="check_out" class="form-label">퇴실시간</label>
						  <input type="text" name="check_out" class="form-control" id="check_out" value="${accomodation.check_out} " >
						</div>
						  
						 <div class="mb-3 ">
							 <label for="rest_time" class="form-label">태그</label>
								<div class="tag-container">
			                         <div class="tag-item">
			                             <div>#MZ추천</div>
			                         </div>
			                         <div class="tag-item">
			                             <div>#MZ추천</div>
			                         </div>
			                         <div class="tag-item">
			                             <div>#MZ추천</div>
			                         </div>
			                         <div class="tag-item">
			                             <div>#MZ추천</div>
			                         </div>
			                         <div class="tag-item">
			                             <div>#MZ추천</div>
			                       </div>
			    				</div>
		                   </div>	 
						  
						  <label for="facilities" class="form-label">부대시설</label><br>
						<div class="col-12 d-flex justify-content-between">
						  	<div class="col-3 form-check mx-3">
								<input class="form-check-input" type="radio" name="is_credit"
								id="is_cook" value="1" ${accomodation.is_cook == 1?"checked":""} > 
								<label class="form-check-label" for="is_credit">조리가능</label>
							</div>
							<div class="col-3 form-check mx-3">
								<input class="form-check-input" type="radio" name="is_pet"
								id="is_pickup" value="1" ${accomodation.is_pickup == 1?"checked":""} > 
								<label class="form-check-label" for="is_pet">픽업가능</label>
							</div>
							<div class="col-3 form-check mx-3">
							<input class="form-check-input" type="radio" name="is_parking"
								id="is_parking" value="1" ${accomodation.is_parking == 1?"checked":""} > 
								<label class="form-check-label" for="is_parking">주차가능</label>
							</div>
						</div>
						<!-- 카카오맵을 통해 좌표 받기위한 로직 -->
						<div id="map"></div>
						<input type="hidden" name="mapx" id="mapx_input" value="${accomodation.mapx }">
  						<input type="hidden" name="mapy" id="mapy_input" value="${accomodation.mapy }">
						
						<hr class="hr" />			
						
						
						
						<div class="d-flex justify-content-between">
							<div class="col-6 mb-3" >
    							<button type="submit" class="form-control btn btn-primary w-100" onclick="return confirm('등록 하시겠습니까?')">등록</button>
							</div>
	                        <div class="col-3 mb-3">
	                        	<button type="reset" class="btn btn-outline-secondary w-100" onclick="return confirm('입력하신 내용이 초기화됩니다. 정말 진행하시겠습니까?')">초기화</button>
	                        </div>
	                        <div class="col-2 mb-3">
	                        	<button type="button" class="btn btn-outline-secondary w-100" onclick="location.href='../content/accomodation'">취소</button>
	                        </div>
	                                        
						</div>
						<!-- 카카오맵을 통해 좌표 받기위한 로직 -->
						<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=3d40db7fe264068aa3438b9a0b8b2274&libraries=services"></script>
						<script>
						
  						
  						var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
  					    mapOption = {
  					        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
  					        level: 3 // 지도의 확대 레벨
  					    };  

  					// 지도를 생성합니다    
  					var map = new kakao.maps.Map(mapContainer, mapOption); 

  					// 주소-좌표 변환 객체를 생성합니다
  					var geocoder = new kakao.maps.services.Geocoder();

  					// 주소로 좌표를 검색합니다
  					document.getElementById('address').onchange = function() {
  					  var address = this.value;
  					  
  					  // 'address' 대신 실제 주소 값을 전달하도록 수정
  					  geocoder.addressSearch(address, function(result, status) {
  					    // 정상적으로 검색이 완료됐으면 
  					    if (status === kakao.maps.services.Status.OK) {
  					      var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
  					      
  					      // 결과값으로 받은 위치를 마커로 표시합니다
  					      var marker = new kakao.maps.Marker({
  					        map: map,
  					        position: coords
  					      });

  					      // 인포윈도우로 장소에 대한 설명을 표시합니다
  					      var infowindow = new kakao.maps.InfoWindow({
  					        content: '<div style="width:150px;text-align:center;padding:6px 0;">우리회사</div>'
  					      });
  					      infowindow.open(map, marker);

  					      // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
  					      map.setCenter(coords);
  					    document.getElementById("mapx_input").value = result[0].x;
  						document.getElementById("mapy_input").value = result[0].y;
  					    } 
  					  });
  					}
					        
					</script>
						
						</form>
						</div>
						</div>
						</div>
						</div>
			</main>
			</div>
		</div>
	</body>
</html>
