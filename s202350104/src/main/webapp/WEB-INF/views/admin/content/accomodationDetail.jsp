<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/components/AdminHeader.jsp" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>숙박 상세 정보</title>
		<link rel="stylesheet" type="text/css" href="/css/adminContentsDetail.css">
		<script src="http://code.jquery.com/jquery-latest.min.js"></script>
		<script type="text/javascript">
		function deleteConfirm() {
			var contentId = Number(${accomodation.content_id}); 
			var is_deleted = "${accomodation.is_deleted}";
			if(confirm("삭제하시겠습니까?")) {
					location.href="../content/accomodationDelete?contentId=${accomodation.content_id}";
				}
			}
		function confirmRestore(contentId) {
	        if (confirm('정말로 이 항목을 복원하시겠습니까?')) {
	            $.ajax({
	                type: 'POST', // 또는 'POST' 등의 HTTP 메서드 사용 가능
	                url: 'accomodationRestoreAjax',
	                data: { contentId: contentId },
	                success: function(result) {
	                    // 성공적으로 복원된 경우의 처리
	                    alert('복원되었습니다.');
	                    location.reload();
	                },
	                error: function(xhr, status, error) {
	                    // 오류 발생 시의 처리
	                    alert('복원에 실패했습니다.');
	                }
	            });
	        } else {
	            // 취소 버튼을 눌렀을 때의 처리
	            // 필요한 로직을 추가하세요.
	        }
	    }
			
			function approveConfirm() {
				var contentId = Number(${accomodation.content_id});
				var status = "${accomodation.status}";
				if(confirm("승인하시겠습니까?")) {
					location.href="../content/accomodationApprove?contentId="+contentId+"&currentPage=${currentPage}&status="+status;
				}
			}
			
			function approveConfirm1() {
				var contentId = Number(${accomodation.content_id}); 
				var status = $("#accomo_status").val();
				if(confirm("반려전환 변경하시겠습니까?")) {
					location.href="../content/accomodationApprove?contentId="+contentId+"&currentPage=${currentPage}&status="+status;
				}
			}
			
			function submitRejectForm(formName) {
				// $('#statusInput').value = 0;
				formName.action = "/admin/content/insertHistory";
				formName.method = "post";
				$('.form-input, .check-duple').prop("disabled", false);
				
				$('#rejectModal').modal('hide');
				
				const rejectContent = document.getElementById('message-text').value;
				const rejectTitle = document.getElementById('modal-title').innerText;		
				$('#reject-title').val(rejectTitle);
				$('#reject-content').val(rejectContent);
				
				formName.submit();
			}
			
			function getSigungu(pArea){
				var pSigungu = ${accomodation.sigungu}
				$.ajax(
						{
							url:"<%=request.getContextPath()%>/getSigungu/"+pArea,
							dataType:'json',
							success:function(areas) {
								$('#sigungu_select option').remove();
								str = "<option value='999'>전체</option>";
								$(areas).each(
									function() {
										if(this.sigungu != 999 && this.content != null) {
											strOption = "<option value='"+this.sigungu+"' ${"+this.sigungu+" == "+pSigungu+"? 'selected':''}>"+this.content+"</option>";
											str += strOption;
										}
									}		
								)
								$('#sigungu_select').append(str);
							}
						}		
				)
			}
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
		
		#detail-top-id3{
			color: red;
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
				<label  class="admin-header-title ">숙소 상세 정보 </label>	
				</div>
			</div>
				
				<div class="container my-5" id="detail-body-container">
				<div>
				<h1>숙박 관리</h1>
				<hr class="hr" />
				</div>
				<div>
				<h3 style="color: #FF4379 ">숙소별 상세 정보  </h3>
				<input type="hidden" id="accomo_status" value="${accomodation.status}">
				</div>
				<div class="my-5">
				<div class="" id="detail-main-container">
					<div class="container d-flex justify-content-around" id="detail-top-container">
								<label id="detail-top-text">숙박 ㅣ </label>
								<label id="detail-top-text" >${accomodation.content_id} ㅣ</label>
								<c:choose>
									<c:when test="${accomodation.is_deleted == 1}">
									<label id="detail-top-id3" >삭제(게시X)</label>
									</c:when>
									<c:when test="${accomodation.status == 0}">
									<label id="detail-top-id" >승인대기</label>
									</c:when>
									<c:when test="${accomodation.status == 1}">
									<label id="detail-top-id2" >승인(게시중)</label>
									</c:when>
								</c:choose>
					</div>
					<div class="container p-5" id="form-container">
					<form action="accomodation/update" method="post">
						<div class="mb-3">
						  <label for="content_id" class="form-label">컨텐츠 ID</label>
						  <input type="text" class="form-control" id="content_id" value="${accomodation.content_id} " readonly>
						</div>	
						<div class="mb-3" id="detail-content-title">
						  <label for="small_code" class="form-label">숙박 종류</label>
							<select class="form-select" aria-label="small_code">
								<c:forEach var="smallCode" items="${listSmallCode}">
									<c:if test="${smallCode.small_code != 999}">
										<option value="${smallCode.small_code}" ${smallCode.small_code == accomodation.small_code? 'selected' : '' } disabled>${smallCode.content}</option>
									</c:if>
							 	</c:forEach>
							</select>
						</div>			
						<div class="mb-3 ">
						  <label for="title" class="form-label">숙소 이름</label>
						  <input type="text" class="form-control" id="title" value="${accomodation.title} " readonly>
						</div>
						 <div class="mb-3 ">
							<label for="content" class="form-label ">지역</label>
								<div class="row">
								    <div class="col-2">
								        <!-- 첫 번째 그리드 -->
								        <select class="form-select" id="area" name="area" onchange="getSigungu(this.value)" disabled>
								            <option value="">전체</option>
								            <c:forEach var="areas" items="${listAreas}">
								                <c:if test="${areas.sigungu == 999}">
								                    <option value="${areas.area}" ${areas.area == accomodation.area? 'selected':''}>${areas.content}</option>
								                </c:if>
								            </c:forEach>
								        </select>
								    </div>
								    <div class="col-2">
								        <!-- 두 번째 그리드 -->
								        <select class="form-select" id="sigungu_select" name="sigungu" disabled>
								            <option value="999">전체</option>
								            <c:forEach var="areas" items="${listSigungu}">
								                <c:if test="${areas.sigungu != 999 && areas.sigungu != null}">
								                    <option value="${areas.sigungu}" ${areas.sigungu == accomodation.sigungu? 'selected':''}>${areas.content}</option>
								                </c:if>
								            </c:forEach>
								        </select>
								    </div>
								    	<div class="col-6">
										    <input type="text" class="form-control" id="address" value="${accomodation.address} " readonly>
								    	</div>
								</div>
						</div>
						<div class="mb-3 ">
						  <label for="content" class="form-label">개요</label>
						  <textarea class="form-control" id="content" rows="5" readonly>${accomodation.content}</textarea>
						</div>		
						<div class="mb-3 ">
						  <label for="email" class="form-label">email</label>
						  <input type="text" class="form-control" id="email" value="${accomodation.email} " readonly>
						</div>
						<div class="mb-3 ">
						  <label for="phone" class="form-label">전화번호</label>
						  <input type="text" class="form-control" id="phone" value="${accomodation.phone} " readonly>
						</div>
						<div class="mb-3 ">
						  <label for="homepage" class="form-label">홈페이지</label>
						  <input type="text" class="form-control" id="homepage" value="${accomodation.homepage} " readonly>
						</div>
						<div class="mb-3 ">
						  <label for=created_at class="form-label">작성일</label>
						  <input type="text" class="form-control" id="created_at" value="<fmt:formatDate value="${accomodation.created_at}" pattern="YYYY/MM/dd"/>" readonly>
						</div>
						<div class="mb-3 ">
						  <label for="room_count" class="form-label">객실수</label>
						  <input type="text" class="form-control" id="room_count" value="${accomodation.room_count} " readonly>
						</div>
						<div class="mb-3 ">
						  <label for="reservation_url" class="form-label">예약처</label>
						  <input type="text" class="form-control" id="reservation_url" value="${accomodation.reservation_url} " readonly>
						</div>						
						<div class="mb-3 ">
						  <label for="refund" class="form-label">환불규정</label>
						  <input type="text" class="form-control" id="refund" value="${accomodation.refund} " readonly>
						</div>
						<div class="mb-3 ">
						  <label for="check_in" class="form-label">입실시간</label>
						  <input type="text" class="form-control" id="check_in" value="${accomodation.check_in} " readonly>
						</div>
						<div class="mb-3 ">
						  <label for="check_out" class="form-label">퇴실시간</label>
						  <input type="text" class="form-control" id="check_out" value="${accomodation.check_out} " readonly>
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
								id="is_cook" value="1" ${accomodation.is_cook == 1?"checked":""} disabled> 
								<label class="form-check-label" for="is_credit">조리가능</label>
							</div>
							<div class="col-3 form-check mx-3">
								<input class="form-check-input" type="radio" name="is_pet"
								id="is_pickup" value="1" ${accomodation.is_pickup == 1?"checked":""} disabled> 
								<label class="form-check-label" for="is_pet">픽업가능</label>
							</div>
							<div class="col-3 form-check mx-3">
							<input class="form-check-input" type="radio" name="is_parking"
								id="is_parking" value="1" ${accomodation.is_parking == 1?"checked":""} disabled> 
								<label class="form-check-label" for="is_parking">주차가능</label>
							</div>
						</div>							
							
						<hr class="hr" />			
						
						 <div class="d-flex justify-content-between">
						 

						 	<c:choose>
							 <c:when test="${accomodation.is_deleted == 1}">
							 	<div class="col-6 mb-3" >
		                        	<button type="button" class="form-control btn btn-primary w-100" onclick="confirmRestore(${accomodation.content_id})">복원</button>
		                        </div>
		                        <div class="col-6 mb-3">
		                        	<button type="button" class="btn btn-outline-secondary w-100" onclick="location.href='../content/accomodation?currentPage=1'">취소</button>
		                        </div>
		                    </c:when>
							 <c:when test="${accomodation.status == 0}">
							 	<div class="col-6 mb-3" >
		                              <button type="button" class="form-control btn btn-primary w-100" onclick="approveConfirm()">승인(게시하기)</button>
		                          </div>
		                          <div class="col-3 mb-3">
		                                <button type="button" class="btn btn-outline-secondary w-100" data-bs-toggle="modal" data-bs-target="#rejectModal">반려(사유선택)</button>
		                          </div>
		                          <div class="col-3 mb-3">
		                              <button type="button" class="btn btn-outline-secondary w-100" onclick="location.href='../content/accomodation?currentPage=1'">목록</button>
		                          </div>
							 </c:when>
							 <c:when test="${accomodation.status == 1}">
							 	<div class="col-6 mb-3">
		                                <button type="button" class="form-control btn btn-primary2 w-100" onclick="location.href='../content/accomodationUpdateForm?contentId=${accomodation.content_id}&currentPage=${currentPage}'">수정하기</button>
		                             </div>
		                             <div class="col-2 mb-3">
		                                <button type="button" class="btn btn-outline-secondary w-100" onclick="approveConfirm1()">반려전환</button>
		                             </div>
		                             <div class="col-2 mb-3">
		                                <button type="button" class="btn btn-outline-secondary w-100" onclick="deleteConfirm()">삭제</button>
		                             </div>
		                          <div class="col-1 mb-3">
		                             <button type="button" class="btn btn-outline-secondary w-100" onclick="location.href='../content/accomodation?currentPage=1'">목록</button>
		                          </div>		
							 </c:when>
						</c:choose>
	                        </div>
	                     
							
						</form>
						<form name="updateForm">
								<input type="hidden" name="status" id="statusInput" value="${accomodaiton.status}">
								<input type="hidden" name="big_code" value="${accomodaiton.big_code}">
								<input type="hidden" name="small_code" value="${accomodaiton.small_code}">
								<input type="hidden" name="target_id" value="${accomodaiton.content_id}">
								<input type="hidden" name="title" id="reject-title">
								<input type="hidden" name="content" id="reject-content">
						</form>
					</div>
				</div>
				</div>
			</div>
		</main>
		</div>
		<div class="modal fade" id="rejectModal" tabindex="-1" aria-labelledby="label" aria-hidden="true">
			<div class="modal-dialog modal-dialog-centered">
				<div class="modal-content">
					<div class="modal-header">
						<h1 class="modal-title fs-5" id="modal-title">반려 전환</h1>
						<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					</div>
					<div class="modal-body">
						<div class="mb-3">
							<label class="col-form-label">반려사유</label>
							<textarea class="form-control" id="message-text"></textarea>
						</div>
					</div>
					<div class="form-row d-flex justify-content-around modal-footer">
						<button type="button" onclick="submitRejectForm(updateForm)" class="btn btn-primary col-4">반려</button>
						<button type="button" class="btn btn-outline-secondary col-4" data-bs-dismiss="modal">취소</button>
					</div>
				</div>
			</div>
			</div>
	</div>	
	</body>
</html>