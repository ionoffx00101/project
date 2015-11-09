<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"  %>

<tiles:insertDefinition name="mainTemplate">
<tiles:putAttribute name="title">홈</tiles:putAttribute>
    <tiles:putAttribute name="body">
<script type="text/javascript">
$(jqueryOk);
function jqueryOk() {
	$('#btn').click(function(evt) {
		if(confirm('정말로 수정하시겠습니까?')) {
			
			var serializeData = $('#form').serialize();
			$.ajax({
				type:'post',
				url:'update',
				data:serializeData,
				dataType:'json',
				success:function(json) {
					if(json.ok) {
						alert('수정에 성공');
						location.href='info?num=' + ${info.num};
					} else {
						alert('수정에 실패');
					}
				}
			});
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
							<li>자유게시판</li>
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

                            <form id="form">  
                            <input type="hidden" name="num" value="${info.num}">
                            <div class="form-group">
                                    <label >글번호</label>
                                    <input type="text" class="form-control" name="numtitle" value="${info.num}" readonly="readonly">
                                </div>
                             <div class="form-group">
                                    <label >글쓴이</label>
                                    <input type="text" class="form-control" name="author" value="${info.author}" readonly="readonly">
                                </div>
                            
                                <div class="form-group">
                                    <label >글제목</label>
                                    <input type="text" class="form-control" name="title" value="${info.title}">
                                </div>
                                <div class="form-group">
                                    <label >내용</label>
                                    <textarea name="contents" class="form-control" rows="15">${info.contents}</textarea>
                                    <!-- <input type="text" class="form-control" id="email-login"> -->
                                </div>
                                <div class="text-center">
                                    <button type="button" class="btn btn-template-main"  id="btn"> 변경사항 적용</button>
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