<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<tiles:insertDefinition name="mainTemplate">
	<tiles:putAttribute name="title">홈</tiles:putAttribute>
	<tiles:putAttribute name="body">
		<!-- 서브페이지 배너 -->
		<div id="heading-breadcrumbs">
			<div class="container">
				<div class="row">
					<div class="col-md-7">
						<h1>자유게시판</h1>
					</div>
					<div class="col-md-5">
						<ul class="breadcrumb">
							<li><a href="../temp/home">Home</a></li>
							<li>자유게시판</li>
						</ul>

					</div>
				</div>
			</div>
		</div>
		<!-- 서브페이지 배너 끝 -->
		<%-- 파일을 보낼려면 method="post" enctype="multipart/form-data" 반드시 필요/ 서블렛에서 form데이터 처리 부분 좀 다름--%>

		<div id="content">
			<div class="container">

				<div class="row">
					<div class="col-md-12">
						<div class="box">

							<div class="heading">
								<h2>글작성</h2>
							</div>
							<hr>
							<form id="uploadForm" action="input" method="post">
								<input type="hidden" name="ref" value="${vo.ref}"> <input type="hidden" name="author" value="${sessionScope.id}">
								

								  <div class="form-group">
                                    <label >글제목</label>
                                   <input type="text" name="title"  class="form-control"  value="업로드 테스트">
                                </div>
                                <div class="form-group">
                                    <label >작성자</label>
                                   ${sessionScope.id}
                                </div>
                                <div class="form-group">
                                    <label >내용</label>
                                    <textArea name="contents" cols="50" rows="3"  class="form-control">업로드 테스트 입니다.</textArea>
                                </div>
                                <div class="text-center">
                                <button type="submit" id="btn"  class="btn btn-template-main">글저장</button>
									
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