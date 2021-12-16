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
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
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
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css" integrity="sha512-+4zCK9k+qNFUR5X+cKL9EIR+ZOhtIloNl9GIKS57V1MyNsYpYcUrUeQc9vNfzsWfV28IaLL3i96P9sdNyeRssA==" crossorigin="anonymous" />

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
	margin-bottom: 80px;
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
	opacity: 0.9;
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
        #modal-body{
        height: 300px
        }
        
        
        /*로그아웃*/
        #logoutBtn{
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
                        <div class="row" id="modal-body">
                        </div>
                        <div class="row" id="modal-footer">
                        <div class="col d-flex justify-content-end">
                        	<a class ="" href="${pageContext.request.contextPath}/mypage.mem">내정보</a>
                            <a class ="ms-4" id="logoutBtn" onclick=kakaoLogout()>로그아웃</a>
       
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