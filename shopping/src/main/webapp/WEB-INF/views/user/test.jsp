<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>

</head>

<body>
    <h1 style="font-family: '고딕체'; margin-left: 40%; margin-top: 10px;">기
        본 정 보 입 력</h1>
    <hr>
    <form action="index.jsp" method="post">
        <table style="font-size: 20pt;">

            <tr>
                <td><h4>이름 :</h4></td>
                <td><input type="text" maxlength=1pt name="name"
                    placeholder="성 + 이름"
                    style="height: 40px; margin-top: 100px; margin: 0%;size="30";></td>
            </tr>
            <br>
            <tr>
                <td><h4>전화번호 :</h4>
                <td><select name="phone"
                    style="height: 40px; margin: 100px; margin: 0%;"10";>
                        <option>010</option>

                </select> -<input type="number" name="ph1" maxlength="4"
                    style="height: 30px; margin: 100px; margin: 0%;" size=5>-<input
                    type="number" name="ph2" maxlength="4"
                    style="height: 30px; margin: 100px; margin: 0%;" size=5></td>
            </tr>
            <br>

            <tr>
                <td><h4>아이디 :</h4></td>

                <td><input type="text" minlength="6" maxlength="10" name="id"
                    placeholder="사용할아이디영문입력" required
                    style="height: 40px; margin-top: 100px; margin: 0%; size: 30;"></td>
            </tr>
            <br>
            <tr>
                <td><h4>비밀번호 :</h4></td>
                <td><input type="password" name="pw" minlength="6"
                    maxlength="10" placeholder="특수문자+영문 = 6자 이상 !"
                    style="height: 40px; margin: 100px; margin: 0%; size: 30";"></td>
                <br>
            </tr>
            <tr>
                <td><h4>비밀번호 확인 :</h4></td>

                <td><input type="password" name="pw2" minlength="6"
                    maxlength="10" placeholder="비밀번호 한번더 입력"
                    style="height: 40px; margin-top: 100px; margin: 0%; size: 30";>
                    <button
                        style="height: 42px; margin-top: 100px; margin: 0%; size: 25";>확인</button>
                </td>

            </tr>
            <br>
            <tr>
                <td><h4>생 년 월 일 :</h4></td>
                <td><input type="date"></td>


            </tr>
            <tr>
                <td><h4>성별 :</h4></td>
                <td><input name="gen" id="gen1" type="radio" value="m">
                <label for="gen1">남자</label> 
                <input name="gen" id="gen2" type="radio" value="f">
                <label for="gen2">여자</label>
                </td>
            </tr>
            <br>
            <tr>
                <td><h4>이메일 :</h4></td>
                <td><input type="text" name="email"
                    style="height: 40px; margin: 100px; margin: 0%; size:30";>@</td>
                <td><select name="email">
                        <option>naver.com</option>
                        <option>google.com</option>
                        <option>nate.com</option>
                        <option>kakao.com</option>
                        <option>hanmail.net.</option>
                </select></td>
            </tr>



        </table>


        <br>
        <div style="margin-bottom: 10%;">
            <button type="submit"
                style="height: 50px; margin-bottom: 10%; margin-left: 30%;">
                회원가입</button>
        </div>

    </form>
</body>
</html>


