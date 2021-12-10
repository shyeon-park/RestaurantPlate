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
	
	<title>비밀번호 입력</title>
	
   <style>
        .container {
            width: 800px;
        }

        .searchIdContiner {
            margin: auto !important;
            text-align: center;
        }

        .positionTest {
            position: relative;
        }
    </style>
	</head>
	
	<body>
	<form action="${pageContext.request.contextPath}/mypage.mem" method="post" id="loginForm">
        <div class="container h-100 d-flex flex-column justify-content-md-center">
            <div class="row">
            <input type="" class ="d-none"> 
            <!-- 인풋창이 한 개일 때 자동으로 서브밋 된다. -->
                <div class="col-12 d-flex justify-content-center">
                    <h3 class="mt-3">비밀번호 입력</h3>
                </div>
            </div>
            <div class="row">
                <div class="col-12">
                    <input type="password" class="form-control mt-3" id="pw" name="pw" placeholder="비밀번호" onkeyup=enterkey()>
                </div>
            </div>
            <div class="row">
                <div class="col-12 d-flex justify-content-center">
                    <button type="button" class="btn btn-dark w-100 mt-3 me-3" id="btnHome"
                    style="height: 40px;">홈으로 돌아가기</button>
                    <button type="button" class="btn btn-dark w-100 mt-3" id="btnLogin"
                    style="height: 40px;">확인</button>
                </div>
            </div>

        </div>
        </form>
        <script>
            document.getElementById("btnLogin").addEventListener("click",function(){
	    	loginFormSubmit()
	        })
            function loginFormSubmit() { //로그인 서브밋 함수
                if (!pwCheck()) { //fase
                    return
                }
                $("#loginForm").submit();
            }
            function enterkey() {
                if (window.event.keyCode == 13) $("#loginForm").submit();
            }
            //password 정규식 
            //8~16자리 영문자 숫자 특문 포함
            function pwCheck() {
                let regex = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*?&])[A-Za-z\d$@$!%*?&]{8,16}/g
                let pw = document.getElementById("pw")
                if (!check(regex, pw.value, pw, "올바르지 않은 비밀번호 형식입니다.")) {
                    return false;
                }
                return true;
            }//정규식이 맞으면 true 반환 틀리면 false 반환 후 틀린부분 focus
            function check(pattern, taget, id, message) {
                if (pattern.test(taget)) {
                    return true;
                }
                alert(message);
                id.focus();
                return false;
            }
            
        </script>

	    
	</body>
	</html>