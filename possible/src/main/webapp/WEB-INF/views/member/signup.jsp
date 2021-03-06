<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: jinwoo
  Date: 1/11/2021
  Time: 9:19 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>

<html>
<head>
    <title>signup</title>
    <!-- if sessionScope.member.id is not empty = session is On State : Cannot sign up -->
    <c:if test="${not empty sessionScope.member.id}">
        <script>
            alert("로그인 상태입니다.");
            history.back();
        </script>
    </c:if>

    <script language="javascript">
        // const request = require("./jszip");

        function id_check_func(){
            var input_id = document.querySelector('input[name=account]');

            $('.account_input').change(function(){
                $('#register').attr("disabled", true);
            })

            // AJAX에서 보내는 데이터 형식과 받는 형식을 일치시켜주어야 한다!
            $.ajax({
                type: "post",
                url: "/member/check_id.do",
                datatype: "json",
                data: {
                    "account": input_id.value
                },
                success: function(data){
                    console.log(data);
                    if (data == input_id.value){
                        alert("중복되는 ID가 존재합니다.");
                        $('#register').attr("disabled", true);
                    }
                },
                error: function(error){
                    alert("사용가능한 ID 입니다.");
                    $('#register').attr("disabled", false);
                }
            });
            /*$(function (){
                $('#password1').keyup(function (){
                    $('#chkNotice').html('');
                });
                $('#password2').keyup(function (){
                    if($('password1').val()!=$('password2').val()){
                        $('#chkNotice').html('비밀번호 일치하지 않음<br><br>');
                        $('#chkNotice').attr('color','#f82a2aa3');
                    }else{
                        $('#chkNotice').html('비밀번호 일치함<br><br>');
                        $('#chkNotice').attr('color', '#199894b3');
                    }
                });
            });*/
            $(function(){

//비밀번호 확인
                $('#password2').blur(function(){
                    if($('#password1').val() != $('#password2').val()){
                        if($('#password2').val()!=''){
                            alert("비밀번호가 일치하지 않습니다.");
                            $('#password2').val('');
                            $('#password2').focus();
                        }
                    }
                })
            });
        }
    </script>

    <style>
        h1 {
            FONT-SIZE: 78px;
            COLOR: #eeeeee;
            PADDING-BOTTOM: 10px;
            TEXT-ALIGN: left;
            PADDING-TOP: 10px;
            PADDING-LEFT: 10px;
            BORDER-LEFT: #00b5ff 8px solid;
        }

        h2 {
            FONT-SIZE: 12px;
            COLOR: #eeeeee;
            PADDING-BOTTOM: 10px;
            TEXT-ALIGN: left;
            PADDING-TOP: 10px;
            PADDING-LEFT: 10px;
            BORDER-LEFT: #00b5ff 8px solid;
        }

        .input{
            border : 1px solid black;
        }


        button {
            background-color: #00b5ff;
            border: none;
            color: #ffffff;
            cursor: pointer;
            display: inline-block;
            font-family: 'BenchNine', Arial, sans-serif;
            font-size: 1em;
            font-size: 10px;
            line-height: 1em;
            outline: none;
            padding: 6px 20px 5px;
            position: relative;
            text-transform: uppercase;
            font-weight: 700;
        }


    </style>

</head>
<body>

<h1> Muse </h1>

<h2> 회원가입해주세요. 당신의 정보는 보호받습니다 .</h2>

<div class="input">
    <!-- Member's field name = HTML tag name !!!-->
    <form action="/member/register" method="post">
        First Name <input type="text" name="first_name" required="required"><br>
        Last Name  <input type="text" name="last_name" required="required"><br>
        ID         <input type="text" name="account" class="account_input" required="required">
        <button type="button" onclick="id_check_func()" id="check">ID 중복 체크</button><br>
        PW         <input type="password" id="password1" name="password" required="required" minlength="8"><br>
        PW확인      <input type="password" id="password2" name="password2" required="required" minlength="="8><br>
        <font id="chkNotice" size=""2></font>
        Age        <input type="number" name="age" required="required" min="0"><br>
        Sex        <select name="sex">
                    <option value=0>Female</option>
                    <option value=1>Male</option>
                    </select>
        <input type="hidden" name="class_" value=1 />
        <input type="hidden" name="money" value=0 />

        <button type="submit"  id="register" disabled="disabled">회원가입</button>
    </form>
</div>

<button onclick="javascript:location.href='/';">메인으로</button>
</body>
</html>
