<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<!-- font -->
<link rel="preconnect" href="https://fonts.gstatic.com">
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;700&display=swap"
	rel="stylesheet">
<!-- Bootstrap -->
<!-- jQuery library -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<!-- CSS -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css"
	integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2"
	crossorigin="anonymous">
	<link rel="stylesheet"
	href="css/formstyle.css">
<!-- 부가적인 테마 -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<!-- 자바스크립트 -->
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx"
	crossorigin="anonymous"></script>
<meta charset="UTF-8">
<link rel="icon" href="Image/favicon.png">
<!--general stylesheet-->
<style type="text/css">
@font-face {
    font-family: 'GoyangIlsan';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_one@1.0/GoyangIlsan.woff') format('woff');
     font-weight: normal;
    font-style: normal;
}
@font-face {
    font-family: 'GoyangDeogyang';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_one@1.0/GoyangDeogyang.woff') format('woff');
    font-weight: normal;
    font-style: normal;
}
* {
	padding: 0px;
	margin: 0px;
	font-family: 'GoyangIlsan';
}

a {
	all: unset;
}
.layout__nav{
	position: sticky;
	top:0;
	z-index: 9999;
}
.layout__main {
	width: 100%;
	height: 100%;
	display: flex;
	justify-content: center;
	align-items: center;
	margin-bottom: 7%;
}
h1,h2,h3,h4,h5{
   font-family:'GoyangDeogyang';
}
/* 기본 링크 스타일 */
a:link, a:visited, a:hover, a:focus, a:active { 
text-decoration:none;
cursor: pointer;
color:black;
}


</style>
<title>Pet & Me | 반려견과 내가 소통하는 공간</title>
</head>
<%
	//메인페이지에 들어갈 파일 읽기
String mainPage = "Layout/main.jsp";
if (request.getParameter("main") != null) {

	mainPage = request.getParameter("main");
}

String id=(String)session.getAttribute("myId");
String log=(String)session.getAttribute("loginOk");
String add=(String)session.getAttribute("accId");

System.out.println(id+log+add);
%>
<body>
	<div class="layout__nav">
		<jsp:include page="Layout/menu.jsp" />
	</div>
	<div class="layout__main">
		<jsp:include page="<%=mainPage%>" />
		
	</div>
</body>
</html>