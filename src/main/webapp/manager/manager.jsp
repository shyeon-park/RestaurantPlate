<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link href="listManagement.css" rel="stylesheet" type="text/css">
<script
	src="//cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.js"></script>
<link rel="stylesheet"
	href="//cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.css">
<title>관리자 페이지 : 메인</title>

<style>
@import url(//fonts.googleapis.com/earlyaccess/notosanskr.css);

.notosanskr * {
	font-family: 'Noto Sans KR', sans-serif;
}

@font-face {
	font-family: 'twaysky';
	src:
		url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_tway@1.0/twaysky.woff')
		format('woff');
	font-weight: normal;
	font-style: normal;
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

/* 네비 */
.navi {
	float: left;
	width: 20%;
	height: 1000px;
	background-color: #333;
	padding-top: 200px;
}

.logo {
	font-size: 40px;
	font-weight: bold;
	cursor: pointer;
}

.logo>div {
	text-align: center;
}

.menubox {
	height: 500px;
	display: flex;
	flex-direction: column;
	justify-content: space-around;
	align-items: flex-end;
	font-weight: bold;
	font-size: 30px;
}

.menubox>div {
	color: white;
	text-align: center;
}

.menubox>.col-12:hover {
	background-color: white;
	color: #333;
	cursor: pointer;
}

/* 메인 */
.mainManeger {
	float: left;
	width: 80%;
	height: 1000px;
}

.managerView {
	width: 80%;
	height: 100%;
	margin: auto;
}

.txtCls {
	/*margin-top: 100px;*/
	margin-bottom: 50px;
}




/* 리스트 관리 영역 */
.header {
	height: 200px;
	width: 100%;
	border: 1px solid black;
	background-color: #333;
	position: relative;
	margin: 0;
}

.header>div {
	position: absolute;
	top: 50%;
	transform: translate(0, -50%);
	text-align: center;
}

.header>div>p {
	font-size: 30px;
	font-weight: bold;
	color: white;
}

.seq_list {
	position: relative;
}

.seq_list>p {
	display: inline;
	position: absolute;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
}

.list_title {
	position: relative;
}

.list_title>a {
	position: absolute;
	top: 50%;
	transform: translate(0, -50%);
	text-decoration: none;
	color: black;
}

.num {
	text-align: center;
}

.dynamicBtnCls {
	text-align: center;
}

.naviTd {
	border: none;
}

/*수정 모달*/
#hiddenSeq_list {
	display: none;
}

/* 맛집등록 모달 */
.addRestContainer {
	width: 90%;
	margin: auto;
}

.addRestContainer h3 {
	font-family: "twaysky";
}

.addRestContainer>.row {
	margin-top: 30px;
}

.addressBtn {
	width: 100%;
}

.pkLabel {
	margin-right: 30px;
}

.ui-timepicker-container {
	z-index: 1151 !important;
	position: absolute;
}

.page-link {
	color: #333;
}





/* 회원관리 영역*/




/* 리뷰관리 영역 */
</style>
</head>
<body>

	<div class="navi">
		<div class="logo">
			<div class="col-12">
				<a href="${pageContext.request.contextPath}/checkBoxDelMem">맛집플레이트</a>
			</div>
		</div>
		<div class="menubox">
			<div class="col-12" id="member">회원관리</div>
			<div class="col-12" id="list">맛집리스트</div>
			<div class="col-12" id="review">리뷰관리</div>
		</div>
	</div>


	<div class="mainManeger">
		<div class="managerView">
			<div class="txtCls">
				<h2>관리자 페이지</h2>
			</div>

			<div class="headDiv"></div>

			<table class="table table-bordered list-table">
				<thead id="table_head">


				</thead>
				<tbody id="table_body">


				</tbody>
			</table>
			<div class="row btnCls"></div>








			<!-- 리스트 등록 Modal -->
			<div class="modal fade" id="modalReg" data-bs-backdrop="static"
				data-bs-keyboard="false" tabindex="-1"
				aria-labelledby="staticBackdropLabel" aria-hidden="true">
				<div class="modal-dialog modal-dialog-centered">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="staticBackdropLabel">리스트 등록</h5>
							<button type="button" class="btn-close" data-bs-dismiss="modal"
								aria-label="Close"></button>
						</div>
						<form method="post" enctype="multipart/form-data" id="addListForm">
							<div class="modal-body">
								<div class="row">
									<div class="col-12" style="margin-bottom: 20px;">
										<label style="margin-bottom: 10px;">리스트 제목</label> <input
											type="text" class="form-control" id="title"
											placeholder="리스트 제목을 입력해주세요." name="title">
									</div>
								</div>
								<div class="row">
									<div class="col-12">
										<label style="margin-bottom: 10px;">리스트 사진첨부</label> <input
											type="file" class="form-control" id="listImg" name="listImg">
									</div>
								</div>
							</div>
						</form>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary"
								data-bs-dismiss="modal">취소</button>
							<button type="button" class="btn btn-primary" id="btnReg">등록</button>
						</div>
					</div>
				</div>
			</div>

			<!-- 리스트 수정 Modal -->
			<div class="modal fade" id="modalModify" data-bs-backdrop="static"
				data-bs-keyboard="false" tabindex="-1"
				aria-labelledby="staticBackdropLabel" aria-hidden="true">
				<div class="modal-dialog modal-dialog-centered">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title">리스트 수정</h5>
							<button type="button" class="btn-close" data-bs-dismiss="modal"
								aria-label="Close"></button>
						</div>
						<form method="post" enctype="multipart/form-data"
							id="modifyListForm">
							<div class="modal-body">
								<div class="row">
									<div class="col-12 modifyListTitle"
										style="margin-bottom: 20px;">
										<label style="margin-bottom: 10px;" id="labelTitle">리스트
											제목</label>
									</div>
								</div>
								<div class="row">
									<div class="col-12">
										<label style="margin-bottom: 10px;">리스트 사진첨부</label> <input
											type="file" class="form-control" id="listImgModify"
											name="listImg">
									</div>
								</div>
							</div>
						</form>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary"
								data-bs-dismiss="modal">취소</button>
							<button type="button" class="btn btn-primary"
								id="btnModifyComplete">수정완료</button>
						</div>
					</div>
				</div>
			</div>

			<!-- 맛집 등록 Modal -->
			<div class="modal fade" id="modalAddRest" data-bs-backdrop="static"
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
						<form method="post" enctype="multipart/form-data" id="addRestForm">
							<div class="modal-body addRestContainer">
								<div class="row">
									<div class="col-12" style="text-align: center;">
										<h3>맛집 등록</h3>
									</div>
								</div>
								<div class="row">
									<div class="col-12">
										<label style="margin-bottom: 4px;">음식점 이름</label> <input
											type="text" class="form-control" id="restName"
											name="restName">
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
										<input type="text" name="seq_list" id="hiddenSeqBox">
									</div>
								</div>
							</div>
						</form>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary"
								data-bs-dismiss="modal">취소</button>
							<button type="button" class="btn btn-primary" id="btnAdd-rest">등록하기</button>
						</div>
					</div>
				</div>
			</div>



		</div>


	</div>

	<script
		src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script>
	// 다음 우편번호 api
	function sample4_execDaumPostcode() {
		new daum.Postcode(
				{
					oncomplete : function(data) {

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
	<script>
	
	// 로드될 시
	$(document).ready(function(){
		// 체크박스 하나만 선택 가능
		$(".form-check-input").click(function() {
			if ($(this).prop('checked')) {
				$(".form-check-input").prop('checked', false);
				$(this).prop('checked', true);
			}
		});
	})
	
	let startNavi = "";
	let endNavi = "";
	
	
	document.getElementById("member").addEventListener("click",function(){
    	getCommentList(1);
        //location.href = "${pageContext.request.contextPath}/getMemberList.mem?currentPage=1"
    })
    document.getElementById("list").addEventListener("click",function(){
    	getListByCurrentPage(1);
    })
    document.getElementById("review").addEventListener("click",function(){
        //location.href = ""
    })
    
    
    
	// 리스트 관리 스크립트 영역
	// 해당 currentPage에 속하는 리스트 목록을 불러오는 작업
	function getListByCurrentPage(e) {
		
		$.ajax({
	        url: "${pageContex.request.contextPath}/getListProc.li?currentPage=" + e,
	        type: "get",
	        dataType: "json"
	        }).done(function (data) {
	        	console.log(data);
	        	$(".headDiv").empty();
	        	$("#table_head").empty();
	        	$("#table_body").empty();
	        	$(".btnCls").empty();
	        	
	        	startNavi = data.startNavi;
				endNavi = data.endNavi;

				let head = "<div class='row header'><div class='col-12'><p>맛집 리스트 관리</p></div></div>";
				$(".headDiv").append(head);
	        	
	        	let thead = "<tr><th class='col-1 num'>번호</th><th colspan='4'>리스트 제목</th></tr>";
	        	$("#table_head").append(thead);

	            for (let listDto of data.list) {
	                let totalList = "<tr><td class='seq_list'>" +"<p>"+ listDto.seq_list+"</p>"
	                    + "</td><td class='list_title'>"
	                    + "<a href='${pageContext.request.contextPath}/toRestManagerView.re?seq_list=" + listDto.seq_list + "'>" + listDto.list_title + "</a></td>"
	                    + "<td class='col-1 dynamicBtnCls'>"
	                    + "<button type='button' class='btn btn-warning' id='btnModifyList' value='" + listDto.seq_list + "'>수정</button></td>"
	                    + "<td class='col-1 dynamicBtnCls'>"
	                    + "<button type='button' class='btn btn-danger' id='btnDeleteList' value='" + listDto.seq_list + "'>삭제</button></td>"
	                    + "<td class='col-2 dynamicBtnCls'>"
	                    + "<button type='button' class='btn btn-dark' id='btnAddRestaurnat' value='" + listDto.seq_list + "'>맛집등록</button></td></tr>";
	               		$("#table_body").append(totalList);
	            }
	            
	            let str1 ="";
				let str2 = "";
				let str3 = "";
				
				if(data.needPrev == true){
					str1 = "<li class='page-item'><a class='page-link' href='javascript:void(0)' onclick='getListByCurrentPage(Number(" + startNavi + ")-1);'>Prev</a></li>";
				}
				
				Number(endNavi)+1
				for(let j = data.startNavi; j <= data.endNavi; j++){
					str2 += "<li class='page-item'><a class='page-link' href='javascript:void(0)' onclick='getListByCurrentPage(" + j + ");'>" + j + "</a></li>";
				}
				
				if(data.needNext == true){
					str3 = "<li class='page-item'><a class='page-link' href='javascript:void(0)' onclick='getListByCurrentPage(Number(" + endNavi + ")+1);'>Next</a></li>";
				}
				let nav = "<td colspan='5' class='naviTd'>"
							+"<nav class='col' aria-label='Page navigation example'>"
							+"<ul class='pagination justify-content-center'>"
						 	+ str1 + str2 + str3
							+"</ul>"  
							+"</nav>"  	
							+"</td>";  
				$("#table_body").append(nav);
				
				let btnCls = "<div class='col-12 d-flex justify-content-end'>" 
							+ "<button type='button' class='btn btn-dark' data-bs-toggle='modal'" 
							+ "data-bs-target='#staticBackdrop' id='btnAddList'>리스트 추가하기</button></div>";
	            
				$(".btnCls").append(btnCls);
	            
	            //let hiddenCurrentBox = "<input type='text' id='hiddenCurrentPage' class='d-none' value='" + data.currentPage + "'>";
	            //$(".hiddenPageBox").append(hiddenCurrentBox);
	            
	       	   }).fail(function (e) {
	          	  console.log(e);
	           })
	    
	    }
	
	// 리스트 추가하기 버튼 클릭 시
	$(document).on("click", "#btnAddList", function() {
		$("#title").val("");
		$("#listImg").val("");
		$("#modalReg").modal("show");
	})

	// 등록버튼 클릭 시
	$("#btnReg").on("click", function() {
		let addListForm = $("#addListForm")[0];
		let formData = new FormData(addListForm);

		if ($("#title").val() == "") {
			alert("리스트 제목을 입력하세요.");
			return;
		} else if ($("#listImg").val() == "") {
			alert("리스트 사진파일을 등록하세요.");
			return;
		}

		$.ajax({
			url : "${pageContext.request.contextPath}/addListProc.li",
			type : "post",
			data : formData,
			contentType : false,
			processData : false
		}).done(function(rs) {
			if (rs == "success") {
				alert("리스트가 등록되었습니다.");
				getListByCurrentPage(1);
			} else if (rs == "fail") {
				alert("리스트 등록에 실패했습니다.");
			}
		}).fail(function(e) {
			consol.log(e);
		})
		$("#title").val("");
		$("#listImg").val("");
		$("#modalReg").modal("hide");
	})

	// 수정버튼 클릭시
	$(document).on("click", "#btnModifyList", function(e) {
		console.log($(e.target).val());
		
		$.ajax({
			url : "${pageContext.request.contextPath}/getAllListInfo.li?seq_list=" + $(e.target).val(),
			type : "get",
			dataType : "json"
		}).done(function(rs) {
			$(".modifyListTitle").children().remove("input");
											
			console.log(rs.list_title);
			let inputs = "<input type='text' id='titleInput' class='form-control' name='title' value='" + rs.list_title + "'>"
						+ "<input type='text' id='hiddenSeq_list' name='seq_list' value='" + rs.seq_list + "'>";
			$(".modifyListTitle").append(inputs);
		}).fail(function(e) {
			console.log(e);
		})
		$("#modalModify").modal("show");
	})

	// 수정완료버튼 클릭시
	$("#btnModifyComplete").on("click", function() {
		console.log($("#hiddenSeq_list").val());
		let modifyListForm = $("#modifyListForm")[0];
		let formData = new FormData(modifyListForm);
		console.log(modifyListForm);

		if ($("#titleInput").val() == "") {
			alert("리스트 제목을 입력하세요.");
			return;
		}

		$.ajax({
			url : "${pageContext.request.contextPath}/modifyListProc.li",
			type : "post",
			data : formData,
			contentType : false,
			processData : false
		}).done(function(rs) {
			if (rs == "success") {
				alert("리스트가 수정되었습니다.");
				getListByCurrentPage(1);
			} else if (rs == "fail") {
				alert("리스트 수정에 실패했습니다.");
			}
		}).fail(function(e) {
			consol.log(e);
		})
		$("#titleInput").val("");
		$("#listImgModify").val("");
		$("#modalModify").modal("hide");
	})

	// 삭제 버튼 클릭시
	$(document).on("click", "#btnDeleteList", function(e) {
		console.log($(e.target).val());
		if (confirm("정말로 삭제하시겠습니까?")) {
			$.ajax({
				url : "${pageContext.request.contextPath}/deleteListProc.li?seq_list=" + $(e.target).val(),
				type : "get"
			}).done(function(data) {
				if (data == "success") {
					alert("리스트가 삭제되었습니다.");
					getListByCurrentPage(1);
				} else if (data == "fail") {
					alert("리스트 삭제에 실패하였습니다.");
				}
			}).fail(function(e) {
				console.log(e);
			})
		}
	})

	// 맛집등록 버튼 클릭 시
	$(document).on("click", "#btnAddRestaurnat", function(e) {
		$("#hiddenSeqBox").val($(e.target).val());
		console.log($("#hiddenSeqBox").val());
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
		$("input:checkbox[name='parkingPossible']").attr("checked", false);
		$("#restFile").val("");
		$("#modalAddRest").modal("show");
	})

	// 등록하기 버튼 클릭시 (맛집)
	$("#btnAdd-rest").on( "click", function(e) {
		// regex
		let regexTel = /^[0-9]{10,12}$/g;

		if ($("#restName").val() == "") {
			alert("음식점명을 입력하세요.");
			return;
		} else if ($("#restIntro").val() == "") {
			alert("음식점 소개를 입력하세요.");
			return;
		} else if ($("#postcode").val() == "" || $("#roadAddress").val() == "") {
			alert("음식점 주소를 입력하세요.");
			return;
		} else if ($("#telNum1").val() == "" || $("#telNum2").val() == ""
					|| $("#telNum3").val() == "" || !regexTel.test(($("#telNum1").val() + $("#telNum2").val() + $("#telNum3").val()))) {
			alert("음식점 번호를 확인하세요.");
			return;
		} else if ($("#openTime").val() == "" || $("#closeTime").val() == "") {
			alert("영업시간을 입력하세요.");
			return;
		} else if ($("#restFile").val() == "") {
			alert("파일을 첨부하세요.");
			return;
		}

		$("#tel").val($("#telNum1").val() + "-" + $("#telNum2").val() + "-" + $("#telNum3").val());
		$("#address").val($("#roadAddress").val() + " " + $("#extraAddress").val() + " " + $("#detailAddress").val());
		$("#time").val($("#openTime").val() + " ~ " + $("#closeTime").val());

		let addRestForm = $("#addRestForm")[0];
		let formData = new FormData(addRestForm);

		$.ajax({
			url : "${pageContext.request.contextPath}/addRestProc.re",
			type : "post",
			data : formData,
			contentType : false,
			processData : false
		}).done(function(rs) {
			if (rs == "success") {
				alert("맛집이 등록되었습니다.");
				getListByCurrentPage($("#hiddenCurrentPage").val());
			} else if (rs == "fail") {
				alert("맛집 등록에 실패했습니다.");
			}
		}).fail(function(e) {
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
		$("input:checkbox[name='parkingPossible']").attr("checked", false);
		$("#restFile").val("");
		$("#hiddenSeqBox").val("");
		$("#modalAddRest").modal("hide");
	})
	
	
	
	
		document.addEventListener('click',function(e){
			console.log(e.target.className);
 	   		//console.log(e.target.className)
 	   		//console.log(e.target.innerHTML)
			if(e.target.className == "page-link listPage"){
     		   let currentPage="";
     		   if(e.target.className == "page-link listPage" && e.target.innerHTML == "Next") {
     			  getListByCurrentPage(Number(endNavi)+1);
            		//currentPage= data.startNavi+1
	               	}
	               	if(e.target.className == "page-link listPage" && e.target.innerHTML == "Previous"){
	               		getListByCurrentPage(Number(startNavi)-1);
	               		//currentPage= data.startNavi-1
	               	}
	               	if(e.target.className == "page-link listPage" && e.target.innerHTML != "Previous" && e.target.innerHTML != "Next"){
	               		console.log(e.target.innerHTML);
	               		currentPage=e.target.innerHTML;
	               		getListByCurrentPage(currentPage);
	               		
	               	}  
     	   }
     	});
	
	</script>

</body>
</html>