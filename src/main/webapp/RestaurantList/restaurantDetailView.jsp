<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>맛집 플레이트 : <c:if test="${!empty loginSession}">
		${restMap.get('restDto').getRest_name()}
	</c:if> ${restDto.getRest_name()}
</title>
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
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css"
	integrity="sha512-+4zCK9k+qNFUR5X+cKL9EIR+ZOhtIloNl9GIKS57V1MyNsYpYcUrUeQc9vNfzsWfV28IaLL3i96P9sdNyeRssA=="
	crossorigin="anonymous" />

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
	z-index: 99;
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

/* */
.headerContainer {
	width: 100%;
	margin-top: 80px;
	margin-bottom: 100px;
}

.headDiv {
	width: 100%;
	background-color: #f1f7e7;
	margin: 0;
}

.headDiv>div {
	padding: 0;
	height: 300px;
	position: relative;
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

/* 바디 영역 */
.bodyContainer {
	width: 100%;
}

.restDetailBox {
	width: 80%;
	margin: auto;
	border: 1px solid lightgray;
}

.mapDiv {
	padding: 12px;
}

.restInfoBox {
	padding: 12px;
}

.restCls {
	margin-bottom: 8px;
}

.restCls>.col-2>p {
	color: gray;
}

.restInfoBox>p:first-child {
	padding-bottom: 12px;
	border-bottom: 1px solid lightgray;
	font-size: 30px;
	font-weight: bold;
}

.titleMark {
	text-align: center;
}

#btnRestMark {
	border-radius: 50%;
	height: 50px;
	width: 50px;
	background-color: white;
	padding: 0;
}

#btnRestMark>i {
	width: 100%;
	heigth: 100%;
}

#markTxt {
	margin: 0;
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

#modal-body {
	height: 300px
}

/*로그아웃*/
#logoutBtn {
	text-decoration: none;
	cursor: pointer;
}

textarea {
	width: 100%;
	height: 6.25em;
	border: none;
	resize: none;
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
			<div class="col-2 menu d-flex justify-content-center">
				<img src="${pageContext.request.contextPath}/img/plateLogo.png"
					id="logo">
			</div>
			<div class="col-2 col-md-7 menu"></div>
			<c:choose>
				<c:when test="${!empty loginSession}">
					<div class="col-2 col-md-1 menu">
						<a href="${pageContext.request.contextPath}/toTotalListView.li">맛집
							리스트</a>
					</div>
					<div class="col-2 col-md-1 menu">
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
					<div class="col-2 col-md-1 menu">
						<a href="${pageContext.request.contextPath}/toTotalListView.li">맛집
							리스트</a>
					</div>
					<div class="col-2 col-md-1 menu">
						<a href="/view.vi?currentPage=1">전체 리뷰</a>
					</div>
				</c:otherwise>
			</c:choose>

		</div>
		<div class="headerContainer">
			<div class="row headDiv">
				<div class="col-12">
					<p>맛집이름</p>
				</div>
			</div>
		</div>

		<div class="bodyContainer">
			<div class="row restDetailBox">
				<div class="col-5 d-none d-md-block mapDiv">
					<div id="map" style="width: 100%; height: 400px;"></div>
				</div>
				<script type="text/javascript"
					src="//dapi.kakao.com/v2/maps/sdk.js?appkey=6ff8deedbebce1fe90adb84cc3728d4a&libraries=services"></script>
				<script>
					var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    				mapOption = {
        				center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
        				level: 3 // 지도의 확대 레벨
    				};  
				
					// 지도를 생성합니다    
					var map = new kakao.maps.Map(mapContainer, mapOption); 
				
					// 주소-좌표 변환 객체를 생성합니다
					var geocoder = new kakao.maps.services.Geocoder();

					// 주소로 좌표를 검색합니다
					geocoder.addressSearch("${restMap.get('restDto').getRest_address()}", function(result, status) {

    				// 정상적으로 검색이 완료됐으면 
     				if (status === kakao.maps.services.Status.OK) {

        				var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

       					// 결과값으로 받은 위치를 마커로 표시합니다
        				var marker = new kakao.maps.Marker({
            				map: map,
            				position: coords
       			 		});

        				// 인포윈도우로 장소에 대한 설명을 표시합니다
        				var infowindow = new kakao.maps.InfoWindow({
            				content: '<div style="width:150px;text-align:center;padding:6px 0;">' + "${restMap.get('restDto').getRest_name()}" + '</div>'
        				});
        				infowindow.open(map, marker);

     					// 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
        					map.setCenter(coords);
    					} 
					});
				</script>
				<div class="col-7 restInfoBox">
					<div class="row restCls">
						<div class="col-10">
							<p style="font-size: 30px;">${restMap.get('restDto').getRest_name()}</p>
						</div>
						<div class="col-2 d-none d-lg-block titleMark" style="padding: 0;">
							<div
								style="padding: 0px; color: gray; font-size: 14px; margin-bottom: 6px;">
								<span>추천수 : </span> <span id="totalMark">${restMap.get('restDto').getMark_count()}</span>
							</div>
							<c:choose>
								<c:when test="${!empty loginSession}">
									<button type="button" id="btnRestMark">
										<i class="far fa-thumbs-up fa-2x" id="markIcon"></i>
									</button>
									<p id="markTxt">추천해요!</p>
									<input class="d-none" name="seq_rest"
										value="${restMap.get('restDto').getSeq_rest()}" id="seq_rest">
									<c:choose>
										<c:when test="${! empty restMap.get('rmDto')}">
											<script>
												$(function(){
													$("#btnRestMark").css("border", "3px solid red");
													$("#markIcon").css("color", "red");
													$("#markTxt").css("color", "red");
												})
											</script>
										</c:when>
										<c:otherwise>
											<script>
												$(function(){
													$("#btnRestMark").css("border", "3px solid gray");
							    					$("#markIcon").css("color", "gray");
							    					$("#markTxt").css("color", "gray");
												})
											</script>
										</c:otherwise>
									</c:choose>
								</c:when>
								<c:otherwise>
									<button type="button" id="btnRestMark" disabled>
										<i class="far fa-thumbs-up fa-2x" id="markIcon"></i>
									</button>
									<script>
										$(function(){
											$("#btnRestMark").css("border", "3px solid gray");
				    						$("#markIcon").css("color", "gray");
				    						$("#markTxt").css("color", "gray");
										})
									</script>
									<p id="markTxt">추천해요!</p>
									<input class="d-none" name="seq_rest"
										value="${restMap.get('restDto').getSeq_rest()}" id="seq_rest">
								</c:otherwise>
							</c:choose>
						</div>

					</div>
					<div class="row restCls">
						<div class="col-2">
							<p>소개</p>
						</div>
						<div class="col-10">
							<p>${restMap.get('restDto').getRest_introduction()}</p>
						</div>
					</div>
					<div class="row restCls">
						<div class="col-2">
							<p>주소</p>
						</div>
						<div class="col-10">
							<p>${restMap.get('restDto').getPostCode()}
								${restMap.get('restDto').getRest_address()}</p>
						</div>
					</div>
					<div class="row restCls">
						<div class="col-2">
							<p>전화번호</p>
						</div>
						<div class="col-10">
							<p>${restMap.get('restDto').getRest_tel()}</p>
						</div>
					</div>
					<div class="row restCls">
						<div class="col-2">
							<p>영업시간</p>
						</div>
						<div class="col-10">
							<p>${restMap.get('restDto').getRest_time()}</p>
						</div>
					</div>
					<div class="row restCls">
						<div class="col-2">
							<p>주차여부</p>
						</div>
						<div class="col-10">
							<p>${restMap.get('restDto').getParking_possible()}</p>
						</div>
					</div>

				</div>
			</div>

			<div class="reviewContainer">
				<c:choose>
					<c:when test="${empty loginSession}">
						<div class="row">
							<input type="button" id="btnViewWrite" disabled value="리뷰쓰기">
						</div>
					</c:when>
					<c:otherwise>
						<div class="row">
							<input type="button" id="btnViewWrite" value="리뷰쓰기">
						</div>
					</c:otherwise>
				</c:choose>

				<div class="reviewBox"></div>

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
	$(document).ready(function() {
		getViewList();
	});
	
	// 리뷰쓰기 버튼 클릭 시  맛집 번호와 이름 같이 viewWrite.vi로 보내줌.
	document.getElementById("btnViewWrite").addEventListener("click", function() {
		location.href = "${pageContext.request.contextPath}/viewWrite.vi?seq_rest=${restMap.get('restDto').getSeq_rest()}&rest_name=${restMap.get('restDto').getRest_name()}";
	});
	
	// ajax를 이용해 리뷰을 불러오는 작업
	function getViewList(){
		$.ajax({
			type : "get"
			, url : "${pageContext.request.contextPath}/toDetailViewProc.vi?seq_rest=${restMap.get('restDto').getSeq_rest()}"
			, dataType : "json"
		
		}).done(function(data){
			console.log(data);
			
			$(".reviewBox").empty();
			
			for(let dto of data){
				console.log(dto.reivew)
				let review = "<div class='row m-1'>"
					 + "<div class='col-12 d-flex justify-content-start cmt-info'>"
					 +  dto.user_name
					 + "</div>"
		             + "<div class='col-12 d-flex justify-content-start cmt-info'>"
		             + dto.review_date
		             + "</div>"
		             + "<div class='col-10 d-flex justify-content-start reviewDiv-cmt'>"
		             + "<textarea class='form-control' class='content-cmt' name='view_comment' readonly>"
		             + dto.review_content
		             + "</textarea>"
		             + "</div>"
		             + "</div>"
		             // 댓글 동적 요소 추가
		             $(".reviewBox").append(review);
		             
		          	// 수정 삭제 버튼 영역	
		          	if("${loginSession.get('id')}" == dto.user_id){ // 작성자와 로그인 아이디가 같을 경우에만 수정삭제 버튼 추가 
		          		let btns = "<div class='col-1 d-flex justify-content-center'>"
		          		 + "<button type='button' class='btn btn-modifyCmt' id='btnModify' value='" + dto.seq_view +"'>수정</button>"
		          		 + "</div>"
		          		 + "<div class='col-1 d-flex justify-content-center'>"
		          		 + "<button type='button' class='btn btn-deleteCmt' id='btnDelete' value='" + dto.seq_view + "'>삭제</button>"
		          		 + "</div>";
		          		 // 가장 최신에 만들어진 댓글 영역 옆에 버튼 추가
		          		$(".reviewDiv-cmt:last").after(btns);
		          	}

							
			}
			
		
		}).fail(function(e){
			console.log(e);
		});
		}
	
	document.addEventListener('click',function(e){
        if(e.target.id == 'btnModify'){
      	   let seq_view = e.target.value;
      	   console.log(seq_view);
      	  location.href="/toDetailViewModify.vi?seq_view=" + seq_view;
         }
        });
	 
	 document.addEventListener('click',function(e){
        if(e.target.id == 'btnDelete'){
      	  let seq_view = e.target.value;
      	  if(confirm("정말로 삭제하시겠습니까?")) {
       		 $.ajax({
       			 url: "/toDetailViewDelete.vi?seq_view="+ seq_view +"&seq_rest=${restMap.get('restDto').getSeq_rest()}",
       			 type: "get"
       		 }).done(function(data){
       			 if(data == "success") {
       				 alert("리뷰가 삭제되었습니다.");
       			 } else if(data == "fail") {
       				 alert("리뷰 삭제에 실패하였습니다.");
       			 }
       		 }).fail(function(e){
       			 console.log(e);
       		 })
       	 }
			
         }
        });
		
		// 로고 클릭 시
        $("#logo").on("click", function(){
        	location.href = "/";
        })
        
        // 마크버튼 클릭 시
        $("#btnRestMark").on("click", function(){
        	let seq_rest = $("#seq_rest").val();
        	console.log(seq_rest);
        	
        	$.ajax({
        		url: "${pageContext.request.contextPath}/restmarkProc.mr?seq_rest=" + seq_rest,
        		type: "get",
        		dataType: "json"
        	}).done(function(data){
        		if(data.msg == "successMark") {
        			console.log(data.msg);
        			$("#btnRestMark").css("border", "3px solid red");
        			$("#markIcon").css("color", "red");
        			$("#markTxt").css("color", "red");
        		} else if(data.msg == "cancleMark") {
        			console.log(data.msg);
        			$("#btnRestMark").css("border", "3px solid gray");
        			$("#markIcon").css("color", "gray");
        			$("#markTxt").css("color", "gray");
        		}
        		
        		$("#totalMark").html("");
        		$("#totalMark").html(data.totalCount);
        	}).fail(function(e){
        		console.log(e);
        	})
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