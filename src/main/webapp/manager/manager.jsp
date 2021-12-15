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
	height: 100%;
	background-color: #333;
	padding-top: 200px;
}

.logo {
	font-size: 40px;
	font-weight: bold;
	cursor: pointer;
}

.logo > div {
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

.menubox > div {
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
	height: 100%;
	border: 1px solid black;
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


</style>
</head>
<body>

	<div class="navi">
		<div class="logo">
			<div class="col-12"><a href="${pageContext.request.contextPath}/checkBoxDelMem">맛집플레이트</a></div>
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
			
			<table class="table table-bordered list-table">
				<thead id="table_head">
					
					
				</thead>
				<tbody id="table_body">
				
				
				</tbody>
			</table>
			
			
		
		<!--  
		<div class="d-none hiddenPageBox">
			<input type="text" class="d-none" id="hiddenCurrentPage" value="${currentPage}">
		</div>
		-->
		
		
		
		</div>
	
	
	</div>
	<script>
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
    
    
	
	// 해당 currentPage에 속하는 리스트 목록을 불러오는 작업
	function getListByCurrentPage(e) {
		
		$.ajax({
	        url: "${pageContex.request.contextPath}/getListProc.li?currentPage=" + e,
	        type: "get",
	        dataType: "json"
	        }).done(function (data) {
	        	console.log(data);
	        	$("#table_head").empty();
	        	$("#table_body").empty();
	        	
	        	let startNevi = data.startNavi;
				let endNevi = data.endNavi;
	        	
	        	let thead = "<tr><th class='col-1'>번호</th><th colspan='4'>리스트 제목</th></tr>";
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
					str1 = "<li class='page-item'><div class='page-link' id= 'aa'>Previous</div></li>";
				}
				for(let j = data.startNavi; j<data.endNavi; j++){
					str2 += "<li class='page-item'><div class='page-link' id= 'bb'>"+j+"</div></li>";
				}
				if(data.needNext == true){
					str3 = "<li class='page-item'><button type ='button' class='page-link'>Next</div></li>";
				}
				let nav = "<td colspan='5'>"
							+"<nav class='col' aria-label='Page navigation example'>"
							+"<ul class='pagination justify-content-center'>"
						 	+ str1 + str2 + str3
							+"</ul>"  
							+"</nav>"  	
							+"</td>";  
				$("#table_body").append(nav);
	            
	            
	            //let hiddenCurrentBox = "<input type='text' id='hiddenCurrentPage' class='d-none' value='" + data.currentPage + "'>";
	            //$(".hiddenPageBox").append(hiddenCurrentBox);
	            
	       	   }).fail(function (e) {
	          	  console.log(e);
	           })
	    
	    }
	
	
	
	
	
	
	</script>

</body>
</html>