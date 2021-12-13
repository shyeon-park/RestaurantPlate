<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet"
            integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
        <script src="https://code.jquery.com/jquery-3.6.0.js"
            integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
        <title>회원탈퇴</title>
        <style>
            .container {
                margin: auto;
                text-align: center;
            }
        </style>
    </head>

    <body>

        <nav class="navbar navbar-expand-lg navbar-light bg-light">
            <div class="container-fluid">
                <a class="navbar-brand" href="#">맛집 플레이트</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarText"
                    aria-controls="navbarText" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarText">
                    <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                        <li class="nav-item"><a class="nav-link" aria-current="page" href="${pageContext.request.contextPath}/mypage.mem">내정보 수정</a></li>
                        <li class="nav-item"><a class="nav-link"
						aria-current="page"
						href="${pageContext.request.contextPath}/pwInput.mem">비밀번호 재설정</a></li>
                        <li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/deleteMember.mem">회원탈퇴</a></li>
                    </ul>

                </div>
            </div>
        </nav>
        <form action="${pageContext.request.contextPath}/modifyProc.mem" method="post" id="mypageModifyForm">
            <div class="container">
                <div class="mt-5">
                    <p>회원탈퇴 시 더 이상 맛집플레이트의 기능을 사용할 수 없습니다.</p>
                    <p>그래도 탈퇴하시겠습니까?</p>
                    <button type="button" class="btn btn-secondary" id="delMember">회원탈퇴</button>
                </div>
               


            </div>
        </form>
             <script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
        <script>
            let delMember = document.getElementById("delMember")
            delMember.addEventListener("click",function(){
            	unlinkApp()
            	setTimeout(function() {
            	location.href = "${pageContext.request.contextPath}/deleteProc.mem"
				}, 100);
                //함수가 실행중에 넘어가서 0.3초 딜레이 부여
                	
            })
            Kakao.init('f5b85acc6a4af9096ab0fcf1ad929c7c'); //발급받은 키 중 javascript키를 사용해준다.
			
            console.log(Kakao.isInitialized()); // sdk초기화여부판단
            
            function unlinkApp() { //카카오 앱 연결 끊기
                if (Kakao.Auth.getAccessToken()) {
                    Kakao.API.request({
                        url: '/v1/user/unlink',
                        success: function (response) {
                            console.log(response)
                        },
                        fail: function (error) {
                            console.log(error)
                        },
                    })
                    Kakao.Auth.setAccessToken(undefined)
                }
            }
        </script>
   
        <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
            crossorigin="anonymous"></script>
    </body>
    </body>

    </html>