<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
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

* {
	box-sizing: border-box;
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
	border: 1px solid grey;
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

.menu > a {
	color: white;
	font-size: 16px;
	font-weight: bold;
	position: absolute;
	top: 50%;
	transform: translate(0, -50%);
}

.menu > img {
	position: absolute;
	top: 50%;
	transform: translate(0, -50%);
}

.menu > img:hover {
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

/*메인페이지 바디부분1*/
.bodyContainer1 {
	width: 100%;
	height: 600px;
	background-color: #ebc091;
}

.rowBody {
	width: 100%;
	height: 50%;
	padding-top: 20px;
}

.txtBox {
	width: 50%;
	height: 100%;
	text-align: center;
	padding: 0;
	position: relative;
}

.txtBox>p {
	font-weight: bold;
	font-size: 20px;
	position: relative;
	top: 50%;
	transform: translate(0, -50%);
}

.imgBox {
	width: 40%;
	height: 100%;
	margin: auto;
}

.imgBox>img {
	width: 100%;
	height: 100%;
}

.borderBox {
	width: 10%;
	margin: auto;
	height: 50px;
}

#bold {
	border-top: 2px solid black;
}

/*메인페이지 바디부분2*/
.bodyContainer2 {
	width: 90%;
	height: 700px;
	margin: auto;
	/* border: 1px solid grey; */
	margin-top: 100px;
	/* background-color: lightgrey; */
}

.tit {
	text-align: center;
	/* margin-bottom: 100px; */
}

.bodyContainer2 h2 {
	font-family: 'Noto Sans KR';
	font-weight: bold;
	color: #333;
	margin: 0;
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
	height: 400px;
	border: 1px solid black;
	background-color: lightgrey;
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
                            <a class ="ms-4" href="${pageContext.request.contextPath}/logoutProc.mem">로그아웃</a>
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
				<img src="${pageContext.request.contextPath}/img/plateLogo.png" id="logo">
			</div>
			<div class="col-2 col-md-7 menu"></div>
			<c:choose>
				<c:when test="${!empty loginSession}">
					<div class="col-2 col-md-1 menu">
						<a href="#">맛집 리스트</a>
					</div>
					<div class="col-2 col-md-1 menu">
						<a href="#">전체 리뷰</a>
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
					<div class="col-2 col-md-1 menu">
						<a href="#">맛집 리스트</a>
					</div>
					<div class="col-2 col-md-1 menu">
						<a href="#">전체 리뷰</a>
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
				<input type="text" id="searchBox" placeholder="맛집명, 주소 검색">
				<button type="button" class="btn btn-danger" id="searchBtn">
					<svg xmlns="http://www.w3.org/2000/svg" width="30" height="30"
						fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
                            <path
							d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z" />
                        </svg>
				</button>
			</div>
		</div>

		<div class="bodyContainer1">
			<div class="row rowBody">
				<div class="col-6 txtBox">
					<p>짧은 점심시간, 점심메뉴 선정 고민</p>
					<p>맛집 플레이트에서 해결해드릴께요.</p>
				</div>
				<div class="col-6 imgBox">
					<img src="">
				</div>
			</div>
			<div class="row rowBody">
				<div class="col-6 imgBox">
					<img src="">
				</div>
				<div class="col-6 txtBox">
					<p>가보고 싶은 SNS 맛집 핫플레이스,</p>
					<p>맛집 플레이트에서 한눈에 확인하세요.</p>
				</div>
			</div>
		</div>
		<div class="bodyContainer2">
			<div class="row">
				<div class="col-12 tit">
					<h2>추천 맛집 리스트</h2>
				</div>
			</div>
			<div class="borderBox"></div>
			<div class="borderBox" id="bold"></div>
			<div class="row viewList"></div>
			<div class="row">
				<div class="col-12 d-flex justify-content-end moleList">
					<a href="${pageContext.request.contextPath}/toTotalListView.li">더보기</a>
				</div>
			</div>
		</div>

		<div class="footer"></div>

	<script>
         $(document).ready(function(){
             getListAndFile();
         })

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
                        "box-shadow": "2px 0px 2px 2px grey"
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
        	location.href="${pageContext.request.contextPath}/toListDetailView.re?seq_list=" + $(this).find("input").val();
        })
        
        // 유저 아이콘 클릭 시
      //  $("#userPage").on("click", function(){
      //  	$("#modalUser").modal("show");
      //  })
    </script>
</body>

</html>