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
	padding-top: 100px;
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
}

.header>div {
	position: absolute;
	top: 50%;
	transform: translate(0, -50%);
	text-align: center;
}

.header > div > p:first-child {
	font-size: 30px;
	font-weight: bold;
}

.header > div > p:last-child {
	font-size: 18px;
	color: gray;
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
					<button type="button" class="btn btn-success" id="btnRestModify"
						value="">수정</button>
				</div>
				<div class="col-1 restDiv d-flex justify-content-center">
					<button type="button" class="btn btn-dark" id="btnRestDelete"
						value="">삭제</button>
				</div>
			</div>
		</c:forEach>

	</div>

</body>
</html>