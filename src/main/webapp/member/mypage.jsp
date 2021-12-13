<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
<title>mypage</title>
<style>
.container {
	margin: auto;
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
					<li class="nav-item"><a class="nav-link active"
						aria-current="page" href="${pageContext.request.contextPath}/mypage.mem">내정보 수정</a></li>
						<li class="nav-item"><a class="nav-link"
						aria-current="page" href="${pageContext.request.contextPath}/pwInput.mem">비밀번호 재설정</a></li>
					<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/deleteMember.mem">회원탈퇴</a></li>
				</ul>

			</div>
		</div>
	</nav>
	<form action="${pageContext.request.contextPath}/modifyProc.mem"
		method="post" id="mypageModifyForm">
		<div class="container">
			<div class="row mt-3">
				<div class="col-12 col-md-2 d-flex justify-content-lg-end">닉네임</div>
				<div class="col-12 col-md-10">
					<input type="text" class="form-control w-100" id="nickname"
						name="nickname" placeholder="영문자, 한글, 숫자 2~16자리" maxlength="16"
						value="${dto.getUser_nickname()}" readonly>
				</div>
			</div>


			<div class="row mt-3" id="emailBox">
				<div class="col-12 col-md-2 d-flex justify-content-lg-end">이메일</div>
				<div class="col-12 col-md-10">
					<input type="text" class="form-control w-100" id="email"
						name="email" placeholder="이메일 입력" maxlength="30"
						value="${dto.getUser_email()}" readonly>
				</div>
			</div>


			<div class="row mt-2" id="phoneBox">
				<div class="col-12 col-md-2 d-flex justify-content-lg-end">휴대폰
					번호</div>

				<div class="col-12 col-md-8 d-flex justify-content-lg-end">
					<input type="text" class="form-control" id="phone" name="phone"
						maxlength="13" value="${dto.getUser_phone()}" readonly>
				</div>
				<div class="col-12 col-md-2 d-flex justify-content-lg-end">
					<button type="button" id="phoneAuthNumSend" class="w-100 h-100"
						disabled>인증완료</button>
				</div>
			</div>
			<div class="row mt-3 d-none" id="phoneAuth">
				<div class="col-12 col-md-2 d-flex justify-content-lg-end">휴대폰
					인증</div>
				<div class="col-12 col-md-8 d-flex">
					<input type="text" class="form-control w-75 "
						id="phoneAuthNumInput" placeholder="인증번호 입력" maxlength="6">
					<div
						class="ms-1 w-25 d-flex justify-content-center align-items-center"
						id="phoneTime"></div>
				</div>

				<div class="col-12 col-md-2">
					<button type="button" id="phoneAuthNumCheck" class="w-100 h-100">확인</button>
				</div>
			</div>

			<div class="row mt-3" id=postCodeBox>
				<div class="col-12 col-md-2 d-flex justify-content-lg-end">우편번호</div>
				<div class="col-12 col-md-8 d-flex justify-content-lg-end">
					<input type="text" class="form-control w-100" id="postCode"
						name="postCode" placeholder="우편번호" readonly
						value="${dto.getPost_code()}">
				</div>
				<div class="col-12 col-md-2 d-flex justify-content-lg-end">
					<button type="button" onclick="daumPostcode()" class="w-100 h-100"
						id="postCodeSerch">우편 번호 찾기</button>
				</div>
			</div>

			<div class="row mt-3">
				<div class="col-12 col-md-2 d-flex justify-content-lg-end">도로명주소</div>
				<div
					class="postcodeContentBox col-12 col-md-10 d-flex justify-content-lg-end">
					<input type="text" class="form-control inputBox" id="roadAddress"
						name="roadAddress" placeholder="도로명주소" readonly
						value="${dto.getRoad_addr()}">
				</div>
			</div>

			<div class="row mt-3 detailedAddress">
				<div class="col-12 col-md-2 d-flex justify-content-lg-end">상세주소</div>
				<div class="col-12 col-md-10 d-flex justify-content-lg-end">
					<input type="text" class="form-control inputBox" id="detailAddr"
						name="detailAddr" placeholder="상세주소"
						value="${dto.getDetail_addr()}" readonly>
				</div>
			</div>

			<div class="row mt-3">
				<div class="col-12 col-md-2 d-flex justify-content-lg-end">읍/면/동</div>
				<div class="col-12 col-md-10 d-flex justify-content-lg-end">
					<input type="text" class="form-control inputBox" id="extraAddr"
						name="extraAddr" placeholder="읍/면/동" readonly
						value="${dto.getExtra_addr()}">
				</div>
			</div>

			<div class="row mt-3">
				<div class="col-7 d-flex justify-content-end">
					<button type="button" class="btn btn-secondary" id="btnBack">홈으로</button>
				</div>
				<div class="col-5 d-flex justify-content-start">
					<button type="button" class="btn btn-success" id="btnSubmit">수정</button>
				</div>
			</div>

		</div>
		</div>
	</form>
	<script>




let nickname = document.getElementById("nickname") // 닉네임 인풋창
let email = document.getElementById("email") // 이메일 인풋창
let sendEmail = document.getElementById("sendEmail") // 이메일 인증번호 전송 버튼
let authNumCheck = document.getElementById("authNumCheck") // 이메일 인증 번호 확인 버튼
let phone = document.getElementById("phone") //핸드폰 번호 합친것

let phoneAuthNumSend = document.getElementById("phoneAuthNumSend") // phone 인증번호 전송
let phoneAuthNumCheck = document.getElementById("phoneAuthNumCheck") // phone 인증번호 확인
let phoneAuthNumInput = document.getElementById("phoneAuthNumInput")// 휴대폰인증번호 Input

let	phoneLicense = true //휴대폰 인증 완료 여부


  //g라는 플래그가 없어야지만 한 번만 찾고 포인터초기화

let nicknameRegex = /[ㄱ-힣a-zA-Z0-9]{2,16}/
let emailRegex = /^[a-zA-Z][a-zA-Z0-9_.]+@[a-zA-Z0-9]+\.[a-zA-z]{2,3}(:?\.[a-zA-z]{2,3})?$/
let phoneRegex = /[0-9]{3}-[0-9]{4}-[0-9]{4}/
let phoneTimer = null; // sms 인증 timer

  // 주소 관련 요소 선택
  let postCodeSerch = document.getElementById("postCodeSerch")
let postCode = document.getElementById("postCode");
let roadAddr = document.getElementById("roadAddress");
let detailAddr = document.getElementById("detailAddr");
let extraAddr = document.getElementById("extraAddr");
let btnBack = document.getElementById("btnBack");
let btnSubmit = document.getElementById("btnSubmit");

   // 닉네임 검사
   nickname.addEventListener("blur", function () {
    $("#resultNickname").remove();
    let newP
    if (regexTest(nicknameRegex, nickname)) {
        newP = "<div id ='resultNickname'></div>"
    } else {
        newP = "<div class='d-flex justify-content-start mt-3' id ='resultNickname'><p class = 'm-0 ms-3'style='color: red; font-size: 0.8rem;'>올바르지 않은 형식입니다.</p></div>"
    }
    $("#nickname").after(newP)
})

   //이메일 검사
   email.addEventListener("blur", function () {
    $("#resultEmail").remove();
    let newP
    if (regexTest(emailRegex, email)) {
        newP = "<div id ='resultEmail'></div>"
    } else {
        newP = "<div class='row' id ='resultEmail'><div class='col-2 d-flex justify-content-end'></div><div class='col-6 d-flex justify-content-start m-0 mt-3'><p class = 'm-0 ms-3'style='color: red; font-size: 0.8rem;'>올바르지 않은 이메일 형식입니다.</p></div></div>"
    }
    $("#emailBox").after(newP)
})
   //phone 검사
   phone.addEventListener("blur", function () {
	   $("#resultPhone").remove();
	   let newP
	    if (regexTest(phoneRegex, phone)) {
	        	   if("${dto.getUser_phone()}" == phone.value ){
	        			phoneLicense = true
	        			phoneAuthNumSend.disabled=true
	        			phoneAuthNumSend.innerHTML="인증완료"
	        			$("#resultPhoneAuth").remove();
	        			return
	        		}else{
	        			phoneLicense = false
	        			phoneAuthNumSend.disabled=false
	        			phoneAuthNumSend.innerHTML="인증필요"
	        			  $("#resultPhoneAuth").remove();
	        	        newP = "<div class='row' id ='resultPhoneAuth'><div class='col-2 d-flex justify-content-end'></div><div class='col-6 d-flex justify-content-start m-0 mt-3'><p class = 'm-0 ms-3'style='color: red; font-size: 0.8rem;'>휴대폰 인증을 해주세요!.</p></div></div>"
	        	        $("#phoneAuth").after(newP)
	        		    return
	        		}
	    } else {
	    	newP = "<div class='row' id ='resultPhone'><div class='col-2 d-flex justify-content-end'></div><div class='col-6 d-flex justify-content-start m-0 mt-3'><p class = 'm-0 ms-3'style='color: red; font-size: 0.8rem;'>올바르지 않은 형식입니다.(010-0000-0000)</p></div></div>"
	    }
	    $("#phoneBox").after(newP)
    
 

})

     // 정규식검사 함수
     function regexTest(regex, testId) {
    let regexCheck = regex
    if (regexCheck.test(testId.value)) {
        return true;
    }
    return false;
}

    //폰 타이머
    function phoneTimerStart(count, display) {
    var minutes, seconds;
    phoneTimer = setInterval(function () {
        displayTime(count, minutes, seconds, display, phoneTimer, phoneAuthNumCheck)
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
     //sms인증문자 전송 시 
     phoneAuthNumSend.addEventListener("click", function () {
    $("#resultPhone").remove();
    
    if (regexTest(phoneRegex, phone)) {
        let phoneNumber = phone.value
        $("#phoneAuthNumCheck").attr("disabled", false);
        data = { "rphone": phone.value }
        $.ajax({
            type: "post"
            , url: "${pageContext.request.contextPath}/SmsSend.sms"
            , data: data
            , success: function (rs) {
                console.log(rs)
                if (rs == "success") {
                    $("#phoneAuth").removeClass("d-none");
                    var display = $("#phoneTime");
                    // 유효시간 설정
                    var leftSec = 180;
                    // 버튼 클릭 시 시간 연장
                    clearInterval(phoneTimer);
                    phoneTimerStart(leftSec, display);
                } else {
                    $("#resultPhone").remove();
                    newP = "<div class='row' id ='resultPhone'><div class='col-2 d-flex justify-content-end'></div><div class='col-6 d-flex justify-content-start m-0 mt-3'><p class = 'm-0 ms-3'style='color: red; font-size: 0.8rem;'>인증번호 전송실패</p></div></div>"
                    $("#phoneBox").after(newP)
                }
            }, error: function (e) {
                console.log(e)
            }
        })
    } else {
        $("#resultPhone").remove();
        let newP
        newP = "<div class='row' id ='resultPhone'><div class='col-2 d-flex justify-content-end'></div><div class='col-6 d-flex justify-content-start m-0 mt-3'><p class = 'm-0 ms-3'style='color: red; font-size: 0.8rem;'>올바르지 않은 형식입니다.(010-0000-0000)</p></div></div>"
        $("#phoneBox").after(newP)
    }
})

//sms인증 확인 시 
phoneAuthNumCheck.addEventListener("click", function () {
    data = { "phoneAuthNumInput": phoneAuthNumInput.value }
    console.log(data)
    $.ajax({
        type: "post"
        , url: "${pageContext.request.contextPath}/phoneAuthNumSend.sms"
        , data: data
        , success: function (rs) {
            console.log(rs)
            if (rs == "success") {
                $("#resultPhoneAuth").remove();
                $("#phoneAuth").addClass("d-none");
                $("#phoneAuthNumSend").html("인증완료")
                $("#phoneAuthNumSend").attr("disabled", true);
                $("#phone1").attr("disabled", true);
                $("#phone2").attr("disabled", true);
                $("#phone3").attr("disabled", true);
                $("#phoneAuthNumCheck").attr("disabled", true);
                phoneLicense = true;
            } else {
                $("#resultPhoneAuth").remove();
                newP = "<div class='row' id ='resultPhoneAuth'><div class='col-2 d-flex justify-content-end'></div><div class='col-6 d-flex justify-content-start m-0 mt-3'><p class = 'm-0 ms-3'style='color: red; font-size: 0.8rem;'>인증번호가 틀렸습니다.</p></div></div>"
                $("#phoneAuth").after(newP)
            }
        }, error: function (e) {
            console.log(e)
        }
    })
})

//우편번호 포커스에서 벗어났을 때 값이 비어있으면 필수입력사항이라고 표시해준다.
postCode.addEventListener("blur",function(){
    if( postCode.value == ""){
          $("#resultPostCode").remove();
            let newP
            newP = "<div class='row' id ='resultPostCode'><div class='col-2 d-flex justify-content-end'></div><div class='col-6 d-flex justify-content-start m-0 mt-3'><p class = 'm-0 ms-3'style='color: red; font-size: 0.8rem;'>필수 입력 사항입니다.</p></div></div>"
            $("#postCodeBox").after(newP)
    }	
})
postCodeSerch.addEventListener("click",function(){
    $("#resultPostCode").remove();
})

btnBack.addEventListener("click",function(){
	console.log(btnBack.innerHTML)
    if(btnBack.innerHTML == "홈으로"){
        location.href="${pageContext.request.contextPath}/"
    }else{
    	location.href="${pageContext.request.contextPath}/mypage.mem"

    }
    
})

btnSubmit.addEventListener("click",function(){
    if(btnSubmit.innerHTML == "수정"){
      btnSubmit.innerHTML = "완료" 
      btnBack.innerHTML = "취소"
      
      nickname.readOnly = false
      email.readOnly = false
      phone.readOnly = false
      nickname.readOnly = false
      detailAddr.readOnly =false
      

	
    }else{ // 완료 버튼을 눌렀을 때 
    	
    	if(!regexTest(nicknameRegex,nickname)) return nickname.focus()
		if(!regexTest(emailRegex,email)) return email.focus();
    
    	if(!phoneLicense){
			  $("#resultPhoneAuth").remove();
            newP = "<div class='row' id ='resultPhoneAuth'><div class='col-2 d-flex justify-content-end'></div><div class='col-6 d-flex justify-content-start m-0 mt-3'><p class = 'm-0 ms-3'style='color: red; font-size: 0.8rem;'>휴대폰 인증을 해주세요!.</p></div></div>"
            $("#phoneAuth").after(newP)
		   return phone.focus()
		   }
		if(postCode.value == "") return postCode.focus()
    	$("#mypageModifyForm").submit();
       
    }
    
})

function daumPostcode() {
    new daum.Postcode({
        oncomplete: function (data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var roadAddr = data.roadAddress; // 도로명 주소 변수
            var extraRoadAddr = ''; // 참고 항목 변수

            // 법정동명이 있을 경우 추가한다. (법정리는 제외)
            // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
            if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
                extraRoadAddr += data.bname;
            }
            // 건물명이 있고, 공동주택일 경우 추가한다.
            if (data.buildingName !== '' && data.apartment === 'Y') {
                extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
            }
            // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
            if (extraRoadAddr !== '') {
                extraRoadAddr = ' (' + extraRoadAddr + ')';
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('postCode').value = data.zonecode;
            document.getElementById("roadAddress").value = roadAddr;


            // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
            if (roadAddr !== '') {
                document.getElementById("extraAddr").value = extraRoadAddr;
            } else {
                document.getElementById("extraAddr").value = '';
            }
        }
    }).open();
}
</script>
	<script
		src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
		crossorigin="anonymous"></script>
</body>
</body>
</html>