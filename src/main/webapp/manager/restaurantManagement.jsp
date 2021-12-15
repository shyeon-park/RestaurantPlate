<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 : 맛집 목록</title>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet">

<style type="text/css">
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

.container {
	height: 100%;
	padding: 0;
	width: 80%;
	margin: auto;
}

.row {
	margin-left: 0;
}

.header {
	height: 200px;
	width: 100%;
	border: 1px solid black;
	position: relative;
	background-color: #333;
}

.header>div {
	position: absolute;
	top: 50%;
	transform: translate(0, -50%);
	text-align: center;
}

.header>div>p:first-child {
	font-size: 30px;
	font-weight: bold;
	color: white;
}

.header>div>p:last-child {
	font-size: 18px;
	color: lightgray;
}

.restCls {
	width: 100%;
	border: 1px solid lightgrey;
	width: 80%;
	margin: auto;
}

.restDiv {
	position: relative;
	height: 60px;
}

.restDiv>* {
	position: absolute;
	top: 50%;
	transform: translate(0, -50%);
}

/* 맛집등록 모달 */
        
        .modifyRestContainer {
          width: 90%;
          margin: auto;
        }

        .modifyRestContainer h3 {
            font-family: "twaysky";
        }

        .modifyRestContainer >.row {
            margin-top: 30px;
        }

        .addressBtn {
            width: 100%;
        }

        .pkLabel {
            margin-right: 30px;
        }
</style>
</head>
<body>
	<div class="container">
		<div class="row header">
			<div class="col-12">
				<p>맛집 목록</p>
				<p>${ldto.getList_title()}</p>
			</div>
		</div>

		<c:forEach items="${restList}" var="list">
			<div class="row restCls">
				<div class="col-1 restDiv d-flex justify-content-center">
					<p>${list.getSeq_rest()}</p>
				</div>
				<div class="col-3 restDiv d-flex justify-content-center">
					<a href="#">${list.getRest_name()}</a>
				</div>
				<div class="col-6 restDiv d-flex justify-content-start">
					<p>${list.getRest_address()}</p>
				</div>
				<div class="col-1 restDiv d-flex justify-content-center">
					<button type="button" class="btn btn-success btnRestModify"
						value="${list.getSeq_rest()}">수정</button>
				</div>
				<div class="col-1 restDiv d-flex justify-content-center">
					<button type="button" class="btn btn-dark btnRestDelete"
						value="${list.getSeq_rest()}">삭제</button>
				</div>
			</div>
		</c:forEach>

		<!-- 맛집 수정 Modal -->
		<div class="modal fade" id="modalModifyRest" data-bs-backdrop="static"
			data-bs-keyboard="false" tabindex="-1"
			aria-labelledby="staticBackdropLabel" aria-hidden="true">
			<div class="modal-dialog modal-dialog-centered"
				style="max-width: 100%; width: 50%;">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title"></h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal"
							aria-label="Close"></button>
					</div>
					<form method="post" enctype="multipart/form-data" id="modifyRestForm">
						<div class="modal-body modifyRestContainer">
							<div class="row">
								<div class="col-12" style="text-align: center;">
									<h3>맛집 수정</h3>
								</div>
							</div>
							<div class="row">
								<div class="col-12">
									<label style="margin-bottom: 4px;">음식점 이름</label> 
									<input type="text" class="form-control" id="restName" name="restName">
								</div>
							</div>

							<div class="row">
								<div class="col-12">
									<label style="margin-bottom: 4px;">음식점 소개</label> <input
										type="text" class="form-control" id="restIntro"
										name="restIntro">
								</div>
							</div>

							<div class="row">
								<label style="margin-bottom: 4px;">음식점 주소</label>
								<div class="col-6">
									<div class="input-group flex-nowrap">
										<input type="text" id="postcode" class="form-control"
											name="postcode" placeholder="우편번호" readonly>
									</div>
								</div>
								<div class="col-6">
									<input type="button" class="btn btn-dark addressBtn"
										onclick="sample4_execDaumPostcode()" value="우편번호 찾기"><br>
								</div>
							</div>
							<div class="row">
								<div class="col-12">
									<div class="input-group flex-nowrap">
										<input type="text" id="roadAddress" class="form-control"
											placeholder="도로명주소" readonly>
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col-6">
									<div class="input-group flex-nowrap">
										<input type="text" id="detailAddress" class="form-control"
											placeholder="상세주소">
									</div>
								</div>
								<div class="col-6">
									<div class="input-group flex-nowrap">
										<input type="text" id="extraAddress" class="form-control"
											placeholder="참고항목" readonly>
									</div>
								</div>
								<div class="col d-none">
									<input type="text" class="form-control" id="address"
										name="address">
								</div>
							</div>
							<div class="row">
								<div class="col-4">
									<div class="input-group flex-nowrap">
										<input type="text" id="sido" class="form-control"
											placeholder="시/도" name="sido" readonly>
									</div>
								</div>
								<div class="col-4">
									<div class="input-group flex-nowrap">
										<input type="text" id="sigungu" class="form-control"
											placeholder="시군구" name="sigungu" readonly>
									</div>
								</div>
								<div class="col-4">
									<div class="input-group flex-nowrap">
										<input type="text" id="bname" class="form-control"
											placeholder="읍/면/동" name="bname" readonly>
									</div>
								</div>
							</div>

							<div class="row">
								<label style="margin-bottom: 4px;">음식점 전화번호</label>
								<div class="col-4">
									<div class="input-group flex-nowrap">
										<input type="text" id="telNum1" class="form-control"
											maxlength=4>
									</div>
								</div>
								<div class="col-4">
									<div class="input-group flex-nowrap">
										<input type="text" id="telNum2" class="form-control"
											maxlength=4>
									</div>
								</div>
								<div class="col-4">
									<div class="input-group flex-nowrap">
										<input type="text" id="telNum3" class="form-control"
											maxlength=4>
									</div>
								</div>
								<div class="col d-none">
									<input type="text" class="form-control" id="tel" name="tel">
								</div>
							</div>

							<div class="row">
								<label style="margin-bottom: 4px;">영업시간</label>
								<div class="col-3">
									<input type="text" id="openTime"
										class="form-control timepicker" style="text-align: center;">
								</div>
								~
								<div class="col-3">
									<input type="text" id="closeTime"
										class="form-control timepicker" style="text-align: center;">
								</div>
								<div class="col-3 d-none">
									<input type="text" id="time" name="time">
								</div>
							</div>
							<div class="row">
								<div class="col-12">
									<label style="margin-bottom: 4px;" class="pkLabel">주차가능여부</label>
									<div class="form-check form-check-inline">
										<input class="form-check-input" type="checkbox"
											id="inlineCheckbox1" value="주차가능" name="parkingPossible">
										<label class="form-check-label" for="inlineCheckbox1">주차가능</label>
									</div>
									<div class="form-check form-check-inline">
										<input class="form-check-input" type="checkbox"
											id="inlineCheckbox2" value="주차불가능" name="parkingPossible">
										<label class="form-check-label" for="inlineCheckbox2">주차불가능</label>
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col-12">
									<label style="margin-bottom: 4px;" class="pkLabel">음식점
										파일첨부</label> <input type="file" class="form-control" id="restFile"
										name="restFile">
								</div>
							</div>
							<div class="row">
								<div class="col-12 d-none">
									<input type="text" name="seq_rest" id="hiddenSeqBox">
								</div>
							</div>
							<div class="row">
								<div class="col-12 d-none">
									<input type="text" name="mark_count" id="hiddenMarkCount">
								</div>
							</div>
							<div class="row">
								<div class="col-12 d-none">
									<input type="text" name="seq_list" id="hiddenSeqList">
								</div>
							</div>
						</div>
					</form>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-bs-dismiss="modal">취소</button>
						<button type="button" class="btn btn-primary" id="btnModifyComplete">수정완료</button>
					</div>
				</div>
			</div>
		</div>

	</div>

	<script
		src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script>
	// 수정버튼 클릭시
    $(".btnRestModify").on("click", function(e) {
   	 	console.log($(e.target).val());
   	 	$("#hiddenSeqBox").val($(e.target).val());
   	 
   	 	$.ajax({
   			 url: "${pageContext.request.contextPath}/getAllListInfo.re?seq_rest=" + $(e.target).val(),
   		 	 type: "get",
   		 	 dataType: "json"
   	 	}).done(function(data){
   		 console.log(data.rest_name);
   		 $("#restName").val(data.rest_name);
   		 $("#restIntro").val(data.rest_introduction);
   		 $("#postcode").val(data.postCode);
   		 $("#sido").val(data.sido);
   		 $("#sigungu").val(data.sigungu);
   		 $("#bname").val(data.bname);  		 
   		 
   		 let tel = data.rest_tel;
   		 tel = tel.split("-");
   		 $("#telNum1").val(tel[0]);
   		 $("#telNum2").val(tel[1]);
   		 $("#telNum3").val(tel[2]);
   		 
   		 let time = data.rest_time;
   		 time = time.split(" ~ ");
   		 $("#openTime").val(time[0]);
   		 $("#closeTime").val(time[1]);
   		 $("#hiddenMarkCount").val(data.mark_count);
   		 $("#hiddenSeqList").val(data.seq_list);
   		 
   	 }).fail(function(e){
   		 console.log(e);
   	 })
   	 $("#modalModifyRest").modal("show");
    })
    
    
    // 수정완료버튼 클릭 시
     $("#btnModifyComplete").on("click", function(e){
        	// regex
        	let regexTel = /^[0-9]{10,12}$/g;
        	
        	if($("#restName").val() == "") {
        		alert("음식점명을 입력하세요.");
        		return;
        	} else if($("#restIntro").val() == "") {
        		alert("음식점 소개를 입력하세요.");
        		return;
        	} else if($("#postcode").val() == "" || $("#roadAddress").val() == "") {
        		alert("음식점 주소를 입력하세요.");
        		return;
        	} else if($("#telNum1").val() == "" || $("#telNum2").val() == "" 
        			|| $("#telNum3").val() == "" || !regexTel.test(($("#telNum1").val() + $("#telNum2").val() + $("#telNum3").val()))) {
        		alert("음식점 번호를 확인하세요.");
        		return;
        	} else if($("#openTime").val() == "" || $("#closeTime").val() == ""){
        		alert("영업시간을 입력하세요.");
        		return;
        	} else if($("#restFile").val() == "") {
        		alert("파일을 첨부하세요.");
        		return;
        	}
        	
        	$("#tel").val($("#telNum1").val() + "-" + $("#telNum2").val() + "-" + $("#telNum3").val());
        	$("#address").val($("#roadAddress").val() + " " + $("#extraAddress").val() + " " + $("#detailAddress").val());
        	$("#time").val($("#openTime").val() + " ~ " + $("#closeTime").val());
        	
        	let modifyRestForm = $("#modifyRestForm")[0];
        	let formData = new FormData(modifyRestForm);
        	
        	$.ajax({
                url: "${pageContext.request.contextPath}/modifyRestProc.re",
                type: "post",
                data: formData,
                contentType: false,
                processData: false
                }).done(function (rs) {
                    if (rs == "success") {
                        alert("맛집이 수정되었습니다.");
                        getRestaurantList();
                    } else if(rs == "fail") {
                    	alert("맛집 수정에 실패했습니다.");
                    }
                }).fail(function (e) {
                    consol.log(e);
                })
                $("#restName").val("");
        		$("#restIntro").val("");
                $("#postcode").val("");
                $("#roadAddress").val("");
                $("#detailAddress").val("");
                $("#extraAddress").val("");
                $("#telNum1").val("");
                $("#telNum2").val("");
                $("#telNum3").val("");
                $("#openTime").val("");
                $("#closeTime").val("");
                $("#restFile").val("");
                $("#hiddenSeqBox").val("");
                $("#hiddenMarkCount").val("");
                $("#hiddenSeqList").val("");
                $("#modalModifyRest").modal("hide");
         })
         
         // 삭제 버튼 클릭시
        $(".btnRestDelete").on("click", function(e) {
        	 console.log($(e.target).val());
        	 if(confirm("정말로 삭제하시겠습니까?")) {
        		 $.ajax({
        			 url: "${pageContext.request.contextPath}/deleteRestProc.re?seq_rest=" + $(e.target).val(),
        			 type: "get"
        		 }).done(function(data){
        			 if(data == "success") {
        				 alert("리스트가 삭제되었습니다.");
        			 } else if(data == "fail") {
        				 alert("리스트 삭제에 실패하였습니다.");
        			 }
        		 }).fail(function(e){
        			 console.log(e);
        		 })
        	 }
         })
         
         
         // 다음 우편번호 api
         function sample4_execDaumPostcode() {
            new daum.Postcode(
                {
                    oncomplete: function (data) {

                        var roadAddr = data.roadAddress; // 도로명 주소 변수
                        var extraRoadAddr = ''; // 참고 항목 변수

                        if (data.bname !== ''
                            && /[동|로|가]$/g.test(data.bname)) {
                            extraRoadAddr += data.bname;
                        }

                        if (data.buildingName !== ''
                            && data.apartment === 'Y') {
                            extraRoadAddr += (extraRoadAddr !== '' ? ', '
                                + data.buildingName : data.buildingName);
                        }

                        if (extraRoadAddr !== '') {
                            extraRoadAddr = ' (' + extraRoadAddr + ')';
                        }

                        document.getElementById('postcode').value = data.zonecode;
                        document.getElementById("roadAddress").value = roadAddr;
                        document.getElementById("sido").value = data.sido; // 시도
                        document.getElementById("sigungu").value = data.sigungu; // 시군구
                        document.getElementById("bname").value = data.bname; // 동

                        if (roadAddr !== '') {
                            document.getElementById("extraAddress").value = extraRoadAddr;
                        } else {
                            document.getElementById("extraAddress").value = '';
                        }

                        var guideTextBox = document.getElementById("guide");
                    }
                }).open();
		}
	</script>
</body>
</html>