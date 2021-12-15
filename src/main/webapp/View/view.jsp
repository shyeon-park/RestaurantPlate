<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
<title>Insert title here</title>
<style>
	.container{
		width: 90%;
		padding: 10px;
	}
	th, td{
		text-align: center;
	}
	td:nth-child(2){
		text-align: left;
	}
	a{
		text-decoration: none;
		font-weight: bold;
		color: black;
	}
    .boxBtn-top{
        margin: 20px;
        width: 90%;
        text-align: right;
    }
    .boxBtn-bottom{
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
					<th class="col-md-5">음식점 이름</th>
					<th class="col-md-3">글쓴이</th>
					<th class="col-md-2">작성일</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${list}" var="dto">
					<tr>
						<td><a href="${pageContext.request.contextPath}/toRestDetailView.re?seq_rest=${dto.getRest_name()}&currentPage=${naviMap.get('currentPage')}">${dto.getRest_name()}</a></td>
						<td>${dto.getUser_id()}</td>
						<td>${dto.getReview_date()}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<div class="row">
			<nav class="col" aria-label="Page navigation example">
			  <ul class="pagination justify-content-center">
				  <c:if test="${naviMap.get('needPrev') eq true}">
				  	<li class="page-item"><a class="page-link" href="${pageContext.request.contextPath}/view.vi?currentPage=${naviMap.get('startNavi')-1}">Previous</a></li>
				  </c:if>
				  <!--startNavi ->endNavi  -->
				  <c:forEach var="i" begin="${naviMap.get('startNavi')}" end="${naviMap.get('endNavi')}">
				  	<li class="page-item"><a class="page-link" href="${pageContext.request.contextPath}/view.vi?currentPage=${i}">${i}</a></li>
				  </c:forEach>
				  <c:if test="${naviMap.get('needNext') eq true}">
				  	<li class="page-item"><a class="page-link" href="${pageContext.request.contextPath}/view.vi?currentPage=${naviMap.get('endNavi')+1}">Next</a></li>
				  </c:if>			    
			  </ul>
			</nav>
		</div>
	</div>
    <div class="boxBtn-bottom">
        <button class="btn btn-success" id="btnHome" type="button">홈으로</button>
    </div>
    
    <script>
    	// 홈으로
    	document.getElementById("btnHome").addEventListener("click", function(e){
    		location.href = "/";
    	});
    </script>
</body>
</html>