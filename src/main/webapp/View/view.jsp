<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css"
	integrity="sha512-+4zCK9k+qNFUR5X+cKL9EIR+ZOhtIloNl9GIKS57V1MyNsYpYcUrUeQc9vNfzsWfV28IaLL3i96P9sdNyeRssA=="
	crossorigin="anonymous" />
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />
<title>전체 리뷰</title>
<style>
.container {
	width: 90%;
	padding: 10px;
}

th, td {
	text-align: center;
}

td:nth-child(2) {
	text-align: left;
}

a {
	text-decoration: none;
	font-weight: bold;
	color: black;
}

.boxBtn-top {
	margin: 20px;
	width: 90%;
	text-align: right;
}

.boxBtn-bottom {
	margin: 20px;
	width: 90%;
	text-align: right;
}

/*네비*/
.naviBar {
	position: fixed;
	width: 100%;
	margin: 0;
	top: 0;
	z-index: 1;
	height: 80px;
	background-color: white;
	box-shadow: 2px 2px 4px 0px lightgrey;
	/* opacity: 0.8; */
}

.menu {
	position: relative;
	height: 100%;
	/* border: 1px solid grey; */
	/* position: relative; */
}

.menu:first-child {
	padding: 8px;
}

#logo {
	width: 100%;
	height: 100%;
	cursor: pointer;
}

.menu>a {
	color: grey;
	font-size: 16px;
	font-weight: bold;
	position: absolute;
	top: 50%;
	transform: translate(0, -50%);
}

.menu>img {
	position: absolute;
	top: 50%;
	transform: translate(0, -50%);
}

.menu>img:hover {
	cursor: pointer;
}

a:link {
	text-decoration: none;
}

/* modal */
.searchModal {
	display: none;
	/* Hidden by default */
	position: fixed;
	/* Stay in place */
	z-index: 10;
	/* Sit on top */
	left: 0;
	top: 0;
	width: 100%;
	/* Full width */
	height: 100%;
	/* Full height */
	overflow: auto;
	/* Enable scroll if needed */
	background-color: rgb(0, 0, 0);
	/* Fallback color */
	background-color: rgba(0, 0, 0, 0.4);
	/* Black w/ opacity */
}
/* Modal Content/Box */
.search-modal-content {
	background-color: #fefefe;
	position: fixed;
	top: 80px;
	right: 0px;
	/* 15% from the top and centered */
	padding: 20px;
	width: 350px;
	/* Could be more or less, depending on screen size */
}

#modal-body {
	height: 300px
}

/*로그아웃*/
#logoutBtn {
	text-decoration: none;
	cursor: pointer;
}
</style>
</head>
<body>
	<div id="modalMypage" class="searchModal">
		<div class="search-modal-content">
			<div id=slideContainer>
				<div class="d-flex justify-content-around">
					<div class="col-6 idSea d-flex justify-content-center m-0">${loginSession.get("nickname")}님
						안녕하세요</div>
				</div>
				<div class="album">
					<div class="searchIdContiner">
						<div class="row" id="header">
							<div class="d-flex justify-content-around align-items-center">
								<div class="col d-flex justify-content-center">최근 본 맛집</div>
								<div class="col d-flex justify-content-center">격하게 가고싶다!</div>
							</div>
						</div>
						<div class="row" id="modal-body"></div>
						<div class="row" id="modal-footer">
							<div class="col d-flex justify-content-end">
								<a class="" href="${pageContext.request.contextPath}/mypage.mem">내정보</a>
								<a class="ms-4" id="logoutBtn" onclick=kakaoLogout()>로그아웃</a>

							</div>


						</div>

						<button id=btnModal onclick=closeModal()>닫기</button>
					</div>
				</div>

			</div>

		</div>
	</div>
	<script>
        let modal = document.getElementById("modalMypage")
        function showModal() {
            $("#modalMypage").show();
        }
        function closeModal() {
            $('.searchModal').hide();
        };
        window.addEventListener('click', (e) => {
            e.target === modal ? $('.searchModal').hide() : false
        })
    </script>
	<div class="row naviBar">
		<div class="col-2 menu d-flex justify-content-center">
			<img src="${pageContext.request.contextPath}/img/plateLogo.png"
				id="logo">
		</div>

		<c:choose>
			<c:when test="${!empty loginSession}">

				<c:choose>
					<c:when test="${loginSession.identification eq '1'}">
						<div class="d-none d-md-block col-md-6 menu"></div>
						<div class="col-1 col-md-1 menu">
							<a
								href="${pageContext.request.contextPath}/manager/managerIndex.jsp">관리자페이지</a>
						</div>
						<div class="col-1 col-md-1 menu">
							<a href="${pageContext.request.contextPath}/toTotalListView.li">맛집리스트</a>
						</div>
						<div class="col-1 col-md-1 menu">
							<a href="/view.vi?currentPage=1">전체 리뷰</a>
						</div>
						<div class="col-1 col-md-1 menu">
							<img src="https://cdn-icons-png.flaticon.com/512/149/149995.png"
								width="50px" height="50px" id="userPage" onclick=showModal()>

						</div>
					</c:when>

					<c:otherwise>
						<!-- 사용자일때 -->
						<div class="d-none d-md-block col-md-7 menu"></div>
						<div class="col-3 col-md-1 menu">
							<a href="${pageContext.request.contextPath}/toTotalListView.li">맛집리스트</a>
						</div>
						<div class="col-3 col-md-1 menu">
							<a href="/view.vi?currentPage=1">전체 리뷰</a>
						</div>
						<div class="col-3 col-md-1 menu">
							<img src="https://cdn-icons-png.flaticon.com/512/149/149995.png"
								width="50px" height="50px" id="userPage" onclick=showModal()>
						</div>
					</c:otherwise>
				</c:choose>

			</c:when>
			<c:otherwise>
				<div class="d-none d-md-block col-md-7 menu"></div>
				<c:if test="${rs eq 'fail'}">
					<script type="text/javascript">
						alert("아이디 혹은 비밀번호를 잘못 입력 하였습니다.")
						</script>
				</c:if>
				<div class="col-3 col-md-1 menu">
					<a href="${pageContext.request.contextPath}/login.mem">로그인</a>
				</div>
				<div class="col-3 col-md-1 menu">
					<a href="${pageContext.request.contextPath}/toTotalListView.li">맛집
						리스트</a>
				</div>
				<div class="col-3 col-md-1 menu">
					<a href="/view.vi?currentPage=1">전체 리뷰</a>
				</div>
			</c:otherwise>
		</c:choose>

	</div>

	<div class="container">
		<div class="row">
			<div class="col-12 mb-5 d-flex justify-content-center">
				<h3>전체 리뷰</h3>
			</div>
		</div>
		<table class="table table-bordered">
			<thead>
				<tr>
					<th class="col-md-5">음식점 이름</th>
					<th class="col-md-3">글쓴이</th>
					<th class="col-md-2">작성일</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${list}" var="dto">
					<tr>
						<td><a
							href="${pageContext.request.contextPath}/toRestDetailView.re?seq_rest=${dto.getRest_name()}&currentPage=${naviMap.get('currentPage')}">${dto.getRest_name()}</a></td>
						<td><a
							href="${pageContext.request.contextPath}/toRestDetailView.re?seq_rest=${dto.getSeq_rest()}">${dto.getRest_name()}</a></td>
						<td>${dto.getUser_id()}</td>
						<td>${dto.getReview_date()}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<div class="row">
			<nav class="col" aria-label="Page navigation example">
				<ul class="pagination justify-content-center">
					<c:if test="${naviMap.get('needPrev') eq true}">
						<li class="page-item"><a class="page-link"
							href="${pageContext.request.contextPath}/view.vi?currentPage=${naviMap.get('startNavi')-1}">Previous</a></li>
					</c:if>
					<!--startNavi ->endNavi  -->
					<c:forEach var="i" begin="${naviMap.get('startNavi')}"
						end="${naviMap.get('endNavi')}">
						<li class="page-item"><a class="page-link"
							href="${pageContext.request.contextPath}/view.vi?currentPage=${i}">${i}</a></li>
					</c:forEach>
					<c:if test="${naviMap.get('needNext') eq true}">
						<li class="page-item"><a class="page-link"
							href="${pageContext.request.contextPath}/view.vi?currentPage=${naviMap.get('endNavi')+1}">Next</a></li>
					</c:if>
				</ul>
			</nav>
		</div>
	</div>
	<div class="boxBtn-bottom">
		<button class="btn btn-success" id="btnHome" type="button">홈으로</button>
	</div>

	<script>
    	// 홈으로
    	document.getElementById("btnHome").addEventListener("click", function(e){
    		location.href = "/";
    	});
    	
    	// 로고 클릭 시
        $("#logo").on("click", function(){
        	location.href = "/";
        })
        
       </script>

	<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
	<!-- 카카오 cdn -->
	<script>
         $("#logoutBtn").click(function () {
        	 setTimeout(function() {
			location.href = "${pageContext.request.contextPath}/logoutProc.mem";
        	 }, 100);
		})
         
        	
        	
         Kakao.init('f5b85acc6a4af9096ab0fcf1ad929c7c'); //발급받은 키 중 javascript키를 사용해준다.
         console.log(Kakao.isInitialized()); // sdk초기화여부판단
   		   function kakaoLogout() { // 카카오 로그아웃 함수
	        if (!Kakao.Auth.getAccessToken()) {
	        	console.log('로그인되어있지않습니다.')
	          return
	        }
	        Kakao.Auth.logout(function() {
	          console.log('로그아웃완료')
	        })
	      }
        
        
    </script>
</body>
</html>