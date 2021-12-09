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
					<img src="${pageContext.request.contextPath}/img/logo.png"
						id="logo">
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
				</div>
				<div class="reviewContainer">
					<div class="row">
						<button type="button" id="btnViewWrite">리뷰쓰기</button>
					</div>
					<div class="reviewBox"></div>

				</div>
			</div>
		</div>
	</div>
	</div>

	<script type="text/javascript"
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=6ff8deedbebce1fe90adb84cc3728d4a"></script>
	<script>
		// 리뷰쓰기 버튼 클릭 시  맛집 번호와 이름 같이 viewWrite.vi로 보내줌.
		document.getElementById("btnViewWrite").addEventListener("click", function() {
			location.href = "${pageContext.request.contextPath}/viewWrite.vi?seq_rest=100&rest_name=맛집";
		});
		$(document).ready(function() {
			getCommentList();
		});
		
		function getCommentList(){
			// ajax를 이용해 댓글을 불러오는 작업
			$.ajax({
				type : "get"
				, url : "${pageContext.request.contextPath}/toDetailViewProc.vi?seq_rest=${seq_rest}"
				, dataType : "json"
			
			}).done(function(data){
				console.log(data);
				
				$(".reviewBox").empty();
				
				for(let dto of data){
					let comment = "<div class='row'>" 
								+ "<div class='col-2 show_nick'>"
								+ dto.user_id
								+ "</div>"
								+ "<div class='col-10'>"
								+ "<div>"
								+ dto.reivew_date 
								+ "</div>"
								+ "<div class='reviewDiv-cmt'>"
								+"<textarea style='border:none' readonly>"
								+ dto.review_content
								+ "</textarea>"
								+ "</div>"
								+ "</div>"
								+ "</div>";
								
								$(".reviewBox").append(comment);
								//수정 삭제 버튼 영역
								if("$(loginSession.get('id'))" == dto.user_id){
									let btns = "<div>" +
												"<button type='button' class='btn btn-modifyCmt' value='"+ dto.seq_view +" '>수정</button>" + 
												"</div>" +
												"<div>" +
												"<button type='button' class='btn btn-deleteCmt' value='"+ dto.seq_view +"'>삭제</button>" +
												"</div>";
												
												$(".reviewDiv-cmt:last").after(btns);
								}
				}
			}).fail(function(e){
				console.log(e);
			});
		}
	</script>
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