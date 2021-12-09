<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>   
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>맛집 리스트 이름</title>

    <script src="https://code.jquery.com/jquery-3.6.0.js"
        integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />

    <style>
        * {
            box-sizing: border-box;
        }
        
        html {
        	width: 100%;
        	height: 100%;
        }
        
        body {
        	width: 100%;
        	height: 100%;
        }

        .wrapper {
            width: 100%;
            height: 100%;
        }

        /*메인 페이지 헤더부분*/
        .headerContainer {
            width: 100%;
            /* border: 1px solid grey; */
            position: relative;
            margin-bottom: 100px;
        }

        /*네비*/
        .naviBar {
            position: fixed;
            width: 100%;
            height: 80px;
            margin: 0;
            top: 0;
            background-color: white;
            box-shadow: 0px 0px 2px 2px lightgrey;
            z-index: 1;
            /* opacity: 0.8; */
        }

        .menu {
            height: 100%;
            /* border: 1px solid grey; */
            position: relative;
            float: left;
        }

        .menu:first-child {
            padding: 8px;
        }

        #logo {
            width: 100%;
            height: 100%;
            cursor: pointer;
        }

        .menu>a {
            color: grey;
            position: absolute;
            top: 50%;
            transform: translate(0, -50%);
            font-size: 16px;
            font-weight: bold;
        }

        a:link {
            text-decoration: none;
        }

        /* */
        .headDiv {
            width: 100%;
            height: 500px;
            background-color: #dfd8ca;
            margin: 0;
        }

        .headDiv>div {
            padding: 0;
            position: relative;
        }

        .headDiv>div>p {
            position: relative;
            top: 50%;
            transform: translate(0, -50%);
            text-align: center;
            color: #333;
            font-weight: bold;
            font-size: 40px;
        }

        /* 바디영역 */
        .bodyContainer {
            width: 60%;
            margin: auto;
            height: 600px;
        }

        .restaurantBox {
            width: 100%;
            border: 1px solid lightgray;
            margin-bottom: 30px;
        }

        .restaurantBox .row {
            width: 100%;
            margin: 0;
        }

        .restaurantBox:hover {
            cursor: pointer;
        }

        .divBox1 {
            width: 100%;
            height: 50px;
            border-bottom: 1px solid lightgray;
        }

        .divBox2 {
            width: 100%;
            height: 50px;
            border-top: 1px solid lightgray;
        }

        .restContent {
            width: 100%;
            height: 200px;
        }

        .restaurantImgDiv {
            padding: 8px;
        }

        .restaurantImgDiv > img {
            width: 100%;
            height: 100%;
        }

        .restaurantTxtDiv {
            padding: 12px;
        }

        .restaurantTxtDiv > p {
            margin-bottom: 20px;
        }

        .restaurantTxtDiv>p:first-child {
            font-size: 30px;
        }
    </style>
</head>

<body>
    <div class="wrapper">
        <div class="headerContainer">
            <div class="row naviBar">
                <div class="col-2 menu d-flex justify-content-center">
                    <img src="img/logo.png" id="logo">
                </div>
                <div class="col-2 col-md-6 menu">

                </div>
                <div class="col-2 col-md-1 menu d-flex justify-content-start">
                    <a href="#">로그인</a>
                </div>
                <div class="col-2 col-md-1 menu d-flex justify-content-start">
                    <a href="#">회원가입</a>
                </div>
                <div class="col-2 col-md-1 menu d-flex justify-content-start">
                    <a href="#">맛집 리스트</a>
                </div>
                <div class="col-2 col-md-1 menu d-flex justify-content-start">
                    <a href="#">전체 리뷰</a>
                </div>
            </div>
            <div class="row headDiv">
                <div class="col-12">
                    <p>${ldto.getList_title()}</p>
                </div>
            </div>
        </div>
        
        <div class="bodyContainer">
        <c:forEach items="${restList}" var="list">
        	<div class="restaurantBox">
        		<input type="text" class="d-none" value="${list.getSeq_rest()}">
                <div class="row divBox1">
                    <div class="col-12"></div>
                </div>
                <div class="row restContent">
                    <div class="col-4 restaurantImgDiv">
                        <img src="/restFiles/${list.getSystem_name()}">
                    </div>
                    <div class="col-8 restaurantTxtDiv">
                        <p>${list.getRest_name()}</p>
                        <p>${list.getRest_address()}</p>
                        <p>${list.getRest_introduction()}</p>
                    </div>
                </div>
                <div class="row divBox2">
                    <div class="col-12"></div>
                </div>
            </div>
        </c:forEach>
        </div>
    </div>
    <script>
    	$(".restaurantBox").on("click", function(){
    		console.log($(this));
    		console.log($(this).find("input").val());
    		location.href = "${pageContexr.request.contextPath}/toRestDetailView.re?seq_rest=" + $(this).find("input").val();
    	})
    </script>

</body>

</html>