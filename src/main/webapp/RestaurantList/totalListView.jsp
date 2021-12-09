<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>전체 리스트: 더보기</title>

    <script src="https://code.jquery.com/jquery-3.6.0.js"
        integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />

    <style>
        * {
            box-sizing: border-box;
        }

        .wrapper {
            width: 100%;
            height: 4000px;
        }

        /* 메인 페이지 헤더부분 */
        .headerContainer {
            width: 100%;
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
            z-index: 111;
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

        /* 헤드 영역 */
        .headDiv {
            width: 100%;
            height: 300px;
            background-color: #f1f7e7;
            margin: 0;
        }

        .headDiv>div {
            padding: 0;
            position: relative;
        }

        .headDiv>div>p {
            position: relative;
            top: 60%;
            transform: translate(0, -50%);
            text-align: center;
            color: #333;
            font-weight: bold;
            font-size: 40px;
        }

        /* 리스트 목록 영역 */
        .bodyContainer{
            width: 80%;
            margin: auto;
        }

        .viewList {
			width: 100%;
			margin: auto;
		}
		
		.listBox {
			height: 200px;
			position: relative;
			margin-bottom: 20px;
			transition-duration: 1.5s;
		}
		
		.listBox:hover {
			cursor: pointer;
			transform: scale(1.1);
		}
		
		.listBox > img {
			position: absolute;
			width: 100%;
			height: 100%;
			opacity: 0.7;
		}
		
		.listBox > p {
			position: absolute;
			font-weight: bold;
			top: 50%;
			left: 50%;
			transform: translate(-50%, -50%);
			text-align: center;
			font-size: 20px;
			color: white;
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
                <div class="col-2 col-md-7 menu">

                </div>
                <div class="col-2 col-md-1 menu d-flex justify-content-start">
                    <a href="#">로그인</a>
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
                    <p>전체 맛집 리스트 목록</p>
                </div>
            </div>
        </div>

        <div class="bodyContainer">
            <div class="row viewList">
            <c:forEach items="${list}" var="listDto">
            	<div class="col-3 ">
                    <div class="listBox">
                        <img src="${listDto.getSystem_name()}">
                        <p>${listDto.getList_title()}</p>
                        <input type="text" class="d-none" value="${listDto.getSeq_list}">
                    </div>
                </div>
            </c:forEach>
            </div>
        </div>
    </div>
</body>
</html>