<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script type="text/javascript" src="<c:url value="/resources/jquery-2.1.4.min.js"/>"></script>
<script type="text/javascript">

$(start);
function start(){
	$("#btn1").click(function(){
		location.href="edit?editsc="+$("#editsc").val();
	});
	
	$("#btn2").click(function(){
		if(confirm("정말로 삭제하시겠습니까?")){
			 $.ajax({
 				url:"delete",
 				type:"post",
 				dataType:"json",
 				data:{"num":$("#editsc").val()},
 				success:function(ok){
 					if(ok.ok){
 						alert("삭제에 성공하였습니다.");
 						location.href="list";
 					}
 					else if(!ok.ok){
 						alert("삭제에 실패하였습니다.");
 					}
 				},
 				error:function(err){
 					alert("에러입니다."+err);
 				}
 			}); 
	   }
	});
		
	$("#btn3").click(function(){
		location.href="list";
	});
}
</script>
<tiles:insertDefinition name="mainTemplate">
    <tiles:putAttribute name="title">홈</tiles:putAttribute>
<tiles:putAttribute name="body">
    <!-- 서브페이지 배너 -->
 <div id="heading-breadcrumbs">
            <div class="container">
                <div class="row">
                    <div class="col-md-7">
                        <h1>공　지　게　시　판</h1>
                    </div>
                    <div class="col-md-5">
                        <ul class="breadcrumb">
                            <li><a href="home">Home</a>
                            </li>
                            <li>Questions and answers</li>
                        </ul>

                    </div>
                </div>
            </div>
        </div>
<!-- 서브페이지 배너 끝 -->
<h2>게시글　내용</h2>
<c:forEach var="list" items="${list }">
<input type="hidden" id="editsc" value="${list.num }">
<table>
<tr>
<td>제　목</td>
<td>${list.title }</td>
</tr>
<tr>
<td>작　성　일</td>
<td>${list.wdate }</td>
</tr>
<tr>
<td>작　성　자</td>
<td>${list.author }</td>
</tr>
<tr>
<td>내　　용</td>
<td>${list.contents }</td>
</tr>
<c:choose>
   <c:when test="${loginOk =='KING' }">
<tr>
<td><button type="button" id="btn3">목　록</button></td>
<td><button type="button" id="btn1">수　정　하　기</button></td>
<td><button type="button" id="btn2">삭　제</button></td>
</tr>
</c:when>
</c:choose>
</table>
</c:forEach>
</tiles:putAttribute>
</tiles:insertDefinition>