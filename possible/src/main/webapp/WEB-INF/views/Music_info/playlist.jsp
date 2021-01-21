<%--
  Created by IntelliJ IDEA.
  User: JJH
  Date: 2021-01-18
  Time: 오후 10:07
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>playlist</title>
    <script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.5.1.min.js"></script> <!-- JQuery -->
    <script type="text/javascript">
        $(document).ready(function (){                       //search music
            $("#To_search").click(function (){
                //var radioVal = $('input[name="chk_info"]:checked').val();
                //console.log(radioVal)
                var params={"keyword":$('input[name="chk_info"]:checked').val()+"//"+$("#keyword").val()};
                $.ajax({
                    type:"POST",
                    url:"/Music_info/list",
                    data:params,
                    datatype: "json",
                    success:function (args){
                        $('#songs').find('option').remove();
                        $(args).find("item").each(function (){
                            console.log($(this).find("title").text())
                            $("#songs").append("<option value='"+$(this).find("title").text()+"//"+$(this).find("artist").text()+"'>"+$(this).find("title").text()+" - "+$(this).find("artist").text()+"</option>");
                        })
                    },
                    error:function (error){
                        alert("error: search music");
                    }
                })
            })
        })
    </script>

    <script type="text/javascript">
        $(function (){
            $("#songs").dblclick(function(){                 //add playlist
                var params={"keyword":${sessionScope.member.id}+"//"+$("#songs").val()};
                $.ajax({
                    type:"POST",
                    url:"/Music_info/insert_playlist",
                    data:params,
                    datatype: "json",
                    success:function (args) {
                        alert("플레이리스트 저장")
                        $("#playlist").append("<option value='"+$("#songs").val()+"'>"+$("#songs").val()+"</option>");
                    },
                    error:function (error){
                    alert("error: add playlist");
                }
            })
        })
        })
    </script>

    <script type="text/javascript">
        $(function load (){                               //load my playlist
            //$('#playlist').change(function(){
                var param={'keyword':${sessionScope.member.id}};
                $.ajax({
                    type:'POST',
                    url:'/Music_info/load_playlist',
                    data:param,
                    datatype:'json',
                    success:function(args) {
                        $(args).find("item").each(function () {
                            $("#playlist").append("<option value='"+$(this).find("title").text()+"//"+$(this).find("artist").text()+"'>"+$(this).find("title").text()+" - "+$(this).find("artist").text()+"</option>");
                        })

                    },error:function(error){
                        alert("error: load playlist");
                }
                //})
            })
        })
    </script>

    <script>
        $(function(){                 //if search textbox is empty, disabled search button
            $('#keyword').on('input',function(){
                if($('#keyword').val=='')
                    $("#To_search").attr("disabled",true);
                else
                    $("#To_search").attr("disabled",false);
            })
        })
    </script>
    <style>
        .right{
            position: absolute;
            top: 50px;
            left:700px;
        }
    </style>
</head>
<body>
<button onclick="history.back()">뒤로가기</button> &nbsp; ID : ${sessionScope.member.id} &nbsp; ACCOUNT : ${sessionScope.member.account}
<br><br>
<form action="/py/recommend_list" method="get">
    <input type="hidden" id="ID" name="id" value=${sessionScope.member.id} />
    <input type="hidden" id="account" name="account" value=${sessionScope.member.account} />
    <input type="hidden" id="videoID" name="videoID" value="abc" />
    <button type="submit">노래 추천 받기</button>
</form>


<input type="radio" name="chk_info" value="title" checked="checked">제목
<input type="radio" name="chk_info" value="artist">가수
<input type="text" id="keyword" name="keyword" required="required">
<button type="submit" id="To_search">search</button><br>
<select name="songs" style="width:300px" id="songs" size="10">
    <option value="" selected>--선택--</option>
</select>
<div class="right" id="list">
    플레이리스트<br>
    <select name="playlist" id="playlist" size="15">
        <option value="" selected>--선택--</option>
    </select>
</div>
</body>
</html>
