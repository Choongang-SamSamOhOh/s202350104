<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/components/AdminHeader.jsp" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>코스 태그</title>
		<link href="/css/adminTable.css" rel="stylesheet" type="text/css">
		<style type="text/css">
			.badge {
				color: white !important;
				background-color: #FF4379 !important;
			}
			
			.nav-menu {
				background-color: #b7e24d !important;
				border: none;
			}
		</style>
		
		<script src="http://code.jquery.com/jquery-latest.min.js"></script>
		<script src="/js/updateArea.js"></script>
		<script type="text/javascript">
			document.addEventListener("DOMContentLoaded", function() {	
				const urlParams = new URL(location.href).searchParams;
				const smallCodeStr = urlParams.get('smallCodeStr');
			   // 행별로 저장된 태그를 가져와서 뱃지로 표시
			   $.ajax({
						   method:"POST",
						   url:"<%=request.getContextPath()%>/admin/tag/getCourseTags",
						   data:{smallCodeStr : smallCodeStr},
						   dataType:'json',
						   success:function(listTags) {
							   for(let i = 0; i < ${page.end - page.start + 1}; i++) {
								   var str = "";
								   for(let j = 0; j < listTags.length; j++) {
									   if(listTags[j].course_id == $("#course_id"+i).val()) {
										   str += "<span class='badge text-bg-primary'>"+listTags[j].name+"</span>";
										   str += " ";
									   }
								   }	   
								   $("#tag_name"+i).append(str);   
							   }
						   }
					   })
		   });
			
			
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
						<i class="title-bi bi bi-grid-fill "></i>
					<label  class="admin-header-title ">코스태그</label>
					</div>
				</div>
		
				<!-- Section2: Search Form -->		
				<div class="container col-9 justify-content-center my-5">
					<form action="courseTag" method="GET" class="container justify-content-center">
						<input type="hidden" name="smallCodeStr" value="${smallCode}">
						<div class="col-12 my-4 d-flex align-items-center">
							<label for="searchType" class="col-form-label col-1  mx-2">검색어</label>
							<div class="col-2">
								<select name="searchType" class="form-select">
									<option value="tag_name">태그명</option>
									<option value="title">코스명</option>
									<option value="course_id">코스번호</option>
								</select>
							</div>
							<div class="col-6 mx-1">
					        	<input type="text" name="keyword" class="form-control" value="${keyword}"
					             placeholder="검색어를 입력하세요.">
				            </div>
							<div class="col-5 mx-1 d-flex justify-content-start">					
								<button type="submit" class="btn btn-primary  col-2 mx-1">검색</button>
								<button type="reset" class="btn btn-outline-secondary col-2 mx-1">초기화</button>
							</div>
						</div>
					</form>				
				</div>		
				
				<!-- Section3: Table -->		
				<div class="container col-9 justify-content-center align-items-center mb-2 p-3 pt-0">
					<div class="container col-10 d-flex justify-content-center p-0">
						<button type="button" class="btn btn-primary nav-menu col-2 mx-1" onclick="location.href='courseTag?smallCodeStr=1'">가족코스</button>
						<button type="button" class="btn btn-primary nav-menu col-2 mx-1" onclick="location.href='courseTag?smallCodeStr=2'">나홀로코스</button>
						<button type="button" class="btn btn-primary nav-menu col-2 mx-1" onclick="location.href='courseTag?smallCodeStr=3'">힐링코스</button>
						<button type="button" class="btn btn-primary nav-menu col-2 mx-1" onclick="location.href='courseTag?smallCodeStr=4'">도보코스</button>
						<button type="button" class="btn btn-primary nav-menu col-2 mx-1" onclick="location.href='courseTag?smallCodeStr=5'">캠핑코스</button>
						<button type="button" class="btn btn-primary nav-menu col-2 mx-1" onclick="location.href='courseTag?smallCodeStr=6'">맛코스</button>
					</div>
					<div class="container table-container mt-1 p-4">
					<div class="table-responsive">
						<table id="userTable" class="table table-md text-center p-3">
							<thead>
								<tr>
									<th scope="col">순번</th>
									<th scope="col">코스번호</th>
									<th scope="col">이름</th>
									<th scope="col">지역</th>
									<th scope="col">태그명</th>
									<th scope="col">상세</th>
									<th scope="col"></th>
								</tr>
							</thead>
							<tbody>
								<c:set var="num" value="${page.start}"/>
								<c:forEach var="course" items="${listCourse}" varStatus="st">
									<tr>
										<td>${num}</td>
										<td><input type="hidden" id="course_id${st.index}" value="${course.course_id}">${course.course_id}</td>
										<td>${course.title}</td>
										<td>${course.area_content} ${course.sigungu_content}</td>
										<td id="tag_name${st.index}"></td>
										<td><a href="../course/courseUpdateForm?id=${course.course_id}" class="detail-link">이동</a></td>
										<td><a href="courseTagsUpdateForm?courseIdStr=${course.course_id}" class="detail-link">관리</a></td>
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
								<a href="courseTag?currentPage=${page.startPage-page.pageBlock}&smallCodeStr=${smallCode}" class="pageblock page-link">Prev</a>
							</li>
						</c:if>
						<c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
							<li class="page-item">
								<a href="courseTag?currentPage=${i}&smallCodeStr=${smallCode}" class="pageblock page-link ${page.currentPage == i ? 'active':''}">${i}</a>
							</li>
						</c:forEach>
						<c:if test="${page.endPage < page.totalPage}">
							<li class="page-item">
								<a href="courseTag?currentPage=${page.startPage+page.pageBlock}&smallCodeStr=${smallCode}" class="pageblock page-link">Next</a>
							</li>
						</c:if>
					</ul>
				</nav>
					
			</main>
		</div>
		</div>
	</body>
</html>