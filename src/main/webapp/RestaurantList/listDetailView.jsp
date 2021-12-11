<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>맛집 플레이트 : ${ldto.getList_title()}</title>

<script src="https://code.jquery.com/jquery-3.6.0.js"
	integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk="
	crossorigin="anonymous"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />

<style>
@import url(//fonts.googleapis.com/earlyaccess/notosanskr.css);

.notosanskr * {
	font-family: 'Noto Sans KR', sans-serif;
}

* {
	box-sizing: border-box;
}

html {
	width: 100%;
	height: 100%;
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
	box-shadow: 2px 0px 2px 2px lightgrey;
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

/* */
.headerContainer {
	width: 100%;
	/* border: 1px solid grey; */
	position: relative;
	margin-top: 80px;
	margin-bottom: 100px;
}

.headDiv {
	width: 100%;
	background-color: #dfd8ca;
	margin: 0;
}

.headDiv>div {
	padding: 0;
	position: relative;
	height: 400px;
}

.headDiv>div>p {
	position: relative;
	top: 50%;
	transform: translate(0, -50%);
	text-align: center;
	color: #333;
	font-weight: bold;
	font-size: 40px;
}


/* 바디영역 */
.bodyContainer {
	width: 50%;
	margin: auto;
	height: 600px;
}

.restaurantBox {
	width: 100%;
	border: 1px solid lightgray;
	margin-bottom: 30px;
}

.restaurantBox .row {
	width: 100%;
	margin: 0;
}

.restaurantBox:hover {
	cursor: pointer;
}

.divBox1 {
	width: 100%;
	height: 30px;
	border-bottom: 1px solid lightgray;
}

.divBox2 {
	width: 100%;
	height: 30px;
	border-top: 1px solid lightgray;
}

.restContent {
	width: 100%;
	height: 200px;
}

.restaurantImgDiv {
	padding: 8px;
	height: 100%;
}

.restaurantImgDiv>img {
	width: 100%;
	height: 100%;
}

.restaurantTxtDiv {
	padding: 8px;
	height: 100%;
}

#restName {
	font-size: 30px;
	margin-bottom: 0;
	font-family: 'Noto Sans KR';
	font-weight: bold;
	color: #333;
}

#restAddress {
	color: lightgrey;
	font-family: 'Noto Sans KR';
	margin-bottom: 30px;
	font-size: 14px;
}

#restIntro {
	font-family: 'Noto Sans KR';
}
</style>
</head>

<body>
	<div class="wrapper">
		<div class="row naviBar">
			<div class="col-2 menu d-flex justify-content-center">
				<img src="${pageContext.request.contextPath}/img/plateLogo.png"
					id="logo">
			</div>
			<div class="col-2 col-md-7 menu"></div>
			<c:choose>
				<c:when test="${!empty loginSession}">
					<div class="col-2 col-md-1 menu">
						<a href="${pageContext.request.contextPath}/toTotalListView.li">맛집 리스트</a>
					</div>
					<div class="col-2 col-md-1 menu">
						<a href="#">전체 리뷰</a>
					</div>
					<div class="col-2 col-md-1 menu">
						<img src="https://cdn-icons-png.flaticon.com/512/149/149995.png"
							width="50px" height="50px" id="userPage">
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
					<div class="col-2 col-md-1 menu">
						<a href="${pageContext.request.contextPath}/toTotalListView.li">맛집 리스트</a>
					</div>
					<div class="col-2 col-md-1 menu">
						<a href="#">전체 리뷰</a>
					</div>
				</c:otherwise>
			</c:choose>

		</div>
		<div class="headerContainer">
			<div class="row headDiv">
				<div class="col-12">
					<p>${ldto.getList_title()}</p>
				</div>
			</div>
		</div>

		<div class="bodyContainer">
			<c:forEach items="${restList}" var="list">
				<div class="restaurantBox">
					<input type="text" class="d-none" value="${list.getSeq_rest()}" name="seq_rest" id="seq_rest">
					<div class="row divBox1">
						<div class="col-12"></div>
					</div>
					<div class="row restContent">
						<div class="col-4 restaurantImgDiv">
							<img src="/restFiles/${list.getSystem_name()}">
						</div>
						<div class="col-8 restaurantTxtDiv">
							<p id="restName">${list.getRest_name()}</p>
							<p id="restAddress">${list.getPostCode()} ${list.getRest_address()}</p>
							<p id="restIntro">${list.getRest_introduction()}</p>
						</div>
					</div>
					<div class="row divBox2">
						<div class="col-12"></div>
					</div>
				</div>
			</c:forEach>
		</div>
	</div>
	<script>
	<c:choose>
		<c:when test="${!empty loginSession}">
			$(".restaurantBox").on("click", function(){
				location.href = "${pageContext.request.contextPath}/toRestDetailLoginView.re?seq_rest=" + $("#seq_rest").val();
			})
		</c:when>
		<c:otherwise>
			// 로그인 안한 사용자가 맛집 클릭 시
			$(".restaurantBox").on("click", function() {
				console.log($(this));
				console.log($(this).find("input").val());
				location.href = "${pageContext.request.contextPath}/toRestDetailView.re?seq_rest=" + $("#seq_rest").val();
			})
		</c:otherwise>
	</c:choose>
						
		// 로고 클릭 시
        $("#logo").on("click", function(){
        	location.href = "/";
        })
	</script>

</body>

</html>