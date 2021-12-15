<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css"
	integrity="sha512-+4zCK9k+qNFUR5X+cKL9EIR+ZOhtIloNl9GIKS57V1MyNsYpYcUrUeQc9vNfzsWfV28IaLL3i96P9sdNyeRssA=="
	crossorigin="anonymous" />
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />
<style>
.container {
	width: 90%;
	padding: 10px;
}

th, td {
	text-align: center;
}

td:nth-child(2) {
	text-align: left;
}

a {
	text-decoration: none;
	font-weight: bold;
	color: black;
}

.boxBtn-top {
	margin: 20px;
	width: 90%;
	text-align: right;
}

.boxBtn-bottom {
	margin: 20px;
	width: 90%;
	text-align: right;
}
</style>
</head>
<body>

	<div class="container">
		<div class="row">
			<div class="col-12 mb-5 d-flex justify-content-center">
				<h3>전체 리뷰</h3>
			</div>
		</div>
		<table class="table table-bordered">
			<thead>
				<tr>
					<th class="col-md-2">음식점 이름</th>
					<th class="col-md-3">글쓴이</th>
					<th class="col-md-2">작성일</th>
					<th class="col-md-3">리뷰 내용</th>
					<th class="col-md-2">삭제</th>
				</tr>
			</thead>
			<tbody>

			</tbody>
		</table>

	</div>
	<script>
	 $(document).ready(function(){
	     getViewList(1);
	      
	   })
	   
	   
	function getViewList(currentPage){
		$.ajax({
			type : "get"
			, url : "${pageContext.request.contextPath}/managerReviewProc.vi?currentPage=" +currentPage
			, dataType : "json"
		
		}).done(function(data){
			console.log(data);
			
			$("tbody").empty();
			startNevi = data.startNavi
			endNevi = data.endNavi
			for(let dto of data.list){
				console.log(dto.reivew)
				let review = "<tr>"
				+ "<td>"+ dto.rest_name + "</td>" 
				+ "<td>" + dto.user_name + "</td>"
				+  "<td>" + dto.review_date + "</td>" 
				+ "<td>" + dto.review_content +"</td>"
				+ "<td><button type='button' class='btn btn-deleteCmt' id='btnDelete' value='" + dto.seq_view + "'>삭제</button></td>"
				+ "</tr>";
				$("tbody").append(review);
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
					str2 = "<li class='page-item'><button type ='button' class='page-link'>Next</div></li>"
				}
				let nav = ""
					
					nav = "<td colspan=5>"
						+"<nav class='col' aria-label='Page navigation example'>"
						+"<ul class='pagination justify-content-center'>"
					 	+str+str1+str2
						+"</ul>"  
						+"</nav>"  	
						+"</td>"  	 
	              $("tbody").append(nav)

		
		}).fail(function(e){
			console.log(e);
		});
		}
	 
	 document.addEventListener('click',function(e){
        if(e.target.id == 'btnDelete'){
      	  let seq_view = e.target.value;
      	  if(confirm("정말로 삭제하시겠습니까?")) {
       		 $.ajax({
       			 url: "/managerViewDelete.vi?seq_view="+ seq_view,
       			 type: "get"
       		 }).done(function(data){
       			 if(data == "success") {
       				 alert("리뷰가 삭제되었습니다.");
       				getViewList(1);
       			 } else if(data == "fail") {
       				 alert("리뷰 삭제에 실패하였습니다.");
       			 }
       		 }).fail(function(e){
       			 console.log(e);
       		 })
       	 }
			
         }
        });
	 
	 document.addEventListener('click',function(e){
  	   //console.log(e.target.className)
  	   //console.log(e.target.innerHTML)
  	   if(e.target.className == "page-link"){
  		   let currentPage=""
  		   if(e.target.className == "page-link" && e.target.innerHTML == "Next") {
  			 getViewList( Number(endNevi)+1)
         		//currentPage= data.startNavi+1
             	}
             	if(e.target.className == "page-link" && e.target.innerHTML == "Previous"){
             		getViewList(Number(startNevi)-1)
             		//currentPage= data.startNavi-1
             	}
             	if(e.target.className == "page-link" && e.target.innerHTML != "Previous" && e.target.innerHTML != "Next"){
             		currentPage=e.target.innerHTML
             		getViewList(currentPage)
             		
             	}  
  	   }
  	
      });
		
		
	</script>

</body>
</html>
</body>
</html>