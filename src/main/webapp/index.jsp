<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://code.jquery.com/jquery-3.6.0.js"
        integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />
    <link href="index.css" rel="stylesheet" type="text/css">
    <title>맛집 플레이트</title>
    
</head>

<body>
    <div class="wrapper">
        <div class="headerContainer">
            <div class="row naviBar">
                <div class="col-2 menu d-flex justify-content-center">
                    <img src="${pageContext.request.contextPath}/img/logo.png" id="logo">
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
            <div class="row mainImg">
                <div class="col-12 ImgCls">
                    <img src="${pageContext.request.contextPath}/img/main2.png" id="imgs">
                </div>
            </div>
            <div class="row mainTxt">
                <div class="d-none d-md-block col-md-12 txtDiv">
                    <h2>당장 오늘, 점심 뭐먹지? 고민일 땐</h2>
                    <h2>맛집 플레이트</h2>
                </div>
            </div>
            <div class="row search">
                <div class="col-12 searchDiv">
                    <input type="text" id="searchBox" placeholder=" 맛집명, 주소 검색">
                    <button type="button" class="btn btn-danger" id="searchBtn">
                        <svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor"
                            class="bi bi-search" viewBox="0 0 16 16">
                            <path
                                d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z" />
                        </svg>
                    </button>
                </div>
            </div>
        </div>
        <div class="bodyContainer1">
            <div class="row rowBody">
                <div class="col-6 txtBox">
                    <p>짧은 점심시간, 점심메뉴 선정 고민</p>
                    <p>맛집 플레이트에서 해결해드릴께요.</p>
                </div>
                <div class="col-6 imgBox">
                    <img src="">
                </div>
            </div>
            <div class="row rowBody">
                <div class="col-6 imgBox">
                    <img src="">
                </div>
                <div class="col-6 txtBox">
                    <p>가보고 싶은 SNS 맛집 핫플레이스,</p>
                    <p>맛집 플레이트에서 한눈에 확인하세요.</p>
                </div>
            </div>
        </div>

        <div class="bodyContainer2">
            <div class="row">
                <div class="col-12 tit">
                    <h3>추천 맛집 리스트</h3>
                </div>
            </div>
            <div class="row viewList">
            
            </div>
            
        </div>
    </div>
    <script>
         $(document).ready(function(){
             getListAndFile();
         })

         function getListAndFile() {
        	 $.ajax({
        		 url: "${pageContext.request.contextPath}/toGetList.home",
        		 dataType: "json"
        	 }).done(function(data){
        		 for(let list of data) {
        			 let listDiv = "<div class='col-3'>"
        			 				+ "<div class='listBox'>"
        			 				+ "<img src='/files/" + list.system_name + "'>"
        			 				+ "<p>" + list.list_title + "</p>"
        			 				+ "<input type='text' class='d-none' id='hiddenSeq_list' value='" + list.seq_list + "'>"
        			 				+ "</div></div>";
        			 				
        			 $(".viewList").append(listDiv);
        		 }
        	 }).fail(function(e){
        		 console.log(e);
        	 })
         }
         
        // 네비바 스크롤 시 변화
        $(function () {
            $(window).scroll(function () {
                let navbar = $(this).scrollTop();
                if (navbar > 500) {
                    $(".naviBar").css({
                        "backgroundColor": "white",
                        "z-index": "1",
                        "box-shadow": "2px 0px 2px 2px grey"
                    });
                    $(".menu").children().css("color", "grey");
                } else {
                    $(".naviBar").css({
                        "backgroundColor": "",
                        "box-shadow": "0 0 0 0"
                    });
                    $(".menu").children().css("color", "white");
                    // $(".menu").css("border", "none");
                }
            })
        })

        document.getElementById("logo").addEventListener("click", function () {
            location.href = "#";
        })
    </script>



</body>

</html>