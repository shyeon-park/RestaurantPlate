<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css" integrity="sha512-+4zCK9k+qNFUR5X+cKL9EIR+ZOhtIloNl9GIKS57V1MyNsYpYcUrUeQc9vNfzsWfV28IaLL3i96P9sdNyeRssA==" crossorigin="anonymous" />
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

<title>검색결과 : ${searchWord}</title>
<style>
@import url(//fonts.googleapis.com/earlyaccess/notosanskr.css);

.notosanskr * {
	font-family: 'Noto Sans KR', sans-serif;
}

* {
	box-sizing: border-box;
	font-family: 'Noto Sans KR';
}

html {
	width: 100%;
	height: 100%;
	overflow-x: hidden;
}

body {
	width: 100%;
	height: 100%;
}

.wrapper {
	width: 100%;
	height: 100%;
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

/*검색창*/
.header-search {
	position: absolute;
	width: 100%;
	top: 50%;
	transform: translate(0, -50%);
	padding-left: 20px;
}

#searchBox {
	width: 100%;
	height: 60px;
	/*border: 2px solid red;*/
	border: none;
	opacity: 0.9;
	padding-left: 20px;
	position: absolut;
}

#searchIcon {
	position: absolute;
	right: 0;
	top: 50%;
	transform: translate(0, -50%);
	padding-right: 40px;
	color: red;
}

.header-search > i:hover {
	cursor: pointer;
}


#searchBox:focus {
	outline: none;
}


#searchBtn {
	position: absolute;
	height: 100%;
	width: 100px;
	top: 0;
	right: 0;
	background-color: red;
	border: 1px solid red;
}

/* section */
.section {
	padding-top: 80px;
	width: 80%;
	margin: auto;
	padding-bottom: 200px;
}

.section > .row:first-child {
	
}

.resultTxt{
	margin-top: 80px;
	margin-bottom: 80px;
}

.resultTxt > span {
	border-bottom: 2px solid black;
	font-size: 30px;
	padding-bottom: 10px;
	font-family: 'Noto Sans KR';

}

/*
.result .col-3 {
	margin-bottom: 16px;
} */

.result > .row {
	padding-bottom: 24px;
	border-bottom: 1px solid lightgray;
}

.card {
	position: relative;
}

.card:hover {
	cursor: pointer;
}

.result a {
	position: absolute;
	bottom: 0;
	right: 0;
	color: gray;
	font-size: 12px;
	margin-bottom: 4px;
	padding-right: 8px;
}

#restName {
	font-weight: bold;
}

#restAddress {
	color: gray;
	font-size: 14px;
}

.noMatching p {
	font-size: 20px;
	color: gray;
	margin-top: 50px;
}

/* footer */
.footer {
	width: 100%;
	/*height: 400px;*/
	background-color: #333;
}

.footerData {
	width: 40%;
	height: 100%;
	margin: auto;
	padding-top: 80px;
	padding-bottom: 80px;
}

.footer i {
	margin-left: 8px;
	margin-right: 8px;
	color: white;
}

.footer span {
	color: white;
	margin-bottom: 8px;
	font-family: 'Noto Sans KR'
}

.footer a {
	color: white;
	font-family: 'Noto Sans KR'
}
</style>
</head>
<body>
	<div class="wrapper">
		<div class="row naviBar">
			<div class="d-none d-md-block col-md-2 menu">
				<img src="${pageContext.request.contextPath}/img/plateLogo.png"
					id="logo">
			</div>
			<div class="col-10 col-md-7 menu">
				<form action="${pageContext.request.contextPath}/toSearchRest.re" method="post" id="searchForm">
					<div class="header-search">
						<input type="text" id="searchBox" placeholder="맛집명 또는 주소 검색" name="searchWord" value="">
						<i class="fas fa-search fa-2x" id="searchIcon"></i>
					</div>
				</form>
			</div>
			<c:choose>
				<c:when test="${!empty loginSession}">
					<div class="d-none d-md-block col-md-1 menu">
						<a href="${pageContext.request.contextPath}/toTotalListView.li">맛집 리스트</a>
					</div>
					<div class="d-none d-md-block col-md-1 menu">
						<a href="/view.vi?currentPage=1">전체 리뷰</a>
					</div>
					<div class="col-2 col-md-1 menu">
						<img src="https://cdn-icons-png.flaticon.com/512/149/149995.png"
							width="50px" height="50px" id="userPage" onclick=showModal()>
					</div>
				</c:when>

				<c:otherwise>
					<c:if test="${rs eq 'fail'}">
						<script type="text/javascript">
							alert("아이디 혹은 비밀번호를 잘못 입력 하였습니다.")
						</script>
					</c:if>

					<div class="col-2 col-md-1 menu">
						<a href="${pageContext.request.contextPath}/login.mem">로그인</a>
					</div>

					<!-- <div class="col-2 col-md-1 menu d-flex justify-content-start">
						<a href="${pageContext.request.contextPath}/signup.mem">회원가입</a>
					</div> -->
					<div class="d-none d-md-block col-md-1 menu">
						<a href="${pageContext.request.contextPath}/toTotalListView.li">맛집 리스트</a>
					</div>
					<div class="d-none d-md-block col-md-1 menu">
						<a href="/view.vi?currentPage=1">전체 리뷰</a>
					</div>
				</c:otherwise>
			</c:choose>
		</div>
		<script>
			$("#searchIcon").on("click", function(){
				if($("#searchBox").val() == "") {
					alert("검색어를 입력해주세요.");
					return;
				}
				$("#searchForm").submit();
			})
			
			$("#searchBox").keydown(function(key) {
				
				if(key.keycode == 13) {
					alert("엔터키");
				}
			})


		</script>
		
		
		
		<div class="section">
			<div class="row">
				<div class="col-12 resultTxt">
					<span>'${searchWord}'에 대한 검색결과</span>
				</div>
			</div>
			<c:choose>
				<c:when test="${! empty dto}">
					<div class="result">
						<div class="row" style="padding-left: 16px; padding-right: 16px;">
							<c:forEach items="${dto}" var="rsDto">
								<div class="col-6 col-md-3 d-flex justify-content-center">
        			 				<div class="card restCard" style="width: 18rem;">
  										<img src="/restFiles/${rsDto.getSystem_name()}" class="card-img-top" alt="${rsDto.getRest_name()}" style="width: 100%; height: 250px;">
  										<div class="card-body">
    									<p class="card-text" id="restName">${rsDto.getRest_name()}</p>
    									<p class="card-text" id="restAddress">${rsDto.getRest_address()}</p>
    									<input type="text" class="d-none" id="seq_rest" value="${rsDto.getSeq_rest()}">
    									<c:choose>
    										<c:when test="${!empty loginSession}">
    											<a href="${pageContext.request.contextPath}/toRestDetailLoginView.re?seq_rest=${rsDto.getSeq_rest()}">상세정보 보기</a>
    										</c:when>
    										<c:otherwise>
    											<a href="${pageContext.request.contextPath}/toRestDetailView.re?seq_rest=${rsDto.getSeq_rest()}">상세정보 보기</a>
    										</c:otherwise>
    									</c:choose>		
  										</div>
									</div>
								</div>
							</c:forEach>
						</div>
					</div>
				</c:when>
				<c:otherwise>
					<div class="noMatching">
						<p>
							<span style="color: red;">'${searchWord}'</span>에 대한 검색결과를 찾을 수 없습니다. 다시 검색해주세요.</p>
					</div>
				</c:otherwise>
			</c:choose>
			<c:choose>
				<c:when test="${!empty loginSession}">
					<script>
						$(".restCard").on("click", function(){
							console.log($(this));
							let seq_rest = $(this).find("input").val();
							console.log(seq_rest);
							location.href = "${pageContext.request.contextPath}/toRestDetailLoginView.re?seq_rest=" + seq_rest;
						})
					</script>
				</c:when>
				<c:otherwise>
					<script>
						$(".restCard").on("click", function(){
							let seq_rest = $(this).find("input").val();
							console.log(seq_rest);
							location.href = "${pageContext.request.contextPath}/toRestDetailView.re?seq_rest=" + seq_rest;
						})
					</script>
				</c:otherwise>
			</c:choose>	
		</div>
		
		
		
		
		<div class="footer">
			<div class="footerData">
				<div class="row" style="margin-bottom: 80px;">
					<div class="col-12 d-flex justify-content-center">
						<i class="fab fa-instagram-square fa-5x"></i>
						<i class="fab fa-facebook fa-5x"></i>
						<i class="fab fa-twitter-square fa-5x"></i>
						<i class="fab fa-line fa-5x"></i>
					</div>
				</div>
				<div class="row">
					<div class="col-12 d-flex justify-content-center">
						<span style="font-size: 20px;"><a href="/">InFo</a> · <a href="/">Support</a> · <a href="/">Marketing</a></span>
					</div>
					<div class="col-12 d-flex justify-content-center">
						<span style="font-size: 20px;"><a href="/">Terms of Use</a> · <a href="/">Privacy Policy</a></span>
					</div>
					<div class="col-12 d-flex justify-content-center">
						<span>서울특별시 강남구 ooo로 ooo, ooo타워</span>
					</div>
					<div class="col-12 d-flex justify-content-center">
						<span>고객센터: 02-000-0000</span>
					</div>
					<div class="col-12 d-flex justify-content-center">
						<span style="color: grey;">© 2021 kh 3, Restaurant exploration team. All rights reserved.</span>
					</div>
					
				</div>
			</div>
		</div>
	</div>
	<script>
		// 로고 클릭 시
		$("#logo").on("click", function(){
    		location.href = "/";
   		})
   		
	</script>
</body>
</html>