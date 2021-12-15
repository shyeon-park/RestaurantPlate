<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 관리</title>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="//cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.js"></script>
<link rel="stylesheet"
	href="//cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.css">

<style>
.container {
	text-align: center;
	height: 100%;
	width: 100%;
}

.content {
	border: 1px solid black;
	height: 100%;
	width: 100%;
}

.logo {
	font-size: 40px;
	font-weight: bold;
	cursor: pointer;
}


table {
	width: 100%;
}
.page-link{
	cursor: pointer;
}
a {
	text-decoration: none;
	color: black;
}
</style>

</head>
<body>
<form action="${pageContext.request.contextPath}/checkBoxDelMem.mem"
		method="post" id="btnSubmit">
		<div class="container">
			<div class="row">
				<div class="col">
					<H3>회원관리</H3>
				</div>
			</div>
			<div class="col-12 content">
				<table class="table table-hover">
					<thead>
						<tr>
							<th class="w-20"><input type='checkbox' id='cbx_chkAll'
								name='numAll' value=''> 전체선택</th>
							<th class="w-20">번호</th>
							<th class="w-20">아이디</th>
							<th class="w-20">닉네임</th>
							<th class="w-20">가입일</th>
						</tr>
					</thead>
					<tbody>

					</tbody>
				</table>
				<div class="d-flex justify-content-end">
					<button type="button" class="btn btn-secondary me-5 mb-5" id="delMem">회원삭제</button>
				</div>

			</div>
		</div>
	</form>
	<script>
	checkBoxes = document.getElementsByName("num");	 
	let checkBoxArr = []
	let startNevi;
	let endNevi;
	$("#delMem").click(function(){
		  for (var i = 0; i < checkBoxes.length; i++) {
               if (checkBoxes[i].checked) {
            	   //console.log(checkBoxes[i].value)
            	    checkBoxArr.push(checkBoxes[i].value)
               }
           }
		  if(checkBoxArr == null) return; 
		  $("#btnSubmit").submit();
	})
	
	$(document).ready(function(){
		getCommentList(1)
		//전체선택 전체해제
		$("#cbx_chkAll").click(function() {
			if($("#cbx_chkAll").is(":checked")) $("input[name=num]").prop("checked", true);
			else $("input[name=num]").prop("checked", false);
		});
		
	})
        function getCommentList(currentPage){			
			$.ajax({
				type : "get"
				, url : "${pageContext.request.contextPath}/getMemberList.mem?currentPage="+currentPage
				, dataType : "json"
			}).done(function(data){
				// 기존에 댓글이 있다면 모두 비워주는 작업 
				$("tbody").empty();
				console.log(data)
				startNevi = data.startNavi
				endNevi = data.endNavi
				let list = ""
				for(let dto of data.list){
					//console.log(dto.user_id)
					list += "<tr><td><input type='checkbox' name='num' value='"+dto.user_id+"'></td><td>"+dto.rowNum+"</td><td>"+dto.user_id+"</td><td>"+dto.user_nickname+"</td><td>"+dto.signup_date+"</td></tr>" 
				}	
				 let str =""
				 let str1 = ""
				 let str2 = ""
				if(data.needPrev == true){
					str = "<li class='page-item'><div class='page-link' id= 'aa'>Previous</div></li>"
				}
				for(let j = data.startNavi; j<data.endNavi; j++){
					str1 += "<li class='page-item'><div class='page-link' id= 'bb'>"+j+"</div></li>"
				}
				if(data.needNext == true){
					str2 = "<li class='page-item'><div class='page-link'>Next</div></li>"
				}
				let nav = ""
					nav = "<td colspan=5>"
						+"<nav class='col' aria-label='Page navigation example'>"
						+"<ul class='pagination justify-content-center'>"
					 	+str+str1+str2
						+"</ul>"  
						+"</nav>"  	
						+"</td>"  	 
				  $("tbody").append(list);
	              $("tbody").append(nav)
	     
			}).fail(function(e){
				console.log(e);
			});
		}
        document.addEventListener('click',function(e){
        	   //console.log(e.target.className)
        	   //console.log(e.target.innerHTML)
        	   if(e.target.className == "page-link"){
        		   let currentPage=""
        		   if(e.target.className == "page-link" && e.target.innerHTML == "Next") {
        			   getCommentList(Number(endNevi)+1)
               		//currentPage= data.startNavi+1
	               	}
	               	if(e.target.className == "page-link" && e.target.innerHTML == "Previous"){
	               		getCommentList(Number(startNevi)-1)
	               		//currentPage= data.startNavi-1
	               	}
	               	if(e.target.className == "page-link" && e.target.innerHTML != "Previous" && e.target.innerHTML != "Next"){
	               		currentPage=e.target.innerHTML
	               		getCommentList(currentPage)
	               	}  
        	   }
            });
    	
    </script>

</body>
</html>