
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
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css" integrity="sha512-+4zCK9k+qNFUR5X+cKL9EIR+ZOhtIloNl9GIKS57V1MyNsYpYcUrUeQc9vNfzsWfV28IaLL3i96P9sdNyeRssA==" crossorigin="anonymous" />
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />

<title>로그인페이지</title>

<style type="text/css">
.container {
	width: 400px;
	padding-top: 100px;
}
#sendPhonebtn, #phoneAtuhbtn, #sendEmailbtn, #emailAtuhbtn {
	height: 37px
}
a {
	font-size: small;
	text-decoration: none;
	color: black;
}

/* footer */
.footer {
	margin-top: 100px;
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
</style>
</head>
<body>
	<c:choose>
		<c:when test="${!empty loginSession}">
			<script type="text/javascript">location.href = "${pageContext.request.contextPath}/home"</script>
		</c:when>
		<c:otherwise>
			<c:if test="${rs eq 'fail'}">
				<script type="text/javascript">
				alert("아이디 혹은 비밀번호를 잘못 입력 하였습니다.");
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
							<img src="${pageContext.request.contextPath}/img/logo.jpg" alt="">
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
							<a href="#" class="me-1" data-bs-toggle="modal"
								data-bs-target="#IdModal">아이디 찾기</a> <a href="#" class="me-1"
								data-bs-toggle="modal" data-bs-target="#pwModal">비밀번호 찾기</a> <a
								href="${pageContext.request.contextPath}/signup.mem" class="">회원가입</a>
						</div>
					</div>
					<div class="row">
						<div class="col-12">
							<img
								src="${pageContext.request.contextPath}/img/kakao_login_img.png"
								alt="" class="w-100 mt-3" id="kakoLoginBtn"
								style="height: 50px;">
						</div>
						<div class="col"></div>
					</div>
				</div>
				</form>
				
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
					<div class="col-12 d-flex justify-content-center" >
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
				<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
				<!-- 카카오 로그인 sdk 등록-->
				<script type="text/javascript">
		 window.Kakao.init("f5b85acc6a4af9096ab0fcf1ad929c7c"); 
		 console.log(Kakao.isInitialized()); //초기화 여부 판단 == true 정상적으로 초기화 
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

	<!-- =============================비밀번호 찾기 모달 영역 ============================= -->
	<div class="modal fade" id="pwModal" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">비밀번호 찾기</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">

					<div>아이디를 입력하세요</div>
					<div class="d-flex">
						<input type="text" class="form-control w-75 me-3" id="pwModalId">
						<button type="button" class="w-25" id="pwModalSendId">전송</button>
					</div>

					<div class="searchpwContiner d-none">
						<div class="row">
							<div class="col smsSendController">
								<div class="d-flex justify-content-start align-items-center">
									<input type="radio" id="sms1" name="chk1" value="SMS"
										checked="checked">
									<div>SMS 인증</div>
								</div>
								<div id="smsBox2">
									<div class="col d-flex mt-2">
										<input type="text" class="form-control w-75 me-3"
											name="phone2" id="phone2" placeholder="010-0000-0000"
											style="font-size: 1rem;" maxlength="13">
										<button type="button" class="w-25" id="sendPhonebtn2">전송</button>

									</div>
									<div class="col d-flex mt-2 d-none" id="ponAuthBox2">
										<input type="text" class="form-control w-75 me-3"
											name="phoneAuthNumInput" id="phoneAuthNumInput2"
											placeholder="인증번호를 입력하세요" style="font-size: 1rem;"
											maxlength="6">
										<button type="button" class="w-25" id="phoneAtuhbtn2" disabled>완료</button>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<div
						class="ms-1 col-12 d-flex justify-content-center align-items-center d-none"
						id="phoneTime2"></div>
					<div class="col-12 d-flex justify-content-center d-none" id="getPw"></div>
				</div>
			</div>
		</div>
	</div>

	<!-- =============================비밀번호 찾기 모달 영역 끝   ============================================ -->
	<script type="text/javascript">
	  let phoneTimer2 = null; // sms 인증 timer
					$("#pwModalId").val
					
					  document.getElementById("pwModalSendId").addEventListener("click",function(){
						  if(pwModalIdCheck()){
							  
							  let data={"id" : $("#pwModalId").val() }
							  $.ajax({
				                    type: "post"
				                    , url: "${pageContext.request.contextPath}/searchPw.mem"
				                    , data: data
				                    , success: function (rs) {
				                        console.log(rs)
				                        if (rs == "success") {
				                        	$(".searchpwContiner").removeClass("d-none")     
				                        	
				                        } else {
				                           alert("존재하지않는 아이디입니다.")
				                        }
				                    }, error: function (e) {
				                        console.log(e)
				                    }
				                })
						  }
						  
					    })
					    
					    document.getElementById("sendPhonebtn2").addEventListener("click",function(){
					    	  if (regexTest(phoneRegex, phone2)) {
					                $("#phoneAtuhbtn2").attr("disabled", false);
					                $("#phoneTime2").removeClass("d-none");
					                $("#ponAuthBox2").removeClass("d-none");
					                let data = { "rphone": phone2.value }
						      $.ajax({
				                    type: "post"
				                    , url: "${pageContext.request.contextPath}/SmsSend.sms"
				                    , data: data
				                    , success: function (rs) {
				                        console.log(rs)
				                        if (rs == "success") {
				                            $("#phoneAtuhbtn2").removeClass("d-none");
				                            var display = $("#phoneTime2");
				                            // 유효시간 설정
				                            var leftSec = 180;
				                            // 버튼 클릭 시 시간 연장
				                            clearInterval(phoneTimer2);
				                            phoneTimerStart2(leftSec, display);
				                        } else {
				                        	alert("인증번호 전송 실패")
				                        }
				                    }, error: function (e) {
				                        console.log(e)
				                    }
				               	})
					  	 }else{
					  		 alert("올바르지 않은 phone 형식입니다.")
					  	 }
				
					    })
					    		//폰 타이머
					            function phoneTimerStart2(count, display) {
					                var minutes, seconds;
					                phoneTimer2 = setInterval(function () {
					                    displayTime(count, minutes, seconds, display, phoneTimer, phoneAtuhbtn2)
					                    count--
					                }, 1000);
					            }
	  
						        function pwModalIdCheck() {
							    let regex = /^[a-zA-Z][a-zA-Z0-9_]{5,11}$/g
							    let id =  document.getElementById("pwModalId")
							    if (!check(regex,id.value, id, "올바르지 않은 Id 형식입니다.")) {
							    return false;
							    }
							    return true;
						    }
					
						        //sms인증 확인 시 
						        phoneAtuhbtn2.addEventListener("click", function () {
						            data = { "phoneAuthNumInput": $("#phoneAuthNumInput2").val() }
						            console.log(data)
						            
						            $.ajax({
						                type: "post"
						                , url: "${pageContext.request.contextPath}/phoneAuthNumSend.sms"
						                , data: data
						                , success: function (rs) {
						                    console.log(rs)
						                    if (rs == "success") {
						                        //$("#resultPhoneAuth2").remove();
						                        $("#sendPhonebtn2").html("인증완료")
						                        $("#sendPhonebtn2").attr("disabled", true);
						                        $("#phone2").attr("disabled", true);
						                        $("#phoneTime2").addClass("d-none");
						                        $("#ponAuthBox2").addClass("d-none");
						                    
						                        let phoneNumber = phone.value
						                        
						                        $.ajax({
						                        	  type: "post"
						                                  , url: "${pageContext.request.contextPath}/tempPw.mem"
						                                  , data: {"id": $("#pwModalId").val(), "phone2" : $("#phone2").val() }
						                                  , success: function (rs) {
						                                	   $("#getPw").html("");
						                                	   $("#getPw").removeClass("d-none");
						                                	  if(rs != "fail"){
						                                		  $("#getPw").html("발급된 임시비밀번호는 " + rs + " 입니다.");
						                                	  }else{
						                                		  $("#getPw").html("비밀번호 발급에 실패하였습니다. 관리자에게 문의해주세요(010-5670-5842)");
						                                	  }
						                                		 
						                                  }, error: function (e) {
						                                      console.log(e)
						                                  }
						                        })
						                    } else {
						                      alert("인증번호가 틀렸습니다.")
						                    }
						                }, error: function (e) {
						                    console.log(e)
						                }
						            })
						        })
					</script>

	<!--================================ 아이디찾기 모달 영역  ================================-->
	<div class="modal fade" id="IdModal" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">아이디 찾기</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<div class="searchIdContiner">

						<div class="row">
							<div class="col smsSendController">
								<div class="d-flex justify-content-start align-items-center">
									<input type="radio" id="sms" name="chk" value="SMS"
										checked="checked">
									<div>SMS 인증</div>
								</div>
								<div id="smsBox">
									<div class="col d-flex mt-2">
										<input type="text" class="form-control w-75 me-3" name="phone"
											id="phone" placeholder="010-0000-0000"
											style="font-size: 1rem;" maxlength="13">
										<button type="button" class="w-25" id="sendPhonebtn">전송</button>

									</div>
									<div class="col d-flex mt-2 d-none" id="ponAuthBox">
										<input type="text" class="form-control w-75 me-3"
											name="phoneAuthNumInput" id="phoneAuthNumInput"
											placeholder="인증번호를 입력하세요" style="font-size: 1rem;"
											maxlength="6">
										<button type="button" class="w-25" id="phoneAtuhbtn" disabled>완료</button>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<div
						class="ms-1 col-12 d-flex justify-content-center align-items-center d-none"
						id="phoneTime"></div>
					<div class="col-12 d-flex justify-content-center d-none" id="getId"></div>
				</div>
			</div>
		</div>
	</div>
	<script>
	    let phone = document.getElementById("phone") //핸드폰 번호 합친것
	    let phoneAuthNumInput = document.getElementById("phoneAuthNumInput")
	    let email = document.getElementById("email") // 이메일 인풋창
	    let emailRegex = /^[a-zA-Z][a-zA-Z0-9_.]+@[a-zA-Z0-9]+\.[a-zA-z]{2,3}(:?\.[a-zA-z]{2,3})?$/
	    let phoneRegex = /[0-9]{3}-[0-9]{4}-[0-9]{4}/
	    let	phoneLicense = false
	    let phoneTimer = null; // sms 인증 timer
	    
	    
	    let sendPhonebtn = document.getElementById("sendPhonebtn")// 핸드폰 전송
	    let phoneAtuhbtn = document.getElementById("phoneAtuhbtn")// 핸드폰 인증번호 확인
	    let sendEmailbtn = document.getElementById("sendEmailbtn")// 이메일 전송
	    let emailAtuhbtn = document.getElementById("emailAtuhbtn")// 이메일 인증번호 확인
	    
	    /* =======================모달영역=========================== */
	    //모달을 초기화 해준다.
	    $('.modal').on('hidden.bs.modal', function (e) { 
  			//아이디 찾기 모달
  			phone.value = ""
  			$("#phone").removeAttr("disabled");
  			$("#sendPhonebtn").removeAttr("disabled");
  			$("#getId").html("");
  			$("#sendPhonebtn").html("전송");
  			$("#phoneAuthNumInput").val("");
  			
  			
  			//비밀번호 찾기 모달
  			$("#phoneAuthNumInput2").val("");
  			$("#phone2").val("");
  			$("#phone2").removeAttr("disabled");
  			$("#pwModalId").val("");
  			$("#sendPhonebtn2").html("전송");
  			$("#sendPhonebtn2").removeAttr("disabled");
  			$("#getPw").html("");
			$(".searchpwContiner").addClass("d-none");  			
  			//location.href ="${pageContext.request.contextPath}/login.mem"
		})
	    
	    //sms인증문자 전송 시 
        sendPhonebtn.addEventListener("click", function () {
            $("#resultPhone").remove();
            if (regexTest(phoneRegex, phone)) {
                $("#phoneAtuhbtn").attr("disabled", false);
                $("#phoneTime").removeClass("d-none");
                $("#ponAuthBox").removeClass("d-none");
                data = { "rphone": phone.value }
               
                $.ajax({
                    type: "post"
                    , url: "${pageContext.request.contextPath}/SmsSend.sms"
                    , data: data
                    , success: function (rs) {
                        console.log(rs)
                        if (rs == "success") {
                            $("#phoneAtuhbtn").removeClass("d-none");
                            var display = $("#phoneTime");
                            // 유효시간 설정
                            var leftSec = 180;
                            // 버튼 클릭 시 시간 연장
                            clearInterval(phoneTimer);
                            phoneTimerStart(leftSec, display);
                        } else {
                        	 alert("인증번호 전송 실패.")
                        }
                    }, error: function (e) {
                        console.log(e)
                    }
                })
               
            } else {
            	 alert("올바르지 않은 형식입니다.")
            }
        })
        
        
	    //sms인증 확인 시 
        phoneAtuhbtn.addEventListener("click", function () {
            data = { "phoneAuthNumInput": phoneAuthNumInput.value }
            
            $.ajax({
                type: "post"
                , url: "${pageContext.request.contextPath}/phoneAuthNumSend.sms"
                , data: data
                , success: function (rs) {
                    console.log(rs)
                    if (rs == "success") {
                        $("#resultPhoneAuth").remove();
                        $("#sendPhonebtn").html("인증완료")
                        $("#sendPhonebtn").attr("disabled", true);
                        $("#phone").attr("disabled", true);
                        $("#phoneTime").addClass("d-none");
                        $("#ponAuthBox").addClass("d-none");
                    
                        phoneLicense = true;
                        let phoneNumber = phone.value
                        
                        $.ajax({
                        	  type: "post"
                                  , url: "${pageContext.request.contextPath}/searchId.mem"
                                  , data: {"phone":phoneNumber}
                                  , success: function (rs) {
                                	   $("#getId").html("");
                                	   $("#getId").removeClass("d-none");
                                	  if(rs == "x"){
                                		  $("#getId").html("등록된 아이디가 없습니다.");
                                	  }else if(rs == "kakao"){
                                		  $("#getId").html("카카오 sns로 회원가입 하였습니다.");
                                	  }else{
                                		  $("#getId").html("등록된 ID는 "+rs+" 입니다.");
                                	  }
                                		 
                                  }, error: function (e) {
                                      console.log(e)
                                  }
                        })
                    } else {
                    	 alert("인증번호가 틀렸습니다.")
                    }
                }, error: function (e) {
                    console.log(e)
                }
            })
        })
        
			
       //폰 타이머
            function phoneTimerStart(count, display) {
                var minutes, seconds;
                phoneTimer = setInterval(function () {
                    displayTime(count, minutes, seconds, display, phoneTimer, phoneAtuhbtn)
                    count--
                }, 1000);
            }
	    
		// 시,분,초를 화면에 표시하는 기능 
	       function displayTime(count, minutes, seconds, display, timerId, buttonId) {
               minutes = parseInt(count / 60, 10);
               seconds = parseInt(count % 60, 10);
               minutes = minutes < 10 ? "0" + minutes : minutes;
               seconds = seconds < 10 ? "0" + seconds : seconds;
               display.html(minutes + ":" + seconds);
               // 타이머 끝
               if (count < 0) {
                   clearInterval(timerId);
                   display.html("시간초과");
                   buttonId.disabled = true;
               }
           }

	     // 정규식검사 함수
        function regexTest(regex, testId) {
            let regexCheck = regex
            if (regexCheck.test(testId.value)) {
                return true;
            }
            return false;
        }
	        
	        /* =======================모달영역 끝 =========================== */
	    </script>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
		crossorigin="anonymous"></script>
</body>
</html>