	<%@ page language="java" contentType="text/html; charset=UTF-8"
		pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<!DOCTYPE html>
	<html>
	<head>
	<meta charset="UTF-8">
	<link
		href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
		rel="stylesheet"
		integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
		crossorigin="anonymous">
	<script src="https://code.jquery.com/jquery-3.6.0.js"
		integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk="
		crossorigin="anonymous"></script>
	
	<title>로그인페이지</title>
	
	<style type="text/css">
	.container {
		width: 400px;
	}
	.btnsz{
		height: 30px
		display: flex;
	        justify-content: center;
	        align-items: center;
	}
	#sendPhonebtn, #phoneAtuhbtn, #sendEmailbtn, #emailAtuhbtn{
	height: 37px
	}
	a {
		font-size: small;
		text-decoration: none;
		color: black;
	}
	</style>
	</head>
	
	<body>
		 <!-- 아이디찾기 모달 영역-->
	    <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	        <div class="modal-dialog">
	            <div class="modal-content">
	                <div class="modal-header">
	                    <h5 class="modal-title" id="exampleModalLabel">인증방법 선택</h5>
	                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	                </div>
	                <div class="modal-body">
	                    <div class="searchIdContiner">
	
	                        <div class="row">
	                            <div class="col smsSendController">
	                                <div class="d-flex justify-content-start align-items-center">
	                                    <input type="radio" id="sms" name="chk" value="SMS" checked="checked">
	                                    <div>SMS 인증</div>
	                                </div>
	                                <div id="smsBox">
	                                    <div class="col d-flex mt-2">
	                                        <input type="text" class="form-control w-75 me-3" name="phone"
	                                            placeholder="010-0000-0000" style="font-size: 1rem ;">
	                                        <button type="button" class="w-25" id="sendPhonebtn">전송</button>
	                                        
	                                    </div>
	                                    <div class="col d-flex mt-2">
	                                        <input type="text" class="form-control w-75 me-3" name="phoneAuth"
	                                            placeholder="인증번호를 입력하세요" style="font-size: 1rem ;">
	                                        <button type="button" class="w-25" id="phoneAtuhbtn">완료</button>
	                                    </div>
	                                </div>
	
	                            </div>
	                            <div class="emailSendController">
	                                <div class="d-flex justify-content-start align-items-center mt-3">
	                                    <input type="radio" id="email" name="chk" value="EMAIL">
	                                    <div>이메일 인증</div>
	                                </div>
									<div id="emailBox" class = d-none>
	                                <div class="col d-flex justify-content-start align-items-center mt-2">
	                                    <input type="text" class="form-control w-75 me-3" name="email"
	                                        placeholder="이메일을 입력하세요" style="font-size: 1rem ;">
	                                    <button type="button" class="w-25" id ="sendEmailbtn">전송</button>
	                                    
	                                </div>
	                                  <div class="col d-flex mt-2">
	                                        <input type="text" class="form-control w-75 me-3" name="emailAuth"
	                                            placeholder="인증번호를 입력하세요" style="font-size: 1rem ;">
	                                        <button type="button" class="w-25" id="emailAtuhbtn">완료</button>
	                                    </div>
	                                    </div>
	                            </div>
	                        </div>
	                    </div>
	                </div>
	                <div class="modal-footer">
	                   
	                </div>
	            </div>
	        </div>
	    </div>
	
	    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
	        integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
	        crossorigin="anonymous"></script>
	    <script>
	    let phone = document.getElementById("phone") //핸드폰 번호 합친것
	    let email = document.getElementById("email") // 이메일 인풋창
	    let emailRegex = /^[a-zA-Z][a-zA-Z0-9_.]+@[a-zA-Z0-9]+\.[a-zA-z]{2,3}(:?\.[a-zA-z]{2,3})?$/
	    let phoneRegex = /[0-9]{3}-[0-9]{4}-[0-9]{4}/
	    let	emailLicense = false
	    let	phoneLicense = false
	    let phoneTimer = null; // sms 인증 timer
	    let emailTimer = null;
	    et phoneRegex = /[0-9]{3}-[0-9]{4}-[0-9]{4}/
	    $("#sendPhonebtn").click(function(){
	    	console.log("핸드폰전송")
	    })
	    $("#phoneAtuhbtn").click(function(){
	    	console.log("sms 인증번호")
	    })
	    $("#sendEmailbtn").click(function(){
	    	console.log("이메일전송")
	    })
	    $("#emailAtuhbtn").click(function(){
	    	console.log("이메일 인증번호")
	    })
	    
	       email.addEventListener("blur", function () {
                $("#resultEmail").remove();
                let newP
                if (regexTest(emailRegex, email)) {
                    newP = "<div id ='resultEmail'></div>"
                } else {
                    newP = "<div class='row' id ='resultEmail'><div class='col-3 d-flex justify-content-end'></div><div class='col-6 d-flex justify-content-start m-0 mt-3'><p class = 'm-0 ms-3'style='color: red; font-size: 0.8rem;'>올바르지 않은 이메일 형식입니다.</p></div></div>"
                }
                $("#emailBox").after(newP)
            })
	    
	    //#sendPhonebtn, #phoneAtuhbtn, #sendEmailbtn, #emailAtuhbtn{
	    //	height: 37px
	    //	}
	        $("input[name='chk']:radio").change(function (e) {
	            //라디오 버튼 값을 가져온다.
	            let noticeCat = this.value;
	
	            console.log(noticeCat);
	            if (e.target.value == "SMS") {
	                $("#emailBox").addClass("d-none")
	                $("#smsBox").removeClass("d-none")
	                console.log("인증번호 전송페이지")
	            } else {
	                $("#smsBox").addClass("d-none")
	                $("#emailBox").removeClass("d-none")
	                console.log("인증번호 전송페이지")
	            }
	        });
	
	    </script>
		<!-- <p>$ { loginSession.get("nickname")}님환영합니다.</p> -->
		<c:choose>
			<c:when test="${!empty loginSession}">
				<p>로그인 성공</p>
			</c:when>
			<c:otherwise>
				<c:if test="${rs eq 'fail'}">
					<script type="text/javascript">
				alert("아이디 혹은 비밀번호를 잘못 입력 하였습니다.")
				</script>
				</c:if>
	
				<form action="${pageContext.request.contextPath}/loginProc.mem"
					method="post" id="loginForm">
					<div
						class="container h-100 d-flex flex-column justify-content-md-center">
						<div class="row">
							<div class="col-12 d-flex justify-content-center">
								<h3 class="mt-3">로그인</h3>
							</div>
							<div class="col-12 d-flex justify-content-center mt-3">
								<img src="${pageContext.request.contextPath}/logo.jpg" alt="">
							</div>
						</div>
						<div class="row">
							<div class="col-12">
								<input type="text" class="form-control mt-3" id="id" name="id"
									placeholder="맛집 플레이트 ID" onkeyup=enterkey()>
							</div>
							<div class="col-12">
								<input type="password" class="form-control mt-3" id="pw"
									name="pw" placeholder="비밀번호" onkeyup=enterkey()>
							</div>
						</div>
						<div class="row">
							<div class="col-12">
								<button type="button" class="btn btn-dark w-100 mt-3"
									id="btnLogin" style="height: 50px;">로그인</button>
							</div>
							<div class="col">
								<a href="#" class="me-1" data-bs-toggle="modal" data-bs-target="#exampleModal">아이디 찾기</a> <a href="#" class="me-1">비밀번호
									찾기</a> <a href="${pageContext.request.contextPath}/signup.mem"
									class="">회원가입</a>
							</div>
						</div>
						<div class="row">
							<div class="col-12">
								<img src="${pageContext.request.contextPath}/kakao_login_img.png"
									alt="" class="w-100 mt-3" id="kakoLoginBtn"
									style="height: 50px;">
							</div>
							<div class="col"></div>
						</div>
					</div>
					<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
					<!-- 카카오 로그인 sdk 등록-->
					<script type="text/javascript">
		
		<form action = "${pageContext.request.contextPath}/loginProc.mem" method = "post" id="loginForm">
		<div
			class="container h-100 d-flex flex-column justify-content-md-center">
			<div class="row">
				<div class="col-12 d-flex justify-content-center">
					<h3 class="mt-3">로그인</h3>
				</div>
				<div class="col-12 d-flex justify-content-center mt-3">
					<img src="${pageContext.request.contextPath}/img/logo.jpg" alt="">
				</div>
			</div>
			<div class="row">
				<div class="col-12">
					<input type="text" class="form-control mt-3" id="id" name = "id"
						placeholder="맛집 플레이트 ID">
				</div>
				<div class="col-12">
					<input type="password" class="form-control mt-3" id="pw"  name = "pw" placeholder="비밀번호">
				</div>
			</div>
			<div class="row">
				<div class="col-12">
					<button type="button" class="btn btn-dark w-100 mt-3" id="btnLogin"
						style="height: 50px;">로그인</button>
				</div>
				<div class="col">
					<a href="#" class="me-1">아이디 찾기</a> <a href="#" class="me-1">비밀번호
						찾기</a> <a href="${pageContext.request.contextPath}/signup.mem" class="">회원가입</a>
				</div>
			</div>
			<div class="row">
				<div class="col-12">
					<img src="${pageContext.request.contextPath}/img/kakao_login_img.png" alt="" class="w-100 mt-3" id="kakoLoginBtn"
						style="height: 50px;">
				</div>
				<div class="col"></div>
			</div>
		</div>
		 <script src="https://developers.kakao.com/sdk/js/kakao.js"></script> <!-- 카카오 로그인 sdk 등록-->
		<script type="text/javascript">
		 window.Kakao.init("f5b85acc6a4af9096ab0fcf1ad929c7c"); //자바 키 등록
		 console.log(Kakao.isInitialized()); //초기화 여부 판단 ==> true 정상적으로 초기화
	
	    //로그인 버튼 클릭시 
	    document.getElementById("btnLogin").addEventListener("click",function(){
	    	loginFormSubmit()
	    })
	    function enterkey() {
	         if (window.event.keyCode == 13) {
	        	 loginFormSubmit()
	         }
	     }
	   	function loginFormSubmit(){ //로그인 서브밋 함수
	   		if(!idCheck()) return
	    	if(!pwCheck()) return
	    	$("#loginForm").submit();
	   	}
	    
	    document.getElementById("kakoLoginBtn").addEventListener("click",function(){
	    	kakaoLogin()
	    })
	   
	    //아이디 정규식
	    function idCheck() {
		    let regex = /^[a-zA-Z][a-zA-Z0-9_]{5,11}$/g
		    let id =  document.getElementById("id")
		    if (!check(regex,id.value, id, "올바르지 않은 Id 형식입니다.")) {
		    return false;
		    }
		    return true;
	    }
	    //password 정규식 
	    //8~16자리 영문자 숫자 특문 포함
	    function pwCheck() {
		    let regex = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*?&])[A-Za-z\d$@$!%*?&]{8,16}/g
		    let pw =  document.getElementById("pw")
		    if (!check(regex,pw.value, pw, "올바르지 않은 비밀번호 형식입니다.")) {
		    return false;
		    }
		    return true;
	    }
	    
	    //정규식이 맞으면 true 반환 틀리면 false 반환 후 틀린부분 focus
	    function check(pattern, taget, id, message) {
	        if (pattern.test(taget)) {
	            return true;
	        }
	        alert(message);
	        id.focus();
	        return false;
	    }
	   
	    function kakaoLogin() {
	        Kakao.Auth.login({
	            scope: 'profile_nickname,profile_image,account_email,gender,profile_image', // 추가 항목 동의 
	            success: function (authObj) { //성공시 콜백 함수 
	                //console.log(authObj);
	                window.Kakao.API.request({ //리퀘스트 요청 
	                    url: '/v2/user/me', // 로그인 사용자 정보
		
	                    success: function(res) {
	                    //data: {kakaoId : res.id, kakaoNickname : res.properties.nickname}	
	                     	console.log(res)
	                     	console.log(res.id)
	                     	console.log(res.properties.nickname)
	                  	 	let newForm = "<form action='${pageContext.request.contextPath}/kakaoLogin.mem' method='post' id='kakaoForm' ><input type='hidden' name ='kakaoId' value='"+res.id+"'>	<input type='hidden' name ='kakaoNickname' value='"+res.properties.nickname+"'></form>"
	                  	 	$("body").append(newForm)
	                  	 	$("#kakaoForm").submit();
	                  	 	//console.log(res.kakao_account);
	                        //console.log(res.kakao_account.email);
	                        //console.log(res.properties.nickname);
	                        //console.log(res.properties.profile_image);
	                        //console.log(res.properties);
	                       
	                    },
	                    fail: function (error) {
	                        console.log(error)
	                    }
	
	                });
	            }
	        });
	    }
	    
	    </script>
			</c:otherwise>
		</c:choose>
	
	</body>
	</html>