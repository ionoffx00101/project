<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%--defaultTemplate를 적용할 때 템플릿의 title, body 영역은 여기에서 오버라이드한다 --%>
<script type="text/javascript" src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script type="text/javascript">
	$(function() {
		var cate;
		$('button[name=btn_search]').on('click', function(evt) {

			var word = $('input[name=searchword]').val();
			cate = $('select[name=category]').val();
			if (word != null) {
				location.href = 'search?word=' + word + '&cate=' + cate + '&pnum=1';
			}
		});
		$('input[name=searchword]').on('keydown', function(evt) {

			var word = $('input[name=searchword]').val();
			cate = $('select[name=category]').val();

			if (evt.keyCode == 13) {
				if (word != null) {
					location.href = 'search?word=' + word + '&cate=' + cate + '&pnum=1';
				}
			}

		});
	});
</script>
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
.category{
width: 80px;
    height: 30px;}
</style>

<tiles:insertDefinition name="subTemplate">
	<tiles:putAttribute name="title">Q&A</tiles:putAttribute>
	<tiles:putAttribute name="body">

		<!-- 서브페이지 배너 -->
		<div id="heading-breadcrumbs">
			<div class="container">
				<div class="row">
					<div class="col-md-7">
						<h1>Q & A</h1>
					</div>
					<div class="col-md-5">
						<ul class="breadcrumb">
							<li><a href="home">Home</a></li>
							<li>Questions and answers</li>
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
							<a href="qnapost"><button type="button" class="btn_postlnk">글쓰기</button></a> <br> <br>
							<div class="table-responsive">
								<table class="table">
									<thead>
										<tr>
											<th class="cole">글번호</th>
											<th class="cols">제목</th>
											<th class="cole">작성자</th>
											<th class="cole">작성일</th>
											<th class="cole">조회수</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach var="b" items="${list}">
											<tr>
												<td>${b.num}</td>
												<td class="colss"><a href="qnaread?num=${b.num}"> ${b.title} </a></td>
												<td>${b.author}</td>
												<td>${b.wdate}</td>
												<td>${b.hitcnt}</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>
							<!-- /.table-responsive -->


							<div class="box-footer">
								<div class="panel-body">

									<!-- <div class="searchform"> -->

									<!-- </div> -->
									<!-- /input-group -->
									<div class="row">
										<div class="col-md-3"></div>
										<div class="col-md-1">

											<select class="category" name="category">
											
												<option>글제목</option>
												<option>글쓴이</option>
											</select>
										</div>
										<div class="col-md-5">
										<div class="input-group">
											<input type="text" class="form-control" placeholder="Search" name="searchword">
										
										
											<span class="input-group-btn">

												<button class="btn btn-template-main btn_search" type="button" name="btn_search">
													<i class="fa fa-search"></i>
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
											<c:when test="${search}">
												<c:choose>
													<c:when test="${navi.leftMore}">
														<li><a href="search?word=${word}&cate=${cate}&pnum=1"> « </a> </li>
														<%-- ${navi.links.length-1}${navi.links().length-1}--%>
													</c:when>
												</c:choose>
											</c:when>


											<c:otherwise>
												<c:choose>
													<c:when test="${navi.leftMore}">
													<li>	<a href="qna?pnum=1"> « </a> </li>
													</c:when>
												</c:choose>
											</c:otherwise>

										</c:choose>


										<!--  -->

										<c:choose>
											<c:when test="${search}">
												<c:forEach var="board" items="${navi.links}">

													<c:choose>
														<c:when test="${navi.currPage==board}">
          <li><a href="search?word=${word}&cate=${cate}&pnum=${board}">${board}</a></li>
       </c:when>
														<c:when test="${navi.currPage!=board}">
        <li><a href="search?word=${word}&cate=${cate}&pnum=${board}">${board}</a></li>
       </c:when>
													</c:choose>

												</c:forEach>
											</c:when>

											<c:otherwise>
												<c:forEach var="board" items="${navi.links}">

													<c:choose>
														<c:when test="${navi.currPage==board}">
          <li><a href="qna?pnum=${board}">${board}</a></li>
       </c:when>
														<c:when test="${navi.currPage!=board}">
        <li><a href="qna?pnum=${board}">${board}</a></li>
       </c:when>
													</c:choose>

												</c:forEach>
											</c:otherwise>

										</c:choose>
										
										<!--  -->


										<c:choose>
											<c:when test="${search}">

												<c:choose>
													<c:when test="${navi.rightMore}">
														<li><a href="search?word=${word}&cate=${cate}&pnum=${navi.linknum}">»</a></li>
														<%-- ${navi.links.length-1}${navi.links().length-1}--%>
													</c:when>
												</c:choose>

											</c:when>

											<c:otherwise>
												<c:choose>
													<c:when test="${navi.rightMore}">
														<li><a href="qna?pnum=${navi.linknum}">»</a></li>
														<%-- ${navi.links.length-1}${navi.links().length-1}--%>
													</c:when>
												</c:choose>
											</c:otherwise>
										</c:choose>
										</ul>
									</div>
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