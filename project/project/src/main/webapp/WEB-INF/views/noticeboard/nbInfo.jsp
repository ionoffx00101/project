<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script type="text/javascript" src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script type="text/javascript">
	$(start);
	function start() {
		$("#btn1").click(function() {
			location.href = "edit?editsc=" + $("#editsc").val();
		});

		$("#btn2").click(function() {
			if (confirm("정말로 삭제하시겠습니까?")) {
				$.ajax({
					url : "delete",
					type : "post",
					dataType : "json",
					data : {
						"num" : $("#editsc").val()
					},
					success : function(ok) {
						if (ok.ok) {
							alert("삭제에 성공하였습니다.");
							location.href = "list";
						} else if (!ok.ok) {
							alert("삭제에 실패하였습니다.");
						}
					},
					error : function(err) {
						alert("에러입니다." + err);
					}
				});
			}
		});

		$("#btn3").click(function() {
			location.href = "list";
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
			<div class="container" id="contact">
				<div class="box">
					<section>

						<div class="row">
							<div class="col-md-12">
								<section>
									<div class="heading">
										<h2>상세페이지</h2>
									</div>
									<c:forEach var="list" items="${list }">
										<input type="hidden" id="editsc" value="${list.num }">



										<p class="lead">${list.title }</p>
										<div class="col-md-9"></div>
										<div class="col-md-1">${list.author }</div>
										<div class="col-md-2">${list.wdate }</div>

										<pre>${list.contents }</pre>
										<c:choose>
											<c:when test="${loginOk =='KING' }">

												<div class="text-center">

													<button type="button" id="btn3" class="btn btn-template-main">목 록</button>
													<button type="button" id="btn1" class="btn btn-template-main">수 정 하 기</button>
													<button type="button" id="btn2" class="btn btn-template-main">삭 제</button>

												</div>

											</c:when>
										</c:choose>
									</c:forEach>
								</section>
							</div>
						</div>

						<!-- 댓글 끝 -->
						<!-- 버튼그룹 -->

						<!-- 버튼그룹 끝 -->

					</section>
				</div>
			</div>
			<!-- /#contact.container -->
		</div>
		<!-- /#content -->

	</tiles:putAttribute>
</tiles:insertDefinition>