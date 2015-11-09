<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
String ok = (String)session.getAttribute("loginOk");
if(ok==null){
	response.sendRedirect("login");
}
%>
<script type="text/javascript" src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script type="text/javascript">
$(start);
function start(){
	$("#btn1").click(function(){
		$.ajax({
			url:"editgo",
			type:"post",
			dataType:"json",
			data:$("#form1").serialize(),
			success:function(ok){
				if(ok.ok){
					alert("수정에 성공하였습니다.");
					location.href="list";
				}
				else if(!ok.ok){
					alert("수정에 실패하였습니다.");
					
				}
			},
			error:function(err){
				alert("에러입니다."+err);
			}
		});
		
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
                                <h2 >글수정</h2>
                            </div>
                            <hr>

                            <form id="form1">  
                            <input type="hidden" name="num" value="${list.num }">
                            <div class="form-group">
                                    <label >제목</label>

                                    <input type="text" class="form-control" name="title" value="${list.title}" >
                                </div>
                             <div class="form-group">
                                    <label >작성자</label>
                                    <input type="text" class="form-control" name="author" value="${list.author }" readonly="readonly">
                                </div>
                            
                                <div class="form-group">
                                    <label >내용</label>
                                    <textarea name="contents" class="form-control" rows="30" cols="70" >${info.contents}</textarea>
                                    <!-- <input type="text" class="form-control" id="email-login"> -->
                                </div>
                                <div class="text-center">
                                    <button type="button" class="btn btn-template-main"  id="btn1"> 수　정　완　료</button>
                                    <button type="reset" class="btn btn-template-main">취　소</button>
                                    <a href="list"><button type="button"  class="btn btn-template-main">목록</button></a>
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