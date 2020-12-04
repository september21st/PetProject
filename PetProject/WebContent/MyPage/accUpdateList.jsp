<%@page import="data.dto.AccountDto"%>
<%@page import="java.util.List"%>
<%@page import="data.dao.AccountDao"%>
<%@page import="data.dao.UserDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
$(function(){
	$(document).on("click","a.acc_dogdetail", function() {	
		var dog_num=$(this).attr("dog_num");
		location.href="index.jsp?main=MyPage/accUpdate.jsp?dog_num="+dog_num;
	});
	
	$(document).on("click",".acc__sel-acc", function() {	
		var user_num=$(this).attr("user_num");
		
		$.ajax({
			dataType:"html",
			data:{
				"user_num":user_num,	
			},
			type:"post",
			url:"MyPage/accDefaultAll.jsp",
			success:function(){
				alert("컨펌버튼을 최종적으로 클릭해야 수정됩니다!")
				
			}
		});
		
	});
	$(document).on("click",".acc__sel-cnf", function() {	
		var dog_num=$(this).attr("dog_num2");
		
		$.ajax({
			dataType:"html",
			data:{
				"dog_num":dog_num,	
			},
			type:"post",
			url:"MyPage/accDefault.jsp",
			success:function(){
				 alert("수정완료 :)")
				 location.reload();
			}
		});
	
});
});

</script>
<%

	String id=(String)session.getAttribute("myId");
	
	UserDao udao=new UserDao();
	String user_num=udao.getNum(id);
	
	
	AccountDao adao=new AccountDao();
	List<AccountDto> alist=adao.getAllAccounts(user_num);
	
	
%>

</head>
<body>


<div id="acc_update-list">
	<h4><b>강아지 계정리스트</b></h4>
	<table class="table table-bordered" style="width:900px;">
	<tr bgcolor="#66cdaa">
		<td style="width:60px;" align="center">이름</td>
		<td style="width:100px;" align="center">사진</td>
		<td style="width:120px;" align="center">견종</td>
		<td style="width:120px;" align="center">성별</td>
		<td style="width:120px;" align="center">메인설정(각각 클릭)</td>
		<td style="width:100px;" align="center">계정삭제</td>
	</tr>
	
	<%
	for(AccountDto dto:alist)
		{%>
		<input type="hidden" name="dog_num" id="dog_num" value="<%=dto.getDog_num()%>">
		<tr bgcolor="white">
		<td> <a dog_num="<%=dto.getDog_num()%>" style="width:60px;cursor:pointer;"  align="center" name="accName" class="acc_dogdetail"><%=dto.getAcc_name()%></a></td>
		<td style="width:100px;" align="center" name="accPhoto"><img src="AccSave/<%=dto.getPhoto()%>" style="max-width:80px;" hspace="5" align="center"></td>
		<td style="width:120px;" align="center" name="accBreed"><%=dto.getBreed()%></td>
		<td style="width:120px;" align="center" name="accGender"><%=dto.getGender()%></td>
		<input type="hidden" id="sel_acc" name="sel_acc" value="<%=dto.getSel_acc()%>">
		<%if(dto.getSel_acc()==0){ %>
		<td style="width:120px;" align="center">
			<button user_num="<%=dto.getUser_num()%>" type="button" class="acc__sel-acc btn btn-danger btn-sm" >설정</button>
			<button dog_num2="<%=dto.getDog_num()%>" type="button" class="acc__sel-cnf btn btn-danger btn-sm" >컨펌</button>
		</td>
		<%}else{%>
			<td style="width:120px;" align="center" id="acc_default">
			메인계정
		</td>
		<%} %>
		<td>
		<button type="button" class="acc__acc-del btn btn-info"
		style="width:100px;"  align="center" onclick="location.href='MyPage/accDelete.jsp?dog_num=<%=dto.getDog_num()%>'">삭제하기</button>
		</td>
		</tr>
	<%
	}
	%>
	</table>
	
</div>


</body>
</html>