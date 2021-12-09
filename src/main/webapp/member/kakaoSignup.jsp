<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	${kakaoInformation.get("kakaoId")}
	${kakaoInformation.get("kakaoNickname")}
	

	<p>카카오 회원가입 페이지입니다.</p>
	
</body>
</html>