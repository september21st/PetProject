<%@page import="java.net.URLDecoder"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="data.dto.AccountDto"%>
<%@page import="java.util.List"%>
<%@page import="data.dao.MungDao"%>
<%@page import="data.dto.MungPostDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
/* bg-dark text-white */
#mumg__container {
	width: 100%;
}

ul li {
	list-style: none;
}

a {
	cursor: pointer;
}

.mung__post-list{
	max-width: 86.5%;
	text-align: center;
	margin: 0 13.5%;
}

/* 카드텍스트 */
.mung__post-text {
	display: block;
	text-align: center;
}

/* 카드이미지*/
.mung__img-box img{
	min-height: 300px;
	border-style: none;
	border-radius: 0;
	margin: 0;
}

/* 카드이미지 박스 */
.mung__img-box {
    overflow: hidden;
    display: flex;
    align-items: center;
    justify-content: center;
    width: 300px;
    height: 300px;
    border-style: none;
    border-radius: 0;
    margin: 0;
}

.card-img-overlay {
	padding: 0;
}

/* 로그인한 계정 프로필, 게시글작성한 계정 프로필 */
.mung__profile {
	width: 30px;
	height: 30px;
	border-radius: 50px;
	margin: 0 20px;
}
     
/* 게시글에 댓글작성한 계정 프로필 */     
.mung__profile-sm {
	width: 20px;
	height: 20px;
	border-radius: 50px;
	margin: 0 10px;
}

/* 모달 (모달dialog, 모달content) */
.modal-size {
	width: 80%; 
	min-width: 80%;
	height: 90%;
	min-height: 70%;
	display: flex;
	overflow: hidden;
	align-items: center;
    justify-content: center;
    z-index: 100000;
}     

/* 모달 바디 */
div.mung__post__modal {
	padding: 0;
	display: flex;
	overflow: hidden;
	align-items: center;
    justify-content: center;
}

/* 모달 이미지 박스 */
div.mung__modal__img {
	background-color: #121212;
	display: block;	
    align-items: center;
    justify-content: center;
    height: 90%;
}


/* 모달창 이미지 */
.modalImg {
	max-width: 100%;
	max-height: 90%;
	 
}

/* 컨텐츠 */
#mung__modal__content {
	width: 90%;
}

/* 태그 목록 */
#mung__modal__tag {
	width: 90%;
}

/* 태그 */
.mung__modal__tag {
	color: blue;
	cursor: pointer;
}

/* 댓글입력창 */
#mung__modal__inputComm {
	max-width: 80%;
}

/* 검색창 */
#mung__searchTag {
	width: 200px;
}


</style>
<script type="text/javascript">
$(function() {
	//게시글 클릭시 모달창 오픈
	//모달창 열릴 경우 이벤트
	$("#exampleModal").on("show.bs.modal",function(e) {
		//클릭한 게시글 post_num
		var post_num=$(e.relatedTarget).data("num");
		$.ajax({
			type:"post",
			url:"Mung/mungPostData.jsp",
			data:{"post_num":post_num},
			datatype:'json',
			success:function(data) {
				//json파싱
				json=JSON.parse(data);
				
				//json으로부터 받아올 데이터 변수
				var photo=json.photo.split(',');
				var content=json.content;
				var tag=json.tag.split("#");
				var writeday=json.writeday;
				var likes=json.likes;
				var postUserId=json.postUserId;
				var postAccId=json.postAccId;
				var postProfile=json.postProfile;
				var commList=json.commList;
				
				/* 사진 캐러셀 */
				//게시글 당 불러올 사진 개수
				var img_idx=photo.length-1;
				//캐러셀 추가할 이미지
				var src="mungSave/"+photo[img_idx];
				//캐러셀 이미지에 들어갈 코드
				var s1="";
				s1+="<div class='carousel-item active'><div class='mung__modal__img'>";
				s1+="<img src='"+src+"' class='d-block w-100 modalImg'>";
				s1+="</div></div>";
				//사진이 2장이상일 경우 사진개수만큼 코드 생성
				if(img_idx>0) {
					for(var i=img_idx-1; i>=0; i--) {
						src="mungSave/"+photo[i];
						s1+="<div class='carousel-item'><div class='mung__modal__img'>";
						s1+="<img src='"+src+"' class='d-block w-100 modalImg'>";
						s1+="</div></div>";
					}    
				}
				//코드 추가
				$("#slideImg").html(s1);
				//캐러셀 이미지 위치 표시를 위한 코드
				var s2="";
				s2+="<li data-target='#carouselExampleIndicators' data-slide-to='0' class='active'></li>";
				//사진이 2장이상일 경우 사진개수만큼 코드 생성
				if(img_idx>0) {
					for(var i=1; i<=img_idx; i++) {
						src="mungSave/"+photo[i];
						s2+="<li data-target='##carouselExampleIndicators' data-slide-to='"+i+"'></li>";
					}    
				}
				//코드 추가
				$("#slideIdx").html(s2);
				//캐러셀 실행 및 자동 슬라이드 기능 해제
				$('.carousel').carousel('pause');
				
				/* 텍스트 */
	        	//게시글 작성한 계정정보
	        	$("#mung__post__profile").attr("src","AccSave/"+postProfile);
	        	$("#mung__post__id").text(postAccId+' ('+postUserId+')');
				
	        	//게시글 내용
	        	$("#mung__modal__content").html(content);
	        	
	        	var tagList="";
	        	var tag_len=tag.length;
	        	for(var i=1; i<tag_len; i++) {
	        		tagList+="<span class='mung__modal__tag'>#"+tag[i]+"</span>";
	        	}
	        	$("#mung__modal__tag").html(tagList);
	        	
	        	
	        	//댓글 목록(댓글 추가 후 목록 새로고침 되도록 ajax로 처리)
	        	getCommList(post_num);
	        	
	        	//게시글 좋아요(클릭시 개수 업데이트)
	        	getLikes(post_num);
	        	
	        	//게시글 좋아요 클릭이벤트
	        	$(".mung__modal_likes").click(function() {
	        		var heart=$("#mung__likesIcon").attr("class");
	        		
	        		if(heart=="empty") {
	        			plusLikes(post_num);
	        			$("#mung__likesIcon").removeClass("empty");
	        			var fill="<svg width='1em' height='1em' viewBox='0 0 16 16' class='bi bi-heart-fill' fill='currentColor' xmlns='http://www.w3.org/2000/svg'>";
	        			fill+="<path fill-rule='evenodd' d='M8 1.314C12.438-3.248 23.534 4.735 8 15-7.534 4.736 3.562-3.248 8 1.314z'/>";
	        			fill+="</svg>";
	        			$("#mung__likesIcon").html(fill);
	        			getLikes(post_num);
	        		}
	        		
	        		if(heart!="empty") {
	        			minusLikes(post_num);
	        			$("#mung__likesIcon").addClass("empty");
	        			var empty="<svg width='1em' height='1em' viewBox='0 0 16 16' class='bi bi-heart' fill='currentColor' xmlns='http://www.w3.org/2000/svg'>";
						empty+="<path fill-rule='evenodd' d='M8 2.748l-.717-.737C5.6.281 2.514.878 1.4 3.053c-.523 1.023-.641 2.5.314 4.385.92 1.815 2.834 3.989 6.286 6.357 3.452-2.368 5.365-4.542 6.286-6.357.955-1.886.838-3.362.314-4.385C13.486.878 10.4.28 8.717 2.01L8 2.748zM8 15C-7.333 4.868 3.279-3.04 7.824 1.143c.06.055.119.112.176.171a3.12 3.12 0 0 1 .176-.17C12.72-3.042 23.333 4.867 8 15z'/>";
						empty+="</svg>";
	        			$("#mung__likesIcon").html(empty);
	        			getLikes(post_num);
	        		}
	        		
	        	});
	        	
	        	//게시글 댓글
	        	$("#mung__comm__commNum").val(post_num);
				
				//댓글 추가 버튼 이벤트
				$("#mung__modal__sbmitBtn").click(function() {
					var content=$("#mung__modal__inputComm").val();
					var dog_num=$("#mung__modal__commNum").val();
					insertComm(post_num, content, dog_num);
					$("#mung__modal__inputComm").val("");
				});
			},error:function(request,status,error){
		        alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		    }
		});
	});
	
	//태그 검색 후 엔터키 이벤트
	$("#mung__searchTag").keydown(function(key) {
		if (key.keyCode==13) {
			var tag=$(this).val();
			location.href="index.jsp?main=Mung/mungSearch.jsp?tag="+tag;
		}
	});
	
	//게시글의 태그 클릭시 이벤트
	$(document).on("click",".mung__modal__tag",function() {
		var tag=$(this).text().replace("#","");
		location.href="index.jsp?main=Mung/mungSearch.jsp?tag="+tag;
	});
	
	//모달창 닫힐 때 모달창 내의 데이터 초기화
	$('#exampleModal').on('hidden.bs.modal', function () {
		$("#slideImg").html("");
		$("#slideIdx").html("");
		$("#mung__modal__content").val("");
		$("#mung__modal__tag").html("");
		$("#mung__modal__inputComm").val("");
	});
});

//게시글 좋아요 출력
function getLikes(post_num) {
	$.ajax({
		type:"get",
		url:"Mung/mungPostData.jsp",
		data:{"post_num":post_num},
		datatype:'json',
		success:function(data) {
			//json파싱
			json=JSON.parse(data);
			//좋아요 개수 출력
			var likes=json.likes;
			$("#mung__modal__likes").html("좋아요&nbsp;"+likes+"개");
		}	
	});
}

//게시글 좋아요 +1
function plusLikes(post_num) {
	$.ajax({
		type:"get",
		url:"Mung/mungLikesPlus.jsp",
		data:{"post_num":post_num},
		datatype:'html',
		success:function(data) {
			getLikes(post_num);
		}
	});
}
	
//게시글 좋아요 -1
function minusLikes(post_num) {
	$.ajax({
		type:"get",
		url:"Mung/mungLikesCancel.jsp",
		data:{"post_num":post_num},
		datatype:'html',
		success:function(data) {
			getLikes(post_num);
		}
	});	
}

//댓글 목록 출력
function getCommList(post_num) {
	$.ajax({
		type:"post",
		url:"Mung/mungPostData.jsp",
		data:{"post_num":post_num},
		datatype:'json',
		success:function(data) {
			//json파싱
			json=JSON.parse(data);
			//댓글목록 초기화
			$("#mung__modal__comment").html("");
			//댓글 목록 출력
			var commList=json.commList;
			var comm="";
        	$.each(commList,function(i,item) {
        		comm="<li><img class='mung__profile-sm' idx="+item.idx+" src=AccSave/"+item.commProfile+"><span>"+item.content+"</span><span>"+item.writeday+"</span></li>";
	        	$("#mung__modal__comment").append(comm);
			});
		}	
	});
}

//댓글 추가
function insertComm(comm_num,content,dog_num) {
	$.ajax({
		type:"post",
		url:"Mung/mungCommAddAction.jsp",
		data:{"comm_num":comm_num,"content":content,"dog_num":dog_num},
		datatype:'html',
		success:function(data) {
			getCommList(comm_num);
		}	
	});
}
</script>
</head>
<%	
	//인코딩
	request.setCharacterEncoding("utf-8");

	//로그인 상태 및 아이디 세션값
	String myId=(String)session.getAttribute("myId");
	String accId=(String)session.getAttribute("accId");
	String loginOk=(String)session.getAttribute("loginOk");
	
	MungDao dao=new MungDao();
	//계정 정보 출력
	AccountDto accDto=dao.getAccountData(accId);
	String dog_num=dao.getAccount(accId);
	//검색한 게시글목록 출력
	String tag=request.getParameter("tag");
	List<MungPostDto> postList=dao.getSearchData(tag);
	System.out.println(tag);
%>
<body>
<div id="mumg__container">
	<!-- 멍스타그램 네비바 -->
	<ul id="mung__nav">
		<!-- 로그인한 계정 정보 -->
<%
		if(loginOk!=null && accId!="no") {
%>		
		<li class="mung__nav__acc">
			<a href="index.jsp?main=Mung/mungAccount.jsp">
				<img class="mung__profile" src="AccSave/<%=accDto.getPhoto()%>">
				<b><%=accId %>(<%=myId %>)</b>
			</a>
			<a href="index.jsp?main=Mung/mungPostAdd.jsp">
				<svg class="mung__post__icon" width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-plus-square" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
				  <path fill-rule="evenodd" d="M14 1H2a1 1 0 0 0-1 1v12a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1V2a1 1 0 0 0-1-1zM2 0a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2H2z"/>
				  <path fill-rule="evenodd" d="M8 4a.5.5 0 0 1 .5.5v3h3a.5.5 0 0 1 0 1h-3v3a.5.5 0 0 1-1 0v-3h-3a.5.5 0 0 1 0-1h3v-3A.5.5 0 0 1 8 4z"/>
				</svg>
			</a>
		</li>
		<!-- 검색창 -->
		<li>
			<input type="text" id="mung__searchTag" class="form-control" placeholder="#<%=tag%>">
		</li>
		<!-- 메뉴 버튼 -->
		<li class="mung__nav__btn">
			<a href="index.jsp?main=Mung/mungMain.jsp">
				<svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-house-door" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
				  <path fill-rule="evenodd" d="M7.646 1.146a.5.5 0 0 1 .708 0l6 6a.5.5 0 0 1 .146.354v7a.5.5 0 0 1-.5.5H9.5a.5.5 0 0 1-.5-.5v-4H7v4a.5.5 0 0 1-.5.5H2a.5.5 0 0 1-.5-.5v-7a.5.5 0 0 1 .146-.354l6-6zM2.5 7.707V14H6v-4a.5.5 0 0 1 .5-.5h3a.5.5 0 0 1 .5.5v4h3.5V7.707L8 2.207l-5.5 5.5z"/>
				  <path fill-rule="evenodd" d="M13 2.5V6l-2-2V2.5a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 .5.5z"/>
				</svg>
			</a>
			<a href="index.jsp?main=Mung/mungChat.jsp">
				<svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-cursor" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
				  <path fill-rule="evenodd" d="M14.082 2.182a.5.5 0 0 1 .103.557L8.528 15.467a.5.5 0 0 1-.917-.007L5.57 10.694.803 8.652a.5.5 0 0 1-.006-.916l12.728-5.657a.5.5 0 0 1 .556.103zM2.25 8.184l3.897 1.67a.5.5 0 0 1 .262.263l1.67 3.897L12.743 3.52 2.25 8.184z"/>
				</svg>
			</a>
			<svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-arrow-repeat" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
			  <path d="M11.534 7h3.932a.25.25 0 0 1 .192.41l-1.966 2.36a.25.25 0 0 1-.384 0l-1.966-2.36a.25.25 0 0 1 .192-.41zm-11 2h3.932a.25.25 0 0 0 .192-.41L2.692 6.23a.25.25 0 0 0-.384 0L.342 8.59A.25.25 0 0 0 .534 9z"/>
			  <path fill-rule="evenodd" d="M8 3c-1.552 0-2.94.707-3.857 1.818a.5.5 0 1 1-.771-.636A6.002 6.002 0 0 1 13.917 7H12.9A5.002 5.002 0 0 0 8 3zM3.1 9a5.002 5.002 0 0 0 8.757 2.182.5.5 0 1 1 .771.636A6.002 6.002 0 0 1 2.083 9H3.1z"/>
			</svg>
		</li>
<%
		}
%>
	</ul>
	
<!-- 게시글 목록 카드이미지 -->
	<div class="mung__post-list">
		<div class="row row-cols-1 row-cols-md-3">
<%
		//전체 게시글리스트에서 데이터 꺼내기
		
		//case1.게시글 1개 
		if(postList.size()==1) {
			
			for(MungPostDto dto:postList) {
				//계정별 게시글 전체 목록에서 필요한 데이터 변수
				int idx=dto.getPhoto().split(",").length-1;
				String photo=dto.getPhoto().split(",")[idx];
				int likes=dto.getLikes();
				int commSize=dao.getCommentSize(dto.getPost_num());
			
%>
			<div class="col mb-4  " data-toggle="modal" data-target="#exampleModal" data-num="<%=dto.getPost_num()%>"> 
			    <div class="card text-center mung__img-box">
			      <img src="mungSave/<%=photo %>" class="card-img mung__post-img">
			      <div class="card-img-overlay">
				    <p class="card-text mung__post-text">
						<svg class="mung__post__icon" width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-heart-fill" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
						  <path fill-rule="evenodd" d="M8 1.314C12.438-3.248 23.534 4.735 8 15-7.534 4.736 3.562-3.248 8 1.314z"/>
						</svg>
						<span><%=likes %></span>
				    	<svg class="mung__post__icon" width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-chat-right-fill" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
						  <path fill-rule="evenodd" d="M14 0a2 2 0 0 1 2 2v12.793a.5.5 0 0 1-.854.353l-2.853-2.853a1 1 0 0 0-.707-.293H2a2 2 0 0 1-2-2V2a2 2 0 0 1 2-2h12z"/>
						</svg>
				    	<span><%=commSize %></span>
					</p>
				  </div>
			    </div>
			</div>
<%
			}
%>			
			<div class="col md-1  "> 
			    <div class="card mung__img-box">
			      <img src="" class="card-img mung__post-img">
			      
			    </div>
			</div>
			<div class="col md-1  "> 
			    <div class="card mung__img-box">
			      <img src="" class="card-img mung__post-img">
			      
			    </div>
			</div>
<%		
		//case2.게시글 2개 
		}else if(postList.size()==2) {
			for(MungPostDto dto:postList) {
				//계정별 게시글 전체 목록에서 필요한 데이터 변수
				int idx=dto.getPhoto().split(",").length-1;
				String photo=dto.getPhoto().split(",")[idx];
				int likes=dto.getLikes();
				int commSize=dao.getCommentSize(dto.getPost_num());
			
%>
			<div class="col mb-4  " data-toggle="modal" data-target="#exampleModal" data-num="<%=dto.getPost_num()%>"> 
			    <div class="card text-center mung__img-box">
			      <img src="mungSave/<%=photo %>" class="card-img mung__post-img">
			      <div class="card-img-overlay">
				    <p class="card-text mung__post-text">
						<svg class="mung__post__icon" width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-heart-fill" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
						  <path fill-rule="evenodd" d="M8 1.314C12.438-3.248 23.534 4.735 8 15-7.534 4.736 3.562-3.248 8 1.314z"/>
						</svg>
						<span><%=likes %></span>
				    	<svg class="mung__post__icon" width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-chat-right-fill" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
						  <path fill-rule="evenodd" d="M14 0a2 2 0 0 1 2 2v12.793a.5.5 0 0 1-.854.353l-2.853-2.853a1 1 0 0 0-.707-.293H2a2 2 0 0 1-2-2V2a2 2 0 0 1 2-2h12z"/>
						</svg>
				    	<span><%=commSize %></span>
					</p>
				  </div>
			    </div>
			</div>
<%
			}
%>			
			<div class="col md-1  " > 
			    <div class="card mung__img-box" style="border-style: none;">
			      <img src="" class="card-img mung__post-img" style="border-style: none;">
			    </div>
			</div>
<%	
		//case2.게시글 3개 이상
		}else {
			for(MungPostDto dto:postList) {
				//계정별 게시글 전체 목록에서 필요한 데이터 변수
				int idx=dto.getPhoto().split(",").length-1;
				String photo=dto.getPhoto().split(",")[idx];
				int likes=dto.getLikes();
				int commSize=dao.getCommentSize(dto.getPost_num());
			
%>
			<div class="col mb-4  " data-toggle="modal" data-target="#exampleModal" data-num="<%=dto.getPost_num()%>"> 
			    <div class="card text-center mung__img-box">
			      <img src="mungSave/<%=photo %>" class="card-img mung__post-img">
			      <div class="card-img-overlay">
				    <p class="card-text mung__post-text">
						<svg class="mung__post__icon" width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-heart-fill" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
						  <path fill-rule="evenodd" d="M8 1.314C12.438-3.248 23.534 4.735 8 15-7.534 4.736 3.562-3.248 8 1.314z"/>
						</svg>
						<span><%=likes %></span>
				    	<svg class="mung__post__icon" width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-chat-right-fill" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
						  <path fill-rule="evenodd" d="M14 0a2 2 0 0 1 2 2v12.793a.5.5 0 0 1-.854.353l-2.853-2.853a1 1 0 0 0-.707-.293H2a2 2 0 0 1-2-2V2a2 2 0 0 1 2-2h12z"/>
						</svg>
				    	<span><%=commSize %></span>
					</p>
				  </div>
			    </div>
			</div>
<%			
			}
		}
%>				
		</div>	
	</div>
			
	<!-- 모달창 -->
	<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog modal-size modal-dialog-centered">
		<!-- close 버튼 -->	  
	    <button type="button" class="close" data-dismiss="modal" aria-label="Close" id="mung__modal__closeBtn">
	      <span aria-hidden="true">&times;</span>
	    </button>
	    <!-- 모달창 컨텐츠 -->
	    <div class="modal-content modal-size">
	      <div class="modal-body mung__post__modal">
	       <div class="row">
     		 <div class="col">
		      	<!-- 이미지영역 -->
	        		<%-- 캐러셀 --%>
					<div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
					  <!-- Indicators -->
					  <ol class="carousel-indicators" id="slideIdx">
					    <%-- 모달창 오픈시 스크립트에서 추가될 부분 --%>
					  </ol>
					  <!-- Wrapper for slides -->
					  <div class="carousel-inner" role="listbox" id="slideImg">
						<%-- 모달창 오픈시 스크립트에서 추가될 부분 --%>
					  </div>
					  <!-- Controls -->
					 <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
					    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
					    <span class="sr-only">Previous</span>
					  </a>
					  <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
					    <span class="carousel-control-next-icon" aria-hidden="true"></span>
					    <span class="sr-only">Next</span>
					  </a>
					</div>
	        	</div>
	        	<!-- 텍스트 영역 -->
		        <div class="mung__modal__text col-5">
		        	<!-- 게시글 작성한 계정 -->
		        	<ul class="mung__modal__acc">
		        		<!-- 프로필 -->
		        		<li class="mung__modal__moveAcc">
		        		 	<img id="mung__post__profile" class="mung__profile" src="">
							<b id="mung__post__id"></b>
		        		</li>
		        		<!-- 삭제버튼 -->
		        		<li>
		        			<svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-three-dots" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
							  <path fill-rule="evenodd" d="M3 9.5a1.5 1.5 0 1 1 0-3 1.5 1.5 0 0 1 0 3zm5 0a1.5 1.5 0 1 1 0-3 1.5 1.5 0 0 1 0 3zm5 0a1.5 1.5 0 1 1 0-3 1.5 1.5 0 0 1 0 3z"/>
							</svg>
		        		</li>
		        	</ul>
		        	<div class="mung__modal__textBox">
			        	<!-- 게시글 내용 -->
			        	<article id="mung__modal__content"><%-- 게시글 내용 출력 --%></article>
			        	<div id="mung__modal__tag"><%-- 게시글 태그 출력 --%></div>
			        	<!-- 게시글 댓글 목록 -->
			        	<ul id="mung__modal__comment">
			        		<%-- 댓글 리스트 출력 --%>
			        	</ul>
			        	<!-- 게시글 좋아요 -->
			        	<div class="mung__modal_likes">
			        		<span id="mung__likesIcon" class="empty">
				        		<svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-heart" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
								  <path fill-rule="evenodd" d="M8 2.748l-.717-.737C5.6.281 2.514.878 1.4 3.053c-.523 1.023-.641 2.5.314 4.385.92 1.815 2.834 3.989 6.286 6.357 3.452-2.368 5.365-4.542 6.286-6.357.955-1.886.838-3.362.314-4.385C13.486.878 10.4.28 8.717 2.01L8 2.748zM8 15C-7.333 4.868 3.279-3.04 7.824 1.143c.06.055.119.112.176.171a3.12 3.12 0 0 1 .176-.17C12.72-3.042 23.333 4.867 8 15z"/>
								</svg>
			        		</span>
			        		<b id="mung__modal__likes"><%-- 게시글 좋아요 개수 출력 --%></b>
			        	</div> 
			        </div>		
<%
					if(loginOk!=null && accId!="no") {
%>			        
		        	<!-- 게시글 댓글추가 -->
		        	<form id="mung__modal__addComm">
		        		<input type="hidden" id="mung__modal__commNum" value="<%=dog_num%>">
		        		<input type="text" id="mung__modal__inputComm">
		        		<button type="button" id="mung__modal__sbmitBtn">등록</button>
		        	</form>
<%
					}
%>	
		   		 </div>
		   	   </div> 
		   	 </div>
		   </div>
	  	</div>
	</div>
</div>
</body>
</html>