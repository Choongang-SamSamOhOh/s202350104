<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/components/AdminHeader.jsp" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>축제 관리</title>
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
						$(".sigungu-dropdown").empty().append("<option value='0'>시군구</option>");
					}
				});
			});
			
			function reset() {
				document.getElementById('searchType').value = null;
				document.getElementById('keyword').value = null;
				document.getElementById('area').value = null;
				document.getElementById('sigungu').value = null;
				document.getElementById('status').value = null;
				document.getElementById('is_deleted').value = null;
			}
			
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
						<i class="title-bi bi bi-pencil-square "></i>
						<label class="admin-header-title ">축제 정보 관리 </label>					
					</div>
				</div>
		
				<!-- Section2: Search Form -->		
				<div class="container col-9 justify-content-center mt-5">
					<form action="festival" method = "get" class="container justify-content-center">
						<div class="col-12 my-4 d-flex align-items-center">
							<label for="searchType" class="col-form-label col-1  mx-2">검색어</label>
				               <div class="col-4">
					              <select id="searchType" name="searchType" class="form-select">
						              <option value="s_title" ${searchType == 's_title'? 'selected':''}>축제명</option>
									  <option value="s_content" ${searchType == 's_content'? 'selected':''}>내용</option>
									  <option value="s_sponsor" ${searchType == 's_sponsor'? 'selected':''}>주최자</option>
									  <option value="s_eventplace" ${searchType == 's_eventplace'? 'selected':''}>장소</option>
					              </select>
				                </div>
				                <div class="col-5 mx-2">
					                <input type="text" name="keyword" class="form-control" value="${keyword}"
					                 placeholder="검색어를 입력하세요.">
				                </div>
				        </div>
				            
				            <div class="col-12 my-4 d-flex align-items-center">
				            	<label for="searchType" class="col-form-label col-1  mx-2">테마</label>
				            		<div class="col-2 d-flex align-items-center">
				            			<select id="searchType" class="form-select" name="small_code">
											<option value="0" selected>전체</option>
											<c:forEach var="theme" items="${listCodes}">
												<c:if test="${theme.big_code == 11 && theme.small_code != 999 }">
													<option value="${theme.small_code}" ${theme.small_code == small_code? 'selected':''}>${theme.content}</option>
												</c:if>
											</c:forEach>
										</select>
				            		</div>
				            	<div class="col-1"></div>
					            <label for="searchType" class="col-form-label col-1  mx-2">지역</label>
					            	<div class="col-2 d-flex align-items-center">
										<select name="area" id="area" class="area-dropdown form-select"></select>
									</div>
									<div class="col-2 mx-2 d-flex align-items-center">
										<select name="sigungu" id="sigungu" class="sigungu-dropdown form-select"></select><p>
									</div>
							</div>
							
							<div class="col-12 my-4 d-flex align-items-center">
								<label for="searchType" class="col-form-label col-1  mx-2">승인여부</label>
									<div class="col-2 d-flex align-items-center">
										<select name="status" id="status" class="form-select">
											<option value = "" selected>전체</option>
											<option value = "0" ${status == '0'? 'selected':''}>승인대기</option>
											<option value = "1" ${status == '1'? 'selected':''}>승인완료</option>
											<!-- <option>승인반려</option> -->
										</select>
									</div>
								<div class="col-1"></div>
								<label for="searchType" class="col-form-label col-1  mx-2">게시여부</label>
									<div class="col-2 mx-2 d-flex align-items-center">
										<select name="is_deleted" id="is_deleted" class="form-select">
											<option value = "" selected>전체</option>
											<option value = "0" ${is_deleted == '0'? 'selected':''}>Y</option>
											<option value = "1" ${is_deleted == '1'? 'selected':''}>N</option>
										</select><p>
									</div>
							</div>
								
							<div class="container col-10 d-flex justify-content-center">
								<button type="submit" class="btn btn-primary  col-2 mx-3">검색</button>
								<button type="reset"  class="btn btn-outline-secondary col-2 mx-3" onclick="reset()">초기화</button>
							</div>
					</form>
				</div>		
				
				<!-- Section3: Table -->		
				<div class="container col-9 justify-content-center align-items-center mb-2 p-3 pt-0">
					<div class="container d-flex justify-content-end p-0">
						<button id="regist-btn" type="button" class="btn btn-primary btn-sm mb-4" onclick="location.href='festivalInsertForm'">등록</button>
					</div>
					<div class="container table-container p-4">
						<div class="table-responsive">
							<table id="userTable" class="table table-md text-center p-3">
								<thead>
									<tr>
										<th scope="col">순번</th>
										<th scope="col">지역</th>
										<th scope="col">축제명</th>
										<th scope="col">주최자</th>
										<th scope="col">등록일</th>
										<th scope="col">승인여부</th>
										<th scope="col">게시</th>
										<th scope="col"></th>
									</tr>
								</thead>
								<tbody>
									<c:if test="${listFestivals.size() == 0}"><td colspan="8">해당하는 축제 정보가 없습니다.</td></c:if>
									
									<c:set var="num" value="${page.start}"/>
									<c:forEach var="festival" items="${listFestivals}" varStatus="st">				
										<tr id="festival${st.index}">
											<td><input type="hidden" value="${festival.content_id}" id="id${st.index}">${num}</td>
											<td>${festival.area_content} ${festival.sigungu_content}</td>
											<td>${festival.title}</td>
											<td>${festival.sponsor}</td>
											<td><fmt:formatDate value="${festival.created_at}" type="date" pattern="YY/MM/dd"/></td>
											<td>
												<c:if test="${festival.status == 0}">승인대기</c:if>
												<c:if test="${festival.status == 1}">승인완료</c:if>
											</td>
											<td>
												<c:if test="${festival.is_deleted == 0}">Y</c:if>
												<c:if test="${festival.is_deleted == 1}">N</c:if>
											</td>
											<td><a class="detail-btn" href="festivalDetail?contentIdStr=${festival.content_id}&currentPage=${page.currentPage}">관리</a></td>
										</tr>
										<c:set var="num" value="${num + 1}"/>
									</c:forEach>
								</tbody>
							</table>
						</div>
					</div>	
				</div>
					
				<nav aria-label="Page navigation example ">
					<ul class="pagination">
						<c:if test="${page.startPage > page.pageBlock}">
							<li class="page-item">
								<a href="festival?currentPage=${page.startPage-page.pageBlock}&searchType=${searchType}&keyword=${keyword}&small_code=${small_code}&area=${area}&sigungu=${sigungu}&status=${status}&is_deleted=${is_deleted}"
								 class="pageblock page-link">Prev</a>
							</li>
						</c:if>
						<c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
							<li class="page-item">
								<a href="festival?currentPage=${i}&searchType=${searchType}&keyword=${keyword}&small_code=${small_code}&area=${area}&sigungu=${sigungu}&status=${status}&is_deleted=${is_deleted}"
								 class="pageblock page-link ${page.currentPage == i ? 'active':'' }">${i}</a>
							</li>
						</c:forEach>
						<c:if test="${page.endPage < page.totalPage}">
							<li class="page-item">
								<a href="festival?currentPage=${page.startPage+page.pageBlock}&searchType=${searchType}&keyword=${keyword}&small_code=${small_code}&area=${area}&sigungu=${sigungu}&status=${status}&is_deleted=${is_deleted}"
								 class="pageblock page-link">Next</a>
							</li>
						</c:if>
					</ul>
				</nav>
			</main>
		</div>
		</div>
	</body>
</html>