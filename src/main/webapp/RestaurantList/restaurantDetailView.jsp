<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Document</title>

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
* {
	box-sizing: border-box;
}

.wrapper {
	width: 100%;
	height: 4000px;
}

/* 메인 페이지 헤더부분 */
.headerContainer {
	width: 100%;
	margin-bottom: 100px;
}

/*네비*/
.naviBar {
	position: fixed;
	width: 100%;
	height: 80px;
	margin: 0;
	top: 0;
	background-color: white;
	box-shadow: 0px 0px 2px 2px lightgrey;
	z-index: 111;
	/* opacity: 0.8; */
}

.menu {
	height: 100%;
	/* border: 1px solid grey; */
	position: relative;
	float: left;
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
	position: absolute;
	top: 50%;
	transform: translate(0, -50%);
	font-size: 16px;
	font-weight: bold;
}

a:link {
	text-decoration: none;
}

/* */
.headDiv {
	width: 100%;
	height: 300px;
	background-color: #f1f7e7;
	margin: 0;
}

.headDiv>div {
	padding: 0;
	position: relative;
}

.headDiv>div>p {
	position: relative;
	top: 60%;
	transform: translate(0, -50%);
	text-align: center;
	color: #333;
	font-weight: bold;
	font-size: 40px;
}

/* 바디 영역 */
.bodyContainer {
	width: 100%;
}

.restDetailBox {
	width: 90%;
	margin: auto;
}

.mapDiv {
	padding: 12px;
}

.restInfoBox {
	padding: 12px;
}

.restInfoBox>p:first-child {
	padding-bottom: 12px;
	border-bottom: 1px solid lightgray;
	font-size: 30px;
	font-weight: bold;
}
</style>
</head>

<body>
	<div class="wrapper">
		<div class="headerContainer">
			<div class="row naviBar">
				<div class="col-2 menu d-flex justify-content-center">
					<img src="img/logo.png" id="logo">
				</div>
				<div class="col-2 col-md-6 menu"></div>
				<div class="col-2 col-md-1 menu d-flex justify-content-start">
					<a href="#">로그인</a>
				</div>
				<div class="col-2 col-md-1 menu d-flex justify-content-start">
					<a href="#">회원가입</a>
				</div>
				<div class="col-2 col-md-1 menu d-flex justify-content-start">
					<a href="#">맛집 리스트</a>
				</div>
				<div class="col-2 col-md-1 menu d-flex justify-content-start">
					<a href="#">전체 리뷰</a>
				</div>
			</div>
			<div class="row headDiv">
				<div class="col-12">
					<p>맛집이름</p>
				</div>
			</div>
		</div>

		<div class="bodyContainer">
			<div class="row restDetailBox">
				<div class="col-5 d-none d-md-block mapDiv">
					<div id="map" style="width: 500px; height: 400px;"></div>
				</div>
				<div class="col-7 restInfoBox">
					<p>맛집이름</p>
					<p>맛집소개</p>
					<p>맛집주소</p>
					<p>맛집전화번호</p>
					<p>맛집영업시간</p>
					<p>주차</p>
					<input type="text" class="form-control" value="100">
				</div>
			</div>
		</div>
	</div>

	<script type="text/javascript"
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=3f2fbb32fd1900763f10f59745f3b5f1"></script>
	<script>
		var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
		var options = { //지도를 생성할 때 필요한 기본 옵션
			center : new kakao.maps.LatLng(37.213297511073065,
					127.04461056874126), //지도의 중심좌표.
			level : 3
		//지도의 레벨(확대, 축소 정도)
		};

		var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴

		let btnZoomIn = document.getElementById("btnZoomIn");
		let btnZoomOut = document.getElementById("btnZoomOut");
		btnZoomIn.addEventListener("click", zoomIn);
		btnZoomOut.addEventListener("click", zoomOut);
		function zoomIn() {
			// 현재 지도의 레벨을 얻어옵니다
			var level = map.getLevel();

			// 지도를 1레벨 내립니다 (지도가 확대됩니다)
			map.setLevel(level - 1);

		}

		function zoomOut() {
			// 현재 지도의 레벨을 얻어옵니다
			var level = map.getLevel();

			// 지도를 1레벨 올립니다 (지도가 축소됩니다)
			map.setLevel(level + 1);

		}
	</script>
</body>

</html>