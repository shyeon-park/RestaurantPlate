<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이용불가 페이지</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.6.0.js"
	integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk="
	crossorigin="anonymous"></script>
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


	<div
		class="container h-100 d-flex flex-column justify-content-md-center">
		<div class="row">
			<div class="col-12 d-flex justify-content-center">
				<h3 class="mt-3">SNS로그인 이용불가 페이지</h3>
			</div>
		</div>
		<div class="row">
			<div class="col-12 d-flex justify-content-center">
				<p class="col-12 d-flex justify-content-center">해당 페이지는 SNS로그인 이용불가 페이지입니다.</p>
			</div>
		</div>
	</div>
</body>
</html>