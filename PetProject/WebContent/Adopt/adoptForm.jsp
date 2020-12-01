<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>분양 게시판</title>
<style type="text/css">
   
</style>
<script type="text/javascript">

</script>
</head>
<body>
   <div class="">
   <form action="Adopt/addaction.jsp" method="post"
      enctype="multipart/form-data" class="form-inline">
      <table class="" style="width: 600px;">
         <caption><b>강아지 등록</b></caption>
         <tr>
            <td>
               <span>이름</span>
               <input type="text" name="id" style="width: 75px;" required="required">
            </td>
         </tr>
         <tr>
            <td>
               <span>견종</span>
               <input type="text" name="breed" style="width: 75px;" required="required">
            </td>
         </tr>
         <tr>
            <td>
               <span>나이</span>
               <input type="text" name="age" style="width: 25px;" required="required">
            </td>
         </tr>
         <tr>
            <td>
               <span>성별</span>
               <select style="width:200px;" name="gender"
                  class="form-control" required="required">
                  <option value="수컷">수컷</option>
                  <option value="암컷">암컷</option>
                  <option value="수컷(중성화)">수컷(중성화)</option>
                  <option value="암컷(중성화)">암컷(중성화)</option>
      
               
               </select>
   
            </td>
         </tr>
            <tr>
            <td>
               <span>예방접종</span>
               <input type="checkbox" name="vaccine" class="form-control">
            </td>
         </tr>
         <tr>
            <td>
               <input type="text" name="title" class="form-control"
               style="width: 400px;"required="required">
            </td>
         </tr>   
         <tr>
            <td>
               <div class="form-group">
                  <span>사진등록</span>
                  <input type="file" name="photo" 
                  style="width: 200px;" class="form-control"
                  required="required">
                  
                  <span class="glyphicon glyphicon-plus-sign files"
                  style="margin-left: 20px;font-size: 1.3em;cursor: pointer;"></span>
               </div>
               <div class="addfile"></div>
            </td>
         </tr>
         <tr>
            <td>
               <textarea name="content" required="required"
               style="width: 400px; height: 150px;"></textarea>
            </td>
         </tr>   
         <tr>
            <td colspan="2" align="center">
               <button type="submit" class="btn btn-info"
               style="width: 100px;">등록</button>
            </td>
         </tr>   
      </table>
      
   </form>
</div>
</body>
</html>