<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript" src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script type="text/javascript">
	$(jqueryOk);
	function jqueryOk() {
		$('#dBtn').click(function(evt) {
			if (confirm('정말로 삭제하시겠습니까?')) {
				$.ajax({
					type : 'post',
					url : 'delete',
					data : $('#form1').serialize(),
					dataType : 'json',
					success : function(json) {
						if (json.ok) {
							alert('삭제에 성공');
							location.href = 'list';
						} else {
							alert('삭제에 실패');
						}
					}
				});
			}
		});
		$('#reBtn').click(function() {
			evt.preventDefault();
			alert($('#form2').serialize() + "form2");
			$.ajax({
				type : 'post',
				url : 'replyInput',
				dataType : 'json',
				data : $('#form2').serialize(),
				success : function(json) {
					console.log(json);
					if (json.ok) {
						location.href = "info?num=" + json.bNum;
					} else {
						alert("false");
					}
				},
				error : function(json) {
					alert("오류발생");
				}
			});
		});
		$("#table a.reDelete").each(function(i) {
			evt.preventDefault();
			$(this).click(function() {
				$.ajax({
					type : 'post',
					url : 'replyDelete',
					dataType : 'json',
					data : {
						reNum : $('#num' + i).val(),
						checkAuthor : $('#checkAuthor' + i).val(),
						bNum : $('#bNum').val()
					},
					success : function(json) {
						console.log(json);
						if (json.ok) {
							console.log(json.bNum);
							alert('삭제성공');
							location.href = "info?num=" + json.bNum;
						} else {
							alert("작성자만 삭제 가능합니다.");
						}
					},
					error : function(json) {
						alert("오류발생");
					}
				});
			});
		});
		$("#table a.reReInput").each(function(i) {
			$(this).click(function() {
				evt.preventDefault();
				$('#tr' + i).append('<div>댓글 추가될곳</div>');
				$('.reBtn').each(function(i) {
					alert($('#form3').serialize() + "form3");
					$(this).click(function(i) {

						$.ajax({
							type : 'post',
							url : 'replyInput',
							dataType : 'json',
							data : $('#form3').serialize(),
							success : function(json) {
								console.log(json);
								if (json.ok) {
									alert(json.bNum);
									location.href = "info?num=" + json.bNum;
								} else {
									alert("false");
								}
							},
							error : function(json) {
								alert("오류발생");
							}
						});
					});
				});
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
									<p class="lead">${info.title }</p>
									<div class="col-md-8"></div>
									<div class="col-md-1">${info.num }</div>
									<div class="col-md-1">${info.author }</div>
									<div class="col-md-2">${info.wdate }</div>

									<pre>${info.contents }</pre>

								</section>
							</div>
						</div>


						<!-- 댓글  -->
						<div id="comments">
							<div class="row comment">
								<div class="col-sm-9 col-md-12">
									<form id="form3">
										<input type="text" name="reAuthor" value="${sessionScope.id}"><!--hidden="hidden"  --><!-- 현재 접속중인 아이디 -->
										<input type="text" name="bNum" id="bNum" value="${info.num}"><!--hidden="hidden"  -->
										<div id="table">
											<c:forEach var="reList" items="${reList}" varStatus="status">
												<input type="text" name="reNum" id="num${status.index}" value="${reList.reNum}">
												<!--hidden="hidden"  -->
												<input type="text" name="checkAuthor" id="checkAuthor${status.index}" value="${reList.reAuthor}">
												<!--hidden="hidden"  -->
												<div id="tr${status.index}">
													<div>
														<h5 class="text-uppercase">${reList.reAuthor}</h5>
														<p class="posted">
															<i class="fa fa-clock-o"></i> ${reList.reDate}
														</p>
														<p>${reList.reContents}</p>
														<p class="reply">
															<a class="reReInput"><i class="fa fa-reply"></i> Reply</a>
															<a href="#" class="reDelete"><i class="fa fa-times"></i> Delete</a>
														</p>
													</div>

												</div>

											</c:forEach>
										</div>
									</form>

								</div>

							</div>
							<!--  -->
							<div id="comment-form">

								<h4 class="text-uppercase">Leave comment</h4>

								<form id="form2">
									<input type="text" name="reAuthor" value="${sessionScope.id}">
									<!--hidden="hidden"  -->
									<input type="text" name="bNum" value="${info.num}">
									<!--hidden="hidden"  -->
									<!-- 현재 들어와있는 상세게시글 번호 -->
									<div class="row">

										<div class="col-sm-3">
											<div class="form-group">
												<label for="name">작성자 <span class="required">*</span>
												</label> <input type="text" class="form-control" id="name" value="${sessionScope.id}" readonly="readonly">
											</div>
										</div>
									</div>

									<div class="row">
										<div class="col-sm-6">
											<div class="form-group">
												<label for="comment">내용 <span class="required">*</span>
												</label>
												<textarea class="form-control" name="reContents" cols="53" rows="2"></textarea>
											</div>
										</div>
									</div>

									<div class="row">
										<div class="col-sm-6 text-right">
											<button class="btn btn-template-main" id="reBtn">
												<i class="fa fa-comment-o"></i> 댓글쓰기
											</button>
										</div>
									</div>


								</form>

							</div>
							<!-- /#comment-form -->

						</div>
						<!-- 댓글 끝 -->
						<!-- 버튼그룹 -->
						<div class="text-center">
							<form id="form1">
								<a href="editForm?num=${info.num}"><button type="button" class="btn btn-template-main">수정하로 가기</button></a> <a href="inputForm?ref=${info.num}"><button type="button" class="btn btn-template-main">답글 쓰기</button></a> <a href="list"><button type="button" class="btn btn-template-main">목록으로</button></a> <input type="hidden" name="num" value="${info.num}"> <input type="hidden" name="checkAuthor" value="${info.author}">
								<button type="button" id="dBtn" class="btn btn-template-main">삭제</button>
							</form>
						</div>
						<!-- 버튼그룹 끝 -->

					</section>
				</div>
			</div>
			<!-- /#contact.container -->
		</div>
		<!-- /#content -->

	</tiles:putAttribute>
</tiles:insertDefinition>