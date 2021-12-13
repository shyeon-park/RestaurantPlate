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
        .pwInputContainer .pwChangeContainer{
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
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<div class="container-fluid">
			<a class="navbar-brand" href="#">맛집 플레이트</a>
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarText"
				aria-controls="navbarText" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarText">
				<ul class="navbar-nav me-auto mb-2 mb-lg-0">
					<li class="nav-item"><a class="nav-link" aria-current="page"
						href="${pageContext.request.contextPath}/mypage.mem">내정보 수정</a></li>
					<li class="nav-item"><a class="nav-link active"
						aria-current="page"
						href="${pageContext.request.contextPath}/pwInput.mem">비밀번호 재설정</a></li>
					<li class="nav-item"><a class="nav-link"
						href="${pageContext.request.contextPath}/deleteMember.mem">회원탈퇴</a></li>
				</ul>

			</div>
		</div>
	</nav>
	<form action="${pageContext.request.contextPath}/changePw.mem" method="post" id="loginForm">
        <div class="pwInputContainer h-100 d-flex flex-column justify-content-md-center">
            <div class="row">
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
                <div class="col-12">
                    <input type="password" class="form-control mt-3" id="changePw" name="changePw" placeholder="변경할 비밀번호" onkeyup=enterkey()>
                </div>
            </div>
             <div class="row">
                <div class="col-12">
                    <input type="password" class="form-control mt-3" id="changePwCheck" placeholder="비밀번호 확인" onkeyup=enterkey()>
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
        let pw  = document.getElementById("pw")
        let changePw = document.getElementById("changePw")
        let changePwCheck = document.getElementById("changePwCheck")
            document.getElementById("btnLogin").addEventListener("click",function(){+
	    	loginFormSubmit()
	        })
	          document.getElementById("btnHome").addEventListener("click",function(){
	        	  location.href='${pageContext.request.contextPath}/home';
	        })
	        
            function loginFormSubmit() { //로그인 서브밋 함수
                if (!pwCheck()) return
                if(!changePwCheckInput()) return
                if(!changePwCheckCheck()) return
                
                $("#loginForm").submit();
            }
            function enterkey() {
                if (window.event.keyCode == 13){
                	loginFormSubmit()
                }
            }
            //password 정규식 
            //8~16자리 영문자 숫자 특문 포함
            function pwCheck() {
                let regex = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*?&])[A-Za-z\d$@$!%*?&]{8,16}/g
                let pw = document.getElementById("pw")
                if (!check(regex, pw.value, pw, "올바르지 않은 비밀번호 형식입니다. 비밀번호를 확인해주세요.")) {
                    return false;
                }
                return true;
            }
            
            
            //정규식이 맞으면 true 반환 틀리면 false 반환 후 틀린부분 focus
            function changePwCheckInput() {
            	$("#pwCheckText").remove();
                let regex = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*?&])[A-Za-z\d$@$!%*?&]{8,16}/g
                let pw = document.getElementById("changePw")
                if (!check(regex, pw.value, pw, "올바르지 않은 비밀번호 형식입니다. 변경 할 비밀번호를 확인해주세요")) {
                    return false;
                }
                return true;
            }//정규식이 맞으면 true 반환 틀리면 false 반환 후 틀린부분 focus
           
            
            function changePwCheckCheck() {
            	$("#pwCheckText2").remove();
                let regex = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*?&])[A-Za-z\d$@$!%*?&]{8,16}/g
                let pw = document.getElementById("changePwCheck")
                if (!check(regex, pw.value, pw, "올바르지 않은 비밀번호 형식입니다. 변경할 비밀번호 확인을 확인해주세요.")) {
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
            
            
            // 비밀번호 확인 검사
           changePwCheck.addEventListener("keyup", function () {
                $(".pwCheckText").remove();
                if (checkPassword() == "불일치") newP = "<p class = 'pwCheckText mt-0 ms-3'style='color: red; font-size: 0.8rem;' >비밀번호가 일치하지 않습니다</p>"
                else if (checkPassword() == "빈칸") newP = "<p class = 'pwCheckText mt-0 ms-3'style='color: red; font-size: 0.8rem;' >비밀번호가 일치하지 않습니다</p>"
                else if (checkPassword() == "일치") newP = "<p class='pwCheckText'></p>"
                $("#changePwCheck").after(newP)

            })
            // 비밀번호에 변화가 생겼을 때
            changePwCheck.addEventListener("change", function () {
               $(".pwCheckText").remove();
                if (checkPassword() == "불일치") newP = "<p class = 'pwCheckText mt-0 ms-3'style='color: red; font-size: 0.8rem;' >비밀번호가 일치하지 않습니다</p>"
                else if (checkPassword() == "빈칸") newP = "<p class = 'pwCheckText mt-0 ms-3'style='color: red; font-size: 0.8rem;' >비밀번호가 일치하지 않습니다</p>"
               else if (checkPassword() == "일치") newP = "<p class='pwCheckText'></p>"
               $("#changePwCheck").after(newP)
            })
            //비밀번호 확인함수
            function checkPassword() {
                if ((changePwCheck.value !== "")) {
                    if (changePw.value == changePwCheck.value) {
                        return "일치"
                    } else {
                        return "불일치"
                    }
                } else {
                    return "빈칸"
                }
            }

        </script>

	    
	</body>
	</html>