
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
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

<title>맛집 플레이트</title>
<style>
@font-face {
	font-family: 'twaysky';
	src:
		url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_tway@1.0/twaysky.woff')
		format('woff');
	font-weight: normal;
	font-style: normal;
}

@font-face {
	font-family: '양진체';
	src:
		url('https://cdn.jsdelivr.net/gh/supernovice-lab/font@0.9/yangjin.woff')
		format('woff');
	font-weight: normal;
	font-style: normal;
}

5


@import url(//fonts.googleapis.com/earlyaccess/notosanskr.css);

.notosanskr * {
	font-family: 'Noto Sans KR', sans-serif;
}

@font-face {
	font-family: 'YdestreetB';
	src:
		url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2110@1.0/YdestreetB.woff2')
		format('woff2');
	font-weight: normal;
	font-style: normal;
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
	color: white;
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
/* 헤더 */
.header {
	width: 100vw;
	position: relative;
}

.header-txt {
	position: absolute;
	width: 100%;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	z-index: 1;
}

.header-txt>h2 {
	font-family: '양진체';
	color: whitesmoke;
	/* font-weight: bold; */
	text-shadow: 1px 1px 1px grey;
	font-size: 3vw;
	text-align: center;
}

.header-txt>h2:first-child {
	margin-top: 40px;
}
/*검색창*/
.header-search {
	position: absolute;
	width: 60%;
	margin: auto;
	top: 70%;
	left: 50%;
	transform: translate(-50%, 0);
}

#searchBox {
	width: 100%;
	height: 60px;
	border-radius: 4px;
	border: 1px solid #bbb;
	opacity: 0.9;
	padding-left: 20px;
}

#searchBtn {
	border-top-right-radius: 4px;
	border-bottom-right-radius: 4px;
	border-top-left-radius: 0px;
	border-bottom-left-radius: 0px;
	position: absolute;
	height: 100%;
	width: 100px;
	top: 0;
	right: 0;
	background-color: red;
	border: 1px solid red;
}
/*메인페이지 섹션1*/
.section1 {
	width: 100%;
	height: auto;
}

.img-body {
	position: absolute;
}

.section1 .row {
	position: relative;
	width: 80%;
	margin: auto;
}

.section1_title {
	padding-top: 100px;
}

.tit {
	width: 100%;
	text-align: center;
	/*position: relative;*/
}

.section1 .tit {
	padding-bottom: 100px;
}

.tit>h2 {
	font-family: '양진체';
	font-weight: bold;
	color: #333;
	margin: 0;
	/*position: relative;
	top: 50%;
	transform: translate(0, -50%);*/
}

.section1_row {
	/*height: 45%;*/
	/*width: 80vw;
	margin: auto;*/
	
}

.section1_row:last-child {
	padding-top: 20px;
	margin-bottom: 100px;
}

.imgBox {
	height: 100%;
	padding-left: 40px;
	padding-right: 40px;
	position: relative;
	margin: 0;
}

.imgBox>img {
	position: relative;
	left: 50%;
	transform: translate(-50%, 0);
	max-height: 700px;
	width: 100%;
	/*margin: auto;*/
}

.txtBox {
	position: relative;
}

.txtBox1 {
	padding-left: 40px;
	padding-right: 20%;
}

.txtBox2 {
	padding-left: 10%;
	padding-right: 40px;
}

.txtCls {
	position: relative;
	top: 50%;
	transform: translate(0, -50%);
}

.txtCls1 {
	text-align: right;
}

.txtCls2 {
	text-align: left;
}

.txtCls>h1 {
	font-family: '양진체';
	color: red;
	margin-bottom: 30px;
}
/*
.txtBox {
	width: 50%;
	text-align: center;
	padding: 0;
	position: relative;
	height: 100%
}
*/
.txtCls>p {
	font-weight: bold;
	font-size: 20px;
	color: grey;
	margin: 0;
	font-family: 'Noto Sans KR'
}
/*
.imgBox>img {
	width: 100%;
	height: 100%;
}
*/
.borderBox {
	width: 10%;
	margin: auto;
	height: 50px;
}

#bold {
	border-top: 2px solid black;
}
/*메인페이지 바디부분2*/
.section2 {
	position: relative;
	width: 90%;
	margin: auto;
	/*padding-top: 100px;*/
	/* border: 1px solid grey; */
	/* background-color: lightgrey; */
}

.viewList {
	width: 100%;
	margin: auto;
}

.listBox {
	height: 200px;
	position: relative;
	background-color: black;
	margin-bottom: 20px;
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
	opacity: 0.7;
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

.moleList>a {
	margin-right: 12px;
	color: #333;
	font-weight: bold;
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
	margin-left: 16px;
	margin-right: 16px;
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

	<div class="wrapper">
		<div class="row naviBar">
			<div class="col-3 col-md-2 menu">
				<img src="${pageContext.request.contextPath}/img/plateLogo.png"
					id="logo">
			</div>

			<c:choose>
				<c:when test="${!empty loginSession}">
				
					<c:choose>
						<c:when test="${loginSession.identification eq '1'}">
							<div class="d-none d-md-block col-md-6 menu"></div>
							<div class="col-1 col-md-1 menu">
								<a href="${pageContext.request.contextPath}/manager/managerIndex.jsp">관리자페이지</a>
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

		<div class="header">
			<div class="header-img">
				<img src="${pageContext.request.contextPath}/img/mainImg2.png"
					style="width: 100%;">
			</div>
			<div class="header-txt d-none d-md-block">
				<h2>당장 오늘, 점심 뭐먹지? 고민일 땐</h2>
				<h2>맛집 플레이트</h2>
			</div>
			<div class="header-search d-none d-md-block">
				<form action="${pageContext.request.contextPath}/toSearchRest.re"
					method="post" id="searchForm">
					<input type="text" id="searchBox" placeholder="맛집명 또는 주소 검색"
						name="searchWord" onkeyup="enterkey();">
					<button type="button" class="btn btn-danger" id="searchBtn">
						<svg xmlns="http://www.w3.org/2000/svg" width="30" height="30"
							fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
                            <path
								d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z" />
                        </svg>
					</button>
				</form>
			</div>
		</div>
		<script>
			// 검색버튼 클릭 시
        	$("#searchBtn").on("click", function(){
        		if($("#searchBox").val() == "") {
        			alert("검색어를 입력해주세요.");
        			return;
        		}
        		$("#searchForm").submit();
       		})
		</script>

		<div class="section1">
			<div class="img-body">
				<img src="${pageContext.request.contextPath}/img/bodyMain.png"
					style="width: 100%; height: 100%;">
			</div>
			<div class="row section1_title">
				<div class="col-12 tit">
					<h2>플레이트 스토리</h2>
				</div>
				
			</div>
			<div class="row section1_row">
				<div class="col col-12 col-md-6 imgBox">
					<img src="${pageContext.request.contextPath}/img/section1Img.png">
				</div>
				<div class="col col-12 col-md-6 d-none d-md-block txtBox txtBox1">
					<div class="txtCls txtCls1">
						<h1>메뉴선정 고민</h1>
						<p>믿을만한 솔직한 리뷰로</p>
						<p>탁월한 메뉴 선택 도와드릴께요.</p>
					</div>
				</div>
			</div>
			<div class="row section1_row">
				<div class="col col-12 col-md-6 d-none d-md-block txtBox txtBox2">
					<div class="txtCls txtCls2">
						<h1>맛집과 핫플레이스를 한눈에</h1>
						<p>가보고 싶은 SNS 맛집 핫플레이스,</p>
						<p>맛집 플레이트에서 한눈에 확인하세요.</p>
					</div>
				</div>
				<div class="col col-12 col-md-6 imgBox">
					<img src="${pageContext.request.contextPath}/img/section1Img2.png">
				</div>
			</div>
		</div>

		<div class="section2">
			<div class="row">
				<div class="col-12 tit">
					<h2>추천 맛집 리스트</h2>
				</div>
			</div>
			<div class="borderBox"></div>
			<div class="borderBox" id="bold"></div>
			<div class="row viewList"></div>
			<div class="row" style="margin-bottom: 100px;">
				<div class="col-12 d-flex justify-content-end moleList">
					<a href="${pageContext.request.contextPath}/toTotalListView.li">더보기</a>
				</div>
			</div>
		</div>



		<div class="footer">
			<div class="footerData">
				<div class="row" style="margin-bottom: 80px;">
					<div class="col-12 d-flex justify-content-center">
						<i class="fab fa-instagram-square fa-5x"></i> <i
							class="fab fa-facebook fa-5x"></i> <i
							class="fab fa-twitter-square fa-5x"></i> <i
							class="fab fa-line fa-5x"></i>
					</div>
				</div>
				<div class="row">
					<div class="col-12 d-flex justify-content-center">
						<span style="font-size: 20px;"><a href="/">InFo</a> · <a
							href="/">Support</a> · <a href="/">Marketing</a></span>
					</div>
					<div class="col-12 d-flex justify-content-center">
						<span style="font-size: 20px;"><a href="/">Terms of Use</a>
							· <a href="/">Privacy Policy</a></span>
					</div>
					<div class="col-12 d-flex justify-content-center">
						<span>서울특별시 강남구 ooo로 ooo, ooo타워</span>
					</div>
					<div class="col-12 d-flex justify-content-center">
						<span>고객센터: 02-000-0000</span>
					</div>
					<div class="col-12 d-flex justify-content-center">
						<span style="color: grey;">© 2021 kh 3, Restaurant
							exploration team. All rights reserved.</span>
					</div>

				</div>
			</div>
		</div>

	</div>
	<script>
         $(document).ready(function(){
             getListAndFile();
         })
         
         
        // $("#searchBox").on("keypress", function (e) {
        //        if (e.keyCode == 13 && $("#searchBox").val() == ""){
        //        	alert("검색어를 입력하세요.");
        //        	return;
        //        } else if (e.keyCode == 13 && $("#searchBox").val() != "") {
        //        	$("#searchForm").submit();
        //        }
        // });
           
         // 메인페이지로 리스트목록 불러오기
         function getListAndFile() {
        	 $.ajax({
        		 url: "${pagContext.request.ContextPath}/getHomeList.li",
        		 dataType: "json"
        	 }).done(function(data){
        		 for(let list of data) {
        			 let listDiv = "<div class='col-3'>"
        			 				+ "<div class='listBox'>"
        			 				+ "<img src='/listFiles/" + list.system_name + "'>"
        			 				+ "<p>" + list.list_title + "</p>"
        			 				+ "<input type='text' class='d-none' value='" + list.seq_list + "'>"
        			 				+ "</div></div>";
        			 				
        			 $(".viewList").append(listDiv);
        		 }
        	 }).fail(function(e){
        		 console.log(e);
        	 })
         }
         
        // 네비바 스크롤 시 변화
        $(function () {
            $(window).scroll(function () {
                let navbar = $(this).scrollTop();
                if (navbar > 200) {
                    $(".naviBar").css({
                        "backgroundColor": "white",
                        "z-index": "99",
                        "box-shadow": "2px 2px 4px 0px grey"
                        // 2px 0px 2px 2px, box-shadow: 2px 2px 4px 0px lightgrey;
                    });
                    $(".menu").children().css("color", "grey");
                } else {
                    $(".naviBar").css({
                        "backgroundColor": "",
                        "box-shadow": "0 0 0 0"
                    });
                    $(".menu").children().css("color", "white");
                    // $(".menu").css("border", "none");
                }
            })
        })
        
        // 로고 클릭 시
        $("#logo").on("click", function(){
        	location.href = "/";
        })
        
        // 리스트 클릭 시
        $(document).on("click", ".listBox", function(){
        	console.log($(this).find("input").val());
        	location.href="${pageContext.request.contextPath}/toRestaurnatList.re?seq_list=" + $(this).find("input").val();
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
