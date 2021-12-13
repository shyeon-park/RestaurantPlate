<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
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
<title>추가 정보 입력</title>

<style>
.container {
	text-align: center !important;
	width: 700px;
}
</style>
</head>


<body>

	<form id="kakaoSignupForm"
		action="${pageContext.request.contextPath}/addMember.mem"
		method="post">

		<div class="container">
			<input type="hidden" value="${kakaoInformation.get("kakaoId")}" name="id">
			<input type="hidden" value="1" name="pw">
			<h2 class="mt-3">추가 정보 입력</h2>
			<div class="row mt-3">
				<div class="col-3 d-flex justify-content-end">닉네임</div>
				<div class="col-9">
					<input type="text" class="form-control w-100" id="nickname"
						name="nickname" placeholder="영문자, 한글, 숫자 2~16자리" maxlength="16"
						value="${kakaoInformation.get("kakaoNickname")}">
				</div>
			</div>


			<div class="row mt-3" id="emailBox">
				<div class="col-3 d-flex justify-content-end">이메일</div>
				<div class="col-9">
					<input type="text" class="form-control w-100" id="email"
						name="email" placeholder="이메일 입력" maxlength="30">
				</div>
			</div>


			<div class="row mt-3" id="phoneBox">
				<div class="col-3 d-flex justify-content-end align-items-start">휴대폰
					번호</div>
				<div class="col-2">
					<select class="form-select" id="phone1">
						<option value="010" selected>010</option>
						<option value="011">011</option>
						<option value="016">016</option>
						<option value="017">017</option>
					</select>
				</div>
				<div class="col-2">
					<input type="text" class="form-control" id="phone2" maxlength="4">
				</div>
				<div class="col-2">
					<input type="text" class="form-control" id="phone3" maxlength="4">
					<input type="text" class="form-control d-none" id="phone"
						name="phone">
				</div>
				<div class="col-3">
					<button type="button" id="phoneAuthNumSend" class="w-100 h-100">인증번호
						전송</button>
				</div>
			</div>
			<div class="row mt-3 d-none" id="phoneAuth">
				<div class="col-3 d-flex justify-content-end align-items-center">휴대폰
					인증</div>
				<div class="col-6 d-flex justify-content-start align-items-center">
					<input type="text" class="form-control w-75 "
						id="phoneAuthNumInput" placeholder="인증번호 입력" maxlength="6">
					<div class="ms-1 w-25" id="phoneTime"></div>
				</div>

				<div class="col-3">
					<button type="button" id="phoneAuthNumCheck" class="w-100 h-100">확인</button>
				</div>
			</div>

			<div class="row mt-3" id=postCodeBox>
				<div class="col-3 d-flex justify-content-end align-items-center">우편번호</div>
				<div class="postcodeContentBox col-6">
					<input type="text" class="form-control w-100" id="postCode"
						name="postCode" placeholder="우편번호" readonly>
				</div>
				<div class="col-3">
					<button type="button" onclick="daumPostcode()" class="w-100 h-100"
						id="postCodeSerch">우편 번호 찾기</button>
				</div>
			</div>

			<div class="row mt-3">
				<div class="col-3 d-flex justify-content-end align-items-center">도로명주소</div>
				<div class="postcodeContentBox col-9">
					<input type="text" class="form-control inputBox" id="roadAddress"
						name="roadAddress" placeholder="도로명주소" readonly>
				</div>
			</div>

			<div class="row mt-3 detailedAddress">
				<div class="col-3 d-flex justify-content-end align-items-center">상세주소</div>
				<div class="col-9 d-flex justify-content-end align-items-center">
					<input type="text" class="form-control inputBox" id="detailAddr"
						name="detailAddr" placeholder="상세주소">
				</div>
			</div>

			<div class="row mt-3">
				<div class="col-3 d-flex justify-content-end align-items-center">읍/면/동</div>
				<div class="col-9 d-flex justify-content-end align-items-center">
					<input type="text" class="form-control inputBox" id="extraAddr"
						name="extraAddr" placeholder="읍/면/동" readonly>
				</div>
			</div>

			<div class="row mt-3">
				<div class="col-7 d-flex justify-content-end">
					<button type="button" class="btn btn-secondary" id="btnBack">취소</button>
				</div>
				<div class="col-5 d-flex justify-content-start">
					<button type="button" class="btn btn-success" id="btnSubmit">가입</button>
				</div>
			</div>

		</div>
	</form>
</body>

<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>




			let nickname = document.getElementById("nickname") // 닉네임 인풋창
            let email = document.getElementById("email") // 이메일 인풋창
            let sendEmail = document.getElementById("sendEmail") // 이메일 인증번호 전송 버튼
            let authNumCheck = document.getElementById("authNumCheck") // 이메일 인증 번호 확인 버튼
            let phone1 = document.getElementById("phone1") //첫 번째 폰 셀렉트창
            let phone2 = document.getElementById("phone2") //두 번째 폰 인풋창
            let phone3 = document.getElementById("phone3") //세 번째 폰 인풋창
            let phone = document.getElementById("phone") //핸드폰 번호 합친것

			let phoneAuthNumSend = document.getElementById("phoneAuthNumSend") // phone 인증번호 전송
            let phoneAuthNumCheck = document.getElementById("phoneAuthNumCheck") // phone 인증번호 확인
            let phoneAuthNumInput = document.getElementById("phoneAuthNumInput")// 휴대폰인증번호 Input

            let	emailLicense = false //이메일 인증 완료 여부
            let	phoneLicense = false //휴대폰 인증 완료 여부


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
                    newP = "<div class='row' id ='resultEmail'><div class='col-3 d-flex justify-content-end'></div><div class='col-6 d-flex justify-content-start m-0 mt-3'><p class = 'm-0 ms-3'style='color: red; font-size: 0.8rem;'>올바르지 않은 이메일 형식입니다.</p></div></div>"
                }
                $("#emailBox").after(newP)
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
                phone.value = phone1.value + "-" + phone2.value + "-" + phone3.value
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
                                newP = "<div class='row' id ='resultPhone'><div class='col-3 d-flex justify-content-end'></div><div class='col-6 d-flex justify-content-start m-0 mt-3'><p class = 'm-0 ms-3'style='color: red; font-size: 0.8rem;'>인증번호 전송실패</p></div></div>"
                                $("#phoneBox").after(newP)
                            }
                        }, error: function (e) {
                            console.log(e)
                        }
                    })
                } else {
                    $("#resultPhone").remove();
                    let newP
                    newP = "<div class='row' id ='resultPhone'><div class='col-3 d-flex justify-content-end'></div><div class='col-6 d-flex justify-content-start m-0 mt-3'><p class = 'm-0 ms-3'style='color: red; font-size: 0.8rem;'>올바르지 않은 형식입니다.</p></div></div>"
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
                            newP = "<div class='row' id ='resultPhoneAuth'><div class='col-3 d-flex justify-content-end'></div><div class='col-6 d-flex justify-content-start m-0 mt-3'><p class = 'm-0 ms-3'style='color: red; font-size: 0.8rem;'>인증번호가 틀렸습니다.</p></div></div>"
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
	                    newP = "<div class='row' id ='resultPostCode'><div class='col-3 d-flex justify-content-end'></div><div class='col-6 d-flex justify-content-start m-0 mt-3'><p class = 'm-0 ms-3'style='color: red; font-size: 0.8rem;'>필수 입력 사항입니다.</p></div></div>"
	                    $("#postCodeBox").after(newP)
				}	
			})
			postCodeSerch.addEventListener("click",function(){
				$("#resultPostCode").remove();
			})
			
			btnBack.addEventListener("click",function(){
				location.href="${pageContext.request.contextPath}/"
			})

			btnSubmit.addEventListener("click",function(){
				
				if(!regexTest(nicknameRegex,nickname)) return nickname.focus()
				if(!regexTest(emailRegex,email)) return email.focus();
				if(!phoneLicense){
					  $("#resultPhoneAuth").remove();
                      newP = "<div class='row' id ='resultPhoneAuth'><div class='col-3 d-flex justify-content-end'></div><div class='col-6 d-flex justify-content-start m-0 mt-3'><p class = 'm-0 ms-3'style='color: red; font-size: 0.8rem;'>휴대폰 인증을 해주세요!.</p></div></div>"
                      $("#phoneAuth").after(newP)
				   return phone2.focus()
				}
				if(postCode.value == "") return postCode.focus()
				$("#kakaoSignupForm").submit();
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
				//새로고침 값 유지 함수
				 window.addEventListener('beforeunload', (event) => { 

				 	window.location.reload(true);
				 	});

</script>
</html>