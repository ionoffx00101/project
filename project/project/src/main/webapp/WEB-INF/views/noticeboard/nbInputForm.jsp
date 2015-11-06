<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String ok = (String)session.getAttribute("loginOk");
if(ok==null){
	response.sendRedirect("login");
}
%>
<script type="text/javascript" src="<c:url value="/resources/jquery-2.1.4.min.js"/>"></script>
<script type="text/javascript">
$(start);
function start(){
	$("#btn").click(function(){
		$.ajax({
			url : "writeRegi",
			type : "post",
			dataType : "json",
			data : $("#form1").serialize(),
			success : function(ok) {
				location.href="info?infosc="+ok.infosource;
				//location="list";
			},
			error : function(err) {
				alert("에러"+err);
			}
		});
		
	});
	
};
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
<h2>게시글 작성</h2>
<form id="form1">
<table>
<tr>
<td>제　목:　</td>
<td><input type="text" name="title"></td>
</tr>
<tr>
<td>작　성　자:　</td>
<td><input type="text" name="author" value="${loginOk }"></td>
</tr>
<tr>
<td>내　용:　</td>
<td><textarea name="contents"></textarea></td>
</tr>
<tr>
<td> </td>
<td><button type="button" id="btn">등　록</button></td>
</tr>
</table>
</form>
</tiles:putAttribute>
</tiles:insertDefinition>
