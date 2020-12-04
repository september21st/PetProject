<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	.book__mainlayout{
		margin-top: 50px;
	}
	.book__choice{
		display: flex;
		justify-content: space-between;
	}
	.book__choice1{
		position: relative;
	}
	.book__choice1:after{
		top: 0; /*말풍선꼭지위치 위아래*/
		right: 9.3%; /*말풍선위치 좌우*/
		border: solid transparent;
		content: "";
		height: 0;
		width: 0;
		position: absolute;
		pointer-events: none;
		border-color: transparent transparent transparent #F7CA18 ; /*말풍선 꼭지방향*/
		border-width: 32px; /*말풍선 꼭지 사이즈*/
		margin-right: -29.5%; /*말풍선 상세위치 조정*/
	}
	
	.book__choice li{
		list-style-type: none;
		padding:20px 130px;
	}
	
	.book__choice2 a, .book__choice3 a, .book__choice4 a{
		pointer-events: none;
	} 
	.bookmain__boxs{
		display: flex;
		justify-content: space-between;
	}
	
	.bookmain__boxs div{
		width: 400px;
		height: 300px;
		border: 1px solid red;
		margin: auto;
	}
	.bookmain__box1 span:nth-child(1),.bookmain__box2 span:nth-child(1),.bookmain__box3 span:nth-child(1){
		color: green;
	}
	.bookmain__box1 span:nth-child(2),.bookmain__box2 span:nth-child(2),.bookmain__box3 span:nth-child(2){
		display:none;
		color: red;
	}
	.bookmain__box1:hover span:nth-child(1),.bookmain__box2:hover span:nth-child(1),.bookmain__box3:hover span:nth-child(1){
		display: none;
	}
	.bookmain__box1:hover span:nth-child(2),.bookmain__box2:hover span:nth-child(2),.bookmain__box3:hover span:nth-child(2){
		display: inline;
	}
	.bookmain__bookbtn{
		display: flex;
		justify-content: center;
		border: 1px solid black;
	}
</style>
</head>
<%
 		String loginOk = (String)session.getAttribute("loginOk");
%>
<body>
	<div class="book__mainlayout">
		<jsp:include page="bookmenu.jsp"/>
		
		<div class="bookmain__boxs" style="width: 100%; height: 500px; border: 1px solid red;">
			<div class="bookmain__box1" style="text-align: center; padding: 50px;"  onclick="bookSelectOnelesson()">
				<span>1:1 레슨</span>
				<span>
					1:1 레슨은 어쩌구저쩌구 쌸라라라라<br> 와라라라랄 어쩌구저쩌구 쌸라라라라 와라라라랄 어쩌구저쩌구 쌸라라라라 와라라라랄 
					쌸라라라라 와라라라랄 쌸라라 우리팀 화이팅 우리팀 화이팅 우리팀 화이팅 우리팀 화이팅 우리팀 화이팅
				</span>
			</div>
			<div class="bookmain__box2" style="text-align: center; padding: 50px;" onclick="bookSelectGrouplesson()">
				<span>그룹 레슨</span>
				<span>
					그룹 레슨은 어쩌구저쩌구 쌸라라라라<br> 와라라라랄 어쩌구저쩌구 쌸라라라라 와라라라랄 어쩌구저쩌구 쌸라라라라 와라라라랄 
					쌸라라라라 와라라라랄 쌸라라 우리팀 화이팅 우리팀 화이팅 우리팀 화이팅 우리팀 화이팅 우리팀 화이팅
				</span>
			</div>
			<div class="bookmain__box3" style="text-align: center; padding: 50px;" onclick="bookSelectHoteling()">
				<span>호텔링</span>
				<span>
					호텔링은 어쩌구저쩌구 쌸라라라라<br> 와라라라랄 어쩌구저쩌구 쌸라라라라 와라라라랄 어쩌구저쩌구 쌸라라라라 와라라라랄 
					쌸라라라라 와라라라랄 쌸라라 우리팀 화이팅 우리팀 화이팅 우리팀 화이팅 우리팀 화이팅 우리팀 화이팅
				</span>
			</div>
		</div>
	
	
	</div>
<script type="text/javascript">
 	function bookSelectOnelesson(){
 		var s="<%=loginOk%>";
 		if(s=="null"){
 			alert("먼저 로그인을 해주세요");
 			location.onLoad();
 		}else{
 			location.href="index.jsp?main=Book/bookSelect.jsp?onelesson=1:1 레슨";
 		}
 	}
 	function bookSelectGrouplesson(){
 		var s="<%=loginOk%>";
 		if(s=="null"){
 			alert("먼저 로그인을 해주세요");
 			location.onLoad();
 		}else{
 			location.href="index.jsp?main=Book/bookSelect.jsp?onelesson=그룹 레슨";
 		}
 	}
 	function bookSelectHoteling(){
 		var s="<%=loginOk%>";
 		if(s=="null"){
 			alert("먼저 로그인을 해주세요");
 			location.onLoad();
 		}else{
 			location.href="index.jsp?main=Book/bookSelect.jsp?onelesson=호텔링";
 		}
 	}
</script>	
</body>
</html>