<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>맛집 플레이트 : 전체 리스트 더보기</title>

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
	font-family: 'Noto Sans KR';
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
/* 헤드 영역 */
.headerContainer {
	width: 100%;
	margin-top: 80px;
	margin-bottom: 80px;
}

.headDiv {
	width: 100%;
	/*background-color: #f1f7e7;*/
	margin: 0;
}

.headDiv>div {
	padding: 0;
	height: 400px;
	position: relative;
}

.headDiv>div>p {
	position: absolute;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	color: whitesmoke;
	font-weight: bold;
	font-size: 40px;
}


/* 리스트 목록 영역 */
.bodyContainer {
	width: 80%;
	margin: auto;
}

.viewList {
	width: 100%;
	margin: auto;
}

.viewList>.col-4 {
	border-bottom: 1px solid lightgrey;
}

.listBox {
	height: 200px;
	position: relative;
	margin-top: 30px;
	margin-bottom: 30px;
	transition-duration: 1.5s;
}

.listBox:hover {
	cursor: pointer;
	transform: scale(1.1);
}

.listBox>img {
	position: absolute;
	width: 100%;
	height: 100%;
	opacity: 0.8;
}

.listBox>p {
	position: absolute;
	font-weight: bold;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	text-align: center;
	font-size: 20px;
	color: white;
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
					<img src="${pageContext.request.contextPath}/img/random/${random}" style="width: 100%; height: 100%">
					<p>맛집 리스트 전체목록</p>
				</div>
			</div>
		</div>

		<div class="bodyContainer">
			<div class="row viewList">
				<c:forEach items="${list}" var="listDto">
					<div class="col-4">
						<div class="listBox">
							<img src="/listFiles/${listDto.getSystem_name()}">
							<p>${listDto.getList_title()}</p>
							<input type="text" class="d-none"
								value="${listDto.getSeq_list()}">
						</div>
					</div>
				</c:forEach>
			</div>
		</div>
	</div>
	<script>
		// 리스트 박스 클릭 시
		$(".listBox").on("click", function() {
			console.log($(this).find("input").val());
			location.href = "${pageContext.request.contextPath}/toRestaurnatList.re?seq_list="
							+ $(this).find("input").val();		
		})
						
		// 로고 클릭 시
        $("#logo").on("click", function(){
        	location.href = "/";
        })
	</script>
</body>
</html>