<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/components/AdminHeader.jsp" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>회원 태그</title>
		<script src="http://code.jquery.com/jquery-latest.min.js"></script>
		<script type="text/javascript">
		   $(document).ready(function() {			   
			   $.ajax(
					   {
						   method:"POST",
						   url:"<%=request.getContextPath()%>/admin/tag/getUserTags",
						   dataType:'json',
						   success:function(listTags) {
							   
							   for(let i = 0; i < ${page.end - page.start + 1}; i++) {
								   var str = "";
								   for(let j = 0; j < listTags.length; j++) {
									   if(listTags[j].user_id == $("#user_id"+i).val()) {
										   str += "<span class='badge text-bg-primary'>"+listTags[j].name+"</span>";
										   str += " ";
									   }
								   }	   
								   $("#tag_name"+i).append(str);   
							   }
						   }
					   }
				)
		   })
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
					<label  class="admin-header-title ">회원태그</label>
					</div>
				</div>
		
				<!-- Section2: Search Form -->		
				<div class="container col-9 justify-content-center my-5">
					<form action="userTag">
						<div class="col-12 my-4 d-flex align-items-center">
							<label for="searchType" class="form-label col-2  mx-2">검색어</label>
								<div class="col-4">
									<select name="searchType" class="form-select">
										<option value="tagname">태그명</option>
										<option value="email">회원ID</option>
									</select>
								</div>
								<div class="col-5 mx-2">
					                <input type="text" name="keyword" class="form-control" value="${keyword}"
					                placeholder="검색어를 입력하세요.">
				                </div>
				        </div>
						
						<div class="container col-10 d-flex justify-content-center">					
							<button type="submit" class="btn btn-primary  col-2 mx-3">검색</button>
							<button type="reset" class="btn btn-outline-secondary col-2 mx-3">초기화</button>
						</div>
					</form>
				</div>
				
				<!-- Section3: Table -->		
				<div class="container col-9 justify-content-center my-2 border p-2">
					<table class="table table-striped table-sm text-center mb-2">
						<thead>
							<tr>
								<th scope="col">순번</th>
								<th scope="col">회원ID</th>
								<th scope="col">이름</th>
								<th scope="col">닉네임</th>
								<th scope="col">생년월일</th>
								<th scope="col">성별</th>
								<th scope="col">주소</th>
								<th scope="col">태그명</th>
							</tr>
						</thead>
						<tbody>
							<c:set var="num" value="${page.start}"/>
							<c:forEach var="user" items="${listUsers}" varStatus="st">
								<tr>
									<td>${num}</td>
									<td><input type="hidden" id="user_id${st.index}" value="${user.id}">${user.email}</td>
									<td>${user.name}</td>
									<td>${user.nickname}</td>
									<td>${user.birthday}</td>
									<td>
										<c:if test="${user.gender == 0}">남</c:if>
										<c:if test="${user.gender == 1}">여</c:if>
									</td>
									<td>${user.address}</td>
									<td id="tag_name${st.index}"></td>
								</tr>
								<c:set var="num" value="${num + 1}"/>
							</c:forEach>
						</tbody>
					</table>
					<p>총 건수 : ${totalUsers}</p>
				</div>
				
				<nav aria-label="Page navigation example ">
					<ul class="pagination">
						<c:if test="${page.startPage > page.pageBlock}">
							<li class="page-item">
								<a href="userTag?currentPage=${page.startPage-page.pageBlock}" class="pageblock page-link">Prev</a>
							</li>
						</c:if>
						<c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
							<li class="page-item">
								<a href="userTag?currentPage=${i}" class="pageblock page-link ${page.currentPage == i ? 'active':'' }">${i}</a>
							</li>
						</c:forEach>
						<c:if test="${page.endPage < page.totalPage}">
							<li class="page-item">
								<a href="userTag?currentPage=${page.startPage+page.pageBlock}" class="pageblock page-link">Next</a>
							</li>
						</c:if>
					</ul>
				</nav>
						
			</main>
		</div>
		</div>
	</body>
</html>