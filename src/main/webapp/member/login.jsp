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

a {
	font-size: small;
	text-decoration: none;
	color: black;
}
</style>
</head>
<body>
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
	<form action = "${pageContext.request.contextPath}/loginProc.mem" method = "post" id="loginForm">
	<div
		class="container h-100 d-flex flex-column justify-content-md-center">
		<div class="row">
			<div class="col-12 d-flex justify-content-center">
				<h3 class="mt-3">로그인</h3>
			</div>
			<div class="col-12 d-flex justify-content-center mt-3">
				<img src="../image/logo.jpg" alt="">
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
				<img src="../image/kakao_login_img.png" alt="" class="w-100 mt-3" id="kakoLoginBtn"
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
    	if(!idCheck()) return
    	if(!pwCheck()) return
    	
    	//console.log("형식이 모두 맞아요")
    	$("#loginForm").submit();
    })
    
   
    
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
    //d6de0aee5449f4487d8dcaa196bd5ab3
   
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