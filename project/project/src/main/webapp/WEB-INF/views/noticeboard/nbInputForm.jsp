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
<script type="text/javascript" src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<%-- <script type="text/javascript" src="<c:url value="../resources/js/jquery-2.1.4.min.js"/>"></script> --%>
<script type="text/javascript">
$(start);
function start(){
	$("#btn").click(function(){
		alert( $("#form1").serialize());
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
						<h1>공지게시판</h1>
					</div>
					<div class="col-md-5">
						<ul class="breadcrumb">
							<li><a href="../temp/home">Home</a></li>
							<li>공지게시판</li>
						</ul>

					</div>
				</div>
			</div>
		</div>
		<!-- 서브페이지 배너 끝 -->
<div id="content">
			<div class="container">

				<div class="row">
					<div class="col-md-12">
						<div class="box">

							<div class="heading">
								<h2>게시글 작성</h2>
							</div>
							<hr>
							<form id="form1">
								
								  <div class="form-group">
                                    <label >제목</label>
                                   <input type="text" name="title" class="form-control">
                                </div>
                                <div class="form-group">
                                    <label >작성자</label>
                                  <input type="text" name="author" value="${loginOk }" class="form-control">
                                </div>
                                <div class="form-group">
                                    <label >내용</label>
                                    <textArea name="contents" cols="50" rows="3"  class="form-control"></textArea>
                                </div>
                                <div class="text-center">
                                <button type="button" id="btn"  class="btn btn-template-main">등　록</button>
									
                                </div>
								
							</form>

						</div>
					</div>

				</div>
				<!-- /.row -->

			</div>
			<!-- /.container -->
		</div>
		<!-- /#content -->

</tiles:putAttribute>
</tiles:insertDefinition>
