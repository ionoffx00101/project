<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style type="text/css">
a:link {
	text-decoration: none;
	color: black;
}

a:visited {
	text-decoration: none;
	color: black;
}

a:active {
	text-decoration: none;
	color: black;
}

a:hover {
	text-decoration: none;
	color: blue;
	font-weight: bold;
}

table {
	display: inline-block;
	border-collapse: collapse;
	text-align: center;
	line-height: 1.5;
}

.cole {
	text-align: center;
}

.cols {
	text-align: left;
	width: 450px;
}

.colss {
	text-align: left;
	width: 450px;
}

.btn_postlnk {
	float: right;
}

.searchform {
	text-align: center;
}

.pagenavi {
	text-align: center;
	vertical-align: middle;
}

.box .box-footer:after {
	text-align: center;
	clear: both;
}

.form-control {
	width: 100px;
	size: 10;
}

.category {
	width: 80px;
	height: 30px;
}
</style>
<tiles:insertDefinition name="mainTemplate">
	<tiles:putAttribute name="title">홈</tiles:putAttribute>
	<tiles:putAttribute name="body">
	<script type="text/javascript">
	$(jqueryOk);
	function jqueryOk() {
		$('#btn').click(function() {
			location.href = 'search?searchChoice=' + $('#combo').val() + '&key=' + $('#key').val();
		});
		$('#key').keydown(function(evt) {
			if (evt.keyCode == 13) {
				location.href = 'search?searchChoice=' + $('#combo').val() + '&key=' + $('#key').val();
			}
		});
	}
</script>
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
							<li>검색리스트</li>
						</ul>

					</div>
				</div>
			</div>
		</div>
		<!-- 서브페이지 배너 끝 -->



		<div id="content">
			<div class="container">
				<div class="row">
					<div class="col-md-12 clearfix">
						<div class="box">
							<div class="heading">
								<h2>자유게시판</h2>
							</div>
							<a href="inputForm"><button type="button" class="btn_postlnk">글쓰기</button></a> <br> <br>
							<div class="table-responsive">
								<table class="table">
									<thead>
										<tr>
											<th class="cole">글번호</th>
											<th class="cols">제목</th>
											<th class="cole">작성자</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach var="s" items="${list}">
											<tr>
												<td>${s.num}</td>
												<td><a href="info?num=${s.num}">${s.title}</td>
												<td>${s.author}</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
								<a href="list">목록으로</a>
							</div>
							<!-- /.table-responsive -->
							<div class="box-footer">
								<div class="panel-body">
									<form method="post" action="search">
										<div class="row">
											<div class="col-md-3"></div>
											<div class="col-md-1">
												<select name="searchChoice" id="combo">
													<option value="제목으로 검색" selected>제목</option>
													<option value="작가로 검색">작가</option>
												</select>
											</div>
											<div class="col-md-5">
												<div class="input-group">
													<input type="text" id="key" name="key" class="form-control" placeholder="Search"> <span class="input-group-btn">

														<button class="btn btn-template-main btn_search" type="button" id="btn">
															<i class="fa fa-search"></i>검색
														</button>

													</span>
												</div>
											</div>
											<div class="col-md-3"></div>
										</div>
										<Br> <Br>
										<div class="pagenavi">

											<ul class="pagination pagination-lg">

												<c:choose>
													<c:when test="${nvo.leftMore}">
														<li><a href="searchNavi?page=${nvo.links[0]-1}"> « </a></li>
													</c:when>
												</c:choose>

												<!--  -->

												<c:forEach var="s" items="${nvo.links}">
													<c:choose>
														<c:when test="${nvo.currPage == s}">
															<li class="active"><a href="searchNavi?page=${s}">${s}</a></li>
														</c:when>
														<c:otherwise>
															<li><a href="searchNavi?page=${s}">${s}</a></li>
														</c:otherwise>
													</c:choose>
												</c:forEach>
												<!--  -->
												<c:choose>

													<c:when test="${nvo.rightMore}">
														<li><a href="searchNavi?page=${nvo.links[1]+1}">»</a></li>
													</c:when>
												</c:choose>
											</ul>
										</div>
									</form>
								</div>
							</div>
							<!-- /.box -->
						</div>
						<!-- /.col-md-9 -->
					</div>
					<!-- /.row -->
				</div>
				<!-- /.container -->
			</div>
		</div>
		<!-- /#content -->
	</tiles:putAttribute>
</tiles:insertDefinition>